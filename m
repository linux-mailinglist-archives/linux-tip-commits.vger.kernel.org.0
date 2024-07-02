Return-Path: <linux-tip-commits+bounces-1571-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D9924827
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD8D1F21C47
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCB1CFD50;
	Tue,  2 Jul 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hXbZH1Sz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVy4KqDl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0131CB31C;
	Tue,  2 Jul 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948258; cv=none; b=t3qSkbWkwIVzbTwQ75Ff/RojpbITsp/8Re+j1Y1E6dKPcahN23b/xqB5x0M8ySSL3x40ba9JTXtHOQnOq5QXBAB7FkO+k+3JFAtobxAC3ylEQd+wU380/Ktq1/u67CvHuxEjvYvw1FvZ2j5O+MrJimjN2sXubfqHxooyNfG7ot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948258; c=relaxed/simple;
	bh=sOG3GWjSH1E7jIRRtDES0IIF8q00ZQe3o8I61yO6sOA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CtGyHBVQO8+Tzrkkw+AhdFaJ3e3IRxpEPesoeP9nMC7sSpeLpRVAtyFd7soBooZPuxWBWmDQTn0FPbM7mdFBgHIrWrCb7soslHF78wC1+0uHn7Un0d7Wq7uVSgbYrdW7FfZm3qrOR2uTsrTUunAR3cUFzm62Y8wCoztXpC0zCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hXbZH1Sz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVy4KqDl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2n8VEeML06m/7lL8D+0sZETZuQLqHpkR/Atgp8SW28=;
	b=hXbZH1SzINI/6FQ4UdS+EvaFlIxRvAzV6WKsFp2MaNHGRfOfKUS6JwgAtnAk7XjaUuKCnf
	xwIadnzU1FO8yk2Quwcf8sBTDjT66FPFhx6iXwc3Vv0mFIAmvJdkdJ1XnRD3QR1VuU73U4
	mB0ecDSxZt9Nje/WMygPHEj4VCetHcXzW3CFSNt116hTSCnZUzVPD4cQ0mjb6hWKjRTOHK
	+MKA7OPmBYkwPE0d2xC7R1N5e1tPuSaqg+6Eb4EGTCREj338w9OxQ8ORbCz6uX2lyh4Ny0
	QPUuzxwHTtN8OdvH7VUJiL0TOqEV/Bzy41QjBuQrqqCbg3jOvrhK7KfstfWawQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2n8VEeML06m/7lL8D+0sZETZuQLqHpkR/Atgp8SW28=;
	b=JVy4KqDlQ2IzzWHbzwy88z6kU/j6OeKky7lZeq2z9VmYV+GeS3O42woqBNzpe3az5a0slH
	oxwFRlO9ONnSofAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Create Sub-NUMA Cluster (SNC) monitor files
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-14-tony.luck@intel.com>
References: <20240628215619.76401-14-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825315.2215.1959804690073141886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0158ed6a1335ff37f0336a986d7b99d6e97d46e9
Gitweb:        https://git.kernel.org/tip/0158ed6a1335ff37f0336a986d7b99d6e97d46e9
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:13 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Create Sub-NUMA Cluster (SNC) monitor files

When SNC mode is enabled, create subdirectories and files to monitor at the SNC
node granularity. Legacy behavior is preserved by tagging the monitor files at
the L3 granularity with the "sum" attribute.  When the user reads these files
the kernel will read monitor data from all SNC nodes that share the same L3
cache instance and return the aggregated value to the user.

Note that the "domid" field for files that must sum across SNC domains has the
L3 cache instance id, while non-summing files use the domain id.

The "sum" files do not need to make a call to mon_event_read() to initialize
the MBM counters. This will be handled by initializing the individual SNC nodes
that share the L3.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-14-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 ++++++++++++++++++-------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9c38ddc..8502385 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3026,7 +3026,8 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 }
 
 static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
-			     struct rdt_resource *r, struct rdtgroup *prgrp)
+			     struct rdt_resource *r, struct rdtgroup *prgrp,
+			     bool do_sum)
 {
 	struct rmid_read rr = {0};
 	union mon_data_bits priv;
@@ -3037,14 +3038,15 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 		return -EPERM;
 
 	priv.u.rid = r->rid;
-	priv.u.domid = d->hdr.id;
+	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
+	priv.u.sum = do_sum;
 	list_for_each_entry(mevt, &r->evt_list, list) {
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
 			return ret;
 
-		if (is_mbm_event(mevt->evtid))
+		if (!do_sum && is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
 
@@ -3055,23 +3057,51 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
-	struct kernfs_node *kn;
+	struct kernfs_node *kn, *ckn;
 	char name[32];
-	int ret;
+	bool snc_mode;
+	int ret = 0;
 
-	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
-	/* create the directory */
-	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
+	lockdep_assert_held(&rdtgroup_mutex);
 
-	ret = rdtgroup_kn_set_ugid(kn);
-	if (ret)
-		goto out_destroy;
+	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	kn = kernfs_find_and_get(parent_kn, name);
+	if (kn) {
+		/*
+		 * rdtgroup_mutex will prevent this directory from being
+		 * removed. No need to keep this hold.
+		 */
+		kernfs_put(kn);
+	} else {
+		kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
 
-	ret = mon_add_all_files(kn, d, r, prgrp);
-	if (ret)
-		goto out_destroy;
+		ret = rdtgroup_kn_set_ugid(kn);
+		if (ret)
+			goto out_destroy;
+		ret = mon_add_all_files(kn, d, r, prgrp, snc_mode);
+		if (ret)
+			goto out_destroy;
+	}
+
+	if (snc_mode) {
+		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		ckn = kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(ckn)) {
+			ret = -EINVAL;
+			goto out_destroy;
+		}
+
+		ret = rdtgroup_kn_set_ugid(ckn);
+		if (ret)
+			goto out_destroy;
+
+		ret = mon_add_all_files(ckn, d, r, prgrp, false);
+		if (ret)
+			goto out_destroy;
+	}
 
 	kernfs_activate(kn);
 	return 0;

