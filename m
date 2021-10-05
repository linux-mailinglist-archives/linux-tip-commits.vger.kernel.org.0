Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1676B422A6E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhJEOOa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhJEOOC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE59C061786;
        Tue,  5 Oct 2021 07:12:10 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIAvYn42rhROY5E6oqRvQcMIt/GxIN+XR+yIa+6O5Pw=;
        b=Nlkwv49nuhTTnhOYN7xz2FqoCZRVnXMTzhZdzqd3uCMKF1mtXr4gXIKzhp/WAFz+uO7uMf
        Dj8T4lapWW+IR+GrmMdSNKMfLGUWFDteO6cvJmFIU31WywBme9CSfyXnajVr3124s5VyuG
        ZIZ0kzh3N06NAxLwvEh0ZdzPbZcGUFqqzF6z8CJP1VuSoLJ8a5GHHZ4pvyXiFSVN7xrk6v
        pr5oEYzCYqUNXV4IDxErSL6ntd6QGWMzTZ6A89AWLsqatNe5sBKwLoSr/A5ODa2c6j/jhZ
        HwAdL6CS1cBv7vbiMpM+waLrtw4+QnLxDO7OtZPVQeV/yblt1thFucIbfueBOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIAvYn42rhROY5E6oqRvQcMIt/GxIN+XR+yIa+6O5Pw=;
        b=ZT/Lk69ATGolcPINR8p/7TfNHypsEHv8M6hk0goiJclSBNuAnx2bv5F2Q5lza5xtTPgIPD
        b+/wnjB47aQ8pYCA==
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
Message-ID: <163344312843.25758.4573162866545999201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     847fc0cd0664fcb2a08ac66df6b85935361ec454
Gitweb:        https://git.kernel.org/tip/847fc0cd0664fcb2a08ac66df6b85935361ec454
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:48 +02:00

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
index 2bc4c72..193e16e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -503,6 +503,8 @@ struct sched_statistics {
 
 	u64				block_start;
 	u64				block_max;
+	s64				sum_block_runtime;
+
 	u64				exec_max;
 	u64				slice_max;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 76fd38e..26fac5e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -540,10 +540,11 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
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
@@ -977,6 +978,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
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
