Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9679A2BAA43
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgKTMeJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgKTMeJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:09 -0500
Date:   Fri, 20 Nov 2020 12:34:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSrLCr9AMfJGLoukMuw9saYmT8or4nMuM0vgPIah/bo=;
        b=hltIXg9jCHaUwc7Pt6XekWB4mnjLLi+e0PT+kttTVjIg3PoWChNmk9SMQceiJvk2U6sKWk
        kPFW4I7DSrhmnuCRGrN/z0TWkn1A1/xfOvbgsEXGJBJRLwnPLNQi0d6DcG+nHX/sx1G4tD
        C+7s3RzesBjk3Qk7jEiIU/QAZPGxGQpANmG6SupLtWH9qStISMObO6d+3Sfa0rUHgCkKP/
        dkdSvX6m85bEo/1iUObYMb4WIR85TjENm3hB7ZuxJtgFtV5de76Z+z7zyaUlxuwFYAQqpZ
        SbFFc7OyptYt/7FHzvmSTBtoo5/5hrbv6197cSCvn4oHODK5qY7d9CM8LwjR2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSrLCr9AMfJGLoukMuw9saYmT8or4nMuM0vgPIah/bo=;
        b=3Jxg9rPzYbIH2fqipaK3Z5E7OeQdwJx8oQ6qjPKQRBrJn1uo6DzpxzkJiOZPiY3yTK8P7C
        VFVlAHfMN21JTvCQ==
From:   "tip-bot2 for Ionela Voinescu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology,schedutil: Wrap sched domains rebuild
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201027180713.7642-2-ionela.voinescu@arm.com>
References: <20201027180713.7642-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Message-ID: <160587564561.11244.17522096998314139913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     31f6a8c0a471be7d7d05c93eac50fcb729e79b9d
Gitweb:        https://git.kernel.org/tip/31f6a8c0a471be7d7d05c93eac50fcb729e79b9d
Author:        Ionela Voinescu <ionela.voinescu@arm.com>
AuthorDate:    Tue, 27 Oct 2020 18:07:11 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:47 +01:00

sched/topology,schedutil: Wrap sched domains rebuild

Add the rebuild_sched_domains_energy() function to wrap the functionality
that rebuilds the scheduling domains if any of the Energy Aware Scheduling
(EAS) initialisation conditions change. This functionality is used when
schedutil is added or removed or when EAS is enabled or disabled
through the sched_energy_aware sysctl.

Therefore, create a single function that is used in both these cases and
that can be later reused.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Quentin Perret <qperret@google.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20201027180713.7642-2-ionela.voinescu@arm.com
---
 include/linux/sched/topology.h   |  8 ++++++++
 kernel/sched/cpufreq_schedutil.c |  9 +--------
 kernel/sched/topology.c          | 18 +++++++++++-------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 9ef7bf6..8f0f778 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 
 #endif	/* !CONFIG_SMP */
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+extern void rebuild_sched_domains_energy(void);
+#else
+static inline void rebuild_sched_domains_energy(void)
+{
+}
+#endif
+
 #ifndef arch_scale_cpu_capacity
 /**
  * arch_scale_cpu_capacity - get the capacity scale factor of a given CPU.
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e254745..37b3038 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -899,16 +899,9 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 cpufreq_governor_init(schedutil_gov);
 
 #ifdef CONFIG_ENERGY_MODEL
-extern bool sched_energy_update;
-extern struct mutex sched_energy_mutex;
-
 static void rebuild_sd_workfn(struct work_struct *work)
 {
-	mutex_lock(&sched_energy_mutex);
-	sched_energy_update = true;
-	rebuild_sched_domains();
-	sched_energy_update = false;
-	mutex_unlock(&sched_energy_mutex);
+	rebuild_sched_domains_energy();
 }
 static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b296c1c..04d9ebf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -211,6 +211,15 @@ unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
 
+void rebuild_sched_domains_energy(void)
+{
+	mutex_lock(&sched_energy_mutex);
+	sched_energy_update = true;
+	rebuild_sched_domains();
+	sched_energy_update = false;
+	mutex_unlock(&sched_energy_mutex);
+}
+
 #ifdef CONFIG_PROC_SYSCTL
 int sched_energy_aware_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
@@ -223,13 +232,8 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
-		if (state != sysctl_sched_energy_aware) {
-			mutex_lock(&sched_energy_mutex);
-			sched_energy_update = 1;
-			rebuild_sched_domains();
-			sched_energy_update = 0;
-			mutex_unlock(&sched_energy_mutex);
-		}
+		if (state != sysctl_sched_energy_aware)
+			rebuild_sched_domains_energy();
 	}
 
 	return ret;
