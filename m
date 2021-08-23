Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC33F4771
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhHWJ1L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbhHWJ1J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE5C061760;
        Mon, 23 Aug 2021 02:26:27 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILzqYXJqSiZAI2gYAvFZrl45beVSfZHEvA4DDkoxbEE=;
        b=Ba1aZdCV7m4jFlBybX32Dje0Mulo7TBSlQdLo8h48IbwWLQPZWxMlfaE7u3/+S+OflVHmQ
        9vtBV3oTmKgTofigVbUa891/2nxNaU06cWrFyP9uHqG+5iSomtCMYNx3uia+kfmZ1xFp8a
        z+wnQhLrBBDYEp33JRsC/PVbnutqxD5N7Pu7p01LdZG5KG5IcqYq9myG1HueP1s6LtYvYj
        Mdyq7FAyNoY/H+lnyK5Lc1KZ8upeNug30l62Ne7tOeI9/UyZmwt6yEDVYob3B6xlOBq4uJ
        g96dCOS4RkzoXfOkznScZjc7ra/szyVppqj8dQfNp9Q1l/sAo1JUCIvGvySWaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILzqYXJqSiZAI2gYAvFZrl45beVSfZHEvA4DDkoxbEE=;
        b=bxgXo1Vt7iiScsF5zpckDM2KHhswSXH/p7qLke2bwpSovflZEkouHO5ZHlAH5pL6R0Rq1c
        8vYZnLlXUxkBkYBA==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuset: Don't use the cpu_possible_mask as a last
 resort for cgroup v1
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-3-will@kernel.org>
References: <20210730112443.23245-3-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078514.25758.11684144899839075412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d4b96fb92ae7fe7533e11e662504d96161928575
Gitweb:        https://git.kernel.org/tip/d4b96fb92ae7fe7533e11e662504d96161928575
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:58 +02:00

cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1

If the scheduler cannot find an allowed CPU for a task,
cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
if cgroup v1 is in use.

In preparation for allowing architectures to provide their own fallback
mask, just return early if we're either using cgroup v1 or we're using
cgroup v2 with a mask that contains invalid CPUs. This will allow
select_fallback_rq() to figure out the mask by itself.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Link: https://lkml.kernel.org/r/20210730112443.23245-3-will@kernel.org
---
 include/linux/cpuset.h | 1 +
 kernel/cgroup/cpuset.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 04c20de..ed6ec67 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -15,6 +15,7 @@
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
 #include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/jump_label.h>
 
 #ifdef CONFIG_CPUSETS
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190..a869378 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3322,9 +3322,13 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
+	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+	const struct cpumask *cs_mask;
+
 	rcu_read_lock();
-	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
-		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
+	cs_mask = task_cs(tsk)->cpus_allowed;
+	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
+		do_set_cpus_allowed(tsk, cs_mask);
 	rcu_read_unlock();
 
 	/*
