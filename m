Return-Path: <linux-tip-commits+bounces-2606-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FE9B1683
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9921C20FA3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F961C4A3A;
	Sat, 26 Oct 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YGxonNjO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/UsZwuxK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DA16BE0D;
	Sat, 26 Oct 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935170; cv=none; b=V3X1NWu4xZycIcprWVqN3NYOKrFhaZiB0zy9KeuRNNWzz3fsjK6TzZgS9Cu3fFuqSBKvtLVoaS4ksliqQYicVABi/7ijhpq8xiZBE/PoWJIySNNns4Xp8Crmi+OdtBTSbTq/eMsykiDnhVZTm6SazZ88xrjdtVhcWuPGojaOPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935170; c=relaxed/simple;
	bh=K+K2R7R/9m0xpl+NP8/Zo55dv6lxR8WrnmabOlXwAVI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AGl0xy6e5TE7s8v+WsKQxNZp5cnr4M9e6uVoK/VjApt3HnIA2UKsCF7kQ6lFyTGcteHNB8RMyJm4KKA1ndUKMIFGbvcQUTh8SbXk79oN7j0LoS69/gmKGYaCemrKA/2Hs8MbJhbqhkO33UftwqeET/aByn4i7wQRycdMA2UqCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YGxonNjO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/UsZwuxK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 09:32:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729935166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpJLLChtrYhWGHcvekzpsJay5ShdcD+4SGp6l0JOQYM=;
	b=YGxonNjOVwvjfBGQdMTTSas6bRF31XWSdgZbIB6WPu2x8yTllytbfbzSPjJbTqnCBCBP/K
	nxkH4wiv+w6Sh58nOkYuKQGc/9uOiFtkRvWC3TdMUNCRR1r/lZTKWlSIAXdSr/+axeMyoo
	1rUw58DHPXv7z9aCC0q/jRTyE1wnjA0W8PNE+eOa/PyTzDHwRw3+h+bURK43F+R1l0m9J4
	Cuer7oXqS5lQr0tl4tk6Eot2OiePemDzawEdenIj7q0nucy6ePpH9oyFkhM16Fnr9xdQuo
	plsCus2bfoBNjZCNSbVTAF3i5xwWtUakD87A/meLH1xtypywEwhqoaYNek4smA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729935166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpJLLChtrYhWGHcvekzpsJay5ShdcD+4SGp6l0JOQYM=;
	b=/UsZwuxKfK4ci7XoB3PZLlJU47NHdq1dmofB3GhvkpsiyGtrmHn+2F1eQSiOapymYpBGgG
	JLaJyj+FDRAX1UBw==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/amd: Use heterogeneous core topology for
 identifying boost numerator
Cc: Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025171459.1093-6-mario.limonciello@amd.com>
References: <20241025171459.1093-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172993516548.1442.3012769179305386922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3eef25ab0d89cb1e55699a4d242c5afe17dbbd07
Gitweb:        https://git.kernel.org/tip/3eef25ab0d89cb1e55699a4d242c5afe17dbbd07
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Fri, 25 Oct 2024 12:14:59 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 25 Oct 2024 20:51:17 +02:00

x86/amd: Use heterogeneous core topology for identifying boost numerator

AMD heterogeneous designs include two types of cores:

 * Performance
 * Efficiency

Each core type has different highest performance values configured by the
platform.  Drivers such as amd_pstate need to identify the type of core to
correctly set an appropriate boost numerator to calculate the maximum
frequency.

X86_FEATURE_AMD_HETEROGENEOUS_CORES is used to identify whether the SoC
supports heterogeneous core type by reading CPUID leaf Fn_0x80000026.

On performance cores the scaling factor of 196 is used.  On efficiency cores
the scaling factor is the value reported as the highest perf.  Efficiency
cores have the same preferred core rankings.

Suggested-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241025171459.1093-6-mario.limonciello@amd.com
---
 arch/x86/kernel/acpi/cppc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 9569840..59edf64 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -234,8 +234,10 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
+	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
 	bool prefcore;
 	int ret;
+	u32 tmp;
 
 	ret = amd_detect_prefcore(&prefcore);
 	if (ret)
@@ -261,6 +263,27 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 			break;
 		}
 	}
+
+	/* detect if running on heterogeneous design */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES)) {
+		switch (core_type) {
+		case TOPO_CPU_TYPE_UNKNOWN:
+			pr_warn("Undefined core type found for cpu %d\n", cpu);
+			break;
+		case TOPO_CPU_TYPE_PERFORMANCE:
+			/* use the max scale for performance cores */
+			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
+			return 0;
+		case TOPO_CPU_TYPE_EFFICIENCY:
+			/* use the highest perf value for efficiency cores */
+			ret = amd_get_highest_perf(cpu, &tmp);
+			if (ret)
+				return ret;
+			*numerator = tmp;
+			return 0;
+		}
+	}
+
 	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
 
 	return 0;

