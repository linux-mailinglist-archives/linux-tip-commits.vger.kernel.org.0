Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0063F3F4770
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhHWJ1K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhHWJ1I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661DC061575;
        Mon, 23 Aug 2021 02:26:26 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emgugvQ6NDo24O6txtfBIb+5Ga4ZjBPXiH+tAw0MtkA=;
        b=2cXJlqDOLz25ssTsay7g3+wh2Rca5wl7qaW8ZMGpUxmQmS0lM+5csK8r1e1CHOYwhm7NeI
        lR96SAoOFT450CyhbCeBs3iZV7kjF9tLd6HAKw2nhNOI6wK3Dixo34hyZ6MRmqFmXk7A15
        kl/bqII5w4TrvDybHXikHB7MO0rp/L7r+3Dq80CtbN90s4hSxGZwqUMiKlJK7jybOU/QBt
        pQxlV4RHyQKwq4jr7swUrsLm5m4NOKXj0kiKNNNuu0II7zSnSDFJtQ1OchKpCmUra9F3jC
        mGWDmKlV26atfjEMjSe6reQqiIT1n/iSReCOLvpftw1O7SqKLs8f7+muzIeMuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emgugvQ6NDo24O6txtfBIb+5Ga4ZjBPXiH+tAw0MtkA=;
        b=qiGDWBOLlLdYuoGTQDWyG/5SFGbN4GaYLWBJtUIKsP93V+PrUBwlCDuiJIgLNwRuEHbDnd
        G3T/zSPKZMCo7vBw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuset: Honour task_cpu_possible_mask() in
 guarantee_online_cpus()
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-4-will@kernel.org>
References: <20210730112443.23245-4-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078439.25758.9786344164798338385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     431c69fac05baa7477d61a44f2708e069f2bed6c
Gitweb:        https://git.kernel.org/tip/431c69fac05baa7477d61a44f2708e069f2bed6c
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:59 +02:00

cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

Modify guarantee_online_cpus() to take task_cpu_possible_mask() into
account when trying to find a suitable set of online CPUs for a given
task. This will avoid passing an invalid mask to set_cpus_allowed_ptr()
during ->attach() and will subsequently allow the cpuset hierarchy to be
taken into account when forcefully overriding the affinity mask for a
task which requires migration to a compatible CPU.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Link: https://lkml.kernel.org/r/20210730112443.23245-4-will@kernel.org
---
 include/linux/cpuset.h |  2 +-
 kernel/cgroup/cpuset.c | 43 ++++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index ed6ec67..414a8e6 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -185,7 +185,7 @@ static inline void cpuset_read_unlock(void) { }
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
-	cpumask_copy(mask, cpu_possible_mask);
+	cpumask_copy(mask, task_cpu_possible_mask(p));
 }
 
 static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a869378..3918132 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -372,18 +372,29 @@ static inline bool is_in_v2_mode(void)
 }
 
 /*
- * Return in pmask the portion of a cpusets's cpus_allowed that
- * are online.  If none are online, walk up the cpuset hierarchy
- * until we find one that does have some online cpus.
+ * Return in pmask the portion of a task's cpusets's cpus_allowed that
+ * are online and are capable of running the task.  If none are found,
+ * walk up the cpuset hierarchy until we find one that does have some
+ * appropriate cpus.
  *
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_mask.
  *
  * Call with callback_lock or cpuset_mutex held.
  */
-static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
+static void guarantee_online_cpus(struct task_struct *tsk,
+				  struct cpumask *pmask)
 {
-	while (!cpumask_intersects(cs->effective_cpus, cpu_online_mask)) {
+	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+	struct cpuset *cs;
+
+	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))
+		cpumask_copy(pmask, cpu_online_mask);
+
+	rcu_read_lock();
+	cs = task_cs(tsk);
+
+	while (!cpumask_intersects(cs->effective_cpus, pmask)) {
 		cs = parent_cs(cs);
 		if (unlikely(!cs)) {
 			/*
@@ -393,11 +404,13 @@ static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
 			 * cpuset's effective_cpus is on its way to be
 			 * identical to cpu_online_mask.
 			 */
-			cpumask_copy(pmask, cpu_online_mask);
-			return;
+			goto out_unlock;
 		}
 	}
-	cpumask_and(pmask, cs->effective_cpus, cpu_online_mask);
+	cpumask_and(pmask, pmask, cs->effective_cpus);
+
+out_unlock:
+	rcu_read_unlock();
 }
 
 /*
@@ -2199,15 +2212,13 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	percpu_down_write(&cpuset_rwsem);
 
-	/* prepare for attach */
-	if (cs == &top_cpuset)
-		cpumask_copy(cpus_attach, cpu_possible_mask);
-	else
-		guarantee_online_cpus(cs, cpus_attach);
-
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
 	cgroup_taskset_for_each(task, css, tset) {
+		if (cs != &top_cpuset)
+			guarantee_online_cpus(task, cpus_attach);
+		else
+			cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
 		/*
 		 * can_attach beforehand should guarantee that this doesn't
 		 * fail.  TODO: have a better way to handle failure here
@@ -3302,9 +3313,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
-	guarantee_online_cpus(task_cs(tsk), pmask);
-	rcu_read_unlock();
+	guarantee_online_cpus(tsk, pmask);
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
