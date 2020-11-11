Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4A2AEB0C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKKIXs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36286 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgKKIX1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:27 -0500
Date:   Wed, 11 Nov 2020 08:23:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pzpn1kPr16DfTpHI2+SSmyKhry05qUuNysR6hEjmJsg=;
        b=Zx/NY02Ia8p6YBof9CEcc8IFB9TjemsOJiDrgSgBuY5pYeKQyuDO1fzcTkKEghKW5ah9EQ
        njBhY69cyp2jgcZZvBeHc+8LjwUxQbgYg6MD4LImFL0kucEmPurPaOGZPLwE4MNB56LgfI
        Ub0mPMSdLYfwBanF20hFKp/fpvd8W85v+DnNXpGkm4pWXrmYHs6MtrUB6xMQt4QeWLjBJu
        3PMCOzuyLq6uHmDeWQljDnGSL1+/GZWxqG6GTg6KPOMVbIRah1lWpgh2KMPUCfM0uweUK6
        oM7laDqIjTFhl67DfK58wK2QjgdQu4UMmJ0fzDNI4SKogc1pBgP5pIyEU+BnnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pzpn1kPr16DfTpHI2+SSmyKhry05qUuNysR6hEjmJsg=;
        b=2BxCSWPCQ6F+cgZf+qJCp7b/xODESMOOvU37zNSfupJck1ymqrz6CXD+9+JciHoulNWkNe
        EVoGlxkauoSTjVDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] stop_machine: Add function and caller debug info
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.116513635@infradead.org>
References: <20201023102346.116513635@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300457.11244.14762732628813639514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a8b62fd0850503cf1e557d7e5a98d3f1f5c25eef
Gitweb:        https://git.kernel.org/tip/a8b62fd0850503cf1e557d7e5a98d3f1f5c25eef
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Sep 2020 12:58:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:57 +01:00

stop_machine: Add function and caller debug info

Crashes in stop-machine are hard to connect to the calling code, add a
little something to help with that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.116513635@infradead.org
---
 include/linux/stop_machine.h |  5 +++++
 kernel/sched/core.c          |  1 +
 kernel/stop_machine.c        | 27 ++++++++++++++++++++++++---
 lib/dump_stack.c             |  2 ++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 76d8b09..30577c3 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -24,6 +24,7 @@ typedef int (*cpu_stop_fn_t)(void *arg);
 struct cpu_stop_work {
 	struct list_head	list;		/* cpu_stopper->works */
 	cpu_stop_fn_t		fn;
+	unsigned long		caller;
 	void			*arg;
 	struct cpu_stop_done	*done;
 };
@@ -36,6 +37,8 @@ void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
 
+extern void print_stop_info(const char *log_lvl, struct task_struct *task);
+
 #else	/* CONFIG_SMP */
 
 #include <linux/workqueue.h>
@@ -80,6 +83,8 @@ static inline bool stop_one_cpu_nowait(unsigned int cpu,
 	return false;
 }
 
+static inline void print_stop_info(const char *log_lvl, struct task_struct *task) { }
+
 #endif	/* CONFIG_SMP */
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7..5e24104 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6447,6 +6447,7 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
+	print_stop_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 865bb02..3cf567c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -42,11 +42,27 @@ struct cpu_stopper {
 	struct list_head	works;		/* list of pending works */
 
 	struct cpu_stop_work	stop_work;	/* for stop_cpus */
+	unsigned long		caller;
+	cpu_stop_fn_t		fn;
 };
 
 static DEFINE_PER_CPU(struct cpu_stopper, cpu_stopper);
 static bool stop_machine_initialized = false;
 
+void print_stop_info(const char *log_lvl, struct task_struct *task)
+{
+	/*
+	 * If @task is a stopper task, it cannot migrate and task_cpu() is
+	 * stable.
+	 */
+	struct cpu_stopper *stopper = per_cpu_ptr(&cpu_stopper, task_cpu(task));
+
+	if (task != stopper->thread)
+		return;
+
+	printk("%sStopper: %pS <- %pS\n", log_lvl, stopper->fn, (void *)stopper->caller);
+}
+
 /* static data for stop_cpus */
 static DEFINE_MUTEX(stop_cpus_mutex);
 static bool stop_cpus_in_progress;
@@ -123,7 +139,7 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 {
 	struct cpu_stop_done done;
-	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done };
+	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done, .caller = _RET_IP_ };
 
 	cpu_stop_init_done(&done, 1);
 	if (!cpu_stop_queue_work(cpu, &work))
@@ -331,7 +347,8 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 	work1 = work2 = (struct cpu_stop_work){
 		.fn = multi_cpu_stop,
 		.arg = &msdata,
-		.done = &done
+		.done = &done,
+		.caller = _RET_IP_,
 	};
 
 	cpu_stop_init_done(&done, 2);
@@ -367,7 +384,7 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			struct cpu_stop_work *work_buf)
 {
-	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, };
+	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, .caller = _RET_IP_, };
 	return cpu_stop_queue_work(cpu, work_buf);
 }
 
@@ -487,6 +504,8 @@ repeat:
 		int ret;
 
 		/* cpu stop callbacks must not sleep, make in_atomic() == T */
+		stopper->caller = work->caller;
+		stopper->fn = fn;
 		preempt_count_inc();
 		ret = fn(arg);
 		if (done) {
@@ -495,6 +514,8 @@ repeat:
 			cpu_stop_signal_done(done);
 		}
 		preempt_count_dec();
+		stopper->fn = NULL;
+		stopper->caller = 0;
 		WARN_ONCE(preempt_count(),
 			  "cpu_stop: %ps(%p) leaked preempt count\n", fn, arg);
 		goto repeat;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index a00ee6e..f5a33b6 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/kexec.h>
 #include <linux/utsname.h>
+#include <linux/stop_machine.h>
 
 static char dump_stack_arch_desc_str[128];
 
@@ -57,6 +58,7 @@ void dump_stack_print_info(const char *log_lvl)
 		       log_lvl, dump_stack_arch_desc_str);
 
 	print_worker_info(log_lvl, current);
+	print_stop_info(log_lvl, current);
 }
 
 /**
