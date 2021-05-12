Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F937BA6D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhELK3q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50544 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhELK3i (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:38 -0400
Date:   Wed, 12 May 2021 10:28:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQBquYpW0oCpypwgTS9JGzv1AQJSSjvg3kcverQPfPQ=;
        b=KJbr+L6/Cn4cHTXHNS8F/+zkZ95H7SUpICnXWLmM4RtG0pbbXf5WMA5EpYszILlU6SlhTS
        /j3eI9AKrw2kLbRv0C62hE2uGDq/LgMa174UF+vxOjyXrBG0JVRx3AriYcgyGDjkFQyYT+
        G9d2SPNhtIf+L/GXBpuum82P3sjibYKE2D0tWI2m+oLGdZNCFn9ERlqZh+uIH/oolMIrX2
        HAgc2S1v2VnPGXCVZ0IeYhbqT0RyhMvG7lV3K1F8JJqDuk50+viLpSlirl0INmNGMCrBdC
        b02yvCLoRWFf9j2ZjXHf1M0FqfBwxECcVzsDCaxkQ17eJlkM/6UbKgZrjH+cDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQBquYpW0oCpypwgTS9JGzv1AQJSSjvg3kcverQPfPQ=;
        b=wsN5Oui7BTbYA+g0vTa3xzVHCj2rtK0v2mqBucV1A4fjpQwpfxaTjE2y8QAcN38sS5ShHZ
        rk511HCVNcHWi4Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] delayacct: Add sysctl to enable at runtime
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YJkhebGJAywaZowX@hirez.programming.kicks-ass.net>
References: <YJkhebGJAywaZowX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162081530866.29796.12022086349139308604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0cd7c741f01de13dc1eecf22557593b3514639bb
Gitweb:        https://git.kernel.org/tip/0cd7c741f01de13dc1eecf22557593b3514639bb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 10 May 2021 14:01:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:25 +02:00

delayacct: Add sysctl to enable at runtime

Just like sched_schedstats, allow runtime enabling (and disabling) of
delayacct. This is useful if one forgot to add the delayacct boot time
option.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YJkhebGJAywaZowX@hirez.programming.kicks-ass.net
---
 Documentation/accounting/delay-accounting.rst |  6 ++-
 include/linux/delayacct.h                     |  4 ++-
 kernel/delayacct.c                            | 36 +++++++++++++++++-
 kernel/sysctl.c                               | 12 ++++++-
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index f20b282..1b8b46d 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -74,8 +74,10 @@ To enable, add::
 
    delayacct
 
-to the kernel boot options. The rest of the instructions
-below assume this has been done.
+to the kernel boot options. The rest of the instructions below assume this has
+been done. Alternatively, use sysctl kernel.task_delayacct to switch the state
+at runtime. Note however that only tasks started after enabling it will have
+delayacct information.
 
 After the system has booted up, use a utility
 similar to  getdelays.c to access the delays
diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 225c8e0..af7e6eb 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -65,6 +65,10 @@ DECLARE_STATIC_KEY_FALSE(delayacct_key);
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
+
+extern int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
+			    size_t *lenp, loff_t *ppos);
+
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio_start(void);
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 3f08690..51530d5 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -18,6 +18,17 @@ DEFINE_STATIC_KEY_FALSE(delayacct_key);
 int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
 struct kmem_cache *delayacct_cache;
 
+static void set_delayacct(bool enabled)
+{
+	if (enabled) {
+		static_branch_enable(&delayacct_key);
+		delayacct_on = 1;
+	} else {
+		delayacct_on = 0;
+		static_branch_disable(&delayacct_key);
+	}
+}
+
 static int __init delayacct_setup_enable(char *str)
 {
 	delayacct_on = 1;
@@ -29,9 +40,30 @@ void delayacct_init(void)
 {
 	delayacct_cache = KMEM_CACHE(task_delay_info, SLAB_PANIC|SLAB_ACCOUNT);
 	delayacct_tsk_init(&init_task);
-	if (delayacct_on)
-		static_branch_enable(&delayacct_key);
+	set_delayacct(delayacct_on);
+}
+
+#ifdef CONFIG_PROC_SYSCTL
+int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
+		     size_t *lenp, loff_t *ppos)
+{
+	int state = delayacct_on;
+	struct ctl_table t;
+	int err;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	t = *table;
+	t.data = &state;
+	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+	if (write)
+		set_delayacct(state);
+	return err;
 }
+#endif
 
 void __delayacct_tsk_init(struct task_struct *tsk)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 14edf84..0afbfc8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -71,6 +71,7 @@
 #include <linux/coredump.h>
 #include <linux/latencytop.h>
 #include <linux/pid.h>
+#include <linux/delayacct.h>
 
 #include "../lib/kstrtox.h"
 
@@ -1727,6 +1728,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_SCHEDSTATS */
+#ifdef CONFIG_TASK_DELAY_ACCT
+	{
+		.procname	= "task_delayacct",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_delayacct,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_TASK_DELAY_ACCT */
 #ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing",
