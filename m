Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675E52D494B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbgLISmM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732961AbgLISjb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84B6C061793;
        Wed,  9 Dec 2020 10:38:50 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCHLpzsf+qtSYP5Z/O54VFcXA3bDvoqQyI7mhQmeTKc=;
        b=WF05ShpGIjiZJ+JI6srxt4K4E7W9Mu/tZEyFOt6mkyE33/b0I2SXS0Snu2kKZT51YYEnc1
        8XlIknHzJCGxDngm9QJTXQYZdC9naNlD1psU3ARhWamaOqBNF0S4dTOO/1lgIzDBDE3YnB
        477RXEA/zTcwNaECsOKHlVnrB2S+Z6hPMEknnsFKjOBKhifKuR7cia9Q7Ff+yTuWxRvb62
        Bs0Cc0o/ANlGeaxDhLU4UNYVl1UkR5fV++ZsfNOmQkrnyocb4Yd3/QFmKrwWliKwJEIuqT
        CQQqiEb71lzSnBbSd62fGJ+6Rk00zRaC/6ttF3SRv4C9/k/urtj6yzBXuckSxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCHLpzsf+qtSYP5Z/O54VFcXA3bDvoqQyI7mhQmeTKc=;
        b=2LUzseco1rMfLByyqmWGYHxtujJM9R92Ha7WkUxFUQqPi9w14fK3twWELdcMREZ64nkeqd
        rv8OvpJ3Zlim+eBg==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Pass the current atomic count to
 rwsem_down_read_slowpath()
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201121041416.12285-2-longman@redhat.com>
References: <20201121041416.12285-2-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <160753912803.3364.4437531645113964830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c8fe8b0564388f41147326f31e4587171aacccd4
Gitweb:        https://git.kernel.org/tip/c8fe8b0564388f41147326f31e4587171aacccd4
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 20 Nov 2020 23:14:12 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:47 +01:00

locking/rwsem: Pass the current atomic count to rwsem_down_read_slowpath()

The atomic count value right after reader count increment can be useful
to determine the rwsem state at trylock time. So the count value is
passed down to rwsem_down_read_slowpath() to be used when appropriate.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lkml.kernel.org/r/20201121041416.12285-2-longman@redhat.com
---
 kernel/locking/rwsem.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 67ae366..5768b90 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -270,14 +270,14 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 					  owner | RWSEM_NONSPINNABLE));
 }
 
-static inline bool rwsem_read_trylock(struct rw_semaphore *sem)
+static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
 {
-	long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
+	*cntp = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
 
-	if (WARN_ON_ONCE(cnt < 0))
+	if (WARN_ON_ONCE(*cntp < 0))
 		rwsem_set_nonspinnable(sem);
 
-	if (!(cnt & RWSEM_READ_FAILED_MASK)) {
+	if (!(*cntp & RWSEM_READ_FAILED_MASK)) {
 		rwsem_set_reader_owned(sem);
 		return true;
 	}
@@ -1008,9 +1008,9 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 {
-	long count, adjustment = -RWSEM_READER_BIAS;
+	long adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 	bool wake = false;
@@ -1356,8 +1356,10 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 static inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
-	if (!rwsem_read_trylock(sem)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, state)))
+	long count;
+
+	if (!rwsem_read_trylock(sem, &count)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	}
