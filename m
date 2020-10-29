Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0102B29E9AD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgJ2Kwr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgJ2Kvr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC0C0613CF;
        Thu, 29 Oct 2020 03:51:47 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4nuQ3rHyItpKz3DNsOe0exUKjdmQl/AWYBEs8xStZng=;
        b=fh7ILeiXZ78ba6mKuTJXNoRRd8zHHNd8bSYkTatXE4uV9C/R7LXhTLGa3hhZ860ksB0q8q
        tGr9vKgX3xDwY1xC64+10YaUK5aYuvl835UKIx7qeWi1+NUVn6dordvtNIMWPGa5knLhhc
        Tqd7zIMOehZ7/+50RXrJ+glDf3INHdrF02eSrWqtQk9HmLyCnTg9LpleaYku99Ebq56nUA
        e/BscG6VYdFzYppwAmK6bOJKL7Iz7pHF5eYr2CuF4wnTZE3ok+o5++M9YUFKy+Sl6SXVSB
        8HigzbJIxhgJm9q24n8rksjoFoLEKBT84fibMb83vQNIemQKv783vaEzynmJFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4nuQ3rHyItpKz3DNsOe0exUKjdmQl/AWYBEs8xStZng=;
        b=q9AvugvGS+6rsSF3+v2Uk2IGM6dWki3k2jvGyrXt3eWDmCnXRg9AW0WCb7DvhS44UsdGuF
        FAEhr/bJRl6PNmBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove relyance on STRUCT_ALIGNMENT
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Jelinek <jakub@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160396870486.397.377616182428528939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     43c31ac0e665d942fcaba83a725a8b1aeeb7adf0
Gitweb:        https://git.kernel.org/tip/43c31ac0e665d942fcaba83a725a8b1aeeb7adf0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 21 Oct 2020 15:45:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:32 +01:00

sched: Remove relyance on STRUCT_ALIGNMENT

Florian reported that all of kernel/sched/ is rebuild when
CONFIG_BLK_DEV_INITRD is changed, which, while not a bug is
unexpected. This is due to us including vmlinux.lds.h.

Jakub explained that the problem is that we put the alignment
requirement on the type instead of on a variable. Type alignment is a
minimum, the compiler is free to pick any larger alignment for a
specific instance of the type (eg. the variable).

So force the type alignment on all individual variable definitions and
remove the undesired dependency on vmlinux.lds.h.

Fixes: 85c2ce9104eb ("sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to 64 bytes for GCC-4.9")
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Suggested-by: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c  |  4 ++--
 kernel/sched/fair.c      |  4 ++--
 kernel/sched/idle.c      |  4 ++--
 kernel/sched/rt.c        |  4 ++--
 kernel/sched/sched.h     | 17 +++++++++++++++--
 kernel/sched/stop_task.c |  3 +--
 6 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0b45dd1..c6ce90f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2522,8 +2522,8 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	}
 }
 
-const struct sched_class dl_sched_class
-	__section("__dl_sched_class") = {
+DEFINE_SCHED_CLASS(dl) = {
+
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd9a37c..f30d35a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11171,8 +11171,8 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 /*
  * All the scheduling class methods:
  */
-const struct sched_class fair_sched_class
-	__section("__fair_sched_class") = {
+DEFINE_SCHED_CLASS(fair) = {
+
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 846743e..9da69c4 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -458,8 +458,8 @@ static void update_curr_idle(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
-const struct sched_class idle_sched_class
-	__section("__idle_sched_class") = {
+DEFINE_SCHED_CLASS(idle) = {
+
 	/* no enqueue/yield_task for idle tasks */
 
 	/* dequeue is not valid, we print a debug message there: */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8a3b1ba..9b27352 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2431,8 +2431,8 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 		return 0;
 }
 
-const struct sched_class rt_sched_class
-	__section("__rt_sched_class") = {
+DEFINE_SCHED_CLASS(rt) = {
+
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 965b296..3e45055 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,7 +67,6 @@
 #include <linux/tsacct_kern.h>
 
 #include <asm/tlb.h>
-#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -1836,7 +1835,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
+};
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
@@ -1850,6 +1849,20 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
+
+/*
+ * Helper to define a sched_class instance; each one is placed in a separate
+ * section which is ordered by the linker script:
+ *
+ *   include/asm-generic/vmlinux.lds.h
+ *
+ * Also enforce alignment on the instance, not the type, to guarantee layout.
+ */
+#define DEFINE_SCHED_CLASS(name) \
+const struct sched_class name##_sched_class \
+	__aligned(__alignof__(struct sched_class)) \
+	__section("__" #name "_sched_class")
+
 /* Defined in include/asm-generic/vmlinux.lds.h */
 extern struct sched_class __begin_sched_classes[];
 extern struct sched_class __end_sched_classes[];
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index ceb5b6b..91bb10c 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -109,8 +109,7 @@ static void update_curr_stop(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU stop tasks:
  */
-const struct sched_class stop_sched_class
-	__section("__stop_sched_class") = {
+DEFINE_SCHED_CLASS(stop) = {
 
 	.enqueue_task		= enqueue_task_stop,
 	.dequeue_task		= dequeue_task_stop,
