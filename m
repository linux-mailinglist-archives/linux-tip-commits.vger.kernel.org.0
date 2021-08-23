Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E93F476E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhHWJ1K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhHWJ1H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81CAC061764;
        Mon, 23 Aug 2021 02:26:24 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWhQTcgp9D4npvWYuKZ1pU53aWQERcYDfDTRpYnJJSU=;
        b=EmtJFznOKKEJy2xr+Pf49Aab0EHUt1gODPALvbORHkocTXmAnCPtPF5LWEKa+Ns5abRThh
        9qVjaEOfGflcmij0Md1rIasBHvvI6bXgennQ3QBZkaRMDjQbgZhjMzbj9/FZeK15a/A1r8
        WkG17z0Pk1H1V1GnSfaJHLmYKfflXC1pSXb771sOK1+kNbNC1fBeOShXDf842qFNEYbJjM
        JL4i8Mk/lbNOt7sfGHPWWO9wFFLVYH9g1ur7euyq/UhIsV5UVaKI39pFuSopZY51sKfRxq
        t2k5VyhPtpiu6akylX75VGA82+QCPdV8ARdkAFkdYnQYjIT3sfNI4+4Tbf8Vxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWhQTcgp9D4npvWYuKZ1pU53aWQERcYDfDTRpYnJJSU=;
        b=4+HlyjV/xPzTYi2M+azRmUTntmwAYM3BU3ZWV5Rf5QSHlAiGl6uaRBDThOuulA45LmZDLX
        r6hyC1Himd/0S6Cg==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Reject CPU affinity changes based on
 task_cpu_possible_mask()
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Quentin Perret <qperret@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-6-will@kernel.org>
References: <20210730112443.23245-6-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078270.25758.8552853367056272946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     234a503e670be01f72841be9fcf68dfb89a1fa8b
Gitweb:        https://git.kernel.org/tip/234a503e670be01f72841be9fcf68dfb89a1fa8b
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:59 +02:00

sched: Reject CPU affinity changes based on task_cpu_possible_mask()

Reject explicit requests to change the affinity mask of a task via
set_cpus_allowed_ptr() if the requested mask is not a subset of the
mask returned by task_cpu_possible_mask(). This ensures that the
'cpus_mask' for a given task cannot contain CPUs which are incapable of
executing it, except in cases where the affinity is forced.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Link: https://lore.kernel.org/r/20210730112443.23245-6-will@kernel.org
---
 kernel/sched/core.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b9d4bae..8cec0d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2709,7 +2709,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  const struct cpumask *new_mask,
 				  u32 flags)
 {
+	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	bool kthread = p->flags & PF_KTHREAD;
 	unsigned int dest_cpu;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -2718,7 +2720,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
+	if (kthread || is_migration_disabled(p)) {
 		/*
 		 * Kernel threads are allowed on online && !active CPUs,
 		 * however, during cpu-hot-unplug, even these might get pushed
@@ -2732,6 +2734,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
+	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
