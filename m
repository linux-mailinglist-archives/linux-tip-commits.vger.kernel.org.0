Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34FE327BC6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhCAKRP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58314 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhCAKQ7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:16:59 -0500
Date:   Mon, 01 Mar 2021 10:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUFCKsst8/NH3pqLTxh0upfjk+FjzzWBVUM0frrnX8I=;
        b=gDbeF4dOEwnFQCZ5rlVf5uk1GMtOIfp1lMAkykHsMHNMA3CFqPIr6y1mfRfqGahftBcefj
        qJBAtNnlAgvp4ufJFgGMLc42YfSTOZfLFnSMKNqlWUXh6BnGZPZfudeN5iT8wZYdtkHh2Q
        VpiacUk1mw7Nj6SsoZBjrp0rZ9BaUYGFLeaQjb1DqJOTcBNHndGwLmewF72jxCB6Re7QyH
        ihnXWKG8DOZzmAfANoBC6HjlARGndAAjxmLhgOAWrw45N88Cbkz7xxdNs8rKRIPrd2PM5t
        j7vo4NKG47trW66ezlHU1Lqhvezjfc33PKEaCshtsTKwUMfz/RaFoYGQJkvFKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUFCKsst8/NH3pqLTxh0upfjk+FjzzWBVUM0frrnX8I=;
        b=p2NOQ9f+ysYLrco3wQeKseJK0hVLKAPGO1S3DKIa8P4HnfddVKm65QQ3jdf1thxzT5nsK1
        RTsA/5amo7FJubAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Optimize migration_cpu_stop()
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.569238629@infradead.org>
References: <20210224131355.569238629@infradead.org>
MIME-Version: 1.0
Message-ID: <161459377710.20312.5135775358196230734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9eca0f53b1c2f5acb85e84673e263bf996817a24
Gitweb:        https://git.kernel.org/tip/9eca0f53b1c2f5acb85e84673e263bf996817a24
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Feb 2021 11:21:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:14 +01:00

sched: Optimize migration_cpu_stop()

When the purpose of migration_cpu_stop() is to migrate the task to
'any' valid CPU, don't migrate the task when it's already running on a
valid CPU.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.569238629@infradead.org
---
 kernel/sched/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84b657f..ac05afb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1936,14 +1936,25 @@ static int migration_cpu_stop(void *data)
 			complete = true;
 		}
 
-		if (dest_cpu < 0)
+		if (dest_cpu < 0) {
+			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
+				goto out;
+
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
+		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
 			p->wake_cpu = dest_cpu;
 
+		/*
+		 * XXX __migrate_task() can fail, at which point we might end
+		 * up running on a dodgy CPU, AFAICT this can only happen
+		 * during CPU hotplug, at which point we'll get pushed out
+		 * anyway, so it's probably not a big deal.
+		 */
+
 	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
