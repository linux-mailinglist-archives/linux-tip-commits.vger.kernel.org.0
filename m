Return-Path: <linux-tip-commits+bounces-7483-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A6C7F7FD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7B2134827E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD372F60D6;
	Mon, 24 Nov 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFKYV+i3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lV27DYhc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B82F5A18;
	Mon, 24 Nov 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975504; cv=none; b=eW8em2ao9ti4MWds2jNfGsglZKY5MA0dL1wX6fQmzuyXXQ453j+wkE1cg0sCQdytMlwH709mMP5qZeVAeqUVzGtQO0Is7HAR2cdwk+PNl7OImzH4tVvYksSH5GkbqjrQ1Lid5jZX74EQ8sLhIyQMAgdbhMgMCbWtFGTBoRpCna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975504; c=relaxed/simple;
	bh=cpCkxiCUXuKoaJ8Ar6iVbdX5nLK92IzwgywuGg3KNlM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yn+wN60T9JRahpx+MF26+Hn25ZzT5nSUXc28/qgXFwgsvixEIS1Gwm2zpyAnjFQDjMcTQ17Qww4Jqln/gRbL44g/LuIqxAsufcjWJaOCCC9GSZqKJwREh2kyhTn54yVnlSjqEeM8CHzivWi/KpoUJ6LIBJeF1mY1nA+nnDdtAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFKYV+i3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lV27DYhc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHKrDtNB5P+hAoQwPuI7IbS4QWIpwj1jdNiDhRupDUw=;
	b=IFKYV+i3jN2o3LqT+kGusPG/qsycK7U335CeTCxrao48o9yeWwFUfPfntB2oT7PMWgPlUP
	nZRT5gkjSGBCBt2fpHhvxzneQH7SXtcBC4+JR2QlpqogXv15kNA6ZSzVEb5KMB+tiqSglP
	hN0QM3M/7AaSkDVfzz6jiAO56l70I+uD9BInYWQxysLZLPCoxQi0+GOGEnLkJdnr5ANeJQ
	tAbEcSS5zenkAl5Cr+toYIfiCP+3/uN/FkA1lhxPobE9guJelChd/3eH2XhbWbZaCCR79u
	sG9ne8GmYxycR4vmBGIOkkNdv9HTssdlEr4YrcTDzjdIzhYrJtYvgQKNNd9oBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHKrDtNB5P+hAoQwPuI7IbS4QWIpwj1jdNiDhRupDUw=;
	b=lV27DYhc/F1Ban6aoX6A1+nig7lqDHn/+7sDfaImxG77TE/zLmF+eWgpcQ32V2usRSlYc+
	1RTtlb08+jzt9eBQ==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Provide access to feature and flags of
 group alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-26-alexandre.chartre@oracle.com>
References: <20251121095340.464045-26-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397549865.498.7720547858368907601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     be5ee60ac554c6189cda963e886c4b97d2cb978c
Gitweb:        https://git.kernel.org/tip/be5ee60ac554c6189cda963e886c4b97d2c=
b978c
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:14 +01:00

objtool: Provide access to feature and flags of group alternatives

Each alternative of a group alternative depends on a specific
feature and flags. Provide access to the feature/flags for each
alternative as an attribute (feature) in struct alt_group.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-26-alexandre.chartre@ora=
cle.com
---
 tools/objtool/check.c                   | 2 ++
 tools/objtool/include/objtool/check.h   | 1 +
 tools/objtool/include/objtool/special.h | 2 +-
 tools/objtool/special.c                 | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f75364f..9ec0e07 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1751,6 +1751,7 @@ static int handle_group_alt(struct objtool_file *file,
 		orig_alt_group->last_insn =3D last_orig_insn;
 		orig_alt_group->nop =3D NULL;
 		orig_alt_group->ignore =3D orig_insn->ignore_alts;
+		orig_alt_group->feature =3D 0;
 	} else {
 		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
 		    orig_alt_group->first_insn->offset !=3D special_alt->orig_len) {
@@ -1855,6 +1856,7 @@ end:
 	new_alt_group->nop =3D nop;
 	new_alt_group->ignore =3D (*new_insn)->ignore_alts;
 	new_alt_group->cfi =3D orig_alt_group->cfi;
+	new_alt_group->feature =3D special_alt->feature;
 	return 0;
 }
=20
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index cbf4af5..2e1346a 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -36,6 +36,7 @@ struct alt_group {
 	struct cfi_state **cfi;
=20
 	bool ignore;
+	unsigned int feature;
 };
=20
 enum alternative_type {
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/=
objtool/special.h
index 72d09c0..b224107 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -25,7 +25,7 @@ struct special_alt {
 	struct section *new_sec;
 	unsigned long new_off;
=20
-	unsigned int orig_len, new_len; /* group only */
+	unsigned int orig_len, new_len, feature; /* group only */
 };
=20
 int special_get_alts(struct elf *elf, struct list_head *alts);
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e262af9..2a533af 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -81,6 +81,8 @@ static int get_alt_entry(struct elf *elf, const struct spec=
ial_entry *entry,
 						   entry->orig_len);
 		alt->new_len =3D *(unsigned char *)(sec->data->d_buf + offset +
 						  entry->new_len);
+		alt->feature =3D *(unsigned int *)(sec->data->d_buf + offset +
+						 entry->feature);
 	}
=20
 	orig_reloc =3D find_reloc_by_dest(elf, sec, offset + entry->orig);

