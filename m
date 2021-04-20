Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4A365686
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhDTKrQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhDTKrO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:14 -0400
Date:   Tue, 20 Apr 2021 10:46:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1LDND5/AiqPN77eJ8353FZa2qTNsmxH8+ckB8wxVug=;
        b=Gv+L3IKRvk6k1nege9fBRmGM0jnzvgIk3n06bqGSg6pi45k18yTViLS27icJaTPmSPhotO
        cVSPoSvoky9RrW8RGWSFKIJR0xD/R/+Ivy4IMFshvcHSsbPZ6UHesnkzOVL+8emTd3k+5M
        cgMtxbgcVSFgkXfTdzBJU0mguIMb0LYXvTypXDWz20+uVY+g29Lb16uXcYdOX6XpslLA4S
        +16zeUTji22EGdU7LnJ99ZoMyyCqG4X1qv9qJxTGQLJVnXQLFptSYmS/CN6gpJvyQlnzhP
        qE4xWwBnPu9PcgaUBTlXq+iRexznq9JRYcuRSxbrMA5FdIt4+6cpUbQRV/ID+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1LDND5/AiqPN77eJ8353FZa2qTNsmxH8+ckB8wxVug=;
        b=C6DYeY2ZNZLPnjqp+56ULDhcGBhdURqJXAv2XoMnf7IcLhgnW1LrL0Q+6MRlJpPTJhdd3V
        BF3pSiE28ivXPlBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Alder Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-23-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-23-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560163.29796.2574440079089114826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     772ed05f3c5ce722b9de6c4c2dd87538a33fb8d3
Gitweb:        https://git.kernel.org/tip/772ed05f3c5ce722b9de6c4c2dd87538a33fb8d3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:31:02 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:29 +02:00

perf/x86/intel/uncore: Add Alder Lake support

The uncore subsystem for Alder Lake is similar to the previous Tiger
Lake.

The difference includes:
- New MSR addresses for global control, fixed counters, CBOX and ARB.
  Add a new adl_uncore_msr_ops for uncore operations.
- Add a new threshold field for CBOX.
- New PCIIDs for IMC devices.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-23-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |   7 +-
 arch/x86/events/intel/uncore.h     |   1 +-
 arch/x86/events/intel/uncore_snb.c | 131 ++++++++++++++++++++++++++++-
 3 files changed, 139 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a2b68bb..df7b07d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1752,6 +1752,11 @@ static const struct intel_uncore_init_fun rkl_uncore_init __initconst = {
 	.pci_init = skl_uncore_pci_init,
 };
 
+static const struct intel_uncore_init_fun adl_uncore_init __initconst = {
+	.cpu_init = adl_uncore_cpu_init,
+	.mmio_init = tgl_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1806,6 +1811,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_l_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 96569dc..2917910 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -582,6 +582,7 @@ void snb_uncore_cpu_init(void);
 void nhm_uncore_cpu_init(void);
 void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
+void adl_uncore_cpu_init(void);
 void tgl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 5127128..0f63706 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -62,6 +62,8 @@
 #define PCI_DEVICE_ID_INTEL_TGL_H_IMC		0x9a36
 #define PCI_DEVICE_ID_INTEL_RKL_1_IMC		0x4c43
 #define PCI_DEVICE_ID_INTEL_RKL_2_IMC		0x4c53
+#define PCI_DEVICE_ID_INTEL_ADL_1_IMC		0x4660
+#define PCI_DEVICE_ID_INTEL_ADL_2_IMC		0x4641
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -131,12 +133,33 @@
 #define ICL_UNC_ARB_PER_CTR			0x3b1
 #define ICL_UNC_ARB_PERFEVTSEL			0x3b3
 
+/* ADL uncore global control */
+#define ADL_UNC_PERF_GLOBAL_CTL			0x2ff0
+#define ADL_UNC_FIXED_CTR_CTRL                  0x2fde
+#define ADL_UNC_FIXED_CTR                       0x2fdf
+
+/* ADL Cbo register */
+#define ADL_UNC_CBO_0_PER_CTR0			0x2002
+#define ADL_UNC_CBO_0_PERFEVTSEL0		0x2000
+#define ADL_UNC_CTL_THRESHOLD			0x3f000000
+#define ADL_UNC_RAW_EVENT_MASK			(SNB_UNC_CTL_EV_SEL_MASK | \
+						 SNB_UNC_CTL_UMASK_MASK | \
+						 SNB_UNC_CTL_EDGE_DET | \
+						 SNB_UNC_CTL_INVERT | \
+						 ADL_UNC_CTL_THRESHOLD)
+
+/* ADL ARB register */
+#define ADL_UNC_ARB_PER_CTR0			0x2FD2
+#define ADL_UNC_ARB_PERFEVTSEL0			0x2FD0
+#define ADL_UNC_ARB_MSR_OFFSET			0x8
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(cmask5, cmask, "config:24-28");
 DEFINE_UNCORE_FORMAT_ATTR(cmask8, cmask, "config:24-31");
+DEFINE_UNCORE_FORMAT_ATTR(threshold, threshold, "config:24-29");
 
 /* Sandy Bridge uncore support */
 static void snb_uncore_msr_enable_event(struct intel_uncore_box *box, struct perf_event *event)
@@ -422,6 +445,106 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
+static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
+static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
+{
+	wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
+static void adl_uncore_msr_disable_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, 0);
+}
+
+static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, 0);
+}
+
+static struct intel_uncore_ops adl_uncore_msr_ops = {
+	.init_box	= adl_uncore_msr_init_box,
+	.enable_box	= adl_uncore_msr_enable_box,
+	.disable_box	= adl_uncore_msr_disable_box,
+	.exit_box	= adl_uncore_msr_exit_box,
+	.disable_event	= snb_uncore_msr_disable_event,
+	.enable_event	= snb_uncore_msr_enable_event,
+	.read_counter	= uncore_msr_read_counter,
+};
+
+static struct attribute *adl_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_threshold.attr,
+	NULL,
+};
+
+static const struct attribute_group adl_uncore_format_group = {
+	.name		= "format",
+	.attrs		= adl_uncore_formats_attr,
+};
+
+static struct intel_uncore_type adl_uncore_cbox = {
+	.name		= "cbox",
+	.num_counters   = 2,
+	.perf_ctr_bits	= 44,
+	.perf_ctr	= ADL_UNC_CBO_0_PER_CTR0,
+	.event_ctl	= ADL_UNC_CBO_0_PERFEVTSEL0,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	= ICL_UNC_CBO_MSR_OFFSET,
+	.ops		= &adl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
+static struct intel_uncore_type adl_uncore_arb = {
+	.name		= "arb",
+	.num_counters   = 2,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 44,
+	.perf_ctr	= ADL_UNC_ARB_PER_CTR0,
+	.event_ctl	= ADL_UNC_ARB_PERFEVTSEL0,
+	.event_mask	= SNB_UNC_RAW_EVENT_MASK,
+	.msr_offset	= ADL_UNC_ARB_MSR_OFFSET,
+	.constraints	= snb_uncore_arb_constraints,
+	.ops		= &adl_uncore_msr_ops,
+	.format_group	= &snb_uncore_format_group,
+};
+
+static struct intel_uncore_type adl_uncore_clockbox = {
+	.name		= "clock",
+	.num_counters	= 1,
+	.num_boxes	= 1,
+	.fixed_ctr_bits	= 48,
+	.fixed_ctr	= ADL_UNC_FIXED_CTR,
+	.fixed_ctl	= ADL_UNC_FIXED_CTR_CTRL,
+	.single_fixed	= 1,
+	.event_mask	= SNB_UNC_CTL_EV_SEL_MASK,
+	.format_group	= &icl_uncore_clock_format_group,
+	.ops		= &adl_uncore_msr_ops,
+	.event_descs	= icl_uncore_events,
+};
+
+static struct intel_uncore_type *adl_msr_uncores[] = {
+	&adl_uncore_cbox,
+	&adl_uncore_arb,
+	&adl_uncore_clockbox,
+	NULL,
+};
+
+void adl_uncore_cpu_init(void)
+{
+	adl_uncore_cbox.num_boxes = icl_get_cbox_num();
+	uncore_msr_uncores = adl_msr_uncores;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
@@ -1203,6 +1326,14 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_H_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ }
 };
 
