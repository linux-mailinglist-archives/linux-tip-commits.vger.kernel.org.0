Return-Path: <linux-tip-commits+bounces-4179-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74979A5F262
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B43219C0F92
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE5266B4F;
	Thu, 13 Mar 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ofUxWkwq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ssxxn6bX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936626656F;
	Thu, 13 Mar 2025 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865486; cv=none; b=qV3qdP4vaX7JbObeqZj+ZfItwXOisfo4b3IJHyBg0ZG8k/5SOCWY1ptC8aBVdzetB9a26WHHBwcIOcbUgIhVLxlMWgsSWkN77JKU6cHWbxDSv0pqFTO2/vIjukH/31jAqpc0iDMm3HV3YCPhPfUVRRYBWj5NCcfcxroezzxYBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865486; c=relaxed/simple;
	bh=vyx3aL/Acy88V+TajKRM/g8qkKmM+LQPuT6bHrHag8Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hESPjNYZEtth+0Ry05ki22Ayjbzr+6ZRz+wqsDv46WC53YFwIhhZj0EpVYpkFd41manzDVBrGnozTQ1Xw0we9jyyB0Hd7jO0+C7m10QSc5SDKy5QLzZz1TeeC8iVs1++f20WyJ+/uh3UMkSatmW9PW2iJeEzxZyg1xXah8uZgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ofUxWkwq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ssxxn6bX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGdHiSIcCjwQdfkWq7M8Jhfuf7CvoTkmKsvefuji+vw=;
	b=ofUxWkwqzTFYNFsJuwX5k2XVLqCGBrqiTVinV4QwiJH2F7JtkKtFwXfUmiYinP4zbv7ndN
	eWSTDUo4tL1lrNS8oMF8P8oNhWdJfbia7n4K5hJ/xmJj+qca75ptK3ZXN6osFWQ9Bf706h
	S1/BzY3rf39nGsV1nZCFvj27DLcuFTiQWncdZT+i7f9a2HiwTsKB0jYdXPdYRe3www6lxd
	L91ML/j3syC/kucbtQuOvUcGFWyc2rXu1AOtfWHXDlMOlbbSzJMAtI2T/8hXgSGoZIvPeg
	NvIg4oA0J4n75N7Uvo1tFFtpvEDQkO5g4vApRSTRV4eSO3UgOnWqh4yQAzZ1yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGdHiSIcCjwQdfkWq7M8Jhfuf7CvoTkmKsvefuji+vw=;
	b=ssxxn6bX/DlDqWSIFAXY1khq04K7+33zyBC24NdKhu8H+7mezE3urKnAJUfLRHM1YLJ7O4
	EA7XwNgdKNwZ5yBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Provide a mechanism to allocate a
 given timer ID
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87jz8vz0en.ffs@tglx>
References: <87jz8vz0en.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548220.14745.11412896707958085028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ec2d0c04624b3c8a7eb1682e006717fa20cfbe24
Gitweb:        https://git.kernel.org/tip/ec2d0c04624b3c8a7eb1682e006717fa20cfbe24
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 11 Mar 2025 23:07:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:18 +01:00

posix-timers: Provide a mechanism to allocate a given timer ID

Checkpoint/Restore in Userspace (CRIU) requires to reconstruct posix timers
with the same timer ID on restore. It uses sys_timer_create() and relies on
the monotonic increasing timer ID provided by this syscall. It creates and
deletes timers until the desired ID is reached. This is can loop for a long
time, when the checkpointed process had a very sparse timer ID range.

It has been debated to implement a new syscall to allow the creation of
timers with a given timer ID, but that's tideous due to the 32/64bit compat
issues of sigevent_t and of dubious value.

The restore mechanism of CRIU creates the timers in a state where all
threads of the restored process are held on a barrier and cannot issue
syscalls. That means the restorer task has exclusive control.

This allows to address this issue with a prctl() so that the restorer
thread can do:

   if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_ON))
      goto linear_mode;
   create_timers_with_explicit_ids();
   prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF);
   
This is backwards compatible because the prctl() fails on older kernels and
CRIU can fall back to the linear timer ID mechanism. CRIU versions which do
not know about the prctl() just work as before.

Implement the prctl() and modify timer_create() so that it copies the
requested timer ID from userspace by utilizing the existing timer_t
pointer, which is used to copy out the allocated timer ID on success.

If the prctl() is disabled, which it is by default, timer_create() works as
before and does not try to read from the userspace pointer.

There is no problem when a broken or rogue user space application enables
the prctl(). If the user space pointer does not contain a valid ID, then
timer_create() fails. If the data is not initialized, but constains a
random valid ID, timer_create() will create that random timer ID or fail if
the ID is already given out. 
 
As CRIU must use the raw syscall to avoid manipulating the internal state
of the restored process, this has no library dependencies and can be
adopted by CRIU right away.

Recreating two timers with IDs 1000000 and 2000000 takes 1.5 seconds with
the create/delete method. With the prctl() it takes 3 microseconds.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Tested-by: Cyrill Gorcunov <gorcunov@gmail.com>
Link: https://lore.kernel.org/all/87jz8vz0en.ffs@tglx

---
 include/linux/posix-timers.h |   2 +-
 include/linux/sched/signal.h |   1 +-
 include/uapi/linux/prctl.h   |  11 ++++-
 kernel/sys.c                 |   5 ++-
 kernel/time/posix-timers.c   | 105 +++++++++++++++++++++++++---------
 5 files changed, 98 insertions(+), 26 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 094ef57..dd48c64 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -114,6 +114,7 @@ bool posixtimer_init_sigqueue(struct sigqueue *q);
 void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
+long posixtimer_create_prctl(unsigned long ctrl);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -140,6 +141,7 @@ static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
 					     struct sigqueue *timer_sigq) { return false; }
 static inline void posixtimer_free_timer(struct k_itimer *timer) { }
+static inline long posixtimer_create_prctl(unsigned long ctrl) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 72649d7..1ef1edb 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,6 +136,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
+	unsigned int		timer_create_restore_ids:1;
 	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5c60806..15c18ef 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,15 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/*
+ * Controls the mode of timer_create() for CRIU restore operations.
+ * Enabling this allows CRIU to restore timers with explicit IDs.
+ *
+ * Don't use for normal operations as the result might be undefined.
+ */
+#define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	2
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index cb366ff..982e1c4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2811,6 +2811,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_TIMER_CREATE_RESTORE_IDS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = posixtimer_create_prctl(arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b917a16..2ca1c55 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
+#include <linux/prctl.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
@@ -57,6 +58,8 @@ static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
 static const struct k_clock clock_realtime, clock_monotonic;
 
+#define TIMER_ANY_ID		INT_MIN
+
 /* SIGEV_THREAD_ID cannot share a bit with the other SIGEV values. */
 #if SIGEV_THREAD_ID != (SIGEV_THREAD_ID & \
 			~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
@@ -128,38 +131,60 @@ static bool posix_timer_hashed(struct timer_hash_bucket *bucket, struct signal_s
 	return false;
 }
 
-static int posix_timer_add(struct k_itimer *timer)
+static bool posix_timer_add_at(struct k_itimer *timer, struct signal_struct *sig, unsigned int id)
+{
+	struct timer_hash_bucket *bucket = hash_bucket(sig, id);
+
+	scoped_guard (spinlock, &bucket->lock) {
+		/*
+		 * Validate under the lock as this could have raced against
+		 * another thread ending up with the same ID, which is
+		 * highly unlikely, but possible.
+		 */
+		if (!posix_timer_hashed(bucket, sig, id)) {
+			/*
+			 * Set the timer ID and the signal pointer to make
+			 * it identifiable in the hash table. The signal
+			 * pointer has bit 0 set to indicate that it is not
+			 * yet fully initialized. posix_timer_hashed()
+			 * masks this bit out, but the syscall lookup fails
+			 * to match due to it being set. This guarantees
+			 * that there can't be duplicate timer IDs handed
+			 * out.
+			 */
+			timer->it_id = (timer_t)id;
+			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
+			hlist_add_head_rcu(&timer->t_hash, &bucket->head);
+			return true;
+		}
+	}
+	return false;
+}
+
+static int posix_timer_add(struct k_itimer *timer, int req_id)
 {
 	struct signal_struct *sig = current->signal;
 
+	if (unlikely(req_id != TIMER_ANY_ID)) {
+		if (!posix_timer_add_at(timer, sig, req_id))
+			return -EBUSY;
+
+		/*
+		 * Move the ID counter past the requested ID, so that after
+		 * switching back to normal mode the IDs are outside of the
+		 * exact allocated region. That avoids ID collisions on the
+		 * next regular timer_create() invocations.
+		 */
+		atomic_set(&sig->next_posix_timer_id, req_id + 1);
+		return req_id;
+	}
+
 	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
 		/* Get the next timer ID and clamp it to positive space */
 		unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
-		struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 
-		scoped_guard (spinlock, &bucket->lock) {
-			/*
-			 * Validate under the lock as this could have raced
-			 * against another thread ending up with the same
-			 * ID, which is highly unlikely, but possible.
-			 */
-			if (!posix_timer_hashed(bucket, sig, id)) {
-				/*
-				 * Set the timer ID and the signal pointer to make
-				 * it identifiable in the hash table. The signal
-				 * pointer has bit 0 set to indicate that it is not
-				 * yet fully initialized. posix_timer_hashed()
-				 * masks this bit out, but the syscall lookup fails
-				 * to match due to it being set. This guarantees
-				 * that there can't be duplicate timer IDs handed
-				 * out.
-				 */
-				timer->it_id = (timer_t)id;
-				timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
-				hlist_add_head_rcu(&timer->t_hash, &bucket->head);
-				return id;
-			}
-		}
+		if (posix_timer_add_at(timer, sig, id))
+			return id;
 		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
@@ -364,6 +389,21 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+long posixtimer_create_prctl(unsigned long ctrl)
+{
+	switch (ctrl) {
+	case PR_TIMER_CREATE_RESTORE_IDS_OFF:
+		current->signal->timer_create_restore_ids = 0;
+		return 0;
+	case PR_TIMER_CREATE_RESTORE_IDS_ON:
+		current->signal->timer_create_restore_ids = 1;
+		return 0;
+	case PR_TIMER_CREATE_RESTORE_IDS_GET:
+		return current->signal->timer_create_restore_ids;
+	}
+	return -EINVAL;
+}
+
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct pid *pid = task_tgid(current);
@@ -435,6 +475,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 			   timer_t __user *created_timer_id)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
+	timer_t req_id = TIMER_ANY_ID;
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
 
@@ -449,11 +490,20 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 
 	spin_lock_init(&new_timer->it_lock);
 
+	/* Special case for CRIU to restore timers with a given timer ID. */
+	if (unlikely(current->signal->timer_create_restore_ids)) {
+		if (copy_from_user(&req_id, created_timer_id, sizeof(req_id)))
+			return -EFAULT;
+		/* Valid IDs are 0..INT_MAX */
+		if ((unsigned int)req_id > INT_MAX)
+			return -EINVAL;
+	}
+
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
 	 * after insertion, but has a unique ID allocated.
 	 */
-	new_timer_id = posix_timer_add(new_timer);
+	new_timer_id = posix_timer_add(new_timer, req_id);
 	if (new_timer_id < 0) {
 		posixtimer_free_timer(new_timer);
 		return new_timer_id;
@@ -1041,6 +1091,9 @@ void exit_itimers(struct task_struct *tsk)
 	struct hlist_node *next;
 	struct k_itimer *timer;
 
+	/* Clear restore mode for exec() */
+	tsk->signal->timer_create_restore_ids = 0;
+
 	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
 

