Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7A6347263
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhCXHWt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhCXHWc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2121C0613DC;
        Wed, 24 Mar 2021 00:22:31 -0700 (PDT)
Date:   Wed, 24 Mar 2021 07:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLisSWFob10sZ4Ph1coypgNGYN8jPMEHCqTy7MPRqvM=;
        b=C4OUzXgPbTQaN27UzfawZcy5qf8kz3MYgz/Kvq8mGzOmNkM0WMhYntsCSq0e4UqsCYhxWv
        Y/20VSHRs/LuueE9d3nqK6Zm6BPEIvmVSTURBHV+CSN4HSScbMM1LmZ3waCKRjZClEQ1cM
        bESKGXX9ej4A60wqTm/UVDkLfzZHiahEdGEL3wL9ctj/x3k3/IJtZRqgJmEnJ/3FyOfj6b
        kBnBYhtPdLsh5kwkGTZgmGJl8Q7UyuTTqLz/a8oIhd7QksLu9ZiKu7InJQjx85jmRFUczp
        D7tc/shN6wnw2zXRik+VWMdvPUDtCCSU7Um01M0CpHBQQQGohlfU64rscQhTHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLisSWFob10sZ4Ph1coypgNGYN8jPMEHCqTy7MPRqvM=;
        b=bQdQq+yAMikgA/P2MCJh051vfq3CImJ38ZXAnzwoOh6Cn2xXcq3lJ+SB+XaGGV7kZwHpJ2
        YbLlyWTfuIdFvLAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Decrapify __rt_mutex_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213708.400351704@linutronix.de>
References: <20210323213708.400351704@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657054861.398.8416916314539432460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c86c6bdd1099f398706b59b145148f3d39a587b7
Gitweb:        https://git.kernel.org/tip/c86c6bdd1099f398706b59b145148f3d39a587b7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:08 +01:00

locking/rtmutex: Decrapify __rt_mutex_init()

The conditional debug handling is just another layer of obfuscation. Split
the function so rt_mutex_init_proxy_locked() can invoke the inner init and
__rt_mutex_init() gets the full treatment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213708.400351704@linutronix.de
---
 kernel/locking/rtmutex.c        | 11 ++++-------
 kernel/locking/rtmutex_common.h |  7 +++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0eac57c..c9c2ab5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1586,12 +1586,10 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 void __rt_mutex_init(struct rt_mutex *lock, const char *name,
 		     struct lock_class_key *key)
 {
-	lock->owner = NULL;
-	raw_spin_lock_init(&lock->wait_lock);
-	lock->waiters = RB_ROOT_CACHED;
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key, 0);
 
-	if (name && key)
-		debug_rt_mutex_init(lock, name, key);
+	__rt_mutex_basic_init(lock);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
@@ -1612,8 +1610,7 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
 void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
-	__rt_mutex_init(lock, NULL, NULL);
-	debug_rt_mutex_proxy_lock(lock, proxy_owner);
+	__rt_mutex_basic_init(lock);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 0350ae3..1e11855 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -88,6 +88,13 @@ enum rtmutex_chainwalk {
 	RT_MUTEX_FULL_CHAINWALK,
 };
 
+static inline void __rt_mutex_basic_init(struct rt_mutex *lock)
+{
+	lock->owner = NULL;
+	raw_spin_lock_init(&lock->wait_lock);
+	lock->waiters = RB_ROOT_CACHED;
+}
+
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
