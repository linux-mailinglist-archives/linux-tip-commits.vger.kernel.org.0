Return-Path: <linux-tip-commits+bounces-1569-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649C924826
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854D71F21DD3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1F1CFD45;
	Tue,  2 Jul 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khXBgERf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bXjPNDg8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05D1CF3C0;
	Tue,  2 Jul 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948258; cv=none; b=t+104UExrDC6cS2G9o6ifFrA64h+ZnCkQvndbbMPUXEkUxd8hT56ZGALHIvQ2O92l/Ox5y2RTpRb846SXHeANbU6hKy56bvSodEJ+B2+WxLU0zUfJfYxJtwpWk0MtWnxtruXZc3pgaW1xYZhfZC4h2mUwXjIoeMW0+URdNCx1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948258; c=relaxed/simple;
	bh=aN7ogqYsgb+7O60CI4tjh+PdoPIYFZpPyxsWTLmUdYs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tfz7dkHlEfE4KFiZ/fUWcaMnVZ+S2CL+4AUjnjr9DDZwEzkcRBVjolixPsy+Xzw44Y7mzlMMDMjbSnr14iCIXBl699XSmlxkMkqAep5IjuoamRbvBGf1KA61xToY/HfPpIbp1JSfPmpsIAZ3xylpo4sqP1bgWV5412p/+pU3ENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=khXBgERf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bXjPNDg8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muW2+xpbcCxBqSqZYknl8LPR8YUX7drFI0tevztUIf8=;
	b=khXBgERfJvezydogRRJkEeylOXKN5J3cEP+ciPw9pUFswTvOAZ3LBixe4mIaymAyfj794T
	qOQdbQciHmEjGEhz6EFuU2miW75X1ESEmtcmU96NkRXN9xWctJwEUCyefpgXQDG0DuvTVg
	UoVTte/mTdGcjjIG/WzhoejnTjbLPb3LNRTOI/WEun7hq743Y8B354Oe8BMDUKLLUoFRxA
	i7Cn7oYHtvX5l5HXomrkrfEOO0X2KzD88jUGAzV0h+aJD3LhZp5MrizBDZ0bEu7G2v8YWT
	0WjaH8ZQ2hXbW7H6Ya9YyU4hcSFuEoG7YdZ6/rSd7v46bIErwH/4pacWfTaCXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muW2+xpbcCxBqSqZYknl8LPR8YUX7drFI0tevztUIf8=;
	b=bXjPNDg81VfdNXp36IEEJX1xBu0B9Vw+K7+VYiodIzLPNQQKIvhFw5JO7fUDIzC57Kejug
	6Cp5tASASReLoXAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Handle removing directories in Sub-NUMA
 Cluster (SNC) mode
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240702173820.90368-2-tony.luck@intel.com>
References: <20240702173820.90368-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825282.2215.4608981062416265571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6b48b80b08e6f08eea8eaf7e44555ada191b6bee
Gitweb:        https://git.kernel.org/tip/6b48b80b08e6f08eea8eaf7e44555ada191b6bee
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 02 Jul 2024 10:38:19 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:51:06 +02:00

x86/resctrl: Handle removing directories in Sub-NUMA Cluster (SNC) mode

In SNC mode, there are multiple subdirectories in each L3 level monitor
directory (one for each SNC node). If all the CPUs in an SNC node are taken
offline, just remove the SNC directory for that node. In non-SNC mode, or when
the last SNC node directory is removed, remove the L3 monitor directory.

Add a helper function to avoid duplicated code.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240702173820.90368-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8502385..58e53f1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3006,22 +3006,45 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
 	return ret;
 }
 
+static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subname)
+{
+	struct kernfs_node *kn;
+
+	kn = kernfs_find_and_get(pkn, name);
+	if (!kn)
+		return;
+	kernfs_put(kn);
+
+	if (kn->dir.subdirs <= 1)
+		kernfs_remove(kn);
+	else
+		kernfs_remove_by_name(kn, subname);
+}
+
 /*
  * Remove all subdirectories of mon_data of ctrl_mon groups
- * and monitor groups with given domain id.
+ * and monitor groups for the given domain.
+ * Remove files and directories containing "sum" of domain data
+ * when last domain being summed is removed.
  */
 static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   unsigned int dom_id)
+					   struct rdt_mon_domain *d)
 {
 	struct rdtgroup *prgrp, *crgrp;
+	char subname[32];
+	bool snc_mode;
 	char name[32];
 
+	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	if (snc_mode)
+		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		sprintf(name, "mon_%s_%02d", r->name, dom_id);
-		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
 
 		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
-			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
 	}
 }
 
@@ -3991,7 +4014,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	 * per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d->hdr.id);
+		rmdir_mondata_subdir_allrdtgrp(r, d);
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);

