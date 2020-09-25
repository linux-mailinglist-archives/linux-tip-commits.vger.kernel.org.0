Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A496278715
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIYMX4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:23:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYMX4 (ORCPT
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
        bh=+2KEc5TEhnpXQ5rfUHq9WagqogkBmnIMlMvwcHeNRok=;
        b=G46ZmFJv8mzvaY7M8Z7sSkU5pMUBzNEixIBGWXgmwcf66Fa7PatxBCuhZLj3nv9II6hPop
        6zy4Ff6q/+lbdBsi7t2rv1A3laNVAbLyhp4ocqJB9zl+O88Sobcf+2odlW6Kj+nwa9ehZB
        vnxLC5slcmVgySjaTWRQqIZ9bbsSRgAQpvcXbpEmGGCJ1+6BiXGhiQ28og79pKBxz8CAUH
        Uf2PjxTEg6L6TMlJpdkZ7vkOrEp9TRa9/2QVgr1gjoqyjiV1QGk0hljuE591lywTU8Ya04
        UiK1ajdZzPGdh9wBNng8ubSzAjV1nP0/1iyEuDybkD3cPtNifxzOcI8mJK4G1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2KEc5TEhnpXQ5rfUHq9WagqogkBmnIMlMvwcHeNRok=;
        b=7k+EWHfwY2hFltqXX+gy4Onfmj+rkt+0hi6BKQtzUJEJphIN5Goslv1E6/IPmuJKZWtl29
        JBOk7spB69kfSdBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out
 uncore_pci_pmu_unregister()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600094060-82746-5-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160103663341.7002.13969626013239692427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cdcce92a3a03bccbb0b4a0342fc7e279fc507bc3
Gitweb:        https://git.kernel.org/tip/cdcce92a3a03bccbb0b4a0342fc7e279fc507bc3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 14 Sep 2020 07:34:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:51 +02:00

perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()

The PMU unregistration in the uncore PCI sub driver is similar as the
normal PMU unregistration for a PCI device. The codes to unregister a
PCI PMU can be shared.

Factor out uncore_pci_pmu_unregister(), which will be used later.

Use uncore_pci_get_dev_die_info() to replace the codes which retrieve
the socket and die informaion.

The pci_set_drvdata() is not included in uncore_pci_pmu_unregister() as
well, because the uncore PCI sub driver will not touch the private
driver data pointer of the device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1600094060-82746-5-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 35 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6c6f8b3..747d237 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1137,18 +1137,38 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	return ret;
 }
 
+/*
+ * Unregister the PMU of a PCI device
+ * @pmu: The corresponding PMU is unregistered.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu,
+				      int phys_id, int die)
+{
+	struct intel_uncore_box *box = pmu->boxes[die];
+
+	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
+		return;
+
+	pmu->boxes[die] = NULL;
+	if (atomic_dec_return(&pmu->activeboxes) == 0)
+		uncore_pmu_unregister(pmu);
+	uncore_box_exit(box);
+	kfree(box);
+}
+
 static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
 	struct intel_uncore_pmu *pmu;
 	int i, phys_id, die;
 
-	phys_id = uncore_pcibus_to_physid(pdev->bus);
+	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+		return;
 
 	box = pci_get_drvdata(pdev);
 	if (!box) {
-		die = (topology_max_die_per_package() > 1) ? phys_id :
-					topology_phys_to_logical_pkg(phys_id);
 		for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
 			if (uncore_extra_pci_dev[die].dev[i] == pdev) {
 				uncore_extra_pci_dev[die].dev[i] = NULL;
@@ -1160,15 +1180,10 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	}
 
 	pmu = box->pmu;
-	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
-		return;
 
 	pci_set_drvdata(pdev, NULL);
-	pmu->boxes[box->dieid] = NULL;
-	if (atomic_dec_return(&pmu->activeboxes) == 0)
-		uncore_pmu_unregister(pmu);
-	uncore_box_exit(box);
-	kfree(box);
+
+	uncore_pci_pmu_unregister(pmu, phys_id, die);
 }
 
 static int __init uncore_pci_init(void)
