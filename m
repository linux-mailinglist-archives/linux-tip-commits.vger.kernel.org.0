Return-Path: <linux-tip-commits+bounces-8022-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0504D28D04
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69FC8301FD49
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3A33032D;
	Thu, 15 Jan 2026 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z1hh977l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f3RR0Fxs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0C329C6F;
	Thu, 15 Jan 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513454; cv=none; b=IYr9L7l0JqJn+zsZIdn/OWYjwQBkJoXLSqHiV+Eyqo1+irrnECooX9aKDQzuPYmJsRRRF2xHlDw8muCbllkVsMrayyzf1MtHiCy4dnA6Uhb7P5ubIPgNnIL2zYvqPR2YwL4dVcaoQpjJ2XfDmIj+sUKUAE5qORlITmsUiwcHFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513454; c=relaxed/simple;
	bh=mNW8yqk2xoXaMtQbjfXm6kPMh8V2BNVYdaf0oec55zU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DCrXdbVJvlrQ7WoW1O42Kj3K2rUP2FhGD5f9SekG/MYII3n8XwdGYNTycBuGeRZbecKhJSc8R2KZOG77mOL56XKmZZzAS49nU0Mh8lW++vnXvDjScOJxctrTGiIL8YVkogQeMAyAkTG/UEJB1IpzSzl6qswTB1I/sT6qhX/duBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z1hh977l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f3RR0Fxs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTv/NvM5Fuph+erO9dnvMqa+0/+n4ubcMZORNeWFfQE=;
	b=Z1hh977lAcr/Zra8W79ZLy0mw6kq8lZFmDsrEdBgQ4oZRv0Fe0roRRDVUychKaJ+9+A3Ve
	RZrIL85eJYI7wvO+0JWh971l+aJmlGXi+Wbyod5HBZ+rcuScmPWNjn42AzTzQl2pqdznFH
	/WGGE3OB7PKEYpQxrHlUQ3nlp70mp6YJu5b7Zd3/T2SwNf0l/We9B2MOlF5tLW07GtSQ0t
	deT6U6jbjuXXkO96OR4vFUQZsZ0tE9LE/exsy9Ak2lSP/TK6qAbKvj7gVeP883A96iCSno
	Qu1UbbwminQ+gR9vDdxyHaiFC+90PDnNtQnkpl0+PWuUqJWc/cfcs4sJnamEzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTv/NvM5Fuph+erO9dnvMqa+0/+n4ubcMZORNeWFfQE=;
	b=f3RR0FxsqHHF4tMLARul6l0hFfDY/9ts4tMXVMFveAnyvuKnFWiPoGa4p9e9FiD0A39NaS
	xbrXmdyviwPt25Cw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support the 4 new OMR MSRs
 introduced in DMR and NVL
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114011750.350569-2-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851344823.510.2398506994627726203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4e955c08d6dc76fb60cda9af955ddcebedaa7f69
Gitweb:        https://git.kernel.org/tip/4e955c08d6dc76fb60cda9af955ddcebeda=
a7f69
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 14 Jan 2026 09:17:44 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:26 +01:00

perf/x86/intel: Support the 4 new OMR MSRs introduced in DMR and NVL

Diamond Rapids (DMR) and Nova Lake (NVL) introduce an enhanced
Off-Module Response (OMR) facility, replacing the Off-Core Response (OCR)
Performance Monitoring of previous processors.

Legacy microarchitectures used the OCR facility to evaluate off-core and
multi-core off-module transactions. The newly named OMR facility improves
OCR capabilities for scalable coverage of new memory systems in
multi-core module systems.

Similar to OCR, 4 additional off-module configuration MSRs
(OFFMODULE_RSP_0 to OFFMODULE_RSP_3) are introduced to specify attributes
of off-module transactions. When multiple identical OMR events are
created, they need to occupy the same OFFMODULE_RSP_x MSR. To ensure
these multiple identical OMR events can work simultaneously, the
intel_alt_er() and intel_fixup_er() helpers are enhanced to rotate these
OMR events across different OFFMODULE_RSP_* MSRs, similar to previous OCR
events.

For more details about OMR, please refer to section 16.1 "OFF-MODULE
 RESPONSE (OMR) FACILITY" in ISE documentation.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114011750.350569-2-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c     | 59 ++++++++++++++++++++++---------
 arch/x86/events/perf_event.h     |  5 +++-
 arch/x86/include/asm/msr-index.h |  5 +++-
 3 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1840ca1..3578c66 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3532,17 +3532,32 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
 	struct extra_reg *extra_regs =3D hybrid(cpuc->pmu, extra_regs);
 	int alt_idx =3D idx;
=20
-	if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
-		return idx;
-
-	if (idx =3D=3D EXTRA_REG_RSP_0)
-		alt_idx =3D EXTRA_REG_RSP_1;
+	switch (idx) {
+	case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:
+		if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
+			return idx;
+		if (++alt_idx > EXTRA_REG_RSP_1)
+			alt_idx =3D EXTRA_REG_RSP_0;
+		if (config & ~extra_regs[alt_idx].valid_mask)
+			return idx;
+		break;
=20
-	if (idx =3D=3D EXTRA_REG_RSP_1)
-		alt_idx =3D EXTRA_REG_RSP_0;
+	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
+		if (!(x86_pmu.flags & PMU_FL_HAS_OMR))
+			return idx;
+		if (++alt_idx > EXTRA_REG_OMR_3)
+			alt_idx =3D EXTRA_REG_OMR_0;
+		/*
+		 * Subtracting EXTRA_REG_OMR_0 ensures to get correct
+		 * OMR extra_reg entries which start from 0.
+		 */
+		if (config & ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
+			return idx;
+		break;
=20
-	if (config & ~extra_regs[alt_idx].valid_mask)
-		return idx;
+	default:
+		break;
+	}
=20
 	return alt_idx;
 }
@@ -3550,16 +3565,26 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
 static void intel_fixup_er(struct perf_event *event, int idx)
 {
 	struct extra_reg *extra_regs =3D hybrid(event->pmu, extra_regs);
-	event->hw.extra_reg.idx =3D idx;
+	int er_idx;
=20
-	if (idx =3D=3D EXTRA_REG_RSP_0) {
-		event->hw.config &=3D ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |=3D extra_regs[EXTRA_REG_RSP_0].event;
-		event->hw.extra_reg.reg =3D MSR_OFFCORE_RSP_0;
-	} else if (idx =3D=3D EXTRA_REG_RSP_1) {
+	event->hw.extra_reg.idx =3D idx;
+	switch (idx) {
+	case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:
+		er_idx =3D idx - EXTRA_REG_RSP_0;
 		event->hw.config &=3D ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |=3D extra_regs[EXTRA_REG_RSP_1].event;
-		event->hw.extra_reg.reg =3D MSR_OFFCORE_RSP_1;
+		event->hw.config |=3D extra_regs[er_idx].event;
+		event->hw.extra_reg.reg =3D MSR_OFFCORE_RSP_0 + er_idx;
+		break;
+
+	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
+		er_idx =3D idx - EXTRA_REG_OMR_0;
+		event->hw.config &=3D ~ARCH_PERFMON_EVENTSEL_UMASK;
+		event->hw.config |=3D 1ULL << (8 + er_idx);
+		event->hw.extra_reg.reg =3D MSR_OMR_0 + er_idx;
+		break;
+
+	default:
+		pr_warn("The extra reg idx %d is not supported.\n", idx);
 	}
 }
=20
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3161ec0..586e3fd 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -45,6 +45,10 @@ enum extra_reg_type {
 	EXTRA_REG_FE		=3D 4,  /* fe_* */
 	EXTRA_REG_SNOOP_0	=3D 5,  /* snoop response 0 */
 	EXTRA_REG_SNOOP_1	=3D 6,  /* snoop response 1 */
+	EXTRA_REG_OMR_0		=3D 7,  /* OMR 0 */
+	EXTRA_REG_OMR_1		=3D 8,  /* OMR 1 */
+	EXTRA_REG_OMR_2		=3D 9,  /* OMR 2 */
+	EXTRA_REG_OMR_3		=3D 10,  /* OMR 3 */
=20
 	EXTRA_REG_MAX		      /* number of entries needed */
 };
@@ -1099,6 +1103,7 @@ do {									\
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
 #define PMU_FL_DYN_CONSTRAINT	0x800 /* Needs dynamic constraint */
+#define PMU_FL_HAS_OMR		0x1000 /* has 4 equivalent OMR regs */
=20
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 3d0a095..6d1b69e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -263,6 +263,11 @@
 #define MSR_SNOOP_RSP_0			0x00001328
 #define MSR_SNOOP_RSP_1			0x00001329
=20
+#define MSR_OMR_0			0x000003e0
+#define MSR_OMR_1			0x000003e1
+#define MSR_OMR_2			0x000003e2
+#define MSR_OMR_3			0x000003e3
+
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
=20

