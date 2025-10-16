Return-Path: <linux-tip-commits+bounces-6912-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36ABE2927
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3858D1A620B8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586AF338F50;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5CPG8wE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QS8IIvlk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9333314C3;
	Thu, 16 Oct 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608406; cv=none; b=evQCV4/TD/SawnNj+UZSjNM6UQ+6Joj2hKeSJ+4QTu8um5BybIp3SE07q4r2tgZGhpCc5Tu+/30lWWZkV7rMhm8CG3SdTuUDbgGrT3Da7FTKXeg/RywibVzUL0lMBDDm8yf+tACc8OkS6cRExegETvIc6sKF+xidZaIpqfAWHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608406; c=relaxed/simple;
	bh=3hl/Se0j8ZDUCZR1PETediZjfRZvHSeolD/zLBZLWEk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=i15IDK8BCMVxobGtpmUNoYjgwuOMKBaSz1t83NlGyBKBwHaHWFWGBGgM/RjvpOjWQOQZWSNCSN91usmQsvQsUNchKvgvr54Fy7+IEMynM0RB58PtrPVkJ3C8kDKGQI6TxBhz7Kn9r+CuyX9ZnqlqVQ6wvExnZvZtqU25ZfiSd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5CPG8wE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QS8IIvlk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CK7j4DhHlA8KtaF4qkHYUzU3D5+6TlpyxicG2fdSF+M=;
	b=m5CPG8wEwV5hePNy3btk1MXryssbBNy1wGMUan/dZFP/Jt9uuaqwpmoUIH7Er2rJKTokuu
	1OyMob73zP9jj45lG5WiZR9pEnlvgeeWm6S69Gh/oqR1ydqpabaxYNehdqOm6mJH0eNd11
	I8Bizrw33A3wTzcrSZjNWaS/FUpYYIeNaxwSxKGRkzhoRc3Qv8OXyg4bKo+jbtp5W+ANz1
	Qf2+b9u+04sQqGCmjzDBEtVZsPGXI/KZGl3BJDjipu1CpFSK8d6hUJQPKkAd+hB/n93C4G
	TETwa5ayTXhlKYvpScscaUvsENml9Ah09FspsxTqSU+6OtJpsYxPn4HSsS9n/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CK7j4DhHlA8KtaF4qkHYUzU3D5+6TlpyxicG2fdSF+M=;
	b=QS8IIvlksZrmU1UzmdKMsyUPNQDhCUq/yvOX2rFi1ggBZ64JBjCi6gXmO3kVZ8rkK4cAW4
	c9BK7Y4yefjFu/CA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] interval_tree: Sync interval_tree_generic.h with tools
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838698.709179.767952042115144526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9b7eacac22693d9177402c9d63e1c1747653d28c
Gitweb:        https://git.kernel.org/tip/9b7eacac22693d9177402c9d63e1c174765=
3d28c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:19 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:22 -07:00

interval_tree: Sync interval_tree_generic.h with tools

The following commit made an improvement to interval_tree_generic.h, but
didn't sync it to the tools copy:

  19811285784f ("lib/interval_tree: skip the check before go to the right sub=
tree")

Sync it, and add it to objtool's sync-check.sh so they are more likely
to stay in sync going forward.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/include/linux/interval_tree_generic.h | 8 ++------
 tools/objtool/sync-check.sh                 | 1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/include/linux/interval_tree_generic.h b/tools/include/linu=
x/interval_tree_generic.h
index aaa8a07..1b400f2 100644
--- a/tools/include/linux/interval_tree_generic.h
+++ b/tools/include/linux/interval_tree_generic.h
@@ -104,12 +104,8 @@ ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start=
, ITTYPE last)	      \
 		if (ITSTART(node) <=3D last) {		/* Cond1 */	      \
 			if (start <=3D ITLAST(node))	/* Cond2 */	      \
 				return node;	/* node is leftmost match */  \
-			if (node->ITRB.rb_right) {			      \
-				node =3D rb_entry(node->ITRB.rb_right,	      \
-						ITSTRUCT, ITRB);	      \
-				if (start <=3D node->ITSUBTREE)		      \
-					continue;			      \
-			}						      \
+			node =3D rb_entry(node->ITRB.rb_right, ITSTRUCT, ITRB); \
+			continue;					      \
 		}							      \
 		return NULL;	/* No match */				      \
 	}								      \
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 81d120d..86d64e3 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -16,6 +16,7 @@ arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
+include/linux/interval_tree_generic.h
 include/linux/static_call_types.h
 "
=20

