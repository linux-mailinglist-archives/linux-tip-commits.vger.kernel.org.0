Return-Path: <linux-tip-commits+bounces-7866-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF6D0DCB5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF48430316AA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F929B778;
	Sat, 10 Jan 2026 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jasp5fgt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18s2sYzO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE629A9C3;
	Sat, 10 Jan 2026 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074397; cv=none; b=jqnh7QCtLxesK+LX6JRNZ5GE7Atx5ygVpdwN9M8LiNX0Ut7Qd7ZCAF0GjNfST/90RqREmEVAhFY3CnDhrA7o+DvC8sZtT/9+7i2ZuQVAd1RBL/SrG/WCJN6TifcjVl2ROV1bgpNXUk7bGx2hk2jYWUCydFf9eUeTvzaMyXATOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074397; c=relaxed/simple;
	bh=HIg0ZW2juDFvnDk2P3pxxbBcGGKHMIan1Pje9dWDmbw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IJ+4SRFyfOTCuo5m+/dK9Pvly1m9alKd8LVm4XrQZyVE9fdTIczg3B5i0hQkcI6bPfYMz5+vn7KfNvph0w6iN4ch/gpEq1JRtRaFlSgZ9Mv+4Wp+QSXPtyrSPwH9P9XxFMKJZEewZpSmvnyR/Pg9Wk0IkPh32LxYXpgQDoQVQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jasp5fgt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18s2sYzO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BWau4jNghw0Pm0AhU4Ao0hth9V/sqMEz1ne0qLCN2IU=;
	b=jasp5fgt8Yz6N+3SGirtH29BkFC/C/RoUmkQJsSwmEdpXOkO8ZrW5yysvByptRA9QdpBQS
	5uaLv+3Zn6BKxf0JqRPHdmZ7g95z4RGxdod+fKnq4ZH2/DYrY8BT3VXgKlps1tU02p588M
	unLZmwAnHKeEifblWuKLd5Xxg1/4QBFUVnWEGWKkLQQZr0Qu2Oo1CjmwnmmrN9+VrhD+6m
	pQ+TGlFIgv/BjfdkuTBuXLVsanPm9BD5oqjZnrr3lx+BtUvcxycCe7kmp7ysEfuQxh03tV
	QBXAgjWECngZMUgbZ3ZLgzZoLkbMS4YJH/jZPJ1B2C/2NshJM6a1Fn/k8obVtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BWau4jNghw0Pm0AhU4Ao0hth9V/sqMEz1ne0qLCN2IU=;
	b=18s2sYzO5WMG7IOSiF0yey6jA/1hRzN0tdSy+usOQu5r3vRj0mkQ619IBWq9C2tiKrFMU2
	ugZBMbNwHTeqCxAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Refactor domain create/remove using
 struct rdt_domain_hdr
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437710.510.6589009599529761397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     97fec06d35b2c1ce6d80cf3b01bfddd82c720a2d
Gitweb:        https://git.kernel.org/tip/97fec06d35b2c1ce6d80cf3b01bfddd82c7=
20a2d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:52 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 04 Jan 2026 13:48:11 +01:00

x86,fs/resctrl: Refactor domain create/remove using struct rdt_domain_hdr

Up until now, all monitoring events were associated with the L3 resource and =
it
made sense to use the L3 specific "struct rdt_mon_domain *" argument to funct=
ions
operating on domains.

Telemetry events will be tied to a new resource with its instances represented
by a new domain structure that, just like struct rdt_mon_domain, starts with
the generic struct rdt_domain_hdr.

Prepare to support domains belonging to different resources by changing the
calling convention of functions operating on domains.  Pass the generic header
and use that to find the domain specific structure where needed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c |  4 +-
 fs/resctrl/ctrlmondata.c           | 14 ++++--
 fs/resctrl/internal.h              |  2 +-
 fs/resctrl/rdtgroup.c              | 69 ++++++++++++++++++++---------
 include/linux/resctrl.h            |  4 +-
 5 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 64ed81c..1fab4c6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -534,7 +534,7 @@ static void l3_mon_domain_setup(int cpu, int id, struct r=
dt_resource *r, struct=20
=20
 	list_add_tail_rcu(&d->hdr.list, add_pos);
=20
-	err =3D resctrl_online_mon_domain(r, d);
+	err =3D resctrl_online_mon_domain(r, &d->hdr);
 	if (err) {
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
@@ -661,7 +661,7 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_res=
ource *r)
=20
 		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
 		hw_dom =3D resctrl_to_arch_mon_dom(d);
-		resctrl_offline_mon_domain(r, d);
+		resctrl_offline_mon_domain(r, hdr);
 		list_del_rcu(&hdr->list);
 		synchronize_rcu();
 		mon_domain_free(hw_dom);
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 905c310..3154cdc 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -551,14 +551,21 @@ struct rdt_domain_hdr *resctrl_find_domain(struct list_=
head *h, int id,
 }
=20
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_domain_hdr *hdr, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first)
 {
+	struct rdt_mon_domain *d =3D NULL;
 	int cpu;
=20
 	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
=20
+	if (hdr) {
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+			return;
+		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	}
+
 	/*
 	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
@@ -653,12 +660,11 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 * the resource to find the domain with "domid".
 		 */
 		hdr =3D resctrl_find_domain(&r->mon_domains, domid, NULL);
-		if (!hdr || !domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, resid)) {
+		if (!hdr) {
 			ret =3D -ENOENT;
 			goto out;
 		}
-		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
-		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
+		mon_event_read(&rr, r, hdr, rdtgrp, &hdr->cpu_mask, evtid, false);
 	}
=20
 checkresult:
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index bff4a54..5e52269 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -362,7 +362,7 @@ void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
=20
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_domain_hdr *hdr, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
=20
 int resctrl_mon_resource_init(void);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 8e39dfd..89ffe54 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3229,17 +3229,22 @@ static void mon_rmdir_one_subdir(struct kernfs_node *=
pkn, char *name, char *subn
  * when last domain being summed is removed.
  */
 static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_mon_domain *d)
+					   struct rdt_domain_hdr *hdr)
 {
 	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *d;
 	char subname[32];
 	bool snc_mode;
 	char name[32];
=20
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		return;
+
+	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
 	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : hdr->id);
 	if (snc_mode)
-		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		sprintf(subname, "mon_sub_%s_%02d", r->name, hdr->id);
=20
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
@@ -3249,15 +3254,20 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt=
_resource *r,
 	}
 }
=20
-static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *=
d,
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_domain_hdr *=
hdr,
 			     struct rdt_resource *r, struct rdtgroup *prgrp,
 			     bool do_sum)
 {
 	struct rmid_read rr =3D {0};
+	struct rdt_mon_domain *d;
 	struct mon_data *priv;
 	struct mon_evt *mevt;
 	int ret, domid;
=20
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		return -EINVAL;
+
+	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
 	for_each_mon_event(mevt) {
 		if (mevt->rid !=3D r->rid || !mevt->enabled)
 			continue;
@@ -3271,23 +3281,28 @@ static int mon_add_all_files(struct kernfs_node *kn, =
struct rdt_mon_domain *d,
 			return ret;
=20
 		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
+			mon_event_read(&rr, r, hdr, prgrp, &hdr->cpu_mask, mevt->evtid, true);
 	}
=20
 	return 0;
 }
=20
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_mon_domain *d,
+				struct rdt_domain_hdr *hdr,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	struct kernfs_node *kn, *ckn;
+	struct rdt_mon_domain *d;
 	char name[32];
 	bool snc_mode;
 	int ret =3D 0;
=20
 	lockdep_assert_held(&rdtgroup_mutex);
=20
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		return -EINVAL;
+
+	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
 	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
 	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
 	kn =3D kernfs_find_and_get(parent_kn, name);
@@ -3305,13 +3320,13 @@ static int mkdir_mondata_subdir(struct kernfs_node *p=
arent_kn,
 		ret =3D rdtgroup_kn_set_ugid(kn);
 		if (ret)
 			goto out_destroy;
-		ret =3D mon_add_all_files(kn, d, r, prgrp, snc_mode);
+		ret =3D mon_add_all_files(kn, hdr, r, prgrp, snc_mode);
 		if (ret)
 			goto out_destroy;
 	}
=20
 	if (snc_mode) {
-		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		sprintf(name, "mon_sub_%s_%02d", r->name, hdr->id);
 		ckn =3D kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
 		if (IS_ERR(ckn)) {
 			ret =3D -EINVAL;
@@ -3322,7 +3337,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *par=
ent_kn,
 		if (ret)
 			goto out_destroy;
=20
-		ret =3D mon_add_all_files(ckn, d, r, prgrp, false);
+		ret =3D mon_add_all_files(ckn, hdr, r, prgrp, false);
 		if (ret)
 			goto out_destroy;
 	}
@@ -3340,7 +3355,7 @@ out_destroy:
  * and "monitor" groups with given domain id.
  */
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_mon_domain *d)
+					   struct rdt_domain_hdr *hdr)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
@@ -3348,12 +3363,12 @@ static void mkdir_mondata_subdir_allrdtgrp(struct rdt=
_resource *r,
=20
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		parent_kn =3D prgrp->mon.mon_data_kn;
-		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
+		mkdir_mondata_subdir(parent_kn, hdr, r, prgrp);
=20
 		head =3D &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
 			parent_kn =3D crgrp->mon.mon_data_kn;
-			mkdir_mondata_subdir(parent_kn, d, r, crgrp);
+			mkdir_mondata_subdir(parent_kn, hdr, r, crgrp);
 		}
 	}
 }
@@ -3362,14 +3377,14 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_=
node *parent_kn,
 				       struct rdt_resource *r,
 				       struct rdtgroup *prgrp)
 {
-	struct rdt_mon_domain *dom;
+	struct rdt_domain_hdr *hdr;
 	int ret;
=20
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
=20
-	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
-		ret =3D mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
+	list_for_each_entry(hdr, &r->mon_domains, list) {
+		ret =3D mkdir_mondata_subdir(parent_kn, hdr, r, prgrp);
 		if (ret)
 			return ret;
 	}
@@ -4253,16 +4268,23 @@ void resctrl_offline_ctrl_domain(struct rdt_resource =
*r, struct rdt_ctrl_domain=20
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domai=
n *d)
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hd=
r *hdr)
 {
+	struct rdt_mon_domain *d;
+
 	mutex_lock(&rdtgroup_mutex);
=20
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		goto out_unlock;
+
+	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+
 	/*
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d);
+		rmdir_mondata_subdir_allrdtgrp(r, hdr);
=20
 	if (resctrl_is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
@@ -4280,7 +4302,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r,=
 struct rdt_mon_domain *d
 	}
=20
 	domain_destroy_mon_state(d);
-
+out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
@@ -4353,12 +4375,17 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r=
, struct rdt_ctrl_domain *d
 	return err;
 }
=20
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain =
*d)
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr =
*hdr)
 {
-	int err;
+	struct rdt_mon_domain *d;
+	int err =3D -EINVAL;
=20
 	mutex_lock(&rdtgroup_mutex);
=20
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		goto out_unlock;
+
+	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
 	err =3D domain_setup_mon_state(r, d);
 	if (err)
 		goto out_unlock;
@@ -4379,7 +4406,7 @@ int resctrl_online_mon_domain(struct rdt_resource *r, s=
truct rdt_mon_domain *d)
 	 * If resctrl is mounted, add per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		mkdir_mondata_subdir_allrdtgrp(r, d);
+		mkdir_mondata_subdir_allrdtgrp(r, hdr);
=20
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e7c218f..5db37c7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -507,9 +507,9 @@ int resctrl_arch_update_one(struct rdt_resource *r, struc=
t rdt_ctrl_domain *d,
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *=
d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domai=
n *d);
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain =
*d);
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr =
*hdr);
 void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_dom=
ain *d);
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domai=
n *d);
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hd=
r *hdr);
 void resctrl_online_cpu(unsigned int cpu);
 void resctrl_offline_cpu(unsigned int cpu);
=20

