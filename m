Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC93131B0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhBHMDg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:03:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36278 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhBHMBV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:21 -0500
Date:   Mon, 08 Feb 2021 12:00:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMM84rTUNfg5AqgcTi7cL5nCwUBKHnS1e+0CaXdVIfI=;
        b=jOiNMeD1TUBenwRWiusgqqwazDKQYeC7jmyKQcjQc/Q/zBtnuEH7bYDABhOX4woyqj8y1w
        RPnCTB2vC/fkm3v5L6Cu38OKxb/fy5N22pj7u1cJiqdiBKDEwr5eci/EkaOIFLZiaHTFU0
        cxVUgzYPfcTmOwzxpO9KcDSxJxU/mxlSlDbkeet4WK9jxBS3JCKBakrxRfcpwzoenvlCKv
        P7jUWmKWWz0K/iagIxVNN5BL8E9KNNWip1/jDtxwAW+v17Y40ot0rogozvkokuORiTcLEv
        2siwcHnUKbUAUi6M5pGuPkO+t0BfFPakZvRwgMi9puRmgdObKZFxu00J/pluFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMM84rTUNfg5AqgcTi7cL5nCwUBKHnS1e+0CaXdVIfI=;
        b=eMwliVfGis8EyI1XliuSSVFZwKY40lvigbOXerlAEFgL6a3ir0mEIM4/4VG4dAlrxCsNqi
        Wal7KTFfHgP6YKDA==
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
Message-ID: <161278563865.23325.7252513798399544907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     48dd9c490b9402ff7ca0a7ddecd486dba9450a44
Gitweb:        https://git.kernel.org/tip/48dd9c490b9402ff7ca0a7ddecd486dba9450a44
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 22 Jan 2021 13:01:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:58 +01:00

sched: Add /debug/sched_preempt

Add a debugfs file to muck about with the preempt mode at runtime.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YAsGiUYf6NyaTplX@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c | 135 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0562992..c659266 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5348,37 +5348,154 @@ EXPORT_STATIC_CALL(preempt_schedule_notrace);
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
 
 
