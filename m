Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA7388944
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244892AbhESIWp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244874AbhESIWp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:22:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEB2C06175F;
        Wed, 19 May 2021 01:21:25 -0700 (PDT)
Date:   Wed, 19 May 2021 08:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621412484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TuMeWIBsEaLm7YqwmeltE63dviyyjNSrJlKRHqkwPc=;
        b=vUToMX/AfAVBdgt8Ippz1HMFBBF5o3nqXTyON3dtcJMA8QkgeN0LqwEvZPt1AeYzCXgVY6
        cQenLLjho9oSqZsLSrMXivUKIABfcQ9XnjHVxaRs3w2dL3mzkAc0y0RZ+wK/fJ+I8z00+J
        T+EkS1wa8Y0+DG+0lQRH6qNLqVydo3PneGsnmggkvpOI1x0Tf4NYE0QznKecVd8T36jJEf
        WLEhrDTB6EBchZs89Q8IySuHufgdAkrx+g+HHGqryjXp07f1EBLNyQrgMRsVA1cKKOUOf3
        5ESvEs4WlZACCGiCWxRw33Ezo2y6mOLAvradKv7nX2tNuwzL1qF4OG1DJ36Xpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621412484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TuMeWIBsEaLm7YqwmeltE63dviyyjNSrJlKRHqkwPc=;
        b=F+q27nV0AtQRblr2b/MyHakTS/RpjG+0RdZFKtmPprdJPWtPjtnV21BnBUbxTDvKt4YYSr
        hx7DBEErkaitUzCQ==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Enable I/O stacks to IIO PMON
 mapping on SNR
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210426131614.16205-3-alexander.antonov@linux.intel.com>
References: <20210426131614.16205-3-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162141248321.29796.7409433684560628383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c1777be3646b48f6638d8339ad270a27659adaa4
Gitweb:        https://git.kernel.org/tip/c1777be3646b48f6638d8339ad270a27659adaa4
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 26 Apr 2021 16:16:13 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:57 +02:00

perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR

I/O stacks to PMON mapping on Skylake server relies on topology information
from CPU_BUS_NO MSR but this approach is not applicable for SNR and ICX.
Mapping on these platforms can be gotten by reading SAD_CONTROL_CFG CSR
from Mesh2IIO device with 0x09a2 DID.
SAD_CONTROL_CFG CSR contains stack IDs in its own notation which are
statically mapped on IDs in PMON notation.

The map for Snowridge:

Stack Name         | CBDMA/DMI | PCIe Gen 3 | DLB | NIS | QAT
SAD_CONTROL_CFG ID |     0     |      1     |  2  |  3  |  4
PMON ID            |     1     |      4     |  3  |  2  |  0

This patch enables I/O stacks to IIO PMON mapping on Snowridge.
Mapping is exposed through attributes /sys/devices/uncore_iio_<pmu_idx>/dieX,
where dieX is file which holds "Segment:Root Bus" for PCIe root port which
can be monitored by that IIO PMON block. Example for Snowridge:

==> /sys/devices/uncore_iio_0/die0 <==
0000:f3
==> /sys/devices/uncore_iio_1/die0 <==
0000:00
==> /sys/devices/uncore_iio_2/die0 <==
0000:eb
==> /sys/devices/uncore_iio_3/die0 <==
0000:e3
==> /sys/devices/uncore_iio_4/die0 <==
0000:14

Mapping for Icelake server will be enabled in the follow-up patch.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20210426131614.16205-3-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 96 +++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 02e36a3..b50c946 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -348,6 +348,13 @@
 #define SKX_M2M_PCI_PMON_CTR0		0x200
 #define SKX_M2M_PCI_PMON_BOX_CTL	0x258
 
+/* Memory Map registers device ID */
+#define SNR_ICX_MESH2IIO_MMAP_DID		0x9a2
+#define SNR_ICX_SAD_CONTROL_CFG		0x3f4
+
+/* Getting I/O stack id in SAD_COTROL_CFG notation */
+#define SAD_CONTROL_STACK_ID(data)		(((data) >> 4) & 0x7)
+
 /* SNR Ubox */
 #define SNR_U_MSR_PMON_CTR0			0x1f98
 #define SNR_U_MSR_PMON_CTL0			0x1f91
@@ -4405,6 +4412,91 @@ static const struct attribute_group snr_uncore_iio_format_group = {
 	.attrs = snr_uncore_iio_formats_attr,
 };
 
+static umode_t
+snr_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	/* Root bus 0x00 is valid only for pmu_idx = 1. */
+	return pmu_iio_mapping_visible(kobj, attr, die, 1);
+}
+
+static struct attribute_group snr_iio_mapping_group = {
+	.is_visible	= snr_iio_mapping_visible,
+};
+
+static const struct attribute_group *snr_iio_attr_update[] = {
+	&snr_iio_mapping_group,
+	NULL,
+};
+
+static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_mapping)
+{
+	u32 sad_cfg;
+	int die, stack_id, ret = -EPERM;
+	struct pci_dev *dev = NULL;
+
+	type->topology = kcalloc(uncore_max_dies(), sizeof(*type->topology),
+				 GFP_KERNEL);
+	if (!type->topology)
+		return -ENOMEM;
+
+	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, SNR_ICX_MESH2IIO_MMAP_DID, dev))) {
+		ret = pci_read_config_dword(dev, SNR_ICX_SAD_CONTROL_CFG, &sad_cfg);
+		if (ret) {
+			ret = pcibios_err_to_errno(ret);
+			break;
+		}
+
+		die = uncore_pcibus_to_dieid(dev->bus);
+		stack_id = SAD_CONTROL_STACK_ID(sad_cfg);
+		if (die < 0 || stack_id >= type->num_boxes) {
+			ret = -EPERM;
+			break;
+		}
+
+		/* Convert stack id from SAD_CONTROL to PMON notation. */
+		stack_id = sad_pmon_mapping[stack_id];
+
+		((u8 *)&(type->topology[die].configuration))[stack_id] = dev->bus->number;
+		type->topology[die].segment = pci_domain_nr(dev->bus);
+	}
+
+	if (ret) {
+		kfree(type->topology);
+		type->topology = NULL;
+	}
+
+	return ret;
+}
+
+/*
+ * SNR has a static mapping of stack IDs from SAD_CONTROL_CFG notation to PMON
+ */
+enum {
+	SNR_QAT_PMON_ID,
+	SNR_CBDMA_DMI_PMON_ID,
+	SNR_NIS_PMON_ID,
+	SNR_DLB_PMON_ID,
+	SNR_PCIE_GEN3_PMON_ID
+};
+
+static u8 snr_sad_pmon_mapping[] = {
+	SNR_CBDMA_DMI_PMON_ID,
+	SNR_PCIE_GEN3_PMON_ID,
+	SNR_DLB_PMON_ID,
+	SNR_NIS_PMON_ID,
+	SNR_QAT_PMON_ID
+};
+
+static int snr_iio_get_topology(struct intel_uncore_type *type)
+{
+	return sad_cfg_iio_topology(type, snr_sad_pmon_mapping);
+}
+
+static int snr_iio_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_iio_set_mapping(type, &snr_iio_mapping_group);
+}
+
 static struct intel_uncore_type snr_uncore_iio = {
 	.name			= "iio",
 	.num_counters		= 4,
@@ -4418,6 +4510,10 @@ static struct intel_uncore_type snr_uncore_iio = {
 	.msr_offset		= SNR_IIO_MSR_OFFSET,
 	.ops			= &ivbep_uncore_msr_ops,
 	.format_group		= &snr_uncore_iio_format_group,
+	.attr_update		= snr_iio_attr_update,
+	.get_topology		= snr_iio_get_topology,
+	.set_mapping		= snr_iio_set_mapping,
+	.cleanup_mapping	= skx_iio_cleanup_mapping,
 };
 
 static struct intel_uncore_type snr_uncore_irp = {
