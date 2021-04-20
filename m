Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF13656B5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhDTKsK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhDTKrl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FDC06138E;
        Tue, 20 Apr 2021 03:47:03 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNddzE7f8TP58z9AOkT4CgesAzn10us0+0hwf51XbxY=;
        b=Ny4IuHFAMesI8wlYQ/9izOfASOWAAP4gemHHYb9IzlaZtLqRUWD+EP+am8wI/ibfP2BiaH
        fS5Wj6gtLS2553BczLlpgoxfqfTvxket9MlkfQq7pGE93a2eq7jL9mPYf7Nw0EADmknHdE
        w40vCDZPNTibbFtrgvvZy+sZpyXwAIe3OyKuhegZB9ArCoN3Cwa/6Dh+JoFtBzQS9uTg0G
        3UbYOn55qrfNNRyAzIxH2Q6H5trdLaP2wl+xhwERmSokc0cqv5xTd/U001PSb5ewoJ+cTY
        viZtkl11ho5v16GsdiozGe0bWpcCwtq/HdyyjUlSN1n0tVsybg0FvWbojevEaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNddzE7f8TP58z9AOkT4CgesAzn10us0+0hwf51XbxY=;
        b=PP3clELmfIjBKSkMJ35cHApvyrXdjcZkBo96z2SL5RZZ50sCAVSdNF+VgZIBpM0YVaQ3s6
        Fnt68u5jgMceleDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/sha512-avx2: Standardize stack
 alignment prologue
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b1a7b29fcfc65d60a3b6e77ef75f4762a5b8488d.1614182415.git.jpoimboe@redhat.com>
References: <b1a7b29fcfc65d60a3b6e77ef75f4762a5b8488d.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562124.29796.4031755393590167497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ec063e090bd6487097d459bb4272508b78448270
Gitweb:        https://git.kernel.org/tip/ec063e090bd6487097d459bb4272508b78448270
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:24 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:36 -05:00

x86/crypto/sha512-avx2: Standardize stack alignment prologue

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
Link: https://lore.kernel.org/r/b1a7b29fcfc65d60a3b6e77ef75f4762a5b8488d.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/sha512-avx2-asm.S | 42 ++++++++++++++----------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index 3a44bdc..072cb0f 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -102,17 +102,13 @@ SRND_SIZE = 1*8
 INP_SIZE = 1*8
 INPEND_SIZE = 1*8
 CTX_SIZE = 1*8
-RSPSAVE_SIZE = 1*8
-GPRSAVE_SIZE = 5*8
 
 frame_XFER = 0
 frame_SRND = frame_XFER + XFER_SIZE
 frame_INP = frame_SRND + SRND_SIZE
 frame_INPEND = frame_INP + INP_SIZE
 frame_CTX = frame_INPEND + INPEND_SIZE
-frame_RSPSAVE = frame_CTX + CTX_SIZE
-frame_GPRSAVE = frame_RSPSAVE + RSPSAVE_SIZE
-frame_size = frame_GPRSAVE + GPRSAVE_SIZE
+frame_size = frame_CTX + CTX_SIZE
 
 ## assume buffers not aligned
 #define	VMOVDQ vmovdqu
@@ -570,18 +566,18 @@ frame_size = frame_GPRSAVE + GPRSAVE_SIZE
 # "blocks" is the message length in SHA512 blocks
 ########################################################################
 SYM_FUNC_START(sha512_transform_rorx)
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
-	mov	%rbx, 8*0+frame_GPRSAVE(%rsp)
-	mov	%r12, 8*1+frame_GPRSAVE(%rsp)
-	mov	%r13, 8*2+frame_GPRSAVE(%rsp)
-	mov	%r14, 8*3+frame_GPRSAVE(%rsp)
-	mov	%r15, 8*4+frame_GPRSAVE(%rsp)
 
 	shl	$7, NUM_BLKS	# convert to bytes
 	jz	done_hash
@@ -672,15 +668,17 @@ loop2:
 
 done_hash:
 
-# Restore GPRs
-	mov	8*0+frame_GPRSAVE(%rsp), %rbx
-	mov	8*1+frame_GPRSAVE(%rsp), %r12
-	mov	8*2+frame_GPRSAVE(%rsp), %r13
-	mov	8*3+frame_GPRSAVE(%rsp), %r14
-	mov	8*4+frame_GPRSAVE(%rsp), %r15
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
+
 	ret
 SYM_FUNC_END(sha512_transform_rorx)
 
