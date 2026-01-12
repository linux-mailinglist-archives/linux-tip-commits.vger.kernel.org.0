Return-Path: <linux-tip-commits+bounces-7877-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D528D110E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D883054B35
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808B342529;
	Mon, 12 Jan 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdoiIn6J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbW8qCz+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB533EB1D;
	Mon, 12 Jan 2026 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204993; cv=none; b=blWC1UME8paWFyFH5giOOr/As+xvyeXAXqMQrrqH8SbLGamA+dpegx5fLOAdg0/An4coNIaTxsvrkdLFIPffHWG4GxiqMKvjQdxDK6HsCuklc3WclMuB2qlEIDSEdI2/6783s872V9SOKOQstASxGuB5RQbY6WHQV/auUhQZTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204993; c=relaxed/simple;
	bh=9ZAMLp4eZU+BDBPaONSi+K/KpjbiVAb6gR86NJjIuXY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o9JBNpecblbB0WOUpOkqq8+2CYIg/n0VsEV0QxDYj92EUwaUZBh6oM317GxDWGbCEHHwoYodWMh5cxCx7/RNaWlNSn1rjE9JtrShmXR4xu+cCbr+GH1YlLk05NgXF188khLQAfNegYa9dARjDjNPZYO9UzFvZf3uMuwXiBiuAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdoiIn6J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbW8qCz+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xp5wNTZEHscGxjoXrkgZ2tQRoAP4ayNS4insRw3/YkA=;
	b=kdoiIn6J24a+3kp3dSsIrwRP/e0BhyM3XAw1LsCZ3aiyMc1JusZObXOzZJJNY3DlVwCw1f
	1VRmJgtOwyHAVz5On4cG15kq42gyId/ZO3o2EKTvhSk91ClObR9lMAtGFTIizc0sp10UjL
	BlaT/ZiAXglhpREDYIn9Xa0a70RB2BjPKdFGTnvULn372JEjRYetEdmObQAIpIPIqxMO5q
	CzMd0dmX6bV/qFAWEwSYiLKxzNpDU0jFJLKV3XGHMhMC5c1W5bpcbhKOyEMMH9dQYl3Szq
	Mkqrq4dkx3cUylBdtXi2yGgNoB151LWdQZvzKt189WADCoOb1uIrm92mD0kIhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xp5wNTZEHscGxjoXrkgZ2tQRoAP4ayNS4insRw3/YkA=;
	b=BbW8qCz+D5+sJHWa0mUJMFF5EOa5EOgn3vZnqH20ktJ0HMdkzHJ5HJlROS8Z7QV2MzwPUg
	Hocb9NZf+QQi+YAA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support IIO free-running
 counters on DMR
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-9-zide.chen@intel.com>
References: <20251231224233.113839-9-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820498935.510.7253455875506862425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d8987048f6655b38453d00782a256179f082b79c
Gitweb:        https://git.kernel.org/tip/d8987048f6655b38453d00782a256179f08=
2b79c
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:25 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:25 +01:00

perf/x86/intel/uncore: Support IIO free-running counters on DMR

The free-running counters for IIO uncore blocks on Diamond Rapids are
similar to Sapphire Rapids IMC freecounters, with the following
differences:

- The counters are MMIO based.
- Only a subset of IP blocks implement free-running counters:
  HIOP0 (IP Base Addr: 2E7000h)
  HIOP1 (IP Base Addr: 2EF000h)
  HIOP3 (IP Base Addr: 2FF000h)
  HIOP4 (IP Base Addr: 307000h)
- IMH2 (Secondary IMH) does not provide free-running counters.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-9-zide.chen@intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 118 ++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index cfb4ce3..cc8145e 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -472,10 +472,14 @@
 #define SPR_C0_MSR_PMON_BOX_FILTER0		0x200e
=20
 /* DMR */
+#define DMR_IMH1_HIOP_MMIO_BASE			0x1ffff6ae7000
+#define DMR_HIOP_MMIO_SIZE			0x8000
 #define DMR_CXLCM_EVENT_MASK_EXT		0xf
 #define DMR_HAMVF_EVENT_MASK_EXT		0xffffffff
 #define DMR_PCIE4_EVENT_MASK_EXT		0xffffff
=20
+#define UNCORE_DMR_ITC				0x30
+
 #define DMR_IMC_PMON_FIXED_CTR			0x18
 #define DMR_IMC_PMON_FIXED_CTL			0x10
=20
@@ -6442,7 +6446,11 @@ static int uncore_type_max_boxes(struct intel_uncore_t=
ype **types,
 	for (node =3D rb_first(type->boxes); node; node =3D rb_next(node)) {
 		unit =3D rb_entry(node, struct intel_uncore_discovery_unit, node);
=20
-		if (unit->id > max)
+		/*
+		 * on DMR IMH2, the unit id starts from 0x8000,
+		 * and we don't need to count it.
+		 */
+		if ((unit->id > max) && (unit->id < 0x8000))
 			max =3D unit->id;
 	}
 	return max + 1;
@@ -6930,6 +6938,101 @@ int dmr_uncore_cbb_units_ignore[] =3D {
 	UNCORE_IGNORE_END
 };
=20
+static unsigned int dmr_iio_freerunning_box_offsets[] =3D {
+	0x0, 0x8000, 0x18000, 0x20000
+};
+
+static void dmr_uncore_freerunning_init_box(struct intel_uncore_box *box)
+{
+	struct intel_uncore_type *type =3D box->pmu->type;
+	u64 mmio_base;
+
+	if (box->pmu->pmu_idx >=3D type->num_boxes)
+		return;
+
+	mmio_base =3D DMR_IMH1_HIOP_MMIO_BASE;
+	mmio_base +=3D dmr_iio_freerunning_box_offsets[box->pmu->pmu_idx];
+
+	box->io_addr =3D ioremap(mmio_base, type->mmio_map_size);
+	if (!box->io_addr)
+		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
+}
+
+static struct intel_uncore_ops dmr_uncore_freerunning_ops =3D {
+	.init_box	=3D dmr_uncore_freerunning_init_box,
+	.exit_box	=3D uncore_mmio_exit_box,
+	.read_counter	=3D uncore_mmio_read_counter,
+	.hw_config	=3D uncore_freerunning_hw_config,
+};
+
+enum perf_uncore_dmr_iio_freerunning_type_id {
+	DMR_ITC_INB_DATA_BW,
+	DMR_ITC_BW_IN,
+	DMR_OTC_BW_OUT,
+	DMR_OTC_CLOCK_TICKS,
+
+	DMR_IIO_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters dmr_iio_freerunning[] =3D {
+	[DMR_ITC_INB_DATA_BW]	=3D { 0x4d40, 0x8, 0, 8, 48},
+	[DMR_ITC_BW_IN]		=3D { 0x6b00, 0x8, 0, 8, 48},
+	[DMR_OTC_BW_OUT]	=3D { 0x6b60, 0x8, 0, 8, 48},
+	[DMR_OTC_CLOCK_TICKS]	=3D { 0x6bb0, 0x8, 0, 1, 48},
+};
+
+static struct uncore_event_desc dmr_uncore_iio_freerunning_events[] =3D {
+	/*  ITC Free Running Data BW counter for inbound traffic */
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, "3.814697266e-6"),
+
+	/*  ITC Free Running BW IN counters */
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, "3.814697266e-6"),
+
+	/*  ITC Free Running BW OUT counters */
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, "3.814697266e-6"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, "3.814697266e-6"),
+
+	/* Free Running Clock Counter */
+	INTEL_UNCORE_EVENT_DESC(clockticks, "event=3D0xff,umask=3D0x40"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type dmr_uncore_iio_free_running =3D {
+	.name			=3D "iio_free_running",
+	.num_counters		=3D 25,
+	.mmio_map_size		=3D DMR_HIOP_MMIO_SIZE,
+	.num_freerunning_types	=3D DMR_IIO_FREERUNNING_TYPE_MAX,
+	.freerunning		=3D dmr_iio_freerunning,
+	.ops			=3D &dmr_uncore_freerunning_ops,
+	.event_descs		=3D dmr_uncore_iio_freerunning_events,
+	.format_group		=3D &skx_uncore_iio_freerunning_format_group,
+};
+
+#define UNCORE_DMR_MMIO_EXTRA_UNCORES		1
+static struct intel_uncore_type *dmr_mmio_uncores[UNCORE_DMR_MMIO_EXTRA_UNCO=
RES] =3D {
+	&dmr_uncore_iio_free_running,
+};
+
 int dmr_uncore_pci_init(void)
 {
 	uncore_pci_uncores =3D uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,
@@ -6937,11 +7040,16 @@ int dmr_uncore_pci_init(void)
 						dmr_uncores);
 	return 0;
 }
+
 void dmr_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
-						 UNCORE_DMR_NUM_UNCORE_TYPES,
-						 dmr_uncores);
-}
+	uncore_mmio_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MMIO,
+						UNCORE_DMR_MMIO_EXTRA_UNCORES,
+						dmr_mmio_uncores,
+						UNCORE_DMR_NUM_UNCORE_TYPES,
+						dmr_uncores);
=20
+	dmr_uncore_iio_free_running.num_boxes =3D
+		uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_DMR_ITC);
+}
 /* end of DMR uncore support */

