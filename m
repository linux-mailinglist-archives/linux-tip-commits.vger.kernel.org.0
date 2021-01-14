Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED712F6000
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhANLaQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbhANL3m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668AC061575;
        Thu, 14 Jan 2021 03:29:01 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ftCdvf869q+zXo2k4IaZJ+08ZWOBAo+7ZlN8I3/4fLc=;
        b=WN4k5yGOQauIOPj7iWmrz5pfNWUOCjaTOEk46CremKJ4LARhvm6hVvPSLUo0hMiHNHEjXc
        VaSfC9NxfpMAOmr/xLuLXEP62GBl/4lr31oEljr55qKuVLI6bN2Yat4Ghd8YMtfD+Mb1k8
        KMNDz6fUEDSEu31ixjNN+g5MK1ahjOBDDHhinATQfbGVshl9l0bH98BnuUuqZgy9//ljWY
        0ZEKaLzXHkJJ7SfaW8Qo75DOn9pN0wNc1+TC4cv9XA6bCgIoN9f1NCZ2rfgG3GhvqFnX3X
        q86pMZaY2AfMFvuLB6oMXP4895ptsanrRbEtuzJ8DHxmK6VGKj2lwOMVKwQCdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ftCdvf869q+zXo2k4IaZJ+08ZWOBAo+7ZlN8I3/4fLc=;
        b=J7JasIoNFQkbPvNkeiAmL9omm+bHLcG6F55eaEFP/41vewUR2D+1T2BPykuv6sWV/9INh9
        icZceDgtycjc+OCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Mark local_lock_t
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161062373951.414.9599421860694947579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dfd5e3f5fe27bda91d5cc028c86ffbb7a0614489
Gitweb:        https://git.kernel.org/tip/dfd5e3f5fe27bda91d5cc028c86ffbb7a0614489
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Dec 2020 16:06:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:17 +01:00

locking/lockdep: Mark local_lock_t

The local_lock_t's are special, because they cannot form IRQ
inversions, make sure we can tell them apart from the rest of the
locks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/local_lock_internal.h |  5 ++++-
 include/linux/lockdep.h             | 15 ++++++++++++---
 include/linux/lockdep_types.h       | 18 ++++++++++++++----
 kernel/locking/lockdep.c            | 16 +++++++++-------
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 4a8795b..ded90b0 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -18,6 +18,7 @@ typedef struct {
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
+		.lock_type = LD_LOCK_PERCPU,			\
 	}
 #else
 # define LL_DEP_MAP_INIT(lockname)
@@ -30,7 +31,9 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
-	lockdep_init_map_wait(&(lock)->dep_map, #lock, &__key, 0, LD_WAIT_CONFIG);\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key, 0, \
+			      LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_PERCPU);			\
 } while (0)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b9e9ade..7b7ebf2 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -185,12 +185,19 @@ extern void lockdep_unregister_key(struct lock_class_key *key);
  * to lockdep:
  */
 
-extern void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
-	struct lock_class_key *key, int subclass, short inner, short outer);
+extern void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
+	struct lock_class_key *key, int subclass, u8 inner, u8 outer, u8 lock_type);
+
+static inline void
+lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+		       struct lock_class_key *key, int subclass, u8 inner, u8 outer)
+{
+	lockdep_init_map_type(lock, name, key, subclass, inner, LD_WAIT_INV, LD_LOCK_NORMAL);
+}
 
 static inline void
 lockdep_init_map_wait(struct lockdep_map *lock, const char *name,
-		      struct lock_class_key *key, int subclass, short inner)
+		      struct lock_class_key *key, int subclass, u8 inner)
 {
 	lockdep_init_map_waits(lock, name, key, subclass, inner, LD_WAIT_INV);
 }
@@ -340,6 +347,8 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 # define lock_set_class(l, n, k, s, i)		do { } while (0)
 # define lock_set_subclass(l, s, i)		do { } while (0)
 # define lockdep_init()				do { } while (0)
+# define lockdep_init_map_type(lock, name, key, sub, inner, outer, type) \
+		do { (void)(name); (void)(key); } while (0)
 # define lockdep_init_map_waits(lock, name, key, sub, inner, outer) \
 		do { (void)(name); (void)(key); } while (0)
 # define lockdep_init_map_wait(lock, name, key, sub, inner) \
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9a1fd49..2ec9ff5 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -30,6 +30,12 @@ enum lockdep_wait_type {
 	LD_WAIT_MAX,		/* must be last */
 };
 
+enum lockdep_lock_type {
+	LD_LOCK_NORMAL = 0,	/* normal, catch all */
+	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_MAX,
+};
+
 #ifdef CONFIG_LOCKDEP
 
 /*
@@ -119,8 +125,10 @@ struct lock_class {
 	int				name_version;
 	const char			*name;
 
-	short				wait_type_inner;
-	short				wait_type_outer;
+	u8				wait_type_inner;
+	u8				wait_type_outer;
+	u8				lock_type;
+	/* u8				hole; */
 
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
@@ -169,8 +177,10 @@ struct lockdep_map {
 	struct lock_class_key		*key;
 	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
 	const char			*name;
-	short				wait_type_outer; /* can be taken in this context */
-	short				wait_type_inner; /* presents this context */
+	u8				wait_type_outer; /* can be taken in this context */
+	u8				wait_type_inner; /* presents this context */
+	u8				lock_type;
+	/* u8				hole; */
 #ifdef CONFIG_LOCK_STAT
 	int				cpu;
 	unsigned long			ip;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c1418b4..b061e29 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1290,6 +1290,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	class->name_version = count_matching_names(class);
 	class->wait_type_inner = lock->wait_type_inner;
 	class->wait_type_outer = lock->wait_type_outer;
+	class->lock_type = lock->lock_type;
 	/*
 	 * We use RCU's safe list-add method to make
 	 * parallel walking of the hash-list safe:
@@ -4503,9 +4504,9 @@ print_lock_invalid_wait_context(struct task_struct *curr,
  */
 static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 {
-	short next_inner = hlock_class(next)->wait_type_inner;
-	short next_outer = hlock_class(next)->wait_type_outer;
-	short curr_inner;
+	u8 next_inner = hlock_class(next)->wait_type_inner;
+	u8 next_outer = hlock_class(next)->wait_type_outer;
+	u8 curr_inner;
 	int depth;
 
 	if (!curr->lockdep_depth || !next_inner || next->trylock)
@@ -4528,7 +4529,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
-		short prev_inner = hlock_class(prev)->wait_type_inner;
+		u8 prev_inner = hlock_class(prev)->wait_type_inner;
 
 		if (prev_inner) {
 			/*
@@ -4577,9 +4578,9 @@ static inline int check_wait_context(struct task_struct *curr,
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 			    struct lock_class_key *key, int subclass,
-			    short inner, short outer)
+			    u8 inner, u8 outer, u8 lock_type)
 {
 	int i;
 
@@ -4602,6 +4603,7 @@ void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 
 	lock->wait_type_outer = outer;
 	lock->wait_type_inner = inner;
+	lock->lock_type = lock_type;
 
 	/*
 	 * No key, no joy, we need to hash something.
@@ -4636,7 +4638,7 @@ void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 		raw_local_irq_restore(flags);
 	}
 }
-EXPORT_SYMBOL_GPL(lockdep_init_map_waits);
+EXPORT_SYMBOL_GPL(lockdep_init_map_type);
 
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
