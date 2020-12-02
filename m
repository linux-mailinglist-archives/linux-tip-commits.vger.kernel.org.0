Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC262CB917
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbgLBJjM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbgLBJjJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D6C0613D4;
        Wed,  2 Dec 2020 01:38:29 -0800 (PST)
Date:   Wed, 02 Dec 2020 09:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAuxjYBKISItdRCewIBg69/sL7aoxkOickZXDOHQkSY=;
        b=YncyvtwUvdZ3K2WWp+R0Frp69LqPFhiysemU+mj9DiTpcAI2Ted6JoKoBqPlz5CxIny809
        UyLYmNwNykAcnzOJitwuwMYzR4Gqh+j+lgoJw1T0JPpw+H3ZLAIQQgjid7WeSpleXAlIHP
        +tdMWugMzfpo3WIDBNvynIZy6DhsY6t5Ihy7QUFf8KwIf0IutkRSGTC0a/OewB31qv0hVo
        mM3G/T5qXoOMhRAWnGPjYX5QPtyUH0LTHBJFwiMblyxI4SlHfZxUgYsRtrHk+Vu5lDtPhH
        Dx7ok9LtW0kdKOMLPHq7trI86oVwSaYsqXa9mfqYLKZyW0WM3tEe3+Tz7iR9ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAuxjYBKISItdRCewIBg69/sL7aoxkOickZXDOHQkSY=;
        b=rFfjQtlLf3xO0fWzX2pbvXNzReC3V4CiQek+RoFqINcgWpGbr/EEW/BRf9AB2DgpFAGGbL
        vKxUs11mCksKdSBQ==
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
Message-ID: <160690190718.3364.5857834705678386429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     e2391bd55155ca98293b1bbaa44aa2815d3d054f
Gitweb:        https://git.kernel.org/tip/e2391bd55155ca98293b1bbaa44aa2815d3d054f
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:17 +01:00

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
