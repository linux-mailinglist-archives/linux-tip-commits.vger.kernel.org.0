Return-Path: <linux-tip-commits+bounces-4378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0EA68B00
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2215887680
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49925EFB4;
	Wed, 19 Mar 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aw8gUxNE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="059jTa80"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7425DCF4;
	Wed, 19 Mar 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382243; cv=none; b=W1h+3WfPft6btunOsbEVUwhDIzuPdq2vtYa7PF7DMpffpAyF04WOYQLBuE8Z8GN+wu1uME+MRYSuemGjZ3W6OvsCx0Q7A1DVZg81Ea5TGdXVUGLdczV91M29woWW66RpQtcsKDCo+JQXI674Sir4rNcxSdLx0xonlnv6JRgEJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382243; c=relaxed/simple;
	bh=LrSU1abr9J8m8d2g3Lu0DtCXeMfPAYgdMDfrFNB3vP0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VaOvqVacbvo7F2DDcxYtPf28J1+JuZ0bML4iTcJ2PxioDgGttC733uPv19lC7jWIJM92+90X2ATG4HMB69x54FqqgaI/9ulDs/s+DykyJa00apvE20/VWDn+s1xCOsOe3YzRgowpJ4vAPrM0H9tETSM+XpYW3I/AX//Fh5pJ/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aw8gUxNE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=059jTa80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znubIEzILzyjDgMmLJkBE/HjrFgAG9Q1tYenY5t7/hU=;
	b=Aw8gUxNEwsz7DVpNoUqIoHiQZdERNAgvkx76JyIHhrKr2WA/qNYj4aLXEr6Gbqrwope3my
	3canLQDsYXibBCQdrCyBv3lWXd+pcxz2nqfjpcseJ6ZB5J2YMEYVWpAMgPMcXv+z1gjdEj
	rFj7E9TjjZKM1uLGnRoVUbUOsy0mXB0E3u1EzEV9sYiJNNyZSY7OqK/6uq0+XTiT5Bw4tF
	xMDjtiYln7QsKzKp1bA2NwiagZGDMKLzR+s/x/fYitN4I+wVimc9wEuau9N8wT46Dj+MT1
	7rFcb4m7oxhWozfTX54RJN3gb7ufZ4cT0WRSDAfb6lPjxoybFs0Jegx9DKRl/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znubIEzILzyjDgMmLJkBE/HjrFgAG9Q1tYenY5t7/hU=;
	b=059jTa80JfedV7nnD8+po3Ztr8VIXsdhf0jjoy3SqFgSm5JsDmURKu2ap+Khkw50Ga46Uy
	ksi4c8BxpyrAfFCw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpufeatures: Use AWK to generate
 {REQUIRED|DISABLED}_MASK_BIT_SET in <asm/cpufeaturemasks.h>
Cc: Brian Gerst <brgerst@gmail.com>, "Xin Li (Intel)" <xin@zytor.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228082338.73859-6-xin@zytor.com>
References: <20250228082338.73859-6-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223840.14745.12227408766320522846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     da414d34b55556156ee1a77cf7713fc97071e07b
Gitweb:        https://git.kernel.org/tip/da414d34b55556156ee1a77cf7713fc97071e07b
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 28 Feb 2025 00:23:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:15:12 +01:00

x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET in <asm/cpufeaturemasks.h>

Generate the {REQUIRED|DISABLED}_MASK_BIT_SET macros in the newly added AWK
script that generates <asm/cpufeaturemasks.h>.

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250228082338.73859-6-xin@zytor.com
---
 arch/x86/include/asm/cpufeature.h  | 69 +-----------------------------
 arch/x86/tools/cpufeaturemasks.awk |  9 +++-
 2 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index d54db88..910601c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -51,75 +51,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 #define test_cpu_cap(c, bit)						\
 	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
 
-/*
- * There are 32 bits/features in each mask word.  The high bits
- * (selected with (bit>>5) give us the word number and the low 5
- * bits give us the bit/feature number inside the word.
- * (1UL<<((bit)&31) gives us a mask for the feature_bit so we can
- * see if it is set in the mask word.
- */
-#define CHECK_BIT_IN_MASK_WORD(maskname, word, bit)	\
-	(((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
-
-/*
- * {REQUIRED,DISABLED}_MASK_CHECK below may seem duplicated with the
- * following BUILD_BUG_ON_ZERO() check but when NCAPINTS gets changed, all
- * header macros which use NCAPINTS need to be changed. The duplicated macro
- * use causes the compiler to issue errors for all headers so that all usage
- * sites can be corrected.
- */
-#define REQUIRED_MASK_BIT_SET(feature_bit)		\
-	 ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  2, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  3, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  4, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  5, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  6, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  7, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  8, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  9, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 10, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 11, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 12, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 13, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 14, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 15, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
-	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
-
-#define DISABLED_MASK_BIT_SET(feature_bit)				\
-	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  1, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  2, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  3, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  4, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  5, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  6, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  7, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  8, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  9, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 10, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 11, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 12, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 13, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 14, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 15, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
-	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
-	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
-
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
 	 test_cpu_cap(c, bit))
diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeaturemasks.awk
index 59757ca..173d5bf 100755
--- a/arch/x86/tools/cpufeaturemasks.awk
+++ b/arch/x86/tools/cpufeaturemasks.awk
@@ -74,7 +74,14 @@ END {
 		for (i = 0; i < ncapints; i++)
 			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
 
-		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
+		printf "\n#define %s_MASK_BIT_SET(x)\t\t\t\\\n", s;
+		printf "\t((\t\t\t\t\t";
+		for (i = 0; i < ncapints; i++) {
+			if (masks[i])
+				printf "\t\\\n\t\t((x) >> 5) == %2d ? %s_MASK%d :", i, s, i;
+		}
+		printf " 0\t\\\n";
+		printf "\t) & (1U << ((x) & 31)))\n\n";
 	}
 
 	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";

