Return-Path: <linux-tip-commits+bounces-2903-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BA9DFFE9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B7916042D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973E1FECCF;
	Mon,  2 Dec 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JTXZD1iZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+lFNnRFu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA61FE46B;
	Mon,  2 Dec 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138057; cv=none; b=p4AfHMgpRMa89wqcjjZiXlE8xoaMluN6LApGje5qZUH3OnRt2KdS4Yy8kOwxwZiplEE1jm7IyHWu3PzKez3vX83nzNJc2NW9Feb9oKmOPQ9iGNvv2BSBJgGEHdMebvQud9yZTrmytFV5DL3BVdpt3wJL5j2gEkGP6+T2kG6sYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138057; c=relaxed/simple;
	bh=NYFUxBh260efesd0Pue1rGIRsv2LE1msnlwrF21P2NU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WeFj0b54shOy92Vdi4JchTe1/cCNn/EedFFNxE+K0/KnXvOMn1Be6nfxvJwVPB0uQ6vVlvUZg7ol8dsdAmqcIFcvjLp3U01NN0ApFpBOBsIJ37vYiZcV/LfHO5QTjndyoN1ytvxXKww0i1pK48gTDNSaOZm1o1sI34+L2OrVE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JTXZD1iZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+lFNnRFu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5TE0hDtbckStSxXp/Xy+/dELqhQ7EV/HkNrUfa41kI=;
	b=JTXZD1iZuVrkj5/bqDcmn/vUMnETQnrbH/7UnQzNbM6mNJPxPFOylzKx0Z158DgpTPmDS3
	5YAN0/eb2aorKnBE1DJhiIpGSpOAr0MbVwCz2ajQBeBYfFKMbu8SIIMUnhS4FfhTrixsCf
	oMOavOXAFdkQJYNfX/N3autjybZU02Q8UVjzxLfsNWDYZOadhJ7CPkZXWjJxcuZe7fZ+co
	tAfg/0LIvMdmpT6X2jeUZ0RrurfgGNUd2cPlNfSNOFRVgqi0DqXbxXruUa7hBV8sw/BdVK
	GECAMaQrvb6ltkVZG5FR0yB7HHIrGkjuWHbWH5uozRTxCIu/18yHrXdyneCpYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5TE0hDtbckStSxXp/Xy+/dELqhQ7EV/HkNrUfa41kI=;
	b=+lFNnRFukoV2Rs95gru90/2eoYLlXLGAko06ei3jpKRMeISATesL6jZ73TZpX2JJxUlyOx
	Op2T9mTcu/sGdEBg==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Zhang Rui <rui.zhang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-10-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-10-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805375.412.7960428992846054434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     54d2759778c1ebd66ee42fac93acf0c2cbf4217c
Gitweb:        https://git.kernel.org/tip/54d2759778c1ebd66ee42fac93acf0c2cbf4217c
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:08:05 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:37 +01:00

perf/x86/rapl: Move the cntr_mask to rapl_pmus struct

Prepare for the addition of RAPL core energy counter support.

Move cntr_mask to rapl_pmus struct instead of adding a new global
cntr_mask for the new RAPL power_core PMU. This will also ensure that
the second "core_cntr_mask" is only created if needed (i.e. in case of
AMD CPUs).

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241115060805.447565-10-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index aef2d0e..139c308 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -129,6 +129,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
+	unsigned int		cntr_mask;
 	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
@@ -148,7 +149,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
-static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -364,7 +364,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_pkg_cntr_mask & (1 << bit)))
+	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -592,10 +592,10 @@ static void __init rapl_advertise(void)
 	int i;
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
+		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
 
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
-		if (rapl_pkg_cntr_mask & (1 << i)) {
+		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
 			pr_info("hw unit of domain %s 2^-%d Joules\n",
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
@@ -810,9 +810,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
-					false, (void *) &rapl_model->pkg_events);
-
 	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
@@ -821,6 +818,10 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
+	rapl_pmus_pkg->cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs,
+						  PERF_RAPL_PKG_EVENTS_MAX, false,
+						  (void *) &rapl_model->pkg_events);
+
 	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
 	if (ret)
 		goto out;

