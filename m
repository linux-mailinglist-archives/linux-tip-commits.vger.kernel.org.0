Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F91422A85
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhJEOPJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhJEOO3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A4C0617A7;
        Tue,  5 Oct 2021 07:12:17 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6TpAgVxtA6nWkg/ai1HTTudbJAeoQ2gCTt+dNkTQbc=;
        b=2ot32Q7nD+4Ra9lQEjetmP/xKOfaUomA8EWN3zTKLtYh3sz8dJPsMtg7lwpW9CN6VVWAWe
        HsumMCLiHLKC8zU/nQrSpSH0erjkhLHO8gRvgSPb7bt2AsG6fOA+xbdnTX8aasYtASskyf
        +EWj0Rl703cDnUEodeIgQOIB13uuaP3tCWZwp8AyVdARHtTN+1Pp5JI/z/f2bH7+L1R/s5
        vWcvpu4mrrtMSDy4v+xLNWZnSOfIcUj3X58iLq5cbBkDmNQ+Z+7sf1KwxZhp8Sd2QcduxN
        ccvQbqDGr5KzsJeotnYDmyStHX+lax3YkuICtz+30/Hx2f8QwBJ7Xgh1KToIdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6TpAgVxtA6nWkg/ai1HTTudbJAeoQ2gCTt+dNkTQbc=;
        b=FRb26HITfjE9PB2TPoKwOtEsRhrSsfJfelQf7pAWUqOpzkajjIE53ft/Ab6pcdPr/HmWRk
        nfVvjgKHcOmPbABQ==
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
Message-ID: <163344313490.25758.8126200201306491784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a130e8fbc7de796eb6e680724d87f4737a26d0ac
Gitweb:        https://git.kernel.org/tip/a130e8fbc7de796eb6e680724d87f4737a26d0ac
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Fri, 27 Aug 2021 09:54:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:35 +02:00

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
