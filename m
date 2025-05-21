Return-Path: <linux-tip-commits+bounces-5699-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909DDABF411
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A6189433F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ED326C3BA;
	Wed, 21 May 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNM6NrTr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HV7bLhdg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9A26B2D0;
	Wed, 21 May 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829765; cv=none; b=FxZArzYA3oRf8zFDrf5ejytIauoWvzJm7zsc5384kSc0BKrT7ePtpV6Bhd0ZRt1vh935fpaMqlVDTl4MNmMg2UKCdxkRh5BrV1urUJxueHR9hBUIkiGfpv9GdmpsR5Kb+HYaL7G5lAonc5+9abVR6zZhNqRMi5BXGqlk1kbWhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829765; c=relaxed/simple;
	bh=pYgdw93XOh8kY2mc4VlljCv/py1HWYdOXXG/aXISWHU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A4rtGmVpOvKyjhrtoeI/PdVCY9Q1g0MZ69VAtQiXjN05WIDBdRWJfVKF0kht8F2GEIrYcpKN854afxldHA5F+wgfsj7YoUNdpXY8fdJ10rVh4/j1g2DV2HBnGbFCo5aO8OEryf/fq/j3aGRq5HTXgo4BhfxI+8NqivwX48yHb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNM6NrTr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HV7bLhdg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh3LWlW596fb/7l82C7cw+1Xmm/tWrAydyInr1g618k=;
	b=XNM6NrTrELyq+bPjWJDTMfiJnfJzwpnWjz9Fd2VZNdUBHwwLIQ2ZAyeY1E721QKtPS5M/N
	X8z205RsK9QTmjCV2d7iLSxIphgCu8CooUdSTHQAgaxtv0+mwmC92Yqb4x4x9ZLe4bdmAT
	JSwuOIoxB7oVj+TMrRVMKIMnL6ZB/TpW4babk/IAMcsHTqSu3uf5cdwa3pVKAP3Lme35ww
	J+45/n35HskBqlxIwMI1w/qnD2GE1Dkw3UuBf4zOeR101t8iyQzoyf/sgXgo41W6Onh2VV
	4e5GysJ8kBaJLIjszk2Sztuh8HrMREG/rO43SKvlPzW+3gGiekp3Q8IyJlOpIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh3LWlW596fb/7l82C7cw+1Xmm/tWrAydyInr1g618k=;
	b=HV7bLhdgdWgwxnx9aAC4RJ7/uo3zHECLJawa/wLtRK5j8EqJK1Hf2RkiWowIpoNf1FSZc2
	sA0od9YalcUBxDCw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/amd: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-5-kan.liang@linux.intel.com>
References: <20250520181644.2673067-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782976165.406.16164721635460148194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d058c7d538e77297fe721d4d2e679ca7d2eff69b
Gitweb:        https://git.kernel.org/tip/d058c7d538e77297fe721d4d2e679ca7d2eff69b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:43 +02:00

perf/x86/amd: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250520181644.2673067-5-kan.liang@linux.intel.com
---
 arch/x86/events/amd/core.c | 3 +--
 arch/x86/events/amd/ibs.c  | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 30d6ceb..5e64283 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1003,8 +1003,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0252b7e..4bbbca0 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1373,9 +1373,7 @@ fail:
 		hwc->sample_period = perf_ibs->min_period;
 
 out:
-	if (throttle) {
-		perf_ibs_stop(event, 0);
-	} else {
+	if (!throttle) {
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;

