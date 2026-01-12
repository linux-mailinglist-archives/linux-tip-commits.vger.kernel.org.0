Return-Path: <linux-tip-commits+bounces-7879-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21152D110CC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9320230243A9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC453446D8;
	Mon, 12 Jan 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TrRomM7X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UyohEyUa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FA33F360;
	Mon, 12 Jan 2026 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204999; cv=none; b=GBl1flComsRSfO7eHDLVWMRq+T5uzCb98zex6tfGk5trsBaZP7+0DyfRYZ00b3Aw+YJMd/WkRrf4MpSw4N8EEn6kI5C8yEks/VaNhWPSzFGI0CbxJZ+mFc/WkmNj3X1Okc01MU/YzIU/cJcmREA1H2/0se5Mcje8G+QTLYfNRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204999; c=relaxed/simple;
	bh=oco4WJ7kaRK4zvappTeMuKD5V9gGwXANUIZCisVulDQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sF2t9GBm+SoAJW/nT2p5dUGmYljdeB3w2PWfVN0czCJ9rlL9Ubqf+5elNDW7mEoaScnGX58nn2lbytgqvfSA4S9kQRQqPnMVq+G1dWwO20nXU1vt6i2xgQC5qDbhUwbViGdZXrlYAb+MMYWJ/fcSHNpwgRsibX8waGG7YVvysus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TrRomM7X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UyohEyUa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yNnO4Zhnj7wHeMtFZZwCrZAfwX/1dOI/xxUCl8SmFM=;
	b=TrRomM7XdrHJVMZ9vxC2xCUmw/XewnVeXb0E4UlOOTM0OSyJ8hrLtMLk/+FWneUotT+UQb
	XalygLKYUsUzojEZ9dgcliYZIwP6LmPEkyAiXLE98GFH3/87Q0B3lRxGWXlalkJy0sEfTR
	IfcbZocvJXSvBii7XG40e5Iwo63rPSXfcK26gahMAAOmNw8FG0g3MM/8alebOSYVmVBgTp
	7hYbIespeUok6yq8HyjoxCeGydTTyDhwinVN9XbkjIn0L/kY1SbiWMxvRNCgsi8T1wLdrY
	TMiFM8LNqKnKfNmV26Jfp77JxEqdrz4pebY/Bk6a3lwqV+IsAvEdSbhIx8OvIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yNnO4Zhnj7wHeMtFZZwCrZAfwX/1dOI/xxUCl8SmFM=;
	b=UyohEyUaZGCwNtDWoHNEy+i4dOSgzmu+psLuK5XEuaBWiUxEj1Lx33L4Y13r8KuQiRKxXZ
	l716ugMpNzgNC7AQ==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/uncore: Add domain global init callback
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-7-zide.chen@intel.com>
References: <20251231224233.113839-7-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499149.510.12902392646377343141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b575fc0e33574f3a476b68057e340ebe32d7b750
Gitweb:        https://git.kernel.org/tip/b575fc0e33574f3a476b68057e340ebe32d=
7b750
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:23 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:24 +01:00

perf/x86/intel/uncore: Add domain global init callback

In the Intel uncore self-describing mechanism, the Global Control
Register freeze_all bit is SoC-wide and propagates to all uncore PMUs.

On Diamond Rapids, this bit is set at power-on, unlike some prior
platforms.  Add a global_init callback to unfreeze all PMON units.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-7-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c           | 16 ++++++++++++++++
 arch/x86/events/intel/uncore.h           |  2 ++
 arch/x86/events/intel/uncore_discovery.c |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 08e5dd4..25a678b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1697,6 +1697,21 @@ err:
 	return ret;
 }
=20
+static int uncore_mmio_global_init(u64 ctl)
+{
+	void __iomem *io_addr;
+
+	io_addr =3D ioremap(ctl, sizeof(ctl));
+	if (!io_addr)
+		return -ENOMEM;
+
+	/* Clear freeze bit (0) to enable all counters. */
+	writel(0, io_addr);
+
+	iounmap(io_addr);
+	return 0;
+}
+
 static const struct uncore_plat_init nhm_uncore_init __initconst =3D {
 	.cpu_init =3D nhm_uncore_cpu_init,
 };
@@ -1839,6 +1854,7 @@ static const struct uncore_plat_init dmr_uncore_init __=
initconst =3D {
 	.domain[0].units_ignore =3D dmr_uncore_imh_units_ignore,
 	.domain[1].discovery_base =3D CBB_UNCORE_DISCOVERY_MSR,
 	.domain[1].units_ignore =3D dmr_uncore_cbb_units_ignore,
+	.domain[1].global_init =3D uncore_mmio_global_init,
 };
=20
 static const struct uncore_plat_init generic_uncore_init __initconst =3D {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 83d01a9..55e3aeb 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -51,6 +51,8 @@ struct uncore_discovery_domain {
 	/* MSR address or PCI device used as the discovery base */
 	u32	discovery_base;
 	bool	base_is_pci;
+	int	(*global_init)(u64 ctl);
+
 	/* The units in the discovery table should be ignored. */
 	int	*units_ignore;
 };
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel=
/uncore_discovery.c
index aaa0810..b465752 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -286,6 +286,9 @@ static int __parse_discovery_table(struct uncore_discover=
y_domain *domain,
 	if (!io_addr)
 		return -ENOMEM;
=20
+	if (domain->global_init && domain->global_init(global.ctl))
+		return -ENODEV;
+
 	/* Parsing Unit Discovery State */
 	for (i =3D 0; i < global.max_units; i++) {
 		memcpy_fromio(&unit, io_addr + (i + 1) * (global.stride * 8),

