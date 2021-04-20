Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F195D3656AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhDTKr6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhDTKrf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:35 -0400
Date:   Tue, 20 Apr 2021 10:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sToYEa7Wi9ew13TvKs+4LNfj+3pBZ3KSDf8hAHMAWp0=;
        b=s0RO1i1lEf4kZPXHvDwzXsxTl3F2G937Z6LMV8kTjf6xX8CY5G6nxfWuT45lsNd6g/w7N/
        2c6KaW+LJnlzNk+yx0R1dlhOAiTXJ0e9bp5B4uzwWw+VK+38nrnUcgXwGyKRlShJh2Jn3e
        QwRzY+Oe0upyEFU/ba8sVYx+b6lkQjJ/d3V2v5MgXdpmdsFkcBDGYpv+7QyE1u5rRvTUcE
        ggzWP6aPpSxA0mvLYdsWO+/3NGXGESNUC1Z2Xkst4PfilSQAwENWe1zVoCjQIW9VxvMGTc
        s5Vf4VA7fsyiTOEUiZjta6HWHdcFDHMQA4PFmzbX39ELIOHFx2Zrp2UciVZLTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sToYEa7Wi9ew13TvKs+4LNfj+3pBZ3KSDf8hAHMAWp0=;
        b=/AuFiDaD/iPogVAWgY7KJg4GX1JBgmZd5o0cCOlg5YmUBOz2k4FCG6Gswbbhvf9oJFcQir
        LJS2D9ZMB76JuECA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/sha1_avx2: Standardize stack alignment
 prologue
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <fdaaf8670ed1f52f55ba9a6bbac98c1afddc1af6.1614182415.git.jpoimboe@redhat.com>
References: <fdaaf8670ed1f52f55ba9a6bbac98c1afddc1af6.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562230.29796.6626679200764483556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     20114c899cafa8313534a841cab0ab1f7ab09672
Gitweb:        https://git.kernel.org/tip/20114c899cafa8313534a841cab0ab1f7ab09672
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:21 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:35 -05:00

x86/crypto/sha1_avx2: Standardize stack alignment prologue

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
Link: https://lore.kernel.org/r/fdaaf8670ed1f52f55ba9a6bbac98c1afddc1af6.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/sha1_avx2_x86_64_asm.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
index 1e594d6..5eed620 100644
--- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
+++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
@@ -645,9 +645,9 @@ _loop3:
 	RESERVE_STACK  = (W_SIZE*4 + 8+24)
 
 	/* Align stack */
-	mov	%rsp, %rbx
+	push	%rbp
+	mov	%rsp, %rbp
 	and	$~(0x20-1), %rsp
-	push	%rbx
 	sub	$RESERVE_STACK, %rsp
 
 	avx2_zeroupper
@@ -665,8 +665,8 @@ _loop3:
 
 	avx2_zeroupper
 
-	add	$RESERVE_STACK, %rsp
-	pop	%rsp
+	mov	%rbp, %rsp
+	pop	%rbp
 
 	pop	%r15
 	pop	%r14
