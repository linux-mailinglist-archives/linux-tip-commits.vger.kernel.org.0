Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFD37EDE2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386615AbhELUzx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbhELUDH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 16:03:07 -0400
Date:   Wed, 12 May 2021 20:01:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620849707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=he7PoGyTMVd8d2vIjb3JCZ4egZAR870X/zRlUhrbRmY=;
        b=EapU9zuFdfc2a0nycyUyTK5KgK9bWRA/IuQIzq3wZUeFTQWY4BTaXGrEbz2CDMk+lTgyfO
        O80Chkjo3pFL3UV/XniU7MYXVxuQEUmv2Fahw5KqcF2hFP8sb92qm3wbot/fvs3beXBYwc
        sd6GlhIZW4fQmcAiLmStBR3xKTeldlimyhJ7J9vCNZAqjnjTBPM4jQF8upkafZaQ4FQy+R
        mZYRjPbm0rKFovpMtpkWnICEeDvKcv9Yfpgp3bJ0ivnzkzQHlfSjt/c/reAfcYzkOg9CXW
        Zx1lpdS+EdDeVihHwNIg29T8r29lYEZcG1pCHGRd6W2k3yU5MDI06xy7feDM4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620849707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=he7PoGyTMVd8d2vIjb3JCZ4egZAR870X/zRlUhrbRmY=;
        b=wZ648Dgs1vbqeXsDFwkNtVFG3mjTYLOQS+J/R8EsIRiK9av+7ANCPGKsuj4SiO5LQjK9ou
        HdFK9LfrQcf0i6Cg==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make nr_iowait() return 32-bit value
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422200228.1423391-2-adobriyan@gmail.com>
References: <20210422200228.1423391-2-adobriyan@gmail.com>
MIME-Version: 1.0
Message-ID: <162084970686.29796.5102772648534849157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9745516841a55c77163a5d549bce1374d776df54
Gitweb:        https://git.kernel.org/tip/9745516841a55c77163a5d549bce1374d776df54
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Thu, 22 Apr 2021 23:02:26 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 21:34:15 +02:00

sched: Make nr_iowait() return 32-bit value

Creating 2**32 tasks to wait in D-state is impossible and wasteful.

Return "unsigned int" and save on REX prefixes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210422200228.1423391-2-adobriyan@gmail.com
---
 fs/proc/stat.c             | 2 +-
 include/linux/sched/stat.h | 2 +-
 kernel/sched/core.c        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 941605d..6561a06 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -201,7 +201,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"btime %llu\n"
 		"processes %lu\n"
 		"procs_running %u\n"
-		"procs_blocked %lu\n",
+		"procs_blocked %u\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
 		total_forks,
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 73606b3..81d9b53 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -19,7 +19,7 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned long nr_iowait(void);
+extern unsigned int nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2c6cdb0..fadf2bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4774,9 +4774,9 @@ unsigned long nr_iowait_cpu(int cpu)
  * Task CPU affinities can make all that even more 'interesting'.
  */
 
-unsigned long nr_iowait(void)
+unsigned int nr_iowait(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
 		sum += nr_iowait_cpu(i);
