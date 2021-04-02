Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846C535273D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Apr 2021 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhDBIMy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Apr 2021 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhDBIMw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 2 Apr 2021 04:12:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154DC0613E6;
        Fri,  2 Apr 2021 01:12:51 -0700 (PDT)
Date:   Fri, 02 Apr 2021 08:12:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617351162;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ejWvL1ctm4OYhlZ/iglRHi+AK7S9AJw+Jaw1EmX4Co=;
        b=QJrGVxzNIEaPCgEq6WRPhssk4XAc+uU6WKMmhHlQe5RLf6mlNs7FLWfN0PgqVaQRIBcf9s
        5xkI3ze7vNoWpCZFmXhN25hvfEiM1EJDwOnwJIO3vb+ReOR6TiG+alB3O6lItejRiqIlQM
        pu4+vnIZEwOpK2RYyeOV1fiVDV9CBSsK+rzQkigxxj/W9K9ubjNPgjITnOHQW7LzyEfHYg
        u+uToicUpqfW1Pz3ZgDV5XeifqqmHufSjLiOK98LRMPxUJxqdvWKBOI2TQWU9ZPHxlfmJb
        h23qmTpZ9w4zUJfefHtm8T8VxEr3qjxlFcv78TBfcCtweHTFPrrVr/t80oc2iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617351162;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ejWvL1ctm4OYhlZ/iglRHi+AK7S9AJw+Jaw1EmX4Co=;
        b=us5CdWGdHJh7oxLsKBGF8GBw8EMHA1yLAW31cZylq1CaFehSoJjHKMt1UiAxAsGdjcYfho
        CDMTqeqZzMbNUrCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generic support for the PCI
 type of uncore blocks
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1616003977-90612-5-git-send-email-kan.liang@linux.intel.com>
References: <1616003977-90612-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161735116212.29796.1783405516103570573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     42839ef4a20a4bda415974ff0e7d85ff540fffa4
Gitweb:        https://git.kernel.org/tip/42839ef4a20a4bda415974ff0e7d85ff540fffa4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 17 Mar 2021 10:59:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Apr 2021 10:04:55 +02:00

perf/x86/intel/uncore: Generic support for the PCI type of uncore blocks

The discovery table provides the generic uncore block information
for the PCI type of uncore blocks, which is good enough to provide
basic uncore support.

The PCI BUS and DEVFN information can be retrieved from the box control
field. Introduce the uncore_pci_pmus_register() to register all the
PCICFG type of uncore blocks. The old PCI probe/remove way is dropped.

The PCI BUS and DEVFN information are different among dies. Add box_ctls
to store the box control field of each die.

Add a new BUS notifier for the PCI type of uncore block to support the
hotplug. If the device is "hot remove", the corresponding registered PMU
has to be unregistered. Perf cannot locate the PMU by searching a const
pci_device_id table, because the discovery tables don't provide such
information. Introduce uncore_pci_find_dev_pmu_from_types() to search
the whole uncore_pci_uncores for the PMU.

Implement generic support for the PCI type of uncore block.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1616003977-90612-5-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           | 91 +++++++++++++++++++++--
 arch/x86/events/intel/uncore.h           |  6 +-
 arch/x86/events/intel/uncore_discovery.c | 80 ++++++++++++++++++++-
 arch/x86/events/intel/uncore_discovery.h |  7 ++-
 4 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 391fa7c..3109082 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1032,10 +1032,37 @@ static int uncore_pci_get_dev_die_info(struct pci_dev *pdev, int *die)
 	return 0;
 }
 
+static struct intel_uncore_pmu *
+uncore_pci_find_dev_pmu_from_types(struct pci_dev *pdev)
+{
+	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_type *type;
+	u64 box_ctl;
+	int i, die;
+
+	for (; *types; types++) {
+		type = *types;
+		for (die = 0; die < __uncore_max_dies; die++) {
+			for (i = 0; i < type->num_boxes; i++) {
+				if (!type->box_ctls[die])
+					continue;
+				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
+				if (pdev->devfn == UNCORE_DISCOVERY_PCI_DEVFN(box_ctl) &&
+				    pdev->bus->number == UNCORE_DISCOVERY_PCI_BUS(box_ctl) &&
+				    pci_domain_nr(pdev->bus) == UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl))
+					return &type->pmus[i];
+			}
+		}
+	}
+
+	return NULL;
+}
+
 /*
  * Find the PMU of a PCI device.
  * @pdev: The PCI device.
  * @ids: The ID table of the available PCI devices with a PMU.
+ *       If NULL, search the whole uncore_pci_uncores.
  */
 static struct intel_uncore_pmu *
 uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
@@ -1045,6 +1072,9 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
 	kernel_ulong_t data;
 	unsigned int devfn;
 
+	if (!ids)
+		return uncore_pci_find_dev_pmu_from_types(pdev);
+
 	while (ids && ids->vendor) {
 		if ((ids->vendor == pdev->vendor) &&
 		    (ids->device == pdev->device)) {
@@ -1283,6 +1313,48 @@ static void uncore_pci_sub_driver_init(void)
 		uncore_pci_sub_driver = NULL;
 }
 
+static int uncore_pci_bus_notify(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	return uncore_bus_notify(nb, action, data, NULL);
+}
+
+static struct notifier_block uncore_pci_notifier = {
+	.notifier_call = uncore_pci_bus_notify,
+};
+
+
+static void uncore_pci_pmus_register(void)
+{
+	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_type *type;
+	struct intel_uncore_pmu *pmu;
+	struct pci_dev *pdev;
+	u64 box_ctl;
+	int i, die;
+
+	for (; *types; types++) {
+		type = *types;
+		for (die = 0; die < __uncore_max_dies; die++) {
+			for (i = 0; i < type->num_boxes; i++) {
+				if (!type->box_ctls[die])
+					continue;
+				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
+				pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl),
+								   UNCORE_DISCOVERY_PCI_BUS(box_ctl),
+								   UNCORE_DISCOVERY_PCI_DEVFN(box_ctl));
+				if (!pdev)
+					continue;
+				pmu = &type->pmus[i];
+
+				uncore_pci_pmu_register(pdev, type, pmu, die);
+			}
+		}
+	}
+
+	bus_register_notifier(&pci_bus_type, &uncore_pci_notifier);
+}
+
 static int __init uncore_pci_init(void)
 {
 	size_t size;
@@ -1299,12 +1371,15 @@ static int __init uncore_pci_init(void)
 	if (ret)
 		goto errtype;
 
-	uncore_pci_driver->probe = uncore_pci_probe;
-	uncore_pci_driver->remove = uncore_pci_remove;
+	if (uncore_pci_driver) {
+		uncore_pci_driver->probe = uncore_pci_probe;
+		uncore_pci_driver->remove = uncore_pci_remove;
 
-	ret = pci_register_driver(uncore_pci_driver);
-	if (ret)
-		goto errtype;
+		ret = pci_register_driver(uncore_pci_driver);
+		if (ret)
+			goto errtype;
+	} else
+		uncore_pci_pmus_register();
 
 	if (uncore_pci_sub_driver)
 		uncore_pci_sub_driver_init();
@@ -1328,7 +1403,10 @@ static void uncore_pci_exit(void)
 		pcidrv_registered = false;
 		if (uncore_pci_sub_driver)
 			bus_unregister_notifier(&pci_bus_type, &uncore_pci_sub_notifier);
-		pci_unregister_driver(uncore_pci_driver);
+		if (uncore_pci_driver)
+			pci_unregister_driver(uncore_pci_driver);
+		else
+			bus_unregister_notifier(&pci_bus_type, &uncore_pci_notifier);
 		uncore_types_exit(uncore_pci_uncores);
 		kfree(uncore_extra_pci_dev);
 		uncore_free_pcibus_map();
@@ -1676,6 +1754,7 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
+	.pci_init = intel_uncore_generic_uncore_pci_init,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 05c8e06..76fc898 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -58,6 +58,7 @@ struct intel_uncore_type {
 	unsigned fixed_ctr;
 	unsigned fixed_ctl;
 	unsigned box_ctl;
+	u64 *box_ctls;	/* Unit ctrl addr of the first box of each die */
 	union {
 		unsigned msr_offset;
 		unsigned mmio_offset;
@@ -66,7 +67,10 @@ struct intel_uncore_type {
 	unsigned num_shared_regs:8;
 	unsigned single_fixed:1;
 	unsigned pair_ctr_ctl:1;
-	unsigned *msr_offsets;
+	union {
+		unsigned *msr_offsets;
+		unsigned *pci_offsets;
+	};
 	unsigned *box_ids;
 	struct event_constraint unconstrainted;
 	struct event_constraint *constraints;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index fefb3e2..784d7b4 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -377,6 +377,71 @@ static struct intel_uncore_ops generic_uncore_msr_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
+static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	int box_ctl = uncore_pci_box_ctl(box);
+
+	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
+	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
+}
+
+static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	int box_ctl = uncore_pci_box_ctl(box);
+
+	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
+}
+
+static void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	int box_ctl = uncore_pci_box_ctl(box);
+
+	pci_write_config_dword(pdev, box_ctl, 0);
+}
+
+static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base, hwc->config);
+}
+
+static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base, 0);
+}
+
+static u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					   struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+	u64 count = 0;
+
+	pci_read_config_dword(pdev, hwc->event_base, (u32 *)&count);
+	pci_read_config_dword(pdev, hwc->event_base + 4, (u32 *)&count + 1);
+
+	return count;
+}
+
+static struct intel_uncore_ops generic_uncore_pci_ops = {
+	.init_box	= intel_generic_uncore_pci_init_box,
+	.disable_box	= intel_generic_uncore_pci_disable_box,
+	.enable_box	= intel_generic_uncore_pci_enable_box,
+	.disable_event	= intel_generic_uncore_pci_disable_event,
+	.enable_event	= intel_generic_uncore_pci_enable_event,
+	.read_counter	= intel_generic_uncore_pci_read_counter,
+};
+
 static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 				      struct intel_uncore_type *uncore,
 				      struct intel_uncore_discovery_type *type)
@@ -395,6 +460,14 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctl = (unsigned int)type->box_ctrl;
 		uncore->msr_offsets = type->box_offset;
 		break;
+	case UNCORE_ACCESS_PCI:
+		uncore->ops = &generic_uncore_pci_ops;
+		uncore->perf_ctr = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctr_offset;
+		uncore->event_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctl_offset;
+		uncore->box_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl);
+		uncore->box_ctls = type->box_ctrl_die;
+		uncore->pci_offsets = type->box_offset;
+		break;
 	default:
 		return false;
 	}
@@ -442,3 +515,10 @@ void intel_uncore_generic_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR);
 }
+
+int intel_uncore_generic_uncore_pci_init(void)
+{
+	uncore_pci_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_PCI);
+
+	return 0;
+}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 87078ba..1639ff7 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -23,6 +23,12 @@
 /* Global discovery table size */
 #define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE	0x20
 
+#define UNCORE_DISCOVERY_PCI_DOMAIN(data)	((data >> 28) & 0x7)
+#define UNCORE_DISCOVERY_PCI_BUS(data)		((data >> 20) & 0xff)
+#define UNCORE_DISCOVERY_PCI_DEVFN(data)	((data >> 12) & 0xff)
+#define UNCORE_DISCOVERY_PCI_BOX_CTRL(data)	(data & 0xfff)
+
+
 #define uncore_discovery_invalid_unit(unit)			\
 	(!unit.table1 || !unit.ctl || !unit.table3 ||	\
 	 unit.table1 == -1ULL || unit.ctl == -1ULL ||	\
@@ -121,3 +127,4 @@ struct intel_uncore_discovery_type {
 bool intel_uncore_has_discovery_tables(void);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
+int intel_uncore_generic_uncore_pci_init(void);
