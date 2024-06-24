Return-Path: <linux-tip-commits+bounces-1516-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB025915184
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575071F21D90
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1FB19D8A3;
	Mon, 24 Jun 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgEfsI3o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vUQpHWm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AD19B3DA;
	Mon, 24 Jun 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241767; cv=none; b=o5Pci9YD+Coz5RO63XbrhJ9e8SkLb1vhdlhn3ZcwXZ+X1EyCWEeKCzhGF21JcfJrbKLRPB9mokJmDYsC29hHUKlT7vjVpMpuNYbQ9KWP9JB5XtbDRD8BJESkkUqayI4fZ9hGeI1+AE436rfnfidgB39pJ9S3J46XE17NkrDwNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241767; c=relaxed/simple;
	bh=6FfByQlZ21B/zg1lo+K1K0EJXPAJpqXmfK1th12Hc5c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BhTvHVm/UXdqW0kmKUgLC65Eu+Nkll+SoF55TLMmNLjTHBg/WRitS0Jg61lnoeU1PJGsXXrWbRllW7FAfZgfIyTFIQlc9Xoepsgok00/a4jbwOH2KfCM54ocM0DJX+5LamfwkUWwcPu3wtwpYF06z1fd4Gbo6hJDnaFkEcV25VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bgEfsI3o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vUQpHWm; arc=none smtp.client-ip=193.142.43.55
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
	bh=g8N/R0wj61fkKwuXTPdkdAWln66Ai1LitCUiHI4iXMY=;
	b=bgEfsI3o1BzqO0ogOM09ib+WCtyy/xAmlaqDG0UmaQA2ZTS469YoGmW2RpjKOBnUHa4a4b
	ew52g8WGo1j+HQYLu5HJDH8FJlLiCcPzw68oTSDnSxGRoSZzzYuWQXf9pO9LZOgLHrs/9P
	Xt0PCAlCuOg9BtCUmFikeBA3tITtBysgx25Ttw/H/crtsFrcEmXqlbkv9YSlB7C7C7Rn1k
	gBJHBrsHZFcEBCisXXhzhAE9TC0gDOAuJlnobRSE3gczw+HmRTAjpYAL7Et0GR8lwhJRmi
	slu2xhlHwmEKCGwmtHGj4luGRBqXUlgFADIImknZddVV7lmuuYqnqIJLX5duqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8N/R0wj61fkKwuXTPdkdAWln66Ai1LitCUiHI4iXMY=;
	b=1vUQpHWmTdr2Bj8LMCToWO0LW53hnNE+yEAPTlF1BbwxEkZ6Nc7FcpWc+NYyR72BHItfcr
	5V612BJNSEwvl+Bw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Cleanup unused unit structure
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yunying Sun <yunying.sun@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-8-kan.liang@linux.intel.com>
References: <20240614134631.1092359-8-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924176012.10875.13613360401273888783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     15a4bd51853b9c67f49bb03c20b6b6cb60fd204f
Gitweb:        https://git.kernel.org/tip/15a4bd51853b9c67f49bb03c20b6b6cb60fd204f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:59 +02:00

perf/x86/uncore: Cleanup unused unit structure

The unit control and ID information are retrieved from the unit control
RB tree. No one uses the old structure anymore. Remove them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20240614134631.1092359-8-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |   7 +-
 arch/x86/events/intel/uncore.h           |   2 +-
 arch/x86/events/intel/uncore_discovery.c | 110 ++--------------------
 arch/x86/events/intel/uncore_discovery.h |   5 +-
 4 files changed, 12 insertions(+), 112 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 12c8f70..9e503d8 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -868,7 +868,7 @@ static inline int uncore_get_box_id(struct intel_uncore_type *type,
 	if (type->boxes)
 		return intel_uncore_find_discovery_unit_id(type->boxes, -1, pmu->pmu_idx);
 
-	return type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx;
+	return pmu->pmu_idx;
 }
 
 void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
@@ -980,10 +980,7 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 		kfree(type->pmus);
 		type->pmus = NULL;
 	}
-	if (type->box_ids) {
-		kfree(type->box_ids);
-		type->box_ids = NULL;
-	}
+
 	kfree(type->events_group);
 	type->events_group = NULL;
 }
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 05c429c..027ef29 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -62,7 +62,6 @@ struct intel_uncore_type {
 	unsigned fixed_ctr;
 	unsigned fixed_ctl;
 	unsigned box_ctl;
-	u64 *box_ctls;	/* Unit ctrl addr of the first box of each die */
 	union {
 		unsigned msr_offset;
 		unsigned mmio_offset;
@@ -76,7 +75,6 @@ struct intel_uncore_type {
 		u64 *pci_offsets;
 		u64 *mmio_offsets;
 	};
-	unsigned *box_ids;
 	struct event_constraint unconstrainted;
 	struct event_constraint *constraints;
 	struct intel_uncore_pmu *pmus;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 866493f..571e44b 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -89,10 +89,6 @@ add_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	if (!type)
 		return NULL;
 
-	type->box_ctrl_die = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
-	if (!type->box_ctrl_die)
-		goto free_type;
-
 	type->units = RB_ROOT;
 
 	type->access_type = unit->access_type;
@@ -102,12 +98,6 @@ add_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	rb_add(&type->node, &discovery_tables, __type_less);
 
 	return type;
-
-free_type:
-	kfree(type);
-
-	return NULL;
-
 }
 
 static struct intel_uncore_discovery_type *
@@ -230,13 +220,10 @@ void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
 
 static void
 uncore_insert_box_info(struct uncore_unit_discovery *unit,
-		       int die, bool parsed)
+		       int die)
 {
 	struct intel_uncore_discovery_unit *node;
 	struct intel_uncore_discovery_type *type;
-	unsigned int *ids;
-	u64 *box_offset;
-	int i;
 
 	if (!unit->ctl || !unit->ctl_offset || !unit->ctr_offset) {
 		pr_info("Invalid address is detected for uncore type %d box %d, "
@@ -253,79 +240,21 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 	node->id = unit->box_id;
 	node->addr = unit->ctl;
 
-	if (parsed) {
-		type = search_uncore_discovery_type(unit->box_type);
-		if (!type) {
-			pr_info("A spurious uncore type %d is detected, "
-				"Disable the uncore type.\n",
-				unit->box_type);
-			kfree(node);
-			return;
-		}
-
-		uncore_find_add_unit(node, &type->units, &type->num_units);
-
-		/* Store the first box of each die */
-		if (!type->box_ctrl_die[die])
-			type->box_ctrl_die[die] = unit->ctl;
+	type = get_uncore_discovery_type(unit);
+	if (!type) {
+		kfree(node);
 		return;
 	}
 
-	type = get_uncore_discovery_type(unit);
-	if (!type)
-		goto free_node;
-
-	box_offset = kcalloc(type->num_boxes + 1, sizeof(u64), GFP_KERNEL);
-	if (!box_offset)
-		goto free_node;
-
-	ids = kcalloc(type->num_boxes + 1, sizeof(unsigned int), GFP_KERNEL);
-	if (!ids)
-		goto free_box_offset;
-
 	uncore_find_add_unit(node, &type->units, &type->num_units);
 
 	/* Store generic information for the first box */
-	if (!type->num_boxes) {
-		type->box_ctrl = unit->ctl;
-		type->box_ctrl_die[die] = unit->ctl;
+	if (type->num_units == 1) {
 		type->num_counters = unit->num_regs;
 		type->counter_width = unit->bit_width;
 		type->ctl_offset = unit->ctl_offset;
 		type->ctr_offset = unit->ctr_offset;
-		*ids = unit->box_id;
-		goto end;
 	}
-
-	for (i = 0; i < type->num_boxes; i++) {
-		ids[i] = type->ids[i];
-		box_offset[i] = type->box_offset[i];
-
-		if (unit->box_id == ids[i]) {
-			pr_info("Duplicate uncore type %d box ID %d is detected, "
-				"Drop the duplicate uncore unit.\n",
-				unit->box_type, unit->box_id);
-			goto free_ids;
-		}
-	}
-	ids[i] = unit->box_id;
-	box_offset[i] = unit->ctl - type->box_ctrl;
-	kfree(type->ids);
-	kfree(type->box_offset);
-end:
-	type->ids = ids;
-	type->box_offset = box_offset;
-	type->num_boxes++;
-	return;
-
-free_ids:
-	kfree(ids);
-
-free_box_offset:
-	kfree(box_offset);
-
-free_node:
-	kfree(node);
 }
 
 static bool
@@ -404,7 +333,7 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 		if (uncore_ignore_unit(&unit, ignore))
 			continue;
 
-		uncore_insert_box_info(&unit, die, *parsed);
+		uncore_insert_box_info(&unit, die);
 	}
 
 	*parsed = true;
@@ -474,7 +403,6 @@ void intel_uncore_clear_discovery_tables(void)
 			rb_erase(node, &type->units);
 			kfree(pos);
 		}
-		kfree(type->box_ctrl_die);
 		kfree(type);
 	}
 }
@@ -738,41 +666,23 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 				      struct intel_uncore_discovery_type *type)
 {
 	uncore->type_id = type->type;
-	uncore->num_boxes = type->num_boxes;
 	uncore->num_counters = type->num_counters;
 	uncore->perf_ctr_bits = type->counter_width;
-	uncore->box_ids = type->ids;
+	uncore->perf_ctr = (unsigned int)type->ctr_offset;
+	uncore->event_ctl = (unsigned int)type->ctl_offset;
+	uncore->boxes = &type->units;
+	uncore->num_boxes = type->num_units;
 
 	switch (type_id) {
 	case UNCORE_ACCESS_MSR:
 		uncore->ops = &generic_uncore_msr_ops;
-		uncore->perf_ctr = (unsigned int)type->ctr_offset;
-		uncore->event_ctl = (unsigned int)type->ctl_offset;
-		uncore->box_ctl = (unsigned int)type->box_ctrl;
-		uncore->msr_offsets = type->box_offset;
-		uncore->boxes = &type->units;
-		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_PCI:
 		uncore->ops = &generic_uncore_pci_ops;
-		uncore->perf_ctr = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctr_offset;
-		uncore->event_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl) + type->ctl_offset;
-		uncore->box_ctl = (unsigned int)UNCORE_DISCOVERY_PCI_BOX_CTRL(type->box_ctrl);
-		uncore->box_ctls = type->box_ctrl_die;
-		uncore->pci_offsets = type->box_offset;
-		uncore->boxes = &type->units;
-		uncore->num_boxes = type->num_units;
 		break;
 	case UNCORE_ACCESS_MMIO:
 		uncore->ops = &generic_uncore_mmio_ops;
-		uncore->perf_ctr = (unsigned int)type->ctr_offset;
-		uncore->event_ctl = (unsigned int)type->ctl_offset;
-		uncore->box_ctl = (unsigned int)type->box_ctrl;
-		uncore->box_ctls = type->box_ctrl_die;
-		uncore->mmio_offsets = type->box_offset;
 		uncore->mmio_map_size = UNCORE_GENERIC_MMIO_SIZE;
-		uncore->boxes = &type->units;
-		uncore->num_boxes = type->num_units;
 		break;
 	default:
 		return false;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 0acf9b6..0e94aa7 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -124,18 +124,13 @@ struct intel_uncore_discovery_unit {
 struct intel_uncore_discovery_type {
 	struct rb_node	node;
 	enum uncore_access_type	access_type;
-	u64		box_ctrl;	/* Unit ctrl addr of the first box */
-	u64		*box_ctrl_die;	/* Unit ctrl addr of the first box of each die */
 	struct rb_root	units;		/* Unit ctrl addr for all units */
 	u16		type;		/* Type ID of the uncore block */
 	u8		num_counters;
 	u8		counter_width;
 	u8		ctl_offset;	/* Counter Control 0 offset */
 	u8		ctr_offset;	/* Counter 0 offset */
-	u16		num_boxes;	/* number of boxes for the uncore block */
 	u16		num_units;	/* number of units */
-	unsigned int	*ids;		/* Box IDs */
-	u64		*box_offset;	/* Box offset */
 };
 
 bool intel_uncore_has_discovery_tables(int *ignore);

