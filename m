Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8087E2D4949
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbgLISmM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:42:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgLISja (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:30 -0500
Date:   Wed, 09 Dec 2020 18:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdCm8CFK3OGqOnzEdvDg1PfZ7u0cKfw5AJJh6hUhnmA=;
        b=D2uZ9n9fZ/xYHioJTDqK+hS15K5DoDvqDC5NDYYlxknfdgMF6qG4DutfMm9hADcAyE9k9P
        ekT/Npam2BgGPpvf+4MneLSj67cGPLD2ON84bSUAhkXZBiEUXFRot4tDwc3MygfhHT3nd8
        Nb9iKAZgXZC7EEvTO+7A2jkcW4xZLBu9evrWED2vaFAXhQFkPFjXx6pjb9Pdgk8UbQjdqr
        P6n6k6KQKBd1cHaNUCBqjdadNfknH0QWiRMh4fV1BceuvsuOu/IgYX1TQxM1+i1uyYrp6K
        8xLk4OY62lFZV8ofoLIooRe9KmbLCVWMnG1qi2WtftaJ3P8LCjNwKIrMR9jf5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdCm8CFK3OGqOnzEdvDg1PfZ7u0cKfw5AJJh6hUhnmA=;
        b=AcFRmX1BL9VbcQbtxWtNr/ExIVVFiRlX76V7VpQUbxZQvWZ6N/rb9nMR4Az3XYEEP6kZv5
        vgOJdM116wLueACw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Enable reader optimistic lock stealing
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201121041416.12285-4-longman@redhat.com>
References: <20201121041416.12285-4-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <160753912756.3364.6893166069488987740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1a728dff855a318bb58bcc1259b1826a7ad9f0bd
Gitweb:        https://git.kernel.org/tip/1a728dff855a318bb58bcc1259b1826a7ad9f0bd
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 20 Nov 2020 23:14:14 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:48 +01:00

locking/rwsem: Enable reader optimistic lock stealing

If the optimistic spinning queue is empty and the rwsem does not have
the handoff or write-lock bits set, it is actually not necessary to
call rwsem_optimistic_spin() to spin on it. Instead, it can steal the
lock directly as its reader bias is in the count already.  If it is
the first reader in this state, it will try to wake up other readers
in the wait queue.

With this patch applied, the following were the lock event counts
after rebooting a 2-socket system and a "make -j96" kernel rebuild.

  rwsem_opt_rlock=4437
  rwsem_rlock=29
  rwsem_rlock_steal=19

So lock stealing represents about 0.4% of all the read locks acquired
in the slow path.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lkml.kernel.org/r/20201121041416.12285-4-longman@redhat.com
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 239039d..270a0d3 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -63,6 +63,7 @@ LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
 LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
 LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
+LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
 LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c055f4b..ba5e239 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -976,6 +976,12 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 	}
 	return false;
 }
+
+static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
+{
+	return !osq_is_locked(&sem->osq);
+}
+
 #else
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 					   unsigned long nonspinnable)
@@ -996,6 +1002,11 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 	return false;
 }
 
+static inline bool rwsem_no_spinners(sem)
+{
+	return false;
+}
+
 static inline int
 rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 {
@@ -1027,6 +1038,22 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 		goto queue;
 
 	/*
+	 * Reader optimistic lock stealing
+	 *
+	 * We can take the read lock directly without doing
+	 * rwsem_optimistic_spin() if the conditions are right.
+	 * Also wake up other readers if it is the first reader.
+	 */
+	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
+	    rwsem_no_spinners(sem)) {
+		rwsem_set_reader_owned(sem);
+		lockevent_inc(rwsem_rlock_steal);
+		if (rcnt == 1)
+			goto wake_readers;
+		return sem;
+	}
+
+	/*
 	 * Save the current read-owner of rwsem, if available, and the
 	 * reader nonspinnable bit.
 	 */
@@ -1048,6 +1075,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 		 * Wake up other readers in the wait list if the front
 		 * waiter is a reader.
 		 */
+wake_readers:
 		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
