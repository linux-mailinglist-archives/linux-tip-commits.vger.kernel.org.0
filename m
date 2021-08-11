Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFF3E98FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhHKTlx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhHKTlu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7EFC061765;
        Wed, 11 Aug 2021 12:41:26 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIghVIwGAZqbWXN1P31HLY0wWptiVayPJnAq+roDI2s=;
        b=eM0wmglbeUdW7N+tTx0gMhWv96NM5oj1fVcSrfjltmterJMHGeE3AVROR7DL5txQI0pVrP
        4FvBCAjDStaT5T5nuj0H+RuT3XoyOSfUvR6jZMx122VdxDYFQ/9DS5wtvOtNThGgzDDHKB
        cXJHP5BHRKGLrI1UFrj148aFtODyr6biEYdtfw5ka0WAHYcoYF0DqKK21pawEc1WG8H23/
        P9Mu2/6BD2n6joTgg7u1kLjRh5ThzfyhmPymlYDL5rdn0IghwCntz5X/E2+Gne1e+zbCeE
        jnpW70GYIrlds91zRsispFq/S/eb7Y9iYqAcLcKptzQIe3hjbtyvB98LRUA0uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIghVIwGAZqbWXN1P31HLY0wWptiVayPJnAq+roDI2s=;
        b=2wbHb+11jkl5Ld21nYN4wr+H81ihBzd6d0ef0O0cOw25L45CcORV+4U28Z5HvpYGwxcDCp
        mRSv1tteEUWzBdAg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Apply offset correction when config is staged
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-20-james.morse@arm.com>
References: <20210728170637.25610-20-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088441.395.11996776002479744747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2e7df368fc9260ac2229335755de2f403ec8f08f
Gitweb:        https://git.kernel.org/tip/2e7df368fc9260ac2229335755de2f403ec8f08f
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:32 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 18:03:28 +02:00

x86/resctrl: Apply offset correction when config is staged

When resctrl comes to copy the CAT MSR values from the ctrl_val[] array
into hardware, it applies an offset adjustment based on the type of
the resource. CODE and DATA resources have their closid mapped into an
odd/even range. This mapping is based on a property of the resource.

This happens once the new control value has been written to the ctrl_val[]
array. Once the CDP resources are merged, there will only be a single
property that needs to cover both odd/even mappings to the single
ctrl_val[] array. The offset adjustment must be applied before the new
value is written to the array.

Move the logic from cat_wrmsr() to resctrl_arch_update_domains(). The
value provided to apply_config() is now an index in the array, not the
closid. The parameters provided via struct msr_param are now indexes
too. As resctrl's use of closid is a u32, struct msr_param's type is
changed to match.

With this, the CODE and DATA resources only use the odd or even
indexes in the array. This allows the temporary num_closid/2 fixes in
domain_setup_ctrlval() and reset_all_ctrls() to be removed.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-20-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 15 +----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 32 ++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/internal.h    |  4 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  7 +-----
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9f8be5e..990e416 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -195,11 +195,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 };
 
-static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
-{
-	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
-}
-
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
@@ -438,7 +433,7 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -549,14 +544,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
-
-	/*
-	 * temporary: the array is full-size, but cat_wrmsr() still re-maps
-	 * the index.
-	 */
-	if (hw_res->conf_type != CDP_NONE)
-		m.high /= 2;
-
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9ead0c0..fdb0e11 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -246,17 +246,29 @@ next:
 	return -EINVAL;
 }
 
-static void apply_config(struct rdt_hw_domain *hw_dom,
-			 struct resctrl_staged_config *cfg, int closid,
+static u32 cbm_idx(struct rdt_resource *r, unsigned int closid)
+{
+	if (r->rid == RDT_RESOURCE_MBA)
+		return closid;
+
+	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
+}
+
+static bool apply_config(struct rdt_hw_domain *hw_dom,
+			 struct resctrl_staged_config *cfg, u32 idx,
 			 cpumask_var_t cpu_mask, bool mba_sc)
 {
 	struct rdt_domain *dom = &hw_dom->d_resctrl;
 	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 
-	if (cfg->new_ctrl != dc[closid]) {
+	if (cfg->new_ctrl != dc[idx]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		dc[closid] = cfg->new_ctrl;
+		dc[idx] = cfg->new_ctrl;
+
+		return true;
 	}
+
+	return false;
 }
 
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
@@ -269,11 +281,12 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	struct rdt_domain *d;
 	bool mba_sc;
 	int cpu;
+	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	msr_param.low = closid;
+	msr_param.low = cbm_idx(r, closid);
 	msr_param.high = msr_param.low + 1;
 	msr_param.res = r;
 
@@ -285,7 +298,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
+			idx = cbm_idx(r, closid);
+			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
+				continue;
 		}
 	}
 
@@ -405,11 +420,12 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	u32 idx = cbm_idx(r, closid);
 
 	if (!is_mba_sc(r))
-		*value = hw_dom->ctrl_val[closid];
+		*value = hw_dom->ctrl_val[idx];
 	else
-		*value = hw_dom->mbps_val[closid];
+		*value = hw_dom->mbps_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a95893e..e8751d0 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -332,8 +332,8 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
  */
 struct msr_param {
 	struct rdt_resource	*res;
-	int			low;
-	int			high;
+	u32			low;
+	u32			high;
 };
 
 static inline bool is_llc_occupancy_enabled(void)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 299af12..1f72517 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2379,13 +2379,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	msr_param.high = hw_res->num_closid;
 
 	/*
-	 * temporary: the array is full-sized, but cat_wrmsr() still re-maps
-	 * the index.
-	 */
-	if (hw_res->cdp_enabled)
-		msr_param.high /= 2;
-
-	/*
 	 * Disable resource control for this resource by setting all
 	 * CBMs in all domains to the maximum mask value. Pick one CPU
 	 * from each domain to update the MSRs below.
