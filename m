Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC343656C2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhDTKsh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhDTKsN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:48:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63881C061350;
        Tue, 20 Apr 2021 03:47:22 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFfsflKolEP0bDTPqRJYoQI46pKWz6mBpw+Y1JQviBY=;
        b=VZ3YQZsbRQy2NrZ7P03UrIQlDMB3aiU8vx58sllZCExzAKMvg51E0iPz1OIkbvyhBOfr+l
        /b5lx7+roLM4uuDP8BV8NShT4mSw5L/TBYl6yflbQ+9dVwuKw2+YfuDIIENSfFEwnc+412
        v8HHsbsvS2FIJNjyAfUWjaoPpg2QqClSVfV++ib2KKPLfSE7m7X9nAhnHaFy5WBs9JNAdH
        kqcsHeVUecNWbKQeAcdPbeO8MqsZYq7bf33tywUDiV8KMs688zVSXzC9XZSSezTMSdTDuZ
        OungVE6sjpOsJDK90B9D4/cS0maOPd6dngBpuPaDBWQ56FkVKvNKibtRksGuCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFfsflKolEP0bDTPqRJYoQI46pKWz6mBpw+Y1JQviBY=;
        b=rkWF86MF1vgHbjGZfz5YtukwjPdt6D4FLJatKIz/XCpPEHqSGziZdTFkBCkqU0rvPTHXJI
        WBBgVx9f0l2G3RBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/aesni-intel_avx: Remove unused macros
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <53f7136ea93ebdbca399959e6d2991ecb46e733e.1614182415.git.jpoimboe@redhat.com>
References: <53f7136ea93ebdbca399959e6d2991ecb46e733e.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562455.29796.16754842652682605483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4f08300916e882a0c34a2f325ff3fea2be2e57b3
Gitweb:        https://git.kernel.org/tip/4f08300916e882a0c34a2f325ff3fea2be2e57b3
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:15 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:33 -05:00

x86/crypto/aesni-intel_avx: Remove unused macros

These macros are no longer used; remove them.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/53f7136ea93ebdbca399959e6d2991ecb46e733e.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 2cf8e94..4fdf38e 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -212,10 +212,6 @@ HashKey_8_k    = 16*21   # store XOR of HashKey^8 <<1 mod poly here (for Karatsu
 #define arg4 %rcx
 #define arg5 %r8
 #define arg6 %r9
-#define arg7 STACK_OFFSET+8*1(%r14)
-#define arg8 STACK_OFFSET+8*2(%r14)
-#define arg9 STACK_OFFSET+8*3(%r14)
-#define arg10 STACK_OFFSET+8*4(%r14)
 #define keysize 2*15*16(arg1)
 
 i = 0
@@ -237,9 +233,6 @@ define_reg j %j
 .noaltmacro
 .endm
 
-# need to push 4 registers into stack to maintain
-STACK_OFFSET = 8*4
-
 TMP1 =   16*0    # Temporary storage for AAD
 TMP2 =   16*1    # Temporary storage for AES State 2 (State 1 is stored in an XMM register)
 TMP3 =   16*2    # Temporary storage for AES State 3
@@ -256,7 +249,6 @@ VARIABLE_OFFSET = 16*8
 ################################
 
 .macro FUNC_SAVE
-        #the number of pushes must equal STACK_OFFSET
         push    %r12
         push    %r13
         push    %r14
