Return-Path: <linux-tip-commits+bounces-2907-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051CB9DFFEE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FE016110F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08AE20103C;
	Mon,  2 Dec 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fP0h6/sV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nSgEP2Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2211FF5F1;
	Mon,  2 Dec 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138060; cv=none; b=izsjWle1js2bDUrLzw7Awo20Zjc4IL2YHmICbGUYGCbntXr+vKG0lnbyK5JMvA2d6QrPPiv9e/kjgfvj+wO7xIxI4IpiuOvhlHvWAHjdNe3bXaOYr2o/19MAxukY2slz9Otymn+OCHwgvajpfj/Y2po/rjJzZNuGOJM84OA/3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138060; c=relaxed/simple;
	bh=JM3f5fv8/8kAUPT5MHW6VBaAmL+yFL3Bho4rqJSGECM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HtCBDyUrk1UI60keatJBdH918NCGzdFrIEwLXXrC20c9qNI0dXDQpL4hDIW7JblARo3fe8/q7+ZxyqmwFNRGLQZDPs81Dz7aKqoLo8IYN/gt3QkCNXoMOkeNbeS6mgKlVaucVxQ9TCn1Y3OKdd7uTd6GxYwVuCM5+wXgcKYG4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fP0h6/sV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nSgEP2Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO6t7XzQ9BzVcSg/YB/frKi3jjrn+FTP2chRHzxmoYA=;
	b=fP0h6/sV+CUEGA57dzBeANBe207IHum+sFFie6WjlkT8Yy2rYpOdATn1qOgRo4nImtQzEc
	mnPwnHej1S1UgZkiqO91kUvFQhrINs2WovO4JzBWTSA+GtqFhX5U0tM8FYVmTbaPOn51Kz
	VFZwrnakLXtsnuawfQp+QK703eQQOZRGR5dBF84P3wFLKQiaTzidx2ma0DlwBPXGCMs+71
	/ItkeHpSvb1iHUFzjsh73Rj2tqds9353wo8SS1HeGRMhRkcp0HSMQNvMvLgZl1E3foUf+9
	iYudopkV4HnIn7qoSWpWoMEU7STtBwWnQibHaGn+wDOYTUdKE+jOy/pdxWiZ+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO6t7XzQ9BzVcSg/YB/frKi3jjrn+FTP2chRHzxmoYA=;
	b=0nSgEP2YH2rsppoENylQDY920Uc5x4g6nrB6tLzwGCCCFXpvPcB0nusiMHnwyeDfmnU/J3
	0Sn6OgpKBhYtR2BQ==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Make rapl_model struct global
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-6-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-6-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805654.412.13726606937220934630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cd29d83a6d815bf8472c9aa3cdd1dcb89cc4c419
Gitweb:        https://git.kernel.org/tip/cd29d83a6d815bf8472c9aa3cdd1dcb89cc4c419
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:08:01 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:36 +01:00

perf/x86/rapl: Make rapl_model struct global

Prepare for the addition of RAPL core energy counter support.

As there will always be just one rapl_model variable on a system, make it
global, to make it easier to access it from any function.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241115060805.447565-6-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 9b1ec8a..1049686 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -151,6 +151,7 @@ static struct rapl_pmus *rapl_pmus;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 /*
  * Helper function to get the correct topology id according to the
@@ -542,18 +543,18 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_check_hw_unit(struct rapl_model *rm)
+static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
-	switch (rm->unit_quirk) {
+	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
@@ -798,21 +799,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
 
-	rm = (struct rapl_model *) id->driver_data;
+	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rm->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_msrs;
 
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
+					false, (void *) &rapl_model->events);
 
-	ret = rapl_check_hw_unit(rm);
+	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 

