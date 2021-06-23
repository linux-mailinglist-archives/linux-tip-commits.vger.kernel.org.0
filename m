Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651453B15AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFWIVv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhFWIVj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:39 -0400
Date:   Wed, 23 Jun 2021 08:19:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tmf+B/ay9uQXnP5gmNJ4t/WgEwzskc41MT+UY+HvSJ0=;
        b=blUjUCbrUZcoy5pJjB6WXxGtH/uFQDqjcsRnkw4UWTk/aHb6km9KtRo+SV9424mMn9OJZ5
        dvTzFDyBLj7pmVsjMUjGxCVhui50COy40/CxataUZpnk7tE/xARpSWZuFFrWAMQhAvNzfJ
        3bVY9piEdERAWqWB8w0iIX4YYSrOkSnwcnwVWO2ixldAvCYFs3/IwL4LBtRQ3zf7KVoZxM
        tflqkiOxC6+u/5iyJjLXGJ20MjdpFj1OooLkEJSYDAjSAaiPLSJRilRzdsG2hWrDB/Z5i6
        cOxes4dtqE0HAV+FNHCj9EZ70TOKhyTyQU1Ve4yrKYeJLXlb9KrJIGBusFmnAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tmf+B/ay9uQXnP5gmNJ4t/WgEwzskc41MT+UY+HvSJ0=;
        b=yMMIueF/t02vwWSyud9ojBJL1Af5wdwWKBch9ydRTzRbLuPvol03u8UEo1NV+60iToSj4d
        MkPxrHFbGfUjTUBA==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Fix Deadline utilization tracking during
 policy change
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1624271872-211872-3-git-send-email-vincent.donnefort@arm.com>
References: <1624271872-211872-3-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <162443636041.395.15592882101869070492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d7d607096ae6d378b4e92d49946d22739c047d4c
Gitweb:        https://git.kernel.org/tip/d7d607096ae6d378b4e92d49946d22739c047d4c
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Mon, 21 Jun 2021 11:37:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:41:59 +02:00

sched/rt: Fix Deadline utilization tracking during policy change

DL keeps track of the utilization on a per-rq basis with the structure
avg_dl. This utilization is updated during task_tick_dl(),
put_prev_task_dl() and set_next_task_dl(). However, when the current
running task changes its policy, set_next_task_dl() which would usually
take care of updating the utilization when the rq starts running DL
tasks, will not see a such change, leaving the avg_dl structure outdated.
When that very same task will be dequeued later, put_prev_task_dl() will
then update the utilization, based on a wrong last_update_time, leading to
a huge spike in the DL utilization signal.

The signal would eventually recover from this issue after few ms. Even
if no DL tasks are run, avg_dl is also updated in
__update_blocked_others(). But as the CPU capacity depends partly on the
avg_dl, this issue has nonetheless a significant impact on the scheduler.

Fix this issue by ensuring a load update when a running task changes
its policy to DL.

Fixes: 3727e0e ("sched/dl: Add dl_rq utilization tracking")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/1624271872-211872-3-git-send-email-vincent.donnefort@arm.com
---
 kernel/sched/deadline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 22878cd..aaacd6c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2497,6 +2497,8 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
+	} else {
+		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 	}
 }
 
