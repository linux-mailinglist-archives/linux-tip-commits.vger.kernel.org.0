Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A37352736
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Apr 2021 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhDBIMo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Apr 2021 04:12:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhDBIMn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 2 Apr 2021 04:12:43 -0400
Date:   Fri, 02 Apr 2021 08:12:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617351162;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aM6og7Uxg/fq4kQkLh1J/UDZWkBhkY7YPZ/aLREyDlg=;
        b=D5Ru7u9awAUbGYrPjPPGFYFEn7bzk9YDqbi6px+SPPs7rWNMQh8wRpUfIk/Nnoo6U+nTlo
        +SPsIX7m/uFIie2gcmaRruKPVKdagsL5UlcxOrowzB3wZ909DDRFnLA0EMR4mYgk4jeyDZ
        jBrsw2YRQKh93Ol4TvyV38GhQSN7Gk1EpmOF7B3/TxJ0ByFJpPrf7bYRuioXCGXPS3Zl/J
        KQ37i8pVKOhC9OT9sobBsjkkmBGA6VZeIjlQlz0ZJfWs1VUOEskflYigf784qcNq4h5rAL
        he2g4Zw6s89h7ml8vp6knC2iNGhzq0WjxsQJANITIAk8PbmBf3bjoUkAllE1Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617351162;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aM6og7Uxg/fq4kQkLh1J/UDZWkBhkY7YPZ/aLREyDlg=;
        b=81jX4ppp3ArSoxCJ7rxUULOb7LhxE2zENTQhUfzct232cTit1CT2VQ7GAm28wWpogEWEVW
        C2rOH97FUt/IiIAg==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Enable IIO stacks to PMON
 mapping for multi-segment SKX
Cc:     kernel test robot <lkp@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kyle Meyer <kyle.meyer@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323150507.2013-1-alexander.antonov@linux.intel.com>
References: <20210323150507.2013-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161735116142.29796.1908093361658869591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cface0326a6c2ae5c8f47bd466f07624b3e348a7
Gitweb:        https://git.kernel.org/tip/cface0326a6c2ae5c8f47bd466f07624b3e348a7
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Tue, 23 Mar 2021 18:05:07 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Apr 2021 10:04:55 +02:00

perf/x86/intel/uncore: Enable IIO stacks to PMON mapping for multi-segment SKX

IIO stacks to PMON mapping on Skylake servers is exposed through introduced
early attributes /sys/devices/uncore_iio_<pmu_idx>/dieX, where dieX is a
file which holds "Segment:Root Bus" for PCIe root port which can
be monitored by that IIO PMON block. These sysfs attributes are disabled
for multiple segment topologies except VMD domains which start at 0x10000.
This patch removes the limitation and enables IIO stacks to PMON mapping
for multi-segment Skylake servers by introducing segment-aware
intel_uncore_topology structure and attributing the topology configuration
to the segment in skx_iio_get_topology() function.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Link: https://lkml.kernel.org/r/20210323150507.2013-1-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore.c       | 12 +++++-
 arch/x86/events/intel/uncore.h       |  9 +++-
 arch/x86/events/intel/uncore_snbep.c | 60 ++++++++++++---------------
 3 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 35b3470..a2b68bb 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -53,6 +53,18 @@ int uncore_pcibus_to_dieid(struct pci_bus *bus)
 	return die_id;
 }
 
+int uncore_die_to_segment(int die)
+{
+	struct pci_bus *bus = NULL;
+
+	/* Find first pci bus which attributes to specified die. */
+	while ((bus = pci_find_next_bus(bus)) &&
+	       (die != uncore_pcibus_to_dieid(bus)))
+		;
+
+	return bus ? pci_domain_nr(bus) : -EINVAL;
+}
+
 static void uncore_free_pcibus_map(void)
 {
 	struct pci2phy_map *map, *tmp;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 549cfb2..96569dc 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -42,6 +42,7 @@ struct intel_uncore_pmu;
 struct intel_uncore_box;
 struct uncore_event_desc;
 struct freerunning_counters;
+struct intel_uncore_topology;
 
 struct intel_uncore_type {
 	const char *name;
@@ -87,7 +88,7 @@ struct intel_uncore_type {
 	 * to identify which platform component each PMON block of that type is
 	 * supposed to monitor.
 	 */
-	u64 *topology;
+	struct intel_uncore_topology *topology;
 	/*
 	 * Optional callbacks for managing mapping of Uncore units to PMONs
 	 */
@@ -176,6 +177,11 @@ struct freerunning_counters {
 	unsigned *box_offsets;
 };
 
+struct intel_uncore_topology {
+	u64 configuration;
+	int segment;
+};
+
 struct pci2phy_map {
 	struct list_head list;
 	int segment;
@@ -184,6 +190,7 @@ struct pci2phy_map {
 
 struct pci2phy_map *__find_pci2phy_map(int segment);
 int uncore_pcibus_to_dieid(struct pci_bus *bus);
+int uncore_die_to_segment(int die);
 
 ssize_t uncore_event_show(struct device *dev,
 			  struct device_attribute *attr, char *buf);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b79951d..acc3c0e 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3684,7 +3684,8 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
 
 static inline u8 skx_iio_stack(struct intel_uncore_pmu *pmu, int die)
 {
-	return pmu->type->topology[die] >> (pmu->pmu_idx * BUS_NUM_STRIDE);
+	return pmu->type->topology[die].configuration >>
+	       (pmu->pmu_idx * BUS_NUM_STRIDE);
 }
 
 static umode_t
@@ -3697,19 +3698,14 @@ skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
 }
 
 static ssize_t skx_iio_mapping_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
-	struct pci_bus *bus = pci_find_next_bus(NULL);
-	struct intel_uncore_pmu *uncore_pmu = dev_to_uncore_pmu(dev);
+	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
 	struct dev_ext_attribute *ea = to_dev_ext_attribute(attr);
 	long die = (long)ea->var;
 
-	/*
-	 * Current implementation is for single segment configuration hence it's
-	 * safe to take the segment value from the first available root bus.
-	 */
-	return sprintf(buf, "%04x:%02x\n", pci_domain_nr(bus),
-					   skx_iio_stack(uncore_pmu, die));
+	return sprintf(buf, "%04x:%02x\n", pmu->type->topology[die].segment,
+					   skx_iio_stack(pmu, die));
 }
 
 static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
@@ -3746,34 +3742,32 @@ static int die_to_cpu(int die)
 
 static int skx_iio_get_topology(struct intel_uncore_type *type)
 {
-	int i, ret;
-	struct pci_bus *bus = NULL;
-
-	/*
-	 * Verified single-segment environments only; disabled for multiple
-	 * segment topologies for now except VMD domains.
-	 * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
-	 */
-	while ((bus = pci_find_next_bus(bus))
-		&& (!pci_domain_nr(bus) || pci_domain_nr(bus) > 0xffff))
-		;
-	if (bus)
-		return -EPERM;
+	int die, ret = -EPERM;
 
-	type->topology = kcalloc(uncore_max_dies(), sizeof(u64), GFP_KERNEL);
+	type->topology = kcalloc(uncore_max_dies(), sizeof(*type->topology),
+				 GFP_KERNEL);
 	if (!type->topology)
 		return -ENOMEM;
 
-	for (i = 0; i < uncore_max_dies(); i++) {
-		ret = skx_msr_cpu_bus_read(die_to_cpu(i), &type->topology[i]);
-		if (ret) {
-			kfree(type->topology);
-			type->topology = NULL;
-			return ret;
-		}
+	for (die = 0; die < uncore_max_dies(); die++) {
+		ret = skx_msr_cpu_bus_read(die_to_cpu(die),
+					   &type->topology[die].configuration);
+		if (ret)
+			break;
+
+		ret = uncore_die_to_segment(die);
+		if (ret < 0)
+			break;
+
+		type->topology[die].segment = ret;
 	}
 
-	return 0;
+	if (ret < 0) {
+		kfree(type->topology);
+		type->topology = NULL;
+	}
+
+	return ret;
 }
 
 static struct attribute_group skx_iio_mapping_group = {
@@ -3794,7 +3788,7 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	struct dev_ext_attribute *eas = NULL;
 
 	ret = skx_iio_get_topology(type);
-	if (ret)
+	if (ret < 0)
 		goto clear_attr_update;
 
 	ret = -ENOMEM;
