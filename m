Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94C73656B0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhDTKr6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhDTKrf (ORCPT
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
        bh=IZS+3FkB+6pa93yvc0GqsDxGzH2GKOmh1cvl6nPOYag=;
        b=1HlupDm6AGbz2uxLwVSDo/iq0h4jRH13474R4t3gUmUyYqLa0ajJ90cfPEkjgSwbo+RqN1
        gy38+KEQNHFI93i8tQ4Ikn+7GEBKYgTkhpyRSCfbeE0sn+9HBb/317pxgPm5kguhfNqen1
        4QyjTMrmd/JONcPLsETANJWYh6hGDXXN5nhukndhdla1ZkZafic00DHDZTIgIlPBT8C6zl
        ZkEIxMdUQP2EEjX9GC6aGlhall07QpqmfJjeatdz4g0tVLLfmw06E+04lxeSLfWw5wSg7c
        45H0Us36qYElYxi/1XnCT/I7lqa4XxrM2uLzuMjeVGpurx9ne9ndosh+gFuGDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZS+3FkB+6pa93yvc0GqsDxGzH2GKOmh1cvl6nPOYag=;
        b=sWhiRClr8AfGncaFEjLxMitDLPbrMdLLctdshc8dCEhgrLGhZgZ47sbMr7ktXP5V56Ysl+
        r3PcPcsNhAyALbBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/sha256-avx2: Standardize stack
 alignment prologue
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8048e7444c49a8137f05265262b83dc50f8fb7f3.1614182415.git.jpoimboe@redhat.com>
References: <8048e7444c49a8137f05265262b83dc50f8fb7f3.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562196.29796.14555229104622243282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ce5846668076aa76a17ab559f0296374e3611fec
Gitweb:        https://git.kernel.org/tip/ce5846668076aa76a17ab559f0296374e3611fec
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:22 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:36 -05:00

x86/crypto/sha256-avx2: Standardize stack alignment prologue

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
Link: https://lore.kernel.org/r/8048e7444c49a8137f05265262b83dc50f8fb7f3.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/sha256-avx2-asm.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 11ff60c..4087f74 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -117,15 +117,13 @@ _XMM_SAVE_SIZE	= 0
 _INP_END_SIZE	= 8
 _INP_SIZE	= 8
 _CTX_SIZE	= 8
-_RSP_SIZE	= 8
 
 _XFER		= 0
 _XMM_SAVE	= _XFER     + _XFER_SIZE
 _INP_END	= _XMM_SAVE + _XMM_SAVE_SIZE
 _INP		= _INP_END  + _INP_END_SIZE
 _CTX		= _INP      + _INP_SIZE
-_RSP		= _CTX      + _CTX_SIZE
-STACK_SIZE	= _RSP      + _RSP_SIZE
+STACK_SIZE	= _CTX      + _CTX_SIZE
 
 # rotate_Xs
 # Rotate values of symbols X0...X3
@@ -533,11 +531,11 @@ SYM_FUNC_START(sha256_transform_rorx)
 	pushq	%r14
 	pushq	%r15
 
-	mov	%rsp, %rax
+	push	%rbp
+	mov	%rsp, %rbp
+
 	subq	$STACK_SIZE, %rsp
 	and	$-32, %rsp	# align rsp to 32 byte boundary
-	mov	%rax, _RSP(%rsp)
-
 
 	shl	$6, NUM_BLKS	# convert to bytes
 	jz	done_hash
@@ -704,7 +702,8 @@ only_one_block:
 
 done_hash:
 
-	mov	_RSP(%rsp), %rsp
+	mov	%rbp, %rsp
+	pop	%rbp
 
 	popq	%r15
 	popq	%r14
