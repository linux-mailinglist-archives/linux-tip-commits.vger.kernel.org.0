Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D8362492
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhDPPyQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbhDPPyJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888AC061574;
        Fri, 16 Apr 2021 08:53:44 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVwmKQoIi9A17wnXEUexM0LDdPLA/qd1qY9YgemsJJI=;
        b=mhxQFWB9u4TRfjqehl/Vxj4qihJCg5bpuAfy0usbI7GKSG9xiWGT9YNzN/81mXM8xAD2Fl
        N0yqSqE3itKmm+kfDsDtJEgmbEXUkMH8Gtox9LaxUsOb0xJ1v6GdeGghnp3c1wLnZptIT5
        PsMK0Nosh24P/ySmKWzvktXuVkb93+vqCAD2mu4ApqhXP6oCqE4Bpc2ILVmY1E5AqATHpk
        SgvDytnfRGQZ4fRBhu/0ltdDtIVwy5AnNfxvu2OXhOGOJT7dSfElZFjI1uP6PKzC8WRAEF
        WVMUMswXhYwotapsKWum+LcfvwtYz+ot6zY94SiUXVplh07CwURit18idPeOLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVwmKQoIi9A17wnXEUexM0LDdPLA/qd1qY9YgemsJJI=;
        b=eLXoMvYWAXeXqDqiftMGllW48hl1XmEsePNJABzy+xamQF48y/JSIAaG8bLjMdJjia0eoL
        vXTO1YQI0ai/UMAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,preempt: Move preempt_dynamic to debug.c
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210412102001.353833279@infradead.org>
References: <20210412102001.353833279@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842245.29796.17863309333059665489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1011dcce99f8026d48fdd7b9cc259e32a8b472be
Gitweb:        https://git.kernel.org/tip/1011dcce99f8026d48fdd7b9cc259e32a8b472be
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Mar 2021 12:21:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:34 +02:00

sched,preempt: Move preempt_dynamic to debug.c

Move the #ifdef SCHED_DEBUG bits to kernel/sched/debug.c in order to
collect all the debugfs bits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210412102001.353833279@infradead.org
---
 kernel/sched/core.c  | 77 +------------------------------------------
 kernel/sched/debug.c | 67 ++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h | 11 ++++--
 3 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bac30db..e6c714b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5371,9 +5371,9 @@ enum {
 	preempt_dynamic_full,
 };
 
-static int preempt_dynamic_mode = preempt_dynamic_full;
+int preempt_dynamic_mode = preempt_dynamic_full;
 
-static int sched_dynamic_mode(const char *str)
+int sched_dynamic_mode(const char *str)
 {
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
@@ -5387,7 +5387,7 @@ static int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
-static void sched_dynamic_update(int mode)
+void sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
@@ -5444,79 +5444,8 @@ static int __init setup_preempt_mode(char *str)
 }
 __setup("preempt=", setup_preempt_mode);
 
-#ifdef CONFIG_SCHED_DEBUG
-
-static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *ppos)
-{
-	char buf[16];
-	int mode;
-
-	if (cnt > 15)
-		cnt = 15;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-	mode = sched_dynamic_mode(strstrip(buf));
-	if (mode < 0)
-		return mode;
-
-	sched_dynamic_update(mode);
-
-	*ppos += cnt;
-
-	return cnt;
-}
-
-static int sched_dynamic_show(struct seq_file *m, void *v)
-{
-	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, "(");
-		seq_puts(m, preempt_modes[i]);
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, ")");
-
-		seq_puts(m, " ");
-	}
-
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static int sched_dynamic_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, sched_dynamic_show, NULL);
-}
-
-static const struct file_operations sched_dynamic_fops = {
-	.open		= sched_dynamic_open,
-	.write		= sched_dynamic_write,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-extern struct dentry *debugfs_sched;
-
-static __init int sched_init_debug_dynamic(void)
-{
-	debugfs_create_file("sched_preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
-	return 0;
-}
-late_initcall(sched_init_debug_dynamic);
-
-#endif /* CONFIG_SCHED_DEBUG */
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
-
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2093b90..bdd344f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -213,9 +213,71 @@ static const struct file_operations sched_scaling_fops = {
 
 #endif /* SMP */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	int mode;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+	mode = sched_dynamic_mode(strstrip(buf));
+	if (mode < 0)
+		return mode;
+
+	sched_dynamic_update(mode);
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
+static int sched_dynamic_show(struct seq_file *m, void *v)
+{
+	static const char * preempt_modes[] = {
+		"none", "voluntary", "full"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, "(");
+		seq_puts(m, preempt_modes[i]);
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, ")");
+
+		seq_puts(m, " ");
+	}
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int sched_dynamic_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_dynamic_show, NULL);
+}
+
+static const struct file_operations sched_dynamic_fops = {
+	.open		= sched_dynamic_open,
+	.write		= sched_dynamic_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
 __read_mostly bool sched_debug_enabled;
 
-struct dentry *debugfs_sched;
+static struct dentry *debugfs_sched;
 
 static __init int sched_init_debug(void)
 {
@@ -225,6 +287,9 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
 	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
+#endif
 
 	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 123ff3b..c312389 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2734,5 +2734,12 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 }
 #endif
 
-void swake_up_all_locked(struct swait_queue_head *q);
-void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+extern void swake_up_all_locked(struct swait_queue_head *q);
+extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+extern int preempt_dynamic_mode;
+extern int sched_dynamic_mode(const char *str);
+extern void sched_dynamic_update(int mode);
+#endif
+
