Return-Path: <linux-tip-commits+bounces-4026-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D575A54867
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 11:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A067C1730C7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C9202984;
	Thu,  6 Mar 2025 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bjDH/ji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RvFTdace"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A853BE;
	Thu,  6 Mar 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258299; cv=none; b=jazst4UPTqdgij0PDWC242E6Q1H50sWkuX5jdcGk3c9jR3/8ITG01/5s0NIdyMZBIwBLvG9X2Q0yTNwFEEd1G0L8ePF/CwRBkrPRJIUntgIUjrvgh2xGbzddSfGrQ3viQl4cRjq6S4sinLzCLceON3dEy8A/ZHtqyfA/KRC9J2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258299; c=relaxed/simple;
	bh=Xa1ea0o3Q74JkzomTfFbykLAOK7vKh87CHWZW1SHmzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AI2mA1EVlduUGoGyMAC6wDAJSYsU2Il7wsFErRk7UPzv14ypycJim5tmhgFEIDs47dstsYfvtTTarCiW04uyxVHgkVZe83ZvRn+f4JaAvYK8o4ZTuVeCAze38irNLcZ2ACiCI4MkK66LGcmT2M2qNnuZkhA8HSVvMGRbwJvzOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bjDH/ji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RvFTdace; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 10:51:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741258296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NBdpfjFRzYCeUlmolcL8ku0hDh3g/6wkN9Q589wB6I=;
	b=0bjDH/jih6DutXgsHMRP+N2HFTz0kr7k7CUbaOljkWuR2Y5b2Zf66AUIc2ZiTsweT173r/
	WAYU7LQsP0s5IskN7jufrWk/fE9RlwlZ1YzrU2n0ylY1cI1Kv8hmAZq8enshHmOcwqr1rU
	XSRbGl3MsGy4rvki1pHFrJ6LPaOq26IfXwjcXrFvhmJeG6F2COTyxFkddnYD63kM0ILuZp
	aojqe21AKJ8OGuz998ATlXfDdNtN59XKiNHV1hlna+TxWir5hBwHdjjOLMVAdvMRW1PwUM
	s6EsoMvb8C6Y+Xs1n8GnUSwxBwx0KXUW2YbJmN1GAwC+zO0cqTRWekazSL/BFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741258296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NBdpfjFRzYCeUlmolcL8ku0hDh3g/6wkN9Q589wB6I=;
	b=RvFTdace0SvLfYPduen/oJbbZjBOUjstWk2HhiC38ZFjwz5YLd7u9TQmQW7qmhtydALNlE
	5JU+QXXC+H5DZRBQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/runtime-const: Add the RUNTIME_CONST_PTR assembly macro
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304153342.2016569-1-kirill.shutemov@linux.intel.com>
References: <20250304153342.2016569-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174125829544.14745.15198540190930233265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c84f87de474c9aec84f706ceb732b70751122746
Gitweb:        https://git.kernel.org/tip/c84f87de474c9aec84f706ceb732b70751122746
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 04 Mar 2025 17:33:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 11:27:31 +01:00

x86/runtime-const: Add the RUNTIME_CONST_PTR assembly macro

Add an assembly macro to refer runtime cost. It hides linker magic and
makes assembly more readable.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250304153342.2016569-1-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/runtime-const.h | 13 +++++++++++++
 arch/x86/lib/getuser.S               |  7 ++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 6652ebd..8d983cf 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
+#ifdef __ASSEMBLY__
+
+.macro RUNTIME_CONST_PTR sym reg
+	movq	$0x0123456789abcdef, %\reg
+	1:
+	.pushsection runtime_ptr_\sym, "a"
+	.long	1b - 8 - .
+	.popsection
+.endm
+
+#else /* __ASSEMBLY__ */
+
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
 	asm_inline("mov %1,%0\n1:\n"				\
@@ -58,4 +70,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
+#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 89ecd57..853a2e6 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -34,16 +34,13 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/runtime-const.h>
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	movq $0x0123456789abcdef,%rdx
-  1:
-  .pushsection runtime_ptr_USER_PTR_MAX,"a"
-	.long 1b - 8 - .
-  .popsection
+	RUNTIME_CONST_PTR USER_PTR_MAX, rdx
 	cmp %rdx, %rax
 	cmova %rdx, %rax
 .else

