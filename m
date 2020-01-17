Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75262140792
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jan 2020 11:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAQKKP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jan 2020 05:10:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgAQKIt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYS-0005PS-67; Fri, 17 Jan 2020 11:08:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BED061C19CD;
        Fri, 17 Jan 2020 11:08:39 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:39 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Add PCI ID of IMC for Xeon
 E3 V5 Family
Cc:     "Rosales-fernandez, Carlos" <carlos.rosales-fernandez@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578687311-158748-1-git-send-email-kan.liang@linux.intel.com>
References: <1578687311-158748-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157925571959.396.17894978453297682062.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a6a3c6eae34bffa43d685bea471d57b0965dae54
Gitweb:        https://git.kernel.org/tip/a6a3c6eae34bffa43d685bea471d57b0965dae54
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 10 Jan 2020 12:15:11 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:24 +01:00

perf/x86/intel/uncore: Add PCI ID of IMC for Xeon E3 V5 Family

The IMC uncore support is missed for E3-1585 v5 CPU.

Intel Xeon E3 V5 Family has Sky Lake CPU.
Add the PCI ID of IMC for Intel Xeon E3 V5 Family.

Reported-by: Rosales-fernandez, Carlos <carlos.rosales-fernandez@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Rosales-fernandez, Carlos <carlos.rosales-fernandez@intel.com>
Link: https://lkml.kernel.org/r/1578687311-158748-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index dbaa1b0..c37cb12 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -15,6 +15,7 @@
 #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC		0x1910
 #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC		0x190f
 #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC		0x191f
+#define PCI_DEVICE_ID_INTEL_SKL_E3_IMC		0x1918
 #define PCI_DEVICE_ID_INTEL_KBL_Y_IMC		0x590c
 #define PCI_DEVICE_ID_INTEL_KBL_U_IMC		0x5904
 #define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC		0x5914
@@ -658,6 +659,10 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
 	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_E3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
@@ -826,6 +831,7 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
 	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
 	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
+	IMC_DEV(SKL_E3_IMC, &skl_uncore_pci_driver),  /* Xeon E3 V5 Gen Core processor */
 	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
 	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
 	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
