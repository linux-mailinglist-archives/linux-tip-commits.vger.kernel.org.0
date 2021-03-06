Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999F632F9F8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhCFLm3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhCFLmV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12F7C06175F;
        Sat,  6 Mar 2021 03:42:20 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vvHwa4ijzPORnwg40Q6sbzSiFhrexXoUjLep87zoHA=;
        b=S9CWc/53AmqQYDGnJeJnbfFZH8RhnlFZT7y679hDYmPMDUjK3Hz7Bw0xTzeCh6MNj3Oppx
        avt65AjMQZYWAjdk7vmnkZJwISUHZjcKCoNHGZNV8l8fnbbQhTbW8E4YTcBJsZ4ha4W8u0
        wUIasr/i+r6Fm0eKy8IkWzwuYWLvpFAomDbcsvcTh5hp2Pun0aoyQcxEfodOWKtC3YhAvX
        XkYM8Zj1fv0ymAXp/2rYsGI9Kr7I8qVT3VQ83RmOwmVZSzvuuSMqr5M7kHjGTHtohr/sOR
        tM8+Y4/vICuKYf3bLddjJZJw2DwYw/j6hDokHl36DDnAYQcCZZ9y6jzM8mWX6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vvHwa4ijzPORnwg40Q6sbzSiFhrexXoUjLep87zoHA=;
        b=5mC6esdXBj4rKimbeTDD8xyI6gpo1GxdxMTyLRQEB+M8NSLVA/+6PPTOMnQW94hN4WhXtw
        FBeYiLROZYMSEDDQ==
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Pressure states are unlikely
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210303034659.91735-4-zhouchengming@bytedance.com>
References: <20210303034659.91735-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <161503093847.398.958510579963989988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fddc8bab531e217806b84906681324377d741c6c
Gitweb:        https://git.kernel.org/tip/fddc8bab531e217806b84906681324377d741c6c
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Wed, 03 Mar 2021 11:46:58 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:23 +01:00

psi: Pressure states are unlikely

Move the unlikely branches out of line. This eliminates undesirable
jumps during wakeup and sleeps for workloads that aren't under any
sort of resource pressure.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210303034659.91735-4-zhouchengming@bytedance.com
---
 kernel/sched/psi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 0fe6ff6..3907a6b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -219,17 +219,17 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 {
 	switch (state) {
 	case PSI_IO_SOME:
-		return tasks[NR_IOWAIT];
+		return unlikely(tasks[NR_IOWAIT]);
 	case PSI_IO_FULL:
-		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
+		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
 	case PSI_MEM_SOME:
-		return tasks[NR_MEMSTALL];
+		return unlikely(tasks[NR_MEMSTALL]);
 	case PSI_MEM_FULL:
-		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
+		return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
 	case PSI_CPU_SOME:
-		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
+		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
 	case PSI_CPU_FULL:
-		return tasks[NR_RUNNING] && !tasks[NR_ONCPU];
+		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -729,7 +729,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * task in a cgroup is in_memstall, the corresponding groupc
 	 * on that cpu is in PSI_MEM_FULL state.
 	 */
-	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
+	if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
 	groupc->state_mask = state_mask;
