Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A552CA939
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgLARA6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 12:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgLARA6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 12:00:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E212C0613D4;
        Tue,  1 Dec 2020 09:00:18 -0800 (PST)
Date:   Tue, 01 Dec 2020 17:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606842016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVIMKRD7s9B20AHCrU0fh/AK9+bnfcAmltC1MBzLuZg=;
        b=2UJeKOrOIsaZnK0XJXvK2pB5CtWlS3GLZ/C3TCY2Sz3wSI7RvvG5sdo0i1QZZ2fBat9nox
        7deQ9Wjm38C5PFbe4TLSuRbUkvYpm/ypBhz7a1MKTn/ziAkeGkW8sVhv+zi80EaOSJQOoo
        LL6ViIDNr6TVtBtxVXV1vT+qfja7djwxoVcnXmw+heYNs+mfFf83VrFrw5jUowkXua4EHg
        FHL1I5pQeZH4EwrSiorbvg7P8cql5ZYyAe6nc9OaHG6jtk0AmAmFFv7WDN26KNc4Yf4QiC
        chHPLuK5r3Na8+MWn0Ghv+48Q3hjgI3rPbH/yujF2JgOTE6zppH5RResuuRX3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606842016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVIMKRD7s9B20AHCrU0fh/AK9+bnfcAmltC1MBzLuZg=;
        b=diJsXXxFNpe0avqHJRsVV/tNWxTp4Ee1E1hWy1mRrISk98HEYXPfFDqT3DEA2ppKbmL/lO
        FPQA1vz9HpztB6Cw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
Cc:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <160675180380.15628.3309402017215002347.stgit@bmoger-ubuntu>
References: <160675180380.15628.3309402017215002347.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Message-ID: <160684201570.3364.4966217184350853149.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fae3a13d2a3d49a89391889808428cf1e72afbd7
Gitweb:        https://git.kernel.org/tip/fae3a13d2a3d49a89391889808428cf1e72afbd7
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 30 Nov 2020 09:57:20 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 17:53:31 +01:00

x86/resctrl: Fix AMD L3 QOS CDP enable/disable

When the AMD QoS feature CDP (code and data prioritization) is enabled
or disabled, the CDP bit in MSR 0000_0C81 is written on one of the CPUs
in an L3 domain (core complex). That is not correct - the CDP bit needs
to be updated on all the logical CPUs in the domain.

This was not spelled out clearly in the spec earlier. The specification
has been updated and the updated document, "AMD64 Technology Platform
Quality of Service Extensions Publication # 56375 Revision: 1.02 Issue
Date: October 2020" is available now. Refer the section: Code and Data
Prioritization.

Fix the issue by adding a new flag arch_has_per_cpu_cfg in rdt_cache
data structure.

The documentation can be obtained at:
https://developer.amd.com/wp-content/resources/56375.pdf
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

 [ bp: Massage commit message. ]

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/160675180380.15628.3309402017215002347.stgit@bmoger-ubuntu
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e5f4ee8..e8b5f1c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -570,6 +570,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
+		if (r->cache.arch_has_per_cpu_cfg)
+			rdt_domain_reconfigure_cdp(r);
 		return;
 	}
 
@@ -923,6 +925,7 @@ static __init void rdt_init_res_defs_intel(void)
 		    r->rid == RDT_RESOURCE_L2CODE) {
 			r->cache.arch_has_sparse_bitmaps = false;
 			r->cache.arch_has_empty_bitmaps = false;
+			r->cache.arch_has_per_cpu_cfg = false;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
@@ -943,6 +946,7 @@ static __init void rdt_init_res_defs_amd(void)
 		    r->rid == RDT_RESOURCE_L2CODE) {
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
+			r->cache.arch_has_per_cpu_cfg = true;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 80fa997..f65d3c0 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -360,6 +360,8 @@ struct msr_param {
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
  * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
+ * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
+ *				level has CPU scope.
  */
 struct rdt_cache {
 	unsigned int	cbm_len;
@@ -369,6 +371,7 @@ struct rdt_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmaps;
 	bool		arch_has_empty_bitmaps;
+	bool		arch_has_per_cpu_cfg;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6f4ca4b..f341842 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1909,8 +1909,13 @@ static int set_cache_qos_cfg(int level, bool enable)
 
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
-		/* Pick one CPU from each domain instance to update MSR */
-		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
+		if (r_l->cache.arch_has_per_cpu_cfg)
+			/* Pick all the CPUs in the domain instance */
+			for_each_cpu(cpu, &d->cpu_mask)
+				cpumask_set_cpu(cpu, cpu_mask);
+		else
+			/* Pick one CPU from each domain instance to update MSR */
+			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 	}
 	cpu = get_cpu();
 	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */
