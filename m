Return-Path: <linux-tip-commits+bounces-7574-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA796CA01BC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 17:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DE8F3039EB7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40034AAF0;
	Wed,  3 Dec 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j38zBcAK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6BHOizU0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81B349B15;
	Wed,  3 Dec 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780042; cv=none; b=I5FQYsH8FddxPI98VeaKwr8S/2bgCnVKQOFRqikajOPq9GxCxbJx4Qb9rUTW/GP3LOthiDRTExbbDS3fe2rSVdKBS/zQMM4VpzOqjA+76R6DsQ/TrUm+fVkE587rUvhnsLFv87vyxj3c2Yer9upV1DPV8uAZjqQnzXL5KqSlpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780042; c=relaxed/simple;
	bh=2xb5vjgk0UQ/g2WYZ0DGsMIIxeDxG/rBqF20LVjkcnc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+AdAsGGuZ6kvBuR38U5WyTVZJNqK6g8YP8jp6Peh11Fa8oiTVZSSJd4Uht1J/l2MuDCpRzX73/35rx5DUB3gpS/jFpyQGYxmG9l6G1yhxr2X9YUkT/NKzhzo2Tehb72xewPqQk2M1fSgN3VFKU3V7BIctfDF245XUiQ4WucTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j38zBcAK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6BHOizU0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 16:40:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764780037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gxpq7b+6YStjnTTFVidw4b18D61OdKyWCpcpO4RMcw=;
	b=j38zBcAKJHFzBRcHR2FjhM6Uv7rUu/EUzAG80vJZRT6OiRz6SuRP+iYKkRc9ROXF4KOY9W
	4IPhZPHZFJiQ9OS31CnWWCWigd75lg+cZcIW4+nOjUWCrv61rgcVj+gL1EP98X7Me/IFD8
	dKale722m68LnD0BQwEALqBeb0DowVVlmzVcr2B7ylVNKU1lmM+agN+1n5FdGoRjakey9y
	jbvgeFg0i9o/FBxLhxetnhjPGfQxAx/AZChgCWckXB65sbSFwGkQugAsYd96J9MlqVvSM4
	kdDEsQ6uYeiZlkWse8wUZQQGfk82Ybe0MNULXV1rktMBjVW1uwegu3w0ngUN+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764780037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gxpq7b+6YStjnTTFVidw4b18D61OdKyWCpcpO4RMcw=;
	b=6BHOizU0dKXwMwvKtzjoNAUP7sFdwU+8LSuGErluAM7BBMIn8hAnrm1CbC0Qo5AE8dq2yX
	2afFPL8/qTJG3YBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] x86/alternative: Remove ANNOTATE_DATA_SPECIAL usage
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <5ac04e6db5be6453dce8003a771ebb0c47b4cd7a.1764694625.git.jpoimboe@kernel.org>
References:
 <5ac04e6db5be6453dce8003a771ebb0c47b4cd7a.1764694625.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478003645.498.13757835632501051533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     a818f28f017b23cfe830dd82e89b5aa6b0fea8e5
Gitweb:        https://git.kernel.org/tip/a818f28f017b23cfe830dd82e89b5aa6b0f=
ea8e5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 09:59:36 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 16:53:19 +01:00

x86/alternative: Remove ANNOTATE_DATA_SPECIAL usage

Instead of manually annotating each .altinstructions entry, just make
the section mergeable and store the entry size in the ELF section
header.

Either way works for objtool create_fake_symbols(), this way produces
cleaner code generation.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/5ac04e6db5be6453dce8003a771ebb0c47b4cd7a.17646=
94625.git.jpoimboe@kernel.org
---
 arch/um/include/shared/common-offsets.h | 2 ++
 arch/x86/include/asm/alternative.h      | 7 +++----
 arch/x86/kernel/asm-offsets.c           | 2 ++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared=
/common-offsets.h
index 8ca66a1..4e19103 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -18,3 +18,5 @@ DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
 DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
=20
 DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
+
+DEFINE(ALT_INSTR_SIZE, sizeof(struct alt_instr));
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/altern=
ative.h
index b14c045..df2c870 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -197,8 +197,8 @@ static inline int alternatives_text_reserved(void *start,=
 void *end)
 	"773:\n"
=20
 #define ALTINSTR_ENTRY(ft_flags)					      \
-	".pushsection .altinstructions,\"a\"\n"				      \
-	ANNOTATE_DATA_SPECIAL						      \
+	".pushsection .altinstructions, \"aM\", @progbits, "		      \
+		      __stringify(ALT_INSTR_SIZE) "\n"			      \
 	" .long 771b - .\n"				/* label           */ \
 	" .long 774f - .\n"				/* new instruction */ \
 	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
@@ -339,7 +339,6 @@ void nop_func(void);
  * instruction. See apply_alternatives().
  */
 .macro altinstr_entry orig alt ft_flags orig_len alt_len
-	ANNOTATE_DATA_SPECIAL
 	.long \orig - .
 	.long \alt - .
 	.4byte \ft_flags
@@ -363,7 +362,7 @@ void nop_func(void);
 741:									\
 	.skip -(((744f-743f)-(741b-740b)) > 0) * ((744f-743f)-(741b-740b)),0x90	;\
 742:									\
-	.pushsection .altinstructions,"a" ;				\
+	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE ;\
 	altinstr_entry 740b,743f,flag,742b-740b,744f-743f ;		\
 	.popsection ;							\
 	.pushsection .altinstr_replacement,"ax"	;			\
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 32ba599..db3bb51 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -124,4 +124,6 @@ static void __used common(void)
 	OFFSET(ARIA_CTX_rounds, aria_ctx, rounds);
 #endif
=20
+	BLANK();
+	DEFINE(ALT_INSTR_SIZE,	sizeof(struct alt_instr));
 }

