Return-Path: <linux-tip-commits+bounces-5692-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73000ABF3FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ACF1BC000C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C66268690;
	Wed, 21 May 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UL884vGQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9TqyxOAC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEA267AEB;
	Wed, 21 May 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829760; cv=none; b=PilgrDStE61dPiDvS+NuSpXzrOOfeZAl1FF8PQl8qqCkYSll2+XPosB8ZWi/8pXTwQZ4bNW0LY+vQe5hrvpMrsgpIkrCGv9TOKYJuROJNRwl/pDCA/XEpHJ83BZ4TTy+B/1bpbhXvA3xu7wuRRdSL9ohlgNZAB618nwDCLKSNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829760; c=relaxed/simple;
	bh=dYFXTA632BeeuGQkMAIDu6iBNmqR0e7n0ux3WF4h3ZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XuCUGgspzYQMFbTrR0i4GNGjkk67vshSCGRpmgX/iqFbtrDbmP1EPwX4M69eYl4YFMMadFfQ6iMnzhsfElEe3/rcsbWMO3wsplcvO/kA2b1iZ3kjYbtcsev1crqBaX/zbaBgDS1qLGD8/w3Pl8NeuMY2DjdkTjnA6fjd4tNRyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UL884vGQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9TqyxOAC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWaX49EpyTWI1CXQV7+qQmnLT22/snn5ib9f2qvjoRE=;
	b=UL884vGQl0vu27HNCj+KBhotBygvq+NdqO4GfH30WPuH+HI6Y+S03S+zFXbkmPq2z/6ckx
	nRznmaftoVRmKj1TGfM+fcPfULfbJrJ/ov0WxvnwWC+TBxsJP89q2YIdWo5fZDUGpYUtau
	byN0oomVWPWTMyc7mh4NvJcRZO5vDgzJKuTLbs31CJuKh0o8O1PnOujphP2ShWUDquHX/+
	zPjGze1wBH+PeeYi0FHj4/etJJAw618cJ7IWtJxO0cbmSvjOVQOd5fKyCDAI8XjE3jdlz3
	HXA+9/CUJcSMVOlizSh1fOlj5DzutIxbo+wNQP5FFH9jtT0hZSk3xlOJl2SIGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWaX49EpyTWI1CXQV7+qQmnLT22/snn5ib9f2qvjoRE=;
	b=9TqyxOACsw5gWNdSgFzCzGdSmW1Da7agmh2j2VENROWdpRfl+9z3OZBvyg2czAKPkABo2D
	WaUF/amsxQ6n2YCQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] arc/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vineet Gupta <vgupta@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-12-kan.liang@linux.intel.com>
References: <20250520181644.2673067-12-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975583.406.14458305783798872837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a33d4d5325cce88ecea81c2468d85fa3fe720ab8
Gitweb:        https://git.kernel.org/tip/a33d4d5325cce88ecea81c2468d85fa3fe720ab8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:45 +02:00

arc/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vineet Gupta <vgupta@kernel.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-12-kan.liang@linux.intel.com
---
 arch/arc/kernel/perf_event.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 6e5a651..ed6d4f0 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -599,10 +599,8 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 
 		arc_perf_event_update(event, &event->hw, event->hw.idx);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (arc_pmu_event_set_period(event)) {
-			if (perf_event_overflow(event, &data, regs))
-				arc_pmu_stop(event, 0);
-		}
+		if (arc_pmu_event_set_period(event))
+			perf_event_overflow(event, &data, regs);
 
 		active_ints &= ~BIT(idx);
 	} while (active_ints);

