Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057BA174CBE
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Mar 2020 11:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCAK16 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Mar 2020 05:27:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40038 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCAK16 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Mar 2020 05:27:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j8LpD-0003Nb-Sv; Sun, 01 Mar 2020 11:27:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7FE7D1C2130;
        Sun,  1 Mar 2020 11:27:55 +0100 (CET)
Date:   Sun, 01 Mar 2020 10:27:55 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove unnecessary locking
 around cpu_clock_sample_group
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <878skmvdts.fsf@x220.int.ebiederm.org>
References: <878skmvdts.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <158305847525.28353.4345801491752820779.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     60f2ceaa8111d9ec51af87bde4a6809f2b3235e4
Gitweb:        https://git.kernel.org/tip/60f2ceaa8111d9ec51af87bde4a6809f2b3235e4
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Fri, 28 Feb 2020 11:09:19 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 01 Mar 2020 11:21:44 +01:00

posix-cpu-timers: Remove unnecessary locking around cpu_clock_sample_group

As of e78c3496790e ("time, signal: Protect resource use statistics
with seqlock") cpu_clock_sample_group no longers needs siglock
protection.  Unfortunately no one realized it at the time.

Remove the extra locking that is for cpu_clock_sample_group and not
for cpu_clock_sample.  This significantly simplifies the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/878skmvdts.fsf@x220.int.ebiederm.org

---
 kernel/time/posix-cpu-timers.c | 66 ++++++---------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 46cc188..40c2d83 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -718,31 +718,10 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	/*
 	 * Sample the clock to take the difference with the expiry time.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		now = cpu_clock_sample(clkid, p);
-	} else {
-		struct sighand_struct *sighand;
-		unsigned long flags;
-
-		/*
-		 * Protect against sighand release/switch in exit/exec and
-		 * also make timer sampling safe if it ends up calling
-		 * thread_group_cputime().
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (unlikely(sighand == NULL)) {
-			/*
-			 * The process has been reaped.
-			 * We can't even collect a sample any more.
-			 * Disarm the timer, nothing else to do.
-			 */
-			cpu_timer_setexpires(ctmr, 0);
-			return;
-		} else {
-			now = cpu_clock_sample_group(clkid, p, false);
-			unlock_task_sighand(p, &flags);
-		}
-	}
+	else
+		now = cpu_clock_sample_group(clkid, p, false);
 
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
@@ -986,43 +965,22 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		now = cpu_clock_sample(clkid, p);
-		bump_cpu_timer(timer, now);
-		if (unlikely(p->exit_state))
-			return;
-
-		/* Protect timer list r/w in arm_timer() */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			return;
-	} else {
-		/*
-		 * Protect arm_timer() and timer sampling in case of call to
-		 * thread_group_cputime().
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (unlikely(sighand == NULL)) {
-			/*
-			 * The process has been reaped.
-			 * We can't even collect a sample any more.
-			 */
-			cpu_timer_setexpires(ctmr, 0);
-			return;
-		} else if (unlikely(p->exit_state) && thread_group_empty(p)) {
-			/* If the process is dying, no need to rearm */
-			goto unlock;
-		}
+	else
 		now = cpu_clock_sample_group(clkid, p, true);
-		bump_cpu_timer(timer, now);
-		/* Leave the sighand locked for the call below.  */
-	}
+
+	bump_cpu_timer(timer, now);
+
+	/* Protect timer list r/w in arm_timer() */
+	sighand = lock_task_sighand(p, &flags);
+	if (unlikely(sighand == NULL))
+		return;
 
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
 	arm_timer(timer);
-unlock:
 	unlock_task_sighand(p, &flags);
 }
 
