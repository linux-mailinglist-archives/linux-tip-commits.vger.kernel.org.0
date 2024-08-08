Return-Path: <linux-tip-commits+bounces-1996-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121E94BB11
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B3A1C22314
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D312418A926;
	Thu,  8 Aug 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="quLuuIdY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BpRluLvu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70718A6DF;
	Thu,  8 Aug 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113130; cv=none; b=EJD4lweCn97J9HiXMm+pOvjqnFRSxLNqQpGG0oxLUiwltqGMyW9DrMr/lQiKfZEFzAChPBJJLB2hUv9qqp00PJd+kmPCgF3piEetKT1wPREueXx7aMYP34b/8MA7srVb8mnnWvyuyvimXAnW+BsbTnYtzSQTmR2HpeDzgWuOaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113130; c=relaxed/simple;
	bh=Swjp+if9rc7OvYKUuqbH3py9VbNgQe1L8Z+qab8ZaIk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KchNTysJc4T2yqROSyJorEh4DGgbJ1NZx3cTeNJlYoIjuV9WSbxL6af5axNRjUPRsJCT2FG1IZMxVpEZj/9pJnh63+vL4eLziHeUssVzPZC1pTqrR8v3qMs8CtQT6gE1FylVGT9xBKeXAFRpYCUVwydHsrNZbGPSRzjqSGVa670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=quLuuIdY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BpRluLvu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723113127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8+oKd8SATM6/vpr+Spgqm8dqy50N3DheoV6+wTfQXI=;
	b=quLuuIdYZzmMhJvNHpJ5sMdGd06JYQ72rOeJ2Ad392oZtzDIJyrAKLzZkL+lhzGcCAyW9M
	azG3B+Fwkur32Ss+Y8PDp1hanPDwwmm8336odytRMi+KcKCDUBUejXIpSzpEB7mfTRy+xN
	cXvhw/IJNuav5VF+y4DK8eagQ0JkEPX3CeJkUfhUEO4NFhLtYW9RXXUg/eYt390YqoUfeG
	LAABioUDcdObe+SRWxZYPPadsHBFoGpZygxUMYkmbci0BDuN5BUCOAK5s+5K1m/JkREs6l
	FMm03ZzUT738/yBHENomnYXTxsI4EYyTDCvsg2FLVlu0NpsTWDiUjz0ehGXQJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723113127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8+oKd8SATM6/vpr+Spgqm8dqy50N3DheoV6+wTfQXI=;
	b=BpRluLvubnJy2L4W6Jgmx4mvnUu/GVLM7G0Uk3AQTOhmuHMCXudT1ywEpbh2uV+uulDRr9
	8plzMNS5ZSN5SdCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Optimize __pmu_ctx_sched_out()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240807115550.392851915@infradead.org>
References: <20240807115550.392851915@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311312704.2215.13238492458175562145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e15a3fe3a2a170c5be52783667706875c088f96
Gitweb:        https://git.kernel.org/tip/3e15a3fe3a2a170c5be52783667706875c088f96
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2024 13:29:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Aug 2024 12:27:32 +02:00

perf: Optimize __pmu_ctx_sched_out()

There is is no point in doing the perf_pmu_disable() dance just to do
nothing. This happens for ctx_sched_out(.type = EVENT_TIME) for
instance.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240807115550.392851915@infradead.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 197d3be..9893ba5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3312,7 +3312,7 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 		cpc->task_epc = NULL;
 	}
 
-	if (!event_type)
+	if (!(event_type & EVENT_ALL))
 		return;
 
 	perf_pmu_disable(pmu);

