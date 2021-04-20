Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477AE3656B1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhDTKr7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhDTKrf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:35 -0400
Date:   Tue, 20 Apr 2021 10:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kp5V2hep+LhfTVngb/+OnbjOasBKtp6lxaSlsQ7Mgfg=;
        b=Xv1qH5fmzFVKW3IufTiIg0jSKuv+HVVWsTOb0XlsvBzxEWGztNqQZFwoJIKYASQ4Rw1ldi
        uygIa0d/4lHgG7TZ2EmVkd0Ps7YtjRQnn/eZDF2bspyMPz+8Wok2KaFk33MFKVdqHABaXL
        OLSLQxDZeYL78CuRhzixbJRsNSUFy9IycaSVnacTrI28Gopiami+qE5kv7krrtxsjndzmF
        gb52jIVSWBQiHWePT0As93fPLwxoEDb0/fCqLkUlIC7pFO41cVK/1Ei8nla92iNHSJPsxB
        xP4OBEKnabTW2GDisRqS5pH+02dfQCol6hELOVtJRgMDqVSoVRtwtxEduB6NPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kp5V2hep+LhfTVngb/+OnbjOasBKtp6lxaSlsQ7Mgfg=;
        b=FlJijlPFQo90Ciowmn3W/625gXBppRI7t7Knq6chujv8vzLbDUmciYIZPt+CdboRHctNcC
        iO8athEer7WfqVAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/sha512-ssse3: Standardize stack
 alignment prologue
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6ecaaac9f3828fbb903513bf90c34a08380a8e35.1614182415.git.jpoimboe@redhat.com>
References: <6ecaaac9f3828fbb903513bf90c34a08380a8e35.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562087.29796.17196131429067821021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     27d26793f2105281d9374928448142777cef6f74
Gitweb:        https://git.kernel.org/tip/27d26793f2105281d9374928448142777cef6f74
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:25 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:37 -05:00

x86/crypto/sha512-ssse3: Standardize stack alignment prologue

Use a more standard prologue for saving the stack pointer before
realigning the stack.

This enables ORC unwinding by allowing objtool to understand the stack
realignment.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/6ecaaac9f3828fbb903513bf90c34a08380a8e35.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/sha512-ssse3-asm.S | 41 +++++++++++++----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index 50812af..bd51c90 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -74,14 +74,10 @@ tmp0 =		%rax
 
 W_SIZE = 80*8
 WK_SIZE = 2*8
-RSPSAVE_SIZE = 1*8
-GPRSAVE_SIZE = 5*8
 
 frame_W = 0
 frame_WK = frame_W + W_SIZE
-frame_RSPSAVE = frame_WK + WK_SIZE
-frame_GPRSAVE = frame_RSPSAVE + RSPSAVE_SIZE
-frame_size = frame_GPRSAVE + GPRSAVE_SIZE
+frame_size = frame_WK + WK_SIZE
 
 # Useful QWORD "arrays" for simpler memory references
 # MSG, DIGEST, K_t, W_t are arrays
@@ -283,18 +279,18 @@ SYM_FUNC_START(sha512_transform_ssse3)
 	test msglen, msglen
 	je nowork
 
+	# Save GPRs
+	push	%rbx
+	push	%r12
+	push	%r13
+	push	%r14
+	push	%r15
+
 	# Allocate Stack Space
-	mov	%rsp, %rax
+	push	%rbp
+	mov	%rsp, %rbp
 	sub	$frame_size, %rsp
 	and	$~(0x20 - 1), %rsp
-	mov	%rax, frame_RSPSAVE(%rsp)
-
-	# Save GPRs
-	mov	%rbx, frame_GPRSAVE(%rsp)
-	mov	%r12, frame_GPRSAVE +8*1(%rsp)
-	mov	%r13, frame_GPRSAVE +8*2(%rsp)
-	mov	%r14, frame_GPRSAVE +8*3(%rsp)
-	mov	%r15, frame_GPRSAVE +8*4(%rsp)
 
 updateblock:
 
@@ -355,15 +351,16 @@ updateblock:
 	dec	msglen
 	jnz	updateblock
 
-	# Restore GPRs
-	mov	frame_GPRSAVE(%rsp),      %rbx
-	mov	frame_GPRSAVE +8*1(%rsp), %r12
-	mov	frame_GPRSAVE +8*2(%rsp), %r13
-	mov	frame_GPRSAVE +8*3(%rsp), %r14
-	mov	frame_GPRSAVE +8*4(%rsp), %r15
-
 	# Restore Stack Pointer
-	mov	frame_RSPSAVE(%rsp), %rsp
+	mov	%rbp, %rsp
+	pop	%rbp
+
+	# Restore GPRs
+	pop	%r15
+	pop	%r14
+	pop	%r13
+	pop	%r12
+	pop	%rbx
 
 nowork:
 	ret
