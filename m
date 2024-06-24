Return-Path: <linux-tip-commits+bounces-1513-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53CE91517D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E503A1C22833
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9E19CCED;
	Mon, 24 Jun 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LfOAVj56";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+4H6+v74"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E419B5A7;
	Mon, 24 Jun 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241764; cv=none; b=sjy2YoXwE+a+QNI++LgCj8mBuXxHYlA02FOk9RRAVR/ulbIVp9GT4R97/AYIN50wPKV+o4cJFONUiavbNQ9BgqfFBwWFUH28dR1r1ZbI7ax+cT8uCLnBzV8w7ZpsAsFkcbfkW+9GyVgH1xsze0uXhAsQneNJmMBTLIz20+9TPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241764; c=relaxed/simple;
	bh=2jcdM06oBCVj0g8t2wAiPDaepHkiFnjlpGnc9fpKrBM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZJQYxTSNDfv7JsI8cRk6BabGH39cMTQHgAAYruDiqeJhUpk1sfs+RCybFp9qv+LOwTmNOL3k+5uuBftOh4zy/RXVDKfXEaQap3ggr0QTZYX+QpeBsb8N+5bbSh9DC9v0uXt9xAeRDFMaDLpILio2si0xzsqYHjwde/uAhYPSUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LfOAVj56; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+4H6+v74; arc=none smtp.client-ip=193.142.43.55
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
	bh=OOHe9oI/0CgFcW4GtzyIdN2BUr7Yuv3HviWT4nyQTDo=;
	b=LfOAVj56Fe/n2lbWegZ+cBPTjdE6yIFypStxfuU1gNw7S5Ejvd0xwIYrM0Ice2T8oJM8dL
	LypBs67y12p2kAl1gTrxqAHuqh56978x6c9BRY0b0F1Sqd8Eam1e8DNwPX3Dvp+UM6NXL4
	3blR6oPI3VzxUyv/moN2Z3UF0tILUxRVdnqijrP4ZJdoAgPub8rysEy+P6jfQIxhftG5B/
	OqNBVLP6Gn3n3FpH+IcUtXEAWac8XahfQc1pzvmaWusL/lISIKuZ0EfbJcj2fYoSBUZYhb
	PwnuJrabzgjVnYxZenKoDDfMhm4itINDglCraLPsD6Y9mOUoTT21zNK4DfymgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOHe9oI/0CgFcW4GtzyIdN2BUr7Yuv3HviWT4nyQTDo=;
	b=+4H6+v74s7DiHTZRJwxeJfzZg9qNpZpIgww6h/2WpX+ct5Jmw2508UUkpSqMkiwEuT9r61
	lQDqYI59RNOkN+Ag==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Apply the unit control RB tree to
 MSR uncore units
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yunying Sun <yunying.sun@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-6-kan.liang@linux.intel.com>
References: <20240614134631.1092359-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924176055.10875.10259346235143772268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b1d9ea2e1ca44987c8409cc628dfb0c84e93dce9
Gitweb:        https://git.kernel.org/tip/b1d9ea2e1ca44987c8409cc628dfb0c84e93dce9
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:57 +02:00

perf/x86/uncore: Apply the unit control RB tree to MSR uncore units

The unit control RB tree has the unit control and unit ID information
for all the MSR units. Use them to replace the box_ctl and
uncore_msr_box_ctl() to get an accurate unit control address for MSR
uncore units.

Add intel_generic_uncore_assign_hw_event(), which utilizes the accurate
unit control address from the unit control RB tree to calculate the
config_base and event_base.

The unit id related information should be retrieved from the unit
control RB tree as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20240614134631.1092359-6-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |  3 +-
 arch/x86/events/intel/uncore_discovery.c | 49 ++++++++++++++++++++---
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 arch/x86/events/intel/uncore_snbep.c     | 16 +++++---
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 08e85db..b89c8e0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -263,6 +263,9 @@ static void uncore_assign_hw_event(struct intel_uncore_box *box,
 		return;
 	}
 
+	if (intel_generic_uncore_assign_hw_event(event, box))
+		return;
+
 	hwc->config_base = uncore_event_ctl(box, hwc->idx);
 	hwc->event_base  = uncore_perf_ctr(box, hwc->idx);
 }
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index ece761c..076ec1e 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -499,19 +499,31 @@ static const struct attribute_group generic_uncore_format_group = {
 	.attrs = generic_uncore_formats_attr,
 };
 
+static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
+{
+	struct intel_uncore_discovery_unit *unit;
+
+	unit = intel_uncore_find_discovery_unit(box->pmu->type->boxes,
+						-1, box->pmu->pmu_idx);
+	if (WARN_ON_ONCE(!unit))
+		return 0;
+
+	return unit->addr;
+}
+
 void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
+	wrmsrl(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
 }
 
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
+	wrmsrl(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
 }
 
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), 0);
+	wrmsrl(intel_generic_uncore_box_ctl(box), 0);
 }
 
 static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
@@ -539,6 +551,31 @@ static struct intel_uncore_ops generic_uncore_msr_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
+bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
+					  struct intel_uncore_box *box)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 box_ctl;
+
+	if (!box->pmu->type->boxes)
+		return false;
+
+	if (box->pci_dev || box->io_addr) {
+		hwc->config_base = uncore_pci_event_ctl(box, hwc->idx);
+		hwc->event_base  = uncore_pci_perf_ctr(box, hwc->idx);
+		return true;
+	}
+
+	box_ctl = intel_generic_uncore_box_ctl(box);
+	if (!box_ctl)
+		return false;
+
+	hwc->config_base = box_ctl + box->pmu->type->event_ctl + hwc->idx;
+	hwc->event_base  = box_ctl + box->pmu->type->perf_ctr + hwc->idx;
+
+	return true;
+}
+
 void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
@@ -697,10 +734,12 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 	switch (type_id) {
 	case UNCORE_ACCESS_MSR:
 		uncore->ops = &generic_uncore_msr_ops;
-		uncore->perf_ctr = (unsigned int)type->box_ctrl + type->ctr_offset;
-		uncore->event_ctl = (unsigned int)type->box_ctrl + type->ctl_offset;
+		uncore->perf_ctr = (unsigned int)type->ctr_offset;
+		uncore->event_ctl = (unsigned int)type->ctl_offset;
 		uncore->box_ctl = (unsigned int)type->box_ctrl;
 		uncore->msr_offsets = type->box_offset;
+		uncore->boxes = &type->units;
+		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_PCI:
 		uncore->ops = &generic_uncore_pci_ops;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 96265cf..4a7a7c8 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -169,3 +169,5 @@ intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra
 
 int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
 					unsigned int pmu_idx);
+bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
+					  struct intel_uncore_box *box);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 74b8b21..8b1cabf 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5933,10 +5933,11 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
 	bool tie_en = !!(event->hw.config & SPR_CHA_PMON_CTL_TID_EN);
 	struct intel_uncore_type *type = box->pmu->type;
+	int id = intel_uncore_find_discovery_unit_id(type->boxes, -1, box->pmu->pmu_idx);
 
 	if (tie_en) {
 		reg1->reg = SPR_C0_MSR_PMON_BOX_FILTER0 +
-			    HSWEP_CBO_MSR_OFFSET * type->box_ids[box->pmu->pmu_idx];
+			    HSWEP_CBO_MSR_OFFSET * id;
 		reg1->config = event->attr.config1 & SPR_CHA_PMON_BOX_FILTER_TID;
 		reg1->idx = 0;
 	}
@@ -6460,18 +6461,21 @@ uncore_find_type_by_id(struct intel_uncore_type **types, int type_id)
 static int uncore_type_max_boxes(struct intel_uncore_type **types,
 				 int type_id)
 {
+	struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type;
-	int i, max = 0;
+	struct rb_node *node;
+	int max = 0;
 
 	type = uncore_find_type_by_id(types, type_id);
 	if (!type)
 		return 0;
 
-	for (i = 0; i < type->num_boxes; i++) {
-		if (type->box_ids[i] > max)
-			max = type->box_ids[i];
-	}
+	for (node = rb_first(type->boxes); node; node = rb_next(node)) {
+		unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
 
+		if (unit->id > max)
+			max = unit->id;
+	}
 	return max + 1;
 }
 

