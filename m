Return-Path: <linux-tip-commits+bounces-2676-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1F9B7867
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 11:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6891C23766
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3D19922A;
	Thu, 31 Oct 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RSs86HrS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCiK3Lcx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81771195962;
	Thu, 31 Oct 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369343; cv=none; b=HcRNFHNIrdDM7uvxStP2Y3QY26xnSuOEHMhzWvlTi26LwoBErN0azDaKw1QQT5qxPAiAQj7Nyu3ODcR0j4D11XJzZZrmSMKr/p3EiAT9VLv3Wrp6pO54StPu/Y2GDsiMPIAGJ710xsCfniaXYXiadBlA0DadeYUOsyzLzRgNnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369343; c=relaxed/simple;
	bh=B8di0Oe1DkAfOCd0cHlflPSvcW2qc5C6xDKkzS42yRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QYyasszceepnK54f2G/nP68InH7vQV/liIkHWtCUeKnE9jUgOeP/rtRCGHW2jzgZed3JTx7Nj4dAXwFvEtkgaZnhfY4LTGiFcmCmwLDGIpfkKdXvfyIFUWAis1QfSGpnAocv9BTBNARxV3wH+LZm58urZbsmBAamzGlkd0dxfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RSs86HrS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCiK3Lcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 10:08:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730369339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbVr6W2mZHA1/IGhOvT9sFHEHuLGsy+63ayaHuOQsxQ=;
	b=RSs86HrSoUSsqRepH2Yl8Z1O9zkCRS+uMF0gR/FT7bL4xArtKKyDQMMeWWDCa4CXaVLUbK
	iDSpGPwB+g77DqepifhtTfHeC2LjGF1+oUiVfzQfSa2M78htb80vhb/DLNQP8pm8ou2MNY
	rSDmL3XYL6bJnMJO5/t4JRBCqX+FVyCI4RG8ogDCHZLsLsZ86VUerx4WOHokwBeUw9ZLRV
	BbpUDsMA//uPnc4elRmnWu5h18LK+Bo6edrLZ6/CnE3IoxxXxkNArXWlkRyW1u5mJEGTIs
	XftrgaHYYPWVGVI0X8u73r7bNQuYTqK76WNvJE8mUIORIbiLSIVsVrPxjjRrxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730369339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbVr6W2mZHA1/IGhOvT9sFHEHuLGsy+63ayaHuOQsxQ=;
	b=hCiK3Lcx/bvvfpn9FMIDfo46GMVmfp4QNGiqFhA7KlYJhczYWXGoDHHqU2PGWEytxDQCJ8
	UDVpet7rKdWmI+Cw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/rapl: Move the pmu allocation out of CPU hotplug
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oliver Sang <oliver.sang@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010142604.770192-1-kan.liang@linux.intel.com>
References: <20241010142604.770192-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036933906.3137.13695846549656288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9b99d65c0bb4e37013bc2ec9c32b78c5751ff952
Gitweb:        https://git.kernel.org/tip/9b99d65c0bb4e37013bc2ec9c32b78c5751ff952
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 10 Oct 2024 07:26:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Oct 2024 22:42:18 +01:00

perf/x86/rapl: Move the pmu allocation out of CPU hotplug

There are extra codes in the CPU hotplug function to allocate rapl pmus.
The generic PMU hotplug support is hard to be applied.

As long as the rapl pmus can be allocated upfront for each die/socket,
the code doesn't need to be implemented in the CPU hotplug function.
Move the code to the init_rapl_pmus(), and allocate a PMU for each
possible die/socket.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Oliver Sang <oliver.sang@intel.com>
Link: https://lore.kernel.org/r/20241010142604.770192-1-kan.liang@linux.intel.com
---
 arch/x86/events/rapl.c | 44 +++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a481a93..86cbee1 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -602,19 +602,8 @@ static int rapl_cpu_online(unsigned int cpu)
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
-	if (!pmu) {
-		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
-		if (!pmu)
-			return -ENOMEM;
-
-		raw_spin_lock_init(&pmu->lock);
-		INIT_LIST_HEAD(&pmu->active_list);
-		pmu->pmu = &rapl_pmus->pmu;
-		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
-		rapl_hrtimer_init(pmu);
-
-		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
-	}
+	if (!pmu)
+		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
@@ -707,6 +696,32 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static int __init init_rapl_pmu(void)
+{
+	struct rapl_pmu *pmu;
+	int idx;
+
+	for (idx = 0; idx < rapl_pmus->nr_rapl_pmu; idx++) {
+		pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+		if (!pmu)
+			goto free;
+
+		raw_spin_lock_init(&pmu->lock);
+		INIT_LIST_HEAD(&pmu->active_list);
+		pmu->pmu = &rapl_pmus->pmu;
+		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(pmu);
+
+		rapl_pmus->pmus[idx] = pmu;
+	}
+
+	return 0;
+free:
+	for (; idx > 0; idx--)
+		kfree(rapl_pmus->pmus[idx - 1]);
+	return -ENOMEM;
+}
+
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages();
@@ -730,7 +745,8 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
-	return 0;
+
+	return init_rapl_pmu();
 }
 
 static struct rapl_model model_snb = {

