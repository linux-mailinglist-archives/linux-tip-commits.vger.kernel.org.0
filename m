Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28473E98F4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhHKTlv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhHKTlt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BCC0613D3;
        Wed, 11 Aug 2021 12:41:25 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:41:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxeweYxbPh8+mino1ySLgNLupEwHceT5WMIx8nG5m6o=;
        b=amegrEww7QwkHPpYCV4a7KuQ8oevNDhjvPCScr6sFgfOKSinX/OB9vax25HPfLXoeEm38u
        OVVQ+MeTVn7m2pW608p0d6taQwQLYdqzF2OcW5JzbX/m18mOeXJ4UQE+q2M0DCchmHIRqG
        G3d/pztb7JfNwdu2igmk81VoHghN4qBFTGEe3RXX+4TFpmo/EUEVj2XtG5S2TYgaFHr7y1
        0dYhG4V2wbsX3BZbLR8eBduqZ5QY5xf2zh/L82mZ4BYx1x0emHUP6OcgTuNHbt+WuAwc7b
        TT972DWt+pKi1GGNHK57UUVdTGNEE6fbD4Ed5jMpbuHN/l7C/T74RaoS3IqFUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxeweYxbPh8+mino1ySLgNLupEwHceT5WMIx8nG5m6o=;
        b=zY2N2bWjFQ/bTJGBbt4mcY6H8qFpP9RX7uzieq5XxcbRQQiQXTzMPh+eUDNL0Mv9Ax4XkK
        3uMSPvR6WOfHXCAg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove rdt_cdp_peer_get()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-23-james.morse@arm.com>
References: <20210728170637.25610-23-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088268.395.12682646184865124354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     fbc06c69805976e1b5c7e6bd0b89c5b0f5282cdf
Gitweb:        https://git.kernel.org/tip/fbc06c69805976e1b5c7e6bd0b89c5b0f5282cdf
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:35 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 18:33:48 +02:00

x86/resctrl: Remove rdt_cdp_peer_get()

When CDP is enabled, rdt_cdp_peer_get() finds the alternative
CODE/DATA resource and returns the alternative domain. This is used
to determine if bitmaps overlap when there are aliased entries
in the two struct rdt_hw_resources.

Now that the ctrl_val[] used by the CODE/DATA resources is the same,
the search for an alternate resource/domain is not needed.

Replace rdt_cdp_peer_get() with resctrl_peer_type(), which returns
the alternative type. This can be passed to resctrl_arch_get_config()
with the same resource and domain.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-23-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  99 +++---------------------
 1 file changed, 14 insertions(+), 85 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1f72517..7cf4bf3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1092,82 +1092,17 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-/**
- * rdt_cdp_peer_get - Retrieve CDP peer if it exists
- * @r: RDT resource to which RDT domain @d belongs
- * @d: Cache instance for which a CDP peer is requested
- * @r_cdp: RDT resource that shares hardware with @r (RDT resource peer)
- *         Used to return the result.
- * @d_cdp: RDT domain that shares hardware with @d (RDT domain peer)
- *         Used to return the result.
- * @peer_type: The CDP configuration type of the peer resource.
- *
- * RDT resources are managed independently and by extension the RDT domains
- * (RDT resource instances) are managed independently also. The Code and
- * Data Prioritization (CDP) RDT resources, while managed independently,
- * could refer to the same underlying hardware. For example,
- * RDT_RESOURCE_L2CODE and RDT_RESOURCE_L2DATA both refer to the L2 cache.
- *
- * When provided with an RDT resource @r and an instance of that RDT
- * resource @d rdt_cdp_peer_get() will return if there is a peer RDT
- * resource and the exact instance that shares the same hardware.
- *
- * Return: 0 if a CDP peer was found, <0 on error or if no CDP peer exists.
- *         If a CDP peer was found, @r_cdp will point to the peer RDT resource
- *         and @d_cdp will point to the peer RDT domain.
- */
-static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
-			    struct rdt_resource **r_cdp,
-			    struct rdt_domain **d_cdp,
-			    enum resctrl_conf_type *peer_type)
+static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
 {
-	struct rdt_resource *_r_cdp = NULL;
-	struct rdt_domain *_d_cdp = NULL;
-	int ret = 0;
-
-	switch (r->rid) {
-	case RDT_RESOURCE_L3DATA:
-		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE].r_resctrl;
-		*peer_type = CDP_CODE;
-		break;
-	case RDT_RESOURCE_L3CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl;
-		*peer_type = CDP_DATA;
-		break;
-	case RDT_RESOURCE_L2DATA:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE].r_resctrl;
-		*peer_type = CDP_CODE;
-		break;
-	case RDT_RESOURCE_L2CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl;
-		*peer_type = CDP_DATA;
-		break;
+	switch (my_type) {
+	case CDP_CODE:
+		return CDP_DATA;
+	case CDP_DATA:
+		return CDP_CODE;
 	default:
-		ret = -ENOENT;
-		goto out;
-	}
-
-	/*
-	 * When a new CPU comes online and CDP is enabled then the new
-	 * RDT domains (if any) associated with both CDP RDT resources
-	 * are added in the same CPU online routine while the
-	 * rdtgroup_mutex is held. It should thus not happen for one
-	 * RDT domain to exist and be associated with its RDT CDP
-	 * resource but there is no RDT domain associated with the
-	 * peer RDT CDP resource. Hence the WARN.
-	 */
-	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
-	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
-		_r_cdp = NULL;
-		_d_cdp = NULL;
-		ret = -EINVAL;
+	case CDP_NONE:
+		return CDP_NONE;
 	}
-
-out:
-	*r_cdp = _r_cdp;
-	*d_cdp = _d_cdp;
-
-	return ret;
 }
 
 /**
@@ -1248,19 +1183,16 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
-	enum resctrl_conf_type peer_type;
+	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
 	struct rdt_resource *r = s->res;
-	struct rdt_resource *r_cdp;
-	struct rdt_domain *d_cdp;
 
 	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
 				    exclusive))
 		return true;
 
-	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type) < 0)
+	if (!resctrl_arch_get_cdp_enabled(r->rid))
 		return false;
-
-	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, peer_type, exclusive);
+	return  __rdtgroup_cbm_overlaps(r, d, cbm, closid, peer_type, exclusive);
 }
 
 /**
@@ -2756,11 +2688,9 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
+	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
 	enum resctrl_conf_type t = s->conf_type;
-	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
-	enum resctrl_conf_type peer_type;
-	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
 	unsigned long tmp_cbm;
@@ -2768,7 +2698,6 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	u32 peer_ctl, ctrl_val;
 	int i;
 
-	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type);
 	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
@@ -2788,8 +2717,8 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * usage to ensure there is no overlap
 			 * with an exclusive group.
 			 */
-			if (d_cdp)
-				resctrl_arch_get_config(r_cdp, d_cdp, i, peer_type, &peer_ctl);
+			if (resctrl_arch_get_cdp_enabled(r->rid))
+				resctrl_arch_get_config(r, d, i, peer_type, &peer_ctl);
 			else
 				peer_ctl = 0;
 			resctrl_arch_get_config(r, d, i, s->conf_type, &ctrl_val);
