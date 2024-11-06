Return-Path: <linux-tip-commits+bounces-2763-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5419BE4B4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7BB285A62
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523C1DE2C6;
	Wed,  6 Nov 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qd2+NyiV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IMXUYthv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD071DE4F1;
	Wed,  6 Nov 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890108; cv=none; b=tZFkqqx0WpcjYTqM4+q4TMHDV41b0ww8lIz5Vld1gDG3kVhb/lmHERZYrvQWfx7GcvcAHA/cuT3B4OvlogLr+4Wqn/qFJLfy9ZrG7KqMHzspfBP4qWPPfvEvq5sTXU7XwwKJrQ6iNw3V2MhSy697IabdKvTsqEkFs9DFIZhDxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890108; c=relaxed/simple;
	bh=XL0nLsUyUewmnbQIOMxxdb86qaY74YOiLh3VuiYtIIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YHuN3azDoBQWxwRx3ieXrr4sgeBD8f6KkDyBm09WnIxygbhMqqadsVcwYMUiq+avH7HuvebKTVMUTUNHvKmKyQWveLodQeomOJ0n0kG6tRqWFE1Q01XutyBMLweOfC81la7zVmU+1wOpqF1zydWFFDSWd9rNQftvTVR/GiBJpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qd2+NyiV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IMXUYthv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrXC0bSL5l4tcXEnsKAT7fcJpL2XKv6EvNWW6U2wHt4=;
	b=Qd2+NyiVlQ7z+bJsoR4XYvWMzjpfVuUjmeV+Cwu0zHCYbn7t0ge0iSfnVmreabEP2ezdiW
	2mdtXI4YTSZwHoFM9wdcCXGoCq3VSKhokq1SIYPqfs1bd7TMkeYbNDUatUdu7qtiO0j+6U
	CxNn7VAEm6cpvd1noxl4FCSSSJcNTGUhK3PpYUPLzKLf8ShvEAQU8J6LBPKjTNhsNadmyJ
	SMpwgmDV1wj/kOthV5jaFyIxTTq9K/htu7dcukXFrLoygwGanTADpzTNFlQ5mCnT+iEkv3
	kF4CNpnBQPRv8v1uWv9b/tYTB1+mlb8D8Pf3qfvFJ86MmBuqU4uKD1X92Jf4/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrXC0bSL5l4tcXEnsKAT7fcJpL2XKv6EvNWW6U2wHt4=;
	b=IMXUYthv0yi6/QKOgjayVzolJXD54bDjYj863OnX2NZyUZ8MtzwuSNM0fyM0fCP4aNzeNj
	HQv++R96CaDpfYBQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Do not enable large PEBS for events
 with aux actions or aux sampling
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241022155920.17511-5-adrian.hunter@intel.com>
References: <20241022155920.17511-5-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089010328.32228.17083597737196357277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0d5eb14c1e2ed4a8413458cb3b779f215ff214aa
Gitweb:        https://git.kernel.org/tip/0d5eb14c1e2ed4a8413458cb3b779f215ff214aa
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 22 Oct 2024 18:59:10 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:44 +01:00

perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling

Events with aux actions or aux sampling expect the PMI to coincide with the
event, which does not happen for large PEBS, so do not enable large PEBS in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20241022155920.17511-5-adrian.hunter@intel.com
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7ca4000..bb284af 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3962,8 +3962,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
-			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event))) {
+			if (!(event->attr.sample_type & ~intel_pmu_large_pebs_flags(event)) &&
+			    !has_aux_action(event)) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 				event->attach_state |= PERF_ATTACH_SCHED_CB;
 			}

