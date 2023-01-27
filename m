Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BBD67ED83
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Jan 2023 19:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjA0S2h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Jan 2023 13:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjA0S2W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Jan 2023 13:28:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453D83240;
        Fri, 27 Jan 2023 10:27:34 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:26:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674844017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LHjZkcJoCoNf2FZj9Z1UyWb4+dkvZrYpqan3ctWzrCY=;
        b=viFJ8oV+gFGDxFxNT+dXGlVJ2rlV3BZlC0syXqx8gPz9ByZwY0u0yYZzEPGbYhqqT9/sfC
        pGnVU7qc5rBicjiF6LWUGb/QoztgDy+IJNh/AESxv6Sh1sU7HsOgGawx+7lsh7YJWEQn7S
        col0ZZ7JR2bB2Cb5DourhuiyzPYuQjdd3zw6N675Q/7KAaVcQrlCh4Pobiyo+6QgqRkO60
        CFShsSa+Q4apCzaAzUy8Xzk1/wmQKhjcDhB5oD5HGY7mln8EySM3QlC6q6D/dTs0w/N9Dt
        U1oPkLl9au+fwuDEuy8csp8mLQKyot99CAXTZciIyYbeyzEj1gNF+WazmRKCvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674844017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LHjZkcJoCoNf2FZj9Z1UyWb4+dkvZrYpqan3ctWzrCY=;
        b=TBulKF8z7CXpNBN893syMl7K8IR/WXb0TDZ99Uvu9Htoo94ZsV6YeK0T95xmxiv+ijS+Ty
        G783R11raGi0nLCg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Refactor __tdx_hypercall() to allow pass down
 more arguments
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167484401684.4906.6620390919066115550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     c30c4b2555ba93b845559a036293fcaf7ffd2b82
Gitweb:        https://git.kernel.org/tip/c30c4b2555ba93b845559a036293fcaf7ffd2b82
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 27 Jan 2023 01:11:55 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Jan 2023 09:42:09 -08:00

x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments

RDI is the first argument to __tdx_hypercall() that used to pass pointer
to struct tdx_hypercall_args. RSI is the second argument that contains
flags, such as TDX_HCALL_HAS_OUTPUT and TDX_HCALL_ISSUE_STI.

RDI and RSI can also be used as arguments to TDVMCALL leafs. Move RDI to
RAX and RSI to RBP to free up them for the hypercall arguments.

RAX saved on stack during TDCALL as it returns status code in the
register.

RBP value has to be restored before returning from __tdx_hypercall() as
it is callee-saved register.

This is preparatory patch. No functional change.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230126221159.8635-4-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdcall.S | 46 ++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 74b108e..a9bb4cb 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -124,19 +124,26 @@ SYM_FUNC_START(__tdx_hypercall)
 	push %r14
 	push %r13
 	push %r12
+	push %rbp
+
+	/* Free RDI and RSI to be used as TDVMCALL arguments */
+	movq %rdi, %rax
+	movq %rsi, %rbp
+
+	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r10(%rax), %r10
+	movq TDX_HYPERCALL_r11(%rax), %r11
+	movq TDX_HYPERCALL_r12(%rax), %r12
+	movq TDX_HYPERCALL_r13(%rax), %r13
+	movq TDX_HYPERCALL_r14(%rax), %r14
+	movq TDX_HYPERCALL_r15(%rax), %r15
+
+	push %rax
 
 	/* Mangle function call ABI into TDCALL ABI: */
 	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
 	xor %eax, %eax
 
-	/* Copy hypercall registers from arg struct: */
-	movq TDX_HYPERCALL_r10(%rdi), %r10
-	movq TDX_HYPERCALL_r11(%rdi), %r11
-	movq TDX_HYPERCALL_r12(%rdi), %r12
-	movq TDX_HYPERCALL_r13(%rdi), %r13
-	movq TDX_HYPERCALL_r14(%rdi), %r14
-	movq TDX_HYPERCALL_r15(%rdi), %r15
-
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
 	/*
@@ -148,7 +155,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	 * HLT operation indefinitely. Since this is the not the desired
 	 * result, conditionally call STI before TDCALL.
 	 */
-	testq $TDX_HCALL_ISSUE_STI, %rsi
+	testq $TDX_HCALL_ISSUE_STI, %rbp
 	jz .Lskip_sti
 	sti
 .Lskip_sti:
@@ -165,20 +172,22 @@ SYM_FUNC_START(__tdx_hypercall)
 	testq %rax, %rax
 	jne .Lpanic
 
-	/* TDVMCALL leaf return code is in R10 */
-	movq %r10, %rax
+	pop %rax
 
 	/* Copy hypercall result registers to arg struct if needed */
-	testq $TDX_HCALL_HAS_OUTPUT, %rsi
+	testq $TDX_HCALL_HAS_OUTPUT, %rbp
 	jz .Lout
 
-	movq %r10, TDX_HYPERCALL_r10(%rdi)
-	movq %r11, TDX_HYPERCALL_r11(%rdi)
-	movq %r12, TDX_HYPERCALL_r12(%rdi)
-	movq %r13, TDX_HYPERCALL_r13(%rdi)
-	movq %r14, TDX_HYPERCALL_r14(%rdi)
-	movq %r15, TDX_HYPERCALL_r15(%rdi)
+	movq %r10, TDX_HYPERCALL_r10(%rax)
+	movq %r11, TDX_HYPERCALL_r11(%rax)
+	movq %r12, TDX_HYPERCALL_r12(%rax)
+	movq %r13, TDX_HYPERCALL_r13(%rax)
+	movq %r14, TDX_HYPERCALL_r14(%rax)
+	movq %r15, TDX_HYPERCALL_r15(%rax)
 .Lout:
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
 	/*
 	 * Zero out registers exposed to the VMM to avoid speculative execution
 	 * with VMM-controlled values. This needs to include all registers
@@ -189,6 +198,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	xor %r11d, %r11d
 
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %rbp
 	pop %r12
 	pop %r13
 	pop %r14
