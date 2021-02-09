Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE231531A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Feb 2021 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhBIPp6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 9 Feb 2021 10:45:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhBIPpu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 9 Feb 2021 10:45:50 -0500
Date:   Tue, 09 Feb 2021 15:45:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612885507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Dq3ZQ/5Szkm5G+i8hAJ8U2bM9k6hjZsGXQtEcnj7Js=;
        b=w+kGFwWoUs9wxUjXUHa0TocssQl94mz08kuDyf6TDdew938aZ3UJcAYdWXEjrhLKcHpMHq
        ma8PkUzAp3YJM+0eEx8wEa3Z5owlwJvW3G8qiasj2jsSZysngc15Ns0bE4mjyY+euRcOu4
        sMnMWL+Df4I4sB3ud4Q/htK+V8PSPqk6hnRXnvMef6a/68R2MmhsJPMZT1jSCf98op2XNO
        X4uA10zaObtRK1jaB1kxx5EyYUUCK7clIGfFhTKSG8Z35Oaq99dcZqTrlWJ/WPyzr6tUHn
        pOFUute5hl24wXla+JXuULrY9Yr6rOP6eTS/qQPhnDnvjeZDhL0Vy1JP3bHE7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612885507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Dq3ZQ/5Szkm5G+i8hAJ8U2bM9k6hjZsGXQtEcnj7Js=;
        b=vYNk8rtsifL9zlId3SmfwwHDotJcCk4TxD11Kscz/tshkSHIWA/IEKlmagWOrEaYCrro2A
        U/NM+x0tYkWURPCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add /debug/sched_preempt
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YAsGiUYf6NyaTplX@hirez.programming.kicks-ass.net>
References: <YAsGiUYf6NyaTplX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161288550683.23325.6904383371578790672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b57f3de85c79f9fbfe2fd84cc6ba548e4e73d02d
Gitweb:        https://git.kernel.org/tip/b57f3de85c79f9fbfe2fd84cc6ba548e4e73d02d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 22 Jan 2021 13:01:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Feb 2021 16:31:03 +01:00

sched: Add /debug/sched_preempt

Add a debugfs file to muck about with the preempt mode at runtime.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YAsGiUYf6NyaTplX@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c | 135 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 220393d..cb226f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5349,37 +5349,154 @@ EXPORT_STATIC_CALL(preempt_schedule_notrace);
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
  */
-static int __init setup_preempt_mode(char *str)
+
+enum {
+	preempt_dynamic_none = 0,
+	preempt_dynamic_voluntary,
+	preempt_dynamic_full,
+};
+
+static int preempt_dynamic_mode = preempt_dynamic_full;
+
+static int sched_dynamic_mode(const char *str)
 {
-	if (!strcmp(str, "none")) {
+	if (!strcmp(str, "none"))
+		return 0;
+
+	if (!strcmp(str, "voluntary"))
+		return 1;
+
+	if (!strcmp(str, "full"))
+		return 2;
+
+	return -1;
+}
+
+static void sched_dynamic_update(int mode)
+{
+	/*
+	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
+	 * the ZERO state, which is invalid.
+	 */
+	static_call_update(cond_resched, __cond_resched);
+	static_call_update(might_resched, __cond_resched);
+	static_call_update(preempt_schedule, __preempt_schedule_func);
+	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+
+	switch (mode) {
+	case preempt_dynamic_none:
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
 		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
 		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else if (!strcmp(str, "voluntary")) {
+		pr_info("Dynamic Preempt: none\n");
+		break;
+
+	case preempt_dynamic_voluntary:
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, __cond_resched);
 		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
 		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
 		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else if (!strcmp(str, "full")) {
+		pr_info("Dynamic Preempt: voluntary\n");
+		break;
+
+	case preempt_dynamic_full:
 		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else {
-		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
+		pr_info("Dynamic Preempt: full\n");
+		break;
+	}
+
+	preempt_dynamic_mode = mode;
+}
+
+static int __init setup_preempt_mode(char *str)
+{
+	int mode = sched_dynamic_mode(str);
+	if (mode < 0) {
+		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
 		return 1;
 	}
+
+	sched_dynamic_update(mode);
 	return 0;
 }
 __setup("preempt=", setup_preempt_mode);
 
+#ifdef CONFIG_SCHED_DEBUG
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
+static __init int sched_init_debug_dynamic(void)
+{
+	debugfs_create_file("sched_preempt", 0644, NULL, NULL, &sched_dynamic_fops);
+	return 0;
+}
+late_initcall(sched_init_debug_dynamic);
+
+#endif /* CONFIG_SCHED_DEBUG */
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
 
