Return-Path: <linux-tip-commits+bounces-2076-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4BD955B44
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95AA2825AC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4A757FC;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iIAl5TpW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0LKjN8IY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824F21A1C;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=UT5G5W/1GZZ2ByMtm87mj1H5VrrFskBmsdRW7BfeHuj+gsut8bZ1wLKEfQPrzkDfgy6WdxIOQ/KYAsScr6gOu1+znJqTe+4gSB/bcI4jJqrHGDntEwxAqMas4KqE6dcctVI16scOXCDDXrGKSLj1S+aWEyoAX/DuHDWSC2aDQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=FERU7lWcb3Ns7s2+Dvk3q/INzsrKL+4kM1wYC9BokWI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N2baIREKbP4LzOxOtSIYKnuRpTJUpvMLOmp9la50UpgbT9Bw7DeyY8EeAseI74T/czwsGciZ2VGWu3E/C7LqBvlChtVL+cDajPgIxra2WdGUWbIbj+3qDFT6ufO8BCOAq8PTBs0aLLJyBAhcTGpFOi9bBeDipTkfyVtSFgNx42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iIAl5TpW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0LKjN8IY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suJ3/GL8BRNXXc+ZbeHzNZQfLiDBiRPgvDU1+Lfg6kU=;
	b=iIAl5TpWWU1M47gfFJYyRmVStQTEypjwG7A5PWSCePiIhIsVJJ4enWbJS5bDXGA27b5Vn3
	5ofUtLv6X+s8dsGyQooRV52Pc3x8rNU1z48ZKGojHfrH/tzqLzAnZNa2bCfXiCTHQ87Vzy
	y6ygrhBwcb08yXDJk/qhAamnBXa6XCmmQ3r1vLoFx5HwpF+O9Vl0BTEGUGD2EOT+AFjat4
	khJ0nsy6i+2mIIcVuS+w2MggkbvMF86n0Dr38G7DYUr4qD+pcEfXIQ+lXY84yFM9a8HTyv
	7GALK+1yBfWoTenNCO6Zz4QYHzc4zhunekMMCbbGnFXK0cWbtQAHr2tzGx+PTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suJ3/GL8BRNXXc+ZbeHzNZQfLiDBiRPgvDU1+Lfg6kU=;
	b=0LKjN8IYStEiaSNVMDGSUKcZjaxoOQ1XKE2azfCHohtqPLKNmdLBpS3/LhhvJczx2p5YHO
	Rl0oqEIzeJ9w8EAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Remove min_vruntime_copy
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105028.395297941@infradead.org>
References: <20240727105028.395297941@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219227.2215.14819251232834033002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     949090eaf0a3e39aa0f4a675407e16d0e975da11
Gitweb:        https://git.kernel.org/tip/949090eaf0a3e39aa0f4a675407e16d0e975da11
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 04 Oct 2023 12:43:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:40 +02:00

sched/eevdf: Remove min_vruntime_copy

Since commit e8f331bcc270 ("sched/smp: Use lag to simplify
cross-runqueue placement") the min_vruntime_copy is no longer used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105028.395297941@infradead.org
---
 kernel/sched/fair.c  | 5 ++---
 kernel/sched/sched.h | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d39a82..8201f0f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -779,8 +779,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	u64_u32_store(cfs_rq->min_vruntime,
-		      __update_min_vruntime(cfs_rq, vruntime));
+	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -12933,7 +12932,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
-	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
+	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1e1d1b4..a6d6b6f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -613,10 +613,6 @@ struct cfs_rq {
 	u64			min_vruntime_fi;
 #endif
 
-#ifndef CONFIG_64BIT
-	u64			min_vruntime_copy;
-#endif
-
 	struct rb_root_cached	tasks_timeline;
 
 	/*

