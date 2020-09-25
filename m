Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8091278721
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgIYMX5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:23:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgIYMX4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:56 -0400
Date:   Fri, 25 Sep 2020 12:23:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmzhua8gyBGvEw75xkAOx0rjaqbBAk1U0Y6cy68zXog=;
        b=zB0iGwhTeZIPS9yJthT9kk0UnX9H3XQbJxuemPw56Ur1xOEpW39wmpS948l+cnCqwmJ6xQ
        Kgjqg5trxaFCAsPx+vJo795q8C1eYKWU8oeeNsVVrqPoUTxqnOqOEGPd01lEGsEaZ/8EQb
        UzNwFakjwFEk7kYhstcij53SW6DcXzSEAnpK6tOJHId/1eb858XFT3f4pjvoRG7I3v/PjH
        0hsJwaryrF1ZVXg+h9Nk+qyUnHakhThOfnd1qH1n0KzpQLTk7TzlXLgJ+dcNmtpxvBx3Di
        /67Y9vfPlyC8JR3RfvcMtStX2diqswgU+ue9EeSpin1ixk//H33YezCkvTqJig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmzhua8gyBGvEw75xkAOx0rjaqbBAk1U0Y6cy68zXog=;
        b=vaSWC8MnBazSlxKy6oQM4/wkuLVICzBQVwODdvN2iTU/Z35T/hGxYbrRS6/OxzmpRwwt6Z
        oNm1WF1i7OEsldBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600094060-82746-4-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160103663384.7002.13937009783814644064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     16fa64315c1bd2a61fb20d6aa9a542dd5bf52971
Gitweb:        https://git.kernel.org/tip/16fa64315c1bd2a61fb20d6aa9a542dd5bf52971
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 14 Sep 2020 07:34:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:51 +02:00

perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()

The PMU registration in the uncore PCI sub driver is similar as the
normal PMU registration for a PCI device. The codes to register a PCI
PMU can be shared.

Factor out uncore_pci_pmu_register(), which will be used later.

The pci_set_drvdata() is not included in uncore_pci_pmu_register(). The
uncore PCI sub driver doesn't own the PCI device. It will not touch the
private driver data pointer for the device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1600094060-82746-4-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 82 ++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f6ff1b9..6c6f8b3 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1040,13 +1040,61 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
 }
 
 /*
+ * Register the PMU for a PCI device
+ * @pdev: The PCI device.
+ * @type: The corresponding PMU type of the device.
+ * @pmu: The corresponding PMU of the device.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static int uncore_pci_pmu_register(struct pci_dev *pdev,
+				   struct intel_uncore_type *type,
+				   struct intel_uncore_pmu *pmu,
+				   int phys_id, int die)
+{
+	struct intel_uncore_box *box;
+	int ret;
+
+	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
+		return -EINVAL;
+
+	box = uncore_alloc_box(type, NUMA_NO_NODE);
+	if (!box)
+		return -ENOMEM;
+
+	if (pmu->func_id < 0)
+		pmu->func_id = pdev->devfn;
+	else
+		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
+
+	atomic_inc(&box->refcnt);
+	box->pci_phys_id = phys_id;
+	box->dieid = die;
+	box->pci_dev = pdev;
+	box->pmu = pmu;
+	uncore_box_init(box);
+
+	pmu->boxes[die] = box;
+	if (atomic_inc_return(&pmu->activeboxes) > 1)
+		return 0;
+
+	/* First active box registers the pmu */
+	ret = uncore_pmu_register(pmu);
+	if (ret) {
+		pmu->boxes[die] = NULL;
+		uncore_box_exit(box);
+		kfree(box);
+	}
+	return ret;
+}
+
+/*
  * add a pci uncore device
  */
 static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
-	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
 	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
@@ -1082,38 +1130,10 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
-		return -EINVAL;
-
-	box = uncore_alloc_box(type, NUMA_NO_NODE);
-	if (!box)
-		return -ENOMEM;
-
-	if (pmu->func_id < 0)
-		pmu->func_id = pdev->devfn;
-	else
-		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
-
-	atomic_inc(&box->refcnt);
-	box->pci_phys_id = phys_id;
-	box->dieid = die;
-	box->pci_dev = pdev;
-	box->pmu = pmu;
-	uncore_box_init(box);
-	pci_set_drvdata(pdev, box);
+	ret = uncore_pci_pmu_register(pdev, type, pmu, phys_id, die);
 
-	pmu->boxes[die] = box;
-	if (atomic_inc_return(&pmu->activeboxes) > 1)
-		return 0;
+	pci_set_drvdata(pdev, pmu->boxes[die]);
 
-	/* First active box registers the pmu */
-	ret = uncore_pmu_register(pmu);
-	if (ret) {
-		pci_set_drvdata(pdev, NULL);
-		pmu->boxes[die] = NULL;
-		uncore_box_exit(box);
-		kfree(box);
-	}
 	return ret;
 }
 
