Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2383656BB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhDTKsT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhDTKrw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:52 -0400
Date:   Tue, 20 Apr 2021 10:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEd+wvhxEkyTbBDSJJNy6UsSkC3j192c8g/aTF1ZLTQ=;
        b=vTYtI2HdmZedlOz1zeOyQ2WZ3VyTrk5N6YfoV3c/UeZcBo91SEKgd1SjuAVhZRMaoeKNGB
        YGXvvLXiOfVFhKZ8EgnY7/sZ1cbJvM1iLEl0UjcVGfepX2HwOHXjXaK6QTS/+XBf8zP3Im
        BQnzlCq17sNkIQso7iGlsfUGXIx7613QArBH4+0GWH8/ALS1vcvcSTwMA1ZWeebJWfYRVX
        GR6v4F+8+/2AQmaKpcyeBm75v3IKqhR27RCVNyUmvpCRZ7pfHAVoQXLdz7FUfnL/Y00Aqo
        L5zWEdiTVQJ6cZzyxsifLwnYg95iOWdlvOXGWCapULYiz6m4Vh6HgD1xF1Z/Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEd+wvhxEkyTbBDSJJNy6UsSkC3j192c8g/aTF1ZLTQ=;
        b=aWgEA6AvvhtMAueEZ/BSGxB0B352FYZbOvi6wHZz90Fsl0vIXyZr/pLuWX1ppUhiJVrLkM
        +/djw7jJ5Lf97DDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/aesni-intel_avx: Fix register usage comments
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8655d4513a0ed1eddec609165064153973010aa2.1614182415.git.jpoimboe@redhat.com>
References: <8655d4513a0ed1eddec609165064153973010aa2.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562414.29796.9900227308617726465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ff5796b6dbea4763fdca002101e32b60aa17f8e8
Gitweb:        https://git.kernel.org/tip/ff5796b6dbea4763fdca002101e32b60aa17f8e8
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:16 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:33 -05:00

x86/crypto/aesni-intel_avx: Fix register usage comments

Fix register usage comments to match reality.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/8655d4513a0ed1eddec609165064153973010aa2.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 4fdf38e..188f184 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -286,7 +286,7 @@ VARIABLE_OFFSET = 16*8
 
 # combined for GCM encrypt and decrypt functions
 # clobbering all xmm registers
-# clobbering r10, r11, r12, r13, r14, r15
+# clobbering r10, r11, r12, r13, r15, rax
 .macro  GCM_ENC_DEC INITIAL_BLOCKS GHASH_8_ENCRYPT_8_PARALLEL GHASH_LAST_8 GHASH_MUL ENC_DEC REP
         vmovdqu AadHash(arg2), %xmm8
         vmovdqu  HashKey(arg2), %xmm13      # xmm13 = HashKey
@@ -988,7 +988,7 @@ _partial_block_done_\@:
 ## num_initial_blocks = b mod 4#
 ## encrypt the initial num_initial_blocks blocks and apply ghash on the ciphertext
 ## r10, r11, r12, rax are clobbered
-## arg1, arg3, arg4, r14 are used as a pointer only, not modified
+## arg1, arg2, arg3, arg4 are used as pointers only, not modified
 
 .macro INITIAL_BLOCKS_AVX REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC
 	i = (8-\num_initial_blocks)
@@ -1223,7 +1223,7 @@ _initial_blocks_done\@:
 
 # encrypt 8 blocks at a time
 # ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg3, arg4 are used as pointers only, not modified
+# arg1, arg2, arg3, arg4 are used as pointers only, not modified
 # r11 is the data offset value
 .macro GHASH_8_ENCRYPT_8_PARALLEL_AVX REP T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
 
@@ -1936,7 +1936,7 @@ SYM_FUNC_END(aesni_gcm_finalize_avx_gen2)
 ## num_initial_blocks = b mod 4#
 ## encrypt the initial num_initial_blocks blocks and apply ghash on the ciphertext
 ## r10, r11, r12, rax are clobbered
-## arg1, arg3, arg4, r14 are used as a pointer only, not modified
+## arg1, arg2, arg3, arg4 are used as pointers only, not modified
 
 .macro INITIAL_BLOCKS_AVX2 REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC VER
 	i = (8-\num_initial_blocks)
@@ -2178,7 +2178,7 @@ _initial_blocks_done\@:
 
 # encrypt 8 blocks at a time
 # ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg3, arg4 are used as pointers only, not modified
+# arg1, arg2, arg3, arg4 are used as pointers only, not modified
 # r11 is the data offset value
 .macro GHASH_8_ENCRYPT_8_PARALLEL_AVX2 REP T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
 
