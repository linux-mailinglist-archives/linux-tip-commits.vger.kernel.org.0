Return-Path: <linux-tip-commits+bounces-7883-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACDD11132
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8A0230AB722
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EE2346AFA;
	Mon, 12 Jan 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNfv6HQ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="983rBtjx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FC3446B7;
	Mon, 12 Jan 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205008; cv=none; b=EMTxCq1aYbPo1GpnETu30xeuee1il29b44zu6SFjbYe/qpJ3Gj4CKprrsCC4ysMapMiOLw+dodJshWbqOGmXqJP78lLMXlDgwu4d82tOvUjKqwJNhvTUQ0HNqr07KkVg48HAQcIHVs1YKi7536n8UmmHNipVnnYmRdEFxXyl/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205008; c=relaxed/simple;
	bh=aJ0qd/UUsAFoooYv8mBZ5bT50/hfW8/VJ0pPPIBLR4A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NTklyBzTIdMJWwZfFzdeDRitByy1yrRewgTOHqcNnmp0RrxfOXubYjjxkRHNTtWQfrgysI7QxmKvDx9nWYct57ZUeaVDNtc3R4wK5Q2YMz2Uym4xKHoEb6akpOinrfBJ8NSzH6DJy4BU2j+uhnOba+0hBfaSWtAcvA1BAwT+UmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MNfv6HQ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=983rBtjx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQLPnOkBJero5zmR9YP9Qx1uS/ZJI4c5TkoNZZN4CbM=;
	b=MNfv6HQ49EIY8DLn4LQD5h57IX4rRESS6i+KzfLw/JWzI5kPV1lvVI50p0biPNPLCWDee/
	YkHy/yZpHt6IEDZntkNXLIu6JWkWZ2eRIMA4GUp4nYa9N8ahnV8Beb9JIwaocopjDCg+n5
	9vVM3AHlUmJnv0GHD6IyinvqNLd4KzD1568kY/cw0dy0gvZZcnLxy5FmFv/7tuJsW3j8f3
	k3szyDrrPBhcXYySZXRNiPHisdx3XlzfaCRyvnxTZu51VRG035tCw1+cvhGBDaSgLdFxh+
	L3XMXUN539ZSPCl9vcz5dBmLaX46hSYF7S+nrCRON4wU+blH3HtmOS1b4eHmwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQLPnOkBJero5zmR9YP9Qx1uS/ZJI4c5TkoNZZN4CbM=;
	b=983rBtjxSU/Kxu42duL8Oh7uNSdNF+YY+Y9zoj3HkL0a3Qiw5aAlvSOuzFLKGOWKsr4K5U
	JxEV4i1Yqy3QJeAw==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add IMH PMON support for
 Diamond Rapids
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-5-zide.chen@intel.com>
References: <20251231224233.113839-5-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499374.510.14758156195644170088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6daf2c35b835da211bf70606e9f74d1af98613a9
Gitweb:        https://git.kernel.org/tip/6daf2c35b835da211bf70606e9f74d1af98=
613a9
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:21 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:24 +01:00

perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids

DMR supports IMH PMON units for PCU, UBox, iMC, and CXL:
- PCU and UBox are same with SPR.
- iMC is similar to SPR but uses different offsets for fixed registers.
- CXL introduces a new port_enable field and changes the position of
  the threshold field.

DMR also introduces additional PMON units: SCA, HAMVF, D2D_ULA, UBR,
PCIE4, CRS, CPC, ITC, OTC, CMS, and PCIE6.  Among these, PCIE4 and
PCIE6 use different unit types, but share the same config register
layout, and the generic PCIe PMON events apply to both.

Additionally, ignore the broken MSE unit.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251231224233.113839-5-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c           |   9 +-
 arch/x86/events/intel/uncore.h           |   3 +-
 arch/x86/events/intel/uncore_discovery.h |   2 +-
 arch/x86/events/intel/uncore_snbep.c     | 229 ++++++++++++++++++++++-
 4 files changed, 243 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 2387b1a..40cf9bf 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1831,6 +1831,14 @@ static const struct uncore_plat_init gnr_uncore_init _=
_initconst =3D {
 	.domain[0].units_ignore =3D gnr_uncore_units_ignore,
 };
=20
+static const struct uncore_plat_init dmr_uncore_init __initconst =3D {
+	.pci_init =3D dmr_uncore_pci_init,
+	.mmio_init =3D dmr_uncore_mmio_init,
+	.domain[0].base_is_pci =3D true,
+	.domain[0].discovery_base =3D DMR_UNCORE_DISCOVERY_TABLE_DEVICE,
+	.domain[0].units_ignore =3D dmr_uncore_imh_units_ignore,
+};
+
 static const struct uncore_plat_init generic_uncore_init __initconst =3D {
 	.cpu_init =3D intel_uncore_generic_uncore_cpu_init,
 	.pci_init =3D intel_uncore_generic_uncore_pci_init,
@@ -1898,6 +1906,7 @@ static const struct x86_cpu_id intel_uncore_match[] __i=
nitconst =3D {
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&gnr_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&gnr_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X,	&dmr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 1574ffc..1e4b3a2 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -614,6 +614,7 @@ extern struct pci_extra_dev *uncore_extra_pci_dev;
 extern struct event_constraint uncore_constraint_empty;
 extern int spr_uncore_units_ignore[];
 extern int gnr_uncore_units_ignore[];
+extern int dmr_uncore_imh_units_ignore[];
=20
 /* uncore_snb.c */
 int snb_uncore_pci_init(void);
@@ -662,6 +663,8 @@ void spr_uncore_mmio_init(void);
 int gnr_uncore_pci_init(void);
 void gnr_uncore_cpu_init(void);
 void gnr_uncore_mmio_init(void);
+int dmr_uncore_pci_init(void);
+void dmr_uncore_mmio_init(void);
=20
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel=
/uncore_discovery.h
index dfc237a..618788c 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -5,6 +5,8 @@
=20
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
+/* Device ID used on DMR */
+#define DMR_UNCORE_DISCOVERY_TABLE_DEVICE	0x09a1
 /* Capability ID for a discovery table device */
 #define UNCORE_EXT_CAP_ID_DISCOVERY		0x23
 /* First DVSEC offset */
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index e1f370b..4b72560 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -471,6 +471,14 @@
=20
 #define SPR_C0_MSR_PMON_BOX_FILTER0		0x200e
=20
+/* DMR */
+#define DMR_CXLCM_EVENT_MASK_EXT		0xf
+#define DMR_HAMVF_EVENT_MASK_EXT		0xffffffff
+#define DMR_PCIE4_EVENT_MASK_EXT		0xffffff
+
+#define DMR_IMC_PMON_FIXED_CTR			0x18
+#define DMR_IMC_PMON_FIXED_CTL			0x10
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
@@ -486,6 +494,10 @@ DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en2, tid_en, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
+DEFINE_UNCORE_FORMAT_ATTR(inv2, inv, "config:21");
+DEFINE_UNCORE_FORMAT_ATTR(thresh_ext, thresh_ext, "config:32-35");
+DEFINE_UNCORE_FORMAT_ATTR(thresh10, thresh, "config:23-32");
+DEFINE_UNCORE_FORMAT_ATTR(thresh9_2, thresh, "config:23-31");
 DEFINE_UNCORE_FORMAT_ATTR(thresh9, thresh, "config:24-35");
 DEFINE_UNCORE_FORMAT_ATTR(thresh8, thresh, "config:24-31");
 DEFINE_UNCORE_FORMAT_ATTR(thresh6, thresh, "config:24-29");
@@ -494,6 +506,13 @@ DEFINE_UNCORE_FORMAT_ATTR(occ_sel, occ_sel, "config:14-1=
5");
 DEFINE_UNCORE_FORMAT_ATTR(occ_invert, occ_invert, "config:30");
 DEFINE_UNCORE_FORMAT_ATTR(occ_edge, occ_edge, "config:14-51");
 DEFINE_UNCORE_FORMAT_ATTR(occ_edge_det, occ_edge_det, "config:31");
+DEFINE_UNCORE_FORMAT_ATTR(port_en, port_en, "config:32-35");
+DEFINE_UNCORE_FORMAT_ATTR(rs3_sel, rs3_sel, "config:36");
+DEFINE_UNCORE_FORMAT_ATTR(rx_sel, rx_sel, "config:37");
+DEFINE_UNCORE_FORMAT_ATTR(tx_sel, tx_sel, "config:38");
+DEFINE_UNCORE_FORMAT_ATTR(iep_sel, iep_sel, "config:39");
+DEFINE_UNCORE_FORMAT_ATTR(vc_sel, vc_sel, "config:40-47");
+DEFINE_UNCORE_FORMAT_ATTR(port_sel, port_sel, "config:48-55");
 DEFINE_UNCORE_FORMAT_ATTR(ch_mask, ch_mask, "config:36-43");
 DEFINE_UNCORE_FORMAT_ATTR(ch_mask2, ch_mask, "config:36-47");
 DEFINE_UNCORE_FORMAT_ATTR(fc_mask, fc_mask, "config:44-46");
@@ -6709,3 +6728,213 @@ void gnr_uncore_mmio_init(void)
 }
=20
 /* end of GNR uncore support */
+
+/* DMR uncore support */
+#define UNCORE_DMR_NUM_UNCORE_TYPES	52
+
+static struct attribute *dmr_imc_uncore_formats_attr[] =3D {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh10.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_imc_uncore_format_group =3D {
+	.name =3D "format",
+	.attrs =3D dmr_imc_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_imc =3D {
+	.name			=3D "imc",
+	.fixed_ctr_bits		=3D 48,
+	.fixed_ctr		=3D DMR_IMC_PMON_FIXED_CTR,
+	.fixed_ctl		=3D DMR_IMC_PMON_FIXED_CTL,
+	.ops			=3D &spr_uncore_mmio_ops,
+	.format_group		=3D &dmr_imc_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct attribute *dmr_sca_uncore_formats_attr[] =3D {
+	&format_attr_event.attr,
+	&format_attr_umask_ext5.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_sca_uncore_format_group =3D {
+	.name =3D "format",
+	.attrs =3D dmr_sca_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_sca =3D {
+	.name			=3D "sca",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct attribute *dmr_cxlcm_uncore_formats_attr[] =3D {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv2.attr,
+	&format_attr_thresh9_2.attr,
+	&format_attr_port_en.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_cxlcm_uncore_format_group =3D {
+	.name =3D "format",
+	.attrs =3D dmr_cxlcm_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_cxlcm =3D {
+	.name			=3D "cxlcm",
+	.event_mask		=3D GENERIC_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		=3D DMR_CXLCM_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_cxlcm_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_hamvf =3D {
+	.name			=3D "hamvf",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_ula =3D {
+	.name			=3D "ula",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_ubr =3D {
+	.name			=3D "ubr",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct attribute *dmr_pcie4_uncore_formats_attr[] =3D {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	&format_attr_thresh_ext.attr,
+	&format_attr_rs3_sel.attr,
+	&format_attr_rx_sel.attr,
+	&format_attr_tx_sel.attr,
+	&format_attr_iep_sel.attr,
+	&format_attr_vc_sel.attr,
+	&format_attr_port_sel.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_pcie4_uncore_format_group =3D {
+	.name =3D "format",
+	.attrs =3D dmr_pcie4_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_pcie4 =3D {
+	.name			=3D "pcie4",
+	.event_mask_ext		=3D DMR_PCIE4_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_pcie4_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_crs =3D {
+	.name			=3D "crs",
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_cpc =3D {
+	.name			=3D "cpc",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_itc =3D {
+	.name			=3D "itc",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_otc =3D {
+	.name			=3D "otc",
+	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_sca_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_cms =3D {
+	.name			=3D "cms",
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_pcie6 =3D {
+	.name			=3D "pcie6",
+	.event_mask_ext		=3D DMR_PCIE4_EVENT_MASK_EXT,
+	.format_group		=3D &dmr_pcie4_uncore_format_group,
+	.attr_update		=3D uncore_alias_groups,
+};
+
+static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] =
=3D {
+	NULL, NULL, NULL, NULL,
+	&spr_uncore_pcu,
+	&gnr_uncore_ubox,
+	&dmr_uncore_imc,
+	NULL,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL,
+	&dmr_uncore_sca,
+	&dmr_uncore_cxlcm,
+	NULL, NULL, NULL,
+	NULL, NULL,
+	&dmr_uncore_hamvf,
+	NULL,
+	NULL, NULL, NULL,
+	&dmr_uncore_ula,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL,
+	&dmr_uncore_ubr,
+	NULL,
+	&dmr_uncore_pcie4,
+	&dmr_uncore_crs,
+	&dmr_uncore_cpc,
+	&dmr_uncore_itc,
+	&dmr_uncore_otc,
+	&dmr_uncore_cms,
+	&dmr_uncore_pcie6,
+};
+
+int dmr_uncore_imh_units_ignore[] =3D {
+	0x13,		/* MSE */
+	UNCORE_IGNORE_END
+};
+
+int dmr_uncore_pci_init(void)
+{
+	uncore_pci_uncores =3D uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,
+						UNCORE_DMR_NUM_UNCORE_TYPES,
+						dmr_uncores);
+	return 0;
+}
+void dmr_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+						 UNCORE_DMR_NUM_UNCORE_TYPES,
+						 dmr_uncores);
+}
+
+/* end of DMR uncore support */

