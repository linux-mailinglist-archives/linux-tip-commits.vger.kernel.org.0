Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024ED18CE46
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Mar 2020 13:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCTM7H (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Mar 2020 08:59:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgCTM6N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDs-0003gv-W5; Fri, 20 Mar 2020 13:58:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7D6801C22BE;
        Fri, 20 Mar 2020 13:58:00 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:00 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Ice Lake server uncore support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584470314-46657-3-git-send-email-kan.liang@linux.intel.com>
References: <1584470314-46657-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158470908016.28353.17254812260511143808.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b1a032f147e1013d82555a39f0fdb5967bd5ffce
Gitweb:        https://git.kernel.org/tip/b1a032f147e1013d82555a39f0fdb5967bd5ffce
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 17 Mar 2020 11:38:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:23 +01:00

perf/x86/intel/uncore: Add Ice Lake server uncore support

The uncore subsystem in Ice Lake server is similar to previous server.
There are some differences in config register encoding and pci device
IDs. The uncore PMON units in Ice Lake server include Ubox, Chabox, IIO,
IRP, M2PCIE, PCU, M2M, PCIE3 and IMC.

- For CHA, filter 1 register has been removed. The filter 0 register can
  be used by and of CHA events to be filterd by Thread/Core-ID. To do
  so, the control register's tid_en bit must be set to 1.
- For IIO, there are some changes on event constraints. The MSR address
  and MSR offsets among counters are also changed.
- For IRP, the MSR address and MSR offsets among counters are changed.
- For M2PCIE, the counters are accessed by MSR now. Add new MSR address
  and MSR offsets. Change event constraints.
- To determine the number of CHAs, have to read CAPID6(Low) and CAPID7
  (High) now.
- For M2M, update the PCICFG address and Device ID.
- For UPI, update the PCICFG address, Device ID and counter address.
- For M3UPI, update the PCICFG address, Device ID, counter address and
  event constraints.
- For IMC, update the formular to calculate MMIO BAR address, which is
  MMIO_BASE + specific MEM_BAR offset.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1584470314-46657-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c       |   8 +-
 arch/x86/events/intel/uncore.h       |   3 +-
 arch/x86/events/intel/uncore_snbep.c | 503 ++++++++++++++++++++++++++-
 3 files changed, 514 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 63922e3..fd2dc0f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1480,6 +1480,12 @@ static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
+	.cpu_init = icx_uncore_cpu_init,
+	.pci_init = icx_uncore_pci_init,
+	.mmio_init = icx_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 	.cpu_init = snr_uncore_cpu_init,
 	.pci_init = snr_uncore_pci_init,
@@ -1515,6 +1521,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_D,	  icx_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_X,	  icx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_TIGERLAKE_L,	  tgl_l_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_TIGERLAKE,	  tgl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_D, snr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index b30429f..0da4a46 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -550,6 +550,9 @@ void skx_uncore_cpu_init(void);
 int snr_uncore_pci_init(void);
 void snr_uncore_cpu_init(void);
 void snr_uncore_mmio_init(void);
+int icx_uncore_pci_init(void);
+void icx_uncore_cpu_init(void);
+void icx_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 01023f0..7281ef5 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -382,6 +382,36 @@
 #define SNR_IMC_MMIO_MEM0_OFFSET		0xd8
 #define SNR_IMC_MMIO_MEM0_MASK			0x7FF
 
+/* ICX IIO */
+#define ICX_IIO_MSR_PMON_CTL0			0xa58
+#define ICX_IIO_MSR_PMON_CTR0			0xa51
+#define ICX_IIO_MSR_PMON_BOX_CTL		0xa50
+
+/* ICX IRP */
+#define ICX_IRP0_MSR_PMON_CTL0			0xa4d
+#define ICX_IRP0_MSR_PMON_CTR0			0xa4b
+#define ICX_IRP0_MSR_PMON_BOX_CTL		0xa4a
+
+/* ICX M2PCIE */
+#define ICX_M2PCIE_MSR_PMON_CTL0		0xa46
+#define ICX_M2PCIE_MSR_PMON_CTR0		0xa41
+#define ICX_M2PCIE_MSR_PMON_BOX_CTL		0xa40
+
+/* ICX UPI */
+#define ICX_UPI_PCI_PMON_CTL0			0x350
+#define ICX_UPI_PCI_PMON_CTR0			0x320
+#define ICX_UPI_PCI_PMON_BOX_CTL		0x318
+#define ICX_UPI_CTL_UMASK_EXT			0xffffff
+
+/* ICX M3UPI*/
+#define ICX_M3UPI_PCI_PMON_CTL0			0xd8
+#define ICX_M3UPI_PCI_PMON_CTR0			0xa8
+#define ICX_M3UPI_PCI_PMON_BOX_CTL		0xa0
+
+/* ICX IMC */
+#define ICX_NUMBER_IMC_CHN			2
+#define ICX_IMC_MEM_STRIDE			0x4
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
@@ -390,6 +420,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -4551,3 +4582,475 @@ void snr_uncore_mmio_init(void)
 }
 
 /* end of SNR uncore support */
+
+/* ICX uncore support */
+
+static unsigned icx_cha_msr_offsets[] = {
+	0x0,   0xe,   0x1c,  0x2a,  0x38,  0x46,  0x54,  0x62,  0x70,
+	0x7e,  0x8c,  0x9a,  0xa8,  0xb6,  0xc4,  0xd2,  0xe0,  0xee,
+	0x10a, 0x118, 0x126, 0x134, 0x142, 0x150, 0x15e, 0x16c, 0x17a,
+	0x188,
+};
+
+static int icx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
+	bool tie_en = !!(event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN);
+
+	if (tie_en) {
+		reg1->reg = HSWEP_C0_MSR_PMON_BOX_FILTER0 +
+			    icx_cha_msr_offsets[box->pmu->pmu_idx];
+		reg1->config = event->attr.config1 & SKX_CHA_MSR_PMON_BOX_FILTER_TID;
+		reg1->idx = 0;
+	}
+
+	return 0;
+}
+
+static struct intel_uncore_ops icx_uncore_chabox_ops = {
+	.init_box		= ivbep_uncore_msr_init_box,
+	.disable_box		= snbep_uncore_msr_disable_box,
+	.enable_box		= snbep_uncore_msr_enable_box,
+	.disable_event		= snbep_uncore_msr_disable_event,
+	.enable_event		= snr_cha_enable_event,
+	.read_counter		= uncore_msr_read_counter,
+	.hw_config		= icx_cha_hw_config,
+};
+
+static struct intel_uncore_type icx_uncore_chabox = {
+	.name			= "cha",
+	.num_counters		= 4,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= HSWEP_C0_MSR_PMON_CTL0,
+	.perf_ctr		= HSWEP_C0_MSR_PMON_CTR0,
+	.box_ctl		= HSWEP_C0_MSR_PMON_BOX_CTL,
+	.msr_offsets		= icx_cha_msr_offsets,
+	.event_mask		= HSWEP_S_MSR_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_CHA_RAW_EVENT_MASK_EXT,
+	.constraints		= skx_uncore_chabox_constraints,
+	.ops			= &icx_uncore_chabox_ops,
+	.format_group		= &snr_uncore_chabox_format_group,
+};
+
+static unsigned icx_msr_offsets[] = {
+	0x0, 0x20, 0x40, 0x90, 0xb0, 0xd0,
+};
+
+static struct event_constraint icx_uncore_iio_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x02, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x03, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x83, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type icx_uncore_iio = {
+	.name			= "iio",
+	.num_counters		= 4,
+	.num_boxes		= 6,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= ICX_IIO_MSR_PMON_CTL0,
+	.perf_ctr		= ICX_IIO_MSR_PMON_CTR0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.box_ctl		= ICX_IIO_MSR_PMON_BOX_CTL,
+	.msr_offsets		= icx_msr_offsets,
+	.constraints		= icx_uncore_iio_constraints,
+	.ops			= &skx_uncore_iio_ops,
+	.format_group		= &snr_uncore_iio_format_group,
+};
+
+static struct intel_uncore_type icx_uncore_irp = {
+	.name			= "irp",
+	.num_counters		= 2,
+	.num_boxes		= 6,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= ICX_IRP0_MSR_PMON_CTL0,
+	.perf_ctr		= ICX_IRP0_MSR_PMON_CTR0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl		= ICX_IRP0_MSR_PMON_BOX_CTL,
+	.msr_offsets		= icx_msr_offsets,
+	.ops			= &ivbep_uncore_msr_ops,
+	.format_group		= &ivbep_uncore_format_group,
+};
+
+static struct event_constraint icx_uncore_m2pcie_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type icx_uncore_m2pcie = {
+	.name		= "m2pcie",
+	.num_counters	= 4,
+	.num_boxes	= 6,
+	.perf_ctr_bits	= 48,
+	.event_ctl	= ICX_M2PCIE_MSR_PMON_CTL0,
+	.perf_ctr	= ICX_M2PCIE_MSR_PMON_CTR0,
+	.box_ctl	= ICX_M2PCIE_MSR_PMON_BOX_CTL,
+	.msr_offsets	= icx_msr_offsets,
+	.constraints	= icx_uncore_m2pcie_constraints,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.ops		= &ivbep_uncore_msr_ops,
+	.format_group	= &ivbep_uncore_format_group,
+};
+
+enum perf_uncore_icx_iio_freerunning_type_id {
+	ICX_IIO_MSR_IOCLK,
+	ICX_IIO_MSR_BW_IN,
+
+	ICX_IIO_FREERUNNING_TYPE_MAX,
+};
+
+static unsigned icx_iio_clk_freerunning_box_offsets[] = {
+	0x0, 0x20, 0x40, 0x90, 0xb0, 0xd0,
+};
+
+static unsigned icx_iio_bw_freerunning_box_offsets[] = {
+	0x0, 0x10, 0x20, 0x90, 0xa0, 0xb0,
+};
+
+static struct freerunning_counters icx_iio_freerunning[] = {
+	[ICX_IIO_MSR_IOCLK]	= { 0xa55, 0x1, 0x20, 1, 48, icx_iio_clk_freerunning_box_offsets },
+	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
+};
+
+static struct uncore_event_desc icx_uncore_iio_freerunning_events[] = {
+	/* Free-Running IIO CLOCKS Counter */
+	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
+	/* Free-Running IIO BANDWIDTH IN Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type icx_uncore_iio_free_running = {
+	.name			= "iio_free_running",
+	.num_counters		= 9,
+	.num_boxes		= 6,
+	.num_freerunning_types	= ICX_IIO_FREERUNNING_TYPE_MAX,
+	.freerunning		= icx_iio_freerunning,
+	.ops			= &skx_uncore_iio_freerunning_ops,
+	.event_descs		= icx_uncore_iio_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+static struct intel_uncore_type *icx_msr_uncores[] = {
+	&skx_uncore_ubox,
+	&icx_uncore_chabox,
+	&icx_uncore_iio,
+	&icx_uncore_irp,
+	&icx_uncore_m2pcie,
+	&skx_uncore_pcu,
+	&icx_uncore_iio_free_running,
+	NULL,
+};
+
+/*
+ * To determine the number of CHAs, it should read CAPID6(Low) and CAPID7 (High)
+ * registers which located at Device 30, Function 3
+ */
+#define ICX_CAPID6		0x9c
+#define ICX_CAPID7		0xa0
+
+static u64 icx_count_chabox(void)
+{
+	struct pci_dev *dev = NULL;
+	u64 caps = 0;
+
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x345b, dev);
+	if (!dev)
+		goto out;
+
+	pci_read_config_dword(dev, ICX_CAPID6, (u32 *)&caps);
+	pci_read_config_dword(dev, ICX_CAPID7, (u32 *)&caps + 1);
+out:
+	pci_dev_put(dev);
+	return hweight64(caps);
+}
+
+void icx_uncore_cpu_init(void)
+{
+	u64 num_boxes = icx_count_chabox();
+
+	if (WARN_ON(num_boxes > ARRAY_SIZE(icx_cha_msr_offsets)))
+		return;
+	uncore_msr_uncores = icx_msr_uncores;
+}
+
+static struct intel_uncore_type icx_uncore_m2m = {
+	.name		= "m2m",
+	.num_counters   = 4,
+	.num_boxes	= 4,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= SNR_M2M_PCI_PMON_CTR0,
+	.event_ctl	= SNR_M2M_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= SNR_M2M_PCI_PMON_BOX_CTL,
+	.ops		= &snr_m2m_uncore_pci_ops,
+	.format_group	= &skx_uncore_format_group,
+};
+
+static struct attribute *icx_upi_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext4.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	NULL,
+};
+
+static const struct attribute_group icx_upi_uncore_format_group = {
+	.name = "format",
+	.attrs = icx_upi_uncore_formats_attr,
+};
+
+static struct intel_uncore_type icx_uncore_upi = {
+	.name		= "upi",
+	.num_counters   = 4,
+	.num_boxes	= 3,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= ICX_UPI_PCI_PMON_CTR0,
+	.event_ctl	= ICX_UPI_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext = ICX_UPI_CTL_UMASK_EXT,
+	.box_ctl	= ICX_UPI_PCI_PMON_BOX_CTL,
+	.ops		= &skx_upi_uncore_pci_ops,
+	.format_group	= &icx_upi_uncore_format_group,
+};
+
+static struct event_constraint icx_uncore_m3upi_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x1c, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
+	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
+	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
+	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type icx_uncore_m3upi = {
+	.name		= "m3upi",
+	.num_counters   = 4,
+	.num_boxes	= 3,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= ICX_M3UPI_PCI_PMON_CTR0,
+	.event_ctl	= ICX_M3UPI_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= ICX_M3UPI_PCI_PMON_BOX_CTL,
+	.constraints	= icx_uncore_m3upi_constraints,
+	.ops		= &ivbep_uncore_pci_ops,
+	.format_group	= &skx_uncore_format_group,
+};
+
+enum {
+	ICX_PCI_UNCORE_M2M,
+	ICX_PCI_UNCORE_UPI,
+	ICX_PCI_UNCORE_M3UPI,
+};
+
+static struct intel_uncore_type *icx_pci_uncores[] = {
+	[ICX_PCI_UNCORE_M2M]		= &icx_uncore_m2m,
+	[ICX_PCI_UNCORE_UPI]		= &icx_uncore_upi,
+	[ICX_PCI_UNCORE_M3UPI]		= &icx_uncore_m3upi,
+	NULL,
+};
+
+static const struct pci_device_id icx_uncore_pci_ids[] = {
+	{ /* M2M 0 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(12, 0, ICX_PCI_UNCORE_M2M, 0),
+	},
+	{ /* M2M 1 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(13, 0, ICX_PCI_UNCORE_M2M, 1),
+	},
+	{ /* M2M 2 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(14, 0, ICX_PCI_UNCORE_M2M, 2),
+	},
+	{ /* M2M 3 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(15, 0, ICX_PCI_UNCORE_M2M, 3),
+	},
+	{ /* UPI Link 0 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3441),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(2, 1, ICX_PCI_UNCORE_UPI, 0),
+	},
+	{ /* UPI Link 1 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3441),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(3, 1, ICX_PCI_UNCORE_UPI, 1),
+	},
+	{ /* UPI Link 2 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3441),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 1, ICX_PCI_UNCORE_UPI, 2),
+	},
+	{ /* M3UPI Link 0 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3446),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(5, 1, ICX_PCI_UNCORE_M3UPI, 0),
+	},
+	{ /* M3UPI Link 1 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3446),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(6, 1, ICX_PCI_UNCORE_M3UPI, 1),
+	},
+	{ /* M3UPI Link 2 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3446),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(7, 1, ICX_PCI_UNCORE_M3UPI, 2),
+	},
+	{ /* end: all zeroes */ }
+};
+
+static struct pci_driver icx_uncore_pci_driver = {
+	.name		= "icx_uncore",
+	.id_table	= icx_uncore_pci_ids,
+};
+
+int icx_uncore_pci_init(void)
+{
+	/* ICX UBOX DID */
+	int ret = snbep_pci2phy_map_init(0x3450, SKX_CPUNODEID,
+					 SKX_GIDNIDMAP, true);
+
+	if (ret)
+		return ret;
+
+	uncore_pci_uncores = icx_pci_uncores;
+	uncore_pci_driver = &icx_uncore_pci_driver;
+	return 0;
+}
+
+static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
+{
+	unsigned int box_ctl = box->pmu->type->box_ctl +
+			       box->pmu->type->mmio_offset * (box->pmu->pmu_idx % ICX_NUMBER_IMC_CHN);
+	int mem_offset = (box->pmu->pmu_idx / ICX_NUMBER_IMC_CHN) * ICX_IMC_MEM_STRIDE +
+			 SNR_IMC_MMIO_MEM0_OFFSET;
+
+	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset);
+}
+
+static struct intel_uncore_ops icx_uncore_mmio_ops = {
+	.init_box	= icx_uncore_imc_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.disable_box	= snr_uncore_mmio_disable_box,
+	.enable_box	= snr_uncore_mmio_enable_box,
+	.disable_event	= snr_uncore_mmio_disable_event,
+	.enable_event	= snr_uncore_mmio_enable_event,
+	.read_counter	= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type icx_uncore_imc = {
+	.name		= "imc",
+	.num_counters   = 4,
+	.num_boxes	= 8,
+	.perf_ctr_bits	= 48,
+	.fixed_ctr_bits	= 48,
+	.fixed_ctr	= SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl	= SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.event_descs	= hswep_uncore_imc_events,
+	.perf_ctr	= SNR_IMC_MMIO_PMON_CTR0,
+	.event_ctl	= SNR_IMC_MMIO_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= SNR_IMC_MMIO_PMON_BOX_CTL,
+	.mmio_offset	= SNR_IMC_MMIO_OFFSET,
+	.ops		= &icx_uncore_mmio_ops,
+	.format_group	= &skx_uncore_format_group,
+};
+
+enum perf_uncore_icx_imc_freerunning_type_id {
+	ICX_IMC_DCLK,
+	ICX_IMC_DDR,
+	ICX_IMC_DDRT,
+
+	ICX_IMC_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters icx_imc_freerunning[] = {
+	[ICX_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
+	[ICX_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
+	[ICX_IMC_DDRT]	= { 0x22a0, 0x8, 0, 2, 48 },
+};
+
+static struct uncore_event_desc icx_uncore_imc_freerunning_events[] = {
+	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
+
+	INTEL_UNCORE_EVENT_DESC(read,			"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(read.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(read.unit,		"MiB"),
+	INTEL_UNCORE_EVENT_DESC(write,			"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(write.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(write.unit,		"MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(ddrt_read,		"event=0xff,umask=0x30"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_read.unit,		"MiB"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write,		"event=0xff,umask=0x31"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write.unit,	"MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+{
+	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE +
+			 SNR_IMC_MMIO_MEM0_OFFSET;
+
+	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box), mem_offset);
+}
+
+static struct intel_uncore_ops icx_uncore_imc_freerunning_ops = {
+	.init_box	= icx_uncore_imc_freerunning_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.read_counter	= uncore_mmio_read_counter,
+	.hw_config	= uncore_freerunning_hw_config,
+};
+
+static struct intel_uncore_type icx_uncore_imc_free_running = {
+	.name			= "imc_free_running",
+	.num_counters		= 5,
+	.num_boxes		= 4,
+	.num_freerunning_types	= ICX_IMC_FREERUNNING_TYPE_MAX,
+	.freerunning		= icx_imc_freerunning,
+	.ops			= &icx_uncore_imc_freerunning_ops,
+	.event_descs		= icx_uncore_imc_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+static struct intel_uncore_type *icx_mmio_uncores[] = {
+	&icx_uncore_imc,
+	&icx_uncore_imc_free_running,
+	NULL,
+};
+
+void icx_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = icx_mmio_uncores;
+}
+
+/* end of ICX uncore support */
