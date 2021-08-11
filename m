Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7E3E98F6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhHKTlw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHKTlt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:49 -0400
Date:   Wed, 11 Aug 2021 19:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFn4NmybN1C0/aGKkeo43xgM26bZjfK9VfUmg08/DQk=;
        b=BrCXqU+Pv0ibhlNuIECUTiglZoQ8KkLn9tvwzp+nq1lJnxSF0H6NyIJuTUvZs/tTqETm5J
        itQ1117izrpXawJRqyavWsmZUL4VUuHO+Q/H6Fwqc8Q880TnPnjVh9HUfNo0jYXdJUBy4g
        4+AY+yCrVQqrJwMcOl8cchLbYUPoZtv2sIXR6niBN5BdXrrxsetayOqmm8RL/5aICTWObk
        723Dx4n/xNBDJA5yL+mettER/KmvCdv3kBd5IPz0o/PNIQRiU+PlTMIxM3X/owrI+UDSms
        Ryfbi8T9LmsqtXn9NJetpXSsh3iAfvShEjwP9pF07wKHVDDoeapvI9wKHIF4ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFn4NmybN1C0/aGKkeo43xgM26bZjfK9VfUmg08/DQk=;
        b=/ZjONX3Kzr8MVcL40TtM9heZOGfu6gWMDbI/6s7yGNn8Cd0973bSpK/VW0RavgS4Yo3IRy
        TWBLkTruXHGuL3Dw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Calculate the index from the configuration type
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-21-james.morse@arm.com>
References: <20210728170637.25610-21-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088386.395.9995051701038255004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2b8dd4ab65dad1251822fbf74fb0d5623e4eaee0
Gitweb:        https://git.kernel.org/tip/2b8dd4ab65dad1251822fbf74fb0d5623e4eaee0
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:33 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 18:19:06 +02:00

x86/resctrl: Calculate the index from the configuration type

resctrl uses cbm_idx() to map a closid to an index in the configuration
array. This is based on a multiplier and offset that are held in the
resource.

To merge the resources, the resctrl arch code needs to calculate the
index from something else, as there will only be one resource.

Decide based on the staged configuration type. This makes the static
mult and offset parameters redundant.

 [ bp: Remove superfluous brackets in get_config_index() ]

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-21-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 12 +-----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 25 +++++++++++++---------
 include/linux/resctrl.h                   |  6 +-----
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 990e416..c6b953f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -69,8 +69,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 1,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
@@ -89,8 +87,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3DATA),
 			.parse_ctrlval		= parse_cbm,
@@ -109,8 +105,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 1,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3CODE),
 			.parse_ctrlval		= parse_cbm,
@@ -129,8 +123,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 1,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
@@ -149,8 +141,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2DATA),
 			.parse_ctrlval		= parse_cbm,
@@ -169,8 +159,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 1,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2CODE),
 			.parse_ctrlval		= parse_cbm,
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index fdb0e11..92d79c8 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -246,12 +246,17 @@ next:
 	return -EINVAL;
 }
 
-static u32 cbm_idx(struct rdt_resource *r, unsigned int closid)
+static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 {
-	if (r->rid == RDT_RESOURCE_MBA)
+	switch (type) {
+	default:
+	case CDP_NONE:
 		return closid;
-
-	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
+	case CDP_CODE:
+		return closid * 2 + 1;
+	case CDP_DATA:
+		return closid * 2;
+	}
 }
 
 static bool apply_config(struct rdt_hw_domain *hw_dom,
@@ -286,10 +291,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	msr_param.low = cbm_idx(r, closid);
-	msr_param.high = msr_param.low + 1;
-	msr_param.res = r;
-
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
@@ -298,9 +299,13 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = cbm_idx(r, closid);
+			idx = get_config_index(closid, t);
 			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
 				continue;
+
+			msr_param.low = idx;
+			msr_param.high = msr_param.low + 1;
+			msr_param.res = r;
 		}
 	}
 
@@ -420,7 +425,7 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	u32 idx = cbm_idx(r, closid);
+	u32 idx = get_config_index(closid, type);
 
 	if (!is_mba_sc(r))
 		*value = hw_dom->ctrl_val[idx];
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 69d7387..18dd764 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -73,10 +73,6 @@ struct rdt_domain {
  * struct resctrl_cache - Cache allocation related data
  * @cbm_len:		Length of the cache bit mask
  * @min_cbm_bits:	Minimum number of consecutive bits to be set
- * @cbm_idx_mult:	Multiplier of CBM index
- * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
- *			closid * cbm_idx_multi + cbm_idx_offset
- *			in a cache bit mask
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
@@ -87,8 +83,6 @@ struct rdt_domain {
 struct resctrl_cache {
 	unsigned int	cbm_len;
 	unsigned int	min_cbm_bits;
-	unsigned int	cbm_idx_mult;	// TODO remove this
-	unsigned int	cbm_idx_offset; // TODO remove this
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmaps;
 	bool		arch_has_empty_bitmaps;
