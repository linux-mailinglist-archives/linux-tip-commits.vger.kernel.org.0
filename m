Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D040435273E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Apr 2021 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhDBIMz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Apr 2021 04:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhDBIMw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 2 Apr 2021 04:12:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4973DC061788;
        Fri,  2 Apr 2021 01:12:51 -0700 (PDT)
Date:   Fri, 02 Apr 2021 08:12:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617351163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNpEGMVzlGoeqSVQLQPbNld84/aB2mFfT0hYJhCiNY0=;
        b=bFIdbtjUaRkse5MG8fVRaLbvw48BuZo40X7b4bmh5VU4jRUBldkw6IExahxoDOCWgNftzA
        Ix9kKQ/7kvmOs2Wx8UGL8hPYlFXzqu58hxI3nBhrFhm0wwq4Kh9yGYfGjxdjLERiTHBwPK
        CI9oQIbnFxPMPgS8Kt0Am8MvZ/3Hr/7hiMTyomKemhbOEstx6rh4NfzdY+3OenKF/8GwgA
        G3NPllAy0+sLtjiDmiDIA8xx7C4cs4trEEVCY1bPyDvSe+xUwdhysuPCJ8HX0RCxLMPlJU
        e4nD/vxHTLazruRw1KOzmsj4ZyphvgJaIZ1Tz2Jj/UCJpVUNUApRIJlOxznFcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617351163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNpEGMVzlGoeqSVQLQPbNld84/aB2mFfT0hYJhCiNY0=;
        b=K0Ya8I1QkqfGMTjDdzCHES36uElyL+kYhzorgTVX3vC1LYmnQeVYzXXxem/40adSpRdUix
        BGN0U8R1PRoNX4CQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generic support for the MSR
 type of uncore blocks
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1616003977-90612-3-git-send-email-kan.liang@linux.intel.com>
References: <1616003977-90612-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161735116277.29796.8741605742450643961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d6c754130435ab786711bed75d04a2388a6b4da8
Gitweb:        https://git.kernel.org/tip/d6c754130435ab786711bed75d04a2388a6b4da8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 17 Mar 2021 10:59:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Apr 2021 10:04:54 +02:00

perf/x86/intel/uncore: Generic support for the MSR type of uncore blocks

The discovery table provides the generic uncore block information for
the MSR type of uncore blocks, e.g., the counter width, the number of
counters, the location of control/counter registers, which is good
enough to provide basic uncore support. It can be used as a fallback
solution when the kernel doesn't support a platform.

The name of the uncore box cannot be retrieved from the discovery table.
uncore_type_&typeID_&boxID will be used as its name. Save the type ID
and the box ID information in the struct intel_uncore_type.
Factor out uncore_get_pmu_name() to handle different naming methods.

Implement generic support for the MSR type of uncore block.

Some advanced features, such as filters and constraints, cannot be
retrieved from discovery tables. Features that rely on that
information are not be supported here.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1616003977-90612-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |  45 ++++++--
 arch/x86/events/intel/uncore.h           |   3 +-
 arch/x86/events/intel/uncore_discovery.c | 126 ++++++++++++++++++++++-
 arch/x86/events/intel/uncore_discovery.h |  18 +++-
 4 files changed, 182 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d111370..dabc01f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -10,7 +10,7 @@ static bool uncore_no_discover;
 module_param(uncore_no_discover, bool, 0);
 MODULE_PARM_DESC(uncore_no_discover, "Don't enable the Intel uncore PerfMon discovery mechanism "
 				     "(default: enable the discovery mechanism).");
-static struct intel_uncore_type *empty_uncore[] = { NULL, };
+struct intel_uncore_type *empty_uncore[] = { NULL, };
 struct intel_uncore_type **uncore_msr_uncores = empty_uncore;
 struct intel_uncore_type **uncore_pci_uncores = empty_uncore;
 struct intel_uncore_type **uncore_mmio_uncores = empty_uncore;
@@ -834,6 +834,34 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
+{
+	struct intel_uncore_type *type = pmu->type;
+
+	/*
+	 * No uncore block name in discovery table.
+	 * Use uncore_type_&typeid_&boxid as name.
+	 */
+	if (!type->name) {
+		if (type->num_boxes == 1)
+			sprintf(pmu->name, "uncore_type_%u", type->type_id);
+		else {
+			sprintf(pmu->name, "uncore_type_%u_%d",
+				type->type_id, type->box_ids[pmu->pmu_idx]);
+		}
+		return;
+	}
+
+	if (type->num_boxes == 1) {
+		if (strlen(type->name) > 0)
+			sprintf(pmu->name, "uncore_%s", type->name);
+		else
+			sprintf(pmu->name, "uncore");
+	} else
+		sprintf(pmu->name, "uncore_%s_%d", type->name, pmu->pmu_idx);
+
+}
+
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 {
 	int ret;
@@ -860,15 +888,7 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 		pmu->pmu.attr_update = pmu->type->attr_update;
 	}
 
-	if (pmu->type->num_boxes == 1) {
-		if (strlen(pmu->type->name) > 0)
-			sprintf(pmu->name, "uncore_%s", pmu->type->name);
-		else
-			sprintf(pmu->name, "uncore");
-	} else {
-		sprintf(pmu->name, "uncore_%s_%d", pmu->type->name,
-			pmu->pmu_idx);
-	}
+	uncore_get_pmu_name(pmu);
 
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (!ret)
@@ -909,6 +929,10 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 		kfree(type->pmus);
 		type->pmus = NULL;
 	}
+	if (type->box_ids) {
+		kfree(type->box_ids);
+		type->box_ids = NULL;
+	}
 	kfree(type->events_group);
 	type->events_group = NULL;
 }
@@ -1643,6 +1667,7 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 };
 
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
+	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index a3c6e16..05c8e06 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -50,6 +50,7 @@ struct intel_uncore_type {
 	int perf_ctr_bits;
 	int fixed_ctr_bits;
 	int num_freerunning_types;
+	int type_id;
 	unsigned perf_ctr;
 	unsigned event_ctl;
 	unsigned event_mask;
@@ -66,6 +67,7 @@ struct intel_uncore_type {
 	unsigned single_fixed:1;
 	unsigned pair_ctr_ctl:1;
 	unsigned *msr_offsets;
+	unsigned *box_ids;
 	struct event_constraint unconstrainted;
 	struct event_constraint *constraints;
 	struct intel_uncore_pmu *pmus;
@@ -547,6 +549,7 @@ uncore_get_constraint(struct intel_uncore_box *box, struct perf_event *event);
 void uncore_put_constraint(struct intel_uncore_box *box, struct perf_event *event);
 u64 uncore_shared_reg_config(struct intel_uncore_box *box, int idx);
 
+extern struct intel_uncore_type *empty_uncore[];
 extern struct intel_uncore_type **uncore_msr_uncores;
 extern struct intel_uncore_type **uncore_pci_uncores;
 extern struct intel_uncore_type **uncore_mmio_uncores;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 7519ce3..fefb3e2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -316,3 +316,129 @@ void intel_uncore_clear_discovery_tables(void)
 		kfree(type);
 	}
 }
+
+DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
+DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
+DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
+DEFINE_UNCORE_FORMAT_ATTR(thresh, thresh, "config:24-31");
+
+static struct attribute *generic_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh.attr,
+	NULL,
+};
+
+static const struct attribute_group generic_uncore_format_group = {
+	.name = "format",
+	.attrs = generic_uncore_formats_attr,
+};
+
+static void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
+}
+
+static void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
+{
+	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
+}
+
+static void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
+{
+	wrmsrl(uncore_msr_box_ctl(box), 0);
+}
+
+static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	wrmsrl(hwc->config_base, hwc->config);
+}
+
+static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	wrmsrl(hwc->config_base, 0);
+}
+
+static struct intel_uncore_ops generic_uncore_msr_ops = {
+	.init_box		= intel_generic_uncore_msr_init_box,
+	.disable_box		= intel_generic_uncore_msr_disable_box,
+	.enable_box		= intel_generic_uncore_msr_enable_box,
+	.disable_event		= intel_generic_uncore_msr_disable_event,
+	.enable_event		= intel_generic_uncore_msr_enable_event,
+	.read_counter		= uncore_msr_read_counter,
+};
+
+static bool uncore_update_uncore_type(enum uncore_access_type type_id,
+				      struct intel_uncore_type *uncore,
+				      struct intel_uncore_discovery_type *type)
+{
+	uncore->type_id = type->type;
+	uncore->num_boxes = type->num_boxes;
+	uncore->num_counters = type->num_counters;
+	uncore->perf_ctr_bits = type->counter_width;
+	uncore->box_ids = type->ids;
+
+	switch (type_id) {
+	case UNCORE_ACCESS_MSR:
+		uncore->ops = &generic_uncore_msr_ops;
+		uncore->perf_ctr = (unsigned int)type->box_ctrl + type->ctr_offset;
+		uncore->event_ctl = (unsigned int)type->box_ctrl + type->ctl_offset;
+		uncore->box_ctl = (unsigned int)type->box_ctrl;
+		uncore->msr_offsets = type->box_offset;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static struct intel_uncore_type **
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
+{
+	struct intel_uncore_discovery_type *type;
+	struct intel_uncore_type **uncores;
+	struct intel_uncore_type *uncore;
+	struct rb_node *node;
+	int i = 0;
+
+	uncores = kcalloc(num_discovered_types[type_id] + 1,
+			  sizeof(struct intel_uncore_type *), GFP_KERNEL);
+	if (!uncores)
+		return empty_uncore;
+
+	for (node = rb_first(&discovery_tables); node; node = rb_next(node)) {
+		type = rb_entry(node, struct intel_uncore_discovery_type, node);
+		if (type->access_type != type_id)
+			continue;
+
+		uncore = kzalloc(sizeof(struct intel_uncore_type), GFP_KERNEL);
+		if (!uncore)
+			break;
+
+		uncore->event_mask = GENERIC_PMON_RAW_EVENT_MASK;
+		uncore->format_group = &generic_uncore_format_group;
+
+		if (!uncore_update_uncore_type(type_id, uncore, type)) {
+			kfree(uncore);
+			continue;
+		}
+		uncores[i++] = uncore;
+	}
+
+	return uncores;
+}
+
+void intel_uncore_generic_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR);
+}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 95afa39..87078ba 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -28,6 +28,23 @@
 	 unit.table1 == -1ULL || unit.ctl == -1ULL ||	\
 	 unit.table3 == -1ULL)
 
+#define GENERIC_PMON_CTL_EV_SEL_MASK	0x000000ff
+#define GENERIC_PMON_CTL_UMASK_MASK	0x0000ff00
+#define GENERIC_PMON_CTL_EDGE_DET	(1 << 18)
+#define GENERIC_PMON_CTL_INVERT		(1 << 23)
+#define GENERIC_PMON_CTL_TRESH_MASK	0xff000000
+#define GENERIC_PMON_RAW_EVENT_MASK	(GENERIC_PMON_CTL_EV_SEL_MASK | \
+					 GENERIC_PMON_CTL_UMASK_MASK | \
+					 GENERIC_PMON_CTL_EDGE_DET | \
+					 GENERIC_PMON_CTL_INVERT | \
+					 GENERIC_PMON_CTL_TRESH_MASK)
+
+#define GENERIC_PMON_BOX_CTL_FRZ	(1 << 0)
+#define GENERIC_PMON_BOX_CTL_RST_CTRL	(1 << 8)
+#define GENERIC_PMON_BOX_CTL_RST_CTRS	(1 << 9)
+#define GENERIC_PMON_BOX_CTL_INT	(GENERIC_PMON_BOX_CTL_RST_CTRL | \
+					 GENERIC_PMON_BOX_CTL_RST_CTRS)
+
 enum uncore_access_type {
 	UNCORE_ACCESS_MSR	= 0,
 	UNCORE_ACCESS_MMIO,
@@ -103,3 +120,4 @@ struct intel_uncore_discovery_type {
 
 bool intel_uncore_has_discovery_tables(void);
 void intel_uncore_clear_discovery_tables(void);
+void intel_uncore_generic_uncore_cpu_init(void);
