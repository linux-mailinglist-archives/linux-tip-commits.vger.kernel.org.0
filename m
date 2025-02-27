Return-Path: <linux-tip-commits+bounces-3714-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B29A47E51
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 13:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E4B7A2B04
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3822E3F7;
	Thu, 27 Feb 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mU4HpOB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Myq5VKc0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78E22D781;
	Thu, 27 Feb 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660924; cv=none; b=YusdxFZOfrDWjg39O7wLjh9TmqNOUxcs8fEM4uO14EeEvq+4YNooRDUyRCJsdhlE/7SSM2d+dfe7Oq7tARCEb6pIfY0FZIcf/qPvGGggVe1znGWZYft+xe8ukfQ1ucKwm/8ERQc6hvReBGap2TTewwKbBJRUbYN5XJ8rFmgBsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660924; c=relaxed/simple;
	bh=fzgS/Ef5Oefb13cSGEJRVYQKCi7jbHyZM/GganxxozU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NFLyZ7EqpnJmSl+VcmAXT5MHUljwSRQPN+zR7zR4jsUtFiclJEKoemsBgXS4r/2ozHOoVve9SMxiryatNpI8KOKllrA+mM3lwAeQgPeQEDHW5xtQqRgpelVnuRmHc/WI5u5SHaYbFN4NcyC8NPakqU2DvuOJz3aWMAo+xFzzPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mU4HpOB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Myq5VKc0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 12:55:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740660920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBfEKPSqtWcvAtTHFQm6e/Zym9jJ4A1YvfV/AhTaSJg=;
	b=mU4HpOB+neBs9Z4Am/PdfamfhdqrHGTdkHKFPOlmlum4NW6muTOlfcKqtyzN1cIt1H5GJg
	ST6x/YWFcPb3BAffYRVJK+dEYUQ+US5JMHUEdr73an7H3DfVAF3686PAJNYpzI0hsqXgob
	6Wx9EPXkbczz7mPT8JOEA3baK/BFWGLnylPzpPBY2IEG+P9sEqSCPB0XSIvLEruYS0o0Bu
	6tGoviebKlwFoBA7F/QKxCa6qzVvoJyjYQaY4Hh/PIyuZbIo83wHZdWufUKxIfoR+Mu+2q
	u6itzl6BuZlgmIR7i22xu+shSehezd3coftyI5Qo6NtqbV2R8p19Zrw9NYrM2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740660920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBfEKPSqtWcvAtTHFQm6e/Zym9jJ4A1YvfV/AhTaSJg=;
	b=Myq5VKc0+jOoFKdBzxzWAE85oTHC46iPIeML6dqUlSPFd8p8sPcpatatoj/wix/+QbXKiu
	iA25jm+s8/3KgNCg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241211-add-cpu-type-v5-2-2ae010f50370@linux.intel.com>
References: <20241211-add-cpu-type-v5-2-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174066091933.10177.7411552544696106030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b52aaeeadfac54c91005e044b72b62616a5864a9
Gitweb:        https://git.kernel.org/tip/b52aaeeadfac54c91005e044b72b62616a5864a9
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Dec 2024 22:57:30 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 13:34:52 +01:00

cpufreq: intel_pstate: Avoid SMP calls to get cpu-type

Intel pstate driver relies on SMP calls to get the cpu-type of a given CPU.
Remove the SMP calls and instead use the cached value of cpu-type which is
more efficient.

[ mingo: Forward ported it. ]

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241211-add-cpu-type-v5-2-2ae010f50370@linux.intel.com
---
 drivers/cpufreq/intel_pstate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9c4cc01..f06b9bc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2200,28 +2200,20 @@ static int knl_get_turbo_pstate(int cpu)
 	return ret;
 }
 
-static void hybrid_get_type(void *data)
-{
-	u8 *cpu_type = data;
-
-	*cpu_type = get_this_hybrid_cpu_type();
-}
-
 static int hwp_get_cpu_scaling(int cpu)
 {
 	if (hybrid_scaling_factor) {
-		u8 cpu_type = 0;
-
-		smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
+		struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+		u8 cpu_type = c->topo.intel_type;
 
 		/*
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (cpu_type == 0x40)
+		if (cpu_type == INTEL_CPU_TYPE_CORE)
 			return hybrid_scaling_factor;
 
-		if (cpu_type == 0x20)
+		if (cpu_type == INTEL_CPU_TYPE_ATOM)
 			return core_get_scaling();
 	}
 

