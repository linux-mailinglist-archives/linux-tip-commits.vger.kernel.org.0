Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6C3F476D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhHWJ1J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbhHWJ1H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:07 -0400
Date:   Mon, 23 Aug 2021 09:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wDMBu+Rr2x4fMrNRN54aQCsE5XJcwLloswIWSAY6ig=;
        b=Ks/L813CndOly0HeKvnHQQE7gLcbluVVe8hLQW7OforiH1BWzw6JkxgJmGnVNNcQejGpu3
        6cm3b7cDKdVjG3FjQhfXIRvQIscRFENB9AD0ypPBVeqhJUYeXxuj8T4XgZ+jjAZCK87XaJ
        UbjO3IOHqDSk8/7F13XFqFZ7z5qcBXPeEsRYFpWUxq2q3FtROIoAo6mog/yzmrCZ1FKvZE
        kXJhcll7NbTDwN3YcySwviPhD9TQgYZYHyWgQ6rIVRirxyhvkyGgW4ye0FvHa4SN7UZGEH
        iuCtEW81wgxkNPjGsN9Q8xBHL34d3A+eX+wCKgNDtRzJNtxT4LTvB9v3X/ZqNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wDMBu+Rr2x4fMrNRN54aQCsE5XJcwLloswIWSAY6ig=;
        b=CI7pU7Ng/ENCvCAp8OlMTqoafeZGasSxnWKYEPgno8w81nbYCQaTME09zKSbLfnrfv+Nq5
        nfBqYL8H65Xyp9AQ==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuset: Cleanup cpuset_cpus_allowed_fallback() use
 in select_fallback_rq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-5-will@kernel.org>
References: <20210730112443.23245-5-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078351.25758.10217661081827185654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     97c0054dbe2c3c59d1156fd233f2d44e91981c8e
Gitweb:        https://git.kernel.org/tip/97c0054dbe2c3c59d1156fd233f2d44e91981c8e
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:59 +02:00

cpuset: Cleanup cpuset_cpus_allowed_fallback() use in select_fallback_rq()

select_fallback_rq() only needs to recheck for an allowed CPU if the
affinity mask of the task has changed since the last check.

Return a 'bool' from cpuset_cpus_allowed_fallback() to indicate whether
the affinity mask was updated, and use this to elide the allowed check
when the mask has been left alone.

No functional change.

Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20210730112443.23245-5-will@kernel.org
---
 include/linux/cpuset.h |  5 +++--
 kernel/cgroup/cpuset.c | 10 ++++++++--
 kernel/sched/core.c    |  3 +--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 414a8e6..d2b9c41 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -59,7 +59,7 @@ extern void cpuset_wait_for_hotplug(void);
 extern void cpuset_read_lock(void);
 extern void cpuset_read_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
-extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
+extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -188,8 +188,9 @@ static inline void cpuset_cpus_allowed(struct task_struct *p,
 	cpumask_copy(mask, task_cpu_possible_mask(p));
 }
 
-static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
+static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
 {
+	return false;
 }
 
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3918132..6500cbe 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3327,17 +3327,22 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
  * which will not contain a sane cpumask during cases such as cpu hotplugging.
  * This is the absolute last resort for the scheduler and it is only used if
  * _every_ other avenue has been traveled.
+ *
+ * Returns true if the affinity of @tsk was changed, false otherwise.
  **/
 
-void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
+bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
 	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
 	const struct cpumask *cs_mask;
+	bool changed = false;
 
 	rcu_read_lock();
 	cs_mask = task_cs(tsk)->cpus_allowed;
-	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
+	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) {
 		do_set_cpus_allowed(tsk, cs_mask);
+		changed = true;
+	}
 	rcu_read_unlock();
 
 	/*
@@ -3357,6 +3362,7 @@ void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 	 * select_fallback_rq() will fix things ups and set cpu_possible_mask
 	 * if required.
 	 */
+	return changed;
 }
 
 void __init cpuset_init_current_mems_allowed(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6f31267..b9d4bae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3141,8 +3141,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 		/* No more Mr. Nice Guy. */
 		switch (state) {
 		case cpuset:
-			if (IS_ENABLED(CONFIG_CPUSETS)) {
-				cpuset_cpus_allowed_fallback(p);
+			if (cpuset_cpus_allowed_fallback(p)) {
 				state = possible;
 				break;
 			}
