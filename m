Return-Path: <linux-tip-commits+bounces-6918-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F8BE294B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B179354C4F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3133A038;
	Thu, 16 Oct 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFr8z4WR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9VoQHthj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12D33438A;
	Thu, 16 Oct 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608410; cv=none; b=saH945rLy+trUZymBIY3AofCk6lvA9UZMIj/VTCLxWLAYDZZfys4IEnxYA7l1m4QAv6ifXXgjHYUVIcTQ9/Sesn8WYQLkyxINMiP155p8VAGOzod0v7ZnERoInmtovYa/1vJN7rCL/gg90/e2/HjuzyL7b8mVo4SEjwRw2yZj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608410; c=relaxed/simple;
	bh=Wt4fzwihP1r41E1dGMDTOwj1TFHbDvm8XIMnG/CxZ04=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XFTV29LRjRXK3CJeIN+gI8QJCDPTRGRmcmo5bXeK5dRzIlX49JtFEYPfDkTded4MkljREeq140uZ+9IHtqQdnDetNCmLC3S8eXCKjU6iyHCNSHpWC2TD8OAucohMO2llXDyOgQCAlvoyhu20pa8qsZut5Tvb9N6SL8G0fJx18zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFr8z4WR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9VoQHthj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EajhsptOzgCHTzkhOI35hOhTA8StuyYWJzous2yI6oE=;
	b=qFr8z4WRMB2/WQhDTmtP/CNcW0G/rJEmc1yT07kSiQUzEMRy/UVsWN5ehRz7OMIpmz9zUG
	X9YAHkz9ZjtGLp4AQcaVuv4SJMGQ9RXZXgmf4AnF3lqYzNCUoxbmvwMX2+XI6vqdrjGcN/
	bgwhSzPXsak2mMNpM2Z78KEkwOsMeRC22S+yo6D6IiJ9eKNkEahYvhThtkQ9QB2/PF0WHz
	e8h0BVhnarOGt0bCgRGZulAS63Q5Yh/F19R8H6X6ELhOU5QrMeUsSYoKnfusdMUHTMqcAb
	j3m5eJVXWA/+5UZOsvIH5lK+O9lvujv1ESM+DspFe/IfmygqavA7YUIjTeH6aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EajhsptOzgCHTzkhOI35hOhTA8StuyYWJzous2yI6oE=;
	b=9VoQHthj3gx6xYrcJfB1c0rKMli1edsYBf1nYqPIfq4/tv2MblZYYFxlU5EPM1qgk4dsba
	EmqbEU9t+lr/kUAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] interval_tree: Fix ITSTATIC usage for *_subtree_search()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838580.709179.7193581504355810173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b37491d72b43c3a322d396c2d8e951a10be70c17
Gitweb:        https://git.kernel.org/tip/b37491d72b43c3a322d396c2d8e951a10be=
70c17
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 18 Sep 2025 09:30:03 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:22 -07:00

interval_tree: Fix ITSTATIC usage for *_subtree_search()

For consistency with the other function templates, change
_subtree_search_*() to use the user-supplied ITSTATIC rather than the
hard-coded 'static'.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h | 4 ++++
 include/linux/interval_tree.h                          | 4 ++++
 include/linux/interval_tree_generic.h                  | 2 +-
 include/linux/mm.h                                     | 2 ++
 lib/interval_tree.c                                    | 1 +
 tools/include/linux/interval_tree_generic.h            | 2 +-
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h b/drivers=
/infiniband/hw/usnic/usnic_uiom_interval_tree.h
index 1d7fc32..cfb42a8 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.h
@@ -53,6 +53,10 @@ extern void
 usnic_uiom_interval_tree_remove(struct usnic_uiom_interval_node *node,
 					struct rb_root_cached *root);
 extern struct usnic_uiom_interval_node *
+usnic_uiom_interval_tree_subtree_search(struct usnic_uiom_interval_node *nod=
e,
+					unsigned long start,
+					unsigned long last);
+extern struct usnic_uiom_interval_node *
 usnic_uiom_interval_tree_iter_first(struct rb_root_cached *root,
 					unsigned long start,
 					unsigned long last);
diff --git a/include/linux/interval_tree.h b/include/linux/interval_tree.h
index 2b8026a..9d5791e 100644
--- a/include/linux/interval_tree.h
+++ b/include/linux/interval_tree.h
@@ -20,6 +20,10 @@ interval_tree_remove(struct interval_tree_node *node,
 		     struct rb_root_cached *root);
=20
 extern struct interval_tree_node *
+interval_tree_subtree_search(struct interval_tree_node *node,
+			     unsigned long start, unsigned long last);
+
+extern struct interval_tree_node *
 interval_tree_iter_first(struct rb_root_cached *root,
 			 unsigned long start, unsigned long last);
=20
diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_t=
ree_generic.h
index 1b400f2..c5a2fed 100644
--- a/include/linux/interval_tree_generic.h
+++ b/include/linux/interval_tree_generic.h
@@ -77,7 +77,7 @@ ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,			      \
  *   Cond2: start <=3D ITLAST(node)					      \
  */									      \
 									      \
-static ITSTRUCT *							      \
+ITSTATIC ITSTRUCT *							      \
 ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	     =
 \
 {									      \
 	while (true) {							      \
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33b..04fa277 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3369,6 +3369,8 @@ void vma_interval_tree_insert_after(struct vm_area_stru=
ct *node,
 				    struct rb_root_cached *root);
 void vma_interval_tree_remove(struct vm_area_struct *node,
 			      struct rb_root_cached *root);
+struct vm_area_struct *vma_interval_tree_subtree_search(struct vm_area_struc=
t *node,
+				unsigned long start, unsigned long last);
 struct vm_area_struct *vma_interval_tree_iter_first(struct rb_root_cached *r=
oot,
 				unsigned long start, unsigned long last);
 struct vm_area_struct *vma_interval_tree_iter_next(struct vm_area_struct *no=
de,
diff --git a/lib/interval_tree.c b/lib/interval_tree.c
index 324766e..9ceb084 100644
--- a/lib/interval_tree.c
+++ b/lib/interval_tree.c
@@ -13,6 +13,7 @@ INTERVAL_TREE_DEFINE(struct interval_tree_node, rb,
=20
 EXPORT_SYMBOL_GPL(interval_tree_insert);
 EXPORT_SYMBOL_GPL(interval_tree_remove);
+EXPORT_SYMBOL_GPL(interval_tree_subtree_search);
 EXPORT_SYMBOL_GPL(interval_tree_iter_first);
 EXPORT_SYMBOL_GPL(interval_tree_iter_next);
=20
diff --git a/tools/include/linux/interval_tree_generic.h b/tools/include/linu=
x/interval_tree_generic.h
index 1b400f2..c5a2fed 100644
--- a/tools/include/linux/interval_tree_generic.h
+++ b/tools/include/linux/interval_tree_generic.h
@@ -77,7 +77,7 @@ ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,			      \
  *   Cond2: start <=3D ITLAST(node)					      \
  */									      \
 									      \
-static ITSTRUCT *							      \
+ITSTATIC ITSTRUCT *							      \
 ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	     =
 \
 {									      \
 	while (true) {							      \

