Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27571300A44
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbhAVRuv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbhAVRmZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D0C061788;
        Fri, 22 Jan 2021 09:41:40 -0800 (PST)
Date:   Fri, 22 Jan 2021 17:41:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9BcL50rm8i5DNQgULkOCBpJrrpITPsfg3U2i/kOcEA=;
        b=yz8tOfGlNdAr0Dv36lemlm0n/Q/UBsitU+zS6zcWmHyvSM4sjmVpr+Wegq3MDIQZDg1Hhs
        Xmb1vYYpHit0/X7pxWPzIoR3b8d5Ha3+Z9NL1rZpb/SJjAHTNoiAQoLbK3co7JV6GIVrmR
        qcHsFHcPhv9xUve46bNQbytFvJlihLbB/oguFbQPC7R/OPu32e98sxU9Pr80QGXRBpzmE1
        a0nMG+M3c4fidruABGNAr2yHLI7ht4WTVcLaND8n84Ate6LdVOfl2KPYgF+re4Om8OpWd0
        bXDXsN00wMAJWLsFNr84tx0cSafGY5DSvIwPR98VF0d/QPcGcxAKU2dbsD2JRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9BcL50rm8i5DNQgULkOCBpJrrpITPsfg3U2i/kOcEA=;
        b=oflT5tJChUehbrKcRoFq4wHMW8yD/COt8A80W07aSgrYOJITBX8r7e/lIwuMcE47wJYYdR
        NALNN7ISzRLXDmCQ==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] workqueue: Use cpu_possible_mask instead of
 cpu_active_mask to break affinity
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210111152638.2417-4-jiangshanlai@gmail.com>
References: <20210111152638.2417-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <161133729644.414.3800664867137502999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     547a77d02f8cfb345631ce23b5b548d27afa0fc4
Gitweb:        https://git.kernel.org/tip/547a77d02f8cfb345631ce23b5b548d27afa0fc4
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Mon, 11 Jan 2021 23:26:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:41 +01:00

workqueue: Use cpu_possible_mask instead of cpu_active_mask to break affinity

The scheduler won't break affinity for us any more, and we should
"emulate" the same behavior when the scheduler breaks affinity for
us.  The behavior is "changing the cpumask to cpu_possible_mask".

And there might be some other CPUs online later while the worker is
still running with the pending work items.  The worker should be allowed
to use the later online CPUs as before and process the work items ASAP.
If we use cpu_active_mask here, we can't achieve this goal but
using cpu_possible_mask can.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210111152638.2417-4-jiangshanlai@gmail.com
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9880b6c..1646331 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4920,7 +4920,7 @@ static void unbind_workers(int cpu)
 		raw_spin_unlock_irq(&pool->lock);
 
 		for_each_pool_worker(worker, pool)
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
