Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680BA278713
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIYMX4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:23:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYMX4 (ORCPT
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
        bh=8PBnRkbgVOUY/+pVCoJM4bYhzSr2pSCTrTPj1oZcxDg=;
        b=Ry6D2U2anrnKARViUcwFfxKSlmr/V9i4DH9L0aud2Nhe/UL8TnQ9d+kep2V6M6jJJmUJIH
        GZtP/KhTheLsWXQub9vG/8tVjSRMm9HvI8T5dVwjEhbNJ4Delscr7/2+sGviqMaQS/Mphc
        LSitb8+2+GhxAiuc4fX55cJEuuXSOyLsFi8rvm2WBvxcSrEdeRm/12LPzVwBcUlg0cXNbk
        OW9DfEJNtYGgHSMkNxMDB5XTzAeq8l6nvmrK5Sg20hQJhO/+8g+gV0e7mBINcZA+kTV2Zb
        xUEp6NdljRiDa0pX8gp0a3/Rz275gNryt3Ij9RR7afp9WnCuebq4h+0pT/ht7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PBnRkbgVOUY/+pVCoJM4bYhzSr2pSCTrTPj1oZcxDg=;
        b=f7JlcKEJR1qkmhbhe/8NugqOUBRVKmw+ciBeegx4a8Q+nmejH6JntTA0raEZLwMW36uccG
        xA8Bzx+HB/I38pAA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generic support for the PCI
 sub driver
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600094060-82746-6-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160103663299.7002.197893072818781547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     95a7fc77443328ac8b68378df8e137a044ece5e8
Gitweb:        https://git.kernel.org/tip/95a7fc77443328ac8b68378df8e137a044ece5e8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 14 Sep 2020 07:34:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:51 +02:00

perf/x86/intel/uncore: Generic support for the PCI sub driver

Some uncore counters may be located in the configuration space of a PCI
device, which already has a bonded driver. Currently, the uncore driver
cannot register a PCI uncore PMU for these counters, because, to
register a PCI uncore PMU, the uncore driver must be bond to the device.
However, one device can only have one bonded driver.

Add an uncore PCI sub driver to support such kind of devices.

The sub driver doesn't own the device. In initialization, the sub
driver searches the device via pci_get_device(), and register the
corresponding PMU for the device. In the meantime, the sub driver
registers a PCI bus notifier, which is used to notify the sub driver
once the device is removed. The sub driver can unregister the PMU
accordingly.

The sub driver only searches the devices defined in its id table. The
id table varies on different platforms, which will be implemented in the
following platform-specific patch.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1600094060-82746-6-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 81 +++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/uncore.h |  1 +-
 2 files changed, 82 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 747d237..ce0a5ba 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -12,6 +12,8 @@ struct intel_uncore_type **uncore_mmio_uncores = empty_uncore;
 
 static bool pcidrv_registered;
 struct pci_driver *uncore_pci_driver;
+/* The PCI driver for the device which the uncore doesn't own. */
+struct pci_driver *uncore_pci_sub_driver;
 /* pci bus to socket mapping */
 DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
 struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
@@ -1186,6 +1188,80 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	uncore_pci_pmu_unregister(pmu, phys_id, die);
 }
 
+static int uncore_bus_notify(struct notifier_block *nb,
+			     unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct intel_uncore_pmu *pmu;
+	int phys_id, die;
+
+	/* Unregister the PMU when the device is going to be deleted. */
+	if (action != BUS_NOTIFY_DEL_DEVICE)
+		return NOTIFY_DONE;
+
+	pmu = uncore_pci_find_dev_pmu(pdev, uncore_pci_sub_driver->id_table);
+	if (!pmu)
+		return NOTIFY_DONE;
+
+	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+		return NOTIFY_DONE;
+
+	uncore_pci_pmu_unregister(pmu, phys_id, die);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block uncore_notifier = {
+	.notifier_call = uncore_bus_notify,
+};
+
+static void uncore_pci_sub_driver_init(void)
+{
+	const struct pci_device_id *ids = uncore_pci_sub_driver->id_table;
+	struct intel_uncore_type *type;
+	struct intel_uncore_pmu *pmu;
+	struct pci_dev *pci_sub_dev;
+	bool notify = false;
+	unsigned int devfn;
+	int phys_id, die;
+
+	while (ids && ids->vendor) {
+		pci_sub_dev = NULL;
+		type = uncore_pci_uncores[UNCORE_PCI_DEV_TYPE(ids->driver_data)];
+		/*
+		 * Search the available device, and register the
+		 * corresponding PMU.
+		 */
+		while ((pci_sub_dev = pci_get_device(PCI_VENDOR_ID_INTEL,
+						     ids->device, pci_sub_dev))) {
+			devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(ids->driver_data),
+					  UNCORE_PCI_DEV_FUNC(ids->driver_data));
+			if (devfn != pci_sub_dev->devfn)
+				continue;
+
+			pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
+			if (!pmu)
+				continue;
+
+			if (uncore_pci_get_dev_die_info(pci_sub_dev,
+							&phys_id, &die))
+				continue;
+
+			if (!uncore_pci_pmu_register(pci_sub_dev, type, pmu,
+						     phys_id, die))
+				notify = true;
+		}
+		ids++;
+	}
+
+	if (notify && bus_register_notifier(&pci_bus_type, &uncore_notifier))
+		notify = false;
+
+	if (!notify)
+		uncore_pci_sub_driver = NULL;
+}
+
 static int __init uncore_pci_init(void)
 {
 	size_t size;
@@ -1209,6 +1285,9 @@ static int __init uncore_pci_init(void)
 	if (ret)
 		goto errtype;
 
+	if (uncore_pci_sub_driver)
+		uncore_pci_sub_driver_init();
+
 	pcidrv_registered = true;
 	return 0;
 
@@ -1226,6 +1305,8 @@ static void uncore_pci_exit(void)
 {
 	if (pcidrv_registered) {
 		pcidrv_registered = false;
+		if (uncore_pci_sub_driver)
+			bus_unregister_notifier(&pci_bus_type, &uncore_notifier);
 		pci_unregister_driver(uncore_pci_driver);
 		uncore_types_exit(uncore_pci_uncores);
 		kfree(uncore_extra_pci_dev);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 105fdc6..df544bc 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -552,6 +552,7 @@ extern struct intel_uncore_type **uncore_msr_uncores;
 extern struct intel_uncore_type **uncore_pci_uncores;
 extern struct intel_uncore_type **uncore_mmio_uncores;
 extern struct pci_driver *uncore_pci_driver;
+extern struct pci_driver *uncore_pci_sub_driver;
 extern raw_spinlock_t pci2phy_map_lock;
 extern struct list_head pci2phy_map_head;
 extern struct pci_extra_dev *uncore_extra_pci_dev;
