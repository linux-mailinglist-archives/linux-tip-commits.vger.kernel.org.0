Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4E4278B2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbhJIKJI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhJIKJD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB89C061765;
        Sat,  9 Oct 2021 03:07:06 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhU6ZTZ1f84xBtudWCj+FoWxUmhf/wgPKDKEVNdc8tY=;
        b=P010ADhHkD0u47LXvhZL+CEXxWGWFAdP6cYM17Wt0nC0rm/+VQB08BrqKqXgKQvFyEws6H
        UmGi8k0IUZzvRqB17oKnhvf3LMDC/FcDr5JEvEpUw9a1FyTq664dH8koSuZk2zWnjRNujv
        rqT9x915SnYogo7Vst4RAbYX6gKYbYpUQSqdFEGEX+pYP0UvPeZAK1oag0C/Y5mGdEah/l
        5p4otHWBjQ9lGk/6MGODxtSz+BCcSA4xclwRTGDjphDug3p/1pqQKMtJoipdvflpmXnXRo
        sw7tFG9DChbA0KeRgzBf6n/hZyXRbQa6zgdBo1g0hz6Y8ZPVuWOyhe9KObBF6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhU6ZTZ1f84xBtudWCj+FoWxUmhf/wgPKDKEVNdc8tY=;
        b=PPqHDWGSAz7LUukV9xNO1hrgGXCA/GmVZza+5zcNz8/B6f+5HdCubtMS60wvIq5OcCq+sR
        eJ7WOiZMKsmcxtBw==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Implement sys_futex_waitv()
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-17-andrealmeid@collabora.com>
References: <20210923171111.300673-17-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402463.25758.8669230402987605927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bf69bad38cf63d980e8a603f8d1bd1f85b5ed3d9
Gitweb:        https://git.kernel.org/tip/bf69bad38cf63d980e8a603f8d1bd1f85b5=
ed3d9
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 23 Sep 2021 14:11:05 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:11 +02:00

futex: Implement sys_futex_waitv()

Add support to wait on multiple futexes. This is the interface
implemented by this syscall:

futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
	    unsigned int flags, struct timespec *timeout, clockid_t clockid)

struct futex_waitv {
	__u64 val;
	__u64 uaddr;
	__u32 flags;
	__u32 __reserved;
};

Given an array of struct futex_waitv, wait on each uaddr. The thread
wakes if a futex_wake() is performed at any uaddr. The syscall returns
immediately if any waiter has *uaddr !=3D val. *timeout is an optional
absolute timeout value for the operation. This syscall supports only
64bit sized timeout structs. The flags argument of the syscall should be
empty, but it can be used for future extensions. Flags for shared
futexes, sizes, etc. should be used on the individual flags of each
waiter.

__reserved is used for explicit padding and should be 0, but it might be
used for future extensions. If the userspace uses 32-bit pointers, it
should make sure to explicitly cast it when assigning to waitv::uaddr.

Returns the array index of one of the woken futexes. There=E2=80=99s no given
information of how many were woken, or any particular attribute of it
(if it=E2=80=99s the first woken, if it is of the smaller index...).

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210923171111.300673-17-andrealmeid@collabor=
a.com
---
 MAINTAINERS                       |   1 +-
 include/linux/syscalls.h          |   5 +-
 include/uapi/asm-generic/unistd.h |   5 +-
 include/uapi/linux/futex.h        |  25 ++++-
 kernel/futex/futex.h              |  15 ++-
 kernel/futex/syscalls.c           | 119 +++++++++++++++++-
 kernel/futex/waitwake.c           | 201 +++++++++++++++++++++++++++++-
 kernel/sys_ni.c                   |   1 +-
 8 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3094cb..310fb01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7718,6 +7718,7 @@ M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
 R:	Davidlohr Bueso <dave@stgolabs.net>
+R:	Andr=C3=A9 Almeida <andrealmeid@collabora.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2597968..528a478 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -58,6 +58,7 @@ struct mq_attr;
 struct compat_stat;
 struct old_timeval32;
 struct robust_list_head;
+struct futex_waitv;
 struct getcpu_cache;
 struct old_linux_dirent;
 struct perf_event_attr;
@@ -623,6 +624,10 @@ asmlinkage long sys_get_robust_list(int pid,
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
=20
+asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
+				unsigned int nr_futexes, unsigned int flags,
+				struct __kernel_timespec __user *timeout, clockid_t clockid);
+
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/uni=
std.h
index 1c5fb86..4557a8b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -880,8 +880,11 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
=20
+#define __NR_futex_waitv 449
+__SYSCALL(__NR_futex_waitv, sys_futex_waitv)
+
 #undef __NR_syscalls
-#define __NR_syscalls 449
+#define __NR_syscalls 450
=20
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 235e5b2..71a5df8 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -44,6 +44,31 @@
 					 FUTEX_PRIVATE_FLAG)
=20
 /*
+ * Flags to specify the bit length of the futex word for futex2 syscalls.
+ * Currently, only 32 is supported.
+ */
+#define FUTEX_32		2
+
+/*
+ * Max numbers of elements in a futex_waitv array
+ */
+#define FUTEX_WAITV_MAX		128
+
+/**
+ * struct futex_waitv - A waiter for vectorized wait
+ * @val:	Expected value at uaddr
+ * @uaddr:	User address to wait on
+ * @flags:	Flags for this waiter
+ * @__reserved:	Reserved member to preserve data alignment. Should be 0.
+ */
+struct futex_waitv {
+	__u64 val;
+	__u64 uaddr;
+	__u32 flags;
+	__u32 __reserved;
+};
+
+/*
  * Support for robust futexes: the kernel cleans up held futexes at
  * thread exit time.
  */
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 465f7bd..948fcf3 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -268,6 +268,21 @@ extern int futex_requeue(u32 __user *uaddr1, unsigned in=
t flags,
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
=20
+/**
+ * struct futex_vector - Auxiliary struct for futex_waitv()
+ * @w: Userspace provided data
+ * @q: Kernel side data
+ *
+ * Struct used to build an array with all data need for futex_waitv()
+ */
+struct futex_vector {
+	struct futex_waitv w;
+	struct futex_q q;
+};
+
+extern int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
+			       struct hrtimer_sleeper *to);
+
 extern int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u3=
2 bitset);
=20
 extern int futex_wake_op(u32 __user *uaddr1, unsigned int flags,
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 6e7e36c..6f91a07 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -199,6 +199,125 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u3=
2, val,
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
=20
+/* Mask of available flags for each futex in futex_waitv list */
+#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
+
+/**
+ * futex_parse_waitv - Parse a waitv array from userspace
+ * @futexv:	Kernel side list of waiters to be filled
+ * @uwaitv:     Userspace list to be parsed
+ * @nr_futexes: Length of futexv
+ *
+ * Return: Error code on failure, 0 on success
+ */
+static int futex_parse_waitv(struct futex_vector *futexv,
+			     struct futex_waitv __user *uwaitv,
+			     unsigned int nr_futexes)
+{
+	struct futex_waitv aux;
+	unsigned int i;
+
+	for (i =3D 0; i < nr_futexes; i++) {
+		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
+			return -EFAULT;
+
+		if ((aux.flags & ~FUTEXV_WAITER_MASK) || aux.__reserved)
+			return -EINVAL;
+
+		if (!(aux.flags & FUTEX_32))
+			return -EINVAL;
+
+		futexv[i].w.flags =3D aux.flags;
+		futexv[i].w.val =3D aux.val;
+		futexv[i].w.uaddr =3D aux.uaddr;
+		futexv[i].q =3D futex_q_init;
+	}
+
+	return 0;
+}
+
+/**
+ * sys_futex_waitv - Wait on a list of futexes
+ * @waiters:    List of futexes to wait on
+ * @nr_futexes: Length of futexv
+ * @flags:      Flag for timeout (monotonic/realtime)
+ * @timeout:	Optional absolute timeout.
+ * @clockid:	Clock to be used for the timeout, realtime or monotonic.
+ *
+ * Given an array of `struct futex_waitv`, wait on each uaddr. The thread wa=
kes
+ * if a futex_wake() is performed at any uaddr. The syscall returns immediat=
ely
+ * if any waiter has *uaddr !=3D val. *timeout is an optional timeout value =
for
+ * the operation. Each waiter has individual flags. The `flags` argument for
+ * the syscall should be used solely for specifying the timeout as realtime,=
 if
+ * needed. Flags for private futexes, sizes, etc. should be used on the
+ * individual flags of each waiter.
+ *
+ * Returns the array index of one of the woken futexes. No further informati=
on
+ * is provided: any number of other futexes may also have been woken by the
+ * same event, and if more than one futex was woken, the retrned index may
+ * refer to any one of them. (It is not necessaryily the futex with the
+ * smallest index, nor the one most recently woken, nor...)
+ */
+
+SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
+		unsigned int, nr_futexes, unsigned int, flags,
+		struct __kernel_timespec __user *, timeout, clockid_t, clockid)
+{
+	struct hrtimer_sleeper to;
+	struct futex_vector *futexv;
+	struct timespec64 ts;
+	ktime_t time;
+	int ret;
+
+	/* This syscall supports no flags for now */
+	if (flags)
+		return -EINVAL;
+
+	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
+		return -EINVAL;
+
+	if (timeout) {
+		int flag_clkid =3D 0, flag_init =3D 0;
+
+		if (clockid =3D=3D CLOCK_REALTIME) {
+			flag_clkid =3D FLAGS_CLOCKRT;
+			flag_init =3D FUTEX_CLOCK_REALTIME;
+		}
+
+		if (clockid !=3D CLOCK_REALTIME && clockid !=3D CLOCK_MONOTONIC)
+			return -EINVAL;
+
+		if (get_timespec64(&ts, timeout))
+			return -EFAULT;
+
+		/*
+		 * Since there's no opcode for futex_waitv, use
+		 * FUTEX_WAIT_BITSET that uses absolute timeout as well
+		 */
+		ret =3D futex_init_timeout(FUTEX_WAIT_BITSET, flag_init, &ts, &time);
+		if (ret)
+			return ret;
+
+		futex_setup_timer(&time, &to, flag_clkid, 0);
+	}
+
+	futexv =3D kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
+	if (!futexv)
+		return -ENOMEM;
+
+	ret =3D futex_parse_waitv(futexv, waiters, nr_futexes);
+	if (!ret)
+		ret =3D futex_wait_multiple(futexv, nr_futexes, timeout ? &to : NULL);
+
+	if (timeout) {
+		hrtimer_cancel(&to.timer);
+		destroy_hrtimer_on_stack(&to.timer);
+	}
+
+	kfree(futexv);
+	return ret;
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3688078..4ce0923 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -358,6 +358,207 @@ void futex_wait_queue(struct futex_hash_bucket *hb, str=
uct futex_q *q,
 }
=20
 /**
+ * unqueue_multiple - Remove various futexes from their hash bucket
+ * @v:	   The list of futexes to unqueue
+ * @count: Number of futexes in the list
+ *
+ * Helper to unqueue a list of futexes. This can't fail.
+ *
+ * Return:
+ *  - >=3D0 - Index of the last futex that was awoken;
+ *  - -1  - No futex was awoken
+ */
+static int unqueue_multiple(struct futex_vector *v, int count)
+{
+	int ret =3D -1, i;
+
+	for (i =3D 0; i < count; i++) {
+		if (!futex_unqueue(&v[i].q))
+			ret =3D i;
+	}
+
+	return ret;
+}
+
+/**
+ * futex_wait_multiple_setup - Prepare to wait and enqueue multiple futexes
+ * @vs:		The futex list to wait on
+ * @count:	The size of the list
+ * @woken:	Index of the last woken futex, if any. Used to notify the
+ *		caller that it can return this index to userspace (return parameter)
+ *
+ * Prepare multiple futexes in a single step and enqueue them. This may fail=
 if
+ * the futex list is invalid or if any futex was already awoken. On success =
the
+ * task is ready to interruptible sleep.
+ *
+ * Return:
+ *  -  1 - One of the futexes was woken by another thread
+ *  -  0 - Success
+ *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
+ */
+static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int=
 *woken)
+{
+	struct futex_hash_bucket *hb;
+	bool retry =3D false;
+	int ret, i;
+	u32 uval;
+
+	/*
+	 * Enqueuing multiple futexes is tricky, because we need to enqueue
+	 * each futex on the list before dealing with the next one to avoid
+	 * deadlocking on the hash bucket. But, before enqueuing, we need to
+	 * make sure that current->state is TASK_INTERRUPTIBLE, so we don't
+	 * lose any wake events, which cannot be done before the get_futex_key
+	 * of the next key, because it calls get_user_pages, which can sleep.
+	 * Thus, we fetch the list of futexes keys in two steps, by first
+	 * pinning all the memory keys in the futex key, and only then we read
+	 * each key and queue the corresponding futex.
+	 *
+	 * Private futexes doesn't need to recalculate hash in retry, so skip
+	 * get_futex_key() when retrying.
+	 */
+retry:
+	for (i =3D 0; i < count; i++) {
+		if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
+			continue;
+
+		ret =3D get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
+				    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
+				    &vs[i].q.key, FUTEX_READ);
+
+		if (unlikely(ret))
+			return ret;
+	}
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	for (i =3D 0; i < count; i++) {
+		u32 __user *uaddr =3D (u32 __user *)(unsigned long)vs[i].w.uaddr;
+		struct futex_q *q =3D &vs[i].q;
+		u32 val =3D (u32)vs[i].w.val;
+
+		hb =3D futex_q_lock(q);
+		ret =3D futex_get_value_locked(&uval, uaddr);
+
+		if (!ret && uval =3D=3D val) {
+			/*
+			 * The bucket lock can't be held while dealing with the
+			 * next futex. Queue each futex at this moment so hb can
+			 * be unlocked.
+			 */
+			futex_queue(q, hb);
+			continue;
+		}
+
+		futex_q_unlock(hb);
+		__set_current_state(TASK_RUNNING);
+
+		/*
+		 * Even if something went wrong, if we find out that a futex
+		 * was woken, we don't return error and return this index to
+		 * userspace
+		 */
+		*woken =3D unqueue_multiple(vs, i);
+		if (*woken >=3D 0)
+			return 1;
+
+		if (ret) {
+			/*
+			 * If we need to handle a page fault, we need to do so
+			 * without any lock and any enqueued futex (otherwise
+			 * we could lose some wakeup). So we do it here, after
+			 * undoing all the work done so far. In success, we
+			 * retry all the work.
+			 */
+			if (get_user(uval, uaddr))
+				return -EFAULT;
+
+			retry =3D true;
+			goto retry;
+		}
+
+		if (uval !=3D val)
+			return -EWOULDBLOCK;
+	}
+
+	return 0;
+}
+
+/**
+ * futex_sleep_multiple - Check sleeping conditions and sleep
+ * @vs:    List of futexes to wait for
+ * @count: Length of vs
+ * @to:    Timeout
+ *
+ * Sleep if and only if the timeout hasn't expired and no futex on the list =
has
+ * been woken up.
+ */
+static void futex_sleep_multiple(struct futex_vector *vs, unsigned int count,
+				 struct hrtimer_sleeper *to)
+{
+	if (to && !to->task)
+		return;
+
+	for (; count; count--, vs++) {
+		if (!READ_ONCE(vs->q.lock_ptr))
+			return;
+	}
+
+	freezable_schedule();
+}
+
+/**
+ * futex_wait_multiple - Prepare to wait on and enqueue several futexes
+ * @vs:		The list of futexes to wait on
+ * @count:	The number of objects
+ * @to:		Timeout before giving up and returning to userspace
+ *
+ * Entry point for the FUTEX_WAIT_MULTIPLE futex operation, this function
+ * sleeps on a group of futexes and returns on the first futex that is
+ * wake, or after the timeout has elapsed.
+ *
+ * Return:
+ *  - >=3D0 - Hint to the futex that was awoken
+ *  - <0  - On error
+ */
+int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
+			struct hrtimer_sleeper *to)
+{
+	int ret, hint =3D 0;
+
+	if (to)
+		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
+
+	while (1) {
+		ret =3D futex_wait_multiple_setup(vs, count, &hint);
+		if (ret) {
+			if (ret > 0) {
+				/* A futex was woken during setup */
+				ret =3D hint;
+			}
+			return ret;
+		}
+
+		futex_sleep_multiple(vs, count, to);
+
+		__set_current_state(TASK_RUNNING);
+
+		ret =3D unqueue_multiple(vs, count);
+		if (ret >=3D 0)
+			return ret;
+
+		if (to && !to->task)
+			return -ETIMEDOUT;
+		else if (signal_pending(current))
+			return -ERESTARTSYS;
+		/*
+		 * The final case is a spurious wakeup, for
+		 * which just retry.
+		 */
+	}
+}
+
+/**
  * futex_wait_setup() - Prepare to wait on a futex
  * @uaddr:	the futex userspace address
  * @val:	the expected value
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 13ee833..d194425 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -150,6 +150,7 @@ COND_SYSCALL(set_robust_list);
 COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
+COND_SYSCALL(futex_waitv);
=20
 /* kernel/hrtimer.c */
=20
