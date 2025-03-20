Return-Path: <linux-tip-commits+bounces-4413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C661A6AF09
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 21:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF0D4644AC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0571F09AC;
	Thu, 20 Mar 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PzlsD9ka";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6sblkTx9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E922A1CB;
	Thu, 20 Mar 2025 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501761; cv=none; b=t+wLoqOfmtDfUlK8JTjB7pOAV+aJrukbKO+VZH0drsu2sbddYmJi0KKRrluNesGoDYHpYyYJCIpX1BPYQbnz7q0dhx/AXT1xctUndj7p+8HK4rM2xppgToVwnwJNWpClNFUUUTTLkzfQI1wyokqAGfjoN/Lr1AHfo/MYeZy6jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501761; c=relaxed/simple;
	bh=aYFGXfMi2XYKkbxPZlAvLSb99LF5Dfig+IiAoIjUTcA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VCCVgSKk8s5rTXo61vQp+mDCH9mTASMkdaONenwGaR+4hPPS2SUMDyY6dY1RrbnsNgonXUJtb9iPuxwdkPFj5geP2ckhjuX2vEc1GGiBroC+h4xa9KuN7FyhM8Hrq0kx1LfjZPeB0y5zuX0FDLsxnTStB+VPBvIL3wvIOAns1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PzlsD9ka; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6sblkTx9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 20:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742501757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFx/2PXlmDo2ekF/EGr6kEACutZG7vER+SaxgstOcn4=;
	b=PzlsD9kamGlGG9JkyM4g56wa04M+USUzCfoL9kt4Y+aNDHYj+ZhLpb/oPY8Htr1BZPM75g
	x/S+gLTC4Mt9WDrB69QlsL3DrK2p2PRRzDDw+gRIKHQxcUIAekzkLR3hXINitbZ6geJPws
	2btKsQ5GLcAQ+QN8ihVC12OPzvTx8Y2ko1E2ZhvNjXqtU8ae1aJNWu9z1w1DwfbyZMtdKa
	7vbaWy7CrKTtwFTXiMvehZrrege2FY76u3lAGsujonHjB8+s1NCCoM7fuqP6BVut66dWOG
	AH9UB5kh7gP6Gzx1kzc15CoTqGnYXVXte3YIcZtzTY6/+FP6NGVCJ5zLzp2NyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742501757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFx/2PXlmDo2ekF/EGr6kEACutZG7vER+SaxgstOcn4=;
	b=6sblkTx998c6clqy+GS7jEUWuBzwMJDqVgoOl2WQhE8Qq3dzvJgUKsaOBAimsUdydzpTqV
	feHPGhk7wQDk8LCw==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/rapl: Fix error handling in init_rapl_pmus()
Cc: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320100617.4480-1-dhananjay.ugwekar@amd.com>
References: <20250320100617.4480-1-dhananjay.ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174250174933.14745.3144777458054823623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7e512f5ad24458e2c930b5be5d96ddf9e176e05d
Gitweb:        https://git.kernel.org/tip/7e512f5ad24458e2c930b5be5d96ddf9e176e05d
Author:        Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
AuthorDate:    Thu, 20 Mar 2025 10:06:19 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 20 Mar 2025 21:03:55 +01:00

perf/x86/rapl: Fix error handling in init_rapl_pmus()

If init_rapl_pmu() fails while allocating memory for "rapl_pmu" objects,
we miss freeing the "rapl_pmus" object in the error path. Fix that.

Fixes: 9b99d65c0bb4 ("perf/x86/rapl: Move the pmu allocation out of CPU hotplug")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250320100617.4480-1-dhananjay.ugwekar@amd.com
---
 arch/x86/events/rapl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 6941f48..043f0a0 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -730,6 +730,7 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 {
 	int nr_rapl_pmu = topology_max_packages();
 	struct rapl_pmus *rapl_pmus;
+	int ret;
 
 	/*
 	 * rapl_pmu_scope must be either PKG, DIE or CORE
@@ -761,7 +762,11 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
-	return init_rapl_pmu(rapl_pmus);
+	ret = init_rapl_pmu(rapl_pmus);
+	if (ret)
+		kfree(rapl_pmus);
+
+	return ret;
 }
 
 static struct rapl_model model_snb = {

