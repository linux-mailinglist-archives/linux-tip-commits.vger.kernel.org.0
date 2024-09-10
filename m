Return-Path: <linux-tip-commits+bounces-2286-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73654973047
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21AC1F225E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425518C34B;
	Tue, 10 Sep 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvm2zOGe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4vKGF6Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BE18595E;
	Tue, 10 Sep 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962347; cv=none; b=mO/WWQAKm/uvJiq0FvL6CPSBBOz0DMOJLwDx4MtM3lBCiR+pSWRyTyvp/E2Q3db0qZS/777LpIVunKDZY2+jMImNPrLw1hWqrqQggYtKTQasqkUX2aCsQSn6ev7ZrKys9OJM85+7oRQ9mDxQcedl+xLVBhinL9I2ZJKzhLo456E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962347; c=relaxed/simple;
	bh=35EMhPmtveDj8Tgl98XcRr7TEmIcJ1TY7zTtAE4RWGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RU/nNR+brNHdj6nansSnpAyP9U0Ro6EocqoNzGwxU0kO9cSxzeZbOAdY4+bVccuO2U+s6MSGoiK6l3+8Qslvk4ampYr6yTjuln+hnNy2VD5LUd5fgqQyepHaPj0nU1gtWhcBm94iO0IfreyNjOtDnT1PS5Wf+J8/eFhpI3mgGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvm2zOGe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e4vKGF6Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 09:59:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725962343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fC0NchatosrqdZKXCeymr9bAivAKRBb3+CFI5rNEqHs=;
	b=yvm2zOGeJoLEdm+eYCpOwOC217oWYVTImqPKN5Sbmlv09bv021QCyDeEpb0fPBnKnuxZtC
	aoxo6O8CNqVP770ScjD5fOR5/9iFbTUvmk1B5cPLEwjJDgsG+pq3tCKR/1tCgJdzhEZlMw
	Yb6nGUQxhFI0iTvDbDKVOJVjDewAEmqp1omniWKYSq4zIDSOVrGNpOtH3nN4FuWZ+XPjpT
	SX0+whUh1f/jDt/y7Pm13eg1LdnFyTjMdFTQ9XmeNgrMyQGPI84Fd4tx5rBDeFtEuN7u/J
	gQzaARs6HBdLW20o/Vqw2ocqPz3yIBHVjFboWVFgdYe8Teuz5nHc/Fb9vIPqpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725962343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fC0NchatosrqdZKXCeymr9bAivAKRBb3+CFI5rNEqHs=;
	b=e4vKGF6Y3kOAyjRmnc4fSynwX2oRBJByxIT5PgIR3a17ghN9ZB2OQMLuiD/pty1t4akyyz
	l7pwUxFBJfvuKcBg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] dmaengine: idxd: Clean up cpumask and hotplug for perfmon
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240802151643.1691631-6-kan.liang@linux.intel.com>
References: <20240802151643.1691631-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596234295.2215.4444524175653355124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bbdd4df35c31fe502c1c70e4d3a8e3ebe5a270b7
Gitweb:        https://git.kernel.org/tip/bbdd4df35c31fe502c1c70e4d3a8e3ebe5a270b7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 02 Aug 2024 08:16:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 11:44:13 +02:00

dmaengine: idxd: Clean up cpumask and hotplug for perfmon

The idxd PMU is system-wide scope, which is supported by the generic
perf_event subsystem now.

Set the scope for the idxd PMU and remove all the cpumask and hotplug
codes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lore.kernel.org/r/20240802151643.1691631-6-kan.liang@linux.intel.com
---
 drivers/dma/idxd/idxd.h    |  7 +---
 drivers/dma/idxd/init.c    |  3 +-
 drivers/dma/idxd/perfmon.c | 98 +-------------------------------------
 3 files changed, 1 insertion(+), 107 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 868b724..d84e21d 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -124,7 +124,6 @@ struct idxd_pmu {
 
 	struct pmu pmu;
 	char name[IDXD_NAME_SIZE];
-	int cpu;
 
 	int n_counters;
 	int counter_width;
@@ -135,8 +134,6 @@ struct idxd_pmu {
 
 	unsigned long supported_filters;
 	int n_filters;
-
-	struct hlist_node cpuhp_node;
 };
 
 #define IDXD_MAX_PRIORITY	0xf
@@ -803,14 +800,10 @@ void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index);
 int perfmon_pmu_init(struct idxd_device *idxd);
 void perfmon_pmu_remove(struct idxd_device *idxd);
 void perfmon_counter_overflow(struct idxd_device *idxd);
-void perfmon_init(void);
-void perfmon_exit(void);
 #else
 static inline int perfmon_pmu_init(struct idxd_device *idxd) { return 0; }
 static inline void perfmon_pmu_remove(struct idxd_device *idxd) {}
 static inline void perfmon_counter_overflow(struct idxd_device *idxd) {}
-static inline void perfmon_init(void) {}
-static inline void perfmon_exit(void) {}
 #endif
 
 /* debugfs */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 21f6905..5725ea8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -878,8 +878,6 @@ static int __init idxd_init_module(void)
 	else
 		support_enqcmd = true;
 
-	perfmon_init();
-
 	err = idxd_driver_register(&idxd_drv);
 	if (err < 0)
 		goto err_idxd_driver_register;
@@ -928,7 +926,6 @@ static void __exit idxd_exit_module(void)
 	idxd_driver_unregister(&idxd_drv);
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
-	perfmon_exit();
 	idxd_remove_debugfs();
 }
 module_exit(idxd_exit_module);
diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index 5e94247..f511cf1 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -6,29 +6,6 @@
 #include "idxd.h"
 #include "perfmon.h"
 
-static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
-			    char *buf);
-
-static cpumask_t		perfmon_dsa_cpu_mask;
-static bool			cpuhp_set_up;
-static enum cpuhp_state		cpuhp_slot;
-
-/*
- * perf userspace reads this attribute to determine which cpus to open
- * counters on.  It's connected to perfmon_dsa_cpu_mask, which is
- * maintained by the cpu hotplug handlers.
- */
-static DEVICE_ATTR_RO(cpumask);
-
-static struct attribute *perfmon_cpumask_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL,
-};
-
-static struct attribute_group cpumask_attr_group = {
-	.attrs = perfmon_cpumask_attrs,
-};
-
 /*
  * These attributes specify the bits in the config word that the perf
  * syscall uses to pass the event ids and categories to perfmon.
@@ -67,16 +44,9 @@ static struct attribute_group perfmon_format_attr_group = {
 
 static const struct attribute_group *perfmon_attr_groups[] = {
 	&perfmon_format_attr_group,
-	&cpumask_attr_group,
 	NULL,
 };
 
-static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	return cpumap_print_to_pagebuf(true, buf, &perfmon_dsa_cpu_mask);
-}
-
 static bool is_idxd_event(struct idxd_pmu *idxd_pmu, struct perf_event *event)
 {
 	return &idxd_pmu->pmu == event->pmu;
@@ -217,7 +187,6 @@ static int perfmon_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	event->hw.event_base = ioread64(PERFMON_TABLE_OFFSET(idxd));
-	event->cpu = idxd->idxd_pmu->cpu;
 	event->hw.config = event->attr.config;
 
 	if (event->group_leader != event)
@@ -488,6 +457,7 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
 	idxd_pmu->pmu.stop		= perfmon_pmu_event_stop;
 	idxd_pmu->pmu.read		= perfmon_pmu_event_update;
 	idxd_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+	idxd_pmu->pmu.scope		= PERF_PMU_SCOPE_SYS_WIDE;
 	idxd_pmu->pmu.module		= THIS_MODULE;
 }
 
@@ -496,47 +466,11 @@ void perfmon_pmu_remove(struct idxd_device *idxd)
 	if (!idxd->idxd_pmu)
 		return;
 
-	cpuhp_state_remove_instance(cpuhp_slot, &idxd->idxd_pmu->cpuhp_node);
 	perf_pmu_unregister(&idxd->idxd_pmu->pmu);
 	kfree(idxd->idxd_pmu);
 	idxd->idxd_pmu = NULL;
 }
 
-static int perf_event_cpu_online(unsigned int cpu, struct hlist_node *node)
-{
-	struct idxd_pmu *idxd_pmu;
-
-	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
-
-	/* select the first online CPU as the designated reader */
-	if (cpumask_empty(&perfmon_dsa_cpu_mask)) {
-		cpumask_set_cpu(cpu, &perfmon_dsa_cpu_mask);
-		idxd_pmu->cpu = cpu;
-	}
-
-	return 0;
-}
-
-static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
-{
-	struct idxd_pmu *idxd_pmu;
-	unsigned int target;
-
-	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
-
-	if (!cpumask_test_and_clear_cpu(cpu, &perfmon_dsa_cpu_mask))
-		return 0;
-
-	target = cpumask_any_but(cpu_online_mask, cpu);
-	/* migrate events if there is a valid target */
-	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &perfmon_dsa_cpu_mask);
-		perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
-	}
-
-	return 0;
-}
-
 int perfmon_pmu_init(struct idxd_device *idxd)
 {
 	union idxd_perfcap perfcap;
@@ -544,12 +478,6 @@ int perfmon_pmu_init(struct idxd_device *idxd)
 	int rc = -ENODEV;
 
 	/*
-	 * perfmon module initialization failed, nothing to do
-	 */
-	if (!cpuhp_set_up)
-		return -ENODEV;
-
-	/*
 	 * If perfmon_offset or num_counters is 0, it means perfmon is
 	 * not supported on this hardware.
 	 */
@@ -624,11 +552,6 @@ int perfmon_pmu_init(struct idxd_device *idxd)
 	if (rc)
 		goto free;
 
-	rc = cpuhp_state_add_instance(cpuhp_slot, &idxd_pmu->cpuhp_node);
-	if (rc) {
-		perf_pmu_unregister(&idxd->idxd_pmu->pmu);
-		goto free;
-	}
 out:
 	return rc;
 free:
@@ -637,22 +560,3 @@ free:
 
 	goto out;
 }
-
-void __init perfmon_init(void)
-{
-	int rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
-					 "driver/dma/idxd/perf:online",
-					 perf_event_cpu_online,
-					 perf_event_cpu_offline);
-	if (WARN_ON(rc < 0))
-		return;
-
-	cpuhp_slot = rc;
-	cpuhp_set_up = true;
-}
-
-void __exit perfmon_exit(void)
-{
-	if (cpuhp_set_up)
-		cpuhp_remove_multi_state(cpuhp_slot);
-}

