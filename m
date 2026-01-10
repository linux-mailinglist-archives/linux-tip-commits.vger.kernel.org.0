Return-Path: <linux-tip-commits+bounces-7864-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544CD0DCA3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9091A302DF0A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5F2F4A19;
	Sat, 10 Jan 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6gkm75r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="il4wRQEE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FE2DC77B;
	Sat, 10 Jan 2026 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074394; cv=none; b=c6SF864lld4QdZJILt757KWShLEOIdjZ75P873k1nH7TRCl3LwsS4VWcfpCWJbHcrk0LqQdok5yEEDNbxy6tjeLjAx4d9nBQ+t1/r8HlnH4e5H9G5dk5V2DcvQ17391o2WXdFIRRA01yQwXvQRiD525liqkfdeWo20GHATgNiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074394; c=relaxed/simple;
	bh=Y4IZHsWBKBpnYgPln+BMiqokj2LiKbEwoc4lvcq6bjw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OGqTML1iObR3UV/We1RRzLfcTrMYN9c97YS1WM2w5i4ZHXPDLLkp6IkZwgAr+OrK1H3qvDW5yi8KPMH10DvQ+NlK3+mt/UUNEbc8/qAzczwRItJ8kRNGZ2aILGGixTX+EC1UGaadvu3c3jsAPM0DjGwuqR2T/FQmo4jQP7/WeOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P6gkm75r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=il4wRQEE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Z4JWf9OU4W73BbBefpvBzy0w448m6XuTGyA2MNxM1d0=;
	b=P6gkm75r6b9LWotu1TyXXSbCDoEcTy8e2Ro/vjSeSFZiysEuRTOI/ljGfQeqHmNIneBS6X
	uKgxRoVEGfUZ+8bKTiW/0YPXtL6ApL+9KlzB4igKdofKuCIIytYIfqipq9wxoixAQPI3J4
	kuAnS8XQCYwZ2yFHcFRUWSgmQwcxra2mte1+I7Jts0IbsIVgRFOnVqnkIpBik3QaoRuSfZ
	0hogKodZpIfXsTsJFV4c2aq1ayxMJE+TiLH85aR+LroMUzOEujRwBJOy84Ck6o6m9v3thI
	bfuEfyTnPi95q0ypXfDmQCn8JPjie203AWJp+DpT8tkiHScx1z234IMxo/1+3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Z4JWf9OU4W73BbBefpvBzy0w448m6XuTGyA2MNxM1d0=;
	b=il4wRQEEV1eSy88n7+ZP7h9typ77M+gYWBN9lJWGxqiK0dLwnmaqFfuP98m5Xp4bLJrhbU
	bQyZlbS4xTVISUCA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Improve domain type checking
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807438107.510.8877020021085222786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     03eb578b37659e10bed14c2d9e7cc45dfe24123b
Gitweb:        https://git.kernel.org/tip/03eb578b37659e10bed14c2d9e7cc45dfe2=
4123b
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:48 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 04 Jan 2026 07:30:10 +01:00

x86,fs/resctrl: Improve domain type checking

Every resctrl resource has a list of domain structures. struct rdt_ctrl_domain
and struct rdt_mon_domain both begin with struct rdt_domain_hdr with
rdt_domain_hdr::type used in validity checks before accessing the domain of
a particular type.

Add the resource id to struct rdt_domain_hdr in preparation for a new monitor=
ing
domain structure that will be associated with a new monitoring resource. Impr=
ove
existing domain validity checks with a new helper domain_header_is_valid()
that checks both domain type and resource id.  domain_header_is_valid() should
be used before every call to container_of() that accesses a domain structure.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 10 ++++++----
 fs/resctrl/ctrlmondata.c           |  2 +-
 include/linux/resctrl.h            |  9 +++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 3792ab4..0b8b7b8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -464,7 +464,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resou=
rce *r)
=20
 	hdr =3D resctrl_find_domain(&r->ctrl_domains, id, &add_pos);
 	if (hdr) {
-		if (WARN_ON_ONCE(hdr->type !=3D RESCTRL_CTRL_DOMAIN))
+		if (!domain_header_is_valid(hdr, RESCTRL_CTRL_DOMAIN, r->rid))
 			return;
 		d =3D container_of(hdr, struct rdt_ctrl_domain, hdr);
=20
@@ -481,6 +481,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resou=
rce *r)
 	d =3D &hw_dom->d_resctrl;
 	d->hdr.id =3D id;
 	d->hdr.type =3D RESCTRL_CTRL_DOMAIN;
+	d->hdr.rid =3D r->rid;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
=20
 	rdt_domain_reconfigure_cdp(r);
@@ -520,7 +521,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resour=
ce *r)
=20
 	hdr =3D resctrl_find_domain(&r->mon_domains, id, &add_pos);
 	if (hdr) {
-		if (WARN_ON_ONCE(hdr->type !=3D RESCTRL_MON_DOMAIN))
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
 			return;
 		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
=20
@@ -538,6 +539,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resour=
ce *r)
 	d =3D &hw_dom->d_resctrl;
 	d->hdr.id =3D id;
 	d->hdr.type =3D RESCTRL_MON_DOMAIN;
+	d->hdr.rid =3D r->rid;
 	ci =3D get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 	if (!ci) {
 		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
@@ -598,7 +600,7 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_re=
source *r)
 		return;
 	}
=20
-	if (WARN_ON_ONCE(hdr->type !=3D RESCTRL_CTRL_DOMAIN))
+	if (!domain_header_is_valid(hdr, RESCTRL_CTRL_DOMAIN, r->rid))
 		return;
=20
 	d =3D container_of(hdr, struct rdt_ctrl_domain, hdr);
@@ -644,7 +646,7 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_res=
ource *r)
 		return;
 	}
=20
-	if (WARN_ON_ONCE(hdr->type !=3D RESCTRL_MON_DOMAIN))
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
 		return;
=20
 	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index b2d178d..905c310 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -653,7 +653,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 * the resource to find the domain with "domid".
 		 */
 		hdr =3D resctrl_find_domain(&r->mon_domains, domid, NULL);
-		if (!hdr || WARN_ON_ONCE(hdr->type !=3D RESCTRL_MON_DOMAIN)) {
+		if (!hdr || !domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, resid)) {
 			ret =3D -ENOENT;
 			goto out;
 		}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5470166..e7c218f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -131,15 +131,24 @@ enum resctrl_domain_type {
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @type:		type of this instance
+ * @rid:		resource id for this instance
  * @cpu_mask:		which CPUs share this resource
  */
 struct rdt_domain_hdr {
 	struct list_head		list;
 	int				id;
 	enum resctrl_domain_type	type;
+	enum resctrl_res_level		rid;
 	struct cpumask			cpu_mask;
 };
=20
+static inline bool domain_header_is_valid(struct rdt_domain_hdr *hdr,
+					  enum resctrl_domain_type type,
+					  enum resctrl_res_level rid)
+{
+	return !WARN_ON_ONCE(hdr->type !=3D type || hdr->rid !=3D rid);
+}
+
 /**
  * struct rdt_ctrl_domain - group of CPUs sharing a resctrl control resource
  * @hdr:		common header for different domain types

