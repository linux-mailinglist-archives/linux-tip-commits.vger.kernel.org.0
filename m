Return-Path: <linux-tip-commits+bounces-1514-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D1915180
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9691C22B73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603AB19CD02;
	Mon, 24 Jun 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3G6dwuF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yX/cb8Ql"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7F19B3E2;
	Mon, 24 Jun 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241765; cv=none; b=tEl2mK9Yib1lSREiIpSntIZp5NV8BWkxQ5JsTrGxPu3LzciLLzXD3MlLzW0H5cQEMj7Lc81CK0Ih/s4d4F0ALMeH7gIKZLDkxInH84nWhy84qLUDoaaHBcjJKs2GUJ0DV/CHpabVi39qvYit+7Jyj/2XzIa/ZDZepqT0hyxLNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241765; c=relaxed/simple;
	bh=B33U9LInxpwbLFxjKVZ3p1H9AflA1zF2QM6hEy6cm9Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ncFzUgCJOYX2g7G4fxUvDJ64ehsgAL2EjDlGI49oFqfLUhvKHSvbl4j8HxqygxlSGfTdkRaHIoF8PfApjUcOY3Mk1mIfXaOJJbVMDKcQo6BPUNOEnxFS0L36/LZneXYznuUl87MaEgBzJY/DMG0sorZMbL+AvrTlJ8cOLnk2/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3G6dwuF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yX/cb8Ql; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 15:09:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719241760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzSZBgJRm8NxSjVkijuf3SECHc9RtDRQPUNB4zKPSY=;
	b=U3G6dwuFCa/tpoBICMXBVgauBoEyk9xotq5li9ipG1kGm3sdXzLbabv6WrM9QmhKiZzmst
	BmOw9HcjiFsuJur9XU9nHFysxeJ88dPxwwPEE9cDJWwfTkW2J1gNDPmLyJfbuUHEVjFbHW
	AZj97GOzGF9fuAQgYdU2Mf9kHLUOhZH4Ulwen1fYeqdZXlHmC50p9dUHbzkKK3ae6Kcxl+
	9cAxMtr7fsJKY+vi1mA2q10DphpeeMesh2qjPTXdajl44HK8t8v6Ga18jnlNugiUybJOby
	/fVyHcXnQkTjp4D7yXZnGmRgK/W8Gg+E9SFBjBZobe59X9iTEv5xQgYEpFMFrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzSZBgJRm8NxSjVkijuf3SECHc9RtDRQPUNB4zKPSY=;
	b=yX/cb8QlcsuyZVblklkU0njUra2QiMCF3EyRYmFwN+zLz2I40dJBLDzcz7w1iACD4RaOYb
	wYKuow93ZrEGwFBg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Apply the unit control RB tree to
 PCI uncore units
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yunying Sun <yunying.sun@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-7-kan.liang@linux.intel.com>
References: <20240614134631.1092359-7-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924176031.10875.17039932923973171228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f76a8420444beb1c3968504c8176a67d2d5fe18f
Gitweb:        https://git.kernel.org/tip/f76a8420444beb1c3968504c8176a67d2d5fe18f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:58 +02:00

perf/x86/uncore: Apply the unit control RB tree to PCI uncore units

The unit control RB tree has the unit control and unit ID information
for all the PCI units. Use them to replace the box_ctls/pci_offsets to
get an accurate unit control address for PCI uncore units.

The UPI/M3UPI units in the discovery table are ignored. Please see the
commit 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR").
Manually allocate a unit control RB tree for UPI/M3UPI.
Add cleanup_extra_boxes to release such manual allocation.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20240614134631.1092359-7-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           | 53 +++++++++------------
 arch/x86/events/intel/uncore.h           |  4 ++-
 arch/x86/events/intel/uncore_discovery.c | 26 +++++++---
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 arch/x86/events/intel/uncore_snbep.c     | 57 +++++++++++++++++------
 5 files changed, 94 insertions(+), 48 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b89c8e0..12c8f70 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -969,6 +969,9 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 	if (type->cleanup_mapping)
 		type->cleanup_mapping(type);
 
+	if (type->cleanup_extra_boxes)
+		type->cleanup_extra_boxes(type);
+
 	if (pmu) {
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			uncore_pmu_unregister(pmu);
@@ -1084,22 +1087,19 @@ static struct intel_uncore_pmu *
 uncore_pci_find_dev_pmu_from_types(struct pci_dev *pdev)
 {
 	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
-	u64 box_ctl;
-	int i, die;
+	struct rb_node *node;
 
 	for (; *types; types++) {
 		type = *types;
-		for (die = 0; die < __uncore_max_dies; die++) {
-			for (i = 0; i < type->num_boxes; i++) {
-				if (!type->box_ctls[die])
-					continue;
-				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
-				if (pdev->devfn == UNCORE_DISCOVERY_PCI_DEVFN(box_ctl) &&
-				    pdev->bus->number == UNCORE_DISCOVERY_PCI_BUS(box_ctl) &&
-				    pci_domain_nr(pdev->bus) == UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl))
-					return &type->pmus[i];
-			}
+
+		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
+			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+			if (pdev->devfn == UNCORE_DISCOVERY_PCI_DEVFN(unit->addr) &&
+			    pdev->bus->number == UNCORE_DISCOVERY_PCI_BUS(unit->addr) &&
+			    pci_domain_nr(pdev->bus) == UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr))
+				return &type->pmus[unit->pmu_idx];
 		}
 	}
 
@@ -1375,28 +1375,25 @@ static struct notifier_block uncore_pci_notifier = {
 static void uncore_pci_pmus_register(void)
 {
 	struct intel_uncore_type **types = uncore_pci_uncores;
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
+	struct rb_node *node;
 	struct pci_dev *pdev;
-	u64 box_ctl;
-	int i, die;
 
 	for (; *types; types++) {
 		type = *types;
-		for (die = 0; die < __uncore_max_dies; die++) {
-			for (i = 0; i < type->num_boxes; i++) {
-				if (!type->box_ctls[die])
-					continue;
-				box_ctl = type->box_ctls[die] + type->pci_offsets[i];
-				pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(box_ctl),
-								   UNCORE_DISCOVERY_PCI_BUS(box_ctl),
-								   UNCORE_DISCOVERY_PCI_DEVFN(box_ctl));
-				if (!pdev)
-					continue;
-				pmu = &type->pmus[i];
-
-				uncore_pci_pmu_register(pdev, type, pmu, die);
-			}
+
+		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
+			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
+							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
+							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
+
+			if (!pdev)
+				continue;
+			pmu = &type->pmus[unit->pmu_idx];
+			uncore_pci_pmu_register(pdev, type, pmu, unit->die);
 		}
 	}
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 0a49e30..05c429c 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -99,6 +99,10 @@ struct intel_uncore_type {
 	int (*get_topology)(struct intel_uncore_type *type);
 	void (*set_mapping)(struct intel_uncore_type *type);
 	void (*cleanup_mapping)(struct intel_uncore_type *type);
+	/*
+	 * Optional callbacks for extra uncore units cleanup
+	 */
+	void (*cleanup_extra_boxes)(struct intel_uncore_type *type);
 };
 
 #define pmu_group attr_groups[0]
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 076ec1e..866493f 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -215,8 +215,8 @@ uncore_find_unit(struct rb_root *root, unsigned int id)
 	return NULL;
 }
 
-static void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
-				 struct rb_root *root, u16 *num_units)
+void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
+			  struct rb_root *root, u16 *num_units)
 {
 	struct intel_uncore_discovery_unit *unit = uncore_find_unit(root, node->id);
 
@@ -560,7 +560,7 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 	if (!box->pmu->type->boxes)
 		return false;
 
-	if (box->pci_dev || box->io_addr) {
+	if (box->io_addr) {
 		hwc->config_base = uncore_pci_event_ctl(box, hwc->idx);
 		hwc->event_base  = uncore_pci_perf_ctr(box, hwc->idx);
 		return true;
@@ -570,16 +570,28 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 	if (!box_ctl)
 		return false;
 
+	if (box->pci_dev) {
+		box_ctl = UNCORE_DISCOVERY_PCI_BOX_CTRL(box_ctl);
+		hwc->config_base = box_ctl + uncore_pci_event_ctl(box, hwc->idx);
+		hwc->event_base  = box_ctl + uncore_pci_perf_ctr(box, hwc->idx);
+		return true;
+	}
+
 	hwc->config_base = box_ctl + box->pmu->type->event_ctl + hwc->idx;
 	hwc->event_base  = box_ctl + box->pmu->type->perf_ctr + hwc->idx;
 
 	return true;
 }
 
+static inline int intel_pci_uncore_box_ctl(struct intel_uncore_box *box)
+{
+	return UNCORE_DISCOVERY_PCI_BOX_CTRL(intel_generic_uncore_box_ctl(box));
+}
+
 void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
-	int box_ctl = uncore_pci_box_ctl(box);
+	int box_ctl = intel_pci_uncore_box_ctl(box);
 
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
@@ -588,7 +600,7 @@ void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
-	int box_ctl = uncore_pci_box_ctl(box);
+	int box_ctl = intel_pci_uncore_box_ctl(box);
 
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
 }
@@ -596,7 +608,7 @@ void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
-	int box_ctl = uncore_pci_box_ctl(box);
+	int box_ctl = intel_pci_uncore_box_ctl(box);
 
 	pci_write_config_dword(pdev, box_ctl, 0);
 }
@@ -748,6 +760,8 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl);
 		uncore->box_ctls = type->box_ctrl_die;
 		uncore->pci_offsets = type->box_offset;
+		uncore->boxes = &type->units;
+		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_MMIO:
 		uncore->ops = &generic_uncore_mmio_ops;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 4a7a7c8..0acf9b6 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -171,3 +171,5 @@ int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
 					unsigned int pmu_idx);
 bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 					  struct intel_uncore_box *box);
+void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
+			  struct rb_root *root, u16 *num_units);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8b1cabf..fde123a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6199,6 +6199,24 @@ static u64 spr_upi_pci_offsets[SPR_UNCORE_UPI_NUM_BOXES] = {
 	0, 0x8000, 0x10000, 0x18000
 };
 
+static void spr_extra_boxes_cleanup(struct intel_uncore_type *type)
+{
+	struct intel_uncore_discovery_unit *pos;
+	struct rb_node *node;
+
+	if (!type->boxes)
+		return;
+
+	while (!RB_EMPTY_ROOT(type->boxes)) {
+		node = rb_first(type->boxes);
+		pos = rb_entry(node, struct intel_uncore_discovery_unit, node);
+		rb_erase(node, type->boxes);
+		kfree(pos);
+	}
+	kfree(type->boxes);
+	type->boxes = NULL;
+}
+
 static struct intel_uncore_type spr_uncore_upi = {
 	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
 	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
@@ -6213,10 +6231,11 @@ static struct intel_uncore_type spr_uncore_upi = {
 	.num_counters		= 4,
 	.num_boxes		= SPR_UNCORE_UPI_NUM_BOXES,
 	.perf_ctr_bits		= 48,
-	.perf_ctr		= ICX_UPI_PCI_PMON_CTR0,
-	.event_ctl		= ICX_UPI_PCI_PMON_CTL0,
+	.perf_ctr		= ICX_UPI_PCI_PMON_CTR0 - ICX_UPI_PCI_PMON_BOX_CTL,
+	.event_ctl		= ICX_UPI_PCI_PMON_CTL0 - ICX_UPI_PCI_PMON_BOX_CTL,
 	.box_ctl		= ICX_UPI_PCI_PMON_BOX_CTL,
 	.pci_offsets		= spr_upi_pci_offsets,
+	.cleanup_extra_boxes	= spr_extra_boxes_cleanup,
 };
 
 static struct intel_uncore_type spr_uncore_m3upi = {
@@ -6226,11 +6245,12 @@ static struct intel_uncore_type spr_uncore_m3upi = {
 	.num_counters		= 4,
 	.num_boxes		= SPR_UNCORE_UPI_NUM_BOXES,
 	.perf_ctr_bits		= 48,
-	.perf_ctr		= ICX_M3UPI_PCI_PMON_CTR0,
-	.event_ctl		= ICX_M3UPI_PCI_PMON_CTL0,
+	.perf_ctr		= ICX_M3UPI_PCI_PMON_CTR0 - ICX_M3UPI_PCI_PMON_BOX_CTL,
+	.event_ctl		= ICX_M3UPI_PCI_PMON_CTL0 - ICX_M3UPI_PCI_PMON_BOX_CTL,
 	.box_ctl		= ICX_M3UPI_PCI_PMON_BOX_CTL,
 	.pci_offsets		= spr_upi_pci_offsets,
 	.constraints		= icx_uncore_m3upi_constraints,
+	.cleanup_extra_boxes	= spr_extra_boxes_cleanup,
 };
 
 enum perf_uncore_spr_iio_freerunning_type_id {
@@ -6517,10 +6537,11 @@ void spr_uncore_cpu_init(void)
 
 static void spr_update_device_location(int type_id)
 {
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
 	struct pci_dev *dev = NULL;
+	struct rb_root *root;
 	u32 device, devfn;
-	u64 *ctls;
 	int die;
 
 	if (type_id == UNCORE_SPR_UPI) {
@@ -6534,27 +6555,35 @@ static void spr_update_device_location(int type_id)
 	} else
 		return;
 
-	ctls = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
-	if (!ctls) {
+	root = kzalloc(sizeof(struct rb_root), GFP_KERNEL);
+	if (!root) {
 		type->num_boxes = 0;
 		return;
 	}
+	*root = RB_ROOT;
 
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
-		if (devfn != dev->devfn)
-			continue;
 
 		die = uncore_device_to_die(dev);
 		if (die < 0)
 			continue;
 
-		ctls[die] = pci_domain_nr(dev->bus) << UNCORE_DISCOVERY_PCI_DOMAIN_OFFSET |
-			    dev->bus->number << UNCORE_DISCOVERY_PCI_BUS_OFFSET |
-			    devfn << UNCORE_DISCOVERY_PCI_DEVFN_OFFSET |
-			    type->box_ctl;
+		unit = kzalloc(sizeof(*unit), GFP_KERNEL);
+		if (!unit)
+			continue;
+		unit->die = die;
+		unit->id = PCI_SLOT(dev->devfn) - PCI_SLOT(devfn);
+		unit->addr = pci_domain_nr(dev->bus) << UNCORE_DISCOVERY_PCI_DOMAIN_OFFSET |
+			     dev->bus->number << UNCORE_DISCOVERY_PCI_BUS_OFFSET |
+			     devfn << UNCORE_DISCOVERY_PCI_DEVFN_OFFSET |
+			     type->box_ctl;
+
+		unit->pmu_idx = unit->id;
+
+		uncore_find_add_unit(unit, root, NULL);
 	}
 
-	type->box_ctls = ctls;
+	type->boxes = root;
 }
 
 int spr_uncore_pci_init(void)

