Return-Path: <linux-tip-commits+bounces-5743-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924EAC9A0E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 May 2025 10:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B466A9E21EA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 May 2025 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C0238145;
	Sat, 31 May 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZEMTPPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaLvCFRC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C7235063;
	Sat, 31 May 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748679916; cv=none; b=VNBaCfmyXV/jte8lpuxvt3xGrzFMPODhV7cUuVU9i95gCg8TTvSoPfzshiw0CLJN/0sofgLFRtq/xuFKu2hOwKQ/ZAqD7aN/CRSF4UXc273MOCRuM9sZsGHt8CtDVoyVMx/8uxoVxwgEeJet5igy9S8rnq4xj5SPyjLjRfnoxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748679916; c=relaxed/simple;
	bh=S281ecTmyndUMmjUYK2jNjX+90LVDd4UGPaTkJIYADk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tf7ouqxEyGrNtwjMX2cUwGWZ1Ic2PwnDAM5syGiTgtyR6JyRg3At63+wm/noitGSH2mMVfuyUYU62HjQ/aKrGwtUMiVKWLNnFrlkqyY4L8jHil4e8xTKV3aAbMG9Q0uhyYPjLVbUR+LkvZzuQrvCYsck9fq2tCXz6FOzo+6aKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZEMTPPi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaLvCFRC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 May 2025 08:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748679912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWdp9jVmfLleahcnLH0hvf9/lXuG1BJJk6Y02LkIsCA=;
	b=iZEMTPPi8IS/JexYkwaO0k/RZOG8FevOPZeswhwlsf4K2jyd7Zo9pS81V9tYfQuNNq6RI8
	oQvLZEB0j3BEEYL/61bs+TFDGdUPd5caHW4DDS1y1WMgkUKrSdqZAQMKDh9CNTBny5xp+S
	q1qyUXThoIwEBhi8BXxl92wwLUjxZl9WOdFx8PNLzxYYuA3/wgZCxoj5krgs42/8N7W/69
	dt/Jq61AvJA619KcFtzn64TACNxPxI/gMuhezpW23ab/+gM3PObmhErAtkGHeSowhmB9zX
	Za5dCAkPD83wkUJKj/omUgXmbGzrkNElzq60gT9mQ70Qk3zgRQjGbsu/EyuGVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748679912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWdp9jVmfLleahcnLH0hvf9/lXuG1BJJk6Y02LkIsCA=;
	b=IaLvCFRC80vDrXDqYcFNCZvHmlxqSx1eQaip0y+FlOqn+JdePFymNplwQQ1meenWI6V6DD
	dMKbeFN5ku2CFiCA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix incorrect MSR index
 calculations in intel_pmu_config_acr()
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250529080236.2552247-2-dapeng1.mi@linux.intel.com>
References: <20250529080236.2552247-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174867991161.406.9289935407362158037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     86aa94cd50b138be0dd872b0779fa3036e641881
Gitweb:        https://git.kernel.org/tip/86aa94cd50b138be0dd872b0779fa3036e641881
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 29 May 2025 08:02:36 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 31 May 2025 10:05:16 +02:00

perf/x86/intel: Fix incorrect MSR index calculations in intel_pmu_config_acr()

The MSR offset calculations in intel_pmu_config_acr() are buggy.

To calculate fixed counter MSR addresses in intel_pmu_config_acr(),
the HW counter index "idx" is subtracted by INTEL_PMC_IDX_FIXED.

This leads to the ACR mask value of fixed counters to be incorrectly
saved to the positions of GP counters in acr_cfg_b[], e.g.

For fixed counter 0, its ACR counter mask should be saved to
acr_cfg_b[32], but it's saved to acr_cfg_b[0] incorrectly.

Fix this issue.

[ mingo: Clarified & improved the changelog. ]

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250529080236.2552247-2-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4662833..741b229 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2900,6 +2900,7 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int msr_b, msr_c;
+	int msr_offset;
 
 	if (!mask && !cpuc->acr_cfg_b[idx])
 		return;
@@ -2907,19 +2908,20 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
 	if (idx < INTEL_PMC_IDX_FIXED) {
 		msr_b = MSR_IA32_PMC_V6_GP0_CFG_B;
 		msr_c = MSR_IA32_PMC_V6_GP0_CFG_C;
+		msr_offset = x86_pmu.addr_offset(idx, false);
 	} else {
 		msr_b = MSR_IA32_PMC_V6_FX0_CFG_B;
 		msr_c = MSR_IA32_PMC_V6_FX0_CFG_C;
-		idx -= INTEL_PMC_IDX_FIXED;
+		msr_offset = x86_pmu.addr_offset(idx - INTEL_PMC_IDX_FIXED, false);
 	}
 
 	if (cpuc->acr_cfg_b[idx] != mask) {
-		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
+		wrmsrl(msr_b + msr_offset, mask);
 		cpuc->acr_cfg_b[idx] = mask;
 	}
 	/* Only need to update the reload value when there is a valid config value. */
 	if (mask && cpuc->acr_cfg_c[idx] != reload) {
-		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
+		wrmsrl(msr_c + msr_offset, reload);
 		cpuc->acr_cfg_c[idx] = reload;
 	}
 }

