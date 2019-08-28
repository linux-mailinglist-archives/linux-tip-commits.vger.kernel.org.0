Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1E9FF50
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2019 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfH1KQp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Aug 2019 06:16:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46477 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfH1KQp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0L-0000Lw-39; Wed, 28 Aug 2019 12:16:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 959371C0DE6;
        Wed, 28 Aug 2019 12:16:33 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:33 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Get rid of zero checks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.275086128@linutronix.de>
References: <20190821192922.275086128@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739354.5783.1272606376018222911.tip-bot2@tip-bot2>
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

Commit-ID:     2bbdbdae05167c688b6d3499a7dab74208b80a22
Gitweb:        https://git.kernel.org/tip/2bbdbdae05167c688b6d3499a7dab74208b80a22
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:40 +02:00

posix-cpu-timers: Get rid of zero checks

Deactivation of the expiry cache is done by setting all clock caches to
0. That requires to have a check for zero in all places which update the
expiry cache:

	if (cache == 0 || new < cache)
		cache = new;

Use U64_MAX as the deactivated value, which allows to remove the zero
checks when updating the cache and reduces it to the obvious check:

	if (new < cache)
		cache = new;

This also removes the weird workaround in do_prlimit() which was required
to convert a RLIMIT_CPU value of 0 (immediate expiry) to 1 because handing
in 0 to the posix CPU timer code would have effectively disarmed it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192922.275086128@linutronix.de

---
 include/linux/posix-timers.h   |  7 ++++--
 kernel/sys.c                   |  9 +--------
 kernel/time/posix-cpu-timers.c | 38 +++++++++++++--------------------
 3 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 64bd10d..3ea920e 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -86,7 +86,9 @@ struct posix_cputimers {
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
-	memset(pct->bases, 0, sizeof(pct->bases));
+	pct->bases[0].nextevt = U64_MAX;
+	pct->bases[1].nextevt = U64_MAX;
+	pct->bases[2].nextevt = U64_MAX;
 	INIT_LIST_HEAD(&pct->bases[0].cpu_timers);
 	INIT_LIST_HEAD(&pct->bases[1].cpu_timers);
 	INIT_LIST_HEAD(&pct->bases[2].cpu_timers);
@@ -102,7 +104,8 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
-	.cpu_timers = LIST_HEAD_INIT(b.cpu_timers),			\
+	.nextevt	= U64_MAX,					\
+	.cpu_timers	= LIST_HEAD_INIT(b.cpu_timers),			\
 }
 
 #define INIT_CPU_TIMERBASES(b) {					\
diff --git a/kernel/sys.c b/kernel/sys.c
index c578b75..2462aa8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1557,15 +1557,6 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 			retval = -EPERM;
 		if (!retval)
 			retval = security_task_setrlimit(tsk, resource, new_rlim);
-		if (resource == RLIMIT_CPU && new_rlim->rlim_cur == 0) {
-			/*
-			 * The caller is asking for an immediate RLIMIT_CPU
-			 * expiry.  But we use the zero value to mean "it was
-			 * never set".  So let's cheat and make it one second
-			 * instead
-			 */
-			new_rlim->rlim_cur = 1;
-		}
 	}
 	if (!retval) {
 		if (old_rlim)
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a738d76..cf85292 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -122,11 +122,12 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
 	}
 }
 
-static inline bool expiry_cache_is_zero(const struct posix_cputimers *pct)
+/* Check whether all cache entries contain U64_MAX, i.e. eternal expiry time */
+static inline bool expiry_cache_is_inactive(const struct posix_cputimers *pct)
 {
-	return !(pct->bases[CPUCLOCK_PROF].nextevt |
-		 pct->bases[CPUCLOCK_VIRT].nextevt |
-		 pct->bases[CPUCLOCK_SCHED].nextevt);
+	return !(~pct->bases[CPUCLOCK_PROF].nextevt |
+		 ~pct->bases[CPUCLOCK_VIRT].nextevt |
+		 ~pct->bases[CPUCLOCK_SCHED].nextevt);
 }
 
 static int
@@ -442,11 +443,6 @@ void posix_cpu_timers_exit_group(struct task_struct *tsk)
 	cleanup_timers(&tsk->signal->posix_cputimers);
 }
 
-static inline int expires_gt(u64 expires, u64 new_exp)
-{
-	return expires == 0 || expires > new_exp;
-}
-
 /*
  * Insert the timer on the appropriate list before any timers that
  * expire later.  This must be called with the sighand lock held.
@@ -483,7 +479,7 @@ static void arm_timer(struct k_itimer *timer)
 	 * for process timers we share expiration cache with itimers
 	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
 	 */
-	if (expires_gt(base->nextevt, newexp))
+	if (newexp < base->nextevt)
 		base->nextevt = newexp;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
@@ -753,7 +749,7 @@ check_timers_list(struct list_head *timers,
 		list_move_tail(&t->entry, firing);
 	}
 
-	return 0;
+	return U64_MAX;
 }
 
 static inline void check_dl_overrun(struct task_struct *tsk)
@@ -779,11 +775,7 @@ static void check_thread_timers(struct task_struct *tsk,
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
 
-	/*
-	 * If the expiry cache is zero, then there are no active per thread
-	 * CPU timers.
-	 */
-	if (expiry_cache_is_zero(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
@@ -833,7 +825,7 @@ static void check_thread_timers(struct task_struct *tsk,
 		}
 	}
 
-	if (expiry_cache_is_zero(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -864,7 +856,7 @@ static void check_cpu_itimer(struct task_struct *tsk, struct cpu_itimer *it,
 		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
 	}
 
-	if (it->expires && (!*expires || it->expires < *expires))
+	if (it->expires && it->expires < *expires)
 		*expires = it->expires;
 }
 
@@ -948,7 +940,7 @@ static void check_process_timers(struct task_struct *tsk,
 			}
 		}
 		softns = soft * NSEC_PER_SEC;
-		if (!prof_exp || softns < prof_exp)
+		if (softns < prof_exp)
 			prof_exp = softns;
 	}
 
@@ -956,7 +948,7 @@ static void check_process_timers(struct task_struct *tsk,
 	base[CPUCLOCK_VIRT].nextevt = virt_exp;
 	base[CPUCLOCK_SCHED].nextevt = sched_exp;
 
-	if (expiry_cache_is_zero(&sig->posix_cputimers))
+	if (expiry_cache_is_inactive(&sig->posix_cputimers))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1035,7 +1027,7 @@ task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++) {
-		if (pct->bases[i].nextevt && sample[i] >= pct->bases[i].nextevt)
+		if (sample[i] >= pct->bases[i].nextevt)
 			return true;
 	}
 	return false;
@@ -1055,7 +1047,7 @@ static inline bool fastpath_timer_check(struct task_struct *tsk)
 {
 	struct signal_struct *sig;
 
-	if (!expiry_cache_is_zero(&tsk->posix_cputimers)) {
+	if (!expiry_cache_is_inactive(&tsk->posix_cputimers)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		task_sample_cputime(tsk, samples);
@@ -1200,7 +1192,7 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
 	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	if (expires_gt(*nextevt, *newval))
+	if (*newval < *nextevt)
 		*nextevt = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
