Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7A2CBF44
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 15:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgLBOM4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 09:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgLBOMo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 09:12:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935EC0617A6;
        Wed,  2 Dec 2020 06:12:04 -0800 (PST)
Date:   Wed, 02 Dec 2020 14:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qC7331buLxO2vuFkwsGtrm4GufkgOH2IAuIR+dyHZZA=;
        b=FuWLRRpanDCpzGmhuHan+9bNS71AOOvnFAy4Rvsc4/CQsz4+9UeKDO3nwaWetjX4+9xmaC
        aPoLYWOxoBUu3OaMA1/b3cX2REDIC53ibyE7rqjl4m1ZsScptLV/mxucXC5ViX3aRYwPbx
        8aNsDJBX71XIXq/6pIXvHtY7phMymUdivetpZJZKBdJmMSt/UoGwwluc6GCsa5CB9Bv2+U
        X8i81PEgG+JgI7Bt0wQzg0j77l57SrI6/JukibRstTUoKBYta1c5uF90GEq7nscgAjXpF8
        F55YELdgBGiNAOu7AAiPpH2zXlcMhLy1GFaGDhjtfsnRIUpkRIkBBAhJpIMXLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qC7331buLxO2vuFkwsGtrm4GufkgOH2IAuIR+dyHZZA=;
        b=a7/ssSutxMSsxjaRzQ2h/yyX+6/xZBfKA7YNDTGOeKKo63DPRUuJeLBJ86KZ3VJw7zM76w
        AmOhQj1VlzFnzrBg==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Rename enter_from_user_mode()
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201201142755.31931-2-svens@linux.ibm.com>
References: <20201201142755.31931-2-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <160691832237.3364.17734338910542289465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     6666bb714fb3bc7b2e8be72b9c92f2d8a89ea2dc
Gitweb:        https://git.kernel.org/tip/6666bb714fb3bc7b2e8be72b9c92f2d8a89ea2dc
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 15:07:57 +01:00

entry: Rename enter_from_user_mode()

In order to make this function publicly available rename it so it can still
be inlined. An additional enter_from_user_mode() function will be added with
a later commit.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201201142755.31931-2-svens@linux.ibm.com

---
 kernel/entry/common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e661e70..8e294a7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,7 +11,7 @@
 #include <trace/events/syscalls.h>
 
 /**
- * enter_from_user_mode - Establish state when coming from user mode
+ * __enter_from_user_mode - Establish state when coming from user mode
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -20,7 +20,7 @@
  * 2) Invoke context tracking if enabled to reactivate RCU
  * 3) Trace interrupts off state
  */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
 	arch_check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -103,7 +103,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	long ret;
 
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -115,7 +115,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
@@ -304,7 +304,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
