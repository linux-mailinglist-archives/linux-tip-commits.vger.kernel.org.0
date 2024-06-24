Return-Path: <linux-tip-commits+bounces-1517-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBDE915185
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C81F2186C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58B19D8B2;
	Mon, 24 Jun 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hkyl9apL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGA2YISw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C519CD07;
	Mon, 24 Jun 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241767; cv=none; b=CaiKB/1Kn3VV5z3yPv2YNA/9+wZcMNHpAxAKLbrWGC65HPN5nOkg6p0bwSkCxbNk5ZL/GFXOI2ZVfq5wbkctLF3d/GLGOZMRgzVwtkVx/IU7bb/EotJQvLCqn7eD416arTPWB79iif9oECKZBXGgZW2Sb7n162JKz/OHBaHJ9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241767; c=relaxed/simple;
	bh=rHy3XSR8afTI7hgSwml7T1l19Ir7ik7qWzZnhL8C8UA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u9LZuJz+CvAI9fcIPQ7dWrp1KdAb3kZIGoedd/rh6CfdePc9cRR7seSmZzCcz4JDh0ilvB6Dhq7GtcLuhQQ5RBtEQl2BvovfxZBudSo1+sT+nd0pQLBLwynctdXk9qfYu2lIFfS3MPmkY8ezCDb/Sxg6XmeTm1I2tTqvfUlTKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hkyl9apL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGA2YISw; arc=none smtp.client-ip=193.142.43.55
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
	bh=zQywHD4JsOvepBWPnQRXJSEIHx6fLLGgjYYX6KumLCY=;
	b=Hkyl9apLU4nhzs6wsOutcJ5iYy+UBxRWkgwjabvlnXDCrU4xJfWi2c5e34OfOkmyouBLNa
	eE+j/LWcOMluof11BxkE8b5n+z88344KwFPp2vw6vrJrI6/BK84T4o0Pe5qOdjcuSgrHpI
	7volOJdEJbbi8TNwCxeWZ/E1LKg7xTo1+KRP7mQAvWAWrn3Wh/CNMIHNrzZ6PClAoBGDVQ
	BjVd48dtxzeeL5nrqKVQ4ufqfZGJ3DiWonbNbbU6AVY92KRMWn9K2jIaEjrTdZfrPKYrT3
	A0W7+SKoJv8SMEJGr9G54oyEC4mQnUh0J8qAC4h0axdjiTsqFnYOgNZmqmewxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQywHD4JsOvepBWPnQRXJSEIHx6fLLGgjYYX6KumLCY=;
	b=BGA2YISw2IqGxjtiWI1Zd3sylp7hxoCIOzZUI3zKIkczvND8ER6s0ugz7XHtF3fkiF7LtH
	YGvd0WFVTizmxqDw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Support per PMU cpumask
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yunying Sun <yunying.sun@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-3-kan.liang@linux.intel.com>
References: <20240614134631.1092359-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924176114.10875.13156163294388905807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c74443d92f68f07c03ae242ced554b749e6c6736
Gitweb:        https://git.kernel.org/tip/c74443d92f68f07c03ae242ced554b749e6c6736
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:25 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:56 +02:00

perf/x86/uncore: Support per PMU cpumask

The cpumask of some uncore units, e.g., CXL uncore units, may be wrong
under some configurations. Perf may access an uncore counter of a
non-existent uncore unit.

The uncore driver assumes that all uncore units are symmetric among
dies. A global cpumask is shared among all uncore PMUs. However, some
CXL uncore units may only be available on some dies.

A per PMU cpumask is introduced to track the CPU mask of this PMU.
The driver searches the unit control RB tree to check whether the PMU is
available on a given die, and updates the per PMU cpumask accordingly.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20240614134631.1092359-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           | 31 ++++++++++--
 arch/x86/events/intel/uncore.h           |  2 +-
 arch/x86/events/intel/uncore_discovery.c | 58 +++++++++++++++++++++++-
 arch/x86/events/intel/uncore_discovery.h |  3 +-
 4 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 419c517..f699606 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -843,7 +843,9 @@ static void uncore_pmu_disable(struct pmu *pmu)
 static ssize_t uncore_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &uncore_cpu_mask);
+	struct intel_uncore_pmu *pmu = container_of(dev_get_drvdata(dev), struct intel_uncore_pmu, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->cpu_mask);
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
@@ -1453,6 +1455,18 @@ static void uncore_pci_exit(void)
 	}
 }
 
+static bool uncore_die_has_box(struct intel_uncore_type *type,
+			       int die, unsigned int pmu_idx)
+{
+	if (!type->boxes)
+		return true;
+
+	if (intel_uncore_find_discovery_unit_id(type->boxes, die, pmu_idx) < 0)
+		return false;
+
+	return true;
+}
+
 static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 				   int new_cpu)
 {
@@ -1468,18 +1482,25 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 
 		if (old_cpu < 0) {
 			WARN_ON_ONCE(box->cpu != -1);
-			box->cpu = new_cpu;
+			if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
+				box->cpu = new_cpu;
+				cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
+			}
 			continue;
 		}
 
-		WARN_ON_ONCE(box->cpu != old_cpu);
+		WARN_ON_ONCE(box->cpu != -1 && box->cpu != old_cpu);
 		box->cpu = -1;
+		cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
 		if (new_cpu < 0)
 			continue;
 
+		if (!uncore_die_has_box(type, die, pmu->pmu_idx))
+			continue;
 		uncore_pmu_cancel_hrtimer(box);
 		perf_pmu_migrate_context(&pmu->pmu, old_cpu, new_cpu);
 		box->cpu = new_cpu;
+		cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
 	}
 }
 
@@ -1502,7 +1523,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[id];
-			if (box && atomic_dec_return(&box->refcnt) == 0)
+			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
 				uncore_box_exit(box);
 		}
 	}
@@ -1592,7 +1613,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[id];
-			if (box && atomic_inc_return(&box->refcnt) == 1)
+			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
 				uncore_box_init(box);
 		}
 	}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 4838502..0a49e30 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -86,6 +86,7 @@ struct intel_uncore_type {
 	const struct attribute_group *attr_groups[4];
 	const struct attribute_group **attr_update;
 	struct pmu *pmu; /* for custom pmu ops */
+	struct rb_root *boxes;
 	/*
 	 * Uncore PMU would store relevant platform topology configuration here
 	 * to identify which platform component each PMON block of that type is
@@ -125,6 +126,7 @@ struct intel_uncore_pmu {
 	int				func_id;
 	bool				registered;
 	atomic_t			activeboxes;
+	cpumask_t			cpu_mask;
 	struct intel_uncore_type	*type;
 	struct intel_uncore_box		**boxes;
 };
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index ce520e6..e61e460 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -122,6 +122,64 @@ get_uncore_discovery_type(struct uncore_unit_discovery *unit)
 	return add_uncore_discovery_type(unit);
 }
 
+static inline int pmu_idx_cmp(const void *key, const struct rb_node *b)
+{
+	struct intel_uncore_discovery_unit *unit;
+	const unsigned int *id = key;
+
+	unit = rb_entry(b, struct intel_uncore_discovery_unit, node);
+
+	if (unit->pmu_idx > *id)
+		return -1;
+	else if (unit->pmu_idx < *id)
+		return 1;
+
+	return 0;
+}
+
+static struct intel_uncore_discovery_unit *
+intel_uncore_find_discovery_unit(struct rb_root *units, int die,
+				 unsigned int pmu_idx)
+{
+	struct intel_uncore_discovery_unit *unit;
+	struct rb_node *pos;
+
+	if (!units)
+		return NULL;
+
+	pos = rb_find_first(&pmu_idx, units, pmu_idx_cmp);
+	if (!pos)
+		return NULL;
+	unit = rb_entry(pos, struct intel_uncore_discovery_unit, node);
+
+	if (die < 0)
+		return unit;
+
+	for (; pos; pos = rb_next(pos)) {
+		unit = rb_entry(pos, struct intel_uncore_discovery_unit, node);
+
+		if (unit->pmu_idx != pmu_idx)
+			break;
+
+		if (unit->die == die)
+			return unit;
+	}
+
+	return NULL;
+}
+
+int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
+					unsigned int pmu_idx)
+{
+	struct intel_uncore_discovery_unit *unit;
+
+	unit = intel_uncore_find_discovery_unit(units, die, pmu_idx);
+	if (unit)
+		return unit->id;
+
+	return -1;
+}
+
 static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct intel_uncore_discovery_unit *a_node, *b_node;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 5190017..96265cf 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -166,3 +166,6 @@ u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
 
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra);
+
+int intel_uncore_find_discovery_unit_id(struct rb_root *units, int die,
+					unsigned int pmu_idx);

