Return-Path: <linux-tip-commits+bounces-7844-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B74DD0DC3A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CE94300926F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C532C0287;
	Sat, 10 Jan 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYRkFuD+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iGoBPLY9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85224887E;
	Sat, 10 Jan 2026 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074367; cv=none; b=msI30E4M8bMbrvTdSNVpCTSS4039HUdbVGTBZRw7sNAPvqg2Azy421tx15ZMxkm6iDhNvNNlfHbgrSgt8qtz2T6McmDEnO1tKDuztIlFHLJIkEwb9FJeveCql0AzNQYVo5Eh5HQIJRvLoHzxtAaHLHmOM6lEyJYQzE7rKUPIqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074367; c=relaxed/simple;
	bh=pAdPQyKEM7mIbiF4+rgB60G1ugM75fqQZugIjaF5/eM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hcoUDgGT4K6rc3FihdO3LaC03QBzqdUH6ywLlMcmyEv9bAvwWrpMJLUwcnc2l35ttpoLyBf7dXHNUHTV9eu2NYITAYmXcqtPKU/n+U731WXpvvBFZskR0VS7MuUEPbmyurGFfagqFVOKeF41JcF2vrrLrykPCGWOPwdxPgLW3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYRkFuD+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iGoBPLY9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074361;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RmTtkTfsArxNM/k3oLxxwrczE/wJStlQaIyZXudgwcM=;
	b=hYRkFuD+pnhUIsxtJov2zAl7pCCwgFqch9jpsE8n3FpHUGxHOjqTjDXMA0xuNZguO1sywX
	JwaQBkIfh2wzINUNJbvwE9P8d1itpgqqPqb281kLb16p8xYv5RAnSEQHTtKs/aHoJ2RS2i
	NAnHo0N8o5ninGkBZMjABgE0UQx86yh1Bg/O6uv8QRVqOY7Sjxd8x2gUDcB7jQD9y3tBID
	IUI8SbWj/iimFJWaH0/uaHoL8DnEJQRWb9Y51TnG/ig/gXX4WLNv+VAo4C/Ts+YKnMsVfz
	q4PuVckatA/DkS5I8THdWZpwwXEWD9rEIT4Oxg7YBzMyBTZPoaO+VWJ28a2YAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074361;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RmTtkTfsArxNM/k3oLxxwrczE/wJStlQaIyZXudgwcM=;
	b=iGoBPLY9S9VipKTdh1h91FtfiMpZKOfZAdvZIeqTtFdPHX7FXqP6wk/ZhD4NERXNZFXwJd
	5cUoKJchleC4EzAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Refactor mkdir_mondata_subdir()
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435985.510.17686948796455270307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0ec1db4cac8239bb32da87586c3638200b65dd8c
Gitweb:        https://git.kernel.org/tip/0ec1db4cac8239bb32da87586c3638200b6=
5dd8c
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:08 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 23:02:57 +01:00

fs/resctrl: Refactor mkdir_mondata_subdir()

Population of a monitor group's mon_data directory is unreasonably complicated
because of the support for Sub-NUMA Cluster (SNC) mode.

Split out the SNC code into a helper function to make it easier to add support
for a new telemetry resource.

Move all the duplicated code to make and set owner of domain directories into
the mon_add_all_files() helper and rename to _mkdir_mondata_subdir().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 fs/resctrl/rdtgroup.c | 108 ++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index a2ad99a..6314819 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3260,57 +3260,65 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt=
_resource *r,
 	}
 }
=20
-static int mon_add_all_files(struct kernfs_node *kn, struct rdt_domain_hdr *=
hdr,
-			     struct rdt_resource *r, struct rdtgroup *prgrp,
-			     bool do_sum)
+/*
+ * Create a directory for a domain and populate it with monitor files. Create
+ * summing monitors when @hdr is NULL. No need to initialize summing monitor=
s.
+ */
+static struct kernfs_node *_mkdir_mondata_subdir(struct kernfs_node *parent_=
kn, char *name,
+						 struct rdt_domain_hdr *hdr,
+						 struct rdt_resource *r,
+						 struct rdtgroup *prgrp, int domid)
 {
-	struct rdt_l3_mon_domain *d;
 	struct rmid_read rr =3D {0};
+	struct kernfs_node *kn;
 	struct mon_data *priv;
 	struct mon_evt *mevt;
-	int ret, domid;
+	int ret;
=20
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-		return -EINVAL;
+	kn =3D kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+	if (IS_ERR(kn))
+		return kn;
+
+	ret =3D rdtgroup_kn_set_ugid(kn);
+	if (ret)
+		goto out_destroy;
=20
-	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	for_each_mon_event(mevt) {
 		if (mevt->rid !=3D r->rid || !mevt->enabled)
 			continue;
-		domid =3D do_sum ? d->ci_id : d->hdr.id;
-		priv =3D mon_get_kn_priv(r->rid, domid, mevt, do_sum);
-		if (WARN_ON_ONCE(!priv))
-			return -EINVAL;
+		priv =3D mon_get_kn_priv(r->rid, domid, mevt, !hdr);
+		if (WARN_ON_ONCE(!priv)) {
+			ret =3D -EINVAL;
+			goto out_destroy;
+		}
=20
 		ret =3D mon_addfile(kn, mevt->name, priv);
 		if (ret)
-			return ret;
+			goto out_destroy;
=20
-		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
+		if (hdr && resctrl_is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, hdr, prgrp, &hdr->cpu_mask, mevt, true);
 	}
=20
-	return 0;
+	return kn;
+out_destroy:
+	kernfs_remove(kn);
+	return ERR_PTR(ret);
 }
=20
-static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_domain_hdr *hdr,
-				struct rdt_resource *r, struct rdtgroup *prgrp)
+static int mkdir_mondata_subdir_snc(struct kernfs_node *parent_kn,
+				    struct rdt_domain_hdr *hdr,
+				    struct rdt_resource *r, struct rdtgroup *prgrp)
 {
-	struct kernfs_node *kn, *ckn;
+	struct kernfs_node *ckn, *kn;
 	struct rdt_l3_mon_domain *d;
 	char name[32];
-	bool snc_mode;
-	int ret =3D 0;
-
-	lockdep_assert_held(&rdtgroup_mutex);
=20
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
=20
 	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
-	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
+	sprintf(name, "mon_%s_%02d", r->name, d->ci_id);
 	kn =3D kernfs_find_and_get(parent_kn, name);
 	if (kn) {
 		/*
@@ -3319,41 +3327,41 @@ static int mkdir_mondata_subdir(struct kernfs_node *p=
arent_kn,
 		 */
 		kernfs_put(kn);
 	} else {
-		kn =3D kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		kn =3D _mkdir_mondata_subdir(parent_kn, name, NULL, r, prgrp, d->ci_id);
 		if (IS_ERR(kn))
 			return PTR_ERR(kn);
+	}
=20
-		ret =3D rdtgroup_kn_set_ugid(kn);
-		if (ret)
-			goto out_destroy;
-		ret =3D mon_add_all_files(kn, hdr, r, prgrp, snc_mode);
-		if (ret)
-			goto out_destroy;
+	sprintf(name, "mon_sub_%s_%02d", r->name, hdr->id);
+	ckn =3D _mkdir_mondata_subdir(kn, name, hdr, r, prgrp, hdr->id);
+	if (IS_ERR(ckn)) {
+		kernfs_remove(kn);
+		return PTR_ERR(ckn);
 	}
=20
-	if (snc_mode) {
-		sprintf(name, "mon_sub_%s_%02d", r->name, hdr->id);
-		ckn =3D kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
-		if (IS_ERR(ckn)) {
-			ret =3D -EINVAL;
-			goto out_destroy;
-		}
+	kernfs_activate(kn);
+	return 0;
+}
=20
-		ret =3D rdtgroup_kn_set_ugid(ckn);
-		if (ret)
-			goto out_destroy;
+static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
+				struct rdt_domain_hdr *hdr,
+				struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	struct kernfs_node *kn;
+	char name[32];
=20
-		ret =3D mon_add_all_files(ckn, hdr, r, prgrp, false);
-		if (ret)
-			goto out_destroy;
-	}
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (r->rid =3D=3D RDT_RESOURCE_L3 && r->mon_scope =3D=3D RESCTRL_L3_NODE)
+		return mkdir_mondata_subdir_snc(parent_kn, hdr, r, prgrp);
+
+	sprintf(name, "mon_%s_%02d", r->name, hdr->id);
+	kn =3D _mkdir_mondata_subdir(parent_kn, name, hdr, r, prgrp, hdr->id);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
=20
 	kernfs_activate(kn);
 	return 0;
-
-out_destroy:
-	kernfs_remove(kn);
-	return ret;
 }
=20
 /*

