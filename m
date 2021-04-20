Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7E3656B2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhDTKsA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52044 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhDTKri (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:38 -0400
Date:   Tue, 20 Apr 2021 10:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPJrxA+ZG2bWHgWSKvKZqwD3vozoq2KRih2R2H7OiNs=;
        b=pLc42bV+6M1HpGpZlZSEAEnc/utYdWm0NDjLfnuAzQigxqOpzeV4VEhiJxTl3IErFOh7Fd
        ZoDBVdzsscU+N1gmJC9+xK+PCMapj43MZjm8hUVXaDhw6whNYeBxa6DUrKNr88HXRQnIqQ
        K/cuKFmBAH+QpUoUy7O0vSfotyFb2FhZNOvc2Vs1sWmagkrmzv2JnsSwwtsYvw6QUc43ku
        brR6e1QksSc4sdD+NmwOu2LvfgtEpKLmc3u7CHGj48Na/5avVwjoDXd76cvfJvHahnmT9o
        wV55BnkC2IuwWNs8D22HnNWMPCwos6O+NxicWW7iUeYJEgJJxwUqhIVZSrmqeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPJrxA+ZG2bWHgWSKvKZqwD3vozoq2KRih2R2H7OiNs=;
        b=VidWT83a9LSmI/NkSWfHWM1lKG/CjuW11Jr+2+X0c/o+3WhvtKCTLL5P9liiMCZwxqcYp3
        x8+5M8KyTObUAeAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/camellia-aesni-avx2: Unconditionally
 allocate stack buffer
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <85ac96613ee5784b6239c18d3f68b1f3c509caa3.1614182415.git.jpoimboe@redhat.com>
References: <85ac96613ee5784b6239c18d3f68b1f3c509caa3.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562341.29796.17081283860565906101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     dabe5167a3cbb4bf16b20c0e5b6497513e2e3a08
Gitweb:        https://git.kernel.org/tip/dabe5167a3cbb4bf16b20c0e5b6497513e2e3a08
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:18 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:34 -05:00

x86/crypto/camellia-aesni-avx2: Unconditionally allocate stack buffer

A conditional stack allocation violates traditional unwinding
requirements when a single instruction can have differing stack layouts.

There's no benefit in allocating the stack buffer conditionally.  Just
do it unconditionally.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/85ac96613ee5784b6239c18d3f68b1f3c509caa3.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 782e971..706f708 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -990,6 +990,7 @@ SYM_FUNC_START(camellia_cbc_dec_32way)
 	 *	%rdx: src (32 blocks)
 	 */
 	FRAME_BEGIN
+	subq $(16 * 32), %rsp;
 
 	vzeroupper;
 
@@ -1002,7 +1003,6 @@ SYM_FUNC_START(camellia_cbc_dec_32way)
 		     %ymm8, %ymm9, %ymm10, %ymm11, %ymm12, %ymm13, %ymm14,
 		     %ymm15, %rdx, (key_table)(CTX, %r8, 8));
 
-	movq %rsp, %r10;
 	cmpq %rsi, %rdx;
 	je .Lcbc_dec_use_stack;
 
@@ -1015,7 +1015,6 @@ SYM_FUNC_START(camellia_cbc_dec_32way)
 	 * dst still in-use (because dst == src), so use stack for temporary
 	 * storage.
 	 */
-	subq $(16 * 32), %rsp;
 	movq %rsp, %rax;
 
 .Lcbc_dec_continue:
@@ -1025,7 +1024,6 @@ SYM_FUNC_START(camellia_cbc_dec_32way)
 	vpxor %ymm7, %ymm7, %ymm7;
 	vinserti128 $1, (%rdx), %ymm7, %ymm7;
 	vpxor (%rax), %ymm7, %ymm7;
-	movq %r10, %rsp;
 	vpxor (0 * 32 + 16)(%rdx), %ymm6, %ymm6;
 	vpxor (1 * 32 + 16)(%rdx), %ymm5, %ymm5;
 	vpxor (2 * 32 + 16)(%rdx), %ymm4, %ymm4;
@@ -1047,6 +1045,7 @@ SYM_FUNC_START(camellia_cbc_dec_32way)
 
 	vzeroupper;
 
+	addq $(16 * 32), %rsp;
 	FRAME_END
 	ret;
 SYM_FUNC_END(camellia_cbc_dec_32way)
