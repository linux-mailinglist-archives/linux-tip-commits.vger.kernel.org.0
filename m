Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA42CC688
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgLBTXy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 14:23:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgLBTXy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 14:23:54 -0500
Date:   Wed, 02 Dec 2020 19:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUazshvEdYKlWUiZfcIFFNA8RwpF173JvUXEOw12WQg=;
        b=FPBN979cc2toaDwc9sVMrU/NgW2beYF9Kr/haLwaSw2Q5iyB0XgJanhGtAQk+o93x+Uxcp
        6gX8LC6RMCiAREUdqsAdOerPARd6ndxp4g9axb50qedYpUpYlWHrWmbIxj7DWG30gsItQr
        8bFEzN9Vspty4RaS1x2O5WQMpRXOsitf68g9shnTk37pMKI3lIZw+qQf4q1hMlAxaASvOz
        b+ggKx5zeCR0Kh8jzl6oOL8vpZVBt8jTmevzukM8yK3nLRpY38hnSYI40+CSftlA8GRarM
        BojFpAvG16kIZEwFjq2xCplgIW0hRG00vKdaUpXY+rlmGjvK+iPK7t4ySib7wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUazshvEdYKlWUiZfcIFFNA8RwpF173JvUXEOw12WQg=;
        b=cxfcmWN0l811U+u1nLs1d7PRIXXEw6DPHQib+g8hJKB3iQ0tRc9dk5Te02ZQGpYahgiNj0
        +tmXVcjIr+ix02BQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] sched/cputime: Remove symbol exports from IRQ time accounting
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201202115732.27827-2-frederic@kernel.org>
References: <20201202115732.27827-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160693699209.3364.4469833037418267275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7197688b2006357da75a014e0a76be89ca9c2d46
Gitweb:        https://git.kernel.org/tip/7197688b2006357da75a014e0a76be89ca9c2d46
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 02 Dec 2020 12:57:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 20:20:04 +01:00

sched/cputime: Remove symbol exports from IRQ time accounting

account_irq_enter_time() and account_irq_exit_time() are not called
from modules. EXPORT_SYMBOL_GPL() can be safely removed from the IRQ
cputime accounting functions called from there.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201202115732.27827-2-frederic@kernel.org

---
 arch/s390/kernel/vtime.c | 10 +++++-----
 kernel/sched/cputime.c   |  2 --
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 8df10d3..f9f2a11 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -226,7 +226,7 @@ void vtime_flush(struct task_struct *tsk)
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	u64 timer;
 
@@ -245,12 +245,12 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 
 	virt_timer_forward(timer);
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
-
-void vtime_account_kernel(struct task_struct *tsk)
-__attribute__((alias("vtime_account_irq_enter")));
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
+void vtime_account_irq_enter(struct task_struct *tsk)
+__attribute__((alias("vtime_account_kernel")));
+
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d23..61ce9f9 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -71,7 +71,6 @@ void irqtime_account_irq(struct task_struct *curr)
 	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
-EXPORT_SYMBOL_GPL(irqtime_account_irq);
 
 static u64 irqtime_tick_accounted(u64 maxtime)
 {
@@ -434,7 +433,6 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 	else
 		vtime_account_kernel(tsk);
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
 #endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
