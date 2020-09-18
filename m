Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2527B26F86F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgIRIgh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRIgh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:36:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0013AC06174A;
        Fri, 18 Sep 2020 01:36:36 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600418195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Qm1htnKsvz8zTpt2XsYk232RHrbCVjmVseH61BDccI=;
        b=rMXsujxLx3RLAGL0BdsECac4MW9toHVn7W1mBPiwB+JEmW3kYLb/SNdTJ/XbZLJNFWTBjV
        HNZdJubRQGHUIzibl152yd+KeKLu4NyNWA6/ctThByyPLAo5MahnNpVLuWC8A/JyGtQDQc
        xmg6c5e/bfhLdm0dpbE44+6u9B9ovn+1xQRkiZB7BWBOxerO4r3P4ojMAovESf/1L8Qs97
        qHZ+5VC0KQDVMPEWhMIF8IxWF7HrVb8wU5tKJdmez9EUKDR33Aia0TnpY+Ccqcm9imPkK8
        tPnBD98KZetPx8R0K8pGV5aXU8Kekgr+wXay34uWUvRmG9eo5MPfzT8MEbRqyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600418195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Qm1htnKsvz8zTpt2XsYk232RHrbCVjmVseH61BDccI=;
        b=WrYdHJuOBEvm+u1qw6GgTo033lwVjfjl9txOY6ssZcLlnG/Gkh5wwG4nQU2cAeEXw52h/z
        nt3F0o1uq1bJyDBA==
From:   "tip-bot2 for Hou Tao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/percpu-rwsem: Use this_cpu_{inc,dec}()
 for read_count
Cc:     Hou Tao <houtao1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200915140750.137881-1-houtao1@huawei.com>
References: <20200915140750.137881-1-houtao1@huawei.com>
MIME-Version: 1.0
Message-ID: <160041819402.15536.17324618125529434873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     e6b1a44eccfcab5e5e280be376f65478c3b2c7a2
Gitweb:        https://git.kernel.org/tip/e6b1a44eccfcab5e5e280be376f65478c3b2c7a2
Author:        Hou Tao <houtao1@huawei.com>
AuthorDate:    Tue, 15 Sep 2020 22:07:50 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Sep 2020 16:26:56 +02:00

locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count

The __this_cpu*() accessors are (in general) IRQ-unsafe which, given
that percpu-rwsem is a blocking primitive, should be just fine.

However, file_end_write() is used from IRQ context and will cause
load-store issues on architectures where the per-cpu accessors are not
natively irq-safe.

Fix it by using the IRQ-safe this_cpu_*() for operations on
read_count. This will generate more expensive code on a number of
platforms, which might cause a performance regression for some of the
other percpu-rwsem users.

If any such is reported, we can consider alternative solutions.

Fixes: 70fe2f48152e ("aio: fix freeze protection of aio writes")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lkml.kernel.org/r/20200915140750.137881-1-houtao1@huawei.com
---
 include/linux/percpu-rwsem.h  | 8 ++++----
 kernel/locking/percpu-rwsem.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5e033fe..5fda40f 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -60,7 +60,7 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		__this_cpu_inc(*sem->read_count);
+		this_cpu_inc(*sem->read_count);
 	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
@@ -79,7 +79,7 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss)))
-		__this_cpu_inc(*sem->read_count);
+		this_cpu_inc(*sem->read_count);
 	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
@@ -103,7 +103,7 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 	 * Same as in percpu_down_read().
 	 */
 	if (likely(rcu_sync_is_idle(&sem->rss))) {
-		__this_cpu_dec(*sem->read_count);
+		this_cpu_dec(*sem->read_count);
 	} else {
 		/*
 		 * slowpath; reader will only ever wake a single blocked
@@ -115,7 +115,7 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 		 * aggregate zero, as that is the only time it matters) they
 		 * will also see our critical section.
 		 */
-		__this_cpu_dec(*sem->read_count);
+		this_cpu_dec(*sem->read_count);
 		rcuwait_wake_up(&sem->writer);
 	}
 	preempt_enable();
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 8bbafe3..70a32a5 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
 static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	__this_cpu_inc(*sem->read_count);
+	this_cpu_inc(*sem->read_count);
 
 	/*
 	 * Due to having preemption disabled the decrement happens on
@@ -71,7 +71,7 @@ static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	if (likely(!atomic_read_acquire(&sem->block)))
 		return true;
 
-	__this_cpu_dec(*sem->read_count);
+	this_cpu_dec(*sem->read_count);
 
 	/* Prod writer to re-evaluate readers_active_check() */
 	rcuwait_wake_up(&sem->writer);
