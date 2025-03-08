Return-Path: <linux-tip-commits+bounces-4068-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA8A57699
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205207A8874
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B652528F3;
	Sat,  8 Mar 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="htXrX4AD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+TSM2M5S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA418839F4;
	Sat,  8 Mar 2025 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392497; cv=none; b=CbeIxG6QWAarJqm34J8/UNP4m3LqxymfsFTQFc4yB97tjdrxWDcM54Dex3+0JkD6qK2IG+WR1M645TcQDT9w3ubyuQahHEM1l0fF+6yoaNNklrGpJWqYISiuDxWrcc2skfhTOLCKl2r55dcdlxOtPs1uL1OVJJV/qEb7CLDsHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392497; c=relaxed/simple;
	bh=8EjsG6H0pu6EEa3NSJaBC4UBDbA/DYvXueETg1sm6mk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s6AFalEKcVM8o73w83Sm7kaSYCYP5aWJdU1dJkEgvghYbbUbh9bfxFLZhd+MZtIKq7iY0NYjVCtURnE/YSq+9e2wwrKmlGWPKOiZUvQPZHvTW3XawjE1+IUVXXl7cRNssu6UdDQ6zcHYYrr1/QeNdmzY4kdgMmgkaISF8lv3gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=htXrX4AD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+TSM2M5S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00wmQHQSJwvFcCF/6WeYnD8jrq9INdphcKc4i0wzgbU=;
	b=htXrX4ADhexZVXwH6g3mMynwuq5CLPHEfW3WFV8YAxE+Wm6ik3Y+YFRFJG3C27hOYkDEc5
	FAR/1lKg73Pf4YIDcbGsg4dud/LqGx0VV3g09/KFzlpgiIFX4HCpwgkzjzyQLRHBMz3SQS
	b1f0xi4cvbKIXvN0UUaRp/C2iW7IUa4QMbdEUns1UhMrOPa7Y0ZQebdpJ3stMjnCjZ9H5J
	uvEFAH0HRS91Lvt6gtXe+BdU5VQhfFxlb5bDxuuMu7qKsWSLCyWZY2GyFMh0TxzcePhBvG
	8xQwqioWPmfG/wggAj1CqzVO8M768ZRfScdx54zsrvzStjEfNGFY5plMSZMr3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00wmQHQSJwvFcCF/6WeYnD8jrq9INdphcKc4i0wzgbU=;
	b=+TSM2M5SduLrMKhINbt46YMttKy0whReD7ERloj4cvsIU+i2FMbo/1YDkqX2VKPMUkpK6J
	0A2rL0zsOq31rQAw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/semaphore: Use wake_q to wake up
 processes outside lock critical section
Cc: yzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-3-boqun.feng@gmail.com>
References: <20250307232717.1759087-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139249348.14745.2236673241181761797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     85b2b9c16d053364e2004883140538e73b333cdb
Gitweb:        https://git.kernel.org/tip/85b2b9c16d053364e2004883140538e73b333cdb
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 07 Mar 2025 15:26:52 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:52:01 +01:00

locking/semaphore: Use wake_q to wake up processes outside lock critical section

A circular lock dependency splat has been seen involving down_trylock():

  ======================================================
  WARNING: possible circular locking dependency detected
  6.12.0-41.el10.s390x+debug
  ------------------------------------------------------
  dd/32479 is trying to acquire lock:
  0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90

  but task is already holding lock:
  000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0

  the existing dependency chain (in reverse order) is:
  -> #4 (&zone->lock){-.-.}-{2:2}:
  -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
  -> #2 (&rq->__lock){-.-.}-{2:2}:
  -> #1 (&p->pi_lock){-.-.}-{2:2}:
  -> #0 ((console_sem).lock){-.-.}-{2:2}:

The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
while holding the console_sem raw_spinlock. This dependency can be broken
by using wake_q to do the wakeup instead of calling try_to_wake_up()
under the console_sem lock. This will also make the semaphore's
raw_spinlock become a terminal lock without taking any further locks
underneath it.

The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
the debug_objects_fill_pool() helper function in the debugobjects code.

  -> #4 (&zone->lock){-.-.}-{2:2}:
         __lock_acquire+0xe86/0x1cc0
         lock_acquire.part.0+0x258/0x630
         lock_acquire+0xb8/0xe0
         _raw_spin_lock_irqsave+0xb4/0x120
         rmqueue_bulk+0xac/0x8f0
         __rmqueue_pcplist+0x580/0x830
         rmqueue_pcplist+0xfc/0x470
         rmqueue.isra.0+0xdec/0x11b0
         get_page_from_freelist+0x2ee/0xeb0
         __alloc_pages_noprof+0x2c2/0x520
         alloc_pages_mpol_noprof+0x1fc/0x4d0
         alloc_pages_noprof+0x8c/0xe0
         allocate_slab+0x320/0x460
         ___slab_alloc+0xa58/0x12b0
         __slab_alloc.isra.0+0x42/0x60
         kmem_cache_alloc_noprof+0x304/0x350
         fill_pool+0xf6/0x450
         debug_object_activate+0xfe/0x360
         enqueue_hrtimer+0x34/0x190
         __run_hrtimer+0x3c8/0x4c0
         __hrtimer_run_queues+0x1b2/0x260
         hrtimer_interrupt+0x316/0x760
         do_IRQ+0x9a/0xe0
         do_irq_async+0xf6/0x160

Normally a raw_spinlock to spinlock dependency is not legitimate
and will be warned if CONFIG_PROVE_RAW_LOCK_NESTING is enabled,
but debug_objects_fill_pool() is an exception as it explicitly
allows this dependency for non-PREEMPT_RT kernel without causing
PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
legitimate and not a bug.

Anyway, semaphore is the only locking primitive left that is still
using try_to_wake_up() to do wakeup inside critical section, all the
other locking primitives had been migrated to use wake_q to do wakeup
outside of the critical section. It is also possible that there are
other circular locking dependencies involving printk/console_sem or
other existing/new semaphores lurking somewhere which may show up in
the future. Let just do the migration now to wake_q to avoid headache
like this.

Reported-by: yzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250307232717.1759087-3-boqun.feng@gmail.com
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

