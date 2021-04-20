Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7783656AA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhDTKrx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51934 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhDTKrf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:35 -0400
Date:   Tue, 20 Apr 2021 10:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvBBwsq97L47Ij7pS3U5OD1w6yPWaeW1ScpID7pzphY=;
        b=Y4M4MmTRK/2GRtqe3W94j0iUVwATPdyibrzQ4R3AQHcMNaMqZYsuyvv+Ua7qzDFX8B5SO1
        gNXTwhb9VVey3N/Td9QMYTuvcNgxlKGZHQ3jZPZkt6QXTZagd4DNC+XYCRHQ3fp2Cr88CW
        gKT2+gOQKLRB88L+C/KO55IBUu16PtrFGq0cpZNAqIXQ5RF5sx3y6CczCiVYzaj47yGfdH
        C1bYvolLjZmU4I6WJBpGNZAnoasC6ATN+952CFZVEWYV9WMEfAP9kRWeP+owazBU6IBQ3A
        IpDQDRneynS968KumQWPGiecx+X9zEVAdkDaraE4flKodQ0fQI4uAxnkcRzw/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvBBwsq97L47Ij7pS3U5OD1w6yPWaeW1ScpID7pzphY=;
        b=DNPfv75DM2wlpP9qTMgzVjNXcq1h2oKZWSNs6bydLL3Iu03fq312/+JHtMYdHLe7eoSoMH
        RMgZM1gA6UlYrECQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/sha512-avx: Standardize stack
 alignment prologue
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d36e9ea1c819d87fa89b3df3fa83e2a1ede18146.1614182415.git.jpoimboe@redhat.com>
References: <d36e9ea1c819d87fa89b3df3fa83e2a1ede18146.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562162.29796.15770288491054509558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d61684b56edf369f0a6d388088d7c9d59f1618d4
Gitweb:        https://git.kernel.org/tip/d61684b56edf369f0a6d388088d7c9d59f1618d4
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:23 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:36 -05:00

x86/crypto/sha512-avx: Standardize stack alignment prologue

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
Link: https://lore.kernel.org/r/d36e9ea1c819d87fa89b3df3fa83e2a1ede18146.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/sha512-avx-asm.S | 41 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index 684d58c..3d8f0fd 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -76,14 +76,10 @@ tmp0	= %rax
 W_SIZE = 80*8
 # W[t] + K[t] | W[t+1] + K[t+1]
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
@@ -281,18 +277,18 @@ SYM_FUNC_START(sha512_transform_avx)
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
 	sub     $frame_size, %rsp
 	and	$~(0x20 - 1), %rsp
-	mov	%rax, frame_RSPSAVE(%rsp)
-
-	# Save GPRs
-	mov     %rbx, frame_GPRSAVE(%rsp)
-	mov     %r12, frame_GPRSAVE +8*1(%rsp)
-	mov     %r13, frame_GPRSAVE +8*2(%rsp)
-	mov     %r14, frame_GPRSAVE +8*3(%rsp)
-	mov     %r15, frame_GPRSAVE +8*4(%rsp)
 
 updateblock:
 
@@ -353,15 +349,16 @@ updateblock:
 	dec     msglen
 	jnz     updateblock
 
-	# Restore GPRs
-	mov     frame_GPRSAVE(%rsp),      %rbx
-	mov     frame_GPRSAVE +8*1(%rsp), %r12
-	mov     frame_GPRSAVE +8*2(%rsp), %r13
-	mov     frame_GPRSAVE +8*3(%rsp), %r14
-	mov     frame_GPRSAVE +8*4(%rsp), %r15
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
