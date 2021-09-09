Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F62A404918
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhIILTo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhIILTk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:40 -0400
Date:   Thu, 09 Sep 2021 11:18:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6U+/WvyyC/TTJtJKu9eR22WdaUa7EJQ9pFcQXHusv0=;
        b=YlqJqOfN297q15OxBh+b2ERgDVre6Zs5fkB1xFqySBGQCLq0A3/+ZIQ9WuiHijrD4kr1v2
        IC+M2yrAiN6T1GvL5vV5SPIgJYltK4hPIgC238ku1lIFvYEIqtXanBnIAiLf6JP+2ttGVU
        qebeTJtSS97hG7c/NEbYKEs5gjoZCd3ExWSB+YCyLFobzaIyRoUDwpWQIlDp/J52g0/CiE
        AnocZgoI2musK0iLgTVjshdPIDYlzGnrPvhhSryrWCaHipmNVssRhX7mfwkb0wxA+PPUbe
        L6/XAO3A/deTvRl6vB+N/R9c6Hlu6pQrYwGS1KbzymoRO5Iv3A2wyggMmlWelQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6U+/WvyyC/TTJtJKu9eR22WdaUa7EJQ9pFcQXHusv0=;
        b=ENu2ZrGzpevRhAI1Jl6HgFqE9dv40IUeqUC3TP99eQjZRg/yvF/elxGyL7BMW8pN6CfhYW
        OynHhyuJ0bLRsHDg==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] fs/proc/uptime.c: Fix idle time reporting in /proc/uptime
Cc:     Luigi Rizzo <lrizzo@google.com>, Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Dumazet <edumazet@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210827165438.3280779-1-joshdon@google.com>
References: <20210827165438.3280779-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <163118630930.25758.11716792020482050314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1f74f9ea5a0cc9147f5bda4b5715ccb5cc34605d
Gitweb:        https://git.kernel.org/tip/1f74f9ea5a0cc9147f5bda4b5715ccb5cc34605d
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Fri, 27 Aug 2021 09:54:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:31 +02:00

fs/proc/uptime.c: Fix idle time reporting in /proc/uptime

/proc/uptime reports idle time by reading the CPUTIME_IDLE field from
the per-cpu kcpustats. However, on NO_HZ systems, idle time is not
continually updated on idle cpus, leading this value to appear
incorrectly small.

/proc/stat performs an accounting update when reading idle time; we
can use the same approach for uptime.

With this patch, /proc/stat and /proc/uptime now agree on idle time.
Additionally, the following shows idle time tick up consistently on an
idle machine:

  (while true; do cat /proc/uptime; sleep 1; done) | awk '{print $2-prev; prev=$2}'

Reported-by: Luigi Rizzo <lrizzo@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lkml.kernel.org/r/20210827165438.3280779-1-joshdon@google.com
---
 fs/proc/stat.c              |  4 ++--
 fs/proc/uptime.c            | 14 +++++++++-----
 include/linux/kernel_stat.h |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6561a06..4fb8729 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -24,7 +24,7 @@
 
 #ifdef arch_idle_time
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle;
 
@@ -46,7 +46,7 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 #else
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle, idle_usecs = -1ULL;
 
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 5a1b228..deb99bc 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -12,18 +12,22 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 {
 	struct timespec64 uptime;
 	struct timespec64 idle;
-	u64 nsec;
+	u64 idle_nsec;
 	u32 rem;
 	int i;
 
-	nsec = 0;
-	for_each_possible_cpu(i)
-		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
+	idle_nsec = 0;
+	for_each_possible_cpu(i) {
+		struct kernel_cpustat kcs;
+
+		kcpustat_cpu_fetch(&kcs, i);
+		idle_nsec += get_idle_time(&kcs, i);
+	}
 
 	ktime_get_boottime_ts64(&uptime);
 	timens_add_boottime(&uptime);
 
-	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
+	idle.tv_sec = div_u64_rem(idle_nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
 			(unsigned long) uptime.tv_sec,
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 44ae1a7..69ae6b2 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -102,6 +102,7 @@ extern void account_system_index_time(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
 extern void account_idle_time(u64);
+extern u64 get_idle_time(struct kernel_cpustat *kcs, int cpu);
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 static inline void account_process_tick(struct task_struct *tsk, int user)
