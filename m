Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0C278728
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgIYMY0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:24:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgIYMX5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:57 -0400
Date:   Fri, 25 Sep 2020 12:23:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kfK5+C6aRDyedi5HOhglbUX4PdHZKMeac+ysDm8Seu0=;
        b=cqIytBYQBlIzOvumMxdP5rbxeU8RP0NgQWnBkddbbGHCJOaAaTOlMgbwQwEIYG/RS8stKU
        8kyvDJe9VvH6T8BFxdUN+jtOXJs0fbiV0QFiw/wo/yrzYY2qoT5tCXrkTEcmhszDtPiRW2
        s0uQXso9w150L/cxDYxvTFvRMJZ4a0RZ745C2CeZsrFephKt9JgLLDsP40C9yShmVYha6w
        Tmnz6DWQ+RMVZ81KgqM9ZlyfeIWymc/uUa7zll/K8aa1Ub+9/lUYoRpoMl03jrT3IBmjr9
        8Ol+StGhMC32nfREpXBr1CQOGvpt/XAd3utBDG676TJneYetLDUfh7JSujsF0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kfK5+C6aRDyedi5HOhglbUX4PdHZKMeac+ysDm8Seu0=;
        b=PkLyzYRLxafOXMmtS3iGVkMPpOqFsj4KF8T2wAQSvYOS9OlvD6sk/qz9FIGnUlp3rPqe97
        6zn1mA0kiH14g2BQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600094060-82746-3-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160103663428.7002.17992873706826896518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8ed2ccaa3fa990be61619a61b9bc3914eefdc18f
Gitweb:        https://git.kernel.org/tip/8ed2ccaa3fa990be61619a61b9bc3914eefdc18f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 14 Sep 2020 07:34:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:50 +02:00

perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()

When an uncore PCI sub driver gets a remove notification, the
corresponding PMU has to be retrieved and unregistered. The codes, which
find the corresponding PMU by comparing the pci_device_id table, can be
shared.

Factor out uncore_pci_find_dev_pmu(), which will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1600094060-82746-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 48 ++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e14b03f..f6ff1b9 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1008,6 +1008,37 @@ static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
 
 	return 0;
 }
+
+/*
+ * Find the PMU of a PCI device.
+ * @pdev: The PCI device.
+ * @ids: The ID table of the available PCI devices with a PMU.
+ */
+static struct intel_uncore_pmu *
+uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
+{
+	struct intel_uncore_pmu *pmu = NULL;
+	struct intel_uncore_type *type;
+	kernel_ulong_t data;
+	unsigned int devfn;
+
+	while (ids && ids->vendor) {
+		if ((ids->vendor == pdev->vendor) &&
+		    (ids->device == pdev->device)) {
+			data = ids->driver_data;
+			devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(data),
+					  UNCORE_PCI_DEV_FUNC(data));
+			if (devfn == pdev->devfn) {
+				type = uncore_pci_uncores[UNCORE_PCI_DEV_TYPE(data)];
+				pmu = &type->pmus[UNCORE_PCI_DEV_IDX(data)];
+				break;
+			}
+		}
+		ids++;
+	}
+	return pmu;
+}
+
 /*
  * add a pci uncore device
  */
@@ -1039,21 +1070,8 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	 */
 	if (id->driver_data & ~0xffff) {
 		struct pci_driver *pci_drv = pdev->driver;
-		const struct pci_device_id *ids = pci_drv->id_table;
-		unsigned int devfn;
-
-		while (ids && ids->vendor) {
-			if ((ids->vendor == pdev->vendor) &&
-			    (ids->device == pdev->device)) {
-				devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(ids->driver_data),
-						  UNCORE_PCI_DEV_FUNC(ids->driver_data));
-				if (devfn == pdev->devfn) {
-					pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
-					break;
-				}
-			}
-			ids++;
-		}
+
+		pmu = uncore_pci_find_dev_pmu(pdev, pci_drv->id_table);
 		if (pmu == NULL)
 			return -ENODEV;
 	} else {
