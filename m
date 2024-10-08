Return-Path: <linux-tip-commits+bounces-2366-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FC994604
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7792B24C2F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355818C321;
	Tue,  8 Oct 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cadpvkDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8SLKbtsT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8016FF2A;
	Tue,  8 Oct 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385513; cv=none; b=otsusHqxlQIeUg0sdPXFDhc4jGhIlW8j+Q3lm/PspYuWen3KLFun2+Y4tcb9jmU2ilkuBdLtVkf1rVFUFGjwo/yZFfJ78+YVk22J7CjCsS3up3+R9Eq+xucwnKowo9ucOtF3oxlUUDUkpJm4+Yjb8AdKMvp7NAsBAGiUrBS4TLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385513; c=relaxed/simple;
	bh=ZmUUuIY+lUu0Cnw3nXqrX3rD/MQoX3xHCD+2uj0VAjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bRPIWU081z9kPrSDSGscTQDQUz4gVGeSMdnTUN/M5NlGWP2iRrBgvxyI9oqOlFPhENIdM4aV2DjImX3k4HpBnmENQEll/lE0hCY+x2Jix3RT6k8+IG8ZW/+bgbTPfJGK5jYXzYZZl8dX+Nx48E2I8qhMwmPqQdD0B+zacBXNgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cadpvkDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8SLKbtsT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98ltt3FAoq86ddFp/Hhattb2KtiU3rH6jFcEOWu9wnQ=;
	b=cadpvkDUprv/uNMJj5DRCR+74hk+tXi5VUNUBlqpFSP7f5fnqw3OTfrK9zPjsjM/ylrOgd
	pIVxFcAXqpvt3/bkJ4pXrUJQyW3HhAJpEvTcBOf/UyO8gI2zkmQWnnl6l3v4pA90nf8bnE
	3JSqNNCvnjkFUUEh0MmdcOOm1Cazu+OIWrjP4q5AQO8CF927gvpPEDPXbO84kMwUrV6mY3
	6426mwbX4VRtuyZwLWaofV80+Za2o1LzT/6HFlGnCn5vMd2Apbil9XdgltBcCieeN/1N9q
	La65tMaX8ZD9HM5WR5fb+fmwBnj8yDowGmdNvg4OieLqJrOQjfIBuMjXM0hFNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98ltt3FAoq86ddFp/Hhattb2KtiU3rH6jFcEOWu9wnQ=;
	b=8SLKbtsTiLCbc9JvcIvSlQLNPPu+9DFDcvxSa1tEEGPmPDYukZmdjBseNlUyICK3c2FU0u
	Xdq1YpQH3qt0McAg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Warn only on new bits set
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Breno Leitao <leitao@debian.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001141020.2620361-1-leitao@debian.org>
References: <20241001141020.2620361-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838550950.1442.11370441097683144204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     de20037e1b3c2f2ca97b8c12b8c7bca8abd509a7
Gitweb:        https://git.kernel.org/tip/de20037e1b3c2f2ca97b8c12b8c7bca8abd509a7
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 01 Oct 2024 07:10:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:46 +02:00

perf/x86/amd: Warn only on new bits set

Warning at every leaking bits can cause a flood of message, triggering
various stall-warning mechanisms to fire, including CSD locks, which
makes the machine to be unusable.

Track the bits that are being leaked, and only warn when a new bit is
set.

That said, this patch will help with the following issues:

1) It will tell us which bits are being set, so, it is easy to
   communicate it back to vendor, and to do a root-cause analyzes.

2) It avoid the machine to be unusable, because, worst case
   scenario, the user gets less than 60 WARNs (one per unhandled bit).

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20241001141020.2620361-1-leitao@debian.org
---
 arch/x86/events/amd/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a6..b4a1a25 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -943,11 +943,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	static atomic64_t status_warned = ATOMIC64_INIT(0);
+	u64 reserved, status, mask, new_bits, prev_bits;
 	struct perf_sample_data data;
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -1012,7 +1013,12 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	 * the corresponding PMCs are expected to be inactive according to the
 	 * active_mask
 	 */
-	WARN_ON(status > 0);
+	if (status > 0) {
+		prev_bits = atomic64_fetch_or(status, &status_warned);
+		// A new bit was set for the very first time.
+		new_bits = status & ~prev_bits;
+		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
+	}
 
 	/* Clear overflow and freeze bits */
 	amd_pmu_ack_global_status(~status);

