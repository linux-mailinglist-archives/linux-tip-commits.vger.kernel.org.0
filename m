Return-Path: <linux-tip-commits+bounces-5690-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD58ABF3FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F9C1BA653E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA60266B72;
	Wed, 21 May 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBewwjZf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kewLRMyp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A37238C1A;
	Wed, 21 May 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829758; cv=none; b=OcEgfzb9aMuAYkXXRSjH4siUrEApDh8V64BV3I8YSxAlGX9x+m7bPnqM4bEaiEdG2pXsDU2BRwKthWTpSrwhMQrh03EWUAfS/jYLPX4S8HN3qPn0H4TvO0Di6ckK/8z9WmTx4hTEWSotLVIqGyD1x4sifiwn2IrllqD+AJXJ/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829758; c=relaxed/simple;
	bh=Y1UPO9DJdHMGhRyS9KhFOhsGhMzUrH5SQyJCmAD9Xm4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p7VYT/dr3n2QWQD+lYF08YbKrWdxTHlJG4ExMIamAszVF8QIqngb061ok5ks1Bdbz4mvZpzeycQ0r+SjEfXNDbfcevm8frPcOp+bTaXGQ5UkOjbKzoF5mipotA3dL/WKBGpbqKPB5YE0rcbfkptBjz9ZUlgVlD5HTcrd/DCxwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBewwjZf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kewLRMyp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxkIFrAGLrzMwx37asP+ZMre3t6fugAXzc4hh4DU3Fc=;
	b=KBewwjZfxjjad2tiI2Sk17dTyb92L8M07OW6clNMKJNkMEuyesQxCu6jh9uXe6jOiEClxJ
	YG/gpA9Bcr6fFpIg4ONFV/NzdaRiNfN/pin5MqTAMDlrD+R5+5zk6nSiAwQs7LYGHW4jcC
	7tHQ+mGcU5OLWdWSAYTUb8vZQn8pHE/KqEDfNsVBDIISn9qd6Q/8dbSHzKkK6PSru1SkLy
	k5DY9Q8lzYVTvmITolIlB6bb1SBxle6TkFTomgg2uZx5G9vi4YCsbPPRq9BCXSyQeg9azT
	2NDzc8UcD6Gnx57qL+JcQ47UAL7uQO99Nc/SOOicufQEAiTIjh6HaRsJexjdvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxkIFrAGLrzMwx37asP+ZMre3t6fugAXzc4hh4DU3Fc=;
	b=kewLRMypx2Gtyw625g5buBqiCwhJoik1mLcD4byJA6BaqL27fI+uRE79JCaaFc/E3cRxqm
	mA8FlhzvqNr93KAA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] loongarch/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-14-kan.liang@linux.intel.com>
References: <20250520181644.2673067-14-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975396.406.757823148231064057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b82f8885d1fd46d88c554877a0d87e9a1c3d7165
Gitweb:        https://git.kernel.org/tip/b82f8885d1fd46d88c554877a0d87e9a1c3d7165
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:46 +02:00

loongarch/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-14-kan.liang@linux.intel.com
---
 arch/loongarch/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index f86a4b8..8ad0987 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -479,8 +479,7 @@ static void handle_associated_event(struct cpu_hw_events *cpuc, int idx,
 	if (!loongarch_pmu_event_set_period(event, hwc, idx))
 		return;
 
-	if (perf_event_overflow(event, data, regs))
-		loongarch_pmu_disable_event(idx);
+	perf_event_overflow(event, data, regs);
 }
 
 static irqreturn_t pmu_handle_irq(int irq, void *dev)

