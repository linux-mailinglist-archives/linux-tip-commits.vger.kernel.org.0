Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D211253FAC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Aug 2020 09:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgH0Hys (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Aug 2020 03:54:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgH0Hyc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:32 -0400
Date:   Thu, 27 Aug 2020 07:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W65aNKpI6d+zcohpeJXHlGMGnGyVGByCgC8YVny3pys=;
        b=afxL4HqHKn/IsncDbxfQjCKJo2ngKnghwBgWU0qkhEbJnyUtSbjvucTdU0pIqt+YkMmzFb
        P8fPj0Tqx18Hx9VVlJmfKJITCtig/S+vhUS2h+q7ML9mU7cZ7Js5o7qGnBEA3rK1/Ys/1e
        CKz/Bgg++YS1hS3yL6GwTd3DcYtXdQeUfi66y1NHjUjSNbYpKdYS6sdABVsdVUwA1HrgBU
        eGol6V9K3MmhZkksP9cLI64OL9IPluiXUsSWNkclpZ2GhuxZLx6i5qmphZKZnmrIemmECo
        WZkPuyKy7tc/HXvTYutIDgJF6fnAyXIAtZs8ut7Uf0sbLxzwHaWYDftLZfFSeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W65aNKpI6d+zcohpeJXHlGMGnGyVGByCgC8YVny3pys=;
        b=dxtkjhLW+P8OFBaHgjvQB5wZK62j/XCa2nfe481E0ZZhJZGXc4YZHQTX2a3JGHS45KoQ00
        E4CnDN7LPNq+G1Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Use raw_cpu_*() for per-cpu variables
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.192346882@infradead.org>
References: <20200821085348.192346882@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486889.20229.2481874013860233958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fddf9055a60dfcc97bda5ef03c8fa4108ed555c5
Gitweb:        https://git.kernel.org/tip/fddf9055a60dfcc97bda5ef03c8fa4108ed555c5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 20 Aug 2020 09:13:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:53 +02:00

lockdep: Use raw_cpu_*() for per-cpu variables

Sven reported that commit a21ee6055c30 ("lockdep: Change
hardirq{s_enabled,_context} to per-cpu variables") caused trouble on
s390 because their this_cpu_*() primitives disable preemption which
then lands back tracing.

On the one hand, per-cpu ops should use preempt_*able_notrace() and
raw_local_irq_*(), on the other hand, we can trivialy use raw_cpu_*()
ops for this.

Fixes: a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200821085348.192346882@infradead.org
---
 include/linux/irqflags.h |  6 +++---
 include/linux/lockdep.h  | 18 +++++++++++++-----
 kernel/locking/lockdep.c |  4 ++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index bd5c557..d7e50a2 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -53,13 +53,13 @@ DECLARE_PER_CPU(int, hardirq_context);
   extern void trace_hardirqs_off_finish(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define lockdep_hardirq_context()	(this_cpu_read(hardirq_context))
+# define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
-	if (this_cpu_inc_return(hardirq_context) == 1)	\
+	if (__this_cpu_inc_return(hardirq_context) == 1)\
 		current->hardirq_threaded = 0;		\
 } while (0)
 # define lockdep_hardirq_threaded()		\
@@ -68,7 +68,7 @@ do {						\
 } while (0)
 # define lockdep_hardirq_exit()			\
 do {						\
-	this_cpu_dec(hardirq_context);		\
+	__this_cpu_dec(hardirq_context);	\
 } while (0)
 # define lockdep_softirq_enter()		\
 do {						\
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 62a382d..6a584b3 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -535,19 +535,27 @@ do {									\
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
+/*
+ * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
+ * per-cpu variables. This is required because this_cpu_read() will potentially
+ * call into preempt/irq-disable and that obviously isn't right. This is also
+ * correct because when IRQs are enabled, it doesn't matter if we accidentally
+ * read the value from our previous CPU.
+ */
+
 #define lockdep_assert_irqs_enabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirqs_enabled));	\
 } while (0)
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
 } while (0)
 
 #define lockdep_assert_in_irq()						\
 do {									\
-	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
+	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirq_context));	\
 } while (0)
 
 #define lockdep_assert_preemption_enabled()				\
@@ -555,7 +563,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     debug_locks			&&		\
 		     (preempt_count() != 0		||		\
-		      !this_cpu_read(hardirqs_enabled)));		\
+		      !raw_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
@@ -563,7 +571,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     debug_locks			&&		\
 		     (preempt_count() == 0		&&		\
-		      this_cpu_read(hardirqs_enabled)));		\
+		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
 
 #else
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2fad21d..c872e95 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3756,7 +3756,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 
 skip_checks:
 	/* we'll do an OFF -> ON transition: */
-	this_cpu_write(hardirqs_enabled, 1);
+	__this_cpu_write(hardirqs_enabled, 1);
 	trace->hardirq_enable_ip = ip;
 	trace->hardirq_enable_event = ++trace->irq_events;
 	debug_atomic_inc(hardirqs_on_events);
@@ -3795,7 +3795,7 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
-		this_cpu_write(hardirqs_enabled, 0);
+		__this_cpu_write(hardirqs_enabled, 0);
 		trace->hardirq_disable_ip = ip;
 		trace->hardirq_disable_event = ++trace->irq_events;
 		debug_atomic_inc(hardirqs_off_events);
