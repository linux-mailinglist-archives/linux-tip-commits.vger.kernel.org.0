Return-Path: <linux-tip-commits+bounces-3308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE1A259C4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5A3A6681
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834E205506;
	Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcp1BC+f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKNH14iC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCF204F7D;
	Mon,  3 Feb 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586905; cv=none; b=ncM2GYKmb2/iakGL/Svjn3TBU5H5AohzA1nuJqUcbr7HNXml4oDLlxZb0tJufR3PkqecCmQKeCm5AXFMlp1S/yda0UhkXwsRg5LcN4rZkrSjzNCAIxQm38u4HzmbNGUYqHHgci69pD8Hxs/T/3JCsdRQG4xBd1qD3B1qmWVvJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586905; c=relaxed/simple;
	bh=FwYcrA+J42VQVbkiHtd7MgDHtSXtI04nrEZajcb6X7M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iY0Q5U7HZYlxandma5he6ZXn0JMobDjh16eL3dX6LAO+sg5t+rNFMIT0lGXJwg8tR+HyFL8AHfuTMbtSW/wBTvHb26+rSM07JTaAojx3yDub0jxcqFKcn3TIodyjlt09gP2u5F1niyWy8OD3x0LxFLwBF0mnC1dmeU28dUoRxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcp1BC+f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKNH14iC; arc=none smtp.client-ip=193.142.43.55
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
	bh=Nvn3wsHicQDMtm21qGmsoGUaKAz5YvOtoG82cP0Sliw=;
	b=vcp1BC+f5THW1kcM50M5HyAQhSjkF0V9OXPVG3XA5LCpa0Z2h0sL+l1oTECMg4Kg7Va5fC
	b514uUYsBCPATXhpPfhdmYnVWK6IvpI4ngJidBiSZs+FoNd06t5m06GHdtvKdnCS+oh9Dp
	mHlsJGWP54zjqJBb9Ckbf2oKUQ0uqOBb+CeyD7ZQCtyjBo5B+6lFP+Sdh0ckM19EMq3Crz
	x7pA1U5n+diU3Nz8/b7aBr9Eb6RzhmFN2NANAhNyoYN6Yl2AheM5pMGb4CFZj03fDpy5qV
	SE2qmNBpfLfjGXA8Vzeu1rdeBjJVF/jygIAoMJgxonNSlO5eu0BdN25iY+L1hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nvn3wsHicQDMtm21qGmsoGUaKAz5YvOtoG82cP0Sliw=;
	b=NKNH14iC7uFJQ7kcaaOqrcJ4IpRsqt03SaK1Tk7tp8Vfs/oH3iGnwfwJ5vXBy9HTfeER5S
	5tbPl6nZxKKRlGDA==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Add ->check_period() callback
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-8-ravi.bangoria@amd.com>
References: <20250115054438.1021-8-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689845.10177.6464269007223759632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1afbdd970f50f2e0431fae26b25d4e54e561fa7f
Gitweb:        https://git.kernel.org/tip/1afbdd970f50f2e0431fae26b25d4e54e561fa7f
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:36 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:06 +01:00

perf/amd/ibs: Add ->check_period() callback

IBS Fetch and IBS Op PMUs have constraints on sample period. The sample
period is verified at the time of opening an event but not at the ioctl()
interface. Hence, a user can open an event with valid period but change
it later with ioctl(). Add a ->check_period() callback to verify the
period provided at ioctl() is also valid.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-8-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7b54b76..aea893a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -564,6 +564,28 @@ static void perf_ibs_del(struct perf_event *event, int flags)
 
 static void perf_ibs_read(struct perf_event *event) { }
 
+static int perf_ibs_check_period(struct perf_event *event, u64 value)
+{
+	struct perf_ibs *perf_ibs;
+	u64 low_nibble;
+
+	if (event->attr.freq)
+		return 0;
+
+	perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
+	low_nibble = value & 0xFULL;
+
+	/*
+	 * This contradicts with perf_ibs_init() which allows sample period
+	 * with lower nibble bits set but silently masks them off. Whereas
+	 * this returns error.
+	 */
+	if (low_nibble || value < perf_ibs->min_period)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * We need to initialize with empty group if all attributes in the
  * group are dynamic.
@@ -696,6 +718,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
@@ -720,6 +743,7 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_MAX_CNT,

