Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563C63F4768
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhHWJ1D (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhHWJ1D (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:03 -0400
Date:   Mon, 23 Aug 2021 09:26:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g17YbypSrgWthB+RC3SiTiRslhck3whZNchUtG0CJ+E=;
        b=Y/r3D2PYarPCK5AAYSEPa198E53P+0z7o5suvyjPNQId0td/fl6KsoMn5Q9DJ/wbfP4D9z
        82a/KhtVaOP3c+sbwEVbb7r6K6FuWQ/TwX6YJ5UOEYa+JhOc+iwxI9kSLE7b2lPue4WKcu
        hiI7Qtq3KsgBCgkBxtGcsN9JwycHrPZUTILqHlfVtZvIC8brNRPs9wCqALkcNBgkJuGwKn
        7L+cCdPMjnwgRADz+neqm0o9h0abLdBRZpI9KogTYXLJ4KSttv/VLt2QvTIczEeTcfySBg
        TWeIVVIP/JSW9ZQ1gPfjCdt8Jeqo2f0k1mJXdq9pi3Xju9CTTBwRs+3dwuEo9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g17YbypSrgWthB+RC3SiTiRslhck3whZNchUtG0CJ+E=;
        b=j+EueIdu9wCNQCZPwAED6M+jhA2EnGG0JIvaP3MO1xZ+PZK6pwLjTAYqxPGrWPUbu6Df5M
        ZWJM8cNpMbFzHdDA==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce dl_task_check_affinity() to check
 proposed affinity
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-10-will@kernel.org>
References: <20210730112443.23245-10-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971077903.25758.13822528770886877199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     234b8ab6476c5edd5262e2ff563de9498d60044a
Gitweb:        https://git.kernel.org/tip/234b8ab6476c5edd5262e2ff563de9498d60044a
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:00 +02:00

sched: Introduce dl_task_check_affinity() to check proposed affinity

In preparation for restricting the affinity of a task during execve()
on arm64, introduce a new dl_task_check_affinity() helper function to
give an indication as to whether the restricted mask is admissible for
a deadline task.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lore.kernel.org/r/20210730112443.23245-10-will@kernel.org
---
 include/linux/sched.h |  6 +++++-
 kernel/sched/core.c   | 46 ++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ce2d5cf..3bb9fec 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1709,6 +1709,7 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
+extern int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask);
 extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
 extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
 #else
@@ -1731,6 +1732,11 @@ static inline void release_user_cpus_ptr(struct task_struct *p)
 {
 	WARN_ON(p->user_cpus_ptr);
 }
+
+static inline int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
+{
+	return 0;
+}
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ee1970..a22cc3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7756,6 +7756,32 @@ out_unlock:
 	return retval;
 }
 
+#ifdef CONFIG_SMP
+int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
+{
+	int ret = 0;
+
+	/*
+	 * If the task isn't a deadline task or admission control is
+	 * disabled then we don't care about affinity changes.
+	 */
+	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
+		return 0;
+
+	/*
+	 * Since bandwidth control happens on root_domain basis,
+	 * if admission test is enabled, we only admit -deadline
+	 * tasks allowed to run on all the CPUs in the task's
+	 * root_domain.
+	 */
+	rcu_read_lock();
+	if (!cpumask_subset(task_rq(p)->rd->span, mask))
+		ret = -EBUSY;
+	rcu_read_unlock();
+	return ret;
+}
+#endif
+
 static int
 __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 {
@@ -7773,23 +7799,9 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	cpuset_cpus_allowed(p, cpus_allowed);
 	cpumask_and(new_mask, mask, cpus_allowed);
 
-	/*
-	 * Since bandwidth control happens on root_domain basis,
-	 * if admission test is enabled, we only admit -deadline
-	 * tasks allowed to run on all the CPUs in the task's
-	 * root_domain.
-	 */
-#ifdef CONFIG_SMP
-	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
-		rcu_read_lock();
-		if (!cpumask_subset(task_rq(p)->rd->span, new_mask)) {
-			retval = -EBUSY;
-			rcu_read_unlock();
-			goto out_free_new_mask;
-		}
-		rcu_read_unlock();
-	}
-#endif
+	retval = dl_task_check_affinity(p, new_mask);
+	if (retval)
+		goto out_free_new_mask;
 again:
 	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
 	if (retval)
