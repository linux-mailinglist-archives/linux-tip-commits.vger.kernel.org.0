Return-Path: <linux-tip-commits+bounces-2285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8F973045
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 11:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50851C24308
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065B18C32B;
	Tue, 10 Sep 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6c/TDjb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNP5TUE6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B917BEAE;
	Tue, 10 Sep 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962346; cv=none; b=V8B13Acs1iLOeVYH8vXqFFHE27W/UcgfOtYxegrx6MBBcKgy1ExkMcj1UgqJ6yiLdkjyNQHUDhczJmhWS6rw24WQzHU7+XJN0xheUrfHui+WI0Uvc6W6GvcleaW4z8pJxv2BF2lTRzwoLqB2n4qRtoMr3wS5GBKuAPFZBCFgrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962346; c=relaxed/simple;
	bh=xeJ1eTJ07WTeuckC3GHjcRHlRtFPKhCjuNuJfZW/qWE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lHuFFgjVN+5ucIaXIn6nZvxYqJOG5Y9cQmB//uzJLdDq3Y6ixtJKHbBqWMuiWvPhc0Hpav5GnBAd2fRbGqEkmUEc43f34q+76mlJgHnB5nxUDCGIzILaDtglfwcFmtjyIRtrMNopQ4Ujhukp4/tLsdFRNQcEfk/gJ+EmG5EQEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6c/TDjb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNP5TUE6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 09:59:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725962342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAQ5JvRg9jZpf7TDLrdlriRz1zqLxlecpjFUA2kd4bM=;
	b=u6c/TDjbhmOQx/RNCfSiTqUltlJtDltvXCFf/67fUKpRC1Y9NEJw5CDn0/IMv5CJOeoiPd
	l1LeYpSjfMdSJW0kv/4fIS5WCDJ15TaGlVztzxeTu1jShe+400HuS5XZLG0L/fUEXmaUSq
	nY7dadDZsdFsL0qBT10ohsK/ueupt/tc35HHwm5ojil99SJ1ui94SqTOrLc+V7dWlLmIUc
	sScD4ahRXKd3ZuUTGroLaoyA7f0RpKvnnrGU4/Na7CS0B6Eovv/PolC9ugF1B6Wi+qhht8
	m77oMUzQ3o2iKjgH8q94kxwKxhmGmBQfUsaS+9lbn4XlmrCBeEGh8sM5kDwqjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725962342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAQ5JvRg9jZpf7TDLrdlriRz1zqLxlecpjFUA2kd4bM=;
	b=BNP5TUE6qeWSr8KiAYs+MZRiD1+nls/hnTd0wwSInYK+S7BNhFPMDbd8S3LhWF3gKVvzE6
	zqKAjJkYOImBpEAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/rapl: Move the pmu allocation out of CPU hotplug
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802151643.1691631-7-kan.liang@linux.intel.com>
References: <20240802151643.1691631-7-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596234238.2215.12982461380721483989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     351e6ba39e5c851b00d83716ffb4d19b807ecc3d
Gitweb:        https://git.kernel.org/tip/351e6ba39e5c851b00d83716ffb4d19b807ecc3d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 02 Aug 2024 08:16:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 11:44:14 +02:00

perf/x86/rapl: Move the pmu allocation out of CPU hotplug

The rapl pmu just needs to be allocated once. It doesn't matter to be
allocated at each CPU hotplug, or the global init_rapl_pmus().

Move the pmu allocation to the init_rapl_pmus(). So the generic hotplug
supports can be applied.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240802151643.1691631-7-kan.liang@linux.intel.com
---
 arch/x86/events/rapl.c | 44 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b985ca7..d12f3a6 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -568,19 +568,8 @@ static int rapl_cpu_online(unsigned int cpu)
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
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
-	}
+	if (!pmu)
+		return -ENOMEM;
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
@@ -673,6 +662,32 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static void __init init_rapl_pmu(void)
+{
+	struct rapl_pmu *pmu;
+	int cpu;
+
+	cpus_read_lock();
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		pmu = cpu_to_rapl_pmu(cpu);
+		if (pmu)
+			continue;
+		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
+		if (!pmu)
+			continue;
+		raw_spin_lock_init(&pmu->lock);
+		INIT_LIST_HEAD(&pmu->active_list);
+		pmu->pmu = &rapl_pmus->pmu;
+		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(pmu);
+
+		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+	}
+
+	cpus_read_unlock();
+}
+
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
@@ -693,6 +708,9 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
+	init_rapl_pmu();
+
 	return 0;
 }
 

