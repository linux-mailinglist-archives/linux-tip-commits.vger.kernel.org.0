Return-Path: <linux-tip-commits+bounces-4199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4CA5FE8B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 18:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA523A7D9B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A681E5B64;
	Thu, 13 Mar 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fc6TNNG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzjVpdXy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2B1E51EE;
	Thu, 13 Mar 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888243; cv=none; b=J16PyQZWgZVU2UeZk3K7mi1KIpaRXUvKkE7/cQerrQTPBHNsD2Yu/wWgrsXk1AYvoQzQh4gUEwUHSKklJGCg+Vku0L/o41D/nhe81iGuNOwGPIRrkeUYehZqoab5N5otxSTk79Q1U4syJM+kHAyxaJuE6gA6v9MAxRTsFyEAqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888243; c=relaxed/simple;
	bh=hE3o3l6YDDbEl7ls3Vj4rSrOsIq7qnOAbxmMi+K2QSA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tBSRBd7XULCCazyssnBjG5I5l9Qcai1d5KI4fGAA54t/baTMWrLim+4jj/O97qb0h9fKtimGSF8BL8fUvcFl+G2PFf3j69Pdmy+NdzBnf5hnVMIiX/gG1MTHi34YW/OyiGeNBm9g0bVBKZW9AmTh8XSCRBbw/JAh9fCeK7czsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fc6TNNG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzjVpdXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 17:50:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741888239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tv3o6lwids3X2Ww1BF3y4l+mwnpzcwgvGJXX1PhNsQk=;
	b=0fc6TNNG2FoYoBsaBlPnti79CBu3lKoeeDeG6k2fGin6pRMlNFuaGhUcuk9Y9B9AbOsd2f
	DXBWH0qNWws/3V41mB+9BngG+MGhCRhBDPKeX4KUFY8/GcfX1+K6wfYgpLDN5TEHihiKiH
	tVle44b5J+1oRIjSf5yYe2OxcRV1Hw1C6uTAkVn0HxU7nWVhnNMUECqo/+BOKKqAx3XV0H
	W3wPhSYvQq+VXoq6WwZ2nvZ9Pbn6x5mpRpBcXuHX5/Nn4fIKw0ct0pdncDiS1EoPFNwQa6
	xuZBSIM7ncnYfSlwv6jDGH6vmyAu+//Q9G8qAUXnCrmJ0f3NWeWu29O7+nob+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741888239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tv3o6lwids3X2Ww1BF3y4l+mwnpzcwgvGJXX1PhNsQk=;
	b=EzjVpdXyXcAv67R+0nz28EhjJWpId6sFzp4nVPZNzkXvn9NAE6kxMOjERN0y54/OVfSGNo
	bOEDtOYa3/8LhiAA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S} mnemonics
 in xstate.h
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313130251.383204-1-ubizjak@gmail.com>
References: <20250313130251.383204-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2883b4c2169a435488f7845e1b6fdc6f3438c7c6
Gitweb:        https://git.kernel.org/tip/2883b4c2169a435488f7845e1b6fdc6f3438c7c6
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 14:02:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 18:36:52 +01:00

x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S} mnemonics in xstate.h

Current minimum required version of binutils is 2.25, which
supports XSAVE{,OPT,C,S} and XRSTOR{,S} instruction mnemonics.

Replace the byte-wise specification of XSAVE{,OPT,C,S}
and XRSTOR{,S} with these proper mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250313130251.383204-1-ubizjak@gmail.com
---
 arch/x86/kernel/fpu/xstate.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index aa16f1a..1418423 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -94,18 +94,17 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
-#define REX_PREFIX	"0x48, "
+#define REX_SUFFIX	"64"
 #else
-#define REX_PREFIX
+#define REX_SUFFIX
 #endif
 
-/* These macros all use (%edi)/(%rdi) as the single memory argument. */
-#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
-#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
-#define XSAVEC		".byte " REX_PREFIX "0x0f,0xc7,0x27"
-#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
-#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
-#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
+#define XSAVE		"xsave" REX_SUFFIX " %[xa]"
+#define XSAVEOPT	"xsaveopt" REX_SUFFIX " %[xa]"
+#define XSAVEC		"xsavec" REX_SUFFIX " %[xa]"
+#define XSAVES		"xsaves" REX_SUFFIX " %[xa]"
+#define XRSTOR		"xrstor" REX_SUFFIX " %[xa]"
+#define XRSTORS		"xrstors" REX_SUFFIX " %[xa]"
 
 /*
  * After this @err contains 0 on success or the trap number when the
@@ -114,10 +113,10 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
-		     "2:\n\t"						\
+		     "2:\n"						\
 		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
 /*
@@ -137,12 +136,12 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
 				   XSAVEC,   X86_FEATURE_XSAVEC,	\
 				   XSAVES,   X86_FEATURE_XSAVES)	\
-		     "\n"						\
+		     "\n\t"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
 		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
 /*
@@ -156,7 +155,7 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
 		     "3:\n"						\
 		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)

