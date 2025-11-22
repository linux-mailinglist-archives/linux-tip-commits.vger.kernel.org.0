Return-Path: <linux-tip-commits+bounces-7469-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDC5C7D362
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5633E3A9E41
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F322E2F14;
	Sat, 22 Nov 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0/UUhRD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAc05aex"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16E2BDC25;
	Sat, 22 Nov 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826524; cv=none; b=DVLVUEZGDdXvOyM1HIisV4hcjJgeL+727UrxsE2XQNMv7dKIDyrp+4bN2KUGHMR3ZBo/uBWVY4RWwi52yByHVtREfrPewAbjPrTyTVaiAP7kVOCkm7OU8QiiPIHaUDjoTgQ26gWKp0veIMzR4fTdb9usycb0FgZsAjuEuXSDGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826524; c=relaxed/simple;
	bh=GL3qBR8/0yiOiLfJ/f8ML0SQPlqxGiER4w4Na/wVEvU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hl2DgWZIXh3dEeMUhKiByNuadqkxsiqBREoSbAHegOXZKvZndEqHsGCRyPtM9LcBOdgwhi8TvvTpqTxy+yoKc+9Y5IOHjh7PxVcK23WkoFxl9KS8hzAOn/8N9IN09oB7GZjNKo4559L1+xhbW1C45dIvGxcMujy1+wM8P0G7saU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0/UUhRD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAc05aex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Or56qg2scOoZqGNoU/3sX+REzVrwDfiJCrKPIzMoGEY=;
	b=Q0/UUhRD4PSXwq+Paw98ELfFWN4dHdGgTz6ojZIY8DTBXl76xP8t22hssUQwaHFpni8SAX
	IBvo570cl+9ggwVu2XfzVTGUL13BSL/TmkJgJrm6LdP43HCoebQIkytiB86TYWUk1VweIL
	J9bAAg3tXhy0LlDnLNbhXhg63Oo8uvFkbB5jV2tJgUEoC82NBeegNUMAJ51LXV3PvEHktK
	UhoxQ/Zl79QNEAWDrB4WGYcB+jvkiHHveuo3PFlwvn5CFUdQMk8cd3piREQ2NZuMyaGZEx
	mMbQV3juvwxoRejKHMoSpi1Dzk+XYYEvqYto1ldsFS5d5WMdk6rtk+SZKtks0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Or56qg2scOoZqGNoU/3sX+REzVrwDfiJCrKPIzMoGEY=;
	b=hAc05aexJamMpQRSvkO3oVCQr9z8oz6Eb7/xHOYZdeQdQ4xZZVA2GbZGEMaPcPyfR/cLcL
	qR342Jtj3MqLxPDg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86,fs/resctrl: Implement "io_alloc" enable/disable handlers
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <9e9070100c320eab5368e088a3642443dee95ed7.1762995456.git.babu.moger@amd.com>
References:
 <9e9070100c320eab5368e088a3642443dee95ed7.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382651920.498.17962075709771133849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     556d2892aa715286d840a74216c8fff885559261
Gitweb:        https://git.kernel.org/tip/556d2892aa715286d840a74216c8fff8855=
59261
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:30 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 22:35:22 +01:00

x86,fs/resctrl: Implement "io_alloc" enable/disable handlers

"io_alloc" is the generic name of the new resctrl feature that enables system
software to configure the portion of cache allocated for I/O traffic. On AMD
systems, "io_alloc" resctrl feature is backed by AMD's L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE).

Introduce the architecture-specific functions that resctrl fs should call to
enable, disable, or check status of the "io_alloc" feature. Change SDCIAE sta=
te
by setting (to enable) or clearing (to disable) bit 1 of
MSR_IA32_L3_QOS_EXT_CFG on all logical processors within the cache domain.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/9e9070100c320eab5368e088a3642443dee95ed7.17629=
95456.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 ++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    |  5 +++-
 include/linux/resctrl.h                   | 21 ++++++++++++-
 3 files changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/=
resctrl/ctrlmondata.c
index 1189c0d..b20e705 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -91,3 +91,43 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct=
 rdt_ctrl_domain *d,
=20
 	return hw_dom->ctrl_val[idx];
 }
+
+bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->sdciae_enabled;
+}
+
+static void resctrl_sdciae_set_one_amd(void *arg)
+{
+	bool *enable =3D arg;
+
+	if (*enable)
+		msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
+	else
+		msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
+}
+
+static void _resctrl_sdciae_enable(struct rdt_resource *r, bool enable)
+{
+	struct rdt_ctrl_domain *d;
+
+	/* Walking r->ctrl_domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	/* Update MSR_IA32_L3_QOS_EXT_CFG MSR on all the CPUs in all domains */
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list)
+		on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_sdciae_set_one_amd, &enable, 1);
+}
+
+int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
+{
+	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
+
+	if (hw_res->r_resctrl.cache.io_alloc_capable &&
+	    hw_res->sdciae_enabled !=3D enable) {
+		_resctrl_sdciae_enable(r, enable);
+		hw_res->sdciae_enabled =3D enable;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 9f4c2f0..4a916c8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -46,6 +46,9 @@ struct arch_mbm_state {
 #define ABMC_EXTENDED_EVT_ID		BIT(31)
 #define ABMC_EVT_ID			BIT(0)
=20
+/* Setting bit 1 in MSR_IA32_L3_QOS_EXT_CFG enables the SDCIAE feature. */
+#define SDCIAE_ENABLE_BIT		1
+
 /**
  * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that=
 share
  *			       a resource for a control function
@@ -112,6 +115,7 @@ struct msr_param {
  * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @cdp_enabled:	CDP state of this resource
  * @mbm_cntr_assign_enabled:	ABMC feature is enabled
+ * @sdciae_enabled:	SDCIAE feature (backing "io_alloc") is enabled.
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -126,6 +130,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	bool			cdp_enabled;
 	bool			mbm_cntr_assign_enabled;
+	bool			sdciae_enabled;
 };
=20
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resourc=
e *r)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 533f240..5470166 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -657,6 +657,27 @@ void resctrl_arch_reset_cntr(struct rdt_resource *r, str=
uct rdt_mon_domain *d,
 			     u32 closid, u32 rmid, int cntr_id,
 			     enum resctrl_event_id eventid);
=20
+/**
+ * resctrl_arch_io_alloc_enable() - Enable/disable io_alloc feature.
+ * @r:		The resctrl resource.
+ * @enable:	Enable (true) or disable (false) io_alloc on resource @r.
+ *
+ * This can be called from any CPU.
+ *
+ * Return:
+ * 0 on success, <0 on error.
+ */
+int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
+
+/**
+ * resctrl_arch_get_io_alloc_enabled() - Get io_alloc feature state.
+ * @r:		The resctrl resource.
+ *
+ * Return:
+ * true if io_alloc is enabled or false if disabled.
+ */
+bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
=20

