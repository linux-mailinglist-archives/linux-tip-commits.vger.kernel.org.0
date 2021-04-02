Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEE352738
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Apr 2021 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhDBIMp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Apr 2021 04:12:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhDBIMo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 2 Apr 2021 04:12:44 -0400
Date:   Fri, 02 Apr 2021 08:12:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617351163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcPx5slKAxxLjRplWQi6LuFGoK9WBQ5ve2d8j/W0FKw=;
        b=AaYxs0l0IfobC9mwSrtmoHxwWfFA3T0FSCghJdOZ/OnfBi1PT/zM/RSzErKTfmUo/7kw9E
        /BWz3/aPT0XC/LiifEQ5ic2Yysejj+Se8D8yeFCUVczsgxars6dKbh4Yb/ILGWQssI17yq
        l5CRU/a3i0jULaBLxA9qRmp3Drun+O4B71g7diZzt2SAjx5pXIAEBeTp61uYkeQGYBrB1z
        0fVHMa0v7nM7wVZpg19nNmoTFjJWFs7fCO7gSz5eKuytrCRj1Qvnmbw+bwx7XXfMNaJS/s
        1Nvgurv4tvBNriQbB9cDSHMHI4W6uci35A2zXOBVfNJ3KnCYHERpV1uQC3dAAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617351163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcPx5slKAxxLjRplWQi6LuFGoK9WBQ5ve2d8j/W0FKw=;
        b=joRDdZaUNHNChthWJ+EhQ8L2S66PEczatUo0AaHqJcHPoaxNDvpx04o/kRboExqL24TMMn
        zWNmGtIraMTdejAg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Rename uncore_notifier to
 uncore_pci_sub_notifier
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1616003977-90612-4-git-send-email-kan.liang@linux.intel.com>
References: <1616003977-90612-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161735116245.29796.14619453712248412849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6477dc3934775f82a571fac469fd8c348e611095
Gitweb:        https://git.kernel.org/tip/6477dc3934775f82a571fac469fd8c348e611095
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 17 Mar 2021 10:59:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Apr 2021 10:04:54 +02:00

perf/x86/intel/uncore: Rename uncore_notifier to uncore_pci_sub_notifier

Perf will use a similar method to the PCI sub driver to register
the PMUs for the PCI type of uncore blocks. The method requires a BUS
notifier to support hotplug. The current BUS notifier cannot be reused,
because it searches a const id_table for the corresponding registered
PMU. The PCI type of uncore blocks in the discovery tables doesn't
provide an id_table.

Factor out uncore_bus_notify() and add the pointer of an id_table as a
parameter. The uncore_bus_notify() will be reused in the following
patch.

The current BUS notifier is only used by the PCI sub driver. Its name is
too generic. Rename it to uncore_pci_sub_notifier, which is specific for
the PCI sub driver.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1616003977-90612-4-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index dabc01f..391fa7c 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1203,7 +1203,8 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 }
 
 static int uncore_bus_notify(struct notifier_block *nb,
-			     unsigned long action, void *data)
+			     unsigned long action, void *data,
+			     const struct pci_device_id *ids)
 {
 	struct device *dev = data;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1214,7 +1215,7 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	if (action != BUS_NOTIFY_DEL_DEVICE)
 		return NOTIFY_DONE;
 
-	pmu = uncore_pci_find_dev_pmu(pdev, uncore_pci_sub_driver->id_table);
+	pmu = uncore_pci_find_dev_pmu(pdev, ids);
 	if (!pmu)
 		return NOTIFY_DONE;
 
@@ -1226,8 +1227,15 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block uncore_notifier = {
-	.notifier_call = uncore_bus_notify,
+static int uncore_pci_sub_bus_notify(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	return uncore_bus_notify(nb, action, data,
+				 uncore_pci_sub_driver->id_table);
+}
+
+static struct notifier_block uncore_pci_sub_notifier = {
+	.notifier_call = uncore_pci_sub_bus_notify,
 };
 
 static void uncore_pci_sub_driver_init(void)
@@ -1268,7 +1276,7 @@ static void uncore_pci_sub_driver_init(void)
 		ids++;
 	}
 
-	if (notify && bus_register_notifier(&pci_bus_type, &uncore_notifier))
+	if (notify && bus_register_notifier(&pci_bus_type, &uncore_pci_sub_notifier))
 		notify = false;
 
 	if (!notify)
@@ -1319,7 +1327,7 @@ static void uncore_pci_exit(void)
 	if (pcidrv_registered) {
 		pcidrv_registered = false;
 		if (uncore_pci_sub_driver)
-			bus_unregister_notifier(&pci_bus_type, &uncore_notifier);
+			bus_unregister_notifier(&pci_bus_type, &uncore_pci_sub_notifier);
 		pci_unregister_driver(uncore_pci_driver);
 		uncore_types_exit(uncore_pci_uncores);
 		kfree(uncore_extra_pci_dev);
