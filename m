Return-Path: <linux-tip-commits+bounces-4261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B068CA64A76
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FF03BB0ED
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE7823E346;
	Mon, 17 Mar 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JDhVUsR9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cY5Ht27t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFE23C8D6;
	Mon, 17 Mar 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207687; cv=none; b=iLjxClqcF6RHCUhHao7+ADDkay9R0riOwE4ljUIuDo5eWz0NYogL0l2I7+1hPRjPhJIVJT2EX588e1sZrAT4ztGhDkQF2qyMtggNANGBDGAdyiz5313pMeSvirq8NppUYkzu7BHRB9w08be7CtuChb/pEoQ6xSUTuZgAWw7/w64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207687; c=relaxed/simple;
	bh=uXWUUTM706e3ajKe7fvbZ8pvS9rdyL9aPM2IEP7XaVU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=risDL7tRgauzGGUR5vhtL3DwPh2B71jSBi1FScFi2VHztwvqIrNrWisckDCsMTnVS30XgR6WOUHC4+5xt2Yjv6BqZSoxiJewbTyQcpoNcFS7pBkftHyhmtkI7A9jzafMjzeUkAxsEFWqXKw0k4sh96sSlgle5Y7j9RwwQGuIrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JDhVUsR9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cY5Ht27t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxsMyV6fCVpn5fkWFnPfIzFifyEBhrEt/FNt/hsNzII=;
	b=JDhVUsR9ZO2TiBnDFpy1kFT2TA5ZtUcz8C51vgcdOQcJQ3ATnMIm05oc17DYVP7r4WJKxM
	lSbA3raT3DEWdVfY8eNaGAo4fmwTOTJajLnusEeNnmDHvEpfmu1v/WX1fhvvdATD3OX54B
	0SkVrLLt8vaPM4f6+hx6Hn6hmSfhDK7/+IVOXeKEWliYtZdLkDX/HGJafOu0syq3NshaDH
	T/t9QKYxPPsbu7lCyN7mdO7k3aOB1N6E021JH4WWNTbrkV4p8fqRLsXv1NtGkHN5iMwP9G
	Exe1TcaSJdayyFn04CEihD01Mys+jzapjihU/hvaxvQfaIBtL5meJAGxNGqQGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxsMyV6fCVpn5fkWFnPfIzFifyEBhrEt/FNt/hsNzII=;
	b=cY5Ht27tlIAdPXBlmvCKmMit5BRlYgnVTDz/8gk6bU86A8zVvx+qEb+qX6tkPUZEHRNkqm
	1KFcezdVotQqooBQ==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Wrappers for sched_domains_mutex
Cc: Jon Hunter <jonathanh@nvidia.com>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Z9MP5Oq9RB8jBs3y@jlelli-thinkpadt14gen4.remote.csb>
References: <Z9MP5Oq9RB8jBs3y@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768237.14745.3767646575838342558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     56209334dda1832c0a919e1d74768c6d0f3b2ca9
Gitweb:        https://git.kernel.org/tip/56209334dda1832c0a919e1d74768c6d0f3b2ca9
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 13 Mar 2025 18:03:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:41 +01:00

sched/topology: Wrappers for sched_domains_mutex

Create wrappers for sched_domains_mutex so that it can transparently be
used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
do.

Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/Z9MP5Oq9RB8jBs3y@jlelli-thinkpadt14gen4.remote.csb
---
 include/linux/sched.h   |  5 +++++
 kernel/cgroup/cpuset.c  |  4 ++--
 kernel/sched/core.c     |  4 ++--
 kernel/sched/debug.c    |  8 ++++----
 kernel/sched/topology.c | 12 ++++++++++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e33..0785268 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -382,6 +382,11 @@ enum uclamp_id {
 #ifdef CONFIG_SMP
 extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
+extern void sched_domains_mutex_lock(void);
+extern void sched_domains_mutex_unlock(void);
+#else
+static inline void sched_domains_mutex_lock(void) { }
+static inline void sched_domains_mutex_unlock(void) { }
 #endif
 
 struct sched_param {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c8..f87526e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -994,10 +994,10 @@ static void
 partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	dl_rebuild_rd_accounting();
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c734724..84f6800 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8470,9 +8470,9 @@ void __init sched_init_smp(void)
 	 * CPU masks are stable and all blatant races in the below code cannot
 	 * happen.
 	 */
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	sched_init_domains(cpu_active_mask);
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 39be739..56ae54e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -294,7 +294,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 	bool orig;
 
 	cpus_read_lock();
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 
 	orig = sched_debug_verbose;
 	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
@@ -306,7 +306,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 		sd_dentry = NULL;
 	}
 
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 	cpus_read_unlock();
 
 	return result;
@@ -517,9 +517,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
 
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	update_sched_domain_debugfs();
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8..296ff2a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -6,6 +6,14 @@
 #include <linux/bsearch.h>
 
 DEFINE_MUTEX(sched_domains_mutex);
+void sched_domains_mutex_lock(void)
+{
+	mutex_lock(&sched_domains_mutex);
+}
+void sched_domains_mutex_unlock(void)
+{
+	mutex_unlock(&sched_domains_mutex);
+}
 
 /* Protected by sched_domains_mutex: */
 static cpumask_var_t sched_domains_tmpmask;
@@ -2791,7 +2799,7 @@ match3:
 void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			     struct sched_domain_attr *dattr_new)
 {
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 }

