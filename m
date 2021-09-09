Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1B40491C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhIILTt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbhIILTl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:41 -0400
Date:   Thu, 09 Sep 2021 11:18:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxOF/L38TimH9BTp8icN3RcUda6/ulK+vUEzVJ0EXkI=;
        b=ZdwpQYWn+LSspwh4v6wJVkPU8wQlXto2KMWVrMAQEp9rFwz+ozBWn+mBDHO2cAZU68SmxE
        O6FPdDC8ayDpFm7iX2yhvmIv7oGRk7f8GyAK+qFGINrAb8gei+lNOxzeMBP9+3GT6ZOW/r
        4aAA4WaDFrg8mcvZ/rN47Ge7nK8NLq5sCSIuCOcV93Ej/bIiROkm4UiKqh7wogGiqKS7P3
        12zUszz49wRjxbnP0nuxlGsc2YhjP9OOZirN69EVg1zlVLXovidoPwAS8xc38GWoQ/7495
        3K5fzTsRKr79J+kZstqRUnXIQRER8k5OPXZnf9+C2DHBYDYHPI27AG92icWKgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxOF/L38TimH9BTp8icN3RcUda6/ulK+vUEzVJ0EXkI=;
        b=iQ5leIq2a8p7BSn/LjYQTiO6+IzRSeoKBCQ61EhUy7EYxuQOBIPLIEvpsZwLJrCJr0IA5L
        1/HX/TTHJT+HeoDA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210826170408.vm7rlj7odslshwch@linutronix.de>
References: <20210826170408.vm7rlj7odslshwch@linutronix.de>
MIME-Version: 1.0
Message-ID: <163118631071.25758.12323417296109377806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e9e5ba93a24d946d6e70d5c85f74254335a6555b
Gitweb:        https://git.kernel.org/tip/e9e5ba93a24d946d6e70d5c85f74254335a6555b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 26 Aug 2021 19:04:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:30 +02:00

sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD

With PREEMPT_RT enabled all hrtimers callbacks will be invoked in
softirq mode unless they are explicitly marked as HRTIMER_MODE_HARD.
During boot kthread_bind() is used for the creation of per-CPU threads
and then hangs in wait_task_inactive() if the ksoftirqd is not
yet up and running.
The hang disappeared since commit
   26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")

but enabling function trace on boot reliably leads to the freeze on boot
behaviour again.
The timer in wait_task_inactive() can not be directly used by a user
interface to abuse it and create a mass wake up of several tasks at the
same time leading to long sections with disabled interrupts.
Therefore it is safe to make the timer HRTIMER_MODE_REL_HARD.

Switch the timer to HRTIMER_MODE_REL_HARD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210826170408.vm7rlj7odslshwch@linutronix.de
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a22cc3c..d19d1ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3234,7 +3234,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
