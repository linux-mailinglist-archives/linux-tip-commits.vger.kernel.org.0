Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9259D32FA01
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCFLme (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCFLmY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:24 -0500
Date:   Sat, 06 Mar 2021 11:42:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRl9wChDLctARFGLoH1aQ004KYqRnXZkmfKKvdZT5WY=;
        b=YVZfb9OqZS92AIfgDgKyZt4E3/ILSBH0Bxq0StwHdrLKLdbYO5tF6rV6Z8CZRUFo7q/C7v
        27GlzQz+bWtw2+icc3VaSEKlfKzK4XAz/vQk6V1rGpD+sjm+hEc/UpKJxZG4SJWL0O7UuT
        Sahq7zeV1GxEhjpBzoDYiiy1dML9rK7dhVOc5YcyLigOqdvWk7w5zWU1UHPjeegbpw3zZF
        XBxTnhBh0TM6w9Q3i6NFsPdw8qFD330s37LWqeFiox8+jE2aWUGVBe5fTVBflJcwunKV7p
        L+FIvho83JW4PmyV3BRNki4SNUH3OnI8y/bdvkrnYrv0z/Egfn39jjJb7hCt8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRl9wChDLctARFGLoH1aQ004KYqRnXZkmfKKvdZT5WY=;
        b=8O/Mip1YzznpnGkvtqiVF96DBV5plnzxfMEcJ003O1OJHMCfyG0KYxtOznfTGrQfeh0tWB
        eHM8tJc8N894aVCg==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: use lsub_positive in cpu_util_next()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225083612.1113823-3-vincent.donnefort@arm.com>
References: <20210225083612.1113823-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161503094130.398.6124387493467624368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     736cc6b31102236a55470c72523ed0a65eb3f804
Gitweb:        https://git.kernel.org/tip/736cc6b31102236a55470c72523ed0a65eb3f804
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 25 Feb 2021 08:36:12 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

sched/fair: use lsub_positive in cpu_util_next()

The sub_positive local version is saving an explicit load-store and is
enough for the cpu_util_next() usage.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20210225083612.1113823-3-vincent.donnefort@arm.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b994db9..7b2fac0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6471,7 +6471,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 	 * util_avg should already be correct.
 	 */
 	if (task_cpu(p) == cpu && dst_cpu != cpu)
-		sub_positive(&util, task_util(p));
+		lsub_positive(&util, task_util(p));
 	else if (task_cpu(p) != cpu && dst_cpu == cpu)
 		util += task_util(p);
 
