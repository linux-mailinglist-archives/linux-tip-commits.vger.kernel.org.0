Return-Path: <linux-tip-commits+bounces-7865-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F876D0DCCD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0A130D80C9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434042F90D8;
	Sat, 10 Jan 2026 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wz2rA/Kn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YgsZ+qZr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC42D7DC1;
	Sat, 10 Jan 2026 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074396; cv=none; b=TZ6nMVi3/c8jE8WKUT9XNZLH5jjYSK6i4P7dqWqErcUtvSXJFIHcKzQNbL5XDcvqGTPFTSdgCsJLiDB7crKgPwQZMaLleasXbuHqqZ556q6kCnrDsyoGonxf8wCCJ03ZGkk6WIHgqqal+Ka76AflrigIaeqDfy7IzGz8g91QSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074396; c=relaxed/simple;
	bh=S2Ge1P5agM8rW+DRhDcyvVz4DLUIRJrpbi91wF6Jwfc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Ck93t2m8I8GFbA0qj6IM4q0DVRSLztbMZkx87W9Fw/jsJsyEY+07fEcUndkaQ/4Yu+CRC9z/GMnkZ5bHCkt3i9rvfBhlQbnOGpJ5cxwASPk/WoMzeSM2SS6+a5T5hICON+D/NTyCGbnlvMQPWakv1njvA7KSapdZG59cI9OQW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wz2rA/Kn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YgsZ+qZr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=H7RAyjlUIFjE8hTHgLCODnOjdXvbvaiWEji7wlEqHVU=;
	b=wz2rA/KnivmFtOi9KirpNAHwIq5gLzFDK3s94ZJTYCQ8Bmeat5Io0+dNNC3DqDrqrLKzZh
	tjBCZmj10pHGVy1gK9V4FT9XS7Dh52lxpwrbzHhfOVPz/pZBwgrK8OTFSgzIQjJWiyhDH1
	PjFcvmgEdJFauKxP7HPB7nOdUmmUI0G2LhQFOw5nHNjx+unu7L43SE4wdhZCkp+/JpNOBC
	pMIGfSFJ0iBwtCUDjd87a8S76GfNCDjK/F+a/n1dOeRRsyPDPzeicBderDKKv8jzE4ehyj
	GCrZNIqQ4fQun21B1X7NxPd1+Fm0dbGw3GRNFiUyUokpMFpxMnR+7BO4lTbMYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=H7RAyjlUIFjE8hTHgLCODnOjdXvbvaiWEji7wlEqHVU=;
	b=YgsZ+qZr7R9Jptw5O7IuJT5On7LefRmN7j7oD7g6Sae0vfa/c836ANXH+ZuS+1HX1ZA/eE
	XbXucCYJHW2zWGAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Move L3 initialization into new helper function
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807438007.510.14335124149182376283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0d6447623d788806b5504182032a0837ffa2174c
Gitweb:        https://git.kernel.org/tip/0d6447623d788806b5504182032a0837ffa=
2174c
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:49 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 04 Jan 2026 07:49:24 +01:00

x86/resctrl: Move L3 initialization into new helper function

Carve out the resource monitoring domain init code into a separate helper in
order to be able to initialize new types of monitoring domains besides the
usual L3 ones.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 64 +++++++++++++++--------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 0b8b7b8..2a568b3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -501,37 +501,13 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_res=
ource *r)
 	}
 }
=20
-static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+static void l3_mon_domain_setup(int cpu, int id, struct rdt_resource *r, str=
uct list_head *add_pos)
 {
-	int id =3D get_domain_id_from_scope(cpu, r->mon_scope);
-	struct list_head *add_pos =3D NULL;
 	struct rdt_hw_mon_domain *hw_dom;
-	struct rdt_domain_hdr *hdr;
 	struct rdt_mon_domain *d;
 	struct cacheinfo *ci;
 	int err;
=20
-	lockdep_assert_held(&domain_list_lock);
-
-	if (id < 0) {
-		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resourc=
e %s\n",
-			     cpu, r->mon_scope, r->name);
-		return;
-	}
-
-	hdr =3D resctrl_find_domain(&r->mon_domains, id, &add_pos);
-	if (hdr) {
-		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
-			return;
-		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
-
-		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
-		/* Update the mbm_assign_mode state for the CPU if supported */
-		if (r->mon.mbm_cntr_assignable)
-			resctrl_arch_mbm_cntr_assign_set_one(r);
-		return;
-	}
-
 	hw_dom =3D kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
 	if (!hw_dom)
 		return;
@@ -539,7 +515,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resour=
ce *r)
 	d =3D &hw_dom->d_resctrl;
 	d->hdr.id =3D id;
 	d->hdr.type =3D RESCTRL_MON_DOMAIN;
-	d->hdr.rid =3D r->rid;
+	d->hdr.rid =3D RDT_RESOURCE_L3;
 	ci =3D get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 	if (!ci) {
 		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
@@ -549,10 +525,6 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resou=
rce *r)
 	d->ci_id =3D ci->id;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
=20
-	/* Update the mbm_assign_mode state for the CPU if supported */
-	if (r->mon.mbm_cntr_assignable)
-		resctrl_arch_mbm_cntr_assign_set_one(r);
-
 	arch_mon_domain_online(r, d);
=20
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
@@ -570,6 +542,38 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resou=
rce *r)
 	}
 }
=20
+static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id =3D get_domain_id_from_scope(cpu, r->mon_scope);
+	struct list_head *add_pos =3D NULL;
+	struct rdt_domain_hdr *hdr;
+
+	lockdep_assert_held(&domain_list_lock);
+
+	if (id < 0) {
+		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resourc=
e %s\n",
+			     cpu, r->mon_scope, r->name);
+		return;
+	}
+
+	hdr =3D resctrl_find_domain(&r->mon_domains, id, &add_pos);
+	if (hdr)
+		cpumask_set_cpu(cpu, &hdr->cpu_mask);
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+		/* Update the mbm_assign_mode state for the CPU if supported */
+		if (r->mon.mbm_cntr_assignable)
+			resctrl_arch_mbm_cntr_assign_set_one(r);
+		if (!hdr)
+			l3_mon_domain_setup(cpu, id, r, add_pos);
+		break;
+	default:
+		pr_warn_once("Unknown resource rid=3D%d\n", r->rid);
+		break;
+	}
+}
+
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	if (r->alloc_capable)

