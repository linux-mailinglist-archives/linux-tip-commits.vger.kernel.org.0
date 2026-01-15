Return-Path: <linux-tip-commits+bounces-8011-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A99D28947
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1084B301276E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63F3327210;
	Thu, 15 Jan 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPYpg2Fy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HlRs1bBn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F430AD0C;
	Thu, 15 Jan 2026 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510866; cv=none; b=k2rFNpFWFSNhUX81SpeXYov/HHHBdOo0bbxNVrBf6WsjHS1rlsMuFCdetox44m0LLOPgb8UebWSYrGz19ueQCDkxlE8DWnsBP2bE7vzHstWqQBEVtgLSz0n7VmZs8YuresNgW7boAvWTsEc1eDMd41vi6XIo/ES6YTT0GAsS14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510866; c=relaxed/simple;
	bh=WvNe2NENpvtyDZ1AAVmCNhICjWaD9q1Ed1K0ujR58iQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IDEmoZzj9RkS2iVjt/j8niC458cFUg/BAYHIoUMy1eibCM/0/5a/n5kUkAhqXV4EoDN+WGAxrFZ3yuAxuACOKMlHq7yXXdAD3GgYaX0TNKQeCT/RjBKWT50Oj3tzrJqsrlCdEjt6U9Gs1U54onEw1iPRcScEJUswaCqOxhMu5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pPYpg2Fy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HlRs1bBn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768510862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azuer9t/Dj2wsFPlITo8POMn61sGyHOxWPezf6TwPjo=;
	b=pPYpg2FyL0vOm695o+NJTDwsNG4IC9klZQwASXbvlJ8+GOrdSnGflQnNrYyD+2OgvyGMzX
	nx5buDNaEHqAWzs8jcppUReSPatobQQ7JLBDYIz+KuKRDJbGSpN/t/iCSjJzemZBfDnnis
	wAjVYHHzBiofqx3SGAzjXQtSB3QbPdzjMNe4kdnDZdVVmNV1tLgEoZVUhZ3X6fm8zmDsix
	HxE7bgZhLLJm5IcDuQDJptqZAB3fs+xVQHb1vf91c/4ch8qs6+7iha+/PMSphzZIvjhtOM
	sNhSvtLj574w24ny8l4MBaM7/NWOgpP9D96wN0IPlZKvFF89okOI1sh+aOgcLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768510862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azuer9t/Dj2wsFPlITo8POMn61sGyHOxWPezf6TwPjo=;
	b=HlRs1bBnBfq8Vk1s6YTwDLrsjhQ2QvXYy0ZE018/631GtKmPD5ky4KkHO6VusdERA58RfX
	xfzD+G68y3LXHpAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched: Fold rq-pin swizzle into __balance_callbacks()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
References: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851086169.510.18280312067948817133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     49041e87f9cd3e6be8926b80b3fee71e89323e1c
Gitweb:        https://git.kernel.org/tip/49041e87f9cd3e6be8926b80b3fee71e893=
23e1c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Jan 2026 09:16:44 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 21:57:52 +01:00

sched: Fold rq-pin swizzle into __balance_callbacks()

Prepare for more users needing the rq-pin swizzle.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20260114130528.GB831285@noisy.programming.kick=
s-ass.net
---
 kernel/sched/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 60afadb..842a3ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4950,9 +4950,13 @@ struct balance_callback *splice_balance_callbacks(stru=
ct rq *rq)
 	return __splice_balance_callbacks(rq, true);
 }
=20
-static void __balance_callbacks(struct rq *rq)
+static void __balance_callbacks(struct rq *rq, struct rq_flags *rf)
 {
+	if (rf)
+		rq_unpin_lock(rq, rf);
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
+	if (rf)
+		rq_repin_lock(rq, rf);
 }
=20
 void balance_callbacks(struct rq *rq, struct balance_callback *head)
@@ -4991,7 +4995,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
-	__balance_callbacks(rq);
+	__balance_callbacks(rq, NULL);
 	raw_spin_rq_unlock_irq(rq);
 }
=20
@@ -6867,7 +6871,7 @@ keep_resched:
 			proxy_tag_curr(rq, next);
=20
 		rq_unpin_lock(rq, &rf);
-		__balance_callbacks(rq);
+		__balance_callbacks(rq, NULL);
 		raw_spin_rq_unlock_irq(rq);
 	}
 	trace_sched_exit_tp(is_switch);
@@ -7362,9 +7366,7 @@ void rt_mutex_setprio(struct task_struct *p, struct tas=
k_struct *pi_task)
 out_unlock:
 	/* Caller holds task_struct::pi_lock, IRQs are still disabled */
=20
-	rq_unpin_lock(rq, &rf);
-	__balance_callbacks(rq);
-	rq_repin_lock(rq, &rf);
+	__balance_callbacks(rq, &rf);
 	__task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_RT_MUTEXES */

