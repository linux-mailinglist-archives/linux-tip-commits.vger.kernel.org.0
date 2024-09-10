Return-Path: <linux-tip-commits+bounces-2287-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B84973049
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 11:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A5E1C24281
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AEF18D63B;
	Tue, 10 Sep 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yj9Os7nZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HUmtc4Yr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCC17C22F;
	Tue, 10 Sep 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962347; cv=none; b=l+pVSTMpAPhRCW9oR5C5dB5jjMMt1al0vm9iv6nYoF4z6+4nZGW81uqyPEnDTsZM5wrgNkyb1hza0fkv37zmRIz81X41NHVyQgvNGOX5P5wJklqHZduqyrd9VdwJHLqNG7EZQ+IZlSK+PE69tBIKbp5ybQRA+s5+gyqIWAGsVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962347; c=relaxed/simple;
	bh=kAdJDtz9hbwZPp13FWlLOOqhZAHeTqyPBQkROLeDJ60=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nZaIqa1TgfNFopU6hmD9nPOHoANKGXsw21v/+3OmMe1sW7yn7lFxlZbJfEElZeqZEN/2XR+8ffJZ/IAGTTFsjjzf9mUZu++SIRIaK7KmJZh3gHE9fTYRK5aEA4iJ9ml1e6PktIspQjSaZluE0NBAAK/e0Q5fRs0Rn7fu7nRltrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yj9Os7nZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HUmtc4Yr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 09:59:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725962343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkIrqcn0UDLrQzHvU4Y2/JzwNSMK8Cvc5EbW5aqcXVc=;
	b=yj9Os7nZyIAp1ZhEcR8KiIBsg8aJZIc212j2AXtvJ+3dPW0UZ8eSBBKRCnj8beI2cEcw9c
	ohM+eCpqJwfW4r2vq66lOBoshzf677KiGo2AfW7lA9D0IiFfiyXejpZif0w3lhZv3lfrAi
	dXxMa3eoJBijV8z8Pd7Ws6UlO/5jNvVbDEuSEwjfk+97/sfdMYiX+6dGpWggwj9vlEq67y
	hgP90DRm77JzyFK8notkn4YTubdSF0iQJrjTGR5ImLs5hfKF9hGB2oF4YuRlfZwqnWKb/k
	YgDfeGOZodEWoHO5xdXWCNfTyDg0iPhp02d0WuuZXZUQUZr0IEfLpL7d3p1QPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725962343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkIrqcn0UDLrQzHvU4Y2/JzwNSMK8Cvc5EbW5aqcXVc=;
	b=HUmtc4YrB21BZ0QSBqhwdjMARQRLk/JbBtw2x27lMWtt1FGHKOvAQSvkn8JOt5mLw4tai4
	tYdNkVV8JGJlm9Bw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] iommu/vt-d: Clean up cpumask and hotplug for perfmon
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802151643.1691631-5-kan.liang@linux.intel.com>
References: <20240802151643.1691631-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596234350.2215.17086032772842846168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a8c73b82f7792400555143773d0152d5bc3ac068
Gitweb:        https://git.kernel.org/tip/a8c73b82f7792400555143773d0152d5bc3ac068
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 02 Aug 2024 08:16:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 11:44:13 +02:00

iommu/vt-d: Clean up cpumask and hotplug for perfmon

The iommu PMU is system-wide scope, which is supported by the generic
perf_event subsystem now.

Set the scope for the iommu PMU and remove all the cpumask and hotplug
codes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20240802151643.1691631-5-kan.liang@linux.intel.com
---
 drivers/iommu/intel/iommu.h   |   2 +-
 drivers/iommu/intel/perfmon.c | 111 +---------------------------------
 2 files changed, 2 insertions(+), 111 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14d..bd2c5a4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -687,8 +687,6 @@ struct iommu_pmu {
 	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
 	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
 	unsigned char		irq_name[16];
-	struct hlist_node	cpuhp_node;
-	int			cpu;
 };
 
 #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 44083d0..75f493b 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -34,28 +34,9 @@ static struct attribute_group iommu_pmu_events_attr_group = {
 	.attrs = attrs_empty,
 };
 
-static cpumask_t iommu_pmu_cpu_mask;
-
-static ssize_t
-cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return cpumap_print_to_pagebuf(true, buf, &iommu_pmu_cpu_mask);
-}
-static DEVICE_ATTR_RO(cpumask);
-
-static struct attribute *iommu_pmu_cpumask_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL
-};
-
-static struct attribute_group iommu_pmu_cpumask_attr_group = {
-	.attrs = iommu_pmu_cpumask_attrs,
-};
-
 static const struct attribute_group *iommu_pmu_attr_groups[] = {
 	&iommu_pmu_format_attr_group,
 	&iommu_pmu_events_attr_group,
-	&iommu_pmu_cpumask_attr_group,
 	NULL
 };
 
@@ -565,6 +546,7 @@ static int __iommu_pmu_register(struct intel_iommu *iommu)
 	iommu_pmu->pmu.attr_groups	= iommu_pmu_attr_groups;
 	iommu_pmu->pmu.attr_update	= iommu_pmu_attr_update;
 	iommu_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+	iommu_pmu->pmu.scope		= PERF_PMU_SCOPE_SYS_WIDE;
 	iommu_pmu->pmu.module		= THIS_MODULE;
 
 	return perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
@@ -773,89 +755,6 @@ static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
 	iommu->perf_irq = 0;
 }
 
-static int iommu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
-{
-	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
-
-	if (cpumask_empty(&iommu_pmu_cpu_mask))
-		cpumask_set_cpu(cpu, &iommu_pmu_cpu_mask);
-
-	if (cpumask_test_cpu(cpu, &iommu_pmu_cpu_mask))
-		iommu_pmu->cpu = cpu;
-
-	return 0;
-}
-
-static int iommu_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
-{
-	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
-	int target = cpumask_first(&iommu_pmu_cpu_mask);
-
-	/*
-	 * The iommu_pmu_cpu_mask has been updated when offline the CPU
-	 * for the first iommu_pmu. Migrate the other iommu_pmu to the
-	 * new target.
-	 */
-	if (target < nr_cpu_ids && target != iommu_pmu->cpu) {
-		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
-		iommu_pmu->cpu = target;
-		return 0;
-	}
-
-	if (!cpumask_test_and_clear_cpu(cpu, &iommu_pmu_cpu_mask))
-		return 0;
-
-	target = cpumask_any_but(cpu_online_mask, cpu);
-
-	if (target < nr_cpu_ids)
-		cpumask_set_cpu(target, &iommu_pmu_cpu_mask);
-	else
-		return 0;
-
-	perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
-	iommu_pmu->cpu = target;
-
-	return 0;
-}
-
-static int nr_iommu_pmu;
-static enum cpuhp_state iommu_cpuhp_slot;
-
-static int iommu_pmu_cpuhp_setup(struct iommu_pmu *iommu_pmu)
-{
-	int ret;
-
-	if (!nr_iommu_pmu) {
-		ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
-					      "driver/iommu/intel/perfmon:online",
-					      iommu_pmu_cpu_online,
-					      iommu_pmu_cpu_offline);
-		if (ret < 0)
-			return ret;
-		iommu_cpuhp_slot = ret;
-	}
-
-	ret = cpuhp_state_add_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
-	if (ret) {
-		if (!nr_iommu_pmu)
-			cpuhp_remove_multi_state(iommu_cpuhp_slot);
-		return ret;
-	}
-	nr_iommu_pmu++;
-
-	return 0;
-}
-
-static void iommu_pmu_cpuhp_free(struct iommu_pmu *iommu_pmu)
-{
-	cpuhp_state_remove_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
-
-	if (--nr_iommu_pmu)
-		return;
-
-	cpuhp_remove_multi_state(iommu_cpuhp_slot);
-}
-
 void iommu_pmu_register(struct intel_iommu *iommu)
 {
 	struct iommu_pmu *iommu_pmu = iommu->pmu;
@@ -866,17 +765,12 @@ void iommu_pmu_register(struct intel_iommu *iommu)
 	if (__iommu_pmu_register(iommu))
 		goto err;
 
-	if (iommu_pmu_cpuhp_setup(iommu_pmu))
-		goto unregister;
-
 	/* Set interrupt for overflow */
 	if (iommu_pmu_set_interrupt(iommu))
-		goto cpuhp_free;
+		goto unregister;
 
 	return;
 
-cpuhp_free:
-	iommu_pmu_cpuhp_free(iommu_pmu);
 unregister:
 	perf_pmu_unregister(&iommu_pmu->pmu);
 err:
@@ -892,6 +786,5 @@ void iommu_pmu_unregister(struct intel_iommu *iommu)
 		return;
 
 	iommu_pmu_unset_interrupt(iommu);
-	iommu_pmu_cpuhp_free(iommu_pmu);
 	perf_pmu_unregister(&iommu_pmu->pmu);
 }

