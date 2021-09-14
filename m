Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22B340B7DA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhINTU6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhINTUw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:52 -0400
Date:   Tue, 14 Sep 2021 19:19:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP9d0+5qRcGfY0UAXaxE+3SlhzKdUD7LHvg2XFfjPK4=;
        b=cncpieVpJVpz4coksiZQNv5e4kC4yX987rC1GgV0F7wnSArLCk4U3/Wpl2uSj9ULobF1uN
        QfH+StFBQnG4fqW4n/JMnf2waMyAz3NIyKBB1iXQwfIPOA3mp70QMsZMLobWg7yyOnuNqr
        Dmn6f24ySNb7FKHG0zFxhkmj25f5JR8PCJhjElXvk/JEaLVkHeVZoRLYYclns+Bf0UvXIB
        pZ0hpRh9hSTDxHSa99QlhvwBe15+641Vg4UUrdijPMEK5f/olC6SR8Px7BwmnjvK5+h+hW
        lr9U6OXfem52YmqSt1d58eGpE3RVivNPHZ18bkqGwF4NJPQ9dvD+3OEPPuPerQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP9d0+5qRcGfY0UAXaxE+3SlhzKdUD7LHvg2XFfjPK4=;
        b=O3FohBN02m/fdfz4ha9j48wiMqbY6MBsj81AQMQnQK4MOQgqEllfzWeoGba8sEwx1G467j
        iRoTkwDpr3AY3iAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/copy_mc: Use EX_TYPE_DEFAULT_MCE_SAFE for exception fixups
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.328706042@linutronix.de>
References: <20210908132525.328706042@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717324.25758.15335402761994077440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c1c97d175493ab32325df81133611ce8e4e05088
Gitweb:        https://git.kernel.org/tip/c1c97d175493ab32325df81133611ce8e4e05088
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 18:11:09 +02:00

x86/copy_mc: Use EX_TYPE_DEFAULT_MCE_SAFE for exception fixups

Nothing in that code uses the trap number which was stored by the exception
fixup which is instantiated via _ASM_EXTABLE_FAULT().

Use _ASM_EXTABLE(... EX_TYPE_DEFAULT_MCE_SAFE) instead which just handles
the IP fixup and the type indicates to the #MC handler that the call site
can handle the abort caused by #MC correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.328706042@linutronix.de
---
 arch/x86/lib/copy_mc_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index e5f77e2..7334055 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -107,9 +107,9 @@ SYM_FUNC_END(copy_mc_fragile)
 
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
-	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
-	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE_TYPE(.L_read_leading_bytes, .E_leading_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_read_words, .E_read_words, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_read_trailing_bytes, .E_trailing_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE(.L_write_words, .E_write_words)
 	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
@@ -149,5 +149,5 @@ SYM_FUNC_END(copy_mc_enhanced_fast_string)
 
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_copy, .E_copy)
+	_ASM_EXTABLE_TYPE(.L_copy, .E_copy, EX_TYPE_DEFAULT_MCE_SAFE)
 #endif /* !CONFIG_UML */
