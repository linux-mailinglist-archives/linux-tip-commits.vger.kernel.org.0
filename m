Return-Path: <linux-tip-commits+bounces-3038-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F829E913B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155521618CA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ECB21B194;
	Mon,  9 Dec 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHtFIhzL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/afiT92Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07C21A939;
	Mon,  9 Dec 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742018; cv=none; b=KPxL0FUwcdR8ftCsw4a/l1zNkCj009N+1aGFBUAnHNmexQckTowbvLw62BxqL2H0cwMCiU82IFLI/nvrGyhkQ/3XTAlVjHuzBNLSDk0cVirb+rxTWrp6sb/fMAsfgBAZpt/RMSSE/LFthAsJeT2y1AypgPLY4uDE0hfMSGdE5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742018; c=relaxed/simple;
	bh=/z49iD+1mPMI+x6T+BGDngxircq949I/ee8dMxZ22pw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i4a4vW3jsobmjhNfceXqwAoxQ7CmAQj9e11lEYiHaWi5VCgkac4LPnUJVXpzaMoSBkYkP5kSl7n6rzCMoMYisTMmFzb0i/pUyycig2nnk5dvbsgpNIS6nWKpSQCBam76fJEJpr+tcRG5WvmTW4bPvvQ5Sc80wqOXQ8ZwBp9kXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHtFIhzL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/afiT92Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcIrMknH5oN7IiJCsWHNBMp9lGwiqqlD37wjDr7+MdE=;
	b=EHtFIhzLmVUfh2j4iQBDVR6hMDqVVkdLFQLZ3tXUmHypKaCDJdaGFYzfBs/TWqEzGq/rhu
	uOsXcq/8zE5oWo3SsmxKSioEO6kzAg/gcSUd5ef3Kw5d4KIlqjWefnoy1O1IjyeoiIRPj2
	/2jpKx754MxoQ4BG9gVIewM+zlQDx4FNPX67MAZa2ZHaa80tvfOnWiybQCBOCYO4pHULpc
	j6H3cQbjMnH/ZKNOlUM7jc/LbWYU5H1OQvAliVuEBgQDsrmFdB0xDTEidzRL8glXRkSge3
	tHoWSwICmHEEgZCh+JNw6F6D6RhkLUYbkVamFkZJH4ob91V3a6zrppPcYj4HSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcIrMknH5oN7IiJCsWHNBMp9lGwiqqlD37wjDr7+MdE=;
	b=/afiT92YODfB8Lm2GGAgv5G39TsV6T4QgU1dwvoVBtuZ4c+iBOiyYsWZBediACDGGuanh2
	WJSYjzbZ7tuMD1Bg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Fix sched_can_stop_tick() for fair tasks
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-2-vincent.guittot@linaro.org>
References: <20241202174606.4074512-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374201363.412.6879199999203287235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c1f43c342e1f2e32f0620bf2e972e2a9ea0a1e60
Gitweb:        https://git.kernel.org/tip/c1f43c342e1f2e32f0620bf2e972e2a9ea0a1e60
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:45:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:09 +01:00

sched/fair: Fix sched_can_stop_tick() for fair tasks

We can't stop the tick of a rq if there are at least 2 tasks enqueued in
the whole hierarchy and not only at the root cfs rq.

rq->cfs.nr_running tracks the number of sched_entity at one level
whereas rq->cfs.h_nr_running tracks all queued tasks in the
hierarchy.

Fixes: 11cc374f4643b ("sched_ext: Simplify scx_can_stop_tick() invocation in sched_can_stop_tick()")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-2-vincent.guittot@linaro.org
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c6d8232..3e5a6bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1341,7 +1341,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.nr_running > 1)
+	if (rq->cfs.h_nr_running > 1)
 		return false;
 
 	/*

