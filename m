Return-Path: <linux-tip-commits+bounces-2908-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DF89E0047
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA4B246D1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31B202F72;
	Mon,  2 Dec 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2nh2VQrE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rvWa+NvA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5B1FF7A3;
	Mon,  2 Dec 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138061; cv=none; b=evMGISXtfHFBPiPFXASwdsh+HpOJ0xKjYncbEiXQpcL3x69ySyj/uThvB+mQ/USxhiEor78djq0MAED9GeicjDd/CcEEjJMor8JtUskrmjfKcgXLgfYvsrR5rqcUMK33vfr38BdSRmskq/r3C8NYK9TD3XQzin+NX5eQ46hyt8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138061; c=relaxed/simple;
	bh=LK5HXiPW8Ui+bHksZXNSR4m1nNezliGdFXWHGqoI0Zs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VSxqT2dLk7Jx9SlhVdQDQM06B5oAsh+DeMoMuUNnaqAcst6iKXh4u7t1Xc4/Dx85jght+Yz5En/aiTsOWTyFq4uOgH/lH367+7IqJwMxhQ+EFzfHYat3D0xCLpYYmozQWxOtqcqrXmdg2qRRYV8jtmoS9/QG3bdw23sHyv/IKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2nh2VQrE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rvWa+NvA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EwmR18SzxzeL8qcxUdyXY1D2zlwxZWtpC8Z7Y6U6TM=;
	b=2nh2VQrEWaRzhy6EDm8KHZCOXbdRisek0bEqeKpxw5opG8Aq5huJ4CMF+m2UXJJZ9fOjR2
	Hdcuc5kWI5IzQHlDSUFYCToebaE6Z47tABF8mN7uh5UzzJ+stuhqqQ9Z4xLZ4F2rBReelL
	WsWaMBDykeXzEeBwBMzwuhChuXPtrtVS9FQNK9CfZf57/rzy0vLjkoBqTkt/QPMaRoCpzg
	Nnf43gx3E8v8evWz43+J7dqmUYag0pfSD1+BKV96RacL/TGeQ8oh15/veTTtSci6O+ax2P
	TNgrvTKriMFgnlFvZFDRjJNNgLXtVYxtxXJW7EpnP9gB8jMHrHF7y+FAvku4Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EwmR18SzxzeL8qcxUdyXY1D2zlwxZWtpC8Z7Y6U6TM=;
	b=rvWa+NvAlfPtee3E6fX8zUylTZJhNp+rQJpvh+vHmVAbprVOBOOQRPV7kSPFiSMirO4NsA
	SlRW2Rpghra1vEBQ==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add arguments to the init and cleanup
 functions
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Zhang Rui <rui.zhang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-7-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-7-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805585.412.13173575120952927966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eeca4c6b2529ff41a10519952bf988c0f3605353
Gitweb:        https://git.kernel.org/tip/eeca4c6b2529ff41a10519952bf988c0f3605353
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:08:02 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:36 +01:00

perf/x86/rapl: Add arguments to the init and cleanup functions

Prepare for the addition of RAPL core energy counter support.

Add arguments to the init and cleanup functions, which will help in
initialization and cleaning up of two separate PMUs.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241115060805.447565-7-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 1049686..249bcd3 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -603,7 +603,7 @@ static void __init rapl_advertise(void)
 	}
 }
 
-static void cleanup_rapl_pmus(void)
+static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
 {
 	int i;
 
@@ -621,7 +621,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
-static int __init init_rapl_pmu(void)
+static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
 	int idx;
@@ -647,20 +647,20 @@ free:
 	return -ENOMEM;
 }
 
-static int __init init_rapl_pmus(void)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
 {
 	int nr_rapl_pmu = topology_max_packages();
-	int rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
+	struct rapl_pmus *rapl_pmus;
 
-	if (!rapl_pmu_is_pkg_scope()) {
-		nr_rapl_pmu *= topology_max_dies_per_package();
-		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
-	}
+	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
+		nr_rapl_pmu	*= topology_max_dies_per_package();
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
+	*rapl_pmus_ptr = rapl_pmus;
+
 	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
@@ -675,7 +675,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
-	return init_rapl_pmu();
+	return init_rapl_pmu(rapl_pmus);
 }
 
 static struct rapl_model model_snb = {
@@ -799,8 +799,12 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
+	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
 	int ret;
 
+	if (rapl_pmu_is_pkg_scope())
+		rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
+
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
@@ -816,7 +820,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
+	ret = init_rapl_pmus(&rapl_pmus, rapl_pmu_scope);
 	if (ret)
 		return ret;
 
@@ -829,7 +833,7 @@ static int __init rapl_pmu_init(void)
 
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -837,6 +841,6 @@ module_init(rapl_pmu_init);
 static void __exit intel_rapl_exit(void)
 {
 	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 }
 module_exit(intel_rapl_exit);

