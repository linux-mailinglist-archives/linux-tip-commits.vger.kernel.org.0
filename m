Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C60367B2E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhDVHgj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbhDVHgi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 03:36:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE75C06138B;
        Thu, 22 Apr 2021 00:36:04 -0700 (PDT)
Date:   Thu, 22 Apr 2021 07:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619076962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcIjuvMJ40lZLPnI+sCDv0ss+pJjqSFdoBTIAe59r9k=;
        b=jTlBg7jE58L12ag16bpilKmd5yznfnNypcu5Cg3AKheaPNg3qJ3lPlJkvOBDuIGhPvMniv
        gT6puvi5y/zQ6d1fAnGgKOjxdRlkX5Hxw9pNv3xfGU9HGJDLiCPe0t3HfdDcErnjKSolLZ
        pJSkChLxnQlpeDhj4czJu8WmOMGLBAbEHqv5YdQekJkOEPPuaLOJCnU5mpDcgVYpPzvRiD
        fAAMD2AUQ5+hWsoP/iFJ/z9e/QkBIZPEjJo9aQ0atTIYEy+1r0xIhGuKO0e1BfdNCWKqkS
        14wiIhRF+oUzqwy25YNMw2ylVhMSC6H/bxA0MmPrkoomuCOK+oaUoxQKu6Rycw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619076962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcIjuvMJ40lZLPnI+sCDv0ss+pJjqSFdoBTIAe59r9k=;
        b=6lmUqNjVNWPGEvTlUf36YoBb6nJ3S6rxfThzDWGpQN5+amTbB+QxVRyjxGBbyp57GxmblH
        AOpIXn96oTTjzWDQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Fix cgroup_path[] serialization
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210415195426.6677-1-longman@redhat.com>
References: <20210415195426.6677-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <161907696201.29796.3255306539355382815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ad789f84c9a145f8a18744c0387cec22ec51651e
Gitweb:        https://git.kernel.org/tip/ad789f84c9a145f8a18744c0387cec22ec51651e
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 15 Apr 2021 15:54:26 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Apr 2021 13:55:42 +02:00

sched/debug: Fix cgroup_path[] serialization

The handling of sysrq key can be activated by echoing the key to
/proc/sysrq-trigger or via the magic key sequence typed into a terminal
that is connected to the system in some way (serial, USB or other mean).
In the former case, the handling is done in a user context. In the
latter case, it is likely to be in an interrupt context.

Currently in print_cpu() of kernel/sched/debug.c, sched_debug_lock is
taken with interrupt disabled for the whole duration of the calls to
print_*_stats() and print_rq() which could last for the quite some time
if the information dump happens on the serial console.

If the system has many cpus and the sched_debug_lock is somehow busy
(e.g. parallel sysrq-t), the system may hit a hard lockup panic
depending on the actually serial console implementation of the
system.

The purpose of sched_debug_lock is to serialize the use of the global
cgroup_path[] buffer in print_cpu(). The rests of the printk calls don't
need serialization from sched_debug_lock.

Calling printk() with interrupt disabled can still be problematic if
multiple instances are running. Allocating a stack buffer of PATH_MAX
bytes is not feasible because of the limited size of the kernel stack.

The solution implemented in this patch is to allow only one caller at a
time to use the full size group_path[], while other simultaneous callers
will have to use shorter stack buffers with the possibility of path
name truncation. A "..." suffix will be printed if truncation may have
happened.  The cgroup path name is provided for informational purpose
only, so occasional path name truncation should not be a big problem.

Fixes: efe25c2c7b3a ("sched: Reinstate group names in /proc/sched_debug")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210415195426.6677-1-longman@redhat.com
---
 kernel/sched/debug.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 7251fc4..9c882f2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,8 +8,6 @@
  */
 #include "sched.h"
 
-static DEFINE_SPINLOCK(sched_debug_lock);
-
 /*
  * This allows printing both to /proc/sched_debug and
  * to the console
@@ -476,16 +474,37 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
+static DEFINE_SPINLOCK(sched_debug_lock);
 static char group_path[PATH_MAX];
 
-static char *task_group_path(struct task_group *tg)
+static void task_group_path(struct task_group *tg, char *path, int plen)
 {
-	if (autogroup_path(tg, group_path, PATH_MAX))
-		return group_path;
+	if (autogroup_path(tg, path, plen))
+		return;
 
-	cgroup_path(tg->css.cgroup, group_path, PATH_MAX);
+	cgroup_path(tg->css.cgroup, path, plen);
+}
 
-	return group_path;
+/*
+ * Only 1 SEQ_printf_task_group_path() caller can use the full length
+ * group_path[] for cgroup path. Other simultaneous callers will have
+ * to use a shorter stack buffer. A "..." suffix is appended at the end
+ * of the stack buffer so that it will show up in case the output length
+ * matches the given buffer size to indicate possible path name truncation.
+ */
+#define SEQ_printf_task_group_path(m, tg, fmt...)			\
+{									\
+	if (spin_trylock(&sched_debug_lock)) {				\
+		task_group_path(tg, group_path, sizeof(group_path));	\
+		SEQ_printf(m, fmt, group_path);				\
+		spin_unlock(&sched_debug_lock);				\
+	} else {							\
+		char buf[128];						\
+		char *bufend = buf + sizeof(buf) - 3;			\
+		task_group_path(tg, buf, bufend - buf);			\
+		strcpy(bufend - 1, "...");				\
+		SEQ_printf(m, fmt, buf);				\
+	}								\
 }
 #endif
 
@@ -512,7 +531,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	SEQ_printf(m, " %s", task_group_path(task_group(p)));
+	SEQ_printf_task_group_path(m, task_group(p), " %s")
 #endif
 
 	SEQ_printf(m, "\n");
@@ -549,7 +568,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "cfs_rq[%d]:%s\n", cpu, task_group_path(cfs_rq->tg));
+	SEQ_printf_task_group_path(m, cfs_rq->tg, "cfs_rq[%d]:%s\n", cpu);
 #else
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
@@ -620,7 +639,7 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 {
 #ifdef CONFIG_RT_GROUP_SCHED
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "rt_rq[%d]:%s\n", cpu, task_group_path(rt_rq->tg));
+	SEQ_printf_task_group_path(m, rt_rq->tg, "rt_rq[%d]:%s\n", cpu);
 #else
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "rt_rq[%d]:\n", cpu);
@@ -672,7 +691,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long flags;
 
 #ifdef CONFIG_X86
 	{
@@ -723,13 +741,11 @@ do {									\
 	}
 #undef P
 
-	spin_lock_irqsave(&sched_debug_lock, flags);
 	print_cfs_stats(m, cpu);
 	print_rt_stats(m, cpu);
 	print_dl_stats(m, cpu);
 
 	print_rq(m, rq, cpu);
-	spin_unlock_irqrestore(&sched_debug_lock, flags);
 	SEQ_printf(m, "\n");
 }
 
