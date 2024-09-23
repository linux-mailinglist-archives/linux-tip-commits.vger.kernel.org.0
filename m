Return-Path: <linux-tip-commits+bounces-2308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D600E97EE16
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Sep 2024 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEDA1F21BAA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Sep 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CADE80BFF;
	Mon, 23 Sep 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n20yaAFK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plME1QiZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473B81749;
	Mon, 23 Sep 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105159; cv=none; b=YELGxIfTjozDZYqIG/CM1T8QD1Q/sfV4OMGiupaCdmKoY50FTrf52cyMkH0EQWVs51pcypa3puXdKeO8CqhLph8uqgqj/q951qQX5RjCwQsiu4rwP3ApdyNN8FwZoSYgdCBGjzSwDdaejaX1FuMmPUR8ifYmWfVbSt4dlmHQuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105159; c=relaxed/simple;
	bh=q8AixPV1VBPU9oUQeBes1YxkxGl8jN084PhTZDRqX+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QSLCEMj21wxcBNMYBa2PLYhE8XsU7eyDbWbT/FXcaKef6kexljX4brly4KI7JBeU8TGOSBwpkOE14muwpxVq0Rb3MWrfOg0296KXLdsDTgkYWFrW6NeTIXwj0wcm2Q3uByFi5JQ5EiD0xwGCHC2h4VEuVmqsTo3RrzNZYNrx+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n20yaAFK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plME1QiZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Sep 2024 15:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727105155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Eh6lbFIJA/8P4MkVIg5Zt73Hsk9MQwS2ng1dPIYu+s=;
	b=n20yaAFKEjXglhRJ0H3oOsAfD+UzGzdF3I8MURVS5+qeIl4MJ05/Rb6xhrn3BXM0IvWn+9
	XP0n/+fvOn/suuiDUQDXdbTKk1L1cSRs1MHWG0pf6prprKsazno3i4l66H44FaO4vcKdVb
	n7/2fM5Icg/XJKGIgY3tkBFBSbT/hCrxz2A8W5lobFjkk0MrxLN0BjFtB0ZOzddbq+AtKw
	DNRT5aswZcfYHvnXEahnvuISK/vaed4EiTktx5A+ISHVXu8YkT2K1m/w70zBZwvmSgyC1I
	EJMQ59Vz4nZ3yqZtRQg1vqr764dwhCM8glZJ4BmhCgLnVXIx3E1nWu5kgh/rMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727105155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Eh6lbFIJA/8P4MkVIg5Zt73Hsk9MQwS2ng1dPIYu+s=;
	b=plME1QiZ4CQ5wEOQ4n/89ARO9RhJxAcyNPg3S2ysSgNFdLFOcy8CCcdx8H7zGspnA2o1yQ
	PcqkJMrqa0AKVGCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix topology_sibling_cpumask() check
 warning on ARM
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Steven Price <steven.price@arm.com>, Kan Liang <kan.liang@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240912145025.1574448-1-kan.liang@linux.intel.com>
References: <20240912145025.1574448-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172710515461.2215.10614315030535616389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4e340f66f76b36003646165130fd7e3de5219d7f
Gitweb:        https://git.kernel.org/tip/4e340f66f76b36003646165130fd7e3de5219d7f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Sep 2024 07:50:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 19 Sep 2024 11:51:50 +02:00

perf/core: Fix topology_sibling_cpumask() check warning on ARM

The following warning is triggered when building with ARM
multi_v7_defconfig:

  kernel/events/core.c: In function 'perf_event_setup_cpumask':
  kernel/events/core.c:14012:13: warning: the comparison will always evaluate as 'true' for the address of 'thread_sibling' will never be NULL [-Waddress]
  14012 |         if (!topology_sibling_cpumask(cpu)) {

The perf_event_init_cpu() may be invoked at the early boot stage, while
the topology_*_cpumask hasn't been initialized yet. The check is to
specially handle the case, and initialize the perf_online_<domain>_masks
on the boot CPU.

x86 uses a per-CPU cpumask pointer, which could be NULL at the early
boot stage. However, ARM uses a global variable, which will
never be NULL.

To work around the warning, use perf_online_mask as an indicator instead.
Only initialize the perf_online_<domain>_masks when perf_online_mask is empty.

Fix a typo as well.

Fixes: 4ba4f1afb6a9 ("perf: Generic hotplug support for a PMU with a scope")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Steven Price <steven.price@arm.com>
Tested-by: Steven Price <steven.price@arm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240912145025.1574448-1-kan.liang@linux.intel.com
---
 kernel/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f03eb9..c5b4fba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14002,21 +14002,19 @@ static void perf_event_setup_cpumask(unsigned int cpu)
 	struct cpumask *pmu_cpumask;
 	unsigned int scope;
 
-	cpumask_set_cpu(cpu, perf_online_mask);
-
 	/*
 	 * Early boot stage, the cpumask hasn't been set yet.
 	 * The perf_online_<domain>_masks includes the first CPU of each domain.
-	 * Always uncondifionally set the boot CPU for the perf_online_<domain>_masks.
+	 * Always unconditionally set the boot CPU for the perf_online_<domain>_masks.
 	 */
-	if (!topology_sibling_cpumask(cpu)) {
+	if (cpumask_empty(perf_online_mask)) {
 		for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
 			pmu_cpumask = perf_scope_cpumask(scope);
 			if (WARN_ON_ONCE(!pmu_cpumask))
 				continue;
 			cpumask_set_cpu(cpu, pmu_cpumask);
 		}
-		return;
+		goto end;
 	}
 
 	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
@@ -14031,6 +14029,8 @@ static void perf_event_setup_cpumask(unsigned int cpu)
 		    cpumask_any_and(pmu_cpumask, cpumask) >= nr_cpu_ids)
 			cpumask_set_cpu(cpu, pmu_cpumask);
 	}
+end:
+	cpumask_set_cpu(cpu, perf_online_mask);
 }
 
 int perf_event_init_cpu(unsigned int cpu)

