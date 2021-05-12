Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5683F37EDE7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbhELU4J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:56:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhELUDH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 16:03:07 -0400
Date:   Wed, 12 May 2021 20:01:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620849708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U16Wen9fRtuglAqaBDoY+AdOgmO4JbDun0z7yyR1kjU=;
        b=uT38VRBeUCwGi/QWtuGZJLFf47ShY38MrfcQtWZDJLEqckG/QvbcIgJ6aBy5Q6s49AeZG9
        im6XimfO0dz+VXd/+AIC9PGZRgH0IRdlH+rgq4iD/AVSLp+nrzKn4jJQeK4+gJvWBVDgNj
        t19d3/l8lpkKROGIGIa7EN0SbeBXhehDpWWBV/v85/Ey6q1Cp7HyYNmllDT25VP1iE/9KN
        dwZ+ahLyL4JxRH2hHNhbr1Mb6M7ROYr21r4+8P5KVKleOhe/Hqpp+4QyahyoshYnLHfMnm
        O3/W0Ti4URVeqZofJqjrHJh1GZExRnqxtUBGfYuYW9gCR4yu43o3KNbbOD4WmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620849708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U16Wen9fRtuglAqaBDoY+AdOgmO4JbDun0z7yyR1kjU=;
        b=t1wkgdi0d1hGYi6jaD8JKcCXOecrk4ZR6oC57QhFleam+ZG7rsnIsk7MNFnXsJWe4w443N
        t2ixvH5V5L/NL9Aw==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make nr_running() return 32-bit value
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422200228.1423391-1-adobriyan@gmail.com>
References: <20210422200228.1423391-1-adobriyan@gmail.com>
MIME-Version: 1.0
Message-ID: <162084970734.29796.6875060189702159404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     01aee8fd7fb23049e2b52abadbe1f7b5e94a52d2
Gitweb:        https://git.kernel.org/tip/01aee8fd7fb23049e2b52abadbe1f7b5e94a52d2
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Thu, 22 Apr 2021 23:02:25 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 21:34:14 +02:00

sched: Make nr_running() return 32-bit value

Creating 2**32 tasks is impossible due to futex pid limits and wasteful
anyway. Nobody has done it.

Bring nr_running() into 32-bit world to save on REX prefixes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210422200228.1423391-1-adobriyan@gmail.com
---
 fs/proc/loadavg.c          | 2 +-
 fs/proc/stat.c             | 2 +-
 include/linux/sched/stat.h | 2 +-
 kernel/sched/core.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index 8468bae..f32878d 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -16,7 +16,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
-	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %ld/%d %d\n",
+	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index f25e853..941605d 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -200,7 +200,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"\nctxt %llu\n"
 		"btime %llu\n"
 		"processes %lu\n"
-		"procs_running %lu\n"
+		"procs_running %u\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 939c3ec..73606b3 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -17,7 +17,7 @@ extern unsigned long total_forks;
 extern int nr_threads;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
-extern unsigned long nr_running(void);
+extern unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac8882d..2c6cdb0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4692,9 +4692,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
  * externally visible scheduler statistics: current number of runnable
  * threads, total number of context switches performed since bootup.
  */
-unsigned long nr_running(void)
+unsigned int nr_running(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_running;
