Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E43AC9C6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhFRL0R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhFRL0Q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 07:26:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F701C06175F;
        Fri, 18 Jun 2021 04:24:06 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:24:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624015445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kg1rCNOazPnQToXce5+ufMYrDMOStbUxKKuCH6swu48=;
        b=uzMiicWmgkhQtz0YRBFnLz7hao2J08rsfEdPkd+tgsWGTWECPFl8iAmr4rxKgNK76W/kkU
        Dw1xwj/3dbcpkUemtpzEprNR8NZ2GuoPaceRYl6QJWP2Aupn895QoAEXCSYOIwIw/eVqwB
        Y6E6HJLSg5jJKVY7tMimts8RmWkFPcU1KW1mTuB00yjK74tmvtxP2jVv0Y0wcX1dKLzrt4
        1MLlaBxX90HcRuK75AQaGv4KBah/UK8Yhh1CXmgRXfJRAQQrb4697Owj6aMHBA321nPzKB
        r07dQ7G+gHxSh0yjbrksRQRmyrfugmND6n4NCQSihM9Hd7VxGEFeM5R1iSeEaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624015445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kg1rCNOazPnQToXce5+ufMYrDMOStbUxKKuCH6swu48=;
        b=ckU1/h3u11ps5dpB+MDhXJXrdQo2zGy65CFQUc+fbuQ7wpk+kFlvwTl/1dBehoCS+nboci
        BhGZ7eRTjArxLTBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce task_is_running()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210611082838.222401495@infradead.org>
References: <20210611082838.222401495@infradead.org>
MIME-Version: 1.0
Message-ID: <162401544455.19906.2911216526971599152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b03fbd4ff24c5f075e58eb19261d5f8b3e40d7c6
Gitweb:        https://git.kernel.org/tip/b03fbd4ff24c5f075e58eb19261d5f8b3e40d7c6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 10:28:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Jun 2021 11:43:07 +02:00

sched: Introduce task_is_running()

Replace a bunch of 'p->state == TASK_RUNNING' with a new helper:
task_is_running(p).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210611082838.222401495@infradead.org
---
 arch/alpha/kernel/process.c    | 2 +-
 arch/arc/kernel/stacktrace.c   | 2 +-
 arch/arm/kernel/process.c      | 2 +-
 arch/arm64/kernel/process.c    | 2 +-
 arch/csky/kernel/stacktrace.c  | 2 +-
 arch/h8300/kernel/process.c    | 2 +-
 arch/hexagon/kernel/process.c  | 2 +-
 arch/ia64/kernel/process.c     | 4 ++--
 arch/m68k/kernel/process.c     | 2 +-
 arch/mips/kernel/process.c     | 2 +-
 arch/nds32/kernel/process.c    | 2 +-
 arch/nios2/kernel/process.c    | 2 +-
 arch/parisc/kernel/process.c   | 4 ++--
 arch/powerpc/kernel/process.c  | 4 ++--
 arch/riscv/kernel/stacktrace.c | 2 +-
 arch/s390/kernel/process.c     | 2 +-
 arch/s390/mm/fault.c           | 2 +-
 arch/sh/kernel/process_32.c    | 2 +-
 arch/sparc/kernel/process_32.c | 3 +--
 arch/sparc/kernel/process_64.c | 3 +--
 arch/um/kernel/process.c       | 2 +-
 arch/x86/kernel/process.c      | 4 ++--
 arch/xtensa/kernel/process.c   | 2 +-
 block/blk-mq.c                 | 2 +-
 include/linux/sched.h          | 2 ++
 kernel/kcsan/report.c          | 2 +-
 kernel/locking/lockdep.c       | 2 +-
 kernel/rcu/tree_plugin.h       | 2 +-
 kernel/sched/core.c            | 6 +++---
 kernel/sched/stats.h           | 2 +-
 kernel/signal.c                | 2 +-
 kernel/softirq.c               | 3 +--
 mm/compaction.c                | 2 +-
 33 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5112ab9..ef0c08e 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -380,7 +380,7 @@ get_wchan(struct task_struct *p)
 {
 	unsigned long schedule_frame;
 	unsigned long pc;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 	/*
 	 * This one depends on the frame size of schedule().  Do a
diff --git a/arch/arc/kernel/stacktrace.c b/arch/arc/kernel/stacktrace.c
index f73da20..1b9576d 100644
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -83,7 +83,7 @@ seed_unwind_frame_info(struct task_struct *tsk, struct pt_regs *regs,
 		 *    is safe-kept and BLINK at a well known location in there
 		 */
 
-		if (tsk->state == TASK_RUNNING)
+		if (task_is_running(tsk))
 			return -1;
 
 		frame_info->task = tsk;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 6324f4d..fc9e8b3 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -288,7 +288,7 @@ unsigned long get_wchan(struct task_struct *p)
 	struct stackframe frame;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	frame.fp = thread_saved_fp(p);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b4bb67f..14f3c19 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -598,7 +598,7 @@ unsigned long get_wchan(struct task_struct *p)
 	struct stackframe frame;
 	unsigned long stack_page, ret = 0;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)try_get_task_stack(p);
diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.c
index 16ae20a..1b280ef 100644
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -115,7 +115,7 @@ unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc = 0;
 
-	if (likely(task && task != current && task->state != TASK_RUNNING))
+	if (likely(task && task != current && !task_is_running(task)))
 		walk_stackframe(task, NULL, save_wchan, &pc);
 	return pc;
 }
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 46b1342..2ac27e4 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -134,7 +134,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long stack_page;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)p;
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index c61165c..6a6835f 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -135,7 +135,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)task_stack_page(p);
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 7e1a152..e56d63f 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -529,7 +529,7 @@ get_wchan (struct task_struct *p)
 	unsigned long ip;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	/*
@@ -542,7 +542,7 @@ get_wchan (struct task_struct *p)
 	 */
 	unw_init_from_blocked_task(&info, p);
 	do {
-		if (p->state == TASK_RUNNING)
+		if (task_is_running(p))
 			return 0;
 		if (unw_unwind(&info) < 0)
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index da83cc8..db49f90 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -268,7 +268,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)task_stack_page(p);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index bff080d..73c8e79 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -662,7 +662,7 @@ unsigned long get_wchan(struct task_struct *task)
 	unsigned long ra = 0;
 #endif
 
-	if (!task || task == current || task->state == TASK_RUNNING)
+	if (!task || task == current || task_is_running(task))
 		goto out;
 	if (!task_stack_page(task))
 		goto out;
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index c1327e5..391895b 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -239,7 +239,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long stack_start, stack_end;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index c5f916c..9ff37ba 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -223,7 +223,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long stack_page;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)p;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index b144fbe..184ec3c 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -249,7 +249,7 @@ get_wchan(struct task_struct *p)
 	unsigned long ip;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	/*
@@ -260,7 +260,7 @@ get_wchan(struct task_struct *p)
 	do {
 		if (unwind_once(&info) < 0)
 			return 0;
-		if (p->state == TASK_RUNNING)
+		if (task_is_running(p))
                         return 0;
 		ip = info.ip;
 		if (!in_sched_functions(ip))
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 89e34aa..8935c56 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2084,7 +2084,7 @@ static unsigned long __get_wchan(struct task_struct *p)
 	unsigned long ip, sp;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	sp = p->thread.ksp;
@@ -2094,7 +2094,7 @@ static unsigned long __get_wchan(struct task_struct *p)
 	do {
 		sp = *(unsigned long *)sp;
 		if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD) ||
-		    p->state == TASK_RUNNING)
+		    task_is_running(p))
 			return 0;
 		if (count > 0) {
 			ip = ((unsigned long *)sp)[STACK_FRAME_LR_SAVE];
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index bde85fc..ff467b9 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -132,7 +132,7 @@ unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc = 0;
 
-	if (likely(task && task != current && task->state != TASK_RUNNING))
+	if (likely(task && task != current && !task_is_running(task)))
 		walk_stackframe(task, NULL, save_wchan, &pc);
 	return pc;
 }
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index e20bed1..7ae5dde 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -180,7 +180,7 @@ unsigned long get_wchan(struct task_struct *p)
 	struct unwind_state state;
 	unsigned long ip = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING || !task_stack_page(p))
+	if (!p || p == current || task_is_running(p) || !task_stack_page(p))
 		return 0;
 
 	if (!try_get_task_stack(p))
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 826d017..8ae3dc5 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -702,7 +702,7 @@ static void pfault_interrupt(struct ext_code ext_code,
 			 * interrupt since it must be a leftover of a PFAULT
 			 * CANCEL operation which didn't remove all pending
 			 * completion interrupts. */
-			if (tsk->state == TASK_RUNNING)
+			if (task_is_running(tsk))
 				tsk->thread.pfault_wait = -1;
 		}
 	} else {
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 1aa508e..717de05 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -186,7 +186,7 @@ unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long pc;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	/*
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 3b97949..93983d6 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -376,8 +376,7 @@ unsigned long get_wchan(struct task_struct *task)
 	struct reg_window32 *rw;
 	int count = 0;
 
-	if (!task || task == current ||
-            task->state == TASK_RUNNING)
+	if (!task || task == current || task_is_running(task))
 		goto out;
 
 	fp = task_thread_info(task)->ksp + bias;
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 7afd0a8..d33c58a 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -674,8 +674,7 @@ unsigned long get_wchan(struct task_struct *task)
         unsigned long ret = 0;
 	int count = 0; 
 
-	if (!task || task == current ||
-            task->state == TASK_RUNNING)
+	if (!task || task == current || task_is_running(task))
 		goto out;
 
 	tp = task_thread_info(task);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index c501106..457a38d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -369,7 +369,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long stack_page, sp, ip;
 	bool seen_sched = 0;
 
-	if ((p == NULL) || (p == current) || (p->state == TASK_RUNNING))
+	if ((p == NULL) || (p == current) || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long) task_stack_page(p);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e1f381..e52b208 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -931,7 +931,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
 	int count = 0;
 
-	if (p == current || p->state == TASK_RUNNING)
+	if (p == current || task_is_running(p))
 		return 0;
 
 	if (!try_get_task_stack(p))
@@ -975,7 +975,7 @@ unsigned long get_wchan(struct task_struct *p)
 			goto out;
 		}
 		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && p->state != TASK_RUNNING);
+	} while (count++ < 16 && !task_is_running(p));
 
 out:
 	put_task_stack(p);
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 9534ef5..0601653 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -304,7 +304,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long stack_page = (unsigned long) task_stack_page(p);
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	sp = p->thread.sp;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c86c01b..655db5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3926,7 +3926,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 		if (signal_pending_state(state, current))
 			__set_current_state(TASK_RUNNING);
 
-		if (current->state == TASK_RUNNING)
+		if (task_is_running(current))
 			return 1;
 		if (ret < 0 || !spin)
 			break;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ac5a7d2..2cd5635 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -113,6 +113,8 @@ struct task_group;
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
 					 TASK_PARKED)
 
+#define task_is_running(task)		(READ_ONCE((task)->state) == TASK_RUNNING)
+
 #define task_is_traced(task)		((task->state & __TASK_TRACED) != 0)
 
 #define task_is_stopped(task)		((task->state & __TASK_STOPPED) != 0)
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 13dce3c..56016e8 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -460,7 +460,7 @@ static void set_other_info_task_blocking(unsigned long *flags,
 	 * We may be instrumenting a code-path where current->state is already
 	 * something other than TASK_RUNNING.
 	 */
-	const bool is_running = current->state == TASK_RUNNING;
+	const bool is_running = task_is_running(current);
 	/*
 	 * To avoid deadlock in case we are in an interrupt here and this is a
 	 * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), provide a
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7641bd4..4931a93 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -760,7 +760,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
 	 */
-	if (p->state == TASK_RUNNING && p != current)
+	if (p != current && task_is_running(p))
 		return;
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b..4d69620 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2768,7 +2768,7 @@ EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 #ifdef CONFIG_SMP
 static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
 {
-	return tsp && tsp->state == TASK_RUNNING && !tsp->on_cpu ? "!" : "";
+	return tsp && task_is_running(tsp) && !tsp->on_cpu ? "!" : "";
 }
 #else // #ifdef CONFIG_SMP
 static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75655cd..618c2b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5974,7 +5974,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 {
 	unsigned int task_flags;
 
-	if (!tsk->state)
+	if (task_is_running(tsk))
 		return;
 
 	task_flags = tsk->flags;
@@ -7949,7 +7949,7 @@ again:
 	if (curr->sched_class != p->sched_class)
 		goto out_unlock;
 
-	if (task_running(p_rq, p) || p->state)
+	if (task_running(p_rq, p) || !task_is_running(p))
 		goto out_unlock;
 
 	yielded = curr->sched_class->yield_to_task(rq, p);
@@ -8152,7 +8152,7 @@ void sched_show_task(struct task_struct *p)
 
 	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
 
-	if (p->state == TASK_RUNNING)
+	if (task_is_running(p))
 		pr_cont("  running task    ");
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 111072e..d8f8eb0 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -217,7 +217,7 @@ static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
 
 	rq_sched_info_depart(rq, delta);
 
-	if (t->state == TASK_RUNNING)
+	if (task_is_running(t))
 		sched_info_enqueue(rq, t);
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffc..5fc8fcf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4719,7 +4719,7 @@ void kdb_send_sig(struct task_struct *t, int sig)
 	}
 	new_t = kdb_prev_t != t;
 	kdb_prev_t = t;
-	if (t->state != TASK_RUNNING && new_t) {
+	if (!task_is_running(t) && new_t) {
 		spin_unlock(&t->sighand->siglock);
 		kdb_printf("Process is not RUNNING, sending a signal from "
 			   "kdb risks deadlock\n"
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5ddc3b1..f3a0121 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,8 +92,7 @@ static bool ksoftirqd_running(unsigned long pending)
 
 	if (pending & SOFTIRQ_NOW_MASK)
 		return false;
-	return tsk && (tsk->state == TASK_RUNNING) &&
-		!__kthread_should_park(tsk);
+	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
 }
 
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/mm/compaction.c b/mm/compaction.c
index 84fde27..725f564 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1955,7 +1955,7 @@ static inline bool is_via_compact_memory(int order)
 
 static bool kswapd_is_running(pg_data_t *pgdat)
 {
-	return pgdat->kswapd && (pgdat->kswapd->state == TASK_RUNNING);
+	return pgdat->kswapd && task_is_running(pgdat->kswapd);
 }
 
 /*
