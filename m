Return-Path: <linux-tip-commits+bounces-7872-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C44D110C3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ACCF3065971
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688AD340A6C;
	Mon, 12 Jan 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gL4pEB5s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ayXMmF3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816333FE1A;
	Mon, 12 Jan 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204984; cv=none; b=hCIX52efGj/QCbQBo6iOCtl6+1C6dV3LASfXOMk66SRql1RHwKqc2AUYbSYaFhu9IFeHyWf3JOVFhRrYt1Mfg1zXTfDi/bGrGVYyFJO+CUwai1sT+MtllC+cHTpNLXypGL485GMu+J5DN7oBYJYO1uEd+vax39JK1NRpcQqNTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204984; c=relaxed/simple;
	bh=O+Dou+vf+0oa9WYVBIxUZa7PhiVB1Y/2WEmKBS626C8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MGK8YYONTscaIcuuqNLAsodvZL+W8mxF4SqTeDpKT5slUi1vKz/YuXti0xNfGj/qIzS/WnyDCebujmI6Er/hx5N4opTv4tp9RH1vU7BoJkT9/23JQeAY3/E/ldG+wz9++Tk2Pru0v+g/3UtZtYzq3SoUAQFh4EvY5zGrcSMFuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gL4pEB5s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ayXMmF3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uivUpRr4+mlb3242nfVgRIqP1vNdqHX7GDjW5eIx488=;
	b=gL4pEB5szRVhxEGiWD2tE9ljA92pULPmF8Cf1L8AYGdI8vogdBFwsw9g/Ky272hx936qWe
	fU0zcw4qDZXXdp9f6ZI7kwIdthj+liiV7FGWI+Ku921lbeD1uyDBbftfP2Ey7tzA8DKaSm
	cACQHxkcsS/rO4+As8bWFQluYg02C5UMO9s4Og20knd9xuTT9OIRSl+I7RuHralgHbvJx7
	WWOwz9hvx3IzOIVZHB00Vb6JfRpzxfMuYnU2wsAx9I+5h+y0lxn6KHNBQpSEsugTLRnYSO
	SV5fyhqnfNd3ZrY3MQe9cXnvxLmKC68NEM8tH4j2jWerYKYHN1Sg0TaL4DLNiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uivUpRr4+mlb3242nfVgRIqP1vNdqHX7GDjW5eIx488=;
	b=3ayXMmF3N1aux4XgNdgfap91UWalzw45SiuJ+MwDA3KVQPdpUfeS4zoZ29+2GO2lxSdF9I
	SrFibTiWnwVbfkDQ==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Nova Lake support
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-14-zide.chen@intel.com>
References: <20251231224233.113839-14-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820498005.510.17111224064295272607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e7d5f2ea0923c5e49ccf94cdaab74a08c865115e
Gitweb:        https://git.kernel.org/tip/e7d5f2ea0923c5e49ccf94cdaab74a08c86=
5115e
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:30 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:26 +01:00

perf/x86/intel/uncore: Add Nova Lake support

Nova Lake uncore PMON largely follows Panther Lake and supports CBOX,
iMC, cNCU, SANTA, sNCU, and HBO units.

As with Panther Lake, CBOX, cNCU, and SANTA are not enumerated via
discovery tables.  Their programming model matches Panther Lake, with
differences limited to MSR addresses and the number of boxes or counters
per box.

The remaining units are enumerated via discovery tables using a new
base MSR (0x711) and otherwise reuse the Panther Lake implementation.
Nova Lake also supports iMC free-running counters.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-14-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c           |  9 +++++-
 arch/x86/events/intel/uncore.h           |  1 +-
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 arch/x86/events/intel/uncore_snb.c       | 40 +++++++++++++++++++++++-
 4 files changed, 52 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 704591a..4684649 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1817,6 +1817,13 @@ static const struct uncore_plat_init ptl_uncore_init _=
_initconst =3D {
 	.domain[0].global_init =3D uncore_mmio_global_init,
 };
=20
+static const struct uncore_plat_init nvl_uncore_init __initconst =3D {
+	.cpu_init =3D nvl_uncore_cpu_init,
+	.mmio_init =3D ptl_uncore_mmio_init,
+	.domain[0].discovery_base =3D PACKAGE_UNCORE_DISCOVERY_MSR,
+	.domain[0].global_init =3D uncore_mmio_global_init,
+};
+
 static const struct uncore_plat_init icx_uncore_init __initconst =3D {
 	.cpu_init =3D icx_uncore_cpu_init,
 	.pci_init =3D icx_uncore_pci_init,
@@ -1916,6 +1923,8 @@ static const struct x86_cpu_id intel_uncore_match[] __i=
nitconst =3D {
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&ptl_uncore_init),
+	X86_MATCH_VFM(INTEL_NOVALAKE,		&nvl_uncore_init),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,		&nvl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 564cb26..c35918c 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -636,6 +636,7 @@ void adl_uncore_cpu_init(void);
 void lnl_uncore_cpu_init(void);
 void mtl_uncore_cpu_init(void);
 void ptl_uncore_cpu_init(void);
+void nvl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel=
/uncore_discovery.h
index 63b8f76..e133034 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -4,6 +4,8 @@
 #define UNCORE_DISCOVERY_MSR			0x201e
 /* Base address of uncore perfmon discovery table for CBB domain */
 #define CBB_UNCORE_DISCOVERY_MSR		0x710
+/* Base address of uncore perfmon discovery table for the package */
+#define PACKAGE_UNCORE_DISCOVERY_MSR		0x711
=20
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncor=
e_snb.c
index c663b00..e8e4474 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -256,6 +256,19 @@
 /* PTL cNCU register */
 #define PTL_UNC_CNCU_MSR_OFFSET			0x140
=20
+/* NVL cNCU register */
+#define NVL_UNC_CNCU_BOX_CTL			0x202e
+#define NVL_UNC_CNCU_FIXED_CTR			0x2028
+#define NVL_UNC_CNCU_FIXED_CTRL			0x2022
+
+/* NVL SANTA register */
+#define NVL_UNC_SANTA_CTR0			0x2048
+#define NVL_UNC_SANTA_CTRL0			0x2042
+
+/* NVL CBOX register */
+#define NVL_UNC_CBOX_PER_CTR0			0x2108
+#define NVL_UNC_CBOX_PERFEVTSEL0		0x2102
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(chmask, chmask, "config:8-11");
@@ -1979,3 +1992,30 @@ void ptl_uncore_cpu_init(void)
 }
=20
 /* end of Panther Lake uncore support */
+
+/* Nova Lake uncore support */
+
+static struct intel_uncore_type *nvl_msr_uncores[] =3D {
+	&mtl_uncore_cbox,
+	&ptl_uncore_santa,
+	&mtl_uncore_cncu,
+	NULL
+};
+
+void nvl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes =3D 12;
+	mtl_uncore_cbox.perf_ctr =3D NVL_UNC_CBOX_PER_CTR0,
+	mtl_uncore_cbox.event_ctl =3D NVL_UNC_CBOX_PERFEVTSEL0,
+
+	ptl_uncore_santa.perf_ctr =3D NVL_UNC_SANTA_CTR0,
+	ptl_uncore_santa.event_ctl =3D NVL_UNC_SANTA_CTRL0,
+
+	mtl_uncore_cncu.box_ctl =3D NVL_UNC_CNCU_BOX_CTL;
+	mtl_uncore_cncu.fixed_ctr =3D NVL_UNC_CNCU_FIXED_CTR;
+	mtl_uncore_cncu.fixed_ctl =3D NVL_UNC_CNCU_FIXED_CTRL;
+
+	uncore_msr_uncores =3D nvl_msr_uncores;
+}
+
+/* end of Nova Lake uncore support */

