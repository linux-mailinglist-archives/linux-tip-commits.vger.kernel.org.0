Return-Path: <linux-tip-commits+bounces-7874-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E19D110AE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A46A7302076C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14833E36B;
	Mon, 12 Jan 2026 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VqYi6yKq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBCFIyyS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312D33E348;
	Mon, 12 Jan 2026 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204989; cv=none; b=s+YJx9KKVzeoae+uxG8RzWHkUSzMjThSjxgBeWIZEKgwtAdtb7RAIhvQuUQbbKKgrvHXobdjQNZcn73ZQXlozBlW1i2+wh0zYpxajuHERONIXFNwbVYzGo6M6N9YJ0tnpZq/FiJQteGPAwBxMGMZoRacf0F5ft74i/sqwxQ05t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204989; c=relaxed/simple;
	bh=onsV/ITRvN1wc4CQCPQMaJfHOVv2ATva5bLrAsOFbaA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g0WX75Lz8j3l5yUePMqCcyCxnzWJLsDnhztQQ1wAmTiWEf0q11tyR6Sql2z35PlBrhXjltzmrkYVYitIGQq556gxUA3l78JrxgdNojKAKZ9TtkuSiB8jh7brFnDAz902tiNzLPpDCJsHQVZzrxLEuAQIHfBKlrMb3YAE2JcSn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VqYi6yKq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBCFIyyS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WIvtMfMTOvxENadABk5gG+8EL1fbAr5xLF1+sv02jY=;
	b=VqYi6yKquGyJU6uj31tPsZPkqTHvLGzNB9tffOkmVIiw2FOIiBDBjyW5JdQYorYHao9wO0
	uD6FlFYyZBr5voXHLJEN0nIxNlX0SQUvUJh3XxXYobnauZPA2eSqSdij7r9VIE/djpHzCo
	AfeQftca14K/tTzprqBSidgXjfXZFySxj3E5YJtN4cyg1gAa6fAmjQka+VIfv3T4P1UuN7
	sPEenv0KcCrOYi9al3A3W+bikE7YUeEQxUpA3q9SvM5st6fVs0CFCxnaRxbQhStvPn+ByK
	pcIx19pk5Nt7j0h6LeaJTJ/pyVqFw7YKD5kLoxS5v8FCHRas9sbwP42pgVb5og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WIvtMfMTOvxENadABk5gG+8EL1fbAr5xLF1+sv02jY=;
	b=HBCFIyyS/PHFoYszCcJA9IYgI1U281jYO2UryyaGmAclqEoQrILQK6G+uVLazj5Fc795OZ
	HKwgNs38nBKus3CA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add missing PMON units for
 Panther Lake
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-13-zide.chen@intel.com>
References: <20251231224233.113839-13-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820498135.510.5167713613167083080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     46da08a2bb4d07874990579235ff87b41911a412
Gitweb:        https://git.kernel.org/tip/46da08a2bb4d07874990579235ff87b4191=
1a412
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:29 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:26 +01:00

perf/x86/intel/uncore: Add missing PMON units for Panther Lake

Besides CBOX, Panther Lake includes several legacy uncore PMON units
not enumerated via discovery tables, including cNCU, SANTA, and
ia_core_bridge.

The cNCU PMON is similar to Meteor Lake but has two boxes with two
counters each. SANTA and IA Core Bridge PMON units follow the legacy
model used on Lunar Lake, Meteor Lake, and others.

Panther Lake implements the Global Control Register; the freeze_all bit
must be cleared before programming counters.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-13-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c     |  1 +-
 arch/x86/events/intel/uncore_snb.c | 45 +++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 19ff8db..704591a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1814,6 +1814,7 @@ static const struct uncore_plat_init ptl_uncore_init __=
initconst =3D {
 	.cpu_init =3D ptl_uncore_cpu_init,
 	.mmio_init =3D ptl_uncore_mmio_init,
 	.domain[0].discovery_base =3D UNCORE_DISCOVERY_MSR,
+	.domain[0].global_init =3D uncore_mmio_global_init,
 };
=20
 static const struct uncore_plat_init icx_uncore_init __initconst =3D {
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncor=
e_snb.c
index 807e582..c663b00 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -245,6 +245,17 @@
 #define MTL_UNC_HBO_CTR				0x2048
 #define MTL_UNC_HBO_CTRL			0x2042
=20
+/* PTL Low Power Bridge register */
+#define PTL_UNC_IA_CORE_BRIDGE_PER_CTR0		0x2028
+#define PTL_UNC_IA_CORE_BRIDGE_PERFEVTSEL0	0x2022
+
+/* PTL Santa register */
+#define PTL_UNC_SANTA_CTR0			0x2418
+#define PTL_UNC_SANTA_CTRL0			0x2412
+
+/* PTL cNCU register */
+#define PTL_UNC_CNCU_MSR_OFFSET			0x140
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(chmask, chmask, "config:8-11");
@@ -1921,8 +1932,36 @@ void ptl_uncore_mmio_init(void)
 						 ptl_uncores);
 }
=20
+static struct intel_uncore_type ptl_uncore_ia_core_bridge =3D {
+	.name		=3D "ia_core_bridge",
+	.num_counters   =3D 2,
+	.num_boxes	=3D 1,
+	.perf_ctr_bits	=3D 48,
+	.perf_ctr	=3D PTL_UNC_IA_CORE_BRIDGE_PER_CTR0,
+	.event_ctl	=3D PTL_UNC_IA_CORE_BRIDGE_PERFEVTSEL0,
+	.event_mask	=3D ADL_UNC_RAW_EVENT_MASK,
+	.ops		=3D &icl_uncore_msr_ops,
+	.format_group	=3D &adl_uncore_format_group,
+};
+
+static struct intel_uncore_type ptl_uncore_santa =3D {
+	.name		=3D "santa",
+	.num_counters   =3D 2,
+	.num_boxes	=3D 2,
+	.perf_ctr_bits	=3D 48,
+	.perf_ctr	=3D PTL_UNC_SANTA_CTR0,
+	.event_ctl	=3D PTL_UNC_SANTA_CTRL0,
+	.event_mask	=3D ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	=3D SNB_UNC_CBO_MSR_OFFSET,
+	.ops		=3D &icl_uncore_msr_ops,
+	.format_group	=3D &adl_uncore_format_group,
+};
+
 static struct intel_uncore_type *ptl_msr_uncores[] =3D {
 	&mtl_uncore_cbox,
+	&ptl_uncore_ia_core_bridge,
+	&ptl_uncore_santa,
+	&mtl_uncore_cncu,
 	NULL
 };
=20
@@ -1930,6 +1969,12 @@ void ptl_uncore_cpu_init(void)
 {
 	mtl_uncore_cbox.num_boxes =3D 6;
 	mtl_uncore_cbox.ops =3D &lnl_uncore_msr_ops;
+
+	mtl_uncore_cncu.num_counters =3D 2;
+	mtl_uncore_cncu.num_boxes =3D 2;
+	mtl_uncore_cncu.msr_offset =3D PTL_UNC_CNCU_MSR_OFFSET;
+	mtl_uncore_cncu.single_fixed =3D 0;
+
 	uncore_msr_uncores =3D ptl_msr_uncores;
 }
=20

