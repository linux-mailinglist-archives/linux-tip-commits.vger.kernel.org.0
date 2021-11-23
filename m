Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9C245A0CE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Nov 2021 12:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhKWLFJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Nov 2021 06:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbhKWLFH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Nov 2021 06:05:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED9C061714;
        Tue, 23 Nov 2021 03:01:59 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637665316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSUgJXpBSoHE1b5ccps0swCCLVlY9ZyEecpJCp5D5oA=;
        b=iaF/d+BrwvuYGUkKDuko1ekUJlMIY3PS1ReLhjOQksMNSu8FNfT0t9XRemU3jADM5Ph9Id
        H/e030FNwVtEHdxvBCk1zL8dQJxE/uirLDWNxwtfPuoR1DDFUIwApxngLMXNbsSffrlH0C
        hs3knGz6PtYd3ddABQ/X1oJ+VpgfH5lICuWNZ2fPkxwYZnzRkxnNbhwYpKhJgYuLHp/1ru
        bB6ClGRKz+ssLkq1QVb0PaZtpgRQjT7djMtEmk8igvd1vmL3V+I7UQDzaz9j7WnR+6Q0Rg
        JvXiQJwvIkMeIYmt2kPu71F0iJVk6lb0T3PexwtL1xm347m3L57uWlUYc0kDAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637665316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSUgJXpBSoHE1b5ccps0swCCLVlY9ZyEecpJCp5D5oA=;
        b=CoDfVwbIYYLtxzePhWQY+xkdWVMThBeWC+Wmd52ltZLibJymq6hgdk3XkBrjli7ANecpCR
        2KBCVJBWxKjZDpCw==
From:   "tip-bot2 for Andrey Ryabinin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpuacct: Make user/system times in
 cpuacct.stat more precise
Cc:     Andrey Ryabinin <arbn@yandex-team.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211115164607.23784-4-arbn@yandex-team.com>
References: <20211115164607.23784-4-arbn@yandex-team.com>
MIME-Version: 1.0
Message-ID: <163766531523.11128.10280253346273305725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8c92606ab81086db00cbb73347d124b4eb169b7e
Gitweb:        https://git.kernel.org/tip/8c92606ab81086db00cbb73347d124b4eb169b7e
Author:        Andrey Ryabinin <arbn@yandex-team.com>
AuthorDate:    Mon, 15 Nov 2021 19:46:07 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Nov 2021 09:55:22 +01:00

sched/cpuacct: Make user/system times in cpuacct.stat more precise

cpuacct.stat shows user time based on raw random precision tick
based counters. Use cputime_addjust() to scale these values against the
total runtime accounted by the scheduler, like we already do
for user/system times in /proc/<pid>/stat.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20211115164607.23784-4-arbn@yandex-team.com
---
 kernel/sched/cpuacct.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9de7dd5..3d06c5e 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -261,25 +261,30 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 static int cpuacct_stats_show(struct seq_file *sf, void *v)
 {
 	struct cpuacct *ca = css_ca(seq_css(sf));
-	s64 val[CPUACCT_STAT_NSTATS];
+	struct task_cputime cputime;
+	u64 val[CPUACCT_STAT_NSTATS];
 	int cpu;
 	int stat;
 
-	memset(val, 0, sizeof(val));
+	memset(&cputime, 0, sizeof(cputime));
 	for_each_possible_cpu(cpu) {
 		u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
 
-		val[CPUACCT_STAT_USER]   += cpustat[CPUTIME_USER];
-		val[CPUACCT_STAT_USER]   += cpustat[CPUTIME_NICE];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SYSTEM];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_IRQ];
-		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SOFTIRQ];
+		cputime.utime += cpustat[CPUTIME_USER];
+		cputime.utime += cpustat[CPUTIME_NICE];
+		cputime.stime += cpustat[CPUTIME_SYSTEM];
+		cputime.stime += cpustat[CPUTIME_IRQ];
+		cputime.stime += cpustat[CPUTIME_SOFTIRQ];
+
+		cputime.sum_exec_runtime += *per_cpu_ptr(ca->cpuusage, cpu);
 	}
 
+	cputime_adjust(&cputime, &seq_css(sf)->cgroup->prev_cputime,
+		&val[CPUACCT_STAT_USER], &val[CPUACCT_STAT_SYSTEM]);
+
 	for (stat = 0; stat < CPUACCT_STAT_NSTATS; stat++) {
-		seq_printf(sf, "%s %lld\n",
-			   cpuacct_stat_desc[stat],
-			   (long long)nsec_to_clock_t(val[stat]));
+		seq_printf(sf, "%s %llu\n", cpuacct_stat_desc[stat],
+			nsec_to_clock_t(val[stat]));
 	}
 
 	return 0;
