Return-Path: <linux-tip-commits+bounces-3315-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78DA259CD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA26E1882F7F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D30205AD1;
	Mon,  3 Feb 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gAAmxFWz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7TGRoXD6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26C204F7E;
	Mon,  3 Feb 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586906; cv=none; b=eAdxOKQRRg2nXoNDseoskpymqWx3eKwwpua3DmcczUs7qlulEkUWAWDX8F5oGh0mJtwuJkN38VjdzrmDnkL2iU0/g6D3QLleApM4Y5kkP1wACp7jUXdnO994nEBiVbTnKaCCoTVG+CErMMCGuA05Rtqdi8aQzcQuespSIKEM3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586906; c=relaxed/simple;
	bh=KxJPkZd3L7GqR9ZtkNIb8MkR064ebbc81iDrTojRyEA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hZEZzkZGDvjNoQpLe/xp1uI/r0986/u8wk/enM0CdpHwVP7rSr40BM2GwHcFuYGi7GAZCVuPP79berw8VeUjIZpDLti/VfWN5qPvNTU0O5UGo7q2wUdCi55R2XKeX7A08YX/L0jCFPGZW4awhUn9LAaFgfB4hvCpDA0C2aR+YdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gAAmxFWz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7TGRoXD6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wyHbqE4ugZ1q/Da1klYUIdssRYddLhyzijege2LUYY=;
	b=gAAmxFWzusav9rnC/wIssxmBFCIPAbPGsc8gHW4OwYpx+m/Q9TOBvXn5ZW4R9lNCXv/1ID
	fZcX3zu1MaZkxN2UQIWnGPwJKxxGeU8BmhOgqHOq1wEz7EauntjnMp7lBJnc39Z1VrjB9r
	9uhZCug54s8zhjtFNkAs5ds2qLw1ajByI7kqql2FYQG8g9RFkNKRlX8BwosskXAd+JCCf4
	plVUH2FEDq6OpEuQwFV8T1D3C5crQgBf/JVIlIabzMocOwRx9iOLt9h4FX52BooOeJU0TD
	0atA5UIicBB7Ezi17hQopFeAv/+WRgm5IlrPu/U5iws0PZ5lLLYN9lJb7IXcsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wyHbqE4ugZ1q/Da1klYUIdssRYddLhyzijege2LUYY=;
	b=7TGRoXD6CiDAvR5R4b8ZyZUb1dFtH0kGzKLWLai0/DbtpuIsNPm9oNN4znMi54wpLqs+1e
	EVan5aHl+E1dZ7BA==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Add PMU specific minimum period
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-7-ravi.bangoria@amd.com>
References: <20250115054438.1021-7-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689888.10177.3638142510217328018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b2fc7b282bf7c1253b01c8da84e894539a3e709d
Gitweb:        https://git.kernel.org/tip/b2fc7b282bf7c1253b01c8da84e894539a3e709d
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:35 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:05 +01:00

perf/amd/ibs: Add PMU specific minimum period

0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
Current IBS PMU driver uses 0x10 for both the PMUs, which is incorrect.
Fix it by adding PMU specific minimum period values in struct perf_ibs.

Also, bail out opening a 'sample period mode' event if the user requested
sample period is less than PMU supported minimum value. For a 'freq mode'
event, start calibrating sample period from PMU specific minimum period.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-7-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3e7ca1e..7b54b76 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -86,6 +86,7 @@ struct perf_ibs {
 	u64				cnt_mask;
 	u64				enable_mask;
 	u64				valid_mask;
+	u16				min_period;
 	u64				max_period;
 	unsigned long			offset_mask[1];
 	int				offset_max;
@@ -308,10 +309,14 @@ static int perf_ibs_init(struct perf_event *event)
 			/* raw max_cnt may not be set */
 			return -EINVAL;
 
-		/* Silently mask off lower nibble. IBS hw mandates it. */
-		hwc->sample_period &= ~0x0FULL;
-		if (!hwc->sample_period)
-			hwc->sample_period = 0x10;
+		if (event->attr.freq) {
+			hwc->sample_period = perf_ibs->min_period;
+		} else {
+			/* Silently mask off lower nibble. IBS hw mandates it. */
+			hwc->sample_period &= ~0x0FULL;
+			if (hwc->sample_period < perf_ibs->min_period)
+				return -EINVAL;
+		}
 	} else {
 		u64 period = 0;
 
@@ -329,10 +334,10 @@ static int perf_ibs_init(struct perf_event *event)
 		config &= ~perf_ibs->cnt_mask;
 		event->attr.sample_period = period;
 		hwc->sample_period = period;
-	}
 
-	if (!hwc->sample_period)
-		return -EINVAL;
+		if (hwc->sample_period < perf_ibs->min_period)
+			return -EINVAL;
+	}
 
 	/*
 	 * If we modify hwc->sample_period, we also need to update
@@ -353,7 +358,8 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
 	int overflow;
 
 	/* ignore lower 4 bits in min count: */
-	overflow = perf_event_set_period(hwc, 1<<4, perf_ibs->max_period, period);
+	overflow = perf_event_set_period(hwc, perf_ibs->min_period,
+					 perf_ibs->max_period, period);
 	local64_set(&hwc->prev_count, 0);
 
 	return overflow;
@@ -696,6 +702,7 @@ static struct perf_ibs perf_ibs_fetch = {
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
+	.min_period		= 0x10,
 	.max_period		= IBS_FETCH_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
@@ -720,6 +727,7 @@ static struct perf_ibs perf_ibs_op = {
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
+	.min_period		= 0x90,
 	.max_period		= IBS_OP_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,

