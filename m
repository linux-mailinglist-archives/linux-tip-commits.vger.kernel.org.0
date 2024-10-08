Return-Path: <linux-tip-commits+bounces-2357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0E9941E4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FAB1C2511F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735081E47C9;
	Tue,  8 Oct 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wm64nhBF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tTeqg54J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D81E3DF4;
	Tue,  8 Oct 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374183; cv=none; b=YRTU58L81gm5SeVSXsNBtcx2PGacK2c6sMrwImG6nHW1iUdWEkjrejC3RPgcsjS593GnmQ9DOcnflUJh6LWxv3Jir7OwVUvMqeiGvgj9pL+gwurGn9qWRZgYVfYYsh68f64d3W2dCqRdIgbTpcNtQMYTi995PlfDHPYmGV/LqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374183; c=relaxed/simple;
	bh=v+Nz6zuH4iplykh8bRKyTaIdnBD5oQgOoQP2WDbHX1o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eO4y1cKwAP3q6SERsvTaExjk9mLHbsb2+mwx7unNjjBCYwMDYdA2+mGkjwZ7ZvHKeDY9j/DqGrdYN9W9if92L5pf6N1Xzavj5csPakN9WE34Dv2fvJGmocl3oaHY+rQoIacecNpaavkG+01HDDiNjOm5+yGi/AWlp+8u/cbY3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wm64nhBF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tTeqg54J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kclRuTWIwTkQ70kMONDP5vx9FIxAGeMDvX8rbl97yPk=;
	b=Wm64nhBFGy61qZVg1kKjD/K053kwnpJ8MASJSY3AxnRJdKIho10Ny4vuvVOaJpncRFdnHR
	EwvSIho/fGkaQABF3QmF1HeeWUcH3M7vppSqn2n9w7aCnPrd30LrvL4NlbhYmTK5fHYFsI
	0WrK7gYj4RzMWmD9Agx597Sx+6BZsvW41xSrbQtiF9N9s9ppV2xyZv9Q3Lx6Rm5B9JQ+Xb
	4YaR7SbYLWZ3RPKBTwGjK+4WqxQ5A7WojAL26uVqhJnxR9RxM34nDTKJa7K7m3e/B4SwBS
	veJVkXMFLdOU+iQq0MQFNFc7XzmIzzj2py7wSYI1VcGd3iasw/vyq2h6nw2g9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kclRuTWIwTkQ70kMONDP5vx9FIxAGeMDvX8rbl97yPk=;
	b=tTeqg54JMO9nIKWG/NyT9qCuFQTz/HRezIZcjQk1Gwy/lzT8g0f4neG3olh8uAqkGOFIW3
	Zr0+xeSC2vuF5CAw==
From: "tip-bot2 for Huang Shijie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: remove the DOUBLE_TICK feature
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Christoph Lameter (Ampere)" <cl@linux.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001065451.10356-1-shijie@os.amperecomputing.com>
References: <20241001065451.10356-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837417940.1442.13398867634108590845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e31488c9df27aaea2cdffba688129fdeb3869650
Gitweb:        https://git.kernel.org/tip/e31488c9df27aaea2cdffba688129fdeb3869650
Author:        Huang Shijie <shijie@os.amperecomputing.com>
AuthorDate:    Tue, 01 Oct 2024 14:54:51 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:40 +02:00

sched/fair: remove the DOUBLE_TICK feature

The patch "5e963f2bd46 sched/fair: Commit to EEVDF"
removed the code following the DOUBLE_TICK:
	-
	-       if (!sched_feat(EEVDF) && cfs_rq->nr_running > 1)
	-               check_preempt_tick(cfs_rq, curr);

The DOUBLE_TICK feature becomes dead code now, so remove it.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Christoph Lameter (Ampere)" <cl@linux.com>
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Link: https://lore.kernel.org/r/20241001065451.10356-1-shijie@os.amperecomputing.com
---
 kernel/sched/fair.c     | 6 ------
 kernel/sched/features.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31a..c9e3b8d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5680,12 +5680,6 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		resched_curr(rq_of(cfs_rq));
 		return;
 	}
-	/*
-	 * don't let the period tick interfere with the hrtick preemption
-	 */
-	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-		return;
 #endif
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 2908740..7c22b33 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -56,7 +56,6 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
-SCHED_FEAT(DOUBLE_TICK, false)
 
 /*
  * Decrement CPU capacity based on time not spent running tasks

