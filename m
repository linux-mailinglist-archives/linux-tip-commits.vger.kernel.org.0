Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC0190969
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCXJUV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:20:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43885 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCXJQf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffi-0007wS-ND; Tue, 24 Mar 2020 10:16:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 43C4F1C0470;
        Tue, 24 Mar 2020 10:16:30 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:29 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Add some more RCU list patterns in the kernel
Cc:     Amol Grover <frextrite@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504138992.28353.8639106191007989335.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dc8cb9df2b863c71027c6fee8ce370775d739fc3
Gitweb:        https://git.kernel.org/tip/dc8cb9df2b863c71027c6fee8ce370775d739fc3
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 13 Feb 2020 16:38:21 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 27 Feb 2020 07:02:20 -08:00

doc: Add some more RCU list patterns in the kernel

- Add more information about RCU list patterns taking examples
from audit subsystem in the linux kernel.

- Keep the current audit examples, even though the kernel has changed.

- Modify inline text for better passage quality.

- Fix typo in code-blocks and improve code comments.

- Add text formatting (italics, bold and code) for better emphasis.

Patch originally submitted at
https://lore.kernel.org/patchwork/patch/1082804/

Co-developed-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/listRCU.rst | 275 +++++++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 64 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index 7956ff3..55d2b30 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -4,12 +4,61 @@ Using RCU to Protect Read-Mostly Linked Lists
 =============================================
 
 One of the best applications of RCU is to protect read-mostly linked lists
-("struct list_head" in list.h).  One big advantage of this approach
+(``struct list_head`` in list.h).  One big advantage of this approach
 is that all of the required memory barriers are included for you in
 the list macros.  This document describes several applications of RCU,
 with the best fits first.
 
-Example 1: Read-Side Action Taken Outside of Lock, No In-Place Updates
+
+Example 1: Read-mostly list: Deferred Destruction
+-------------------------------------------------
+
+A widely used usecase for RCU lists in the kernel is lockless iteration over
+all processes in the system. ``task_struct::tasks`` represents the list node that
+links all the processes. The list can be traversed in parallel to any list
+additions or removals.
+
+The traversal of the list is done using ``for_each_process()`` which is defined
+by the 2 macros::
+
+	#define next_task(p) \
+		list_entry_rcu((p)->tasks.next, struct task_struct, tasks)
+
+	#define for_each_process(p) \
+		for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+
+The code traversing the list of all processes typically looks like::
+
+	rcu_read_lock();
+	for_each_process(p) {
+		/* Do something with p */
+	}
+	rcu_read_unlock();
+
+The simplified code for removing a process from a task list is::
+
+	void release_task(struct task_struct *p)
+	{
+		write_lock(&tasklist_lock);
+		list_del_rcu(&p->tasks);
+		write_unlock(&tasklist_lock);
+		call_rcu(&p->rcu, delayed_put_task_struct);
+	}
+
+When a process exits, ``release_task()`` calls ``list_del_rcu(&p->tasks)`` under
+``tasklist_lock`` writer lock protection, to remove the task from the list of
+all tasks. The ``tasklist_lock`` prevents concurrent list additions/removals
+from corrupting the list. Readers using ``for_each_process()`` are not protected
+with the ``tasklist_lock``. To prevent readers from noticing changes in the list
+pointers, the ``task_struct`` object is freed only after one or more grace
+periods elapse (with the help of call_rcu()). This deferring of destruction
+ensures that any readers traversing the list will see valid ``p->tasks.next``
+pointers and deletion/freeing can happen in parallel with traversal of the list.
+This pattern is also called an **existence lock**, since RCU pins the object in
+memory until all existing readers finish.
+
+
+Example 2: Read-Side Action Taken Outside of Lock: No In-Place Updates
 ----------------------------------------------------------------------
 
 The best applications are cases where, if reader-writer locking were
@@ -26,7 +75,7 @@ added or deleted, rather than being modified in place.
 
 A straightforward example of this use of RCU may be found in the
 system-call auditing support.  For example, a reader-writer locked
-implementation of audit_filter_task() might be as follows::
+implementation of ``audit_filter_task()`` might be as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -34,7 +83,7 @@ implementation of audit_filter_task() might be as follows::
 		enum audit_state   state;
 
 		read_lock(&auditsc_lock);
-		/* Note: audit_netlink_sem held by caller. */
+		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
 				read_unlock(&auditsc_lock);
@@ -58,7 +107,7 @@ This means that RCU can be easily applied to the read side, as follows::
 		enum audit_state   state;
 
 		rcu_read_lock();
-		/* Note: audit_netlink_sem held by caller. */
+		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry_rcu(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
 				rcu_read_unlock();
@@ -69,18 +118,18 @@ This means that RCU can be easily applied to the read side, as follows::
 		return AUDIT_BUILD_CONTEXT;
 	}
 
-The read_lock() and read_unlock() calls have become rcu_read_lock()
+The ``read_lock()`` and ``read_unlock()`` calls have become rcu_read_lock()
 and rcu_read_unlock(), respectively, and the list_for_each_entry() has
-become list_for_each_entry_rcu().  The _rcu() list-traversal primitives
+become list_for_each_entry_rcu().  The **_rcu()** list-traversal primitives
 insert the read-side memory barriers that are required on DEC Alpha CPUs.
 
-The changes to the update side are also straightforward.  A reader-writer
-lock might be used as follows for deletion and insertion::
+The changes to the update side are also straightforward. A reader-writer lock
+might be used as follows for deletion and insertion::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
 	{
-		struct audit_entry  *e;
+		struct audit_entry *e;
 
 		write_lock(&auditsc_lock);
 		list_for_each_entry(e, list, list) {
@@ -113,9 +162,9 @@ Following are the RCU equivalents for these two functions::
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
 	{
-		struct audit_entry  *e;
+		struct audit_entry *e;
 
-		/* Do not use the _rcu iterator here, since this is the only
+		/* No need to use the _rcu iterator here, since this is the only
 		 * deletion routine. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
@@ -139,41 +188,41 @@ Following are the RCU equivalents for these two functions::
 		return 0;
 	}
 
-Normally, the write_lock() and write_unlock() would be replaced by
-a spin_lock() and a spin_unlock(), but in this case, all callers hold
-audit_netlink_sem, so no additional locking is required.  The auditsc_lock
-can therefore be eliminated, since use of RCU eliminates the need for
-writers to exclude readers.  Normally, the write_lock() calls would
-be converted into spin_lock() calls.
+Normally, the ``write_lock()`` and ``write_unlock()`` would be replaced by a
+spin_lock() and a spin_unlock(). But in this case, all callers hold
+``audit_filter_mutex``, so no additional locking is required. The
+``auditsc_lock`` can therefore be eliminated, since use of RCU eliminates the
+need for writers to exclude readers.
 
 The list_del(), list_add(), and list_add_tail() primitives have been
 replaced by list_del_rcu(), list_add_rcu(), and list_add_tail_rcu().
-The _rcu() list-manipulation primitives add memory barriers that are
-needed on weakly ordered CPUs (most of them!).  The list_del_rcu()
-primitive omits the pointer poisoning debug-assist code that would
-otherwise cause concurrent readers to fail spectacularly.
+The **_rcu()** list-manipulation primitives add memory barriers that are needed on
+weakly ordered CPUs (most of them!).  The list_del_rcu() primitive omits the
+pointer poisoning debug-assist code that would otherwise cause concurrent
+readers to fail spectacularly.
 
-So, when readers can tolerate stale data and when entries are either added
-or deleted, without in-place modification, it is very easy to use RCU!
+So, when readers can tolerate stale data and when entries are either added or
+deleted, without in-place modification, it is very easy to use RCU!
 
-Example 2: Handling In-Place Updates
+
+Example 3: Handling In-Place Updates
 ------------------------------------
 
-The system-call auditing code does not update auditing rules in place.
-However, if it did, reader-writer-locked code to do so might look as
-follows (presumably, the field_count is only permitted to decrease,
-otherwise, the added fields would need to be filled in)::
+The system-call auditing code does not update auditing rules in place.  However,
+if it did, the reader-writer-locked code to do so might look as follows
+(assuming only ``field_count`` is updated, otherwise, the added fields would
+need to be filled in)::
 
 	static inline int audit_upd_rule(struct audit_rule *rule,
 					 struct list_head *list,
 					 __u32 newaction,
 					 __u32 newfield_count)
 	{
-		struct audit_entry  *e;
-		struct audit_newentry *ne;
+		struct audit_entry *e;
+		struct audit_entry *ne;
 
 		write_lock(&auditsc_lock);
-		/* Note: audit_netlink_sem held by caller. */
+		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				e->rule.action = newaction;
@@ -188,16 +237,16 @@ otherwise, the added fields would need to be filled in)::
 
 The RCU version creates a copy, updates the copy, then replaces the old
 entry with the newly updated entry.  This sequence of actions, allowing
-concurrent reads while doing a copy to perform an update, is what gives
-RCU ("read-copy update") its name.  The RCU code is as follows::
+concurrent reads while making a copy to perform an update, is what gives
+RCU (*read-copy update*) its name.  The RCU code is as follows::
 
 	static inline int audit_upd_rule(struct audit_rule *rule,
 					 struct list_head *list,
 					 __u32 newaction,
 					 __u32 newfield_count)
 	{
-		struct audit_entry  *e;
-		struct audit_newentry *ne;
+		struct audit_entry *e;
+		struct audit_entry *ne;
 
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
@@ -215,34 +264,45 @@ RCU ("read-copy update") its name.  The RCU code is as follows::
 		return -EFAULT;		/* No matching rule */
 	}
 
-Again, this assumes that the caller holds audit_netlink_sem.  Normally,
-the reader-writer lock would become a spinlock in this sort of code.
+Again, this assumes that the caller holds ``audit_filter_mutex``.  Normally, the
+writer lock would become a spinlock in this sort of code.
 
-Example 3: Eliminating Stale Data
+Another use of this pattern can be found in the openswitch driver's *connection
+tracking table* code in ``ct_limit_set()``.  The table holds connection tracking
+entries and has a limit on the maximum entries.  There is one such table
+per-zone and hence one *limit* per zone.  The zones are mapped to their limits
+through a hashtable using an RCU-managed hlist for the hash chains. When a new
+limit is set, a new limit object is allocated and ``ct_limit_set()`` is called
+to replace the old limit object with the new one using list_replace_rcu().
+The old limit object is then freed after a grace period using kfree_rcu().
+
+
+Example 4: Eliminating Stale Data
 ---------------------------------
 
-The auditing examples above tolerate stale data, as do most algorithms
+The auditing example above tolerates stale data, as do most algorithms
 that are tracking external state.  Because there is a delay from the
 time the external state changes before Linux becomes aware of the change,
-additional RCU-induced staleness is normally not a problem.
+additional RCU-induced staleness is generally not a problem.
 
 However, there are many examples where stale data cannot be tolerated.
 One example in the Linux kernel is the System V IPC (see the ipc_lock()
-function in ipc/util.c).  This code checks a "deleted" flag under a
-per-entry spinlock, and, if the "deleted" flag is set, pretends that the
+function in ipc/util.c).  This code checks a *deleted* flag under a
+per-entry spinlock, and, if the *deleted* flag is set, pretends that the
 entry does not exist.  For this to be helpful, the search function must
-return holding the per-entry spinlock, as ipc_lock() does in fact do.
+return holding the per-entry lock, as ipc_lock() does in fact do.
+
+.. _quick_quiz:
 
 Quick Quiz:
-	Why does the search function need to return holding the per-entry lock for
-	this deleted-flag technique to be helpful?
+	For the deleted-flag technique to be helpful, why is it necessary
+	to hold the per-entry lock while returning from the search function?
 
-:ref:`Answer to Quick Quiz <answer_quick_quiz_list>`
+:ref:`Answer to Quick Quiz <quick_quiz_answer>`
 
-If the system-call audit module were to ever need to reject stale data,
-one way to accomplish this would be to add a "deleted" flag and a "lock"
-spinlock to the audit_entry structure, and modify audit_filter_task()
-as follows::
+If the system-call audit module were to ever need to reject stale data, one way
+to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
+audit_entry structure, and modify ``audit_filter_task()`` as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -267,20 +327,20 @@ as follows::
 	}
 
 Note that this example assumes that entries are only added and deleted.
-Additional mechanism is required to deal correctly with the
-update-in-place performed by audit_upd_rule().  For one thing,
-audit_upd_rule() would need additional memory barriers to ensure
-that the list_add_rcu() was really executed before the list_del_rcu().
+Additional mechanism is required to deal correctly with the update-in-place
+performed by ``audit_upd_rule()``.  For one thing, ``audit_upd_rule()`` would
+need additional memory barriers to ensure that the list_add_rcu() was really
+executed before the list_del_rcu().
 
-The audit_del_rule() function would need to set the "deleted"
-flag under the spinlock as follows::
+The ``audit_del_rule()`` function would need to set the ``deleted`` flag under the
+spinlock as follows::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
 	{
-		struct audit_entry  *e;
+		struct audit_entry *e;
 
-		/* Do not need to use the _rcu iterator here, since this
+		/* No need to use the _rcu iterator here, since this
 		 * is the only deletion routine. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
@@ -295,6 +355,91 @@ flag under the spinlock as follows::
 		return -EFAULT;		/* No matching rule */
 	}
 
+This too assumes that the caller holds ``audit_filter_mutex``.
+
+
+Example 5: Skipping Stale Objects
+---------------------------------
+
+For some usecases, reader performance can be improved by skipping stale objects
+during read-side list traversal if the object in concern is pending destruction
+after one or more grace periods. One such example can be found in the timerfd
+subsystem. When a ``CLOCK_REALTIME`` clock is reprogrammed - for example due to
+setting of the system time, then all programmed timerfds that depend on this
+clock get triggered and processes waiting on them to expire are woken up in
+advance of their scheduled expiry. To facilitate this, all such timers are added
+to an RCU-managed ``cancel_list`` when they are setup in
+``timerfd_setup_cancel()``::
+
+	static void timerfd_setup_cancel(struct timerfd_ctx *ctx, int flags)
+	{
+		spin_lock(&ctx->cancel_lock);
+		if ((ctx->clockid == CLOCK_REALTIME &&
+		    (flags & TFD_TIMER_ABSTIME) && (flags & TFD_TIMER_CANCEL_ON_SET)) {
+			if (!ctx->might_cancel) {
+				ctx->might_cancel = true;
+				spin_lock(&cancel_lock);
+				list_add_rcu(&ctx->clist, &cancel_list);
+				spin_unlock(&cancel_lock);
+			}
+		}
+		spin_unlock(&ctx->cancel_lock);
+	}
+
+When a timerfd is freed (fd is closed), then the ``might_cancel`` flag of the
+timerfd object is cleared, the object removed from the ``cancel_list`` and
+destroyed::
+
+	int timerfd_release(struct inode *inode, struct file *file)
+	{
+		struct timerfd_ctx *ctx = file->private_data;
+
+		spin_lock(&ctx->cancel_lock);
+		if (ctx->might_cancel) {
+			ctx->might_cancel = false;
+			spin_lock(&cancel_lock);
+			list_del_rcu(&ctx->clist);
+			spin_unlock(&cancel_lock);
+		}
+		spin_unlock(&ctx->cancel_lock);
+
+		hrtimer_cancel(&ctx->t.tmr);
+		kfree_rcu(ctx, rcu);
+		return 0;
+	}
+
+If the ``CLOCK_REALTIME`` clock is set, for example by a time server, the
+hrtimer framework calls ``timerfd_clock_was_set()`` which walks the
+``cancel_list`` and wakes up processes waiting on the timerfd. While iterating
+the ``cancel_list``, the ``might_cancel`` flag is consulted to skip stale
+objects::
+
+	void timerfd_clock_was_set(void)
+	{
+		struct timerfd_ctx *ctx;
+		unsigned long flags;
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(ctx, &cancel_list, clist) {
+			if (!ctx->might_cancel)
+				continue;
+			spin_lock_irqsave(&ctx->wqh.lock, flags);
+			if (ctx->moffs != ktime_mono_to_real(0)) {
+				ctx->moffs = KTIME_MAX;
+				ctx->ticks++;
+				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			}
+			spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+		}
+		rcu_read_unlock();
+	}
+
+The key point here is, because RCU-traversal of the ``cancel_list`` happens
+while objects are being added and removed to the list, sometimes the traversal
+can step on an object that has been removed from the list. In this example, it
+is seen that it is better to skip such objects using a flag.
+
+
 Summary
 -------
 
@@ -303,19 +448,21 @@ the most amenable to use of RCU.  The simplest case is where entries are
 either added or deleted from the data structure (or atomically modified
 in place), but non-atomic in-place modifications can be handled by making
 a copy, updating the copy, then replacing the original with the copy.
-If stale data cannot be tolerated, then a "deleted" flag may be used
+If stale data cannot be tolerated, then a *deleted* flag may be used
 in conjunction with a per-entry spinlock in order to allow the search
 function to reject newly deleted data.
 
-.. _answer_quick_quiz_list:
+.. _quick_quiz_answer:
 
 Answer to Quick Quiz:
-	Why does the search function need to return holding the per-entry
-	lock for this deleted-flag technique to be helpful?
+	For the deleted-flag technique to be helpful, why is it necessary
+	to hold the per-entry lock while returning from the search function?
 
 	If the search function drops the per-entry lock before returning,
 	then the caller will be processing stale data in any case.  If it
 	is really OK to be processing stale data, then you don't need a
-	"deleted" flag.  If processing stale data really is a problem,
+	*deleted* flag.  If processing stale data really is a problem,
 	then you need to hold the per-entry lock across all of the code
 	that uses the value that was returned.
+
+:ref:`Back to Quick Quiz <quick_quiz>`
