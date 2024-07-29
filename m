Return-Path: <linux-tip-commits+bounces-1799-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0593F2DA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB81C212AA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85069145B10;
	Mon, 29 Jul 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XpUCydsj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNOFY3zs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656B14533A;
	Mon, 29 Jul 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249250; cv=none; b=aRylyRlcaYcBxF8qC6TaQbk7dU912K2tHVwcMVW4I5vXpTA86ailhgJRi1MYjRi3iICiuSGYRRxIC/RejfJxLPvkzGM+Up+GBteS8V4XROyDWGCTCfF7brTpWRGbgmkVAgOAsCMKtG0EIgCX4l88wlHxu7P0bsxkqgFy6iNxGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249250; c=relaxed/simple;
	bh=RFiWwLKQ/xtWAawWPyIahUKheU3vWP123YG2rhGxuiI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f8gBTQRnLWb1gnxeVtJPUycojS33s3IfFFKFul3P6plpoUAz+CCCNrShPLNE9QcFKcr9BdcvL5LtqZiGpUEaMuotW/03bOHHnpn680RA9Yv3elubpvoZ8+mSyM3XiOlsBMofg3qNxk9dT6f5y4oFJ9RN1Qmr8TBfeBErSJFhnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XpUCydsj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNOFY3zs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elXpH8uytUzpeNCA5I/weBw510vIYg50tjMDGQsoswo=;
	b=XpUCydsjO+Ergkc4ymCxt3hELiC2WSI6DiQwODAIAEY+L1IcGWOEI6Y8du89GuD/05Z0F6
	/jo67iLfGYoniTimSfuXyqtzLgBe4ZocWyBJTFnbOXu1+ulIZhj4TycB1x8SjnjY36tvxZ
	LTRuSNsaKdrKCF+e0Wc+s+4uHqUXuDF836LgiJetZZnlKlFkm6A2RJFO2uJVmx2aSfc+VS
	/Yz2leC+U0zV3ZXOnlhOlvZWSgYhMxVKNGNa1Nq9Ld68+lazLkK2kF5v5E88AM3BebUibi
	zzDPQFnFazCd2t1VQmhYF4WY4bqA5pnVQOqwQ8zHiLzxayeAd1XrcbALs2uXog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elXpH8uytUzpeNCA5I/weBw510vIYg50tjMDGQsoswo=;
	b=BNOFY3zs4b6zQTnftcdbJsGmH8pzqDh4SBrmRrcPT7GwLb9xGYr+3P5LsqABJDSHjcue32
	Ff+PC5mmy1h6zhDg==
From: "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: remove HZ_BW feature hedge
Cc: Phil Auld <pauld@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240515133705.3632915-1-pauld@redhat.com>
References: <20240515133705.3632915-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924671.2215.17289809764508952569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a58501fb8320d6232507f722b4c9dcd4e03362ee
Gitweb:        https://git.kernel.org/tip/a58501fb8320d6232507f722b4c9dcd4e03362ee
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Wed, 15 May 2024 09:37:05 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:34 +02:00

sched: remove HZ_BW feature hedge

As a hedge against unexpected user issues commit 88c56cfeaec4
("sched/fair: Block nohz tick_stop when cfs bandwidth in use")
included a scheduler feature to disable the new functionality.
It's been a few releases (v6.6) and no screams, so remove it.

Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20240515133705.3632915-1-pauld@redhat.com
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/features.h | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db5823f..0a71050 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1269,7 +1269,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * dequeued by migrating while the constrained task continues to run.
 	 * E.g. going from 2->1 without going through pick_next_task().
 	 */
-	if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
+	if (__need_bw_check(rq, rq->curr)) {
 		if (cfs_task_bw_constrained(rq->curr))
 			return false;
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8cdfeb..02694fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6555,7 +6555,7 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 {
 	int cpu = cpu_of(rq);
 
-	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
+	if (!cfs_bandwidth_used())
 		return;
 
 	if (!tick_nohz_full_cpu(cpu))
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55d..929021f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,5 +85,3 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
-
-SCHED_FEAT(HZ_BW, true)

