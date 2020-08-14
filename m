Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0699E244BEE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Aug 2020 17:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHNPXg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 Aug 2020 11:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgHNPXf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 Aug 2020 11:23:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A05BC061384;
        Fri, 14 Aug 2020 08:23:35 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597418612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxijkchU6sNiCpR4KeATov851rvZ0Sv1BzTjc6LUFU0=;
        b=uBw7rzHxU0vHlRPNVeED4YZrxEg/fmfDhOgQVPcJdUliEuGVcyrST6rmIZmqW+4CeQvjT8
        yj8dwT0aZ5heR4WlwDWQKyuwJhdOfkSOdRohoQGUKh6yY1V1vQCOmJKubBD/glQKKd97cc
        6XHCa5xfFVFuy+9AQcuYmy3h/CPXKp+dhoV6PGQ5zla/QE+uj++7aYSXbdljstkqVCl1nZ
        ChNJvO/RG9vilrfJbJWAk8LpTuG9AMPFaEVLWaVTRTssSF1Mwqxiuj2ujEaReuFJqvNxBf
        0SbcdWsAYMd5pJZr4kdXaFQ9qu8JE4mpjrEDv5IYVzdLwXXqHD9a+2KTY6ECcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597418612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxijkchU6sNiCpR4KeATov851rvZ0Sv1BzTjc6LUFU0=;
        b=XW4x7IyJfULBpOc7puCN6BTHJZI6glsMD4LmUtl6yWjNjUo9COJdFdxNrnACRJqrSM1rWi
        X1OjcgXSHzNRQ5Ag==
From:   "tip-bot2 for Libing Zhou" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Fix the alignment of the show-state
 debug output
Cc:     Libing Zhou <libing.zhou@nokia-sbell.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200814030236.37835-1-libing.zhou@nokia-sbell.com>
References: <20200814030236.37835-1-libing.zhou@nokia-sbell.com>
MIME-Version: 1.0
Message-ID: <159741861177.3192.4513754043374391379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     cc172ff301d8079e941a6eb31758951a6d764084
Gitweb:        https://git.kernel.org/tip/cc172ff301d8079e941a6eb31758951a6d764084
Author:        Libing Zhou <libing.zhou@nokia-sbell.com>
AuthorDate:    Fri, 14 Aug 2020 11:02:36 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Aug 2020 12:36:18 +02:00

sched/debug: Fix the alignment of the show-state debug output

Current sysrq(t) output task fields name are not aligned with
actual task fields value, e.g.:

	kernel: sysrq: Show State
	kernel:  task                        PC stack   pid father
	kernel: systemd         S12456     1      0 0x00000000
	kernel: Call Trace:
	kernel: ? __schedule+0x240/0x740

To make it more readable, print fields name together with task fields
value in the same line, with fixed width:

	kernel: sysrq: Show State
	kernel: task:systemd         state:S stack:12920 pid:    1 ppid:     0 flags:0x00000000
	kernel: Call Trace:
	kernel: __schedule+0x282/0x620

Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200814030236.37835-1-libing.zhou@nokia-sbell.com
---
 kernel/sched/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4a0e7b4..09fd625 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6387,10 +6387,10 @@ void sched_show_task(struct task_struct *p)
 	if (!try_get_task_stack(p))
 		return;
 
-	printk(KERN_INFO "%-15.15s %c", p->comm, task_state_to_char(p));
+	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
 
 	if (p->state == TASK_RUNNING)
-		printk(KERN_CONT "  running task    ");
+		pr_cont("  running task    ");
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
 #endif
@@ -6399,8 +6399,8 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	printk(KERN_CONT "%5lu %5d %6d 0x%08lx\n", free,
-		task_pid_nr(p), ppid,
+	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
+		free, task_pid_nr(p), ppid,
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
@@ -6435,13 +6435,6 @@ void show_state_filter(unsigned long state_filter)
 {
 	struct task_struct *g, *p;
 
-#if BITS_PER_LONG == 32
-	printk(KERN_INFO
-		"  task                PC stack   pid father\n");
-#else
-	printk(KERN_INFO
-		"  task                        PC stack   pid father\n");
-#endif
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/*
