Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6333E9903
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhHKTmA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53712 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhHKTlz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:55 -0400
Date:   Wed, 11 Aug 2021 19:41:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXAZ+Xt6A1GyNN9XGn1299ULe17QyaNU8v9p5I2YKD0=;
        b=QtAz0UZGvorRAnWJgAEeOAj7cwQG1E10uDT2B02RrBH5sEw+78/MIKOjVnRiSE/m99C7Ed
        2EKuRxi7yzi0FgtE3VOHqgMBfNvkPhLnCa9P823IMCnMZG99iXO6DIeL7yOBfxLwUlTkeU
        COJW/0K0pLDO+4b2znnJr0/LRZg0Lkvg/Q9+daKOVC9j1a9ui4elF9qtMrwGv5658q+CGw
        FDRaeg1TlesKD2AJ2sOpbuGcvx69yBfvIfv2rdq5QL7EgOMamTl3IbANdWi3a+nrNE5F4g
        Zm8WS8rGy9E5bWC4jyV7bmbFdqiINM/9NDEsCYKBBKhTBvvkYYFsF7txsu/E0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXAZ+Xt6A1GyNN9XGn1299ULe17QyaNU8v9p5I2YKD0=;
        b=xGZ6x+4ED5pvkHTa5lMTlDcAY+Os7Gouq3WE26h33/dHIygDs+lR0CbDZOQuZaWjvRwl4o
        b9r3MuJcZosfbWDQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Swizzle rdt_resource and resctrl_schema
 in pseudo_lock_region
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-11-james.morse@arm.com>
References: <20210728170637.25610-11-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088954.395.14808448608337449785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     32150edd3fcf6ee002668878e0b010d402db29b2
Gitweb:        https://git.kernel.org/tip/32150edd3fcf6ee002668878e0b010d402db29b2
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:23 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 15:51:45 +02:00

x86/resctrl: Swizzle rdt_resource and resctrl_schema in pseudo_lock_region

struct pseudo_lock_region points to the rdt_resource.

Once the resources are merged, this won't be unique. The resource name
is moving into the schema, so that the filesystem portions of resctrl can
generate it.

Swap pseudo_lock_region's rdt_resource pointer for a schema pointer.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-11-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 6 +++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 219b057..0ee1ded 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -227,7 +227,7 @@ next:
 				 * the required initialization for single
 				 * region and return.
 				 */
-				rdtgrp->plr->r = r;
+				rdtgrp->plr->s = s;
 				rdtgrp->plr->d = d;
 				rdtgrp->plr->cbm = d->new_ctrl;
 				d->plr = rdtgrp->plr;
@@ -426,7 +426,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 				ret = -ENODEV;
 			} else {
 				seq_printf(s, "%s:%d=%x\n",
-					   rdtgrp->plr->r->name,
+					   rdtgrp->plr->s->res->name,
 					   rdtgrp->plr->d->id,
 					   rdtgrp->plr->cbm);
 			}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5d5debe..c8521ef 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -163,8 +163,8 @@ struct mongroup {
 
 /**
  * struct pseudo_lock_region - pseudo-lock region information
- * @r:			RDT resource to which this pseudo-locked region
- *			belongs
+ * @s:			Resctrl schema for the resource to which this
+ *			pseudo-locked region belongs
  * @d:			RDT domain to which this pseudo-locked region
  *			belongs
  * @cbm:		bitmask of the pseudo-locked region
@@ -184,7 +184,7 @@ struct mongroup {
  * @pm_reqs:		Power management QoS requests related to this region
  */
 struct pseudo_lock_region {
-	struct rdt_resource	*r;
+	struct resctrl_schema	*s;
 	struct rdt_domain	*d;
 	u32			cbm;
 	wait_queue_head_t	lock_thread_wq;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 17868ac..3c035a7 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -250,7 +250,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 	plr->line_size = 0;
 	kfree(plr->kmem);
 	plr->kmem = NULL;
-	plr->r = NULL;
+	plr->s = NULL;
 	if (plr->d)
 		plr->d->plr = NULL;
 	plr->d = NULL;
@@ -294,10 +294,10 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 
 	ci = get_cpu_cacheinfo(plr->cpu);
 
-	plr->size = rdtgroup_cbm_to_size(plr->r, plr->d, plr->cbm);
+	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
 
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->r->cache_level) {
+		if (ci->info_list[i].level == plr->s->res->cache_level) {
 			plr->line_size = ci->info_list[i].coherency_line_size;
 			return 0;
 		}
@@ -800,7 +800,7 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
 	unsigned long cbm_b;
 
 	if (d->plr) {
-		cbm_len = d->plr->r->cache.cbm_len;
+		cbm_len = d->plr->s->res->cache.cbm_len;
 		cbm_b = d->plr->cbm;
 		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
 			return true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 53d281a..305dcf8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1439,8 +1439,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			ret = -ENODEV;
 		} else {
 			seq_printf(s, "%*s:", max_name_width,
-				   rdtgrp->plr->r->name);
-			size = rdtgroup_cbm_to_size(rdtgrp->plr->r,
+				   rdtgrp->plr->s->res->name);
+			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
 						    rdtgrp->plr->d,
 						    rdtgrp->plr->cbm);
 			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
