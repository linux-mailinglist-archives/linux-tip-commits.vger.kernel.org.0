Return-Path: <linux-tip-commits+bounces-4400-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D482EA69A88
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 22:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C47189AC3E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E621C165;
	Wed, 19 Mar 2025 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yEMTVA79";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vS+Be6Vz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56321B9CD;
	Wed, 19 Mar 2025 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418051; cv=none; b=Cs4Yk3BXEIhjDodBBBHvZ6jtw1EsYJjnoOEaMkg2yARob3hGgt8cXbD/KXZndafMxHl/Czw7xo5oEfENApDo9nUeJnHDTxJGQy3LBk/YCEnJy1iTy05QQtmbZq6QbgqBpzJJaCGeUJWci4FYxcNAbSpkq+uWqipQEvD4/v4jthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418051; c=relaxed/simple;
	bh=7HHht1qF+abl/jTNFy+wFnjwh4/y1WYxswEJG8QFgjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WyQiDqOIHCNGSY48t+A4g47JEXlzpczVCGpxIiQ9TgzGaFBZF4mM0FmTpRukoR4VBliRfh4L//jVsU+3r3wIoe4jknGPiHGmsqccIMBRhyBOCfXpSPyEJo3yfiF/lwYz4y5js+tGzZDHNLiVQH+710vPkmX1SrrYv7p+JDTQ3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yEMTVA79; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vS+Be6Vz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 21:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742418047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H2Sw4MbfGAYihCDgvhRQ1aYU2wOPauRS+r6FwBLGcw=;
	b=yEMTVA79XE9upyMYaeCrMzi8UPm2HcG9vpLcsK2YMcPQlhNX1IqpF/TiubKgTwSV9716FE
	tBy53MONeurOC1KalnvWwjK99QhxEuQOEEHv0qBdCWmu99xfDsIv3yKvof2FngIsHodU1u
	V8ciSlfULZtE85csuSX4tPnfj3Uqpr31ZhwiPQNaUk2SfDS3VfOWPSBQCGhy+UdHybQ+s5
	Nlphj9SAtp73o2WOgo2jo5yDrG/x4tSCcb3cXr4Px4y7QJm6RRy2Nv6oEJfylRvyvFEnjj
	DdC6OFa1qIVqCJr3TFtKSNjOck+dRehvn/zc5zL6USbQ510KtUoKdgFSrQxfnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742418047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H2Sw4MbfGAYihCDgvhRQ1aYU2wOPauRS+r6FwBLGcw=;
	b=vS+Be6VzfSqZ15V2UzLNkwQLiOnYDZ99xvIQvhKxBr9B1Rlo/sxLLaWPR1eXakypCxiyKF
	nkw189GCWoUIbgBA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] perf/x86/intel, x86/cpu: Simplify Intel PMU initialization
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250318223828.2945651-2-sohil.mehta@intel.com>
References: <20250318223828.2945651-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174241804698.14745.16403097979769841304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     8b70c7436f51ac0f4702b466e1d9db938944e641
Gitweb:        https://git.kernel.org/tip/8b70c7436f51ac0f4702b466e1d9db938944e641
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Mar 2025 22:38:27 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 21:34:09 +01:00

perf/x86/intel, x86/cpu: Simplify Intel PMU initialization

Architectural Perfmon was introduced on the Family 6 "Core" processors
starting with Yonah. Processors before Yonah need their own customized
PMU initialization.

p6_pmu_init() is expected to provide that initialization for early
Family 6 processors. But, currently, it could get called for any Family
6 processor if the architectural perfmon feature is disabled on that
processor. To simplify, restrict the P6 PMU initialization to early
Family 6 processors that do not have architectural perfmon support and
truly need the special handling.

As a result, the "unsupported" console print becomes practically
unreachable because all the released P6 processors are covered by the
switch cases. Move the console print to a common location where it can
cover all modern processors (including Family >15) that may not have
architectural perfmon support enumerated.

Also, use this opportunity to get rid of the unnecessary switch cases in
P6 initialization. Only the Pentium Pro processor needs a quirk, and the
rest of the processors do not need any special handling. The gaps in the
case numbers are only due to no processor with those model numbers being
released.

Use decimal numbers to represent Intel Family numbers. Also, convert one
of the last few Intel x86_model comparisons to a VFM-based one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250318223828.2945651-2-sohil.mehta@intel.com
---
 arch/x86/events/intel/core.c | 14 ++++++++++----
 arch/x86/events/intel/p6.c   | 26 +++-----------------------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40a62bf..49a1155 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6541,15 +6541,21 @@ __init int intel_pmu_init(void)
 	char *name;
 	struct x86_hybrid_pmu *pmu;
 
+	/* Architectural Perfmon was introduced starting with Core "Yonah" */
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
 		switch (boot_cpu_data.x86) {
-		case 0x6:
-			return p6_pmu_init();
-		case 0xb:
+		case  6:
+			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
+				return p6_pmu_init();
+			break;
+		case 11:
 			return knc_pmu_init();
-		case 0xf:
+		case 15:
 			return p4_pmu_init();
 		}
+
+		pr_cont("unsupported CPU family %d model %d ",
+			boot_cpu_data.x86, boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index a6cffb4..65b45e9 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -2,6 +2,8 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
+
 #include "../perf_event.h"
 
 /*
@@ -248,30 +250,8 @@ __init int p6_pmu_init(void)
 {
 	x86_pmu = p6_pmu;
 
-	switch (boot_cpu_data.x86_model) {
-	case  1: /* Pentium Pro */
+	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO)
 		x86_add_quirk(p6_pmu_rdpmc_quirk);
-		break;
-
-	case  3: /* Pentium II - Klamath */
-	case  5: /* Pentium II - Deschutes */
-	case  6: /* Pentium II - Mendocino */
-		break;
-
-	case  7: /* Pentium III - Katmai */
-	case  8: /* Pentium III - Coppermine */
-	case 10: /* Pentium III Xeon */
-	case 11: /* Pentium III - Tualatin */
-		break;
-
-	case  9: /* Pentium M - Banias */
-	case 13: /* Pentium M - Dothan */
-		break;
-
-	default:
-		pr_cont("unsupported p6 CPU model %d ", boot_cpu_data.x86_model);
-		return -ENODEV;
-	}
 
 	memcpy(hw_cache_event_ids, p6_hw_cache_event_ids,
 		sizeof(hw_cache_event_ids));

