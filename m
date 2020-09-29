Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C136E27BE8F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgI2H5J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44438 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgI2H4y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:54 -0400
Date:   Tue, 29 Sep 2020 07:56:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQTYCiPI5q40fNQm3+NrIave3SiYE5V8nJl7SiTseKo=;
        b=ZyyoRvgOhcl7sRf1ajoEi4OxH0V4Ndc7tBLQfIkxlOAhuenLdwUJGIQc8R5zGUIkPpr8Sn
        KtUGAW3RJ2ipUdm4Mdl6Y9O5A9Cdk47kzCSWT68pLgvzNd7G+y9a2SohR6XRC+Ado5bbqV
        cZcW8zHB5V6sBTliq1c8ievi5MuC8sv7zL062bDSsZivNEIGf/PRZQ7ON4w5UgOZLWnca/
        PdgPZvVngEg5fiIRHJzWFxLZ4HMuoXSkxQ1zhOzXQuKKhVvIRBJAtJqkZ3lDBX0PlHqiNp
        AjOLvEyi0PScxPuaVqYEWhlk8K8ocFf90AtTOnFbbY5Li+6ESJT9FSVfjBgsVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQTYCiPI5q40fNQm3+NrIave3SiYE5V8nJl7SiTseKo=;
        b=2TCtJsDmxlylJpJMje6d2D9Oexb/pmfUunDSMqrlAiXwEgUkYVcqfG/4ozllfiWTLYqAM1
        3KR/g3U8I/m/LBCg==
From:   "tip-bot2 for Xunlei Pang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix wrong cpu selecting from isolated domain
Cc:     Wetp Zhang <wetp.zy@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600930127-76857-1-git-send-email-xlpang@linux.alibaba.com>
References: <1600930127-76857-1-git-send-email-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160136621101.7002.9603761843385133161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     df3cb4ea1fb63ff326488efd671ba3c39034255e
Gitweb:        https://git.kernel.org/tip/df3cb4ea1fb63ff326488efd671ba3c39034255e
Author:        Xunlei Pang <xlpang@linux.alibaba.com>
AuthorDate:    Thu, 24 Sep 2020 14:48:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:25 +02:00

sched/fair: Fix wrong cpu selecting from isolated domain

We've met problems that occasionally tasks with full cpumask
(e.g. by putting it into a cpuset or setting to full affinity)
were migrated to our isolated cpus in production environment.

After some analysis, we found that it is due to the current
select_idle_smt() not considering the sched_domain mask.

Steps to reproduce on my 31-CPU hyperthreads machine:
1. with boot parameter: "isolcpus=domain,2-31"
   (thread lists: 0,16 and 1,17)
2. cgcreate -g cpu:test; cgexec -g cpu:test "test_threads"
3. some threads will be migrated to the isolated cpu16~17.

Fix it by checking the valid domain mask in select_idle_smt().

Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/1600930127-76857-1-git-send-email-xlpang@linux.alibaba.com
---
 kernel/sched/fair.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a15deb2..9613e5d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6080,7 +6080,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int 
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
 
@@ -6088,7 +6088,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
+		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
@@ -6104,7 +6105,7 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -6279,7 +6280,7 @@ symmetric:
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, target);
+	i = select_idle_smt(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
