Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F9237BA6C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhELK3q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhELK3i (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331CAC06174A;
        Wed, 12 May 2021 03:28:30 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzuWqUfH8ZgkreyT3YTqrOvIU5UvcKV36Kowxe7smPc=;
        b=TCRBLgwFp4Wc5iLCRIxqGNLh2s3STyCZf6VP5LWrGHHN98EACVjPuqVVifTJFrE3uWKeZ1
        dRexQY1DRf9qTj8o6FQawSeDW3zntJUECTcN7Fnd5AZrnwDZ0aFxyZvsgyH+Jfrsr15Bu3
        yyzNmYh137E7q8vkzitQ8fkDywdRVBQ3ipHpe6waxDUC4vUQ7LKOQ+vxqVcBCrUPTvgj91
        gQ4Di5Vtp11ST0foTIWG7TpuklYr8KR1WkLzQgCh4KsYveLoXxuNvStgckEbSGWnLjZycu
        o7bzgze1w5kA/Qs3ZcB3qAY9w0kD2A7+MGlSIFGiqm6jJpL+vto/cUg0hOmIcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzuWqUfH8ZgkreyT3YTqrOvIU5UvcKV36Kowxe7smPc=;
        b=Fu1FKUdcO+1pxjgEMXisheEtNbeUT7BrgQLd2BCwsDmF5iV5EYvZS/U2X9s3Nhr8N24tkF
        VgQxBmjjC6KKTvAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add a few assertions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.015639083@infradead.org>
References: <20210422123308.015639083@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530827.29796.4612627849821173058.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9099a14708ce1dfecb6002605594a0daa319b555
Gitweb:        https://git.kernel.org/tip/9099a14708ce1dfecb6002605594a0daa319b555
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:35 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:26 +02:00

sched/fair: Add a few assertions

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.015639083@infradead.org
---
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c209f68..6bdbb7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6288,6 +6288,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		task_util = uclamp_task_util(p);
 	}
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
 	    asym_fits_capacity(task_util, target))
 		return target;
@@ -6781,8 +6786,6 @@ unlock:
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
@@ -6795,6 +6798,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
