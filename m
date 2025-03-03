Return-Path: <linux-tip-commits+bounces-3814-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E64A4CB55
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A171175BB0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB82356C7;
	Mon,  3 Mar 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0M4y0+F9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWInp1kw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196A232377;
	Mon,  3 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027928; cv=none; b=JzwSXoUlbcqsZE6xzzhJm6tY8jL/kt+eGDAoeCipAvGL1mtnA+w0wi6K2wrp1SP6hy4TPzd27s6MpDOQLhtWV0/N+YzTTxC1QmjuTurJfNxcbAmKdyPqIPzfOn0UC3W7kx8opnUwYe0SNzeS4Z+67fe5pBywsICoIyAtDX187zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027928; c=relaxed/simple;
	bh=ZAH99ep1BkxrjDzuk1wWotIxuIoVmpanUKKzWhGZY5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=haiUCM9gdK4DlEjidx6ZUEVjvciMi1Rrh4S+iz2/RPzsAINCK5DMIyfvMasfbhLPMSjR5gjM3JdvRuPKRhR3dc6yHza5MbHyD++tU1Zj+TYXr1gVgQ+yEV/uoYk4CJX1D/ItBu1ankbdyqvgo9XDsPcWEFnqAiLOXDnbGTZtvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0M4y0+F9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yWInp1kw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DogC0mZuZN7eXoH50jJAL8n5jpBKt4yFzTFc4+vLv5U=;
	b=0M4y0+F9F30sudYbgMeGJ+AygY72knkOQCXYTy+AGW6v9TBljYxsjAEHINZUOdH/dm3u3z
	CSgzyNRSvmykGQGUujUg8pPrsaDXrgGMtQQSlDy0+wB/aWd14g+lsJqG9v8kVG4W6JjkXT
	JZZeaV8tQllcf+cfBkJJRNv6DgvIjBTril0UZFxbHmmchhOiRfoO0+bLhcOMY/nGP0Qtlh
	3lp3/Ww9KNWQxdAI0pEhL0PBnLUwpWvYCnSWptFOpabLNS1a4or+JfK3+Y2vkR2H6pzzfn
	BBqMnAorCu20/pu/dDVT2zhc5Qrdj14edxguYDO14EbnNOaG/f9u28hwHdAg9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DogC0mZuZN7eXoH50jJAL8n5jpBKt4yFzTFc4+vLv5U=;
	b=yWInp1kwpRe+dkgyOcU39qPne4up/s16HrAqfttj9m2B9G1N1tjrDRFSvypgmYfRVphOmv
	mzTV2zBctrycQPBg==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/semaphore: Use wake_q to wake up
 processes outside lock critical section
Cc: syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250127013127.3913153-1-longman@redhat.com>
References: <20250127013127.3913153-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791867.14745.11647186091452249551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3a5138209d21cd379d9bf64918060cec4fbc3c43
Gitweb:        https://git.kernel.org/tip/3a5138209d21cd379d9bf64918060cec4fbc3c43
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Sun, 26 Jan 2025 20:31:27 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

locking/semaphore: Use wake_q to wake up processes outside lock critical section

A circular lock dependency splat has been seen involving down_trylock().

[ 4011.795602] ======================================================
[ 4011.795603] WARNING: possible circular locking dependency detected
[ 4011.795607] 6.12.0-41.el10.s390x+debug
[ 4011.795612] ------------------------------------------------------
[ 4011.795613] dd/32479 is trying to acquire lock:
[ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
[ 4011.795636]
[ 4011.795636] but task is already holding lock:
[ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0

  the existing dependency chain (in reverse order) is:
  -> #4 (&zone->lock){-.-.}-{2:2}:
  -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
  -> #2 (&rq->__lock){-.-.}-{2:2}:
  -> #1 (&p->pi_lock){-.-.}-{2:2}:
  -> #0 ((console_sem).lock){-.-.}-{2:2}:

The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
while holding the console.sem raw_spinlock. This dependency can be broken
by using wake_q to do the wakeup instead of calling try_to_wake_up()
under the console_sem lock. This will also make the semaphore's
raw_spinlock become a terminal lock without taking any further locks
underneath it.

The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
the debug_objects_fill_pool() helper function in the debugobjects code.

[ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
[ 4011.795650]        __lock_acquire+0xe86/0x1cc0
[ 4011.795655]        lock_acquire.part.0+0x258/0x630
[ 4011.795657]        lock_acquire+0xb8/0xe0
[ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
[ 4011.795663]        rmqueue_bulk+0xac/0x8f0
[ 4011.795665]        __rmqueue_pcplist+0x580/0x830
[ 4011.795667]        rmqueue_pcplist+0xfc/0x470
[ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
[ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
[ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
[ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
[ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
[ 4011.795684]        allocate_slab+0x320/0x460
[ 4011.795686]        ___slab_alloc+0xa58/0x12b0
[ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
[ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
[ 4011.795692]        fill_pool+0xf6/0x450
[ 4011.795697]        debug_object_activate+0xfe/0x360
[ 4011.795700]        enqueue_hrtimer+0x34/0x190
[ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
[ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
[ 4011.795707]        hrtimer_interrupt+0x316/0x760
[ 4011.795709]        do_IRQ+0x9a/0xe0
[ 4011.795712]        do_irq_async+0xf6/0x160

Normally raw_spinlock to spinlock dependency is not legit
and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
but debug_objects_fill_pool() is an exception as it explicitly
allows this dependency for non-PREEMPT_RT kernel without causing
PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
legit and not a bug.

Anyway, semaphore is the only locking primitive left that is still
using try_to_wake_up() to do wakeup inside critical section, all the
other locking primitives had been migrated to use wake_q to do wakeup
outside of the critical section. It is also possible that there are
other circular locking dependencies involving printk/console_sem or
other existing/new semaphores lurking somewhere which may show up in
the future. Let just do the migration now to wake_q to avoid headache
like this.

Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250127013127.3913153-1-longman@redhat.com
---
 kernel/locking/semaphore.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 34bfae7..de9117c 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -38,7 +39,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -183,13 +184,16 @@ EXPORT_SYMBOL(down_timeout);
 void __sched up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -269,11 +273,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }

