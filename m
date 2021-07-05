Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700553BB86A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhGEH4m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhGEH4g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B85C061765;
        Mon,  5 Jul 2021 00:53:59 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgXbFv/Xu+w45/zQ0suUEe4LiZRAi0s68DVEr9LXVs0=;
        b=cSUqNicJNW/E+JCdvmBDllTnJYL67RvPIl+oyfvFzsnRx2AxIrBuQUhpZF8lV8XZgfNXtZ
        OLTYYs3UrlcOHelc5RiJSchVWqgPfIPTq3gzJZXCVVa4rPbkAiGQrN38qYwfS/RXSLfCwq
        vEpx3noe5Kb1979lQi9wHYYf0YwghnHPsqqa9xnyeiU2u30IekVkz+P+LsdjUChuu9zV6L
        4i9VcSci8UKta67DgonatYqva7S1yTxwCmM0gAXdrIRWrvBZ2iJFQHCh5vdfeV4oQpJYcf
        EIU1ayvhXefcs7Tro3fRwRNlWpE/vF/0OnuTssk1iPuSYLpFEWEBmY46iSyM1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgXbFv/Xu+w45/zQ0suUEe4LiZRAi0s68DVEr9LXVs0=;
        b=Y3koGWpSK/gEuf/l3VWxFLyu3wKzZMn5aJziup/2pfEsfqlImvYhe8eH4Yhj1/D7I7B5GX
        RDDQyL6o8yw+8vBw==
From:   "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/uclamp: Ignore max aggregation if rq is idle
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210630141204.8197-1-xuewen.yan94@gmail.com>
References: <20210630141204.8197-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Message-ID: <162547163731.395.13224498853064077972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3e1493f46390618ea78607cb30c58fc19e2a5035
Gitweb:        https://git.kernel.org/tip/3e1493f46390618ea78607cb30c58fc19e2a5035
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Wed, 30 Jun 2021 22:12:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:24 +02:00

sched/uclamp: Ignore max aggregation if rq is idle

When a task wakes up on an idle rq, uclamp_rq_util_with() would max
aggregate with rq value. But since there is no task enqueued yet, the
values are stale based on the last task that was running. When the new
task actually wakes up and enqueued, then the rq uclamp values should
reflect that of the newly woken up task effective uclamp values.

This is a problem particularly for uclamp_max because it default to
1024. If a task p with uclamp_max = 512 wakes up, then max aggregation
would ignore the capping that should apply when this task is enqueued,
which is wrong.

Fix that by ignoring max aggregation if the rq is idle since in that
case the effective uclamp value of the rq will be the ones of the task
that will wake up.

Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
[qias: Changelog]
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lore.kernel.org/r/20210630141204.8197-1-xuewen.yan94@gmail.com
---
 kernel/sched/sched.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c80d42e..14a41a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2818,20 +2818,27 @@ static __always_inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 				  struct task_struct *p)
 {
-	unsigned long min_util;
-	unsigned long max_util;
+	unsigned long min_util = 0;
+	unsigned long max_util = 0;
 
 	if (!static_branch_likely(&sched_uclamp_used))
 		return util;
 
-	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
-	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
-
 	if (p) {
-		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
-		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+		min_util = uclamp_eff_value(p, UCLAMP_MIN);
+		max_util = uclamp_eff_value(p, UCLAMP_MAX);
+
+		/*
+		 * Ignore last runnable task's max clamp, as this task will
+		 * reset it. Similarly, no need to read the rq's min clamp.
+		 */
+		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+			goto out;
 	}
 
+	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
+	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
+out:
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
 	 * RUNNABLE tasks with _different_ clamps, we can end up with an
