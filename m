Return-Path: <linux-tip-commits+bounces-3026-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4BC9E911F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77372813CD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF26217707;
	Mon,  9 Dec 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pM4EETTJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ii8cU47x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916921765E;
	Mon,  9 Dec 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742005; cv=none; b=gtE5yR2yQL+ZBbFdxUEpCNvOTRhgKXNVG3sawGnI6LuQ+dt6n4/Go5HJpzzCbdQXsQfLaWncG5OZJqBZqw8bwMtWdx3MR/iTD13UMo3isJELJrgebhMpzTueV8CLNLgBhjuS8qfERHGZZlOguDrX/pMPBCEkxuTl0eP3/8cnHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742005; c=relaxed/simple;
	bh=7/Q19izVXo99Lf2A/wawEUvTqvVQ2b9XwUIaX4ejk5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KGi7DIeOemaYNDvCoB+KEUOeZDmXH+OlO2HnwHo1Ga19644lQ7W9ftNZeUr5Nfx99hCuM7JFgGiVzaAsmd4D1O7fDiRp3dNo0H83rvmRVW4erJRFU0lCkwuXIEMgJp5XeFmLOCwnZ9qGnKloG6Cdr/fYFDSRnxQ8YuDvWKzvp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pM4EETTJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ii8cU47x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUbJi9ZUBIKYnEBftXRaoY/Tcv2rvVWF9h9v/4qO5+M=;
	b=pM4EETTJyenr05lNKd15NdoybDSgCaGM3EqOLrzxZ2fM3p2CRIJje2vAjnin7r03QAhf6u
	KvZdnLV+9/L32MeoFRLBBQ6Yy914U6HuHjMTjiBdTCbH/kPfl+mHcTTSSewDw8UlJEvNTo
	XBkHUwstgR7kkudhRUezkJHS7hL2FbbqjWKn1nNX0kPV812XqSgV7KutdqBhLmdoh4m/Xn
	yvIv9e4IGNoyXQVE+sNgeFHh3a4iC7Wb7aMt41GEYJHuSgiprBvWEz8Cn6MWpwz5yrB3gD
	jNXDJyBS6ahwboDbQC6O4pGKvJd8obGdk+6mB0I1DouaXkkJBMuxJ8rNsONyGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUbJi9ZUBIKYnEBftXRaoY/Tcv2rvVWF9h9v/4qO5+M=;
	b=ii8cU47x1EwNNWMmRhgNmlgieROcmwNpDhd9qM0rDnif8Y1oGxMfh3mHQFtfQfFppY+ZIG
	v+dfM1ffK4+LauAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241129101541.GA33464@noisy.programming.kicks-ass.net>
References: <20241129101541.GA33464@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200122.412.16142475104461907417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2a77e4be12cb58bbf774e7c717c8bb80e128b7a4
Gitweb:        https://git.kernel.org/tip/2a77e4be12cb58bbf774e7c717c8bb80e128b7a4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 Nov 2024 11:15:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:13 +01:00

sched/fair: Untangle NEXT_BUDDY and pick_next_task()

There are 3 sites using set_next_buddy() and only one is conditional
on NEXT_BUDDY, the other two sites are unconditional; to note:

  - yield_to_task()
  - cgroup dequeue / pick optimization

However, having NEXT_BUDDY control both the wakeup-preemption and the
picking side of things means its near useless.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241129101541.GA33464@noisy.programming.kicks-ass.net
---
 kernel/sched/fair.c     |  4 ++--
 kernel/sched/features.h |  9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b505d3d..2c4ebfc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5630,9 +5630,9 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	struct sched_entity *se;
 
 	/*
-	 * Enabling NEXT_BUDDY will affect latency but not fairness.
+	 * Picking the ->next buddy will affect latency but not fairness.
 	 */
-	if (sched_feat(NEXT_BUDDY) &&
+	if (sched_feat(PICK_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
 		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3d331d..3c12d9f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -32,6 +32,15 @@ SCHED_FEAT(PREEMPT_SHORT, true)
 SCHED_FEAT(NEXT_BUDDY, false)
 
 /*
+ * Allow completely ignoring cfs_rq->next; which can be set from various
+ * places:
+ *   - NEXT_BUDDY (wakeup preemption)
+ *   - yield_to_task()
+ *   - cgroup dequeue / pick
+ */
+SCHED_FEAT(PICK_BUDDY, true)
+
+/*
  * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
  */

