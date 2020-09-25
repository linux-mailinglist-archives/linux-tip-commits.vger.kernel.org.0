Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDE278714
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIYMX5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:23:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYMX4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:56 -0400
Date:   Fri, 25 Sep 2020 12:23:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hpy86rj6o8c+yABsbbZq30I4qb42npDGVVa5mdEkw2s=;
        b=E3iKG+MHGZqFT3XjLIJph3tIuLRrpTpkncW+x4WcM3RK0SHz+uLyGk9tk54el8yQOSseDa
        31kFpEdUkuv3t3lGnlZGEuMOPo4yQ0TiO3AaxKDK25pfqQMJKApDp0efbShQB2VWci8bHu
        y8I93XtJ8fhYO5Tc5xnEP72AeZD91y63j9lzVhKXgSpygzkHDaW560W8FHWF8MMBnBJFRo
        3YuulK/JSkX+uveCdyTFpkaKrVaMidd+oDCJNflWqTe/AGiGkjL8L+MBfhAg7Oa5tmvjG9
        jF7PJcCzwNfOyd8IaonyIrqdXcvuxWMeRx2S8nJP+Cn8g3iMGM66dRvCrDfz5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hpy86rj6o8c+yABsbbZq30I4qb42npDGVVa5mdEkw2s=;
        b=KG4yOdlYcQgujWBbSD5a3Ad+r7Vh6iD+mEM954NsY2z+gLDMEk/6lIce0MA4nXTEr+OJvs
        jjw5JuXDzYPxOmBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600094060-82746-7-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160103663247.7002.12761039171215978465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a3b1e8451d3fd54fe0df661c2c4f983932b3c0bc
Gitweb:        https://git.kernel.org/tip/a3b1e8451d3fd54fe0df661c2c4f983932b3c0bc
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 14 Sep 2020 07:34:20 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:52 +02:00

perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge

The Snow Ridge integrated PCIe3 uncore unit can be used to collect
performance data, e.g. utilization, between PCIe devices, plugged into
the PCIe port, and the components (in M2IOSF) responsible for
translating and managing requests to/from the device. The performance
data is very useful for analyzing the performance of PCIe devices.

The device with the PCIe3 uncore PMON units is owned by the portdrv_pci
driver. Create a PCI sub driver for the PCIe3 uncore PMON units.

Here are some difference between PCIe3 uncore unit and other uncore
pci units.
- There may be several Root Ports on a system. But the uncore counters
  only exist in the Root Port A. A user can configure the channel mask
  to collect the data from other Root Ports.
- The event format of the PCIe3 uncore unit is the same as IIO unit of
  SKX.
- The Control Register of PCIe3 uncore unit is 64 bits.
- The offset of each counters is 8, which is the same as M2M unit of
  SNR.
- New MSR addresses for unit control, counter and counter config.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1600094060-82746-7-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 53 +++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 62e88ad..495056f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -393,6 +393,11 @@
 #define SNR_M2M_PCI_PMON_BOX_CTL		0x438
 #define SNR_M2M_PCI_PMON_UMASK_EXT		0xff
 
+/* SNR PCIE3 */
+#define SNR_PCIE3_PCI_PMON_CTL0			0x508
+#define SNR_PCIE3_PCI_PMON_CTR0			0x4e8
+#define SNR_PCIE3_PCI_PMON_BOX_CTL		0x4e0
+
 /* SNR IMC */
 #define SNR_IMC_MMIO_PMON_FIXED_CTL		0x54
 #define SNR_IMC_MMIO_PMON_FIXED_CTR		0x38
@@ -4551,12 +4556,46 @@ static struct intel_uncore_type snr_uncore_m2m = {
 	.format_group	= &snr_m2m_uncore_format_group,
 };
 
+static void snr_uncore_pci_enable_event(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base, (u32)(hwc->config | SNBEP_PMON_CTL_EN));
+	pci_write_config_dword(pdev, hwc->config_base + 4, (u32)(hwc->config >> 32));
+}
+
+static struct intel_uncore_ops snr_pcie3_uncore_pci_ops = {
+	.init_box	= snr_m2m_uncore_pci_init_box,
+	.disable_box	= snbep_uncore_pci_disable_box,
+	.enable_box	= snbep_uncore_pci_enable_box,
+	.disable_event	= snbep_uncore_pci_disable_event,
+	.enable_event	= snr_uncore_pci_enable_event,
+	.read_counter	= snbep_uncore_pci_read_counter,
+};
+
+static struct intel_uncore_type snr_uncore_pcie3 = {
+	.name		= "pcie3",
+	.num_counters	= 4,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= SNR_PCIE3_PCI_PMON_CTR0,
+	.event_ctl	= SNR_PCIE3_PCI_PMON_CTL0,
+	.event_mask	= SKX_IIO_PMON_RAW_EVENT_MASK,
+	.event_mask_ext	= SKX_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.box_ctl	= SNR_PCIE3_PCI_PMON_BOX_CTL,
+	.ops		= &snr_pcie3_uncore_pci_ops,
+	.format_group	= &skx_uncore_iio_format_group,
+};
+
 enum {
 	SNR_PCI_UNCORE_M2M,
+	SNR_PCI_UNCORE_PCIE3,
 };
 
 static struct intel_uncore_type *snr_pci_uncores[] = {
 	[SNR_PCI_UNCORE_M2M]		= &snr_uncore_m2m,
+	[SNR_PCI_UNCORE_PCIE3]		= &snr_uncore_pcie3,
 	NULL,
 };
 
@@ -4573,6 +4612,19 @@ static struct pci_driver snr_uncore_pci_driver = {
 	.id_table	= snr_uncore_pci_ids,
 };
 
+static const struct pci_device_id snr_uncore_pci_sub_ids[] = {
+	{ /* PCIe3 RP */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 0, SNR_PCI_UNCORE_PCIE3, 0),
+	},
+	{ /* end: all zeroes */ }
+};
+
+static struct pci_driver snr_uncore_pci_sub_driver = {
+	.name		= "snr_uncore_sub",
+	.id_table	= snr_uncore_pci_sub_ids,
+};
+
 int snr_uncore_pci_init(void)
 {
 	/* SNR UBOX DID */
@@ -4584,6 +4636,7 @@ int snr_uncore_pci_init(void)
 
 	uncore_pci_uncores = snr_pci_uncores;
 	uncore_pci_driver = &snr_uncore_pci_driver;
+	uncore_pci_sub_driver = &snr_uncore_pci_sub_driver;
 	return 0;
 }
 
