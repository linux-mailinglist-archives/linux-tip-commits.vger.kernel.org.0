Return-Path: <linux-tip-commits+bounces-3375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27520A36D78
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0DD16EFC9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01C1D5ADD;
	Sat, 15 Feb 2025 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZST/BcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGgmcruP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF41AB531;
	Sat, 15 Feb 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617004; cv=none; b=JA5ODXtqe6UG/e7iTNwSwayBRZZ9HLoBHPeLUjCVGwhKe6k0yEej3vAt47B6HJ//wEzzBLPyjbrGPixdzcDyxg4zT9sPwYZgzoOT0fOJt2vGOqfHZsETCevUMFtz1D41wGgVCb2FmFdG3S3NfDy+5l5SX3h3Gl9a4m11JF3YGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617004; c=relaxed/simple;
	bh=L3NprjJfDrDHGK/pk4r6YNHLYL87nMecYcypS3S1MsM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N1aHtne8ORCGg44yPIv3+SqVqidUQwZDfs7PL2L1Y3JhFa8rnmqdXBAPWGsjFaGLaSwz4kW5wBbIMHR5s5NiSFigIO2IHV5ZuHbgWQ+rimFJWQm5MpwCcUW9oe73A89zukZoIMKTSZ9dzObfztRwvKOpM27modk6mO5f3CwGlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZST/BcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGgmcruP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739617000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ZUb6K4zfkbX6C4XqM7g1CGqfPOgQvgwV3At+Nstm0=;
	b=zZST/BcCgNY+EaPyBtVvgpx2/hraImUZAJpQx8o11im5lnRETS0HfcOObDlDfmJftLPpHl
	CU571XVvBafmoCg1bgPWhVgM7TD75O20o3brFjZRGvRdyYsLpN6lRS1EFE3N1R5zdNFPgf
	NNcNlTaWrRlOWe647hME0Phvxv2f8ciFUhzvU7/+xagtBLSUYX9SGAXHsdC+XGSKQdz6W9
	2L1IbOujDF1Iha9Z/0xtp/J+TBcfdm3c8YNdhRl/PDr309w3XUSfoSXXyH7FpennB7oFoT
	tuH1QxKCYtIvf/xB64KygsoeEwZ6CSJBw0Uhlkpu3UtcnbvHtYmqX9gV8P0eRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739617000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ZUb6K4zfkbX6C4XqM7g1CGqfPOgQvgwV3At+Nstm0=;
	b=QGgmcruPaVzaRbCvc4w2+i0ha2Pe4DPQGv+jNRZJ6GMraFIclTBiBvDF8VjvhG9XWpezZP
	Xl8OFQw84bjdB3Cw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.302679189@infradead.org>
References: <20250207122546.302679189@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699975.10177.4240954574894192405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2981557cb0408e142480bc1eea30558cf5a2382f
Gitweb:        https://git.kernel.org/tip/2981557cb0408e142480bc1eea30558cf5a2382f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:05 +01:00

x86,kcfi: Fix EXPORT_SYMBOL vs kCFI

The expectation is that all EXPORT'ed symbols are free to have their
address taken and called indirectly. The majority of the assembly
defined functions currently violate this expectation.

Make then all use SYM_TYPED_FUNC_START() in order to emit the proper
kCFI preamble.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.302679189@infradead.org
---
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |  7 ++++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  1 +
 arch/x86/crypto/camellia-x86_64-asm_64.S     |  9 +++++----
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  7 ++++---
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S |  5 +++--
 arch/x86/crypto/twofish-x86_64-asm_64.S      |  5 +++--
 arch/x86/lib/clear_page_64.S                 |  7 ++++---
 arch/x86/lib/copy_page_64.S                  |  3 ++-
 arch/x86/lib/memmove_64.S                    |  3 ++-
 arch/x86/lib/memset_64.S                     |  3 ++-
 arch/x86/lib/msr-reg.S                       |  3 ++-
 11 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index 646477a..1dfef28 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -16,6 +16,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/frame.h>
 
 #define CAMELLIA_TABLE_BYTE_LEN 272
@@ -882,7 +883,7 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 	jmp .Ldec_max24;
 SYM_FUNC_END(__camellia_dec_blk16)
 
-SYM_FUNC_START(camellia_ecb_enc_16way)
+SYM_TYPED_FUNC_START(camellia_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -907,7 +908,7 @@ SYM_FUNC_START(camellia_ecb_enc_16way)
 	RET;
 SYM_FUNC_END(camellia_ecb_enc_16way)
 
-SYM_FUNC_START(camellia_ecb_dec_16way)
+SYM_TYPED_FUNC_START(camellia_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -937,7 +938,7 @@ SYM_FUNC_START(camellia_ecb_dec_16way)
 	RET;
 SYM_FUNC_END(camellia_ecb_dec_16way)
 
-SYM_FUNC_START(camellia_cbc_dec_16way)
+SYM_TYPED_FUNC_START(camellia_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index a0eb94e..b1c9b94 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/frame.h>
 
 #define CAMELLIA_TABLE_BYTE_LEN 272
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 816b6bb..824cb94 100644
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "camellia-x86_64-asm_64.S"
 .text
@@ -177,7 +178,7 @@
 	bswapq				RAB0; \
 	movq RAB0,			4*2(RIO);
 
-SYM_FUNC_START(__camellia_enc_blk)
+SYM_TYPED_FUNC_START(__camellia_enc_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -224,7 +225,7 @@ SYM_FUNC_START(__camellia_enc_blk)
 	RET;
 SYM_FUNC_END(__camellia_enc_blk)
 
-SYM_FUNC_START(camellia_dec_blk)
+SYM_TYPED_FUNC_START(camellia_dec_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -411,7 +412,7 @@ SYM_FUNC_END(camellia_dec_blk)
 		bswapq				RAB1; \
 		movq RAB1,			12*2(RIO);
 
-SYM_FUNC_START(__camellia_enc_blk_2way)
+SYM_TYPED_FUNC_START(__camellia_enc_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -460,7 +461,7 @@ SYM_FUNC_START(__camellia_enc_blk_2way)
 	RET;
 SYM_FUNC_END(__camellia_enc_blk_2way)
 
-SYM_FUNC_START(camellia_dec_blk_2way)
+SYM_TYPED_FUNC_START(camellia_dec_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index 97e2836..84e47f7 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -9,6 +9,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/frame.h>
 #include "glue_helper-asm-avx.S"
 
@@ -656,7 +657,7 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	RET;
 SYM_FUNC_END(__serpent_dec_blk8_avx)
 
-SYM_FUNC_START(serpent_ecb_enc_8way_avx)
+SYM_TYPED_FUNC_START(serpent_ecb_enc_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -674,7 +675,7 @@ SYM_FUNC_START(serpent_ecb_enc_8way_avx)
 	RET;
 SYM_FUNC_END(serpent_ecb_enc_8way_avx)
 
-SYM_FUNC_START(serpent_ecb_dec_8way_avx)
+SYM_TYPED_FUNC_START(serpent_ecb_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -692,7 +693,7 @@ SYM_FUNC_START(serpent_ecb_dec_8way_avx)
 	RET;
 SYM_FUNC_END(serpent_ecb_dec_8way_avx)
 
-SYM_FUNC_START(serpent_cbc_dec_8way_avx)
+SYM_TYPED_FUNC_START(serpent_cbc_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
index d2288bf..071e90e 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "twofish-x86_64-asm-3way.S"
 .text
@@ -220,7 +221,7 @@
 	rorq $32,			RAB2; \
 	outunpack3(mov, RIO, 2, RAB, 2);
 
-SYM_FUNC_START(__twofish_enc_blk_3way)
+SYM_TYPED_FUNC_START(__twofish_enc_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -269,7 +270,7 @@ SYM_FUNC_START(__twofish_enc_blk_3way)
 	RET;
 SYM_FUNC_END(__twofish_enc_blk_3way)
 
-SYM_FUNC_START(twofish_dec_blk_3way)
+SYM_TYPED_FUNC_START(twofish_dec_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64.S b/arch/x86/crypto/twofish-x86_64-asm_64.S
index 775af29..e08b4ba 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64.S
@@ -8,6 +8,7 @@
 .text
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm-offsets.h>
 
 #define a_offset	0
@@ -202,7 +203,7 @@
 	xor	%r8d,		d ## D;\
 	ror	$1,		d ## D;
 
-SYM_FUNC_START(twofish_enc_blk)
+SYM_TYPED_FUNC_START(twofish_enc_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
@@ -255,7 +256,7 @@ SYM_FUNC_START(twofish_enc_blk)
 	RET
 SYM_FUNC_END(twofish_enc_blk)
 
-SYM_FUNC_START(twofish_dec_blk)
+SYM_TYPED_FUNC_START(twofish_dec_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 2760a15..cc5077b 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 
 /*
@@ -14,7 +15,7 @@
  * Zero a page.
  * %rdi	- page
  */
-SYM_FUNC_START(clear_page_rep)
+SYM_TYPED_FUNC_START(clear_page_rep)
 	movl $4096/8,%ecx
 	xorl %eax,%eax
 	rep stosq
@@ -22,7 +23,7 @@ SYM_FUNC_START(clear_page_rep)
 SYM_FUNC_END(clear_page_rep)
 EXPORT_SYMBOL_GPL(clear_page_rep)
 
-SYM_FUNC_START(clear_page_orig)
+SYM_TYPED_FUNC_START(clear_page_orig)
 	xorl   %eax,%eax
 	movl   $4096/64,%ecx
 	.p2align 4
@@ -44,7 +45,7 @@ SYM_FUNC_START(clear_page_orig)
 SYM_FUNC_END(clear_page_orig)
 EXPORT_SYMBOL_GPL(clear_page_orig)
 
-SYM_FUNC_START(clear_page_erms)
+SYM_TYPED_FUNC_START(clear_page_erms)
 	movl $4096,%ecx
 	xorl %eax,%eax
 	rep stosb
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index d6ae793..d8e87fe 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -13,7 +14,7 @@
  * prefetch distance based on SMP/UP.
  */
 	ALIGN
-SYM_FUNC_START(copy_page)
+SYM_TYPED_FUNC_START(copy_page)
 	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
 	movl	$4096/8, %ecx
 	rep	movsq
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 1b60ae8..aa1f92e 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -8,6 +8,7 @@
  */
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -26,7 +27,7 @@
  * Output:
  * rax: dest
  */
-SYM_FUNC_START(__memmove)
+SYM_TYPED_FUNC_START(__memmove)
 
 	mov %rdi, %rax
 
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 0199d56..d66b710 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -28,7 +29,7 @@
  * only for the return value that is the same as the source input,
  * which the compiler could/should do much better anyway.
  */
-SYM_FUNC_START(__memset)
+SYM_TYPED_FUNC_START(__memset)
 	ALTERNATIVE "jmp memset_orig", "", X86_FEATURE_FSRS
 
 	movq %rdi,%r9
diff --git a/arch/x86/lib/msr-reg.S b/arch/x86/lib/msr-reg.S
index ebd259f..5ef8494 100644
--- a/arch/x86/lib/msr-reg.S
+++ b/arch/x86/lib/msr-reg.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <linux/errno.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 #include <asm/msr.h>
 
@@ -12,7 +13,7 @@
  *
  */
 .macro op_safe_regs op
-SYM_FUNC_START(\op\()_safe_regs)
+SYM_TYPED_FUNC_START(\op\()_safe_regs)
 	pushq %rbx
 	pushq %r12
 	movq	%rdi, %r10	/* Save pointer */

