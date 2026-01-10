Return-Path: <linux-tip-commits+bounces-7839-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD99D0DC31
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2E83041568
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F229B8E5;
	Sat, 10 Jan 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fkmQ+Xrm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsKbLXo9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312521B4F1F;
	Sat, 10 Jan 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074356; cv=none; b=BW7sR9sPEkcK2rpWQGtuOTNtJAaS/hSHnRZrlGQKqXAEI97BoMpuA+5EWFN13aE3oKD+V9iFFZrTiV8QAukPG1XWNWJQx2AX0qGs8P9cs8ILyd0EvTZE84urEAw2aIRrGIG5+T050mHqPZfAAtTf6ZGSe32U+zmKcRwQI8XR5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074356; c=relaxed/simple;
	bh=ay5J3m2aOStU5W3WdB0biOdtLN1aUrwph7JuWR57xEE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rmovmMQpl29p6voRTGVfBNEHXXgjp0NlI7jqJUvuvKWBmHJJOI5yqTbK6gm0VFBsEUiUDpUd/a5CaDr7HwlN4zNqGNad0K44KMcoAm6qVCgzowHN4OzbCu5ai54Qg6GDJyEaEC3F0s09lqYf/ibsZWDka49b/aoA9qxc72Yrj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fkmQ+Xrm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsKbLXo9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7EzN44Np+yc8r1hxo9qPPalkkX8Xez7h4sbNFNbRmDY=;
	b=fkmQ+XrmWWKMvpvOEaGuOztBrgIjkS6FO2Zvx2VEzJfEcQcl3Jd0dD5UMlHR2SXijfRuT8
	MGf5zW67g43AlffeNqM7tnzIxBQ5toncRGSUMDvipsDWTMLfH0zxEr1CBQml4VVneVKjXM
	aHoCv+GFCvNL6DWT2WMf8ZeZR72v7cRiPDBukAJFnEOxWD1WmA7yagCwsyJ1c4bLICA0Ic
	tA8D3JhKPPn+Kzvi/WR2pxgOX8jFGFkZlSdHc7EuY7+zJEoR/bKFG1r601G1FloWRA4i1L
	l+fjF4QwSB6HkIEzI/HRDd5sWC58UKLQtXJmLtJeW288QtIoLf5a/UuDoBa/AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7EzN44Np+yc8r1hxo9qPPalkkX8Xez7h4sbNFNbRmDY=;
	b=CsKbLXo9BedMztlcuKG7kNlPl7q2jyUnUH7MSr8/KhV3Hcv4zeDscjqeWBiR0qWZUQn75i
	emTr1UShlitlV3Cg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Move RMID initialization to first mount
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435243.510.1426266743658267968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d0891647fbc6e931f27517364cbc4ee1811d76db
Gitweb:        https://git.kernel.org/tip/d0891647fbc6e931f27517364cbc4ee1811=
d76db
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:15 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 10 Jan 2026 11:46:48 +01:00

fs/resctrl: Move RMID initialization to first mount

L3 monitor features are enumerated during resctrl initialization and
rmid_ptrs[] that tracks all RMIDs and depends on the number of supported
RMIDs is allocated during this time.

Telemetry monitor features are enumerated during first resctrl mount and
may support a different number of RMIDs compared to L3 monitor features.

Delay allocation and initialization of rmid_ptrs[] until first mount.
Since the number of RMIDs cannot change on later mounts, keep the same set of
rmid_ptrs[] until resctrl_exit(). This is required because the limbo handler
keeps running after resctrl is unmounted and needs to access rmid_ptrs[]
as it keeps tracking busy RMIDs after unmount.

Rename routines to match what they now do:
dom_data_init() -> setup_rmid_lru_list()
dom_data_exit() -> free_rmid_lru_list()

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 fs/resctrl/internal.h |  4 +++-
 fs/resctrl/monitor.c  | 54 +++++++++++++++++++-----------------------
 fs/resctrl/rdtgroup.c |  5 ++++-
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 399f625..1a9b291 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -369,6 +369,10 @@ int closids_supported(void);
=20
 void closid_free(int closid);
=20
+int setup_rmid_lru_list(void);
+
+void free_rmid_lru_list(void);
+
 int alloc_rmid(u32 closid);
=20
 void free_rmid(u32 closid, u32 rmid);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index bbf8c90..0cd5476 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -903,20 +903,29 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domai=
n *dom, unsigned long del
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
=20
-static int dom_data_init(struct rdt_resource *r)
+int setup_rmid_lru_list(void)
 {
-	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry =3D NULL;
-	int err =3D 0, i;
+	u32 idx_limit;
 	u32 idx;
+	int i;
=20
-	mutex_lock(&rdtgroup_mutex);
+	if (!resctrl_arch_mon_capable())
+		return 0;
=20
+	/*
+	 * Called on every mount, but the number of RMIDs cannot change
+	 * after the first mount, so keep using the same set of rmid_ptrs[]
+	 * until resctrl_exit(). Note that the limbo handler continues to
+	 * access rmid_ptrs[] after resctrl is unmounted.
+	 */
+	if (rmid_ptrs)
+		return 0;
+
+	idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	rmid_ptrs =3D kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
-	if (!rmid_ptrs) {
-		err =3D -ENOMEM;
-		goto out_unlock;
-	}
+	if (!rmid_ptrs)
+		return -ENOMEM;
=20
 	for (i =3D 0; i < idx_limit; i++) {
 		entry =3D &rmid_ptrs[i];
@@ -929,30 +938,24 @@ static int dom_data_init(struct rdt_resource *r)
 	/*
 	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
 	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in resctrl_init().
+	 * control group, which was setup earlier in rdtgroup_setup_default().
 	 */
 	idx =3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 					   RESCTRL_RESERVED_RMID);
 	entry =3D __rmid_entry(idx);
 	list_del(&entry->list);
=20
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-
-	return err;
+	return 0;
 }
=20
-static void dom_data_exit(struct rdt_resource *r)
+void free_rmid_lru_list(void)
 {
-	mutex_lock(&rdtgroup_mutex);
-
-	if (!r->mon_capable)
-		goto out_unlock;
+	if (!resctrl_arch_mon_capable())
+		return;
=20
+	mutex_lock(&rdtgroup_mutex);
 	kfree(rmid_ptrs);
 	rmid_ptrs =3D NULL;
-
-out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
@@ -1830,7 +1833,8 @@ static void closid_num_dirty_rmid_free(void)
  * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
  * Allocate and initialise global monitor resources that do not belong to a
- * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * specific domain. i.e. the closid_num_dirty_rmid[] used to find the CLOSID
+ * with the cleanest set of RMIDs.
  * Called once during boot after the struct rdt_resource's have been configu=
red
  * but before the filesystem is mounted.
  * Resctrl's cpuhp callbacks may be called before this point to bring a doma=
in
@@ -1850,12 +1854,6 @@ int resctrl_l3_mon_resource_init(void)
 	if (ret)
 		return ret;
=20
-	ret =3D dom_data_init(r);
-	if (ret) {
-		closid_num_dirty_rmid_free();
-		return ret;
-	}
-
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable =3D true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
@@ -1902,6 +1900,4 @@ void resctrl_l3_mon_resource_exit(void)
 		return;
=20
 	closid_num_dirty_rmid_free();
-
-	dom_data_exit(r);
 }
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 666cac7..ba8d503 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2800,6 +2800,10 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out;
 	}
=20
+	ret =3D setup_rmid_lru_list();
+	if (ret)
+		goto out;
+
 	ret =3D rdtgroup_setup_root(ctx);
 	if (ret)
 		goto out;
@@ -4655,4 +4659,5 @@ void resctrl_exit(void)
 	 */
=20
 	resctrl_l3_mon_resource_exit();
+	free_rmid_lru_list();
 }

