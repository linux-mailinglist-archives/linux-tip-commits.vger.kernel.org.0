Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083013F476B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhHWJ1I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhHWJ1F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43967C061575;
        Mon, 23 Aug 2021 02:26:23 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZsdDEkRMnqyeRLxz+qOuwyiX7+zcciH/7fScT18zqrg=;
        b=fjuBwuiphb4D3f78yQJEZI+NdifJOLJLLQll3VCh7saSTaOJmZivxnvCS/XN4LDLK3Ixag
        dAtelr9fJV0U6JSPWodI71UCN6V2H+KygP/heCATMHb5xh5oAPoj5ANkjIkVoUWEHWIdnr
        gNsxrpc+ZKKOkx5Pabmk68WMmVo7GOcL9ZtNAXN/OarqrJkJwLAIfUwVLm0LzEIKF6gGhl
        QHaFnTNSfHZByjOVsOfT/HnF5KDUsempuYRyjes0zW3oA7EeuIkQx9CvYwI3NvLYMKa3HH
        tLu7Luy+3W0NHrPurZ3luokgd7f6+tTwjC3bLEAIulRVz2shXU6vkUz2Ivfv3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZsdDEkRMnqyeRLxz+qOuwyiX7+zcciH/7fScT18zqrg=;
        b=e8rED2K+LjyBAPaQKBaD0Skmx/NqXPBzvw2E5VCHnx5P+nIRZxg0Qx/QfwgGamWRnmQLpt
        vYi/OYc2ueXNXaCA==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Split the guts of sched_setaffinity() into a
 helper function
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-8-will@kernel.org>
References: <20210730112443.23245-8-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078114.25758.18226375114589760498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     db3b02ae896e88b6bb7a95c1373602e87e0de84c
Gitweb:        https://git.kernel.org/tip/db3b02ae896e88b6bb7a95c1373602e87e0de84c
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:00 +02:00

sched: Split the guts of sched_setaffinity() into a helper function

In preparation for replaying user affinity requests using a saved mask,
split sched_setaffinity() up so that the initial task lookup and
security checks are only performed when the request is coming directly
from userspace.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Link: https://lore.kernel.org/r/20210730112443.23245-8-will@kernel.org
---
 kernel/sched/core.c | 105 +++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 360a3ec..672d0fc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7594,53 +7594,22 @@ out_unlock:
 	return retval;
 }
 
-long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+static int
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 {
-	cpumask_var_t cpus_allowed, new_mask;
-	struct task_struct *p;
 	int retval;
+	cpumask_var_t cpus_allowed, new_mask;
 
-	rcu_read_lock();
-
-	p = find_process_by_pid(pid);
-	if (!p) {
-		rcu_read_unlock();
-		return -ESRCH;
-	}
-
-	/* Prevent p going away */
-	get_task_struct(p);
-	rcu_read_unlock();
+	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
+		return -ENOMEM;
 
-	if (p->flags & PF_NO_SETAFFINITY) {
-		retval = -EINVAL;
-		goto out_put_task;
-	}
-	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_put_task;
-	}
 	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
 		retval = -ENOMEM;
 		goto out_free_cpus_allowed;
 	}
-	retval = -EPERM;
-	if (!check_same_owner(p)) {
-		rcu_read_lock();
-		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
-			rcu_read_unlock();
-			goto out_free_new_mask;
-		}
-		rcu_read_unlock();
-	}
-
-	retval = security_task_setscheduler(p);
-	if (retval)
-		goto out_free_new_mask;
-
 
 	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, in_mask, cpus_allowed);
+	cpumask_and(new_mask, mask, cpus_allowed);
 
 	/*
 	 * Since bandwidth control happens on root_domain basis,
@@ -7661,23 +7630,63 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 #endif
 again:
 	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+	if (retval)
+		goto out_free_new_mask;
 
-	if (!retval) {
-		cpuset_cpus_allowed(p, cpus_allowed);
-		if (!cpumask_subset(new_mask, cpus_allowed)) {
-			/*
-			 * We must have raced with a concurrent cpuset
-			 * update. Just reset the cpus_allowed to the
-			 * cpuset's cpus_allowed
-			 */
-			cpumask_copy(new_mask, cpus_allowed);
-			goto again;
-		}
+	cpuset_cpus_allowed(p, cpus_allowed);
+	if (!cpumask_subset(new_mask, cpus_allowed)) {
+		/*
+		 * We must have raced with a concurrent cpuset update.
+		 * Just reset the cpumask to the cpuset's cpus_allowed.
+		 */
+		cpumask_copy(new_mask, cpus_allowed);
+		goto again;
 	}
+
 out_free_new_mask:
 	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
+	return retval;
+}
+
+long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+{
+	struct task_struct *p;
+	int retval;
+
+	rcu_read_lock();
+
+	p = find_process_by_pid(pid);
+	if (!p) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	/* Prevent p going away */
+	get_task_struct(p);
+	rcu_read_unlock();
+
+	if (p->flags & PF_NO_SETAFFINITY) {
+		retval = -EINVAL;
+		goto out_put_task;
+	}
+
+	if (!check_same_owner(p)) {
+		rcu_read_lock();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
+			rcu_read_unlock();
+			retval = -EPERM;
+			goto out_put_task;
+		}
+		rcu_read_unlock();
+	}
+
+	retval = security_task_setscheduler(p);
+	if (retval)
+		goto out_put_task;
+
+	retval = __sched_setaffinity(p, in_mask);
 out_put_task:
 	put_task_struct(p);
 	return retval;
