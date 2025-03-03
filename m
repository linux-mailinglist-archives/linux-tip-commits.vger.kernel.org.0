Return-Path: <linux-tip-commits+bounces-3793-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C10A4BD63
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 12:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BD91887317
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B11F4639;
	Mon,  3 Mar 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3z+OHur";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PJT1fSD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB91F3BBD;
	Mon,  3 Mar 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999768; cv=none; b=daeboJiSWKrj8p01WPu6CB4DIN7rBG7qs7Zi+V86CHPgo1562hJPspD7yu312Z9FzFfsMTrAw1epkqw72fs/QcJ+xMbEL5vwS9K/yPQW6MR4yZeAJy0OqpAiqClaLwY/uUrdl7oJ/Fonp1lv2VI1N/z9V67oQm1oWsHDROcPqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999768; c=relaxed/simple;
	bh=1lduF6Z/FG5fT5Eu7LNvor3csqG192Dr9SCL63ulRMA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TPkF2opslaykjyQrVTQvmKGimEA6RnFn/XL1oE2lln5hWeZ9K0yhT46j8EaMHyR8blmrjbtvGyrJWyN8UuHAUwPJMkjKSsJxww+nAhAbjcCCnG1smgzPBbnv7vVWZ6yuhqGgEw3dsMi4hJKftAuvHFgTm81RcrwqwQNOdp1NXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3z+OHur; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PJT1fSD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 11:02:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740999764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=D1KA4ZfnstGPq53Mcbe3JDRTinulWjp/N54egAyFK7Q=;
	b=H3z+OHurDmKtFnGHA2oJNEWViFacX3LqkUMwwL7LXqBn/t9HE/ZFHy9AAgEO6YMSXe/6el
	xS9wZWZDVbtM9dSfBCzfVQH9q/SkPf+xuUGs7bD+y4F1J4YzS2z/FE0etaNfosguKRSMRp
	P/cnpikkhoMiOpGf7uKuhOJtLWHL4QtwHDr8Diflvig9OiQ+vVhXT/6wI5n0sb4foTKWUX
	yiweLixaUufaZ0ke5QejRDEWoV/MI8R/Wazvre3eZv1KTbYSSChPj2bF/mu8jNJFABqiu5
	/GeUwYCz4xUEtEqkf6WvKqNIqdlKC5qbuvjYFUKm9xgifDFroIdReCFoNkiEbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740999764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=D1KA4ZfnstGPq53Mcbe3JDRTinulWjp/N54egAyFK7Q=;
	b=0PJT1fSDPWPG7YDNGAAoQfVksvhPR7dA4RK2vRl+/nSfakv9cP1VCk4f/2BlNU+9WK/j7m
	R9cAoLYCq1y7rrCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] KVM: VMX: Use named operands in inline asm
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099976397.10177.1674977196672237641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     cccc85ea4032aaabec6cb4a62320c08b46435d10
Gitweb:        https://git.kernel.org/tip/cccc85ea4032aaabec6cb4a62320c08b46435d10
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:20:59 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:39:53 +01:00

KVM: VMX: Use named operands in inline asm

Convert the non-asm-goto version of the inline asm in __vmcs_readl() to
use named operands, similar to its asm-goto version.

Do this in preparation of changing the ASM_CALL_CONSTRAINT primitive.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/vmx/vmx_ops.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 633c87e..9667757 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -118,7 +118,7 @@ do_exception:
 
 #else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 
-	asm volatile("1: vmread %2, %1\n\t"
+	asm volatile("1: vmread %[field], %[output]\n\t"
 		     ".byte 0x3e\n\t" /* branch taken hint */
 		     "ja 3f\n\t"
 
@@ -127,24 +127,26 @@ do_exception:
 		      * @field, and bounce through the trampoline to preserve
 		      * volatile registers.
 		      */
-		     "xorl %k1, %k1\n\t"
+		     "xorl %k[output], %k[output]\n\t"
 		     "2:\n\t"
-		     "push %1\n\t"
-		     "push %2\n\t"
+		     "push %[output]\n\t"
+		     "push %[field]\n\t"
 		     "call vmread_error_trampoline\n\t"
 
 		     /*
 		      * Unwind the stack.  Note, the trampoline zeros out the
 		      * memory for @fault so that the result is '0' on error.
 		      */
-		     "pop %2\n\t"
-		     "pop %1\n\t"
+		     "pop %[field]\n\t"
+		     "pop %[output]\n\t"
 		     "3:\n\t"
 
 		     /* VMREAD faulted.  As above, except push '1' for @fault. */
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %1)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %[output])
 
-		     : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
+		     : ASM_CALL_CONSTRAINT, [output] "=&r" (value)
+		     : [field] "r" (field)
+		     : "cc");
 	return value;
 
 #endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */

