Return-Path: <linux-tip-commits+bounces-6340-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED29CB33C85
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029F8177B84
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E1E2DC355;
	Mon, 25 Aug 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2DJiuW0w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C57NA4XB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205C2D8DCE;
	Mon, 25 Aug 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117471; cv=none; b=rDYJA8Ka16U/Hi+iSTwNPloKqCRe8EXY0RABAJiueqv6kjcWBuNTwWLevREIWyFKEojMJoj08mQIkrdMRC9PNWpeJ9P4tVC2AvmgM2BGE5dYAdu0zInruz8EafaEXR2gXukPxRQBr3FgL6SZn8XIhx9TVzqmCAT7wC2YU2sHVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117471; c=relaxed/simple;
	bh=pgEtoA7+dGTeDo+sa/rzHeH6Cu2tHHvRmyMLDPX2fU8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JWxbZu9sanrXoy7wY1zGH9MxpJNqaZbYRKdAbp+UbZlQafYjinHfeHxPHGRsOwviyDwHfRBtAE5luxE8OUSgQXawSBLCyL6MRehLxqeOD5WsCbL36EFYZfu01O4KPdPD0KCVlA0Ev0nCnzFJ3j9UTljfXNVys0/BA3+5XYnLrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2DJiuW0w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C57NA4XB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3r/hA4K+qwyd5r/V7orDZm7TP7cUiFafobACxwWfeNI=;
	b=2DJiuW0wqbggwjezzaU6pfBmW/uD2exjaSgnBgwMxekvvC4vt+4EzHbmcFtU5ydnkklCet
	bTUQxuozk6gjaCAhJ5NY7IkM6DZbsNXBeP8KDPEcfyfc9MmiTtAZQxnVV0Xi52Jzrtf+13
	jWBKpiPzT+69SYStNjjllWmnVKqg6RLEnhUCPaMk6AZ/5bmtrLDVLJh9AR2baeP2fBK/YR
	Zr95jBBF6X1Uj3fEe3kQ1vyVBXQZb00frVldv0U+qH72rtsH8fluCG0LWhEPk64BaymwDs
	OUrmOt+Z5a9BhqrnonZ258bZvh5uK071GYk/p1mVgRFI/2X7O1sJtjb/4kJCtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3r/hA4K+qwyd5r/V7orDZm7TP7cUiFafobACxwWfeNI=;
	b=C57NA4XBGt07qAH7toUuyCza/xztgW4y2c88mdtOjBy9/vv5Lia1MvQd6ZN4ihY0G068jx
	AgQUoaIXTcLgtHCA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Change macro
 GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48)
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Yi Lai <yi1.lai@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250820023032.17128-6-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611746605.1420.3867849160651519320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9b3e119784bc3671fde5043001a5c9a607c7d920
Gitweb:        https://git.kernel.org/tip/9b3e119784bc3671fde5043001a5c9a607c=
7d920
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 20 Aug 2025 10:30:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:27 +02:00

perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48)

Macro GLOBAL_CTRL_EN_PERF_METRICS is defined to 48 instead of
BIT_ULL(48), it's inconsistent with other similar macros. This leads to
this macro is quite easily used wrongly since users thinks it's a
bit-mask just like other similar macros.

Thus change GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48) and eliminate
this potential misuse.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Link: https://lore.kernel.org/r/20250820023032.17128-6-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c      | 8 ++++----
 arch/x86/include/asm/perf_event.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 15da60c..f88a99d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5319,9 +5319,9 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybr=
id_pmu *pmu)
 						0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
=20
 	if (pmu->intel_cap.perf_metrics)
-		pmu->intel_ctrl |=3D 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+		pmu->intel_ctrl |=3D GLOBAL_CTRL_EN_PERF_METRICS;
 	else
-		pmu->intel_ctrl &=3D ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+		pmu->intel_ctrl &=3D ~GLOBAL_CTRL_EN_PERF_METRICS;
=20
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
@@ -5456,7 +5456,7 @@ static void intel_pmu_cpu_starting(int cpu)
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
 		if (!perf_cap.perf_metrics) {
 			x86_pmu.intel_cap.perf_metrics =3D 0;
-			x86_pmu.intel_ctrl &=3D ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+			x86_pmu.intel_ctrl &=3D ~GLOBAL_CTRL_EN_PERF_METRICS;
 		}
 	}
=20
@@ -7790,7 +7790,7 @@ __init int intel_pmu_init(void)
 	}
=20
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
-		x86_pmu.intel_ctrl |=3D 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+		x86_pmu.intel_ctrl |=3D GLOBAL_CTRL_EN_PERF_METRICS;
=20
 	if (x86_pmu.intel_cap.pebs_timing_info)
 		x86_pmu.flags |=3D PMU_FL_RETIRE_LATENCY;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index 70d1d94..f8247ac 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -430,7 +430,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
=20
-#define GLOBAL_CTRL_EN_PERF_METRICS		48
+#define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
  *

