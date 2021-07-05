Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA82A3BB85D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGEH43 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhGEH4Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:24 -0400
Date:   Mon, 05 Jul 2021 07:53:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IepKQppohduOWRaKTKFgDuBLYR75zY/IZdyVXiCWBG8=;
        b=Y9VMb2NsdR+5sLppkrHyxh5gnjQMzqhrzBRv8qgXruX8qpmU5JjQjnQissZvV7/XR/26ue
        moNoOQxjEPc9FnKh6IbZERr2hBzp6SZkjI2XWBZZJP3KdtSIr/9Uz9YeRmK15QdjF07/lu
        PNzGwTvi873Na46zYYr/09V229V/86cXWHaZYDieyZAiEt9OuKsMqNZYMOsylJrwpe4D9P
        RVL1CDgjgRj5F2fyJczYnIwIZwHOiTsUDXbI5Q/hT5311iZi7+c1VFMHcJOwstVXN0GFj8
        nKaEdY82VsQkWpHpZqgi7XUrulA4qOwmeXgIid9kI9+N3apvQRwwPR1GA/ZxoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IepKQppohduOWRaKTKFgDuBLYR75zY/IZdyVXiCWBG8=;
        b=hePsEAa5rpP1J9/vxCI2UeudQEAJ8Pb2y4tdt/2TVWCgygjae6XWMBgjhupLSgKtZDaX1n
        ge/6NJlHT+GzGlCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 CHA support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-3-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162661.395.5414920770004040891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     949b11381f81664df3997db2ae0ec9546ab6dd85
Gitweb:        https://git.kernel.org/tip/949b11381f81664df3997db2ae0ec9546ab6dd85
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:26 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:37 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server CHA support

CHA merges the caching agent and Home Agent (HA) responsibilities of the
chip into a single block. It's one of the Sapphire Rapids server uncore
units.

The layout of the control registers for a CHA uncore unit is a little
bit different from the generic one. The CHA uncore unit also supports a
filter register for TID. So a specific format and ops are required.
Expose the common MSR ops which can be reused.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c |  6 +-
 arch/x86/events/intel/uncore_discovery.h |  4 +-
 arch/x86/events/intel/uncore_snbep.c     | 90 ++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 93148e2..25f1c01 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -337,17 +337,17 @@ static const struct attribute_group generic_uncore_format_group = {
 	.attrs = generic_uncore_formats_attr,
 };
 
-static void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
 }
 
-static void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
 	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
 }
 
-static void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrl(uncore_msr_box_ctl(box), 0);
 }
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index d7ccc8a..e836a68 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -130,5 +130,9 @@ void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
 void intel_uncore_generic_uncore_mmio_init(void);
 
+void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
+
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index c100616..8a470d2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -455,6 +455,17 @@
 #define ICX_NUMBER_IMC_CHN			2
 #define ICX_IMC_MEM_STRIDE			0x4
 
+/* SPR */
+#define SPR_RAW_EVENT_MASK_EXT			0xffffff
+
+/* SPR CHA */
+#define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
+#define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
+						 SPR_CHA_PMON_CTL_TID_EN)
+#define SPR_CHA_PMON_BOX_FILTER_TID		0x3ff
+
+#define SPR_C0_MSR_PMON_BOX_FILTER0		0x200e
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
@@ -467,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
+DEFINE_UNCORE_FORMAT_ATTR(tid_en2, tid_en, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(thresh9, thresh, "config:24-35");
 DEFINE_UNCORE_FORMAT_ATTR(thresh8, thresh, "config:24-31");
@@ -5508,10 +5520,86 @@ void icx_uncore_mmio_init(void)
 
 /* SPR uncore support */
 
+static void spr_uncore_msr_enable_event(struct intel_uncore_box *box,
+					struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
+
+	if (reg1->idx != EXTRA_REG_NONE)
+		wrmsrl(reg1->reg, reg1->config);
+
+	wrmsrl(hwc->config_base, hwc->config);
+}
+
+static void spr_uncore_msr_disable_event(struct intel_uncore_box *box,
+					 struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
+
+	if (reg1->idx != EXTRA_REG_NONE)
+		wrmsrl(reg1->reg, 0);
+
+	wrmsrl(hwc->config_base, 0);
+}
+
+static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
+	bool tie_en = !!(event->hw.config & SPR_CHA_PMON_CTL_TID_EN);
+	struct intel_uncore_type *type = box->pmu->type;
+
+	if (tie_en) {
+		reg1->reg = SPR_C0_MSR_PMON_BOX_FILTER0 +
+			    HSWEP_CBO_MSR_OFFSET * type->box_ids[box->pmu->pmu_idx];
+		reg1->config = event->attr.config1 & SPR_CHA_PMON_BOX_FILTER_TID;
+		reg1->idx = 0;
+	}
+
+	return 0;
+}
+
+static struct intel_uncore_ops spr_uncore_chabox_ops = {
+	.init_box		= intel_generic_uncore_msr_init_box,
+	.disable_box		= intel_generic_uncore_msr_disable_box,
+	.enable_box		= intel_generic_uncore_msr_enable_box,
+	.disable_event		= spr_uncore_msr_disable_event,
+	.enable_event		= spr_uncore_msr_enable_event,
+	.read_counter		= uncore_msr_read_counter,
+	.hw_config		= spr_cha_hw_config,
+	.get_constraint		= uncore_get_constraint,
+	.put_constraint		= uncore_put_constraint,
+};
+
+static struct attribute *spr_uncore_cha_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext4.attr,
+	&format_attr_tid_en2.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	&format_attr_filter_tid5.attr,
+	NULL,
+};
+static const struct attribute_group spr_uncore_chabox_format_group = {
+	.name = "format",
+	.attrs = spr_uncore_cha_formats_attr,
+};
+
+static struct intel_uncore_type spr_uncore_chabox = {
+	.name			= "cha",
+	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
+	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.num_shared_regs	= 1,
+	.ops			= &spr_uncore_chabox_ops,
+	.format_group		= &spr_uncore_chabox_format_group,
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
-	NULL,
+	&spr_uncore_chabox,
 	NULL,
 	NULL,
 	NULL,
