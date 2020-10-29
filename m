Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03929E9B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgJ2KxO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgJ2Kvl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370DC0613D2;
        Thu, 29 Oct 2020 03:51:40 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO+l3fCGCOHTLBzyr9lZxu7ir9dPcm5Q8hQh5Su9Vgw=;
        b=4De5q99xiL+nXebW1HPHjebqnLoJaTRdPYQzCLltMlqHDmKjzAuHVptNuiGqUqU4ZVvZIB
        5vFqubxEg7IhtpHnLDgUgwTn3akjFMkc5f7jm2e7zgynU2+4zxWdJnzpUAEJqrFslQHpC2
        qhEe4+wwuPDwqXYm4VpUedpj8Gt/OJGaDciZLFzN/aJkRDmOL+2c7IoUTGnppt27lbapNH
        fjD2q7gPcwi3DR2Qr0+39v39U/t2eLjwQlDn0DfuqZfCDgVE11HTmOW46hDzJ2BS2ud6Gz
        /DE+4mPEnV5au5KYcJA70BV5/pvNFdnZoHYdM/Q0BuH9ddQ4Og3jfM4rqhv42w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO+l3fCGCOHTLBzyr9lZxu7ir9dPcm5Q8hQh5Su9Vgw=;
        b=viaq7OrheCfdrVM8tFPQ3NgVNLeAykyMOydgWYdkEG1UdSA2oIVaHnuUx0t0O7qKCDTbYs
        c9lA0Li7j0wkqoBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Rocket Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201019153528.13850-4-kan.liang@linux.intel.com>
References: <20201019153528.13850-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160396869837.397.8191766254685475435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     43bc103a8044b9f7963aa1684efbdc9bd60939de
Gitweb:        https://git.kernel.org/tip/43bc103a8044b9f7963aa1684efbdc9bd60939de
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 19 Oct 2020 08:35:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:40 +01:00

perf/x86/intel/uncore: Add Rocket Lake support

For Rocket Lake, the MSR uncore, e.g., CBOX, ARB and CLOCKBOX, are the
same as Tiger Lake. Share the perf code with it.

For Rocket Lake and Tiger Lake, the 8th CBOX is not mapped into a
different MSR space anymore. Add rkl_uncore_msr_init_box() to replace
skl_uncore_msr_init_box().

The IMC uncore is the similar to Ice Lake. Add new PCIIDs of IMC for
Rocket Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201019153528.13850-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |  6 ++++++
 arch/x86/events/intel/uncore_snb.c | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86d012b..1db6a71 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1636,6 +1636,11 @@ static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun rkl_uncore_init __initconst = {
+	.cpu_init = tgl_uncore_cpu_init,
+	.pci_init = skl_uncore_pci_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1683,6 +1688,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_l_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index de3d962..6bbf54b 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -60,7 +60,8 @@
 #define PCI_DEVICE_ID_INTEL_TGL_U3_IMC		0x9a12
 #define PCI_DEVICE_ID_INTEL_TGL_U4_IMC		0x9a14
 #define PCI_DEVICE_ID_INTEL_TGL_H_IMC		0x9a36
-
+#define PCI_DEVICE_ID_INTEL_RKL_1_IMC		0x4c43
+#define PCI_DEVICE_ID_INTEL_RKL_2_IMC		0x4c53
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -405,6 +406,12 @@ static struct intel_uncore_type *tgl_msr_uncores[] = {
 	NULL,
 };
 
+static void rkl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
 void tgl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = tgl_msr_uncores;
@@ -412,6 +419,7 @@ void tgl_uncore_cpu_init(void)
 	icl_uncore_cbox.ops = &skl_uncore_msr_ops;
 	icl_uncore_clockbox.ops = &skl_uncore_msr_ops;
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
+	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
 enum {
@@ -880,6 +888,14 @@ static const struct pci_device_id icl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICL_U2_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -973,6 +989,8 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(CML_S5_IMC, &skl_uncore_pci_driver),
 	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
+	IMC_DEV(RKL_1_IMC, &icl_uncore_pci_driver),
+	IMC_DEV(RKL_2_IMC, &icl_uncore_pci_driver),
 	{  /* end marker */ }
 };
 
