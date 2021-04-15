Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22647360470
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhDOIiG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 04:38:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58302 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhDOIiB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Apr 2021 04:38:01 -0400
Date:   Thu, 15 Apr 2021 08:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618475857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxBFrY0eBORziLkLegoWdVoGR425NqmMGnivZWETZps=;
        b=wJC8DXHl9wKW93oSaG94P7zEpEFc3tKRxA96JO4eS2O9kb5iCtyy+JhrpxTCFnZUvVRCdB
        AF7974EoMjKqz3f0Dj0grIiSz+/uXMLXE+rqpzao+LlGd7vRfxsGulsN9GDMUz6Mcd/2IK
        6taE8j/KeUeiOALJiAWYMUEJ+FJio7BOFBeTPz182s+kMhSUFFKUfRwlNO85X9Bl/u2Czd
        zJ2R/kzqau4uId1kA9MNkyAu1EgBORkgPjS8jPwXN1+J2BAVcMbC8yxV6lvrcMGmXV2QT0
        FZkG94Dh4JZlnukXReeNfuvz8R3LznzN6rVOnrW27Gidd5nBibhjjkxEADwMNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618475857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxBFrY0eBORziLkLegoWdVoGR425NqmMGnivZWETZps=;
        b=XrQRcwRku2da+AAIq+JZAEfBw5sumDPwIMDuaTdnjhiMatJUQytXdS+l4yeSSSROjwW74w
        Iq9xXCfWeE111XAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] signal: Allow tasks to cache one sigqueue struct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87sg4lbmxo.fsf@nanos.tec.linutronix.de>
References: <87sg4lbmxo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <161847585539.29796.10359694168370917464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4bad58ebc8bc4f20d89cff95417c9b4674769709
Gitweb:        https://git.kernel.org/tip/4bad58ebc8bc4f20d89cff95417c9b4674769709
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:05:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 Apr 2021 18:04:08 +02:00

signal: Allow tasks to cache one sigqueue struct

The idea for this originates from the real time tree to make signal
delivery for realtime applications more efficient. In quite some of these
application scenarios a control tasks signals workers to start their
computations. There is usually only one signal per worker on flight.  This
works nicely as long as the kmem cache allocations do not hit the slow path
and cause latencies.

To cure this an optimistic caching was introduced (limited to RT tasks)
which allows a task to cache a single sigqueue in a pointer in task_struct
instead of handing it back to the kmem cache after consuming a signal. When
the next signal is sent to the task then the cached sigqueue is used
instead of allocating a new one. This solved the problem for this set of
application scenarios nicely.

The task cache is not preallocated so the first signal sent to a task goes
always to the cache allocator. The cached sigqueue stays around until the
task exits and is freed when task::sighand is dropped.

After posting this solution for mainline the discussion came up whether
this would be useful in general and should not be limited to realtime
tasks: https://lore.kernel.org/r/m11rcu7nbr.fsf@fess.ebiederm.org

One concern leading to the original limitation was to avoid a large amount
of pointlessly cached sigqueues in alive tasks. The other concern was
vs. RLIMIT_SIGPENDING as these cached sigqueues are not accounted for.

The accounting problem is real, but on the other hand slightly academic.
After gathering some statistics it turned out that after boot of a regular
distro install there are less than 10 sigqueues cached in ~1500 tasks.

In case of a 'mass fork and fire signal to child' scenario the extra 80
bytes of memory per task are well in the noise of the overall memory
consumption of the fork bomb.

If this should be limited then this would need an extra counter in struct
user, more atomic instructions and a seperate rlimit. Yet another tunable
which is mostly unused.

The caching is actually used. After boot and a full kernel compile on a
64CPU machine with make -j128 the number of 'allocations' looks like this:

  From slab:	   23996
  From task cache: 52223

I.e. it reduces the number of slab cache operations by ~68%.

A typical pattern there is:

<...>-58490 __sigqueue_alloc:  for 58488 from slab ffff8881132df460
<...>-58488 __sigqueue_free:   cache ffff8881132df460
<...>-58488 __sigqueue_alloc:  for 1149 from cache ffff8881103dc550
  bash-1149 exit_task_sighand: free ffff8881132df460
  bash-1149 __sigqueue_free:   cache ffff8881103dc550

The interesting sequence is that the exiting task 58488 grabs the sigqueue
from bash's task cache to signal exit and bash sticks it back into it's own
cache. Lather, rinse and repeat.

The caching is probably not noticable for the general use case, but the
benefit for latency sensitive applications is clear. While kmem caches are
usually just serving from the fast path the slab merging (default) can
depending on the usage pattern of the merged slabs cause occasional slow
path allocations.

The time spared per cached entry is a few micro seconds per signal which is
not relevant for e.g. a kernel build, but for signal heavy workloads it's
measurable.

As there is no real downside of this caching mechanism making it
unconditionally available is preferred over more conditional code or new
magic tunables.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lkml.kernel.org/r/87sg4lbmxo.fsf@nanos.tec.linutronix.de
---
 include/linux/sched.h  |  1 +-
 include/linux/signal.h |  1 +-
 kernel/exit.c          |  1 +-
 kernel/fork.c          |  1 +-
 kernel/signal.c        | 44 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 05572e2..f5ca798 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -984,6 +984,7 @@ struct task_struct {
 	/* Signal handlers: */
 	struct signal_struct		*signal;
 	struct sighand_struct __rcu		*sighand;
+	struct sigqueue			*sigqueue_cache;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 205526c..c3cbea2 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -265,6 +265,7 @@ static inline void init_sigpending(struct sigpending *sig)
 }
 
 extern void flush_sigqueue(struct sigpending *queue);
+extern void exit_task_sigqueue_cache(struct task_struct *tsk);
 
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e3..0596526 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -162,6 +162,7 @@ static void __exit_signal(struct task_struct *tsk)
 		flush_sigqueue(&sig->shared_pending);
 		tty_kref_put(tty);
 	}
+	exit_task_sigqueue_cache(tsk);
 }
 
 static void delayed_put_task_struct(struct rcu_head *rhp)
diff --git a/kernel/fork.c b/kernel/fork.c
index d3171e8..3c43a9f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1995,6 +1995,7 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
+	p->sigqueue_cache = NULL;
 
 	p->utime = p->stime = p->gtime = 0;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
diff --git a/kernel/signal.c b/kernel/signal.c
index 568a2e2..2d9463e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -433,7 +433,16 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	rcu_read_unlock();
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		/*
+		 * Preallocation does not hold sighand::siglock so it can't
+		 * use the cache. The lockless caching requires that only
+		 * one consumer and only one producer run at a time.
+		 */
+		q = READ_ONCE(t->sigqueue_cache);
+		if (!q || sigqueue_flags)
+			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		else
+			WRITE_ONCE(t->sigqueue_cache, NULL);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -450,13 +459,44 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	return q;
 }
 
+void exit_task_sigqueue_cache(struct task_struct *tsk)
+{
+	/* Race free because @tsk is mopped up */
+	struct sigqueue *q = tsk->sigqueue_cache;
+
+	if (q) {
+		tsk->sigqueue_cache = NULL;
+		/*
+		 * Hand it back to the cache as the task might
+		 * be self reaping which would leak the object.
+		 */
+		 kmem_cache_free(sigqueue_cachep, q);
+	}
+}
+
+static void sigqueue_cache_or_free(struct sigqueue *q)
+{
+	/*
+	 * Cache one sigqueue per task. This pairs with the consumer side
+	 * in __sigqueue_alloc() and needs READ/WRITE_ONCE() to prevent the
+	 * compiler from store tearing and to tell KCSAN that the data race
+	 * is intentional when run without holding current->sighand->siglock,
+	 * which is fine as current obviously cannot run __sigqueue_free()
+	 * concurrently.
+	 */
+	if (!READ_ONCE(current->sigqueue_cache))
+		WRITE_ONCE(current->sigqueue_cache, q);
+	else
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
 static void __sigqueue_free(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
 	if (atomic_dec_and_test(&q->user->sigpending))
 		free_uid(q->user);
-	kmem_cache_free(sigqueue_cachep, q);
+	sigqueue_cache_or_free(q);
 }
 
 void flush_sigqueue(struct sigpending *queue)
