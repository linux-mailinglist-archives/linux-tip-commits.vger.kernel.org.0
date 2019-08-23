Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23ED9A545
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbfHWCMS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:12:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33708 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbfHWCMR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3m-0000w9-QA; Fri, 23 Aug 2019 04:12:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 648201C07E4;
        Fri, 23 Aug 2019 04:12:14 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:14 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove tsk argument from
 run_posix_cpu_timers()
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20190819143801.945469967@linutronix.de>
References: <20190819143801.945469967@linutronix.de>
MIME-Version: 1.0
Message-ID: <156652633417.11637.2192098489035972415.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dce3e8fd039cc1b62760b3ad6822cf04c262cd0e
Gitweb:        https://git.kernel.org/tip/dce3e8fd039cc1b62760b3ad6822cf04c262cd0e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 Aug 2019 16:31:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Aug 2019 20:27:16 +02:00

posix-cpu-timers: Remove tsk argument from run_posix_cpu_timers()

It's always current. Don't give people wrong ideas.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190819143801.945469967@linutronix.de

---
 include/linux/posix-timers.h   | 2 +-
 kernel/time/posix-cpu-timers.c | 5 +++--
 kernel/time/timer.c            | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 26c636d..033374b 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -118,7 +118,7 @@ struct k_itimer {
 	struct rcu_head		rcu;
 };
 
-void run_posix_cpu_timers(struct task_struct *task);
+void run_posix_cpu_timers(void);
 void posix_cpu_timers_exit(struct task_struct *task);
 void posix_cpu_timers_exit_group(struct task_struct *task);
 void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 98223d2..387e0e8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1137,11 +1137,12 @@ static inline int fastpath_timer_check(struct task_struct *tsk)
  * already updated our counts.  We need to check if any timers fire now.
  * Interrupts are disabled.
  */
-void run_posix_cpu_timers(struct task_struct *tsk)
+void run_posix_cpu_timers(void)
 {
-	LIST_HEAD(firing);
+	struct task_struct *tsk = current;
 	struct k_itimer *timer, *next;
 	unsigned long flags;
+	LIST_HEAD(firing);
 
 	lockdep_assert_irqs_disabled();
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 673c6a0..0e315a2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1728,7 +1728,7 @@ void update_process_times(int user_tick)
 #endif
 	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
-		run_posix_cpu_timers(p);
+		run_posix_cpu_timers();
 }
 
 /**
