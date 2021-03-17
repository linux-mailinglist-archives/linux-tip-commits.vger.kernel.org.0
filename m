Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD21F33F462
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhCQPtY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhCQPs4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A1CC061762;
        Wed, 17 Mar 2021 08:48:56 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:48:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+DFM0mUu5v/7pA6N6tJB+pDgLgw0G8YXDnifJLQBng=;
        b=mMu/lNwwQjsyhlbolL1XkTL+Uh5Q50kvmCcnypHBESU8B8srElhJ+vBfnGRLtI9mf645bf
        RTEv2fkpM0q4U60hJAWIlDkIyr2NI2Wb770IcJILg772JDVf/Z8UYhXLWRrx1Zq4OCG2Zu
        V6SnN2/M1GlDloTdC71uV/C7LwoU6qTV3RwTsAknjKSz3gxM/1e1VYv+XIFMjJZS/OAH3I
        Jjj0wIcwylYQ7VeGsIwIBkPkT0+zZ2DgFQEPKfoABadMVqc7l8Q0EGFIfRN6H6PdTQNona
        Zyp5sixZKxtDzBVrcIzbkdbqFcLVla9RQavZGoJA4SYWBBnCtl+gUO4o2Defvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+DFM0mUu5v/7pA6N6tJB+pDgLgw0G8YXDnifJLQBng=;
        b=wdK0DnSZVAKVxzDszS3yBJieUZRrqKQAuXyqTEMi+garNeAMAFKWIKyrpC/Bjp3lOEYi8A
        i7m8ZNRiXoYW4cBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqtime: Make accounting correct on RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309085727.153926793@linutronix.de>
References: <20210309085727.153926793@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613428.398.15018455967076257553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6516b386d8a07102aac353daf9c0fe0045faeb74
Gitweb:        https://git.kernel.org/tip/6516b386d8a07102aac353daf9c0fe0045faeb74
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:55:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:09 +01:00

irqtime: Make accounting correct on RT

vtime_account_irq and irqtime_account_irq() base checks on preempt_count()
which fails on RT because preempt_count() does not contain the softirq
accounting which is seperate on RT.

These checks do not need the full preempt count as they only operate on the
hard and softirq sections.

Use irq_count() instead which provides the correct value on both RT and non
RT kernels. The compiler is clever enough to fold the masking for !RT:

       99b:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax
 -     9a2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
 +     9a2:	25 00 ff ff 00       	and    $0xffff00,%eax

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309085727.153926793@linutronix.de

---
 kernel/sched/cputime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5f61165..2c36a5f 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -60,7 +60,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
-	pc = preempt_count() - offset;
+	pc = irq_count() - offset;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -421,7 +421,7 @@ void vtime_task_switch(struct task_struct *prev)
 
 void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
-	unsigned int pc = preempt_count() - offset;
+	unsigned int pc = irq_count() - offset;
 
 	if (pc & HARDIRQ_OFFSET) {
 		vtime_account_hardirq(tsk);
