Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D96A3656AD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDTKr4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhDTKrf (ORCPT
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
        bh=NwEWzx19HtD0syXcbjLK7My5zSzcjxvg7rspYx+xgHI=;
        b=bUcv+RF/HjCY6tfNwmmmdwgX+rNY2nVEgLZ0RMcWPDtSbyAp/r8OkV7m7T81aOBmpsChJM
        8Y3prcZc0b7aYHdFFlGR5yQAPepuEcIzhVomMX1VENsNnr+RFbNjyaPsjJN3r7cOb+6wVC
        Kec0xGXRu/PtAGsUheNZjJaFfAsAtNBw1IyCvM6q+LigsAf1pzfo186eZM6vkXt9+ZVY9V
        CZ+Z4DfSWfXd6uFbrhAF7+28EjU+EMGTI+CfJyxaa+kyZBjhU64qJaLL6sAZh3komS8Dgx
        wgpTjtUtAH59TuW8ZDDhnrIl47BGXf6QYI7mE4e84JoWi05XR9YKwRn68oTrqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwEWzx19HtD0syXcbjLK7My5zSzcjxvg7rspYx+xgHI=;
        b=k0Fv7k4MCksvvESSwDJrwzahDBsqaRDJQaPUhh18gTokYohVT9YgwpyFHfKTfsg0/5k2Pd
        2U5cLodqrkoIkLDg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto: Enable objtool in crypto code
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <fc2a1918c50e33e46ef0e9a5de02743f2f6e3639.1614182415.git.jpoimboe@redhat.com>
References: <fc2a1918c50e33e46ef0e9a5de02743f2f6e3639.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562049.29796.11187705685175975180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     7d3d10e0e85fb7c23a86a70f795b1eabd2bc030b
Gitweb:        https://git.kernel.org/tip/7d3d10e0e85fb7c23a86a70f795b1eabd2bc030b
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:26 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:37 -05:00

x86/crypto: Enable objtool in crypto code

Now that all the stack alignment prologues have been cleaned up in the
crypto code, enable objtool.  Among other benefits, this will allow ORC
unwinding to work.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/fc2a1918c50e33e46ef0e9a5de02743f2f6e3639.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index b28e36b..d0959e7 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -2,8 +2,6 @@
 #
 # x86 crypto algorithms
 
-OBJECT_FILES_NON_STANDARD := y
-
 obj-$(CONFIG_CRYPTO_TWOFISH_586) += twofish-i586.o
 twofish-i586-y := twofish-i586-asm_32.o twofish_glue.o
 obj-$(CONFIG_CRYPTO_TWOFISH_X86_64) += twofish-x86_64.o
