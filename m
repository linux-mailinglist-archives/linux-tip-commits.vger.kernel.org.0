Return-Path: <linux-tip-commits+bounces-5021-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65D6A9161E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78ADD190782F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED222CBE5;
	Thu, 17 Apr 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L9zwKLQ6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694121ADDB;
	Thu, 17 Apr 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877300; cv=none; b=Eh/dKe62XXlVOzInb+KFUu3yDBjLTvCZIJ1Pt4HJe8GKNtnNsyOAHILDLdw0IPXWs+ZT97z7TZdONKxS6c68F/AaQ6b1qhC8xo1TwpsVEsITdD3jhlvPZCY2TdGO5EIAOOWNiMmJylADXZsPvVVXZch0PGx4Afa9JcaWSlTt4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877300; c=relaxed/simple;
	bh=pcCBoYEgi5fe2GMC/2MjGH8qiGQ+NsPVROIfKuVBfjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs/mILVqEvyCBMu/FrtuJS/UIPXEf9sqB1GfHC2Yds8YYijF58/gqjZVEXb34qIrRtHuDpuMSpNzbZSfeucrYnw4OoOCrOPgtMHAh3gCcYTTGTy98vh8siRbDUiJ6elBT87LfSi/Vvjv2ZAV0TNPiGbATGrPojKWE9VHt9ENVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L9zwKLQ6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gnBWyN9RLXdtwpVv3FnLDWANYfvF4HjzZ1/5Hb+T0UM=; b=L9zwKLQ617qE4e2zkkduH2VTAs
	75kmxZ7W4ANP2NujYwRRAMic+5P8oKwRmmqL6X3F/uUeOckrGEsSfEitpK9PCkPm4de36UMyJWXZV
	Hmfv7MjvGL7yMeCc5nRx4tDNKR3TdunjZ7mOVcZl6SIDsQDlYxfrFKJqg+cwhcgS0mUnZgtZgRaBZ
	vYiPrtg49Zti4lTG312imfVoyK+lRFBIg9RIaKhPYTXBilOPPjlF7+TY6sh7lnJimrxjKfVxIfNUt
	mcWdQyxLzNW8IqFBOZ/SgJpZQvMSpGbPAYAKLndIM6mLR5Y1Iqw+PQwARukHGoyuD4LUTZq3S1OR/
	leXV2TrA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u5KIC-0000000AF1D-08td;
	Thu, 17 Apr 2025 08:08:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5ABB300619; Thu, 17 Apr 2025 10:08:15 +0200 (CEST)
Date: Thu, 17 Apr 2025 10:08:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
	yeoreum.yun@arm.com
Subject: Re: [tip: perf/core] perf: Make perf_pmu_unregister() useable
Message-ID: <20250417080815.GI38216@noisy.programming.kicks-ass.net>
References: <20250307193723.525402029@infradead.org>
 <174413910060.31282.8504333237561774159.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174413910060.31282.8504333237561774159.tip-bot2@tip-bot2>

Subject: perf: Fix event timekeeping merge
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Apr 16 11:36:24 CEST 2025

Due to an oversight in merging da916e96e2de ("perf: Make
perf_pmu_unregister() useable") on top of a3c3c66670ce ("perf/core:
Fix child_total_time_enabled accounting bug at task exit") the
timekeeping fix from this latter patch got undone.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2500,14 +2500,14 @@ __perf_remove_from_context(struct perf_e
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
+
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
-	event->state = min(event->state, state);
-
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
 

