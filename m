Return-Path: <linux-tip-commits+bounces-7878-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A815D110F3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EB1F3055C30
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02056342CB3;
	Mon, 12 Jan 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWfAcxwH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZlwQ6qA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198932E138;
	Mon, 12 Jan 2026 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204994; cv=none; b=lzq5PGAlBbQXlFNR+NnmnNEbksDuprKFtZ7FFCRCT1mUT0G1wmCPBUIbeaFNlrQCJdFUphI+3SHiBFeNV7e0vZaDuPncSrZMT3twsVb358vYG4lrPmH4Ux+dZUGAjMlMqcBzxuA3S5iH4XSOBJaCO6+717p+DWP1/NTyCZX3Qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204994; c=relaxed/simple;
	bh=0JOu2PLn1dkG94f6/hUkcBUhYcCHwKe9OcS3YfC7asE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TtosE46pFtw+jMxSGAhAvqPA5sX8rK7iyrh6i5guCzQMrKZq+xKoEWbp55o4nquknQG/kS0uMahNwRp5Ie98jgmNR/0DAtviG2GJ51x8EwdEvyPSVOYWmOFEDRxTbrYV0B64fILLDnWezuCemjiJw/V0t15+Zw92YjipWodl8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lWfAcxwH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZlwQ6qA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5k+x5offEVcWx0MBo/Wtkg8u8RKbUh4qj3dUsetvgHk=;
	b=lWfAcxwHneuc3+8n01wZyuj5sh2VjFQyTddJ/ElOVWq5zwn239LZsqBNwb2uJeYucYm18n
	zJru4U2Kwjb/bfxVwrxHwu1NYnPuGc6rBcllfwMAcVtLk43k1oSmn4LrowWPRena7XYMLg
	vH+9xym3oM6mIBraCEbnSSEHmRD+nZ0rPd055JdCtFlgUt89GBGHKZ8cdDOy+UDwm8AdCq
	j8SrpEZwMBduuCU5qDre0MAtxkzHrqoxCnuBk/TLDC4m/SOMmNYGfzDS5uLii5Ts+NsOVu
	lflMPAJoBOP82+/BSDbrNOuJNV5bBtrRjBhdA36P7MaR83M8v5ln7DmlS+qShw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5k+x5offEVcWx0MBo/Wtkg8u8RKbUh4qj3dUsetvgHk=;
	b=rZlwQ6qAqoLxcaxgqBceM1C5SIRDw95Q0VWgP6oXzUcz//GaGGw4B+vwmSHj6owL+xoJW7
	ppcNHWH+tQBWlVCA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add freerunning event
 descriptor helper macro
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-8-zide.chen@intel.com>
References: <20251231224233.113839-8-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499041.510.9654215449017981398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8a4bd1c0d6bb64ab4d9e94d83c40326356421a73
Gitweb:        https://git.kernel.org/tip/8a4bd1c0d6bb64ab4d9e94d83c403263564=
21a73
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:24 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:25 +01:00

perf/x86/intel/uncore: Add freerunning event descriptor helper macro

Freerunning counter events are repetitive: the event code is fixed to
0xff, the unit is always "MiB", and the scale is identical across all
counters on a given PMON unit.

Introduce a new helper macro, INTEL_UNCORE_FR_EVENT_DESC(), to populate
the event, scale, and unit descriptor triplet. This reduces duplicated
lines and improves readability.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-8-zide.chen@intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 95 +++++++--------------------
 1 file changed, 28 insertions(+), 67 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index df17353..cfb4ce3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4068,34 +4068,24 @@ static struct freerunning_counters skx_iio_freerunnin=
g[] =3D {
 	[SKX_IIO_MSR_UTIL]	=3D { 0xb08, 0x1, 0x10, 8, 36 },
 };
=20
+#define INTEL_UNCORE_FR_EVENT_DESC(name, umask, scl)			\
+	INTEL_UNCORE_EVENT_DESC(name,					\
+				"event=3D0xff,umask=3D" __stringify(umask)),\
+	INTEL_UNCORE_EVENT_DESC(name.scale, __stringify(scl)),		\
+	INTEL_UNCORE_EVENT_DESC(name.unit, "MiB")
+
 static struct uncore_event_desc skx_uncore_iio_freerunning_events[] =3D {
 	/* Free-Running IO CLOCKS Counter */
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=3D0xff,umask=3D0x10"),
 	/* Free-Running IIO BANDWIDTH Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=3D0xff,umask=3D0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=3D0xff,umask=3D0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=3D0xff,umask=3D0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=3D0xff,umask=3D0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=3D0xff,umask=3D0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=3D0xff,umask=3D0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=3D0xff,umask=3D0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=3D0xff,umask=3D0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0,  0x20, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1,  0x21, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2,  0x22, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3,  0x23, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x24, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x25, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x26, 3.814697266e-6),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x27, 3.814697266e-6),
 	/* Free-running IIO UTILIZATION Counters */
 	INTEL_UNCORE_EVENT_DESC(util_in_port0,		"event=3D0xff,umask=3D0x30"),
 	INTEL_UNCORE_EVENT_DESC(util_out_port0,		"event=3D0xff,umask=3D0x31"),
@@ -4910,30 +4900,14 @@ static struct uncore_event_desc snr_uncore_iio_freeru=
nning_events[] =3D {
 	/* Free-Running IIO CLOCKS Counter */
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=3D0xff,umask=3D0x10"),
 	/* Free-Running IIO BANDWIDTH IN Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=3D0xff,umask=3D0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=3D0xff,umask=3D0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=3D0xff,umask=3D0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=3D0xff,umask=3D0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=3D0xff,umask=3D0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=3D0xff,umask=3D0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=3D0xff,umask=3D0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=3D0xff,umask=3D0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.0517578125e-5"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, 3.0517578125e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, 3.0517578125e-5),
 	{ /* end: all zeroes */ },
 };
=20
@@ -5266,12 +5240,8 @@ static struct freerunning_counters snr_imc_freerunning=
[] =3D {
 static struct uncore_event_desc snr_uncore_imc_freerunning_events[] =3D {
 	INTEL_UNCORE_EVENT_DESC(dclk,		"event=3D0xff,umask=3D0x10"),
=20
-	INTEL_UNCORE_EVENT_DESC(read,		"event=3D0xff,umask=3D0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(read.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(write,		"event=3D0xff,umask=3D0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(read,  0x20, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(write, 0x21, 6.103515625e-5),
 	{ /* end: all zeroes */ },
 };
=20
@@ -5836,19 +5806,10 @@ static struct freerunning_counters icx_imc_freerunnin=
g[] =3D {
 static struct uncore_event_desc icx_uncore_imc_freerunning_events[] =3D {
 	INTEL_UNCORE_EVENT_DESC(dclk,			"event=3D0xff,umask=3D0x10"),
=20
-	INTEL_UNCORE_EVENT_DESC(read,			"event=3D0xff,umask=3D0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,		"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(read.unit,		"MiB"),
-	INTEL_UNCORE_EVENT_DESC(write,			"event=3D0xff,umask=3D0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,		"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(write.unit,		"MiB"),
-
-	INTEL_UNCORE_EVENT_DESC(ddrt_read,		"event=3D0xff,umask=3D0x30"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_read.unit,		"MiB"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write,		"event=3D0xff,umask=3D0x31"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"6.103515625e-5"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write.unit,	"MiB"),
+	INTEL_UNCORE_FR_EVENT_DESC(read,       0x20, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(write,      0x21, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(ddrt_read,  0x30, 6.103515625e-5),
+	INTEL_UNCORE_FR_EVENT_DESC(ddrt_write, 0x31, 6.103515625e-5),
 	{ /* end: all zeroes */ },
 };
=20

