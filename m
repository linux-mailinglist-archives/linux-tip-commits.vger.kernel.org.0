Return-Path: <linux-tip-commits+bounces-7731-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E378ECC741D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0933E31B7CF2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E643148DB;
	Wed, 17 Dec 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7pL/B5C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMmn+Paq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785C214A8B;
	Wed, 17 Dec 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968998; cv=none; b=qwbbJyPesZ75cBMg3gm42qZMoU6WRXdo/4M6ctLV2pnXkBE0nCNJOeyE87OyFHPKTrAq73eRtiacLA6jhJyJDJ2DAR/51D8dJuPpTm467AEutguE8y0mFMaoBLy17TPCNKrVTjJYaglEd/iHdUSvdxFt9w33vm00+vwsEtQIip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968998; c=relaxed/simple;
	bh=AGR8FAqAl0jweMgl8sXwlVHqmNCJfXH8kNGk4E/UMYM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SLKXEUIOS748L+mJWfkxBfP1Lm1PaAqtBT5zrUtB7n1MCEbeH3ChESmSmNGJAnkPkLDltzmN2VCXEH/wY6ovQ0vhdc0LMfAfq2pxdBPVqh4wLnPTu8NCpRj465IWvlsoAt5naoMBT/qKMJAJSFK1Bm2gtBQ/9/cwi7KgrP/MzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7pL/B5C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMmn+Paq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 10:56:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765968994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmiNNm39PY3lOEnGS/ImNoK9FxpQFagWPPSY3MsK5l8=;
	b=J7pL/B5Cihqk0/IHGanxXdlEwfTYvXCrUhJRAVlr/MqM13ajIi7iGTn3iLccBHxuS5Aoae
	DOFyHw8Hy6XpnynjjdkMsANrMwUc3mG4O+sYUlhvV2/4MZud8s5b4vYtfPW43yFWatLUvx
	gTivrP1f8IIzgl1VBWYxnnprZKbiSLlNhTaL/9yssC1dyCBl8NZpcqjmuLx5L/h3gRG3dC
	dsi6EW4wp3qxKLbb3E5d7Wec9HFo0gOLOAwLfLHXqfSR+mzw+e7EvopDdS6IPFLKPT8WD/
	AuStwYPNTzqcj/VW7L3sI/VDxaLfbofXwJ1Jo3lhp4RLoOH5Rvv1uyfx6jq7Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765968994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmiNNm39PY3lOEnGS/ImNoK9FxpQFagWPPSY3MsK5l8=;
	b=CMmn+Paq2cupXFk+5XKwsBNZ+gqyZ+G2AMans2F6i5w7pBFndO3uu89PREmk0JeDGmfYbe
	aEdV3Aygutf2GtBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix faulty assertion in sched_change_end()
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216141725.GW3707837@noisy.programming.kicks-ass.net>
References: <20251216141725.GW3707837@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176596899373.510.17191516261088315233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1862d8e264def8425d682f1177e22f9fe7d947ea
Gitweb:        https://git.kernel.org/tip/1862d8e264def8425d682f1177e22f9fe7d=
947ea
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Dec 2025 11:24:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 11:41:18 +01:00

sched: Fix faulty assertion in sched_change_end()

Commit 47efe2ddccb1f ("sched/core: Add assertions to QUEUE_CLASS") added an
assert to sched_change_end() verifying that a class demotion would result in a
reschedule.

As it turns out; rt_mutex_setprio() does not force a resched on class
demontion. Furthermore, this is only relevant to running tasks.

Change the warning into a reschedule and make sure to only do so for running
tasks.

Fixes: 47efe2ddccb1f ("sched/core: Add assertions to QUEUE_CLASS")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by:  Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251216141725.GW3707837@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/core.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d0a862..5b17d8e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10833,23 +10833,24 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		if (p->sched_class->switched_to)
 			p->sched_class->switched_to(rq, p);
=20
-		/*
-		 * If this was a class promotion; let the old class know it
-		 * got preempted. Note that none of the switch*_from() methods
-		 * know the new class and none of the switch*_to() methods
-		 * know the old class.
-		 */
-		if (ctx->running && sched_class_above(p->sched_class, ctx->class)) {
-			rq->next_class->wakeup_preempt(rq, p, 0);
-			rq->next_class =3D p->sched_class;
+		if (ctx->running) {
+			/*
+			 * If this was a class promotion; let the old class
+			 * know it got preempted. Note that none of the
+			 * switch*_from() methods know the new class and none
+			 * of the switch*_to() methods know the old class.
+			 */
+			if (sched_class_above(p->sched_class, ctx->class)) {
+				rq->next_class->wakeup_preempt(rq, p, 0);
+				rq->next_class =3D p->sched_class;
+			}
+			/*
+			 * If this was a degradation in class; make sure to
+			 * reschedule.
+			 */
+			if (sched_class_above(ctx->class, p->sched_class))
+				resched_curr(rq);
 		}
-
-		/*
-		 * If this was a degradation in class someone should have set
-		 * need_resched by now.
-		 */
-		WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
-			     !test_tsk_need_resched(p));
 	} else {
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}

