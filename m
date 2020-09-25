Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7392727871B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgIYMYI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:24:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgIYMX6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:58 -0400
Date:   Fri, 25 Sep 2020 12:23:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/d9ahn+s2EWI3jhvWV8bgJWb2Qb1i+cQdJeI4Yl5WtI=;
        b=eKTvYcQvMybq5CLUVTlXYrOUIKh8T53NAU+gofje8nbU+U4xzyEze24gwQjZ43wVMCW8ni
        SfTJvBK94uMO74HLH+BaiAsCAedq0xbvfUlV9kfr+ihvg571f6kCjGKyzw9XKcOgbnTKSZ
        +eEAZ8jR3iZMSzy0oKZH82ZYhJNc4mPvubL+WNaxklJLb/gSqQLRoltiACpauj+BD0n4xG
        IOZp9WlayCTZe9AsOouwx+FBFtn1qAG4S0ytUnv1xW8VglQ3IhsjmTEIq6AMQPGTmn1HLo
        mNvAE5j+0rkPRVgue3rtlagJoAvC5/g4nDOzbUllIIP/4+212XahTWy8PArLBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/d9ahn+s2EWI3jhvWV8bgJWb2Qb1i+cQdJeI4Yl5WtI=;
        b=NrSI3+SrW5duAnPHMmpjGWPD/9jvbDprxer/IiMBhETkH7P0vwzFjJitJVs5W4JAlSzj4B
        78l2ij2Tiw3/EfCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out
 uncore_pci_get_dev_die_info()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600094060-82746-2-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160103663492.7002.9442035546439230469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fe6507338d635f283e9618b5eaa35f503a8c375b
Gitweb:        https://git.kernel.org/tip/fe6507338d635f283e9618b5eaa35f503a8c375b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 14 Sep 2020 07:34:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:50 +02:00

perf/x86/intel/uncore: Factor out uncore_pci_get_dev_die_info()

The socket and die information is required to register/unregister a PMU
in the uncore PCI sub driver. The codes, which get the socket and die
information from a BUS number, can be shared.

Factor out uncore_pci_get_dev_die_info(), which will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1600094060-82746-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d5c6d3b..e14b03f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -989,6 +989,26 @@ uncore_types_init(struct intel_uncore_type **types, bool setid)
 }
 
 /*
+ * Get the die information of a PCI device.
+ * @pdev: The PCI device.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
+				       int *phys_id, int *die)
+{
+	*phys_id = uncore_pcibus_to_physid(pdev->bus);
+	if (*phys_id < 0)
+		return -ENODEV;
+
+	*die = (topology_max_die_per_package() > 1) ? *phys_id :
+				topology_phys_to_logical_pkg(*phys_id);
+	if (*die < 0)
+		return -EINVAL;
+
+	return 0;
+}
+/*
  * add a pci uncore device
  */
 static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -998,14 +1018,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
-	phys_id = uncore_pcibus_to_physid(pdev->bus);
-	if (phys_id < 0)
-		return -ENODEV;
-
-	die = (topology_max_die_per_package() > 1) ? phys_id :
-					topology_phys_to_logical_pkg(phys_id);
-	if (die < 0)
-		return -EINVAL;
+	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
+	if (ret)
+		return ret;
 
 	if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
 		int idx = UNCORE_PCI_DEV_IDX(id->driver_data);
