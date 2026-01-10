Return-Path: <linux-tip-commits+bounces-7854-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B974D0DCBB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18AB304DB4D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE172BEC52;
	Sat, 10 Jan 2026 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIMSTBaI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3P7z2CAC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB22ECE9D;
	Sat, 10 Jan 2026 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074380; cv=none; b=n40+dV0x5Gwg2lYia7H6vOzeEZU6wT49UvqNhEev13Cwnde31P1kKu8SeEKFIx6Pz1XiugDsQktgxGdiGiFlPpZaQ+mmxMSXwXdPYA71ipfhIfRzhMSPA4fY0ZELMTwZptuNNloqFzq2QB5X+Qy75tVOeo8Ui3hVPhlPl31exUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074380; c=relaxed/simple;
	bh=fyUmZaBUYCT6YX9zFsovXyvllUjv1A4K2KtxzLTXz8U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sPRdfFCqXn83Ag92QRDP7S5vFBncUQ34CK3Y/XQ03AyKIz6Z8mzJmVJ6dX0lshE+W2cuFP6Qtxpm3MWyvm+UEZtlfyCuk5dzTO6X6S6jvANuxerBTpbMfpRpSf6q8wWzH2uBq7t3GV72aT5FtxSIOfC2DRbWTopydU8AFmY5RCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BIMSTBaI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3P7z2CAC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074373;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=oeJtxTp7r8WTC+caHvJBLwxFdIajasUmzBr/L/W2l70=;
	b=BIMSTBaIKgS1vKDSxGn6JyOphrjar84bVflnk0Zu5eiwiagZ20nXvJQ20ApzqUTwSLW1lc
	LOeZagx14ZS4vnAXXWu1IMuryBtEj6cHrEDMS7jXYLPK9XP4+WbGGqf+sbYwFW2Dqq1kPh
	QfcvE1Fq0ORm8DhEFzhel0qrzwymhd9SMa0zVi1wi2Plt+iHu+GDGddOd9RVagx0i0mAxQ
	ZIM0ZYuBW7LL7DqBxhtARoSTWND9HadBlWZE33PThRIQ/i+CJHNwLyVFFiD2zTvPN500Q/
	HaEpBev/SjZ6KBQlf8J85q4OaER7SJYfudKN2e/gx7qrRLY8fKSAa8VQTw0gJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074373;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=oeJtxTp7r8WTC+caHvJBLwxFdIajasUmzBr/L/W2l70=;
	b=3P7z2CACZW8/ZrJXvNUXFkn85oqtaf3pkqLHcCPgBOJAfTX1OOHt4tcy4y+nb0Q/N6Jusu
	00YmagccdElW1oCw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Rename some L3 specific functions
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437274.510.15452070563385548445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     9c214d10c50990c7a61b95887493df9ae713eec5
Gitweb:        https://git.kernel.org/tip/9c214d10c50990c7a61b95887493df9ae71=
3eec5
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:56 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 11:21:55 +01:00

x86,fs/resctrl: Rename some L3 specific functions

With the arrival of monitor events tied to new domains associated with a
different resource it would be clearer if the L3 resource specific functions
are more accurately named.

Rename three groups of functions:

Functions that allocate/free architecture per-RMID MBM state information:
arch_domain_mbm_alloc()		-> l3_mon_domain_mbm_alloc()
mon_domain_free()		-> l3_mon_domain_free()

Functions that allocate/free filesystem per-RMID MBM state information:
domain_setup_mon_state()	-> domain_setup_l3_mon_state()
domain_destroy_mon_state()	-> domain_destroy_l3_mon_state()

Initialization/exit:
rdt_get_mon_l3_config()		-> rdt_get_l3_mon_config()
resctrl_mon_resource_init()	-> resctrl_l3_mon_resource_init()
resctrl_mon_resource_exit()	-> resctrl_l3_mon_resource_exit()

Ensure kernel-doc descriptions of these functions' return values are present
and correctly formatted.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 20 +++++++++++---------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 fs/resctrl/internal.h                  |  6 +++---
 fs/resctrl/monitor.c                   |  8 ++++----
 fs/resctrl/rdtgroup.c                  | 24 ++++++++++++------------
 6 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index cc1b846..b3a2dc5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -368,7 +368,7 @@ static void ctrl_domain_free(struct rdt_hw_ctrl_domain *h=
w_dom)
 	kfree(hw_dom);
 }
=20
-static void mon_domain_free(struct rdt_hw_l3_mon_domain *hw_dom)
+static void l3_mon_domain_free(struct rdt_hw_l3_mon_domain *hw_dom)
 {
 	int idx;
=20
@@ -401,11 +401,13 @@ static int domain_setup_ctrlval(struct rdt_resource *r,=
 struct rdt_ctrl_domain *
 }
=20
 /**
- * arch_domain_mbm_alloc() - Allocate arch private storage for the MBM count=
ers
+ * l3_mon_domain_mbm_alloc() - Allocate arch private storage for the MBM cou=
nters
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
+ *
+ * Return:	0 for success, or -ENOMEM.
  */
-static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_l3_mon_domain *=
hw_dom)
+static int l3_mon_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_l3_mon_domain=
 *hw_dom)
 {
 	size_t tsize =3D sizeof(*hw_dom->arch_mbm_states[0]);
 	enum resctrl_event_id eventid;
@@ -519,7 +521,7 @@ static void l3_mon_domain_setup(int cpu, int id, struct r=
dt_resource *r, struct=20
 	ci =3D get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 	if (!ci) {
 		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
-		mon_domain_free(hw_dom);
+		l3_mon_domain_free(hw_dom);
 		return;
 	}
 	d->ci_id =3D ci->id;
@@ -527,8 +529,8 @@ static void l3_mon_domain_setup(int cpu, int id, struct r=
dt_resource *r, struct=20
=20
 	arch_mon_domain_online(r, d);
=20
-	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
-		mon_domain_free(hw_dom);
+	if (l3_mon_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
+		l3_mon_domain_free(hw_dom);
 		return;
 	}
=20
@@ -538,7 +540,7 @@ static void l3_mon_domain_setup(int cpu, int id, struct r=
dt_resource *r, struct=20
 	if (err) {
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
-		mon_domain_free(hw_dom);
+		l3_mon_domain_free(hw_dom);
 	}
 }
=20
@@ -664,7 +666,7 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_res=
ource *r)
 		resctrl_offline_mon_domain(r, hdr);
 		list_del_rcu(&hdr->list);
 		synchronize_rcu();
-		mon_domain_free(hw_dom);
+		l3_mon_domain_free(hw_dom);
 		break;
 	}
 	default:
@@ -917,7 +919,7 @@ static __init bool get_rdt_mon_resources(void)
 	if (!ret)
 		return false;
=20
-	return !rdt_get_mon_l3_config(r);
+	return !rdt_get_l3_mon_config(r);
 }
=20
 static __init void __check_quirks_intel(void)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index d73c0ad..11d0699 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -213,7 +213,7 @@ union l3_qos_abmc_cfg {
=20
 void rdt_ctrl_update(void *arg);
=20
-int rdt_get_mon_l3_config(struct rdt_resource *r);
+int rdt_get_l3_mon_config(struct rdt_resource *r);
=20
 bool rdt_cpu_has(int flag);
=20
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 04b8f1e..2060521 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -424,7 +424,7 @@ static __init int snc_get_config(void)
 	return ret;
 }
=20
-int __init rdt_get_mon_l3_config(struct rdt_resource *r)
+int __init rdt_get_l3_mon_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index af47b6d..9768341 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -357,7 +357,9 @@ int alloc_rmid(u32 closid);
=20
 void free_rmid(u32 closid, u32 rmid);
=20
-void resctrl_mon_resource_exit(void);
+int resctrl_l3_mon_resource_init(void);
+
+void resctrl_l3_mon_resource_exit(void);
=20
 void mon_event_count(void *info);
=20
@@ -367,8 +369,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_reso=
urce *r,
 		    struct rdt_domain_hdr *hdr, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
=20
-int resctrl_mon_resource_init(void);
-
 void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9edbe98..d5ae0ef 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1780,7 +1780,7 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_fil=
e *of, char *buf,
 }
=20
 /**
- * resctrl_mon_resource_init() - Initialise global monitoring structures.
+ * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
  * Allocate and initialise global monitor resources that do not belong to a
  * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
@@ -1789,9 +1789,9 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_fil=
e *of, char *buf,
  * Resctrl's cpuhp callbacks may be called before this point to bring a doma=
in
  * online.
  *
- * Returns 0 for success, or -ENOMEM.
+ * Return: 0 for success, or -ENOMEM.
  */
-int resctrl_mon_resource_init(void)
+int resctrl_l3_mon_resource_init(void)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	int ret;
@@ -1841,7 +1841,7 @@ int resctrl_mon_resource_init(void)
 	return 0;
 }
=20
-void resctrl_mon_resource_exit(void)
+void resctrl_l3_mon_resource_exit(void)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
=20
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 2ed435d..b57e1e7 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4246,7 +4246,7 @@ static void rdtgroup_setup_default(void)
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
-static void domain_destroy_mon_state(struct rdt_l3_mon_domain *d)
+static void domain_destroy_l3_mon_state(struct rdt_l3_mon_domain *d)
 {
 	int idx;
=20
@@ -4301,13 +4301,13 @@ void resctrl_offline_mon_domain(struct rdt_resource *=
r, struct rdt_domain_hdr *h
 		cancel_delayed_work(&d->cqm_limbo);
 	}
=20
-	domain_destroy_mon_state(d);
+	domain_destroy_l3_mon_state(d);
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
 /**
- * domain_setup_mon_state() -  Initialise domain monitoring structures.
+ * domain_setup_l3_mon_state() -  Initialise domain monitoring structures.
  * @r:	The resource for the newly online domain.
  * @d:	The newly online domain.
  *
@@ -4315,11 +4315,11 @@ out_unlock:
  * Called when the first CPU of a domain comes online, regardless of whether
  * the filesystem is mounted.
  * During boot this may be called before global allocations have been made by
- * resctrl_mon_resource_init().
+ * resctrl_l3_mon_resource_init().
  *
- * Returns 0 for success, or -ENOMEM.
+ * Return: 0 for success, or -ENOMEM.
  */
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_l3_mon_=
domain *d)
+static int domain_setup_l3_mon_state(struct rdt_resource *r, struct rdt_l3_m=
on_domain *d)
 {
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	size_t tsize =3D sizeof(*d->mbm_states[0]);
@@ -4386,7 +4386,7 @@ int resctrl_online_mon_domain(struct rdt_resource *r, s=
truct rdt_domain_hdr *hdr
 		goto out_unlock;
=20
 	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
-	err =3D domain_setup_mon_state(r, d);
+	err =3D domain_setup_l3_mon_state(r, d);
 	if (err)
 		goto out_unlock;
=20
@@ -4503,13 +4503,13 @@ int resctrl_init(void)
=20
 	io_alloc_init();
=20
-	ret =3D resctrl_mon_resource_init();
+	ret =3D resctrl_l3_mon_resource_init();
 	if (ret)
 		return ret;
=20
 	ret =3D sysfs_create_mount_point(fs_kobj, "resctrl");
 	if (ret) {
-		resctrl_mon_resource_exit();
+		resctrl_l3_mon_resource_exit();
 		return ret;
 	}
=20
@@ -4544,7 +4544,7 @@ int resctrl_init(void)
=20
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-	resctrl_mon_resource_exit();
+	resctrl_l3_mon_resource_exit();
=20
 	return ret;
 }
@@ -4580,7 +4580,7 @@ static bool resctrl_online_domains_exist(void)
  * When called by the architecture code, all CPUs and resctrl domains must be
  * offline. This ensures the limbo and overflow handlers are not scheduled to
  * run, meaning the data structures they access can be freed by
- * resctrl_mon_resource_exit().
+ * resctrl_l3_mon_resource_exit().
  *
  * After resctrl_exit() returns, the architecture code should return an
  * error from all resctrl_arch_ functions that can do this.
@@ -4607,5 +4607,5 @@ void resctrl_exit(void)
 	 * it can be used to umount resctrl.
 	 */
=20
-	resctrl_mon_resource_exit();
+	resctrl_l3_mon_resource_exit();
 }

