Return-Path: <linux-tip-commits+bounces-5693-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7BABF40E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D77D3A9E79
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072A12686A2;
	Wed, 21 May 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XYAuA3Gx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BM9/T4TC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C77267AEA;
	Wed, 21 May 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829760; cv=none; b=ttL7GqPOwY/wQOD9D/eI5/WO1lWDrs83y2H8RbwnPz2nu0Z2vsa1BiRycL7Vv5cMNOt0optYuKnERmeonj64y3szu/GYIDZmIAngOtfvBg8GkORa26zKi0/YynCV7IHnapWZN4neO8/w4gfaHcU0sBiNTPQozc6+xqIBkmklgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829760; c=relaxed/simple;
	bh=5iuUEiSIwB26VcfPOyzoLjIljHNUHxgrtXHzn432+F8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DWo7BavX0mcNmLURL1ZTRDyr5NSUltaLAsvtdTXc1OpXYeM/sMyw/uZRPVf7SXFYySCYVqyaJTMu0rPc677MN7bkfd1Q4FS+0nVZH/AcMM4sHTNmvak+r6AXgvCI8FfetDMaekxaMTWYiJx+aYeUGzJeiAcBxwpSQ2XuWLe9Cfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XYAuA3Gx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BM9/T4TC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op0GpHXTyn6gYiUDMBDSNkXgtvIRJL9DUtbxxKsU5I0=;
	b=XYAuA3GxP8dG7qs/23M9THOA9VSklcnMkHZI8JmHD2TifRKf0cnFRUKDYrCGeeA8gkSh+k
	AndV6H6Uql65n7lUa6TAq3VojMuldKj3ZrMnBApZfzu2pxblVwDruUi0ugaiuEI7/krSj1
	fvgIDJvXWtClnngPMbpOeC716gf3F6VVj0QeUjejcUxiSrlftwy0nv88IgAdy0SJfzp1BH
	BB98jVXAkWc3Ky4mzVJc6OkTx6/dLqqoy2Xe+ruK/+VpeqQcvAfLkUrzV/O9Ulw6b8jQ9Z
	ntsIYgAGVzmXbtcIguW3lKKHvyWF6cN7HLBfQ7ktWtHSgbibAL/5Fr1oMJBYGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op0GpHXTyn6gYiUDMBDSNkXgtvIRJL9DUtbxxKsU5I0=;
	b=BM9/T4TC+prw/yFXfHtRg6ZX4qkznkYPmoD6O/wx4VXn3Eu8vStzmGTXlNaGcbsIF02R8s
	Ujoi7SWU7eV4nhAA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] alpha/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-11-kan.liang@linux.intel.com>
References: <20250520181644.2673067-11-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975666.406.9916694222379924937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8c977a17996eb106e9dfd8d37d2eb510dd2c235e
Gitweb:        https://git.kernel.org/tip/8c977a17996eb106e9dfd8d37d2eb510dd2c235e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:45 +02:00

alpha/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-11-kan.liang@linux.intel.com
---
 arch/alpha/kernel/perf_event.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 1f0eb4f..a3eaab0 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -852,14 +852,9 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	alpha_perf_event_update(event, hwc, idx, alpha_pmu->pmc_max_period[idx]+1);
 	perf_sample_data_init(&data, 0, hwc->last_period);
 
-	if (alpha_perf_event_set_period(event, hwc, idx)) {
-		if (perf_event_overflow(event, &data, regs)) {
-			/* Interrupts coming too quickly; "throttle" the
-			 * counter, i.e., disable it for a little while.
-			 */
-			alpha_pmu_stop(event, 0);
-		}
-	}
+	if (alpha_perf_event_set_period(event, hwc, idx))
+		perf_event_overflow(event, &data, regs);
+
 	wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 
 	return;

