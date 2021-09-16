Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AAA40D93B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhIPMA5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbhIPMAw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E1C061764;
        Thu, 16 Sep 2021 04:59:31 -0700 (PDT)
Date:   Thu, 16 Sep 2021 11:59:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSDU1TtyZagcqyOboLaL62+Bw73cOugdGNlT67jjNiU=;
        b=HEmlZVFZid8L5XThFKUwK++5ZrkJ5pxpJdWkg1qQK2QXuBYw7a5RNRiZby7MdnYQOMYOx9
        BctB85JjA0+7NAYyF2DQusvb54QUO3WLlYcwZXXyxfZ0LQ3vAX/99ZjSeLxQFs4Cv1wuEZ
        vSOG5Cl1aZOIDCwGVNIC6qtGwLS8m96Ay8CrZLEoGmfoEmN77ax8H5a52/F+xOnGvxq12Z
        feuzMiAzZsyagy+oSTqjXtF+CaEKJhb6Rz4f9d709DHnJHSfCDEspKld0R5YHMqtLuq0oi
        Acpr2wUfI2DSPZ3pIQUVpTn3fRktXGzZsQ4wIyF9PsCa7TtIviKd9yehkOutRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSDU1TtyZagcqyOboLaL62+Bw73cOugdGNlT67jjNiU=;
        b=JwcKyeYFgrxAiqFgPUQ21UOD95j499kNTNh2IlnGT2Jbzobd53phYIqh2brsrfuz0+PSP/
        30uKg1XB23yvL6Ag==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce task block time in schedstats
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-5-laoar.shao@gmail.com>
References: <20210905143547.4668-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163179356957.25758.2603980497962275087.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a95f0507a1a4d6de8e9c8b2b61cb733947e9422b
Gitweb:        https://git.kernel.org/tip/a95f0507a1a4d6de8e9c8b2b61cb733947e9422b
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:48:59 +02:00

sched: Introduce task block time in schedstats

Currently in schedstats we have sum_sleep_runtime and iowait_sum, but
there's no metric to show how long the task is in D state.  Once a task in
D state, it means the task is blocked in the kernel, for example the
task may be waiting for a mutex. The D state is more frequent than
iowait, and it is more critital than S state. So it is worth to add a
metric to measure it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210905143547.4668-5-laoar.shao@gmail.com
---
 include/linux/sched.h | 2 ++
 kernel/sched/debug.c  | 6 ++++--
 kernel/sched/stats.c  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 518e19c..549018e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -441,6 +441,8 @@ struct sched_statistics {
 
 	u64				block_start;
 	u64				block_max;
+	s64				sum_block_runtime;
+
 	u64				exec_max;
 	u64				slice_max;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ca0dd47..935dad7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -534,10 +534,11 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
-	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
+	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld %9lld.%06ld",
 		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -971,6 +972,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		u64 avg_atom, avg_per_cpu;
 
 		PN_SCHEDSTAT(sum_sleep_runtime);
+		PN_SCHEDSTAT(sum_block_runtime);
 		PN_SCHEDSTAT(wait_start);
 		PN_SCHEDSTAT(sleep_start);
 		PN_SCHEDSTAT(block_start);
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index fad781c..07dde29 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -82,6 +82,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
 
 		__schedstat_set(stats->block_start, 0);
 		__schedstat_add(stats->sum_sleep_runtime, delta);
+		__schedstat_add(stats->sum_block_runtime, delta);
 
 		if (p) {
 			if (p->in_iowait) {
