Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505253656B8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhDTKsQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhDTKrv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D7C061346;
        Tue, 20 Apr 2021 03:47:05 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UugSVNX0e8jJ4jT/12zpWDdPmS/9Gl6S2nC8uNTAOqk=;
        b=bNXyQlqNhXzTKB5TA8Ku6bY3Mjzs/39bS93AOdIPuiItZg0zQSJyXAHULNG1Nnti/fSLOM
        YrLqbk2zodTm9JayLVC0WgLDohEkPa/yqQYbeqCrJZlJYD+Aua83GEgYi3wSA/A1ifjKgj
        MEaXBMOPlT2OMcgQ7vQky3/VgJ1cG4ozKvuN6z6Kg+t0VnxLrfk3GeIBXiXmcQWriQQOlX
        3LrxOc5+VEtRCztpiDuMH/KBfG5vm0gwkn92547c0+inhtPcOTGK3ZolumNxvgyhPD1hKW
        G0iQlVCRwc1E9k1J96v7Sy+KKR2YOb1KvWvnnDnmXoAPT3jTJ8mmJwOwZZHylA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UugSVNX0e8jJ4jT/12zpWDdPmS/9Gl6S2nC8uNTAOqk=;
        b=J/jO3SmeMsl6EqGYuQR3S3CiyXlHeUbGZdUB/ElDUsGMHxx9aErMTC6zWl7xPTm39kSYsu
        xMwjrTSx34vSldDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/sha_ni: Standardize stack alignment prologue
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5033e1a79867dff1b18e1b4d0783c38897d3f223.1614182415.git.jpoimboe@redhat.com>
References: <5033e1a79867dff1b18e1b4d0783c38897d3f223.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562266.29796.10383658274850231155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     35a0067d2c02a7c35466db5f207b7b9265de84d9
Gitweb:        https://git.kernel.org/tip/35a0067d2c02a7c35466db5f207b7b9265de84d9
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:20 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:35 -05:00

x86/crypto/sha_ni: Standardize stack alignment prologue

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
Link: https://lore.kernel.org/r/5033e1a79867dff1b18e1b4d0783c38897d3f223.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/sha1_ni_asm.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/sha1_ni_asm.S b/arch/x86/crypto/sha1_ni_asm.S
index 11efe3a..5d8415f 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -59,8 +59,6 @@
 #define DATA_PTR	%rsi	/* 2nd arg */
 #define NUM_BLKS	%rdx	/* 3rd arg */
 
-#define RSPSAVE		%rax
-
 /* gcc conversion */
 #define FRAME_SIZE	32	/* space for 2x16 bytes */
 
@@ -96,7 +94,8 @@
 .text
 .align 32
 SYM_FUNC_START(sha1_ni_transform)
-	mov		%rsp, RSPSAVE
+	push		%rbp
+	mov		%rsp, %rbp
 	sub		$FRAME_SIZE, %rsp
 	and		$~0xF, %rsp
 
@@ -288,7 +287,8 @@ SYM_FUNC_START(sha1_ni_transform)
 	pextrd		$3, E0, 1*16(DIGEST_PTR)
 
 .Ldone_hash:
-	mov		RSPSAVE, %rsp
+	mov		%rbp, %rsp
+	pop		%rbp
 
 	ret
 SYM_FUNC_END(sha1_ni_transform)
