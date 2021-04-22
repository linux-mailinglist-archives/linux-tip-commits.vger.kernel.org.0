Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3C367B15
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhDVHag (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhDVHag (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 03:30:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1662DC06174A;
        Thu, 22 Apr 2021 00:30:01 -0700 (PDT)
Date:   Thu, 22 Apr 2021 07:29:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619076599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMmlu0nOb2/sxL8gys7acprcP9q0id386/AEWvtNPjA=;
        b=0szDznn6rA1HmTmcv/rlbu6NKVZZihhsQt3BO3aLGo2CAqxfQpkN0kPZhyAVgfyJ/SCt5A
        m59j8zxv2uLtryOQMnaa/CJivmwo0yZb6zvc0E4zhqG3HYapeAcGsAc1xiMUecmZU9/964
        r3KAObop/I4xv39TXWBnYzDlSXAIoDHjBn5ZCaZBCI6gmReIlgCXCxsspOSIDwtLsGy8B9
        2YTGGqc13qHAhaj17f2UDIRlnnrvjyZJ1IV/ULrGFEA8OnojoCXFQjLufud2mOZmxer2FV
        Nhzl6L1UaYkCWOnkw6qr4awnTLaZ1eFJHhjAWSFqbiMgIxt5gKFCuc/c67qDkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619076599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMmlu0nOb2/sxL8gys7acprcP9q0id386/AEWvtNPjA=;
        b=CgmELnnNptAhgGN/S0wC9KTAvLvH5S5sW75c9eX5WEas+6Hitxru7ENTB0c7SiHEbM2ONz
        TtyhnhJf0+PjvUBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Remove uncore extra PCI dev
 HSWEP_PCI_PCU_3
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618521764-100923-1-git-send-email-kan.liang@linux.intel.com>
References: <1618521764-100923-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161907659912.29796.9807219526176072887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9d480158ee86ad606d3a8baaf81e6b71acbfd7d5
Gitweb:        https://git.kernel.org/tip/9d480158ee86ad606d3a8baaf81e6b71acbfd7d5
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 15 Apr 2021 14:22:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Apr 2021 13:55:39 +02:00

perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3

There may be a kernel panic on the Haswell server and the Broadwell
server, if the snbep_pci2phy_map_init() return error.

The uncore_extra_pci_dev[HSWEP_PCI_PCU_3] is used in the cpu_init() to
detect the existence of the SBOX, which is a MSR type of PMON unit.
The uncore_extra_pci_dev is allocated in the uncore_pci_init(). If the
snbep_pci2phy_map_init() returns error, perf doesn't initialize the
PCI type of the PMON units, so the uncore_extra_pci_dev will not be
allocated. But perf may continue initializing the MSR type of PMON
units. A null dereference kernel panic will be triggered.

The sockets in a Haswell server or a Broadwell server are identical.
Only need to detect the existence of the SBOX once.
Current perf probes all available PCU devices and stores them into the
uncore_extra_pci_dev. It's unnecessary.
Use the pci_get_device() to replace the uncore_extra_pci_dev. Only
detect the existence of the SBOX on the first available PCU device once.

Factor out hswep_has_limit_sbox(), since the Haswell server and the
Broadwell server uses the same way to detect the existence of the SBOX.

Add some macros to replace the magic number.

Fixes: 5306c31c5733 ("perf/x86/uncore/hsw-ep: Handle systems with only two SBOXes")
Reported-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/1618521764-100923-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 61 +++++++++++----------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b79951d..9b89376 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1159,7 +1159,6 @@ enum {
 	SNBEP_PCI_QPI_PORT0_FILTER,
 	SNBEP_PCI_QPI_PORT1_FILTER,
 	BDX_PCI_QPI_PORT2_FILTER,
-	HSWEP_PCI_PCU_3,
 };
 
 static int snbep_qpi_hw_config(struct intel_uncore_box *box, struct perf_event *event)
@@ -2857,22 +2856,33 @@ static struct intel_uncore_type *hswep_msr_uncores[] = {
 	NULL,
 };
 
-void hswep_uncore_cpu_init(void)
+#define HSWEP_PCU_DID			0x2fc0
+#define HSWEP_PCU_CAPID4_OFFET		0x94
+#define hswep_get_chop(_cap)		(((_cap) >> 6) & 0x3)
+
+static bool hswep_has_limit_sbox(unsigned int device)
 {
-	int pkg = boot_cpu_data.logical_proc_id;
+	struct pci_dev *dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
+	u32 capid4;
+
+	if (!dev)
+		return false;
+
+	pci_read_config_dword(dev, HSWEP_PCU_CAPID4_OFFET, &capid4);
+	if (!hswep_get_chop(capid4))
+		return true;
 
+	return false;
+}
+
+void hswep_uncore_cpu_init(void)
+{
 	if (hswep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 
 	/* Detect 6-8 core systems with only two SBOXes */
-	if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
-		u32 capid4;
-
-		pci_read_config_dword(uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
-				      0x94, &capid4);
-		if (((capid4 >> 6) & 0x3) == 0)
-			hswep_uncore_sbox.num_boxes = 2;
-	}
+	if (hswep_has_limit_sbox(HSWEP_PCU_DID))
+		hswep_uncore_sbox.num_boxes = 2;
 
 	uncore_msr_uncores = hswep_msr_uncores;
 }
@@ -3135,11 +3145,6 @@ static const struct pci_device_id hswep_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
 						   SNBEP_PCI_QPI_PORT1_FILTER),
 	},
-	{ /* PCU.3 (for Capability registers) */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fc0),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
-						   HSWEP_PCI_PCU_3),
-	},
 	{ /* end: all zeroes */ }
 };
 
@@ -3231,27 +3236,18 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+#define BDX_PCU_DID			0x6fc0
+
 void bdx_uncore_cpu_init(void)
 {
-	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
-
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 	uncore_msr_uncores = bdx_msr_uncores;
 
-	/* BDX-DE doesn't have SBOX */
-	if (boot_cpu_data.x86_model == 86) {
-		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 	/* Detect systems with no SBOXes */
-	} else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
-		struct pci_dev *pdev;
-		u32 capid4;
-
-		pdev = uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3];
-		pci_read_config_dword(pdev, 0x94, &capid4);
-		if (((capid4 >> 6) & 0x3) == 0)
-			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
-	}
+	if ((boot_cpu_data.x86_model == 86) || hswep_has_limit_sbox(BDX_PCU_DID))
+		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
 }
 
@@ -3472,11 +3468,6 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
 						   BDX_PCI_QPI_PORT2_FILTER),
 	},
-	{ /* PCU.3 (for Capability registers) */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
-						   HSWEP_PCI_PCU_3),
-	},
 	{ /* end: all zeroes */ }
 };
 
