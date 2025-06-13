Return-Path: <linux-tip-commits+bounces-5785-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BDBAD845F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344EA3BA8D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1DF2E3381;
	Fri, 13 Jun 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lk2HUPkN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbLreO7o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC32E2EE9;
	Fri, 13 Jun 2025 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800233; cv=none; b=G6FYChL6hgrTuzYTVHbQH4galmI29yTXsFo9OSJ5t33gCTT0gOlktlhOC1DsdVOaPHzmjz6vW0GrBJWCBD3k9payC8TgBbbOS7kxvlhqnM+qy0yvkG63yMXoDbFOSdPrt6llAyPnJEnwbOa9pznbz+GdzQCP9mqSa0KxM5a6CPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800233; c=relaxed/simple;
	bh=mrWWJ3X5nBnBNPCpZs90d8JlfDCR9rg8Acrri97Zyfg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KvZkFsL7ueZWUYN46GuIpeOIiBqIDHmSlhM1NM0+7h3T2V+z3X/dtLrLSTvVbX1o6O27F0UzDaj6A96IrvOaCiJ1lJWwc6wY1oJ9RCk1rlL8l6giV3bC6XLbdsjtR4XY9+eTH4yaErUT7WOnWUM6dWzl5l0IdrY92kphm3PxFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lk2HUPkN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbLreO7o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aZo6M6OQI63cAPam8Bbr0ROdXJmBRs45BPemT6cUA4=;
	b=Lk2HUPkNCjsJdY7R4kz7D4YmznzAUJz+Qi+RrxEdM2w4EaxhRf/cQwV3r7NwwvoDYKtzbO
	RGuEbjampqZePteUizeX9irolVs8bmE/qL0GcTrz95VNtb5UCc7vqCy2qwb3xehg4jDpyM
	C9UIpwnHZh/hqVMmgznmQsR8ogNg5W/P8JyetEC04xUi31eX1xakscbME9whMpowDklQis
	MWfraWiKFQguiVFrb6bqGJWr5rArmlodtWAqR3Z/R3VwGwBbVYqWbU7CJexVkn7vkG8kvD
	hpQuSHG3QQTqFzi8S6w7UsdEp0s0Ucw8fDjH++iy//1ICN442OAPkWYEsOFzig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aZo6M6OQI63cAPam8Bbr0ROdXJmBRs45BPemT6cUA4=;
	b=fbLreO7oxct6P5tcECcf3wbtiUtUOL0j88DbvFyqAW9iCxQ+zbpfXpbBScpRHk1WYnSxYg
	E6S2tkSo2ojX/DBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of rq_pin_lock()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-39-mingo@kernel.org>
References: <20250528080924.2273858-39-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980022940.406.10788690564582753594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     703b8e8545c7ca88002164d6c119c49e8ee9b137
Gitweb:        https://git.kernel.org/tip/703b8e8545c7ca88002164d6c119c49e8ee9b137
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:22 +02:00

sched/smp: Use the SMP version of rq_pin_lock()

Simplify the scheduler by making a CONFIG_SMP-only warning
in rq_pin_lock() unconditional.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-39-mingo@kernel.org
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b184c3d..f4bac9f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1745,9 +1745,7 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-#ifdef CONFIG_SMP
 	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
-#endif
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)

