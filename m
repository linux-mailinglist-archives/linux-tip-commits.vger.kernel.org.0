Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EC72D72E2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405662AbgLKJf1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 04:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405658AbgLKJfU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 04:35:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64426C0613D6;
        Fri, 11 Dec 2020 01:34:40 -0800 (PST)
Date:   Fri, 11 Dec 2020 09:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607679278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTHs41V+aSVHSoooUsie3k4ICBWAWRHRAMu79bY/M6Q=;
        b=jyNXMC39LoC7xQYzK5yUWjIJ10TEP/gPeqH++ez7Xe2pTaJLXMbC9W90bq+kZGlFOXGjEe
        rMsDMbgeaBjUw5x0u14kQsuHhpHbur1MVHnCLvCbrGuLIEGrcInvOolCq/0Bb0lQJyF5bn
        v4jxM9yA3hiHuSzq0c6L8UGRB1s8hN7jwN/ODos3PY0nWv2rE9NeIK1zRzit02vl/Ry8x5
        29SncbJHkPilqqpYiH51rHXAi/9TpBqmUfSo2/5yVjAByYRUt+bIwDRsct+KuIqUUqm6PP
        nWeCNKquLo31iyKZo6gygu/6Pq7pK7Z6z0+zchle2l/HXZ2cO6+sMo1P5fVnmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607679278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTHs41V+aSVHSoooUsie3k4ICBWAWRHRAMu79bY/M6Q=;
        b=NIFRtSRzL1CBiaPCB1A2/Ux+XtqakFxba1JLvo78TaQ8i272cNm/nqruAYapcO+AMSbvft
        +zjbww8cd3aHkmDg==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix kernel-doc markup
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a=2E16068?=
 =?utf-8?q?23973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a=2E160682?=
 =?utf-8?q?3973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160767927827.3364.3591387628156330333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     59a74b1544e1c07ffbfd1edff5fd73ce7d3d3146
Gitweb:        https://git.kernel.org/tip/59a74b1544e1c07ffbfd1edff5fd73ce7d3d3146
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 01 Dec 2020 13:09:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Dec 2020 10:30:31 +01:00

sched: Fix kernel-doc markup

Kernel-doc requires that a kernel-doc markup to be immediately
below the function prototype, as otherwise it will rename it.
So, move sys_sched_yield() markup to the right place.

Also fix the cpu_util() markup: Kernel-doc markups
should use this format:
        identifier - description

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a.1606823973.git.mchehab+huawei@kernel.org
---
 kernel/sched/core.c | 16 ++++++++--------
 kernel/sched/fair.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7abbba..7af80c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6611,14 +6611,6 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
 	return ret;
 }
 
-/**
- * sys_sched_yield - yield the current processor to other threads.
- *
- * This function yields the current CPU to other tasks. If there are no
- * other threads running on this CPU then this function will return.
- *
- * Return: 0.
- */
 static void do_sched_yield(void)
 {
 	struct rq_flags rf;
@@ -6636,6 +6628,14 @@ static void do_sched_yield(void)
 	schedule();
 }
 
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * This function yields the current CPU to other tasks. If there are no
+ * other threads running on this CPU then this function will return.
+ *
+ * Return: 0.
+ */
 SYSCALL_DEFINE0(sched_yield)
 {
 	do_sched_yield();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7e21ac..f5dceda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6330,7 +6330,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 }
 
 /**
- * Amount of capacity of a CPU that is (estimated to be) used by CFS tasks
+ * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
  * @cpu: the CPU to get the utilization of
  *
  * The unit of the return value must be the one of capacity so we can compare
