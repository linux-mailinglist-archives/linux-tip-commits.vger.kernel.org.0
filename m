Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD493656C3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhDTKsh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhDTKsN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:48:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B23C06138D;
        Tue, 20 Apr 2021 03:47:21 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VJMoMpM+tcqCpfsVlqnaTo2QaPtCB8+Cy00uCz0vak=;
        b=JxR8WNGaIL9s3rqZO9V39iJarTJ2WgY30JLkRXzQsNnlLNu9U/O77qVpxPUxoSq7B1lzOT
        xgHZZfeFpDewLyeewSmP2f8CAfnjOZEr1nfGTbSOU6CCFoWHGFLDJgg1lNoRbkPwN6Vypk
        sHS/cMxPXFw17B9q0NV8iSdZL5cDIGj/oSHtZSczOweuVKrqMXXMuZo8Zm6TPBYKXM8yMZ
        TnsknaR6WGgWS6hmeGssVwEsBpfuj2tM2RKkEKpjeMiDYmD58AxTrxv2/XUKufo6UuxVnM
        /1G83Hn7AnSC22Pikz5+8cqbZAb/g8CpuT5LxHGEAhBp9cIq4Jbyv1Hy/NPYmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VJMoMpM+tcqCpfsVlqnaTo2QaPtCB8+Cy00uCz0vak=;
        b=7FA9EMbE0WBsbRgUepUwNY4d9ccOfPcw88aGgthc6ldJ7ONlrYJcxWgu8L1Mknad+JWwlx
        pAsWym2wskBnJ2Cw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/aesni-intel_avx: Standardize stack
 alignment prologue
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <02d00a0903a0959f4787e186e2a07d271e1f63d4.1614182415.git.jpoimboe@redhat.com>
References: <02d00a0903a0959f4787e186e2a07d271e1f63d4.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562376.29796.433962525526224746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e163be86fff3deec70f63330fc43fedf892c9aee
Gitweb:        https://git.kernel.org/tip/e163be86fff3deec70f63330fc43fedf892c9aee
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:17 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:34 -05:00

x86/crypto/aesni-intel_avx: Standardize stack alignment prologue

Use RBP instead of R14 for saving the old stack pointer before
realignment.  This resembles what compilers normally do.

This enables ORC unwinding by allowing objtool to understand the stack
realignment.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/02d00a0903a0959f4787e186e2a07d271e1f63d4.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 188f184..98e3552 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -251,22 +251,20 @@ VARIABLE_OFFSET = 16*8
 .macro FUNC_SAVE
         push    %r12
         push    %r13
-        push    %r14
         push    %r15
 
-        mov     %rsp, %r14
-
-
+	push	%rbp
+	mov	%rsp, %rbp
 
         sub     $VARIABLE_OFFSET, %rsp
         and     $~63, %rsp                    # align rsp to 64 bytes
 .endm
 
 .macro FUNC_RESTORE
-        mov     %r14, %rsp
+        mov     %rbp, %rsp
+	pop	%rbp
 
         pop     %r15
-        pop     %r14
         pop     %r13
         pop     %r12
 .endm
