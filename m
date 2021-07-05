Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260F03BB84C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhGEH4S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhGEH4R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:17 -0400
Date:   Mon, 05 Jul 2021 07:53:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyCl8RGP4qksQONpC+Myv09yV0x1dCXHCNH3URHJ/LE=;
        b=2DKYXRG1FhFbivN4toRfq2bbTQJD420+9lmDhyAUl+vcrcsWf5/biQEPPQuoWGAKpcZICr
        X9HJXCALYZGU/Z4EPGj5TftcfmS5Sak5bonPfnz3EeB7E6L/2q03YrPT+cr1kcUk1g57vF
        9DuWPwlqAT+Tthu3XkIbvX4hh7ZkYwOOsDEhmFMEACTF2f/mFAKcYcUnx29DvU9j88/YA2
        piowRTv81DjcK+k4QCbVtAhEyF4Th5ZOtIM34vlK0iR+dk3kQ0lelJxuKPisiTk95MmhRV
        A6rJR46d5PdUXXZvzGFola9Va0cK52sWps7uQJLd72jRTHxvYdF4H/903UwBJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyCl8RGP4qksQONpC+Myv09yV0x1dCXHCNH3URHJ/LE=;
        b=Zu0zCwWRuJVgN+5L/UW5fGtQo7UPUojccntwSst2ZqAr0V4e3rlTyVwzzLib7mLAtdSciV
        WmUpQPUK9tPvbeAA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out snr_uncore_mmio_map()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-14-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-14-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547161930.395.13816606012486498676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1583971b5cb8c786df88be580cdd96a974ad591b
Gitweb:        https://git.kernel.org/tip/1583971b5cb8c786df88be580cdd96a974ad591b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:41 +02:00

perf/x86/intel/uncore: Factor out snr_uncore_mmio_map()

The IMC free-running counters on Sapphire Rapids server are also
accessed by MMIO, which is similar to the previous platforms, SNR and
ICX. The only difference is the device ID of the device which contains
BAR address.

Factor out snr_uncore_mmio_map() which ioremap the MMIO space. It can be
reused in the following patch for SPR.

Use the snr_uncore_mmio_map() in the icx_uncore_imc_freerunning_init_box().
There is no box_ctl for the free-running counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-14-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 36 ++++++++++++++++++---------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d0d02e0..9618662 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4792,13 +4792,15 @@ int snr_uncore_pci_init(void)
 	return 0;
 }
 
-static struct pci_dev *snr_uncore_get_mc_dev(int id)
+#define SNR_MC_DEVICE_ID	0x3451
+
+static struct pci_dev *snr_uncore_get_mc_dev(unsigned int device, int id)
 {
 	struct pci_dev *mc_dev = NULL;
 	int pkg;
 
 	while (1) {
-		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3451, mc_dev);
+		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, mc_dev);
 		if (!mc_dev)
 			break;
 		pkg = uncore_pcibus_to_dieid(mc_dev->bus);
@@ -4808,16 +4810,17 @@ static struct pci_dev *snr_uncore_get_mc_dev(int id)
 	return mc_dev;
 }
 
-static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
-				       unsigned int box_ctl, int mem_offset)
+static int snr_uncore_mmio_map(struct intel_uncore_box *box,
+			       unsigned int box_ctl, int mem_offset,
+			       unsigned int device)
 {
-	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->dieid);
+	struct pci_dev *pdev = snr_uncore_get_mc_dev(device, box->dieid);
 	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 	u32 pci_dword;
 
 	if (!pdev)
-		return;
+		return -ENODEV;
 
 	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
 	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
@@ -4830,16 +4833,25 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr) {
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
-		return;
+		return -EINVAL;
 	}
 
-	writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
+	return 0;
+}
+
+static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
+				       unsigned int box_ctl, int mem_offset,
+				       unsigned int device)
+{
+	if (!snr_uncore_mmio_map(box, box_ctl, mem_offset, device))
+		writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
 }
 
 static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
 	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box),
-				   SNR_IMC_MMIO_MEM0_OFFSET);
+				   SNR_IMC_MMIO_MEM0_OFFSET,
+				   SNR_MC_DEVICE_ID);
 }
 
 static void snr_uncore_mmio_disable_box(struct intel_uncore_box *box)
@@ -5413,7 +5425,8 @@ static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
 	int mem_offset = (box->pmu->pmu_idx / ICX_NUMBER_IMC_CHN) * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset);
+	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset,
+				   SNR_MC_DEVICE_ID);
 }
 
 static struct intel_uncore_ops icx_uncore_mmio_ops = {
@@ -5483,7 +5496,8 @@ static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box), mem_offset);
+	snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
+			    mem_offset, SNR_MC_DEVICE_ID);
 }
 
 static struct intel_uncore_ops icx_uncore_imc_freerunning_ops = {
