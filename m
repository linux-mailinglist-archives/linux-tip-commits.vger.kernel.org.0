Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F93F76FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Aug 2021 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbhHYOR4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Aug 2021 10:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbhHYORz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Aug 2021 10:17:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE51C061757;
        Wed, 25 Aug 2021 07:17:09 -0700 (PDT)
Date:   Wed, 25 Aug 2021 14:17:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629901028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjZRz5GpND4C2QQLkBoMW6v9l0o1wD7lGmvVCM7yq24=;
        b=1en4p1oU0euAF1NMP5d0hPnHLp2Dr6iXB4j+S9lWIlYGw2j+u6tOg9oOtiLndXIv/2nEB+
        1FHj5Z1Y/5nNupVS7wlh5P+EgGkVmbu9s8PfXEHV2K8yAyObajsbzAFY5Gx8j/A2qYxwkJ
        0hgDA6qkbCVbONTK1rv/6ULW4q8QWmw8zQgXHipDmlcySmcyMowFWHsS3NZC0IB9YqtVFb
        9a/G6X3p2aUiqBwbEojjeY/Or7wTGXpkKg6vxfVmFcifQ2KwmFf1wMasDVPwxqsZfx+Q3t
        dB9e5eL+FlX86XYvK/ojyp7dHiKCRFsSLteFZX+Fg4+FVaCwfDMJePzowKuvdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629901028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjZRz5GpND4C2QQLkBoMW6v9l0o1wD7lGmvVCM7yq24=;
        b=I6fjvHmNBVllBJ8SzOHDvB/zDvnFgY9z8xyrsidPYwJAUgnLd9lKfehc2CdzfOAz+Q3GDc
        s56akePSbfe0nPCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Dont dereference waiter lockless
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210825102453.981720644@linutronix.de>
References: <20210825102453.981720644@linutronix.de>
MIME-Version: 1.0
Message-ID: <162990102782.25758.7299742638535703516.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c3123c431447da99db160264506de9897c003513
Gitweb:        https://git.kernel.org/tip/c3123c431447da99db160264506de9897c003513
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Aug 2021 12:33:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Aug 2021 15:42:32 +02:00

locking/rtmutex: Dont dereference waiter lockless

The new rt_mutex_spin_on_onwer() loop checks whether the spinning waiter is
still the top waiter on the lock by utilizing rt_mutex_top_waiter(), which
is broken because that function contains a sanity check which dereferences
the top waiter pointer to check whether the waiter belongs to the
lock. That's wrong in the lockless spinwait case:

 CPU 0							CPU 1
 rt_mutex_lock(lock)					rt_mutex_lock(lock);
   queue(waiter0)
   waiter0 == rt_mutex_top_waiter(lock)
   rt_mutex_spin_on_onwer(lock, waiter0) {		queue(waiter1)
   					 		waiter1 == rt_mutex_top_waiter(lock)
   							...
     top_waiter = rt_mutex_top_waiter(lock)
       leftmost = rb_first_cached(&lock->waiters);
							-> signal
							dequeue(waiter1)
							destroy(waiter1)
       w = rb_entry(leftmost, ....)
       BUG_ON(w->lock != lock)	 <- UAF

The BUG_ON() is correct for the case where the caller holds lock->wait_lock
which guarantees that the leftmost waiter entry cannot vanish. For the
lockless spinwait case it's broken.

Create a new helper function which avoids the pointer dereference and just
compares the leftmost entry pointer with current's waiter pointer to
validate that currrent is still elegible for spinning.

Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210825102453.981720644@linutronix.de
---
 kernel/locking/rtmutex.c        |  5 +++--
 kernel/locking/rtmutex_common.h | 13 +++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8aaa352..b3c0961 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1329,8 +1329,9 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 		 *    for CONFIG_PREEMPT_RCU=y)
 		 *  - the VCPU on which owner runs is preempted
 		 */
-		if (!owner->on_cpu || waiter != rt_mutex_top_waiter(lock) ||
-		    need_resched() || vcpu_is_preempted(task_cpu(owner))) {
+		if (!owner->on_cpu || need_resched() ||
+		    rt_mutex_waiter_is_top_waiter(lock, waiter) ||
+		    vcpu_is_preempted(task_cpu(owner))) {
 			res = false;
 			break;
 		}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 61256de..c47e836 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -95,6 +95,19 @@ static inline int rt_mutex_has_waiters(struct rt_mutex_base *lock)
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
 
+/*
+ * Lockless speculative check whether @waiter is still the top waiter on
+ * @lock. This is solely comparing pointers and not derefencing the
+ * leftmost entry which might be about to vanish.
+ */
+static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
+						 struct rt_mutex_waiter *waiter)
+{
+	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
+
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+}
+
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
