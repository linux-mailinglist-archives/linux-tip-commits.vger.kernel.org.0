Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC21FB056
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFPMWD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Jun 2020 08:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgFPMWC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9DDC08C5C5;
        Tue, 16 Jun 2020 05:22:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbE-0004dq-TI; Tue, 16 Jun 2020 14:21:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 302FD1C06E5;
        Tue, 16 Jun 2020 14:21:50 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:49 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Comet Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1589915905-55870-1-git-send-email-kan.liang@linux.intel.com>
References: <1589915905-55870-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159231010998.16989.16172004869901710895.tip-bot2@tip-bot2>
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

Commit-ID:     bb85429a9bf2e7d370b8e1afd72f933a88f0629f
Gitweb:        https://git.kernel.org/tip/bb85429a9bf2e7d370b8e1afd72f933a88f0629f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 19 May 2020 12:18:25 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:47 +02:00

perf/x86/intel/uncore: Add Comet Lake support

The uncore subsystem on Comet Lake is similar to Sky Lake.
The only difference is the new PCI IDs for IMC.

Share the perf code with Sky Lake.
Add new PCI IDs in the table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1589915905-55870-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |  2 +-
 arch/x86/events/intel/uncore_snb.c | 66 +++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cf76d66..b9c2876 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1514,6 +1514,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&skx_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&skl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&skl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_uncore_init),
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3de1065..5c40367 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -42,6 +42,17 @@
 #define PCI_DEVICE_ID_INTEL_WHL_UQ_IMC		0x3ed0
 #define PCI_DEVICE_ID_INTEL_WHL_4_UQ_IMC	0x3e34
 #define PCI_DEVICE_ID_INTEL_WHL_UD_IMC		0x3e35
+#define PCI_DEVICE_ID_INTEL_CML_H1_IMC		0x9b44
+#define PCI_DEVICE_ID_INTEL_CML_H2_IMC		0x9b54
+#define PCI_DEVICE_ID_INTEL_CML_H3_IMC		0x9b64
+#define PCI_DEVICE_ID_INTEL_CML_U1_IMC		0x9b51
+#define PCI_DEVICE_ID_INTEL_CML_U2_IMC		0x9b61
+#define PCI_DEVICE_ID_INTEL_CML_U3_IMC		0x9b71
+#define PCI_DEVICE_ID_INTEL_CML_S1_IMC		0x9b33
+#define PCI_DEVICE_ID_INTEL_CML_S2_IMC		0x9b43
+#define PCI_DEVICE_ID_INTEL_CML_S3_IMC		0x9b53
+#define PCI_DEVICE_ID_INTEL_CML_S4_IMC		0x9b63
+#define PCI_DEVICE_ID_INTEL_CML_S5_IMC		0x9b73
 #define PCI_DEVICE_ID_INTEL_ICL_U_IMC		0x8a02
 #define PCI_DEVICE_ID_INTEL_ICL_U2_IMC		0x8a12
 #define PCI_DEVICE_ID_INTEL_TGL_U1_IMC		0x9a02
@@ -771,6 +782,50 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UD_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S4_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S5_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -863,6 +918,17 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(WHL_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
 	IMC_DEV(WHL_4_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
 	IMC_DEV(WHL_UD_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Dual Core */
+	IMC_DEV(CML_H1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_H2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_H3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S4_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S5_IMC, &skl_uncore_pci_driver),
 	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	{  /* end marker */ }
