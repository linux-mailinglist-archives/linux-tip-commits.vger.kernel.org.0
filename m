Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31A52F6003
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbhANLa0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbhANLaW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AEDC0613D3;
        Thu, 14 Jan 2021 03:29:05 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPB/l6LYFmvtproCxCZaLMkpJc1Hwdo0Nf5pwaE+DjY=;
        b=pO5ZLpFS9fv4yvWl7Inqp36+qgIAeuGVFkvrsBvyy3ygqxrnsY59GKqTh+2ACBCRaJToXJ
        GYrEfb+dtLrIsPGBK2FP/uWqe3co1bXyu87/VcXujTT5t1vsFQ2fHZ28aEwNRPds3eYnUO
        lap5Kb5jgQfoniEwlJu0/6xVlAgMz04mMbMTCs80YvQXSCW+KK5EQwsQTxJw/8S7HtA4Js
        u+RMlzqsFNuWnhYGz9iHrYCQz4F2XZo5Mb/3N5Td2QBaiJbE5VLv2ULORmdfMUUD22eO35
        c53uVt1WLluC16UEkr6joaOeUCMKS4weonxUZr8d7pfpCV1Az0ueOA6tCzPoWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPB/l6LYFmvtproCxCZaLMkpJc1Hwdo0Nf5pwaE+DjY=;
        b=5zB/hCzmG72d6ynFW7A0sgUlk5TPNwO26Mb08bcUwvBuD2Jga7vJGfXb32nzg95Kow2KFb
        yzve4cknGv2JNMAQ==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: With > 8 nodes, get pci bus
 die id from NUMA info
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108153549.108989-3-steve.wahl@hpe.com>
References: <20210108153549.108989-3-steve.wahl@hpe.com>
MIME-Version: 1.0
Message-ID: <161062374347.414.10709302386439251120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9a7832ce3d920426a36cdd78eda4b3568d4d09e3
Gitweb:        https://git.kernel.org/tip/9a7832ce3d920426a36cdd78eda4b3568d4d09e3
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 08 Jan 2021 09:35:49 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:14 +01:00

perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info

The registers used to determine which die a pci bus belongs to don't
contain enough information to uniquely specify more than 8 dies, so
when more than 8 dies are present, use NUMA information instead.

Continue to use the previous method for 8 or fewer because it
works there, and covers cases of NUMA being disabled.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20210108153549.108989-3-steve.wahl@hpe.com
---
 arch/x86/events/intel/uncore_snbep.c | 93 ++++++++++++++++++---------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2d7014d..b79951d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1370,40 +1370,77 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		if (!ubox_dev)
 			break;
 		bus = ubox_dev->bus->number;
-		/* get the Node ID of the local register */
-		err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
-		if (err)
-			break;
-		nodeid = config & NODE_ID_MASK;
-		/* get the Node ID mapping */
-		err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
-		if (err)
-			break;
+		/*
+		 * The nodeid and idmap registers only contain enough
+		 * information to handle 8 nodes.  On systems with more
+		 * than 8 nodes, we need to rely on NUMA information,
+		 * filled in from BIOS supplied information, to determine
+		 * the topology.
+		 */
+		if (nr_node_ids <= 8) {
+			/* get the Node ID of the local register */
+			err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
+			if (err)
+				break;
+			nodeid = config & NODE_ID_MASK;
+			/* get the Node ID mapping */
+			err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
+			if (err)
+				break;
 
-		segment = pci_domain_nr(ubox_dev->bus);
-		raw_spin_lock(&pci2phy_map_lock);
-		map = __find_pci2phy_map(segment);
-		if (!map) {
+			segment = pci_domain_nr(ubox_dev->bus);
+			raw_spin_lock(&pci2phy_map_lock);
+			map = __find_pci2phy_map(segment);
+			if (!map) {
+				raw_spin_unlock(&pci2phy_map_lock);
+				err = -ENOMEM;
+				break;
+			}
+
+			/*
+			 * every three bits in the Node ID mapping register maps
+			 * to a particular node.
+			 */
+			for (i = 0; i < 8; i++) {
+				if (nodeid == ((config >> (3 * i)) & 0x7)) {
+					if (topology_max_die_per_package() > 1)
+						die_id = i;
+					else
+						die_id = topology_phys_to_logical_pkg(i);
+					map->pbus_to_dieid[bus] = die_id;
+					break;
+				}
+			}
 			raw_spin_unlock(&pci2phy_map_lock);
-			err = -ENOMEM;
-			break;
-		}
+		} else {
+			int node = pcibus_to_node(ubox_dev->bus);
+			int cpu;
+
+			segment = pci_domain_nr(ubox_dev->bus);
+			raw_spin_lock(&pci2phy_map_lock);
+			map = __find_pci2phy_map(segment);
+			if (!map) {
+				raw_spin_unlock(&pci2phy_map_lock);
+				err = -ENOMEM;
+				break;
+			}
 
-		/*
-		 * every three bits in the Node ID mapping register maps
-		 * to a particular node.
-		 */
-		for (i = 0; i < 8; i++) {
-			if (nodeid == ((config >> (3 * i)) & 0x7)) {
-				if (topology_max_die_per_package() > 1)
-					die_id = i;
-				else
-					die_id = topology_phys_to_logical_pkg(i);
-				map->pbus_to_dieid[bus] = die_id;
+			die_id = -1;
+			for_each_cpu(cpu, cpumask_of_pcibus(ubox_dev->bus)) {
+				struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+				if (c->initialized && cpu_to_node(cpu) == node) {
+					map->pbus_to_dieid[bus] = die_id = c->logical_die_id;
+					break;
+				}
+			}
+			raw_spin_unlock(&pci2phy_map_lock);
+
+			if (WARN_ON_ONCE(die_id == -1)) {
+				err = -EINVAL;
 				break;
 			}
 		}
-		raw_spin_unlock(&pci2phy_map_lock);
 	}
 
 	if (!err) {
