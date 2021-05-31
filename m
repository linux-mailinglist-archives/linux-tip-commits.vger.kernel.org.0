Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5DD395913
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhEaKm0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 06:42:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaKmY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 06:42:24 -0400
Date:   Mon, 31 May 2021 10:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622457643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTz2L42ZwBpHBy4F6uVDUTqvjYZuPhM1myiut8fUYPw=;
        b=EsFImvGScUMb8MVyzZfSuilvTFC9FTTBwW4DQpee3F8yvSpUymWIFyIL/YGZGE0H0c6yZi
        ULU+UhtPQZXkJRPDTkbwWonAn7IlJhqX7iDatIWpCQjd/5eqylJGXH3OAmAc2qtxlxhoEb
        ih6c5lf0azmC6D2+FfjUCcu4WsMo2xGblM5Ii9kS/H4chePHUP/OVSkISmoqf7QQCe4Uyu
        siupA1fayK9v6YODMwL9+HrsbpjB1MdCErfq5gAt9wJLkXQCe8t2+QUCLB26WmlnhQdCxA
        bsIgMuIMLFe5w98bL5QxYLG9hXJZL58jgqlw5S8hjLLS5jyfA+K8WCVh85N1Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622457643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTz2L42ZwBpHBy4F6uVDUTqvjYZuPhM1myiut8fUYPw=;
        b=PpvGHc/w1Syj/+6lx0qezWZ6P8/TGnB7F4kzZ/M6QcLgGYCzD4hVjs731XpHz1DBcmR4Li
        5uL7v5Vf4T2SggAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix a kernel WARNING
 triggered by maxcpus=1
Cc:     John Donnelly <john.p.donnelly@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1622037527-156028-1-git-send-email-kan.liang@linux.intel.com>
References: <1622037527-156028-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162245764326.29796.16594314779095776973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4a0e3ff30980b7601b13dd3b7ee275212b852843
Gitweb:        https://git.kernel.org/tip/4a0e3ff30980b7601b13dd3b7ee275212b852843
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 May 2021 06:58:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 31 May 2021 10:14:51 +02:00

perf/x86/intel/uncore: Fix a kernel WARNING triggered by maxcpus=1

A kernel WARNING may be triggered when setting maxcpus=1.

The uncore counters are Die-scope. When probing a PCI device, only the
BUS information can be retrieved. The uncore driver has to maintain a
mapping table used to calculate the logical Die ID from a given BUS#.

Before the patch ba9506be4e40, the mapping table stores the mapping
information from the BUS# -> a Physical Socket ID. To calculate the
logical die ID, perf does,
- In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
  from the UBOX PCI configure space.
- Calculate the mapping information (a BUS# -> a Physical Socket ID) for
  the other PCI BUS.
- In the uncore_pci_probe(), get the physical Socket ID from a given BUS
  and the mapping table.
- Calculate the logical Die ID

Since only the logical Die ID is required, with the patch ba9506be4e40,
the mapping table stores the mapping information from the BUS# -> a
logical Die ID. Now perf does,
- In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
  from the UBOX PCI configure space.
- Calculate the logical Die ID
- Calculate the mapping information (a BUS# -> a logical Die ID) for the
  other PCI BUS.
- In the uncore_pci_probe(), get the logical die ID from a given BUS and
  the mapping table.

When calculating the logical Die ID, -1 may be returned, especially when
maxcpus=1. Here, -1 means the logical Die ID is not found. But when
calculating the mapping information for the other PCI BUS, -1 indicates
that it's the other PCI BUS that requires the calculation of the
mapping. The driver will mistakenly do the calculation.

Uses the -ENODEV to indicate the case which the logical Die ID is not
found. The driver will not mess up the mapping table anymore.

Fixes: ba9506be4e40 ("perf/x86/intel/uncore: Store the logical die id instead of the physical die id.")
Reported-by: John Donnelly <john.p.donnelly@oracle.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: John Donnelly <john.p.donnelly@oracle.com>
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
Link: https://lkml.kernel.org/r/1622037527-156028-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 63f0972..1587d32 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1406,6 +1406,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 						die_id = i;
 					else
 						die_id = topology_phys_to_logical_pkg(i);
+					if (die_id < 0)
+						die_id = -ENODEV;
 					map->pbus_to_dieid[bus] = die_id;
 					break;
 				}
@@ -1452,14 +1454,14 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			i = -1;
 			if (reverse) {
 				for (bus = 255; bus >= 0; bus--) {
-					if (map->pbus_to_dieid[bus] >= 0)
+					if (map->pbus_to_dieid[bus] != -1)
 						i = map->pbus_to_dieid[bus];
 					else
 						map->pbus_to_dieid[bus] = i;
 				}
 			} else {
 				for (bus = 0; bus <= 255; bus++) {
-					if (map->pbus_to_dieid[bus] >= 0)
+					if (map->pbus_to_dieid[bus] != -1)
 						i = map->pbus_to_dieid[bus];
 					else
 						map->pbus_to_dieid[bus] = i;
