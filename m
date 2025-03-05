Return-Path: <linux-tip-commits+bounces-4007-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6CA4FD9D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 12:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1BE3A604B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12B61F4172;
	Wed,  5 Mar 2025 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xzfcZ1wB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lqyic2pG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D371230BD9;
	Wed,  5 Mar 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174198; cv=none; b=fBBsYBip9PeR3kz6oeIXYUl65cwY5bWfr7Ek3iBVrEe/huPL9i/O/cQA5JciGPp/16F0UoHyJTxjbv7t5epEfXkarj7H6LWuywaDJjHyD68GZSjjVxI9fLD1T6btCzu2cBUez7AqPefknAuf8+6kNI/5M6qLEYSPUyUy+fc/q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174198; c=relaxed/simple;
	bh=yxyEV+rxv4aAei7Y67AAaG1cSrJIbyWbGQ9QClSmoRo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ivtdvlb0jtRZY8TC4bTmiDyUrAn+l0Pp6QX0shnm8sOFG8kR4pWEACIyXuSF+bg+NY5iYf6CTSjFd6+wEsNX6q4H19XAY6RkRsP2SUTHakryMIXuD6+TgOO6E6xOyUSqgzieKGrDvIhQw6Cp21KqFsg7C+HGCJrpBiRCqGI4Q6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xzfcZ1wB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lqyic2pG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 11:29:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741174194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntubxHJVsH7XJ/HAJf1fULkz5dfevC//cSeAVJUIwKA=;
	b=xzfcZ1wBj3A9zfLuVrQMEMagep7G32MxxvsffEc1fNz0tjgdar3CCnDTB6mUjjEtTXFJkB
	bYZR7dHJwpSzENhl8DdkwJeZeGm0wVIsF/WeFpiruNtgicXHVrlx24bwkAkCPtzDTHeibW
	ya0QbHeCMWiSKLT8zIh7Tw5Cc089abZd5YIhLEgWxWNiE6BugPlNY0r5TUNi6J3Vpu49ef
	xxKSAKZiex7YhhXkfM6TbMCrHtgAOFaH0clxqlZUcRc029QkhpuQQR+1rM47I31dLNq1Vt
	aZncR5pmRYO3bkXC8aDVLj0D4sikjFjcIIlS/dbTItSpRsC7cBR6MIuQ5CbnFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741174194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntubxHJVsH7XJ/HAJf1fULkz5dfevC//cSeAVJUIwKA=;
	b=lqyic2pG96mGda+lB3yLlQ4KAj4VqCOEfc0IhZtqiyAsJ51k6myMCzlrFv795VOgWX0AgA
	K4cS+iWUga89waCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Clean up perf_try_init_event()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250205102449.110145835@infradead.org>
References: <20250205102449.110145835@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174117419275.14745.5246949160919511795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da02f54e81db2f7bf6af9d1d0cfc5b41ec6d0dcb
Gitweb:        https://git.kernel.org/tip/da02f54e81db2f7bf6af9d1d0cfc5b41ec6d0dcb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 05 Feb 2025 11:21:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Mar 2025 12:13:59 +01:00

perf/core: Clean up perf_try_init_event()

Make sure that perf_try_init_event() doesn't leave event->pmu nor
event->destroy set on failure.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250205102449.110145835@infradead.org
---
 kernel/events/core.c | 65 +++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b2334d2..f159dba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12109,40 +12109,51 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (ctx)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
-	if (!ret) {
-		if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-		    has_extended_regs(event))
-			ret = -EOPNOTSUPP;
+	if (ret)
+		goto err_pmu;
 
-		if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
-		    event_has_any_exclude_flag(event))
-			ret = -EINVAL;
+	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
+	    has_extended_regs(event)) {
+		ret = -EOPNOTSUPP;
+		goto err_destroy;
+	}
 
-		if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
-			const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
-			struct cpumask *pmu_cpumask = perf_scope_cpumask(pmu->scope);
-			int cpu;
-
-			if (pmu_cpumask && cpumask) {
-				cpu = cpumask_any_and(pmu_cpumask, cpumask);
-				if (cpu >= nr_cpu_ids)
-					ret = -ENODEV;
-				else
-					event->event_caps |= PERF_EV_CAP_READ_SCOPE;
-			} else {
-				ret = -ENODEV;
-			}
-		}
+	if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
+	    event_has_any_exclude_flag(event)) {
+		ret = -EINVAL;
+		goto err_destroy;
+	}
 
-		if (ret && event->destroy)
-			event->destroy(event);
+	if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
+		const struct cpumask *cpumask;
+		struct cpumask *pmu_cpumask;
+		int cpu;
+
+		cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
+		pmu_cpumask = perf_scope_cpumask(pmu->scope);
+
+		ret = -ENODEV;
+		if (!pmu_cpumask || !cpumask)
+			goto err_destroy;
+
+		cpu = cpumask_any_and(pmu_cpumask, cpumask);
+		if (cpu >= nr_cpu_ids)
+			goto err_destroy;
+
+		event->event_caps |= PERF_EV_CAP_READ_SCOPE;
 	}
 
-	if (ret) {
-		event->pmu = NULL;
-		module_put(pmu->module);
+	return 0;
+
+err_destroy:
+	if (event->destroy) {
+		event->destroy(event);
+		event->destroy = NULL;
 	}
 
+err_pmu:
+	event->pmu = NULL;
+	module_put(pmu->module);
 	return ret;
 }
 

