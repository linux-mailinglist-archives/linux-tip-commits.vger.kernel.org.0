Return-Path: <linux-tip-commits+bounces-1518-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07801915187
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ED028A8CE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AA19DF48;
	Mon, 24 Jun 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TeCkVpYr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vW/uja8y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5719D063;
	Mon, 24 Jun 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241768; cv=none; b=Au4br4d9XtSv2fWVSASvV0I/k9x5bQldxU1RDMCuviqyta12ze8ph/xnOhlcriXn8w80l7x+QZGwWF+y6UqXzZ+3FeXm6CnYTy7mWbPQC8n+znebncNI6xoTQPsBJi2EStxUH7e5g9QRksa0CPmbS0kFSx1+wdbC1bw0trQKB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241768; c=relaxed/simple;
	bh=68pqjuunjQ/2fPP4yW0pZ2+gsK6mbAQ7BKevh7JHuYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M6SPaU+VFcVt/a2qlLt/i5Evp3qimW/8+9oraWhAThQC0Y1SkSBdpgDaDWtPc+6f8W4uxrhCgQnzLYd/Egi0mH0eb3EmNnmRzuzQMtxeHz/ZocWTvQrCXLHxDTZVWIFOfQPmA+g5P6K1hD4J5UYzuZM/fRrKNlzbCHivzDY+6Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TeCkVpYr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vW/uja8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 15:09:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719241761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8oPuFg4gak8B9tW09q3n2CtmZj4sJyCrZ1VUeA6e5U=;
	b=TeCkVpYrTXu40ofTraIqgQogokRQRTeL9p7ffBuddWaJmWVnK3pD3OTMOKJ9D3tlYjdkQ9
	tgSaINXKJ9Pc6gdctd9EQ0qSeNHrjDOhbqTB+wiEJMu36Dv64kLQRmWkkfc7q8k1t9Jf+8
	I0d4+DvhtPtwriY2h8ivElOsXiuJu6jI+pgtZC2Z+QJlR9YDEkwZgqpl4SIeBHqaDvui9n
	OmoTiitfdiQXsz0XIEUinaxAt9I5qQ0FRCp+kDR0CHkCTl996Vk/7WYSzfvW8pdAL/+Ulz
	u05qny4XPZTJ76luTc1dRuZlbQkf5/7D+IznQsFpDZE3V4BESMTomOQhC5t3rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8oPuFg4gak8B9tW09q3n2CtmZj4sJyCrZ1VUeA6e5U=;
	b=vW/uja8yx9ThP3RvBUbo9o+XeN7QdlXy2nKl1ngMtn21OTFZZn9SLbWAV+gFDAUjAR4ruV
	ndCWm8xjg1VrCLDg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/uncore: Save the unit control address of all units
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-2-kan.liang@linux.intel.com>
References: <20240614134631.1092359-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924176135.10875.18317409575746674807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0007f39325921351b7860a976a730acbb198b9ca
Gitweb:        https://git.kernel.org/tip/0007f39325921351b7860a976a730acbb198b9ca
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:24 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:55 +02:00

perf/x86/uncore: Save the unit control address of all units

The unit control address of some CXL units may be wrongly calculated
under some configuration on a EMR machine.

The current implementation only saves the unit control address of the
units from the first die, and the first unit of the rest of dies. Perf
assumed that the units from the other dies have the same offset as the
first die. So the unit control address of the rest of the units can be
calculated. However, the assumption is wrong, especially for the CXL
units.

Introduce an RB tree for each uncore type to save the unit control
address and three kinds of ID information (unit ID, PMU ID, and die ID)
for all units.
The unit ID is a physical ID of a unit.
The PMU ID is a logical ID assigned to a unit. The logical IDs start
from 0 and must be contiguous. The physical ID and the logical ID are
1:1 mapping. The units with the same physical ID in different dies share
the same PMU.
The die ID indicates which die a unit belongs to.

The RB tree can be searched by two different keys (unit ID or PMU ID +
die ID). During the RB tree setup, the unit ID is used as a key to look
up the RB tree. The perf can create/assign a proper PMU ID to the unit.
Later, after the RB tree is setup, PMU ID + die ID is used as a key to
look up the RB tree to fill the cpumask of a PMU. It's used more
frequently, so PMU ID + die ID is compared in the unit_less().
The uncore_find_unit() has to be O(N). But the RB tree setup only occurs
once during the driver load time. It should be acceptable.

Compared with the current implementation, more space is required to save
the information of all units. The extra size should be acceptable.
For example, on EMR, there are 221 units at most. For a 2-socket machine,
the extra space is ~6KB at most.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240614134631.1092359-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c | 79 ++++++++++++++++++++++-
 arch/x86/events/intel/uncore_discovery.h | 10 +++-
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 9a698a9..ce520e6 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -93,6 +93,8 @@ add_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	if (!type->box_ctrl_die)
 		goto free_type;
 
+	type->units = RB_ROOT;
+
 	type->access_type = unit->access_type;
 	num_discovered_types[type->access_type]++;
 	type->type = unit->box_type;
@@ -120,10 +122,59 @@ get_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	return add_uncore_discovery_type(unit);
 }
 
+static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
+{
+	struct intel_uncore_discovery_unit *a_node, *b_node;
+
+	a_node = rb_entry(a, struct intel_uncore_discovery_unit, node);
+	b_node = rb_entry(b, struct intel_uncore_discovery_unit, node);
+
+	if (a_node->pmu_idx < b_node->pmu_idx)
+		return true;
+	if (a_node->pmu_idx > b_node->pmu_idx)
+		return false;
+
+	if (a_node->die < b_node->die)
+		return true;
+	if (a_node->die > b_node->die)
+		return false;
+
+	return 0;
+}
+
+static inline struct intel_uncore_discovery_unit *
+uncore_find_unit(struct rb_root *root, unsigned int id)
+{
+	struct intel_uncore_discovery_unit *unit;
+	struct rb_node *node;
+
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+		if (unit->id == id)
+			return unit;
+	}
+
+	return NULL;
+}
+
+static void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
+				 struct rb_root *root, u16 *num_units)
+{
+	struct intel_uncore_discovery_unit *unit = uncore_find_unit(root, node->id);
+
+	if (unit)
+		node->pmu_idx = unit->pmu_idx;
+	else if (num_units)
+		node->pmu_idx = (*num_units)++;
+
+	rb_add(&node->node, root, unit_less);
+}
+
 static void
 uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		       int die, bool parsed)
 {
+	struct intel_uncore_discovery_unit *node;
 	struct intel_uncore_discovery_type *type;
 	unsigned int *ids;
 	u64 *box_offset;
@@ -136,14 +187,26 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		return;
 	}
 
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return;
+
+	node->die = die;
+	node->id = unit->box_id;
+	node->addr = unit->ctl;
+
 	if (parsed) {
 		type = search_uncore_discovery_type(unit->box_type);
 		if (!type) {
 			pr_info("A spurious uncore type %d is detected, "
 				"Disable the uncore type.\n",
 				unit->box_type);
+			kfree(node);
 			return;
 		}
+
+		uncore_find_add_unit(node, &type->units, &type->num_units);
+
 		/* Store the first box of each die */
 		if (!type->box_ctrl_die[die])
 			type->box_ctrl_die[die] = unit->ctl;
@@ -152,16 +215,18 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 
 	type = get_uncore_discovery_type(unit);
 	if (!type)
-		return;
+		goto free_node;
 
 	box_offset = kcalloc(type->num_boxes + 1, sizeof(u64), GFP_KERNEL);
 	if (!box_offset)
-		return;
+		goto free_node;
 
 	ids = kcalloc(type->num_boxes + 1, sizeof(unsigned int), GFP_KERNEL);
 	if (!ids)
 		goto free_box_offset;
 
+	uncore_find_add_unit(node, &type->units, &type->num_units);
+
 	/* Store generic information for the first box */
 	if (!type->num_boxes) {
 		type->box_ctrl = unit->ctl;
@@ -201,6 +266,8 @@ free_ids:
 free_box_offset:
 	kfree(box_offset);
 
+free_node:
+	kfree(node);
 }
 
 static bool
@@ -339,8 +406,16 @@ err:
 void intel_uncore_clear_discovery_tables(void)
 {
 	struct intel_uncore_discovery_type *type, *next;
+	struct intel_uncore_discovery_unit *pos;
+	struct rb_node *node;
 
 	rbtree_postorder_for_each_entry_safe(type, next, &discovery_tables, node) {
+		while (!RB_EMPTY_ROOT(&type->units)) {
+			node = rb_first(&type->units);
+			pos = rb_entry(node, struct intel_uncore_discovery_unit, node);
+			rb_erase(node, &type->units);
+			kfree(pos);
+		}
 		kfree(type->box_ctrl_die);
 		kfree(type);
 	}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 22e769a..5190017 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -113,17 +113,27 @@ struct uncore_unit_discovery {
 	};
 };
 
+struct intel_uncore_discovery_unit {
+	struct rb_node	node;
+	unsigned int	pmu_idx;	/* The idx of the corresponding PMU */
+	unsigned int	id;		/* Unit ID */
+	unsigned int	die;		/* Die ID */
+	u64		addr;		/* Unit Control Address */
+};
+
 struct intel_uncore_discovery_type {
 	struct rb_node	node;
 	enum uncore_access_type	access_type;
 	u64		box_ctrl;	/* Unit ctrl addr of the first box */
 	u64		*box_ctrl_die;	/* Unit ctrl addr of the first box of each die */
+	struct rb_root	units;		/* Unit ctrl addr for all units */
 	u16		type;		/* Type ID of the uncore block */
 	u8		num_counters;
 	u8		counter_width;
 	u8		ctl_offset;	/* Counter Control 0 offset */
 	u8		ctr_offset;	/* Counter 0 offset */
 	u16		num_boxes;	/* number of boxes for the uncore block */
+	u16		num_units;	/* number of units */
 	unsigned int	*ids;		/* Box IDs */
 	u64		*box_offset;	/* Box offset */
 };

