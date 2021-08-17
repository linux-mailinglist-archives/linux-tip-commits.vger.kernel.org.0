Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8651B3EF36A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhHQUPa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhHQUPD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:03 -0400
Date:   Tue, 17 Aug 2021 20:14:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbHWN+YhUyg+M6zWlzWNHsY8CIKjXj+H7DFg6uJdCAE=;
        b=mqEbSjM/TfW1ULHKfGVP/54lAS56BRcwW5UG0ph9+/DgSlQizZ2AlC7/NstKEb3x6KiMYZ
        iRD5xuayz0XEjPo1CXqpT9miuvjRyHSzpWgUPpH3blJ67v3NR7yBwSR04wXjXDhL49Vifi
        m5S+eKJNDNd0q2p6q/vw0/lrD4v9zuq8Ht0vV1C3E0ehiXaKmWatmN0cLdCj00hKxqqJWY
        cd1/My3bYI7t67UmE7wr3BbsefC38Dv/+h/pASycRYua0mki+84+u3i8NaPFosRolZeVA9
        o7PQ84tQnYUs3A42O6JxzkKDJs6W2fdXJIPb2BbOFiQzah3xq91uqSDE/tOGKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbHWN+YhUyg+M6zWlzWNHsY8CIKjXj+H7DFg6uJdCAE=;
        b=qfNP9JTAj8cKAnfmJTors3gznMIHd1WGU3jaX1jM8wX6jPYtFs2IM0wD/mDCUE5WDMhutO
        l6VQUNBGpLjhxZCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rt: Add base code for RT rw_semaphore and rwlock
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.957920571@linutronix.de>
References: <20210815211302.957920571@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126814.25758.11395417168543723983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     943f0edb754fac195043c620b44f920e4fb76ec8
Gitweb:        https://git.kernel.org/tip/943f0edb754fac195043c620b44f920e4fb76ec8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:12:22 +02:00

locking/rt: Add base code for RT rw_semaphore and rwlock

On PREEMPT_RT, rw_semaphores and rwlocks are substituted with an rtmutex and
a reader count. The implementation is writer unfair, as it is not feasible
to do priority inheritance on multiple readers, but experience has shown
that real-time workloads are not the typical workloads which are sensitive
to writer starvation.

The inner workings of rw_semaphores and rwlocks on RT are almost identical
except for the task state and signal handling. rw_semaphores are not state
preserving over a contention, they are expected to enter and leave with state
== TASK_RUNNING. rwlocks have a mechanism to preserve the state of the task
at entry and restore it after unblocking taking potential non-lock related
wakeups into account. rw_semaphores can also be subject to signal handling
interrupting a blocked state, while rwlocks ignore signals.

To avoid code duplication, provide a shared implementation which takes the
small difference vs. state and signals into account. The code is included
into the relevant rw_semaphore/rwlock base code and compiled for each use
case separately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.957920571@linutronix.de
---
 include/linux/rwbase_rt.h  |  39 +++++-
 kernel/locking/rwbase_rt.c | 263 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 302 insertions(+)
 create mode 100644 include/linux/rwbase_rt.h
 create mode 100644 kernel/locking/rwbase_rt.c

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
new file mode 100644
index 0000000..1d264dd
--- /dev/null
+++ b/include/linux/rwbase_rt.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef _LINUX_RWBASE_RT_H
+#define _LINUX_RWBASE_RT_H
+
+#include <linux/rtmutex.h>
+#include <linux/atomic.h>
+
+#define READER_BIAS		(1U << 31)
+#define WRITER_BIAS		(1U << 30)
+
+struct rwbase_rt {
+	atomic_t		readers;
+	struct rt_mutex_base	rtmutex;
+};
+
+#define __RWBASE_INITIALIZER(name)				\
+{								\
+	.readers = ATOMIC_INIT(READER_BIAS),			\
+	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(name.rtmutex),	\
+}
+
+#define init_rwbase_rt(rwbase)					\
+	do {							\
+		rt_mutex_base_init(&(rwbase)->rtmutex);		\
+		atomic_set(&(rwbase)->readers, READER_BIAS);	\
+	} while (0)
+
+
+static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
+{
+	return atomic_read(&rwb->readers) != READER_BIAS;
+}
+
+static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
+{
+	return atomic_read(&rwb->readers) > 0;
+}
+
+#endif /* _LINUX_RWBASE_RT_H */
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
new file mode 100644
index 0000000..4ba1508
--- /dev/null
+++ b/kernel/locking/rwbase_rt.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * RT-specific reader/writer semaphores and reader/writer locks
+ *
+ * down_write/write_lock()
+ *  1) Lock rtmutex
+ *  2) Remove the reader BIAS to force readers into the slow path
+ *  3) Wait until all readers have left the critical section
+ *  4) Mark it write locked
+ *
+ * up_write/write_unlock()
+ *  1) Remove the write locked marker
+ *  2) Set the reader BIAS, so readers can use the fast path again
+ *  3) Unlock rtmutex, to release blocked readers
+ *
+ * down_read/read_lock()
+ *  1) Try fast path acquisition (reader BIAS is set)
+ *  2) Take tmutex::wait_lock, which protects the writelocked flag
+ *  3) If !writelocked, acquire it for read
+ *  4) If writelocked, block on tmutex
+ *  5) unlock rtmutex, goto 1)
+ *
+ * up_read/read_unlock()
+ *  1) Try fast path release (reader count != 1)
+ *  2) Wake the writer waiting in down_write()/write_lock() #3
+ *
+ * down_read/read_lock()#3 has the consequence, that rw semaphores and rw
+ * locks on RT are not writer fair, but writers, which should be avoided in
+ * RT tasks (think mmap_sem), are subject to the rtmutex priority/DL
+ * inheritance mechanism.
+ *
+ * It's possible to make the rw primitives writer fair by keeping a list of
+ * active readers. A blocked writer would force all newly incoming readers
+ * to block on the rtmutex, but the rtmutex would have to be proxy locked
+ * for one reader after the other. We can't use multi-reader inheritance
+ * because there is no way to support that with SCHED_DEADLINE.
+ * Implementing the one by one reader boosting/handover mechanism is a
+ * major surgery for a very dubious value.
+ *
+ * The risk of writer starvation is there, but the pathological use cases
+ * which trigger it are not necessarily the typical RT workloads.
+ *
+ * Common code shared between RT rw_semaphore and rwlock
+ */
+
+static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
+{
+	int r;
+
+	/*
+	 * Increment reader count, if sem->readers < 0, i.e. READER_BIAS is
+	 * set.
+	 */
+	for (r = atomic_read(&rwb->readers); r < 0;) {
+		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
+			return 1;
+	}
+	return 0;
+}
+
+static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
+				      unsigned int state)
+{
+	struct rt_mutex_base *rtm = &rwb->rtmutex;
+	int ret;
+
+	raw_spin_lock_irq(&rtm->wait_lock);
+	/*
+	 * Allow readers, as long as the writer has not completely
+	 * acquired the semaphore for write.
+	 */
+	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
+		atomic_inc(&rwb->readers);
+		raw_spin_unlock_irq(&rtm->wait_lock);
+		return 0;
+	}
+
+	/*
+	 * Call into the slow lock path with the rtmutex->wait_lock
+	 * held, so this can't result in the following race:
+	 *
+	 * Reader1		Reader2		Writer
+	 *			down_read()
+	 *					down_write()
+	 *					rtmutex_lock(m)
+	 *					wait()
+	 * down_read()
+	 * unlock(m->wait_lock)
+	 *			up_read()
+	 *			wake(Writer)
+	 *					lock(m->wait_lock)
+	 *					sem->writelocked=true
+	 *					unlock(m->wait_lock)
+	 *
+	 *					up_write()
+	 *					sem->writelocked=false
+	 *					rtmutex_unlock(m)
+	 *			down_read()
+	 *					down_write()
+	 *					rtmutex_lock(m)
+	 *					wait()
+	 * rtmutex_lock(m)
+	 *
+	 * That would put Reader1 behind the writer waiting on
+	 * Reader2 to call up_read(), which might be unbound.
+	 */
+
+	/*
+	 * For rwlocks this returns 0 unconditionally, so the below
+	 * !ret conditionals are optimized out.
+	 */
+	ret = rwbase_rtmutex_slowlock_locked(rtm, state);
+
+	/*
+	 * On success the rtmutex is held, so there can't be a writer
+	 * active. Increment the reader count and immediately drop the
+	 * rtmutex again.
+	 *
+	 * rtmutex->wait_lock has to be unlocked in any case of course.
+	 */
+	if (!ret)
+		atomic_inc(&rwb->readers);
+	raw_spin_unlock_irq(&rtm->wait_lock);
+	if (!ret)
+		rwbase_rtmutex_unlock(rtm);
+	return ret;
+}
+
+static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
+					    unsigned int state)
+{
+	if (rwbase_read_trylock(rwb))
+		return 0;
+
+	return __rwbase_read_lock(rwb, state);
+}
+
+static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
+					 unsigned int state)
+{
+	struct rt_mutex_base *rtm = &rwb->rtmutex;
+	struct task_struct *owner;
+
+	raw_spin_lock_irq(&rtm->wait_lock);
+	/*
+	 * Wake the writer, i.e. the rtmutex owner. It might release the
+	 * rtmutex concurrently in the fast path (due to a signal), but to
+	 * clean up rwb->readers it needs to acquire rtm->wait_lock. The
+	 * worst case which can happen is a spurious wakeup.
+	 */
+	owner = rt_mutex_owner(rtm);
+	if (owner)
+		wake_up_state(owner, state);
+
+	raw_spin_unlock_irq(&rtm->wait_lock);
+}
+
+static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
+					       unsigned int state)
+{
+	/*
+	 * rwb->readers can only hit 0 when a writer is waiting for the
+	 * active readers to leave the critical section.
+	 */
+	if (unlikely(atomic_dec_and_test(&rwb->readers)))
+		__rwbase_read_unlock(rwb, state);
+}
+
+static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
+					 unsigned long flags)
+{
+	struct rt_mutex_base *rtm = &rwb->rtmutex;
+
+	atomic_add(READER_BIAS - bias, &rwb->readers);
+	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	rwbase_rtmutex_unlock(rtm);
+}
+
+static inline void rwbase_write_unlock(struct rwbase_rt *rwb)
+{
+	struct rt_mutex_base *rtm = &rwb->rtmutex;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	__rwbase_write_unlock(rwb, WRITER_BIAS, flags);
+}
+
+static inline void rwbase_write_downgrade(struct rwbase_rt *rwb)
+{
+	struct rt_mutex_base *rtm = &rwb->rtmutex;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	/* Release it and account current as reader */
+	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
+}
+
+static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
+				     unsigned int state)
+{
+	struct rt_mutex_base *rtm = &rwb->rtmutex;
+	unsigned long flags;
+
+	/* Take the rtmutex as a first step */
+	if (rwbase_rtmutex_lock_state(rtm, state))
+		return -EINTR;
+
+	/* Force readers into slow path */
+	atomic_sub(READER_BIAS, &rwb->readers);
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	/*
+	 * set_current_state() for rw_semaphore
+	 * current_save_and_set_rtlock_wait_state() for rwlock
+	 */
+	rwbase_set_and_save_current_state(state);
+
+	/* Block until all readers have left the critical section. */
+	for (; atomic_read(&rwb->readers);) {
+		/* Optimized out for rwlocks */
+		if (rwbase_signal_pending_state(state, current)) {
+			__set_current_state(TASK_RUNNING);
+			__rwbase_write_unlock(rwb, 0, flags);
+			return -EINTR;
+		}
+		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+
+		/*
+		 * Schedule and wait for the readers to leave the critical
+		 * section. The last reader leaving it wakes the waiter.
+		 */
+		if (atomic_read(&rwb->readers) != 0)
+			rwbase_schedule();
+		set_current_state(state);
+		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	}
+
+	atomic_set(&rwb->readers, WRITER_BIAS);
+	rwbase_restore_current_state();
+	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	return 0;
+}
+
+static inline int rwbase_write_trylock(struct rwbase_rt *rwb)
+{
+	struct rt_mutex_base *rtm = &rwb->rtmutex;
+	unsigned long flags;
+
+	if (!rwbase_rtmutex_trylock(rtm))
+		return 0;
+
+	atomic_sub(READER_BIAS, &rwb->readers);
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	if (!atomic_read(&rwb->readers)) {
+		atomic_set(&rwb->readers, WRITER_BIAS);
+		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+		return 1;
+	}
+	__rwbase_write_unlock(rwb, 0, flags);
+	return 0;
+}
