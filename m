Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEE32B05D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350248AbhCCDhj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378853AbhCBJDa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC8C061797;
        Tue,  2 Mar 2021 01:01:56 -0800 (PST)
Date:   Tue, 02 Mar 2021 09:01:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KG8CDlGrs4zFRMLMM1CYylKc4mzHdK1D/eFfaY+tk3c=;
        b=SrfZ3pF/Weu5UKkcrvOwD5d6qGxEAF0h+3Bl8xcCzRcLVW98BJK9n4wsOCFKNXT3HjSr0l
        /UvOWobycKGNEfyLmXmCRt8+m+j+FaO0BcrAMprX7W1zMKoEquHZ1/6sSfnqc7NMewsvJQ
        D1nM0+63JkHktr9v8uC1bZu4QXt5eeipgAruOJL5W0caB/Zo+q3UdYEUixCsfOyczdWaNJ
        Qj48r0SuF8ppqQIPpxCYQ4hNntsnUnd8Eob3rwby8dXWWUATMOe7irAZNhUUQphQhTqbZr
        EQ05Wf25yXGLFQ2wuzeWG+SAfsYc3y+dzAf3IuK0cY5uDp85oKW6Pld2N4Tfww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KG8CDlGrs4zFRMLMM1CYylKc4mzHdK1D/eFfaY+tk3c=;
        b=AUL1AeNttCsWpMSMdeplUAFvRbnJkBsvivPBYRTjGrlFp5hZX2JYMoBgh7FBcWcZQ732Q5
        e4qivL8bxKLg6BCQ==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: use lsub_positive in cpu_util_next()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225083612.1113823-3-vincent.donnefort@arm.com>
References: <20210225083612.1113823-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161467571374.20312.11737796589208519243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4537b36ee8a290376174b297d6812cba1375ea79
Gitweb:        https://git.kernel.org/tip/4537b36ee8a290376174b297d6812cba1375ea79
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 25 Feb 2021 08:36:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:25 +01:00

sched/fair: use lsub_positive in cpu_util_next()

The sub_positive local version is saving an explicit load-store and is
enough for the cpu_util_next() usage.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
