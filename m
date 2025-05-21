Return-Path: <linux-tip-commits+bounces-5689-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B848CABF3FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874273A3F81
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC826656E;
	Wed, 21 May 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdrT2VkO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0D3JVz+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512721FF58;
	Wed, 21 May 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829757; cv=none; b=f36OFT8ofkoyzzRVAuCnxAWfwPWt361Xzve5h39TlXvepo89OZwwIrMnlOqebFiRg5Yx+vYQl04ryj/3Eil70Bb3Fw81Ip5oNTelnS88bqrfsaEh+OcGy9IJyPPJG+/kOAEF76h45cgOAmQZrW2JUgPyDODVrd4z924tRRKlfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829757; c=relaxed/simple;
	bh=9ifiLf/3QsdWG879UKP7aVH2hLkpnmsXcsMhC8M7sPQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FtumLLTyw5OGyaeIvmTQqhU3qfT0ORRLIXG+wgxuZm/rhhkUcNz9Uerop74FAZqvYlAfsRnceizZRTZp51TaSI5u5qduZki2hWAB3ea1+jbylON8H0+5yZpzP71buDLsf7hVwFLR/4hKGlry953xRmt5sexFjMvNdTPNnu6Zcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdrT2VkO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0D3JVz+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LY4LipDnjhIJM7Miwo8jK3aQpgW6u+WwnMU0XagHwM=;
	b=SdrT2VkOAZ4LkJ6GJr1uMbz7BLRtbxmm3JMBGrhTf3AAYvoh9XlTvbj3GK0tJSKMzbRK6j
	HNk0TumjTeIdZF5JXzlc6HyJ7dXnWzJ2zORBffdFt0JIYpNZdbqtHZw+dcoO3Y7bz2B9KX
	JlZOvem3+LWf8U1mB5mHtR8Stdj7JTaaQXLPX80yEjGfD3TXyILP+gMoq/OqGJAENGg3Z1
	uDmdXu6GHHDbmU5zOxbuUwerJHmoXnnmQQ//rB7sagkXeZF2xV3AI2s+r2GLF8B984Uhyp
	fNcu7Naieutv1y03RDWkFOpd+oYuFqOvAiIZgoFpqzeOrfYtVu3fmvYVeifXjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LY4LipDnjhIJM7Miwo8jK3aQpgW6u+WwnMU0XagHwM=;
	b=n0D3JVz+ft61wBlJoiPt2hp8Zapx92koqtVcQAnRaRj/gCAt1lsmgiCRsrgBYUeG+3xavK
	9rlZ05GToPbaikAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] mips/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-17-kan.liang@linux.intel.com>
References: <20250520181644.2673067-17-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975107.406.18030140197688379257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b216af2eb4618caec6bef32d5886a9700b0ecfeb
Gitweb:        https://git.kernel.org/tip/b216af2eb4618caec6bef32d5886a9700b0ecfeb
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:44 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:47 +02:00

mips/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-17-kan.liang@linux.intel.com
---
 arch/mips/kernel/perf_event_mipsxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index c4d6b09..196a070 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -791,8 +791,7 @@ static void handle_associated_event(struct cpu_hw_events *cpuc,
 	if (!mipspmu_event_set_period(event, hwc, idx))
 		return;
 
-	if (perf_event_overflow(event, data, regs))
-		mipsxx_pmu_disable_event(idx);
+	perf_event_overflow(event, data, regs);
 }
 
 

