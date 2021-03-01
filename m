Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D52327BC8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhCAKRX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhCAKRA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:17:00 -0500
Date:   Mon, 01 Mar 2021 10:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMrXWNyrqFlsBGFgNmfCWTvreIv3xAEl2vTQkeBNekE=;
        b=wH1vRmpKHcMs+2G8YYKF9Xz+wrMiLTAwmDWI92R5SrGVAVorNp3yDW+UZO43ZrOH5YLuaf
        lIwfHd4TGBpAOOSyumkD6cCRnw5b34X+76PUfJj5XomLN/72TbgDs+qeiHdITBW5LPwbi3
        rQudBL90AefjRJOkM9TzdppBqQ5x1+RQvFhhh8V620zI/dixqM6LZjSf1eaEkea+uCLyu+
        N8vCpbRoOGWDNzJkfjYLMFtMu+3qt2dMChyFdzdjpgeP27gxUPfFfdDSrzyRoLn/Yu3Ul5
        t66onROt70Jk3GdYied2QEqctvVe1WqwqYtxg6AoSc6D166EZLGPCAJK4uNXig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMrXWNyrqFlsBGFgNmfCWTvreIv3xAEl2vTQkeBNekE=;
        b=1vHKcX6SSL5+NjTXRsIetq5+MFK3M/fNDy1ylPoUIJd1jjHiE+A+Mir/Q3e54g6+fHLTWy
        4llgORIbN7TpVgCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Collate affine_move_task() stoppers
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.500108964@infradead.org>
References: <20210224131355.500108964@infradead.org>
MIME-Version: 1.0
Message-ID: <161459377735.20312.8945439217409912206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dbf983c0a5c37da2d476564792bd84e0e8f067fc
Gitweb:        https://git.kernel.org/tip/dbf983c0a5c37da2d476564792bd84e0e8f067fc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Feb 2021 11:15:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:14 +01:00

sched: Collate affine_move_task() stoppers

The SCA_MIGRATE_ENABLE and task_running() cases are almost identical,
collapse them to avoid further duplication.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
