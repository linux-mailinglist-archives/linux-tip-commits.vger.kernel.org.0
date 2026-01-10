Return-Path: <linux-tip-commits+bounces-7842-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A00D0DC4C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCE2E303FE33
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2C1DF97C;
	Sat, 10 Jan 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swqG9Bsu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JqT5yAHf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434902BD5BF;
	Sat, 10 Jan 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074364; cv=none; b=g3wxfVamtDdpkwJgxZOXsHh/acJTeQ2Zw8xkxWucLdlVOAeTynE4wk+T0FvnF6VDjM/5QIwHRk1WznCLIaoipdxqQYuYr8LvgS90jmTft2piLnwDcDcuYqnsmJYIkkel1yL7xdtzYTUwjlZabFO+bGdiNtlV/lm6Q2WnyjtswUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074364; c=relaxed/simple;
	bh=E1/OmvvapMY1xt/+yHaCh3TT5QelOS+zfl3dKEtSgEc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oskphubehj3OMEjctUJ5ttMv3STJII/9FYM/s0Np/xRVrbDf+8SjGcHWOA3p/3hF5MEUHYwPH1Xgvmcaq9chNwDhyN++Me+PBA5eKPYK71fUr7P/cCZn8zuSd3+4GGkc7Sxt3tWY5utfLiPKK6nVmyd+sA+h1PkKxNvSnUon80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swqG9Bsu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JqT5yAHf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IBLcAkiHAHlyB4J1UbuqF2Qh84R8sjotGsN4Mr2xiY4=;
	b=swqG9BsuGgPfswAwsqDLW96C0+w8Ux9+YmyW1njakAkeShvAIDLOLAPZL2a2h9MFjNYY7K
	KyjfHvfNI5ibtNKcJjjYbEZGJ6Ob5fy0hzWyONDLQvrcR4GtdLGGY3TKlEuEhh0PbGL1ET
	9SjNoYQGiFOnxF57PLNAT+bL/GwT4De0wgXP5YG54p8XLNamlE7TLyCNTqatEGD3N/iun6
	XeOWhe8Y3xeDr4GbkQ/9zH3aS6MMLb1peXuRLZv2n9acZaM2vtVCkCfsV2n6fIHdhVYt/o
	agVnMKjdnjzJPVx7Y2+U0TVzG/4QGMZFa7PPilRIFuTK22KA+pl5FQtc+fkhWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IBLcAkiHAHlyB4J1UbuqF2Qh84R8sjotGsN4Mr2xiY4=;
	b=JqT5yAHf55W6SA4lvMwjcHoDOrO7pmSgNDQnGu9MAPeTfMw2xlKhGVlPrqNLOkJkTFGc2F
	woH+80653PyFd5Aw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] fs/resctrl: Move allocation/free of closid_num_dirty_rmid[]
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435453.510.3764331639315113385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ee7f6af79f0916b6c49e15edd4cba020b3e4c4ac
Gitweb:        https://git.kernel.org/tip/ee7f6af79f0916b6c49e15edd4cba020b3e=
4c4ac
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:13 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 10 Jan 2026 11:33:14 +01:00

fs/resctrl: Move allocation/free of closid_num_dirty_rmid[]

closid_num_dirty_rmid[] and rmid_ptrs[] are allocated together during resctrl
initialization and freed together during resctrl exit.

Telemetry events are enumerated on resctrl mount so only at resctrl mount will
the number of RMID supported by all monitoring resources and needed as size
for rmid_ptrs[] be known.

Separate closid_num_dirty_rmid[] and rmid_ptrs[] allocation and free in
preparation for rmid_ptrs[] to be allocated on resctrl mount.

Keep the rdtgroup_mutex protection around the allocation and free of
closid_num_dirty_rmid[] as ARM needs this to guarantee memory ordering.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 fs/resctrl/monitor.c | 79 +++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 8a4c2ae..bbf8c90 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -906,36 +906,14 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domai=
n *dom, unsigned long del
 static int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
-	u32 num_closid =3D resctrl_arch_get_num_closid(r);
 	struct rmid_entry *entry =3D NULL;
 	int err =3D 0, i;
 	u32 idx;
=20
 	mutex_lock(&rdtgroup_mutex);
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		u32 *tmp;
-
-		/*
-		 * If the architecture hasn't provided a sanitised value here,
-		 * this may result in larger arrays than necessary. Resctrl will
-		 * use a smaller system wide value based on the resources in
-		 * use.
-		 */
-		tmp =3D kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
-		if (!tmp) {
-			err =3D -ENOMEM;
-			goto out_unlock;
-		}
-
-		closid_num_dirty_rmid =3D tmp;
-	}
=20
 	rmid_ptrs =3D kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
 	if (!rmid_ptrs) {
-		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-			kfree(closid_num_dirty_rmid);
-			closid_num_dirty_rmid =3D NULL;
-		}
 		err =3D -ENOMEM;
 		goto out_unlock;
 	}
@@ -971,11 +949,6 @@ static void dom_data_exit(struct rdt_resource *r)
 	if (!r->mon_capable)
 		goto out_unlock;
=20
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		kfree(closid_num_dirty_rmid);
-		closid_num_dirty_rmid =3D NULL;
-	}
-
 	kfree(rmid_ptrs);
 	rmid_ptrs =3D NULL;
=20
@@ -1814,6 +1787,45 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_fi=
le *of, char *buf,
 	return ret ?: nbytes;
 }
=20
+static int closid_num_dirty_rmid_alloc(struct rdt_resource *r)
+{
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		u32 num_closid =3D resctrl_arch_get_num_closid(r);
+		u32 *tmp;
+
+		/* For ARM memory ordering access to closid_num_dirty_rmid */
+		mutex_lock(&rdtgroup_mutex);
+
+		/*
+		 * If the architecture hasn't provided a sanitised value here,
+		 * this may result in larger arrays than necessary. Resctrl will
+		 * use a smaller system wide value based on the resources in
+		 * use.
+		 */
+		tmp =3D kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp) {
+			mutex_unlock(&rdtgroup_mutex);
+			return -ENOMEM;
+		}
+
+		closid_num_dirty_rmid =3D tmp;
+
+		mutex_unlock(&rdtgroup_mutex);
+	}
+
+	return 0;
+}
+
+static void closid_num_dirty_rmid_free(void)
+{
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		mutex_lock(&rdtgroup_mutex);
+		kfree(closid_num_dirty_rmid);
+		closid_num_dirty_rmid =3D NULL;
+		mutex_unlock(&rdtgroup_mutex);
+	}
+}
+
 /**
  * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -1834,10 +1846,16 @@ int resctrl_l3_mon_resource_init(void)
 	if (!r->mon_capable)
 		return 0;
=20
-	ret =3D dom_data_init(r);
+	ret =3D closid_num_dirty_rmid_alloc(r);
 	if (ret)
 		return ret;
=20
+	ret =3D dom_data_init(r);
+	if (ret) {
+		closid_num_dirty_rmid_free();
+		return ret;
+	}
+
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable =3D true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
@@ -1880,5 +1898,10 @@ void resctrl_l3_mon_resource_exit(void)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
=20
+	if (!r->mon_capable)
+		return;
+
+	closid_num_dirty_rmid_free();
+
 	dom_data_exit(r);
 }

