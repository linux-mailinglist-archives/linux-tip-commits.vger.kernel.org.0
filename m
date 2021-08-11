Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8303E98F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhHKTlu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhHKTlt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79294C061765;
        Wed, 11 Aug 2021 12:41:25 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55PEiuM9+Z9jBTMWXE0Cb3ZI9QviEBwsFe4LDQ2CRuo=;
        b=U0eCrvNl4LkMRX0NNWDpzLwjpe3laM4xFl7+s8Kz1ijo2fhlDNKS9sALMs9a/KrJTW+r4h
        LOIXcaBhRSBexhy/l65aNfJ0HaVOL7QLGidXjBVNLM/0ek2dr1waC8GWErRCN36pfyGtkl
        ihAC24Cfkd+ze6CwuC5L3dXbKzCG/3m9NYbvXKDugesRNVTZqita/N4si/vI1CluReFRau
        zsGVMG1E5cK5lgM/dMhJ/9yFjRankGlLLcp1BhFM59agNGprtvx82cR5+5EXXE2Ex21wT2
        Xrp+dseFGpwsNTIhVsZgYzX7KR5mgGFmnvVt6jIW2BIpMsRnjp8U8fOrk2QeQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55PEiuM9+Z9jBTMWXE0Cb3ZI9QviEBwsFe4LDQ2CRuo=;
        b=NAchkK15ZrnDBW5hqwwD3TUvdw1UuJn5tyUIysc0k1OF1WBSxl02zIgmss/IEjdcGo5d6r
        UAWQ6Fw46rzW9cBA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Merge the ctrl_val arrays
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-22-james.morse@arm.com>
References: <20210728170637.25610-22-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088330.395.12737790269477822914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     43ac1dbf6101722944758f364ea39859d5db3ce0
Gitweb:        https://git.kernel.org/tip/43ac1dbf6101722944758f364ea39859d5db3ce0
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:34 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 18:31:04 +02:00

x86/resctrl: Merge the ctrl_val arrays

Each struct rdt_hw_resource has its own ctrl_val[] array. When CDP is
enabled, two resources are in use, each with its own ctrl_val[] array
that holds half of the configuration used by hardware. One uses the odd
slots, the other the even. rdt_cdp_peer_get() is the helper to find the
alternate resource, its domain, and corresponding entry in the other
ctrl_val[] array.

Once the CDP resources are merged there will be one struct
rdt_hw_resource and one ctrl_val[] array for each hardware resource.
This will include changes to rdt_cdp_peer_get(), making it hard to
bisect any issue.

Merge the ctrl_val[] arrays for three CODE/DATA/NONE resources first.
Doing this before merging the resources temporarily complicates
allocating and freeing the ctrl_val arrays. Add a helper to allocate
the ctrl_val array, that returns the value on the L2 or L3 resource if
it already exists. This gets removed once the resources are merged, and
there really is only one ctrl_val[] array.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-22-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 65 +++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c6b953f..4c0b126 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -509,6 +509,57 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	}
 }
 
+static u32 *alloc_ctrlval_array(struct rdt_resource *r, struct rdt_domain *d,
+				bool mba_sc)
+{
+	/* these are for the underlying hardware, they may not match r/d */
+	struct rdt_domain *underlying_domain;
+	struct rdt_hw_resource *hw_res;
+	struct rdt_hw_domain *hw_dom;
+	bool remapped;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3DATA:
+	case RDT_RESOURCE_L3CODE:
+		hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
+		remapped = true;
+		break;
+	case RDT_RESOURCE_L2DATA:
+	case RDT_RESOURCE_L2CODE:
+		hw_res = &rdt_resources_all[RDT_RESOURCE_L2];
+		remapped = true;
+		break;
+	default:
+		hw_res = resctrl_to_arch_res(r);
+		remapped = false;
+	}
+
+	/*
+	 * If we changed the resource, we need to search for the underlying
+	 * domain. Doing this for all resources would make it tricky to add the
+	 * first resource, as domains aren't added to a resource list until
+	 * after the ctrlval arrays have been allocated.
+	 */
+	if (remapped)
+		underlying_domain = rdt_find_domain(&hw_res->r_resctrl, d->id,
+						    NULL);
+	else
+		underlying_domain = d;
+	hw_dom = resctrl_to_arch_dom(underlying_domain);
+
+	if (mba_sc) {
+		if (hw_dom->mbps_val)
+			return hw_dom->mbps_val;
+		return kmalloc_array(hw_res->num_closid,
+				     sizeof(*hw_dom->mbps_val), GFP_KERNEL);
+	} else {
+		if (hw_dom->ctrl_val)
+			return hw_dom->ctrl_val;
+		return kmalloc_array(hw_res->num_closid,
+				     sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
+	}
+}
+
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -516,11 +567,11 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
+	dc = alloc_ctrlval_array(r, d, false);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val), GFP_KERNEL);
+	dm = alloc_ctrlval_array(r, d, true);
 	if (!dm) {
 		kfree(dc);
 		return -ENOMEM;
@@ -679,8 +730,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
+		/* temporary: these four don't have a unique ctrlval array */
+		if (r->rid != RDT_RESOURCE_L3CODE &&
+		    r->rid != RDT_RESOURCE_L3DATA &&
+		    r->rid != RDT_RESOURCE_L2CODE &&
+		    r->rid != RDT_RESOURCE_L2DATA) {
+			kfree(hw_dom->ctrl_val);
+			kfree(hw_dom->mbps_val);
+		}
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
