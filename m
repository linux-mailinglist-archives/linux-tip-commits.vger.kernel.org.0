Return-Path: <linux-tip-commits+bounces-6619-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A918CB5783D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBD01898729
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152343043DE;
	Mon, 15 Sep 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bh+v5jNf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F0nRyRq4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6F302CC9;
	Mon, 15 Sep 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935664; cv=none; b=PFilSdcGzQ+juYtomxjxQsxvSHQIWNoBOVKvpn7v0M5mpYJCsMerIYzWaQ3vT8Fk1wB1ttmm6UMHTh1eMxcmjCGDLw6I+9pCdpNV8n1S8iCZ0rDy4Puvz44FbJrY+2ha2d+Poj7Iu2N9QIs7B3Q+LtBzDCl692rFPQpZqZQbyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935664; c=relaxed/simple;
	bh=vq3XO7iq2QZxX0YSgdFLZDlgyv9x98Xlg/zlH1v6Lxs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iLqxv98tq9ruVOI8jk5AjMpAtYaqbknN0hNMRZHplBi8OS69VqgyVwjfBJuqCWNZYhKSN+2yrmTU4EYJzYMMY/WKIaIK7estU831a/9l2+MRLect6WoKi9vk/5YowQJYSVb0EE3yn6flP1qE7KoiKXRJDuSJXRHChuuZF7AMuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bh+v5jNf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F0nRyRq4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0h57lN+XAkt/WTJ3Tu4UIMLLesWwA2ZeC9owZSwUSFM=;
	b=Bh+v5jNfm6CJPowZ9nEvDx+rZCsAk0L+tJGz7MHezwAoH1LxXU43to+LpHkL0DpVgVbJV4
	4Tt6IQnMKQgF95aaJ4AtvsI1AZSKwhaUmjmwGWkIXW6Lo+pCDIpsCkDV5c/WFVO37jaSsR
	r0iiZ7ZMI854/qssGKTQo7EISHsxdcWMRozh+FmSj1eCKWIdBXW7YXTyMOw60+Sop9N8hL
	Adgev1s09bvIJjtwiGNbMjsztxbGfbccmBPYNaOBjXINEPNCdEIGTE8lZdAZKzJe86qNlQ
	gYCw80CYO/F676JSuW/KMpzHHRNRDWxMuRO03Tvwjz0VRXFm6jf56SHe7HmI7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0h57lN+XAkt/WTJ3Tu4UIMLLesWwA2ZeC9owZSwUSFM=;
	b=F0nRyRq4WoZcPEPn2kljCsf2DcGApZYiA0WcO5sHUcRYI5H8sclCfN8UOtUmBG8zxnqUDu
	X32PsZi8vC73mrAg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Implement resctrl_arch_config_cntr()
 to assign a counter with ABMC
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <fc76658255a1e5e474cbfc4cab92df601f929a65.1757108044.git.babu.moger@amd.com>
References:
 <fc76658255a1e5e474cbfc4cab92df601f929a65.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565903.709179.1919554635936944227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f7a4fb22312646329ba21bc58958fd83fb9fc15d
Gitweb:        https://git.kernel.org/tip/f7a4fb22312646329ba21bc58958fd83fb9=
fc15d
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:15 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:20:29 +02:00

x86,fs/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with=
 ABMC

The ABMC feature allows users to assign a hardware counter to an RMID,
event pair and monitor bandwidth usage as long as it is assigned. The
hardware continues to track the assigned counter until it is explicitly
unassigned by the user.

Implement an x86 architecture-specific handler to configure a counter. This
architecture specific handler is called by resctrl fs when a counter is
assigned or unassigned as well as when an already assigned counter's
configuration should be updated. Configure counters by writing to the
L3_QOS_ABMC_CFG MSR, specifying the counter ID, bandwidth source (RMID),
and event configuration.

The ABMC feature details are documented in APM [1] available from [2].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537 # [2]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 36 ++++++++++++++++++++++++++-
 include/linux/resctrl.h               | 19 ++++++++++++++-
 2 files changed, 55 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index cce35a0..ed295a6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -444,3 +444,39 @@ bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_res=
ource *r)
 {
 	return resctrl_to_arch_res(r)->mbm_cntr_assign_enabled;
 }
+
+static void resctrl_abmc_config_one_amd(void *info)
+{
+	union l3_qos_abmc_cfg *abmc_cfg =3D info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg->full);
+}
+
+/*
+ * Send an IPI to the domain to assign the counter to RMID, event pair.
+ */
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain =
*d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign)
+{
+	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg =3D { 0 };
+	struct arch_mbm_state *am;
+
+	abmc_cfg.split.cfg_en =3D 1;
+	abmc_cfg.split.cntr_en =3D assign ? 1 : 0;
+	abmc_cfg.split.cntr_id =3D cntr_id;
+	abmc_cfg.split.bw_src =3D rmid;
+	if (assign)
+		abmc_cfg.split.bw_type =3D resctrl_get_mon_evt_cfg(evtid);
+
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &abmc_=
cfg, 1);
+
+	/*
+	 * The hardware counter is reset (because cfg_en =3D=3D 1) so there is no
+	 * need to record initial non-zero counts.
+	 */
+	am =3D get_arch_mbm_state(hw_dom, rmid, evtid);
+	if (am)
+		memset(am, 0, sizeof(*am));
+}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 87daa4c..50e3844 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -594,6 +594,25 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r,=
 struct rdt_mon_domain *
  */
 void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
=20
+/**
+ * resctrl_arch_config_cntr() - Configure the counter with its new RMID
+ *				and event details.
+ * @r:			Resource structure.
+ * @d:			The domain in which counter with ID @cntr_id should be configured.
+ * @evtid:		Monitoring event type (e.g., QOS_L3_MBM_TOTAL_EVENT_ID
+ *			or QOS_L3_MBM_LOCAL_EVENT_ID).
+ * @rmid:		RMID.
+ * @closid:		CLOSID.
+ * @cntr_id:		Counter ID to configure.
+ * @assign:		True to assign the counter or update an existing assignment,
+ *			false to unassign the counter.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain =
*d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
=20

