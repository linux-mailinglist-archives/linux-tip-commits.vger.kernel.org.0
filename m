Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE96D1FF508
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jun 2020 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgFROnk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Jun 2020 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFROni (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Jun 2020 10:43:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4AAC06174E;
        Thu, 18 Jun 2020 07:43:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlvlA-000445-Qe; Thu, 18 Jun 2020 16:43:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 540051C0087;
        Thu, 18 Jun 2020 16:43:20 +0200 (CEST)
Date:   Thu, 18 Jun 2020 14:43:20 -0000
From:   "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Split header file into lockdep and lockdep_types
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <E1jlSJz-0003hE-8g@fornost.hmeau.com>
References: <E1jlSJz-0003hE-8g@fornost.hmeau.com>
MIME-Version: 1.0
Message-ID: <159249140001.16989.17025686502742755136.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c935cd62d3fe985d7f0ebea185d2759e8992e96f
Gitweb:        https://git.kernel.org/tip/c935cd62d3fe985d7f0ebea185d2759e8992e96f
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Wed, 17 Jun 2020 17:17:19 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Jun 2020 18:33:13 +02:00

lockdep: Split header file into lockdep and lockdep_types

There is a header file inclusion loop between asm-generic/bug.h
and linux/kernel.h.  This causes potential compile failurs depending
on the which file is included first.  One way of breaking this loop
is to stop spinlock_types.h from including lockdep.h.  This patch
splits lockdep.h into two files for this purpose.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/E1jlSJz-0003hE-8g@fornost.hmeau.com
---
 include/linux/lockdep.h        | 178 +-----------------------------
 include/linux/lockdep_types.h  | 196 ++++++++++++++++++++++++++++++++-
 include/linux/spinlock.h       |   1 +-
 include/linux/spinlock_types.h |   2 +-
 4 files changed, 200 insertions(+), 177 deletions(-)
 create mode 100644 include/linux/lockdep_types.h

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 8fce5c9..3b73cf8 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -10,181 +10,20 @@
 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H
 
+#include <linux/lockdep_types.h>
+
 struct task_struct;
-struct lockdep_map;
 
 /* for sysctl */
 extern int prove_locking;
 extern int lock_stat;
 
-#define MAX_LOCKDEP_SUBCLASSES		8UL
-
-#include <linux/types.h>
-
-enum lockdep_wait_type {
-	LD_WAIT_INV = 0,	/* not checked, catch all */
-
-	LD_WAIT_FREE,		/* wait free, rcu etc.. */
-	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
-
-#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
-	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
-#else
-	LD_WAIT_CONFIG = LD_WAIT_SPIN,
-#endif
-	LD_WAIT_SLEEP,		/* sleeping locks, mutex_t etc.. */
-
-	LD_WAIT_MAX,		/* must be last */
-};
-
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
-#include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
 
-/*
- * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
- * the total number of states... :-(
- */
-#define XXX_LOCK_USAGE_STATES		(1+2*4)
-
-/*
- * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
- * cached in the instance of lockdep_map
- *
- * Currently main class (subclass == 0) and signle depth subclass
- * are cached in lockdep_map. This optimization is mainly targeting
- * on rq->lock. double_rq_lock() acquires this highly competitive with
- * single depth.
- */
-#define NR_LOCKDEP_CACHING_CLASSES	2
-
-/*
- * A lockdep key is associated with each lock object. For static locks we use
- * the lock address itself as the key. Dynamically allocated lock objects can
- * have a statically or dynamically allocated key. Dynamically allocated lock
- * keys must be registered before being used and must be unregistered before
- * the key memory is freed.
- */
-struct lockdep_subclass_key {
-	char __one_byte;
-} __attribute__ ((__packed__));
-
-/* hash_entry is used to keep track of dynamically allocated keys. */
-struct lock_class_key {
-	union {
-		struct hlist_node		hash_entry;
-		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
-	};
-};
-
-extern struct lock_class_key __lockdep_no_validate__;
-
-struct lock_trace;
-
-#define LOCKSTAT_POINTS		4
-
-/*
- * The lock-class itself. The order of the structure members matters.
- * reinit_class() zeroes the key member and all subsequent members.
- */
-struct lock_class {
-	/*
-	 * class-hash:
-	 */
-	struct hlist_node		hash_entry;
-
-	/*
-	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
-	 * when not in use. Instances that are being freed are on one of the
-	 * zapped_classes lists.
-	 */
-	struct list_head		lock_entry;
-
-	/*
-	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
-	 */
-	struct list_head		locks_after, locks_before;
-
-	const struct lockdep_subclass_key *key;
-	unsigned int			subclass;
-	unsigned int			dep_gen_id;
-
-	/*
-	 * IRQ/softirq usage tracking bits:
-	 */
-	unsigned long			usage_mask;
-	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
-
-	/*
-	 * Generation counter, when doing certain classes of graph walking,
-	 * to ensure that we check one node only once:
-	 */
-	int				name_version;
-	const char			*name;
-
-	short				wait_type_inner;
-	short				wait_type_outer;
-
-#ifdef CONFIG_LOCK_STAT
-	unsigned long			contention_point[LOCKSTAT_POINTS];
-	unsigned long			contending_point[LOCKSTAT_POINTS];
-#endif
-} __no_randomize_layout;
-
-#ifdef CONFIG_LOCK_STAT
-struct lock_time {
-	s64				min;
-	s64				max;
-	s64				total;
-	unsigned long			nr;
-};
-
-enum bounce_type {
-	bounce_acquired_write,
-	bounce_acquired_read,
-	bounce_contended_write,
-	bounce_contended_read,
-	nr_bounce_types,
-
-	bounce_acquired = bounce_acquired_write,
-	bounce_contended = bounce_contended_write,
-};
-
-struct lock_class_stats {
-	unsigned long			contention_point[LOCKSTAT_POINTS];
-	unsigned long			contending_point[LOCKSTAT_POINTS];
-	struct lock_time		read_waittime;
-	struct lock_time		write_waittime;
-	struct lock_time		read_holdtime;
-	struct lock_time		write_holdtime;
-	unsigned long			bounces[nr_bounce_types];
-};
-
-struct lock_class_stats lock_stats(struct lock_class *class);
-void clear_lock_stats(struct lock_class *class);
-#endif
-
-/*
- * Map the lock object (the lock instance) to the lock-class object.
- * This is embedded into specific lock instances:
- */
-struct lockdep_map {
-	struct lock_class_key		*key;
-	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
-	const char			*name;
-	short				wait_type_outer; /* can be taken in this context */
-	short				wait_type_inner; /* presents this context */
-#ifdef CONFIG_LOCK_STAT
-	int				cpu;
-	unsigned long			ip;
-#endif
-};
-
 static inline void lockdep_copy_map(struct lockdep_map *to,
 				    struct lockdep_map *from)
 {
@@ -440,8 +279,6 @@ static inline void lock_set_subclass(struct lockdep_map *lock,
 
 extern void lock_downgrade(struct lockdep_map *lock, unsigned long ip);
 
-struct pin_cookie { unsigned int val; };
-
 #define NIL_COOKIE (struct pin_cookie){ .val = 0U, }
 
 extern struct pin_cookie lock_pin_lock(struct lockdep_map *lock);
@@ -520,10 +357,6 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 # define lockdep_reset()		do { debug_locks = 1; } while (0)
 # define lockdep_free_key_range(start, size)	do { } while (0)
 # define lockdep_sys_exit() 			do { } while (0)
-/*
- * The class key takes no space if lockdep is disabled:
- */
-struct lock_class_key { };
 
 static inline void lockdep_register_key(struct lock_class_key *key)
 {
@@ -533,11 +366,6 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
 {
 }
 
-/*
- * The lockdep_map takes no space if lockdep is disabled:
- */
-struct lockdep_map { };
-
 #define lockdep_depth(tsk)	(0)
 
 #define lockdep_is_held_type(l, r)		(1)
@@ -549,8 +377,6 @@ struct lockdep_map { };
 
 #define lockdep_recursing(tsk)			(0)
 
-struct pin_cookie { };
-
 #define NIL_COOKIE (struct pin_cookie){ }
 
 #define lockdep_pin_lock(l)			({ struct pin_cookie cookie = { }; cookie; })
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
new file mode 100644
index 0000000..7b93506
--- /dev/null
+++ b/include/linux/lockdep_types.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Runtime locking correctness validator
+ *
+ *  Copyright (C) 2006,2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
+ *
+ * see Documentation/locking/lockdep-design.rst for more details.
+ */
+#ifndef __LINUX_LOCKDEP_TYPES_H
+#define __LINUX_LOCKDEP_TYPES_H
+
+#include <linux/types.h>
+
+#define MAX_LOCKDEP_SUBCLASSES		8UL
+
+enum lockdep_wait_type {
+	LD_WAIT_INV = 0,	/* not checked, catch all */
+
+	LD_WAIT_FREE,		/* wait free, rcu etc.. */
+	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
+
+#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
+	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
+#else
+	LD_WAIT_CONFIG = LD_WAIT_SPIN,
+#endif
+	LD_WAIT_SLEEP,		/* sleeping locks, mutex_t etc.. */
+
+	LD_WAIT_MAX,		/* must be last */
+};
+
+#ifdef CONFIG_LOCKDEP
+
+#include <linux/list.h>
+
+/*
+ * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
+ * the total number of states... :-(
+ */
+#define XXX_LOCK_USAGE_STATES		(1+2*4)
+
+/*
+ * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
+ * cached in the instance of lockdep_map
+ *
+ * Currently main class (subclass == 0) and signle depth subclass
+ * are cached in lockdep_map. This optimization is mainly targeting
+ * on rq->lock. double_rq_lock() acquires this highly competitive with
+ * single depth.
+ */
+#define NR_LOCKDEP_CACHING_CLASSES	2
+
+/*
+ * A lockdep key is associated with each lock object. For static locks we use
+ * the lock address itself as the key. Dynamically allocated lock objects can
+ * have a statically or dynamically allocated key. Dynamically allocated lock
+ * keys must be registered before being used and must be unregistered before
+ * the key memory is freed.
+ */
+struct lockdep_subclass_key {
+	char __one_byte;
+} __attribute__ ((__packed__));
+
+/* hash_entry is used to keep track of dynamically allocated keys. */
+struct lock_class_key {
+	union {
+		struct hlist_node		hash_entry;
+		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
+	};
+};
+
+extern struct lock_class_key __lockdep_no_validate__;
+
+struct lock_trace;
+
+#define LOCKSTAT_POINTS		4
+
+/*
+ * The lock-class itself. The order of the structure members matters.
+ * reinit_class() zeroes the key member and all subsequent members.
+ */
+struct lock_class {
+	/*
+	 * class-hash:
+	 */
+	struct hlist_node		hash_entry;
+
+	/*
+	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
+	 * when not in use. Instances that are being freed are on one of the
+	 * zapped_classes lists.
+	 */
+	struct list_head		lock_entry;
+
+	/*
+	 * These fields represent a directed graph of lock dependencies,
+	 * to every node we attach a list of "forward" and a list of
+	 * "backward" graph nodes.
+	 */
+	struct list_head		locks_after, locks_before;
+
+	const struct lockdep_subclass_key *key;
+	unsigned int			subclass;
+	unsigned int			dep_gen_id;
+
+	/*
+	 * IRQ/softirq usage tracking bits:
+	 */
+	unsigned long			usage_mask;
+	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
+
+	/*
+	 * Generation counter, when doing certain classes of graph walking,
+	 * to ensure that we check one node only once:
+	 */
+	int				name_version;
+	const char			*name;
+
+	short				wait_type_inner;
+	short				wait_type_outer;
+
+#ifdef CONFIG_LOCK_STAT
+	unsigned long			contention_point[LOCKSTAT_POINTS];
+	unsigned long			contending_point[LOCKSTAT_POINTS];
+#endif
+} __no_randomize_layout;
+
+#ifdef CONFIG_LOCK_STAT
+struct lock_time {
+	s64				min;
+	s64				max;
+	s64				total;
+	unsigned long			nr;
+};
+
+enum bounce_type {
+	bounce_acquired_write,
+	bounce_acquired_read,
+	bounce_contended_write,
+	bounce_contended_read,
+	nr_bounce_types,
+
+	bounce_acquired = bounce_acquired_write,
+	bounce_contended = bounce_contended_write,
+};
+
+struct lock_class_stats {
+	unsigned long			contention_point[LOCKSTAT_POINTS];
+	unsigned long			contending_point[LOCKSTAT_POINTS];
+	struct lock_time		read_waittime;
+	struct lock_time		write_waittime;
+	struct lock_time		read_holdtime;
+	struct lock_time		write_holdtime;
+	unsigned long			bounces[nr_bounce_types];
+};
+
+struct lock_class_stats lock_stats(struct lock_class *class);
+void clear_lock_stats(struct lock_class *class);
+#endif
+
+/*
+ * Map the lock object (the lock instance) to the lock-class object.
+ * This is embedded into specific lock instances:
+ */
+struct lockdep_map {
+	struct lock_class_key		*key;
+	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
+	const char			*name;
+	short				wait_type_outer; /* can be taken in this context */
+	short				wait_type_inner; /* presents this context */
+#ifdef CONFIG_LOCK_STAT
+	int				cpu;
+	unsigned long			ip;
+#endif
+};
+
+struct pin_cookie { unsigned int val; };
+
+#else /* !CONFIG_LOCKDEP */
+
+/*
+ * The class key takes no space if lockdep is disabled:
+ */
+struct lock_class_key { };
+
+/*
+ * The lockdep_map takes no space if lockdep is disabled:
+ */
+struct lockdep_map { };
+
+struct pin_cookie { };
+
+#endif /* !LOCKDEP */
+
+#endif /* __LINUX_LOCKDEP_TYPES_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3770b3..f2f12d7 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -56,6 +56,7 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
+#include <linux/lockdep.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 6102e6b..b981caa 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -15,7 +15,7 @@
 # include <linux/spinlock_types_up.h>
 #endif
 
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 
 typedef struct raw_spinlock {
 	arch_spinlock_t raw_lock;
