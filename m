Return-Path: <linux-tip-commits+bounces-7495-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B02C7F85A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBBF7345030
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9392FC891;
	Mon, 24 Nov 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9KzX3+z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9TjPt7oI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654A2FBE12;
	Mon, 24 Nov 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975517; cv=none; b=X6mLHkwcAJjd8YnT1DmAvMcd89QuvAw1Xsrb2qghL9TDBoMtVAkAm4b8CmJUH/gERPtzNhvZDcDC3M8ns0TS6ZAaLGkKjdybPUz2h5chE/PXioqJPQ4oD+jW8cSup2WysMfmQMOhgS3ryrlWFmlu2I8FVP8S5Rv33aiDCgau2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975517; c=relaxed/simple;
	bh=EFhA92LUTZUyqPi6enMGHaauFZLDZB5dH3xBWXDzxuk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S5bwcIcKzrWA1U/Fxr8/AndDjJ5X6Nr2vmemhUd5IzKmatwVLlhhYfHeO8EvuSm88Ye6dCk/EremZhy0MMkxEsTg+YWr6i9tzbFfAVaKze/tF4CDsVE+/6Zn5QllylldsC3071a8fcyV0dAmZQ+pWs9usf2B0MEzOFbXpvhPDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9KzX3+z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9TjPt7oI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sLtkH/FWmwkg2qO5cRoeDYez2UeVDbIZDlcFZn6gME=;
	b=S9KzX3+zwskKThlp8daVftZEgty/Uu61ILE6MFJDtFmlP2n1UFEZN8K7H4PXFcDfHXfrI2
	93PnNGiT+g+na0Gc43h1M4V15ScTyI2rKFkxe+TX2BXCTAWy1TVDqfM3u7k5z80lV31ugj
	HzVF4pc3sWnymkNjOvfjkYm12Aw9H/KTdrL2LgZ2yYIdUN160CSVHmucWYgiK5Kd3L7HyS
	F735iJTshKjPj870U1dB5qFlTIu+giiDWBOCXFKd8yQ8kplI+0djb01QV2H5YZ+HpFIbbE
	InoSzdGjBATsfxAob4xZjbdTwFuDGQTeQUJRCa9eseQiymJXzBFbA3ksF13QnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sLtkH/FWmwkg2qO5cRoeDYez2UeVDbIZDlcFZn6gME=;
	b=9TjPt7oIq1Ei3iOgtM+TXcdQVAccK2Yt4INgwQudJcbc84z6CjtXM5WMGOWOC7UnDcuZMo
	nOvbo5EJTttPXGAg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Identify the different types of alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-14-alexandre.chartre@oracle.com>
References: <20251121095340.464045-14-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551104.498.13298733631910735089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d490aa21973fe66ec35ad825c19f88ac7f7abb27
Gitweb:        https://git.kernel.org/tip/d490aa21973fe66ec35ad825c19f88ac7f7=
abb27
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:11 +01:00

objtool: Identify the different types of alternatives

Alternative code, including jump table and exception table, is represented
with the same struct alternative structure. But there is no obvious way to
identify whether the struct represents alternative instructions, a jump
table or an exception table.

So add a type to struct alternative to clearly identify the type of
alternative.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-14-alexandre.chartre@ora=
cle.com
---
 tools/objtool/check.c                 | 13 ++++++++-----
 tools/objtool/include/objtool/check.h | 12 ++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a02f8db..93aaa4b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -27,11 +27,6 @@
 #include <linux/static_call_types.h>
 #include <linux/string.h>
=20
-struct alternative {
-	struct alternative *next;
-	struct instruction *insn;
-};
-
 static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
=20
 static struct cfi_init_state initial_func_cfi;
@@ -1924,6 +1919,7 @@ static int add_special_section_alts(struct objtool_file=
 *file)
 	struct list_head special_alts;
 	struct instruction *orig_insn, *new_insn;
 	struct special_alt *special_alt, *tmp;
+	enum alternative_type alt_type;
 	struct alternative *alt;
=20
 	if (special_get_alts(file->elf, &special_alts))
@@ -1959,9 +1955,15 @@ static int add_special_section_alts(struct objtool_fil=
e *file)
 			if (handle_group_alt(file, special_alt, orig_insn, &new_insn))
 				return -1;
=20
+			alt_type =3D ALT_TYPE_INSTRUCTIONS;
+
 		} else if (special_alt->jump_or_nop) {
 			if (handle_jump_alt(file, special_alt, orig_insn, &new_insn))
 				return -1;
+
+			alt_type =3D ALT_TYPE_JUMP_TABLE;
+		} else {
+			alt_type =3D ALT_TYPE_EX_TABLE;
 		}
=20
 		alt =3D calloc(1, sizeof(*alt));
@@ -1972,6 +1974,7 @@ static int add_special_section_alts(struct objtool_file=
 *file)
=20
 		alt->insn =3D new_insn;
 		alt->next =3D orig_insn->alts;
+		alt->type =3D alt_type;
 		orig_insn->alts =3D alt;
=20
 		list_del(&special_alt->list);
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index fde9586..cbf4af5 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -38,6 +38,18 @@ struct alt_group {
 	bool ignore;
 };
=20
+enum alternative_type {
+	ALT_TYPE_INSTRUCTIONS,
+	ALT_TYPE_JUMP_TABLE,
+	ALT_TYPE_EX_TABLE,
+};
+
+struct alternative {
+	struct alternative *next;
+	struct instruction *insn;
+	enum alternative_type type;
+};
+
 #define INSN_CHUNK_BITS		8
 #define INSN_CHUNK_SIZE		(1 << INSN_CHUNK_BITS)
 #define INSN_CHUNK_MAX		(INSN_CHUNK_SIZE - 1)

