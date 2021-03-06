Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE232FA13
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCFLmi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhCFLm0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:26 -0500
Date:   Sat, 06 Mar 2021 11:42:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tATWz1CDhS4DAfJw7G7sQM7nzszKTwIxUs/B+vIbjMA=;
        b=BGgRT4GB52SPWjHyzfY3ReuNiNW13p/O0zskEnpfdQY9xstjs1jleeidc7V3Ue0URD3IM/
        jYbUCLJ0ZOMONIuk3OBBFn08ktqwHoJA2G8KkfiWb4NTb9z3jG4SmWJ3PEfz7UvJ5Oj9aU
        jy68jYSEIjHgQGwiESkbygJH2NKIFQAgv9uR2uLEsyq3jADgWBpYM0epML66Bh+XAFS+oT
        porlY9+geZlR8x4gPVbaGsj2fCSF8nTuggMGZDmOSCcM475iqU2nt+7jMgrEGdbvnTO2Xy
        mpsGt/NHwjD1pdxzPWX+b7eq4VMd1gHI1SDJw4p154g59s3mVUuk22ahfS8Tfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tATWz1CDhS4DAfJw7G7sQM7nzszKTwIxUs/B+vIbjMA=;
        b=x0QHGb0R5THTv2VYCb4Ypc9wiZNJWO6vGLaIpg9kDnQCgGW0T/aCFO6acRSuYPOpufabeM
        Iv5Rqqvv7a6+WNBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Collate affine_move_task() stoppers
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.500108964@infradead.org>
References: <20210224131355.500108964@infradead.org>
MIME-Version: 1.0
Message-ID: <161503094556.398.6962761454913444272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     58b1a45086b5f80f2b2842aa7ed0da51a64a302b
Gitweb:        https://git.kernel.org/tip/58b1a45086b5f80f2b2842aa7ed0da51a64a302b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Feb 2021 11:15:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:21 +01:00

sched: Collate affine_move_task() stoppers

The SCA_MIGRATE_ENABLE and task_running() cases are almost identical,
collapse them to avoid further duplication.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.500108964@infradead.org
---
 kernel/sched/core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 088e8f4..84b657f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2239,30 +2239,23 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (flags & SCA_MIGRATE_ENABLE) {
-
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
-		p->migration_flags &= ~MDF_PUSH;
-		task_rq_unlock(rq, p, rf);
-
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
-
-		return 0;
-	}
-
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		/*
-		 * Lessen races (and headaches) by delegating
-		 * is_migration_disabled(p) checks to the stopper, which will
-		 * run on the same CPU as said p.
+		 * MIGRATE_ENABLE gets here because 'p == current', but for
+		 * anything else we cannot do is_migration_disabled(), punt
+		 * and have the stopper function handle it all race-free.
 		 */
+
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
+		if (flags & SCA_MIGRATE_ENABLE)
+			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
+		if (flags & SCA_MIGRATE_ENABLE)
+			return 0;
 	} else {
 
 		if (!is_migration_disabled(p)) {
