Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C92F6002
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbhANLa0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbhANLaW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051CC0613CF;
        Thu, 14 Jan 2021 03:29:05 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0d4H4xAV7z5JKBMuJ4lim7+30dNtAiDgyBQo/zPEODg=;
        b=bhNjLQGplnI1zG6C7q0c7+N4GS3/4uSbq2foMlRqw/EY/uRe4ADomunadff+Fj0FBfdaYb
        C2z8BvjLu5eMER+bNDPrvqpxAiVnLK7rotgsP4arXTayNp2xuGkJrf4gSyIx0/lkJV53CO
        rtW8QUMfz5Fsesp5mwzs70SMzZesEM17A2Yeg6Nvrvfc9Abipys4Di5hZqRSdJC9BbvKcm
        Aqt+hNJSg2cByM2Qrjvz5oGpg0J5lrw+b7wkSkRH7ZnPkaYR//z5LgmKBe+WngJtS/c05o
        gct1Z/hAjWNAjs+lKdjtm0Se5tPFDIG1ZY3Zk+rI77Tr8M4JNfY+Dn5LMccPOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0d4H4xAV7z5JKBMuJ4lim7+30dNtAiDgyBQo/zPEODg=;
        b=OSEALg1ZnvaSSgmtUx5qNsra/gjZ/gZXAHcrCmF+SGWzvnmTwqmW/TDe7Kdsu4Bi/yu6bh
        B1T2TIfVftcKoXBg==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Store the logical die id
 instead of the physical die id.
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108153549.108989-2-steve.wahl@hpe.com>
References: <20210108153549.108989-2-steve.wahl@hpe.com>
MIME-Version: 1.0
Message-ID: <161062374374.414.13192548580822730268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ba9506be4e402ee597b8f41204008b97989b5eef
Gitweb:        https://git.kernel.org/tip/ba9506be4e402ee597b8f41204008b97989b5eef
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 08 Jan 2021 09:35:48 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:13 +01:00

perf/x86/intel/uncore: Store the logical die id instead of the physical die id.

The phys_id isn't really used other than to map to a logical die id.
Calculate the logical die id earlier, and store that instead of the
phys_id.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20210108153549.108989-2-steve.wahl@hpe.com
---
 arch/x86/events/intel/uncore.c       | 58 +++++++++------------------
 arch/x86/events/intel/uncore.h       |  5 +--
 arch/x86/events/intel/uncore_snb.c   |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 31 ++++++--------
 4 files changed, 39 insertions(+), 57 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 357258f..33c8180 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -31,21 +31,21 @@ struct event_constraint uncore_constraint_empty =
 
 MODULE_LICENSE("GPL");
 
-int uncore_pcibus_to_physid(struct pci_bus *bus)
+int uncore_pcibus_to_dieid(struct pci_bus *bus)
 {
 	struct pci2phy_map *map;
-	int phys_id = -1;
+	int die_id = -1;
 
 	raw_spin_lock(&pci2phy_map_lock);
 	list_for_each_entry(map, &pci2phy_map_head, list) {
 		if (map->segment == pci_domain_nr(bus)) {
-			phys_id = map->pbus_to_physid[bus->number];
+			die_id = map->pbus_to_dieid[bus->number];
 			break;
 		}
 	}
 	raw_spin_unlock(&pci2phy_map_lock);
 
-	return phys_id;
+	return die_id;
 }
 
 static void uncore_free_pcibus_map(void)
@@ -86,7 +86,7 @@ lookup:
 	alloc = NULL;
 	map->segment = segment;
 	for (i = 0; i < 256; i++)
-		map->pbus_to_physid[i] = -1;
+		map->pbus_to_dieid[i] = -1;
 	list_add_tail(&map->list, &pci2phy_map_head);
 
 end:
@@ -332,7 +332,6 @@ static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 
 	uncore_pmu_init_hrtimer(box);
 	box->cpu = -1;
-	box->pci_phys_id = -1;
 	box->dieid = -1;
 
 	/* set default hrtimer timeout */
@@ -993,18 +992,11 @@ uncore_types_init(struct intel_uncore_type **types, bool setid)
 /*
  * Get the die information of a PCI device.
  * @pdev: The PCI device.
- * @phys_id: The physical socket id which the device maps to.
  * @die: The die id which the device maps to.
  */
-static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
-				       int *phys_id, int *die)
+static int uncore_pci_get_dev_die_info(struct pci_dev *pdev, int *die)
 {
-	*phys_id = uncore_pcibus_to_physid(pdev->bus);
-	if (*phys_id < 0)
-		return -ENODEV;
-
-	*die = (topology_max_die_per_package() > 1) ? *phys_id :
-				topology_phys_to_logical_pkg(*phys_id);
+	*die = uncore_pcibus_to_dieid(pdev->bus);
 	if (*die < 0)
 		return -EINVAL;
 
@@ -1046,13 +1038,12 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
  * @pdev: The PCI device.
  * @type: The corresponding PMU type of the device.
  * @pmu: The corresponding PMU of the device.
- * @phys_id: The physical socket id which the device maps to.
  * @die: The die id which the device maps to.
  */
 static int uncore_pci_pmu_register(struct pci_dev *pdev,
 				   struct intel_uncore_type *type,
 				   struct intel_uncore_pmu *pmu,
-				   int phys_id, int die)
+				   int die)
 {
 	struct intel_uncore_box *box;
 	int ret;
@@ -1070,7 +1061,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
 
 	atomic_inc(&box->refcnt);
-	box->pci_phys_id = phys_id;
 	box->dieid = die;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
@@ -1097,9 +1087,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
-	int phys_id, die, ret;
+	int die, ret;
 
-	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
+	ret = uncore_pci_get_dev_die_info(pdev, &die);
 	if (ret)
 		return ret;
 
@@ -1132,7 +1122,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	ret = uncore_pci_pmu_register(pdev, type, pmu, phys_id, die);
+	ret = uncore_pci_pmu_register(pdev, type, pmu, die);
 
 	pci_set_drvdata(pdev, pmu->boxes[die]);
 
@@ -1142,17 +1132,12 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 /*
  * Unregister the PMU of a PCI device
  * @pmu: The corresponding PMU is unregistered.
- * @phys_id: The physical socket id which the device maps to.
  * @die: The die id which the device maps to.
  */
-static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu,
-				      int phys_id, int die)
+static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
 {
 	struct intel_uncore_box *box = pmu->boxes[die];
 
-	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
-		return;
-
 	pmu->boxes[die] = NULL;
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
@@ -1164,9 +1149,9 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
 	struct intel_uncore_pmu *pmu;
-	int i, phys_id, die;
+	int i, die;
 
-	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+	if (uncore_pci_get_dev_die_info(pdev, &die))
 		return;
 
 	box = pci_get_drvdata(pdev);
@@ -1185,7 +1170,7 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
-	uncore_pci_pmu_unregister(pmu, phys_id, die);
+	uncore_pci_pmu_unregister(pmu, die);
 }
 
 static int uncore_bus_notify(struct notifier_block *nb,
@@ -1194,7 +1179,7 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	struct device *dev = data;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct intel_uncore_pmu *pmu;
-	int phys_id, die;
+	int die;
 
 	/* Unregister the PMU when the device is going to be deleted. */
 	if (action != BUS_NOTIFY_DEL_DEVICE)
@@ -1204,10 +1189,10 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	if (!pmu)
 		return NOTIFY_DONE;
 
-	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+	if (uncore_pci_get_dev_die_info(pdev, &die))
 		return NOTIFY_DONE;
 
-	uncore_pci_pmu_unregister(pmu, phys_id, die);
+	uncore_pci_pmu_unregister(pmu, die);
 
 	return NOTIFY_OK;
 }
@@ -1224,7 +1209,7 @@ static void uncore_pci_sub_driver_init(void)
 	struct pci_dev *pci_sub_dev;
 	bool notify = false;
 	unsigned int devfn;
-	int phys_id, die;
+	int die;
 
 	while (ids && ids->vendor) {
 		pci_sub_dev = NULL;
@@ -1244,12 +1229,11 @@ static void uncore_pci_sub_driver_init(void)
 			if (!pmu)
 				continue;
 
-			if (uncore_pci_get_dev_die_info(pci_sub_dev,
-							&phys_id, &die))
+			if (uncore_pci_get_dev_die_info(pci_sub_dev, &die))
 				continue;
 
 			if (!uncore_pci_pmu_register(pci_sub_dev, type, pmu,
-						     phys_id, die))
+						     die))
 				notify = true;
 		}
 		ids++;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 9efea15..a3c6e16 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -124,7 +124,6 @@ struct intel_uncore_extra_reg {
 };
 
 struct intel_uncore_box {
-	int pci_phys_id;
 	int dieid;	/* Logical die ID */
 	int n_active;	/* number of active events */
 	int n_events;
@@ -173,11 +172,11 @@ struct freerunning_counters {
 struct pci2phy_map {
 	struct list_head list;
 	int segment;
-	int pbus_to_physid[256];
+	int pbus_to_dieid[256];
 };
 
 struct pci2phy_map *__find_pci2phy_map(int segment);
-int uncore_pcibus_to_physid(struct pci_bus *bus);
+int uncore_pcibus_to_dieid(struct pci_bus *bus);
 
 ssize_t uncore_event_show(struct device *dev,
 			  struct device_attribute *attr, char *buf);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 098f893..5127128 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -657,7 +657,7 @@ int snb_pci2phy_map_init(int devid)
 		pci_dev_put(dev);
 		return -ENOMEM;
 	}
-	map->pbus_to_physid[bus] = 0;
+	map->pbus_to_dieid[bus] = 0;
 	raw_spin_unlock(&pci2phy_map_lock);
 
 	pci_dev_put(dev);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 7bdb182..2d7014d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1359,7 +1359,7 @@ static struct pci_driver snbep_uncore_pci_driver = {
 static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool reverse)
 {
 	struct pci_dev *ubox_dev = NULL;
-	int i, bus, nodeid, segment;
+	int i, bus, nodeid, segment, die_id;
 	struct pci2phy_map *map;
 	int err = 0;
 	u32 config = 0;
@@ -1395,7 +1395,11 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		 */
 		for (i = 0; i < 8; i++) {
 			if (nodeid == ((config >> (3 * i)) & 0x7)) {
-				map->pbus_to_physid[bus] = i;
+				if (topology_max_die_per_package() > 1)
+					die_id = i;
+				else
+					die_id = topology_phys_to_logical_pkg(i);
+				map->pbus_to_dieid[bus] = die_id;
 				break;
 			}
 		}
@@ -1412,17 +1416,17 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			i = -1;
 			if (reverse) {
 				for (bus = 255; bus >= 0; bus--) {
-					if (map->pbus_to_physid[bus] >= 0)
-						i = map->pbus_to_physid[bus];
+					if (map->pbus_to_dieid[bus] >= 0)
+						i = map->pbus_to_dieid[bus];
 					else
-						map->pbus_to_physid[bus] = i;
+						map->pbus_to_dieid[bus] = i;
 				}
 			} else {
 				for (bus = 0; bus <= 255; bus++) {
-					if (map->pbus_to_physid[bus] >= 0)
-						i = map->pbus_to_physid[bus];
+					if (map->pbus_to_dieid[bus] >= 0)
+						i = map->pbus_to_dieid[bus];
 					else
-						map->pbus_to_physid[bus] = i;
+						map->pbus_to_dieid[bus] = i;
 				}
 			}
 		}
@@ -4646,19 +4650,14 @@ int snr_uncore_pci_init(void)
 static struct pci_dev *snr_uncore_get_mc_dev(int id)
 {
 	struct pci_dev *mc_dev = NULL;
-	int phys_id, pkg;
+	int pkg;
 
 	while (1) {
 		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3451, mc_dev);
 		if (!mc_dev)
 			break;
-		phys_id = uncore_pcibus_to_physid(mc_dev->bus);
-		if (phys_id < 0)
-			continue;
-		pkg = topology_phys_to_logical_pkg(phys_id);
-		if (pkg < 0)
-			continue;
-		else if (pkg == id)
+		pkg = uncore_pcibus_to_dieid(mc_dev->bus);
+		if (pkg == id)
 			break;
 	}
 	return mc_dev;
