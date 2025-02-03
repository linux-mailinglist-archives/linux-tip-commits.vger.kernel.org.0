Return-Path: <linux-tip-commits+bounces-3313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE5A259C7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9277E3A89EE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494420551E;
	Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dt1ymvkD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c6+tMygm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8A204F8D;
	Mon,  3 Feb 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586905; cv=none; b=uYsMbUV6Cj4D3s9YVleNMvmOZlZLm5OHkNjxry62dpz3LroELvt40IM2OIisU1zf9p/z/6hfKDWnB/CMfngWogNNcHa38LPop1aK75i4kJRz2PNC9gj5U3PKVldB9dzV1NlEdJsAx637Ixj5BW/sngcroW9KBk0emF2jB77QORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586905; c=relaxed/simple;
	bh=ePaxMWeBaW4LO3CAzCyPpCkIxeqT/Othv7tfrPLGm8g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CN4dHhhOZM+6gEP+ujmmOjjwmamaG8rEKtG7d6+Wap9iYCFL5CG8bPTXUjN1KVbBT9sQEc9wDw5ldYFlE3iGsyuRbR+ncFkOvfS1r5UGEMgqaudTq3/+7w8aBigoyLmFXtaz5u5vAF09cgAokArvTyeYOdTUKNmsBDsBoYrS3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dt1ymvkD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c6+tMygm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrbvDsziX955SDu9II2zN/EkZ5JOpohDabhXOOznX0M=;
	b=Dt1ymvkDUL1bNhN0Usr+QitOuDDSAnv69muMsGU19HNKVVXsU+EyVzqkeKR7W6Uf3lSdMu
	MjyEmU85axN5p0Oka9BuPpL5+konHG0EkXJ5Q3doshZ7kdsdbGv46ddiMjXxwMzlNqnunK
	RIZ4b3Xbvs6A+rh4vljSWOfLNbs2SYFPWcuCo+zqaHBeJNXsBiUUhI1o10w++YWS8aimiz
	+il3AUdO8Oj9xBIkSAtO+NU6cNvz8qJFjMEc8RPM7w+ASurKm9KgSrLoR367Qs2jCTOoF8
	3fz/RL2OZ/TVEfUuYqi5Ty0qrYDcpZup+aLj8CXYiH1+4DtxOHOHUIVaWBMd6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrbvDsziX955SDu9II2zN/EkZ5JOpohDabhXOOznX0M=;
	b=c6+tMygmV7V8FfxPG6A++DVoTirhffSuk2LTY6RwkG5z+ecZxmLDoglp02heTwPh/uMvw7
	109NKmkyv2DZYzAQ==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Fix ->config to sample period
 calculation for OP PMU
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-4-ravi.bangoria@amd.com>
References: <20250115054438.1021-4-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858690014.10177.16955187108600485569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     598bdf4fefff5af4ce6d26d16f7b2a20808fc4cb
Gitweb:        https://git.kernel.org/tip/598bdf4fefff5af4ce6d26d16f7b2a20808fc4cb
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:32 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:05 +01:00

perf/amd/ibs: Fix ->config to sample period calculation for OP PMU

Instead of using standard perf_event_attr->freq=0 and ->sample_period
fields, IBS event in 'sample period mode' can also be opened by setting
period value directly in perf_event_attr->config in a MaxCnt bit-field
format.

IBS OP MaxCnt bits are defined as:

  (high bits) IbsOpCtl[26:20] = IbsOpMaxCnt[26:20]
  (low bits)  IbsOpCtl[15:0]  = IbsOpMaxCnt[19:4]

Perf event sample period can be derived from MaxCnt bits as:

  sample_period = (high bits) | ((low_bits) << 4);

However, current code just masks MaxCnt bits and shifts all of them,
including high bits, which is incorrect. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-4-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index bd8919e..f95542b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -271,7 +271,7 @@ static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
-	u64 max_cnt, config;
+	u64 config;
 	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
@@ -313,10 +313,19 @@ static int perf_ibs_init(struct perf_event *event)
 		if (!hwc->sample_period)
 			hwc->sample_period = 0x10;
 	} else {
-		max_cnt = config & perf_ibs->cnt_mask;
+		u64 period = 0;
+
+		if (perf_ibs == &perf_ibs_op) {
+			period = (config & IBS_OP_MAX_CNT) << 4;
+			if (ibs_caps & IBS_CAPS_OPCNTEXT)
+				period |= config & IBS_OP_MAX_CNT_EXT_MASK;
+		} else {
+			period = (config & IBS_FETCH_MAX_CNT) << 4;
+		}
+
 		config &= ~perf_ibs->cnt_mask;
-		event->attr.sample_period = max_cnt << 4;
-		hwc->sample_period = event->attr.sample_period;
+		event->attr.sample_period = period;
+		hwc->sample_period = period;
 	}
 
 	if (!hwc->sample_period)

