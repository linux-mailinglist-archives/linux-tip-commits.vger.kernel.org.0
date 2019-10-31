Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA0EAF69
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2019 12:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfJaLzd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 31 Oct 2019 07:55:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJaLzd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ931-0003A3-DT; Thu, 31 Oct 2019 12:55:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B6351C06D7;
        Thu, 31 Oct 2019 12:55:12 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:12 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] time: Export tick start/stop functions for rcutorture
Cc:     kbuild test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252291213.29376.13393459625257690838.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ae9e557b5be2e285f48ee945d9c8faf75d4f6a66
Gitweb:        https://git.kernel.org/tip/ae9e557b5be2e285f48ee945d9c8faf75d4f6a66
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 09 Aug 2019 16:29:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 10:46:03 -07:00

time: Export tick start/stop functions for rcutorture

It turns out that rcutorture needs to ensure that the scheduling-clock
interrupt is enabled in CONFIG_NO_HZ_FULL kernels before starting on
CPU-bound in-kernel processing.  This commit therefore exports
tick_nohz_dep_set_task(), tick_nohz_dep_clear_task(), and
tick_nohz_full_setup() to GPL kernel modules.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/tick-sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d1b0a84..1ffdb4b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -172,6 +172,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
 bool tick_nohz_full_running;
+EXPORT_SYMBOL_GPL(tick_nohz_full_running);
 static atomic_t tick_dep_mask;
 
 static bool check_tick_dependency(atomic_t *dep)
@@ -351,11 +352,13 @@ void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 	 */
 	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 
 void tick_nohz_dep_clear_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
 	atomic_andnot(BIT(bit), &tsk->tick_dep_mask);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_task);
 
 /*
  * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
@@ -404,6 +407,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	cpumask_copy(tick_nohz_full_mask, cpumask);
 	tick_nohz_full_running = true;
 }
+EXPORT_SYMBOL_GPL(tick_nohz_full_setup);
 
 static int tick_nohz_cpu_down(unsigned int cpu)
 {
