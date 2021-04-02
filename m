Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86295352737
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Apr 2021 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhDBIMo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Apr 2021 04:12:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36402 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhDBIMn (ORCPT
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
        bh=JFNkzJhprrvST0Ka6tlqiMl8VeVywkUQWHBwgVFVs30=;
        b=G1dZTtq2bK3IpJueYJpdpfqls6JjV+7lA43qngugVCuNgT3MTBBiVWin9t9Kyfa9cOn+Jb
        MT3bMD6E/3x1EatiPOuXoNfQDxT/UxOl3AQSS1OSFoxPmx++vfIpgjcmQdOik7M3USyBSz
        X3vSQ45IC3ttVr7kGzQahFmoGHxV1UFQXF46m8OCVele3RBa3OyuGOdURPfMIiMbKOfIGI
        v964pIqAPdTch17XrNLsDtJijn9V6HSVOJ3ASOBTVuBYNZ3pr0beM/yHTdyrRhwvSSA0Lt
        K3WaF+ysqFx0H3XVtGG+EAXgBe5tWJkwWmpIUxs1qqD3MZLSKF5nMxpvvtgwZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617351162;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFNkzJhprrvST0Ka6tlqiMl8VeVywkUQWHBwgVFVs30=;
        b=3s/HsLUjFoLcDzsOXfXdqk3VHZVm0sYXRcQsNiI2m8zCrl0ZpvvXNZPB4br1DQZtFkWlR8
        2gBVq59Hnjvtc9CQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generic support for the MMIO
 type of uncore blocks
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1616003977-90612-6-git-send-email-kan.liang@linux.intel.com>
References: <1616003977-90612-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161735116180.29796.17129715669203589919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c4c55e362a521d763356b9e02bc9a4348c71a471
Gitweb:        https://git.kernel.org/tip/c4c55e362a521d763356b9e02bc9a4348c71a471
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 17 Mar 2021 10:59:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Apr 2021 10:04:55 +02:00

perf/x86/intel/uncore: Generic support for the MMIO type of uncore blocks

The discovery table provides the generic uncore block information
for the MMIO type of uncore blocks, which is good enough to provide
basic uncore support.

The box control field is composed of the BAR address and box control
offset. When initializing the uncore blocks, perf should ioremap the
address from the box control field.

Implement the generic support for the MMIO type of uncore block.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1616003977-90612-6-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |  1 +-
 arch/x86/events/intel/uncore.h           |  1 +-
 arch/x86/events/intel/uncore_discovery.c | 98 +++++++++++++++++++++++-
 arch/x86/events/intel/uncore_discovery.h |  1 +-
 4 files changed, 101 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3109082..35b3470 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1755,6 +1755,7 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
+	.mmio_init = intel_uncore_generic_uncore_mmio_init,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 76fc898..549cfb2 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -70,6 +70,7 @@ struct intel_uncore_type {
 	union {
 		unsigned *msr_offsets;
 		unsigned *pci_offsets;
+		unsigned *mmio_offsets;
 	};
 	unsigned *box_ids;
 	struct event_constraint unconstrainted;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 784d7b4..aba9bff 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -442,6 +442,90 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
 	.read_counter	= intel_generic_uncore_pci_read_counter,
 };
 
+#define UNCORE_GENERIC_MMIO_SIZE		0x4000
+
+static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
+{
+	struct intel_uncore_type *type = box->pmu->type;
+
+	if (!type->box_ctls || !type->box_ctls[box->dieid] || !type->mmio_offsets)
+		return 0;
+
+	return type->box_ctls[box->dieid] + type->mmio_offsets[box->pmu->pmu_idx];
+}
+
+static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
+{
+	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
+	struct intel_uncore_type *type = box->pmu->type;
+	resource_size_t addr;
+
+	if (!box_ctl) {
+		pr_warn("Uncore type %d box %d: Invalid box control address.\n",
+			type->type_id, type->box_ids[box->pmu->pmu_idx]);
+		return;
+	}
+
+	addr = box_ctl;
+	box->io_addr = ioremap(addr, UNCORE_GENERIC_MMIO_SIZE);
+	if (!box->io_addr) {
+		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
+			type->type_id, type->box_ids[box->pmu->pmu_idx],
+			(unsigned long long)addr);
+		return;
+	}
+
+	writel(GENERIC_PMON_BOX_CTL_INT, box->io_addr);
+}
+
+static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
+{
+	if (!box->io_addr)
+		return;
+
+	writel(GENERIC_PMON_BOX_CTL_FRZ, box->io_addr);
+}
+
+static void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
+{
+	if (!box->io_addr)
+		return;
+
+	writel(0, box->io_addr);
+}
+
+static void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	writel(hwc->config, box->io_addr + hwc->config_base);
+}
+
+static void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					      struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	writel(0, box->io_addr + hwc->config_base);
+}
+
+static struct intel_uncore_ops generic_uncore_mmio_ops = {
+	.init_box	= intel_generic_uncore_mmio_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.disable_box	= intel_generic_uncore_mmio_disable_box,
+	.enable_box	= intel_generic_uncore_mmio_enable_box,
+	.disable_event	= intel_generic_uncore_mmio_disable_event,
+	.enable_event	= intel_generic_uncore_mmio_enable_event,
+	.read_counter	= uncore_mmio_read_counter,
+};
+
 static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 				      struct intel_uncore_type *uncore,
 				      struct intel_uncore_discovery_type *type)
@@ -468,6 +552,15 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctls = type->box_ctrl_die;
 		uncore->pci_offsets = type->box_offset;
 		break;
+	case UNCORE_ACCESS_MMIO:
+		uncore->ops = &generic_uncore_mmio_ops;
+		uncore->perf_ctr = (unsigned int)type->ctr_offset;
+		uncore->event_ctl = (unsigned int)type->ctl_offset;
+		uncore->box_ctl = (unsigned int)type->box_ctrl;
+		uncore->box_ctls = type->box_ctrl_die;
+		uncore->mmio_offsets = type->box_offset;
+		uncore->mmio_map_size = UNCORE_GENERIC_MMIO_SIZE;
+		break;
 	default:
 		return false;
 	}
@@ -522,3 +615,8 @@ int intel_uncore_generic_uncore_pci_init(void)
 
 	return 0;
 }
+
+void intel_uncore_generic_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MMIO);
+}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 1639ff7..1d65293 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -128,3 +128,4 @@ bool intel_uncore_has_discovery_tables(void);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
+void intel_uncore_generic_uncore_mmio_init(void);
