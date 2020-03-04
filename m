Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24547178CF1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2020 09:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbgCDI53 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 4 Mar 2020 03:57:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgCDI52 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 4 Mar 2020 03:57:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j9PqH-0007Ax-I3; Wed, 04 Mar 2020 09:57:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CEF5F1C21B0;
        Wed,  4 Mar 2020 09:57:24 +0100 (CET)
Date:   Wed, 04 Mar 2020 08:57:24 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Store a reference to a pid not a task
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87wo86tz6d.fsf@x220.int.ebiederm.org>
References: <87wo86tz6d.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <158331224448.28353.17742299109137799963.tip-bot2@tip-bot2>
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

Commit-ID:     55e8c8eb2c7b6bf30e99423ccfe7ca032f498f59
Gitweb:        https://git.kernel.org/tip/55e8c8eb2c7b6bf30e99423ccfe7ca032f498f59
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Fri, 28 Feb 2020 11:11:06 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Mar 2020 09:54:55 +01:00

posix-cpu-timers: Store a reference to a pid not a task

posix cpu timers do not handle the death of a process well.

This is most clearly seen when a multi-threaded process calls exec from a
thread that is not the leader of the thread group.  The posix cpu timer code
continues to pin the old thread group leader and is unable to find the
siglock from there.

This results in posix_cpu_timer_del being unable to delete a timer,
posix_cpu_timer_set being unable to set a timer.  Further to compensate for
the problems in posix_cpu_timer_del on a multi-threaded exec all timers
that point at the multi-threaded task are stopped.

The code for the timers fundamentally needs to check if the target
process/thread is alive.  This needs an extra level of indirection. This
level of indirection is already available in struct pid.

So replace cpu.task with cpu.pid to get the needed extra layer of
indirection.

In addition to handling things more cleanly this reduces the amount of
memory a timer can pin when a process exits and then is reaped from
a task_struct to the vastly smaller struct pid.

Fixes: e0a70217107e ("posix-cpu-timers: workaround to suppress the problems with mt exec")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87wo86tz6d.fsf@x220.int.ebiederm.org

---
 include/linux/posix-timers.h   |  2 +-
 kernel/time/posix-cpu-timers.c | 73 ++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 3d10c84..e3f0f85 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -69,7 +69,7 @@ static inline int clockid_to_fd(const clockid_t clk)
 struct cpu_timer {
 	struct timerqueue_node	node;
 	struct timerqueue_head	*head;
-	struct task_struct	*task;
+	struct pid		*pid;
 	struct list_head	elist;
 	int			firing;
 };
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ef936c5..6df468a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -118,6 +118,16 @@ static inline int validate_clock_permissions(const clockid_t clock)
 	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
 }
 
+static inline enum pid_type cpu_timer_pid_type(struct k_itimer *timer)
+{
+	return CPUCLOCK_PERTHREAD(timer->it_clock) ? PIDTYPE_PID : PIDTYPE_TGID;
+}
+
+static inline struct task_struct *cpu_timer_task_rcu(struct k_itimer *timer)
+{
+	return pid_task(timer->it.cpu.pid, cpu_timer_pid_type(timer));
+}
+
 /*
  * Update expiry time from increment, and increase overrun count,
  * given the current clock sample.
@@ -391,7 +401,12 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
-	new_timer->it.cpu.task = p;
+	new_timer->it.cpu.pid = get_task_pid(p, cpu_timer_pid_type(new_timer));
+	/*
+	 * get_task_for_clock() took a reference on @p. Drop it as the timer
+	 * holds a reference on the pid of @p.
+	 */
+	put_task_struct(p);
 	return 0;
 }
 
@@ -404,13 +419,15 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 static int posix_cpu_timer_del(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct task_struct *p = ctmr->task;
 	struct sighand_struct *sighand;
+	struct task_struct *p;
 	unsigned long flags;
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!p))
-		return -EINVAL;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p)
+		goto out;
 
 	/*
 	 * Protect against sighand release/switch in exit/exec and process/
@@ -432,8 +449,10 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		unlock_task_sighand(p, &flags);
 	}
 
+out:
+	rcu_read_unlock();
 	if (!ret)
-		put_task_struct(p);
+		put_pid(ctmr->pid);
 
 	return ret;
 }
@@ -561,13 +580,21 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct task_struct *p = ctmr->task;
 	struct sighand_struct *sighand;
+	struct task_struct *p;
 	unsigned long flags;
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!p))
-		return -EINVAL;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p) {
+		/*
+		 * If p has just been reaped, we can no
+		 * longer get any information about it at all.
+		 */
+		rcu_read_unlock();
+		return -ESRCH;
+	}
 
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -584,8 +611,10 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * If p has just been reaped, we can no
 	 * longer get any information about it at all.
 	 */
-	if (unlikely(sighand == NULL))
+	if (unlikely(sighand == NULL)) {
+		rcu_read_unlock();
 		return -ESRCH;
+	}
 
 	/*
 	 * Disarm any old timer after extracting its expiry time.
@@ -690,6 +719,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 	ret = 0;
  out:
+	rcu_read_unlock();
 	if (old)
 		old->it_interval = ns_to_timespec64(old_incr);
 
@@ -701,10 +731,12 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 now, expires = cpu_timer_getexpires(ctmr);
-	struct task_struct *p = ctmr->task;
+	struct task_struct *p;
 
-	if (WARN_ON_ONCE(!p))
-		return;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p)
+		goto out;
 
 	/*
 	 * Easy part: convert the reload time.
@@ -712,7 +744,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
 	if (!expires)
-		return;
+		goto out;
 
 	/*
 	 * Sample the clock to take the difference with the expiry time.
@@ -732,6 +764,8 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 		itp->it_value.tv_nsec = 1;
 		itp->it_value.tv_sec = 0;
 	}
+out:
+	rcu_read_unlock();
 }
 
 #define MAX_COLLECTED	20
@@ -952,14 +986,15 @@ static void check_process_timers(struct task_struct *tsk,
 static void posix_cpu_timer_rearm(struct k_itimer *timer)
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct task_struct *p = ctmr->task;
+	struct task_struct *p;
 	struct sighand_struct *sighand;
 	unsigned long flags;
 	u64 now;
 
-	if (WARN_ON_ONCE(!p))
-		return;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p)
+		goto out;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
@@ -974,13 +1009,15 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	/* Protect timer list r/w in arm_timer() */
 	sighand = lock_task_sighand(p, &flags);
 	if (unlikely(sighand == NULL))
-		return;
+		goto out;
 
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
 	arm_timer(timer, p);
 	unlock_task_sighand(p, &flags);
+out:
+	rcu_read_unlock();
 }
 
 /**
