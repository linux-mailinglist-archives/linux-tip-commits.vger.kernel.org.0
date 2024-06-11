Return-Path: <linux-tip-commits+bounces-1368-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CBC9041E7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776FE28C151
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3D5FEE4;
	Tue, 11 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rgm+YsOZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6SQzF/5F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5BB48CCD;
	Tue, 11 Jun 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124839; cv=none; b=BQBe5CuXAsjyDThJQrb6UrdB2iwb+oUHpx8MFwmCk1qPfKfdoi9RmOHhS/6/mxPX5RvKjQbk9C4Ook4OIkIo2GaF8dOuMwzfsUka43mlUhPmJ63aWeWjzWDc4biKZ3tA4nsXdyf1XrIIBnsVYv2Oq3TSuOZuh8LdtIUG2Pb13F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124839; c=relaxed/simple;
	bh=xeT+UcB3jgw0iQ7ODeXiC8Tq+NUmtrGQYOKVNRSo+mU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rsu+Nz0LU88xjVocpVIizDmOo7Z5Lc7AJAELNmucGNd/lXj6/NqCoddQaNwQFZZM1m+dAiH2vf7XEjJcbCYl+Y/5CJzn1GOna4yxFbPcNCX1f2YCxSucawRs0lamMz0JfJfh2769hFK4VBt+LOQcmFZVtjcFHbDNZtiUfOJxe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rgm+YsOZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6SQzF/5F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnfXJou5oXaes8NRV8HoH6G7ySQTHvCWo43c4GirjqE=;
	b=Rgm+YsOZOYp+b7JEGt65dIyrmjLMoZ6x50wCBXpfQvVoF/PeT6gy/nrwl5dZYL/WLuZehy
	fMNxrBBLBqKIVWr33rpbl8VJES1d0gaArO0rA/LCkH0WSkdDEo5DFvXBAT4iK2ZfIkw0fh
	hP2kl80UhrDKm7fygrYvQOxoNCqPch+bSCd6tt+WxZVTTvj6Ntu2dh4AO6oSNDZOOccFcr
	UJDEm4zl3uv2ZGY9T/XK/Kl9Pdyhj5kaRiA5+B8hZZdx2l7wPLGgaU1R1HwIjIMFcmCqK5
	zfr0w2Bv3kRuDInpi1iEudx6Ie9hkACtS3TTpTukQtVUoRYoXknSbRDJQKVfHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnfXJou5oXaes8NRV8HoH6G7ySQTHvCWo43c4GirjqE=;
	b=6SQzF/5FFhcxFShgsD6TIZwFKZD30V6CPJSjQi8k6v07Z1NRZ1wT5bwYZ04C2Zgr7jiRCT
	6UgN+7It5200a1Dg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert ALTERNATIVE_3()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-11-bp@kernel.org>
References: <20240607111701.8366-11-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482793.10875.5973086213214340869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     93694129c6e84d3013f5b2787e2ff88dd706c4f0
Gitweb:        https://git.kernel.org/tip/93694129c6e84d3013f5b2787e2ff88dd706c4f0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:57 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:22:41 +02:00

x86/alternative: Convert ALTERNATIVE_3()

Zap the hack of using an ALTERNATIVE_3() internal label, as suggested by
bgerst:

  https://lore.kernel.org/r/CAMzpN2i4oJ-Dv0qO46Fd-DxNv5z9=x%2BvO%2B8g=47NiiAf8QEJYA@mail.gmail.com

in favor of a label local to this macro only, as it should be done.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-11-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 24 ++++--------------------
 arch/x86/kernel/fpu/xstate.h       | 14 +++++---------
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 007baab..fba12ad 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -277,26 +277,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
-			newinsn3, ft_flags3)				\
-	OLDINSTR_3(oldinsn, 1, 2, 3)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	ALTINSTR_ENTRY(ft_flags3, 3)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinsn1, 1)				\
-	ALTINSTR_REPLACEMENT(newinsn2, 2)				\
-	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
-	".popsection\n"
-
-
-#define N_ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
-		      newinst3, flag3)					\
-	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
-		      newinst3, flag3)
-
+#define ALTERNATIVE_3(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, \
+			newinstr3, ft_flags3)				\
+	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2), \
+		      newinstr3, ft_flags3)
 /*
  * Alternative instructions for different CPU types or capabilities.
  *
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 05df04f..2ee0b9c 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -106,21 +106,17 @@ static inline u64 xfeatures_mask_independent(void)
  * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
  * supports modified optimization which is not supported by XSAVE.
  *
- * We use XSAVE as a fallback.
- *
- * The 661 label is defined in the ALTERNATIVE* macros as the address of the
- * original instruction which gets replaced. We need to use it here as the
- * address of the instruction where we might get an exception at.
+ * Use XSAVE as a fallback.
  */
 #define XSTATE_XSAVE(st, lmask, hmask, err)				\
-	asm volatile(ALTERNATIVE_3(XSAVE,				\
+	asm volatile("1: " ALTERNATIVE_3(XSAVE,				\
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
 				   XSAVEC,   X86_FEATURE_XSAVEC,	\
 				   XSAVES,   X86_FEATURE_XSAVES)	\
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
+		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
@@ -130,11 +126,11 @@ static inline u64 xfeatures_mask_independent(void)
  * XSAVE area format.
  */
 #define XSTATE_XRESTORE(st, lmask, hmask)				\
-	asm volatile(ALTERNATIVE(XRSTOR,				\
+	asm volatile("1: " ALTERNATIVE(XRSTOR,				\
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")

