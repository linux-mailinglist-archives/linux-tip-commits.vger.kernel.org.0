Return-Path: <linux-tip-commits+bounces-7875-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8CD110C6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4FD03026A42
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0D341648;
	Mon, 12 Jan 2026 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3uvEhjF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d3447+Nx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDD33C1B3;
	Mon, 12 Jan 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204991; cv=none; b=ZAO9FbK8MeL9jSWm9/b0kn+79c9HHVTQQDMMYTQNbBokTGCsR9ogAsxjFOxL49h53R8p5Jqz/u8O7FCeNVGsDI9JvVv2w3XaOGIOMHFxPol6P7qRGcfDt0Ax4KbTpsLvKirY3k7p35jiLpZPXPkPBbyCpSiVilkfG0LboHgAADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204991; c=relaxed/simple;
	bh=dbGrNIstCfeWjfNxeNL89fmrVTGZqBpEjxXPPLa3QKQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DeArubcxebAF24gnI8wSUgn9dA+9Zzqh4N1typfevdvWLvCooDVVVH1r2LGDIbw/TGUbO2nfZ9CckrDPMVdEa73yrc2hkoRgZ1LY9zBmzeT6PJiUcLoDREFz40DAOjAjJ7Pvs5HvT4Ypi2oioT9UbAb05XCXoMAq4sfuFfPqb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3uvEhjF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d3447+Nx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNgPXYKASAvU70hIk8mT3DYEfsVJAgZ3NJr4xRXargw=;
	b=W3uvEhjFQA0ixeXPo2cdxhm9l7muGt0i5jCWMrMnef80zrSIw4MsY7isdyyne4Egx6U/Ik
	f5ZGTNR4vPTHyXF9eWEEsjsV3g3BAH4yDXexBKmryT8UBElZl3Dr4cYiIuX1kDlf2PDBSA
	X69lZvYlNwbL6WAFloWYsj7iQXLB6KOMmt3qTTFzLEGGSvBuuVDPP1ocYYoyV8FMzBsRzI
	W3iBXuIfGa7Ykct57G1ZiJz9/asWGjppvoEJ3IxiPvds5JtlbAKSgvlifIFxDVF20JBiKF
	HhzbPY2kT7STJA7pE4xo8se0R6ZdUATjomhhv1lgMOjXnZY0H4ErJ/tSTvpImg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNgPXYKASAvU70hIk8mT3DYEfsVJAgZ3NJr4xRXargw=;
	b=d3447+NxXH9eTmViH9/a2+sGl3chgVBHPxbDvk/4zqf5UkuaDthgLxhA2Gk/rQkhLo41TU
	3bcdIMtN6LpszWAg==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Update DMR uncore constraints
 preliminarily
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-11-zide.chen@intel.com>
References: <20251231224233.113839-11-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820498705.510.15294477716362060528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     171b5292a82d04e6692f1b19573d15753f21e7fd
Gitweb:        https://git.kernel.org/tip/171b5292a82d04e6692f1b19573d15753f2=
1e7fd
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:27 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:25 +01:00

perf/x86/intel/uncore: Update DMR uncore constraints preliminarily

Update event constraints base on the latest DMR uncore event list.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-11-zide.chen@intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 27 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index eaeb4e9..7ca0429 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6660,10 +6660,19 @@ static const struct attribute_group dmr_cxlcm_uncore_=
format_group =3D {
 	.attrs =3D dmr_cxlcm_uncore_formats_attr,
 };
=20
+static struct event_constraint dmr_uncore_cxlcm_constraints[] =3D {
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1, 0x24, 0x0f),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x41, 0x41, 0xf0),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x50, 0x5e, 0xf0),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x60, 0x61, 0xf0),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type dmr_uncore_cxlcm =3D {
 	.name			=3D "cxlcm",
 	.event_mask		=3D GENERIC_PMON_RAW_EVENT_MASK,
 	.event_mask_ext		=3D DMR_CXLCM_EVENT_MASK_EXT,
+	.constraints		=3D dmr_uncore_cxlcm_constraints,
 	.format_group		=3D &dmr_cxlcm_uncore_format_group,
 	.attr_update		=3D uncore_alias_groups,
 };
@@ -6675,9 +6684,20 @@ static struct intel_uncore_type dmr_uncore_hamvf =3D {
 	.attr_update		=3D uncore_alias_groups,
 };
=20
+static struct event_constraint dmr_uncore_cbo_constraints[] =3D {
+	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x19, 0x1a, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x21, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x36, 0x1),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type dmr_uncore_cbo =3D {
 	.name			=3D "cbo",
 	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.constraints            =3D dmr_uncore_cbo_constraints,
 	.format_group		=3D &dmr_sca_uncore_format_group,
 	.attr_update		=3D uncore_alias_groups,
 };
@@ -6711,9 +6731,16 @@ static struct intel_uncore_type dmr_uncore_dda =3D {
 	.attr_update		=3D uncore_alias_groups,
 };
=20
+static struct event_constraint dmr_uncore_sbo_constraints[] =3D {
+	UNCORE_EVENT_CONSTRAINT(0x1f, 0x01),
+	UNCORE_EVENT_CONSTRAINT(0x25, 0x01),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type dmr_uncore_sbo =3D {
 	.name			=3D "sbo",
 	.event_mask_ext		=3D DMR_HAMVF_EVENT_MASK_EXT,
+	.constraints		=3D dmr_uncore_sbo_constraints,
 	.format_group		=3D &dmr_sca_uncore_format_group,
 	.attr_update		=3D uncore_alias_groups,
 };

