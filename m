Return-Path: <linux-tip-commits+bounces-8327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB57IqYNo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:42 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E41C4184
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDA9316C83D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762C480DD3;
	Sat, 28 Feb 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B6J5empW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4UeZEUB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE06480DE0;
	Sat, 28 Feb 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293024; cv=none; b=pKjqytvZ1VCVIYtd+K5AwJBa2dfJq1q7s9I7iA2hA+ui9O+eUBLMterjxbEuibXnpn99RA8uSICbIkAnlCFH4FTlblMPx1yNDiNZK13niGzXRgeHVJJEfE4Z7nBVOvpgWqiyk451TRIL+rjcCQME0F0A01QHFYVAqZ52taafKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293024; c=relaxed/simple;
	bh=fiNfqY14CUuFgsabkwqccLB8Wa5PyMsR5f4ye4YM3K4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y3u8z/NO23Dvlpn3brhe9Pjz2ZcgoVwZDK18Xnas69v52ygpL8KPN8kwP5nxOD+1Oqq0X9zghGnLyFmoWxIwwDdjcZrbpQIqSJDV7RpXvC6DYBoQCo4Agpy4z4f/Erb88JQMhY1KgnXPSjKBT5IpQB6VQOFnDPObN3R6fkLncxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B6J5empW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4UeZEUB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+zNqQN2hJ3/pokqQOG68dLTEZVCrOFoa3jRIvg+Nfw=;
	b=B6J5empWHB/7IgbvXUq4PC+AY7l0ZnH0xDoBRgvHmcWWiY2Oo0k7/5n5KWaVe/cZBfIQia
	eGCS4tdajMPCwMy75/zHn1BLiJzZP+eAcC0LF9T4Q2+oO+4NshUGveSEVvFHcBks8JX7Mq
	DKjXx3cPo1gAZd+REUZ23nOGZv/qTuoBFaBraeBZG7kgE5rlwLB4QbW/0uPjk2AgCXNDIo
	zvUYd5Pu6B0PhF11c8RILr4cxkpXvTSXVE4gS9y1twTiA3kUk3ea4kdYGxvocol/SXRGhh
	88Js9gc136b9iUYBh1YFRotzjhxqolmMWmcK8TXgYKs4tyhx9n8vo7R8OuC87g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+zNqQN2hJ3/pokqQOG68dLTEZVCrOFoa3jRIvg+Nfw=;
	b=s4UeZEUBpzl1r4w+B5axhZEyHiRpTjmAn9GK1igkPS4Dq5qqi52WsqEvw1y8g/rUQ0qAGy
	Ax8tXL2RX34H5TCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched: Optimize hrtimer handling
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.273068659@kernel.org>
References: <20260224163429.273068659@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301602.1647592.3646056175841364185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8327-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 249E41C4184
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     96d1610e0b20b5a627773874b4514ae922ad98f6
Gitweb:        https://git.kernel.org/tip/96d1610e0b20b5a627773874b4514ae922a=
d98f6
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:05 +01:00

sched: Optimize hrtimer handling

schedule() provides several mechanisms to update the hrtick timer:

  1) When the next task is picked

  2) When the balance callbacks are invoked before rq::lock is released

Each of them can result in a first expiring timer and cause a reprogram of
the clock event device.

Solve this by deferring the rearm to the end of schedule() right before
releasing rq::lock by setting a flag on entry which tells hrtick_start() to
cache the runtime constraint in rq::hrtick_delay without touching the timer
itself.

Right before releasing rq::lock evaluate the flags and either rearm or
cancel the hrtick timer.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.273068659@kernel.org
---
 kernel/sched/core.c  | 57 ++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h |  2 ++-
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a716cc6..a868f0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -872,6 +872,12 @@ void update_rq_clock(struct rq *rq)
  * Use HR-timers to deliver accurate preemption points.
  */
=20
+enum {
+	HRTICK_SCHED_NONE		=3D 0,
+	HRTICK_SCHED_DEFER		=3D BIT(1),
+	HRTICK_SCHED_START		=3D BIT(2),
+};
+
 static void hrtick_clear(struct rq *rq)
 {
 	if (hrtimer_active(&rq->hrtick_timer))
@@ -932,6 +938,17 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 * doesn't make sense and can cause timer DoS.
 	 */
 	delta =3D max_t(s64, delay, 10000LL);
+
+	/*
+	 * If this is in the middle of schedule() only note the delay
+	 * and let hrtick_schedule_exit() deal with it.
+	 */
+	if (rq->hrtick_sched) {
+		rq->hrtick_sched |=3D HRTICK_SCHED_START;
+		rq->hrtick_delay =3D delta;
+		return;
+	}
+
 	rq->hrtick_time =3D ktime_add_ns(ktime_get(), delta);
=20
 	if (rq =3D=3D this_rq())
@@ -940,19 +957,40 @@ void hrtick_start(struct rq *rq, u64 delay)
 		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
 }
=20
-static void hrtick_rq_init(struct rq *rq)
+static inline void hrtick_schedule_enter(struct rq *rq)
 {
-	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
-	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_=
HARD);
+	rq->hrtick_sched =3D HRTICK_SCHED_DEFER;
 }
-#else /* !CONFIG_SCHED_HRTICK: */
-static inline void hrtick_clear(struct rq *rq)
+
+static inline void hrtick_schedule_exit(struct rq *rq)
 {
+	if (rq->hrtick_sched & HRTICK_SCHED_START) {
+		rq->hrtick_time =3D ktime_add_ns(ktime_get(), rq->hrtick_delay);
+		__hrtick_restart(rq);
+	} else if (idle_rq(rq)) {
+		/*
+		 * No need for using hrtimer_is_active(). The timer is CPU local
+		 * and interrupts are disabled, so the callback cannot be
+		 * running and the queued state is valid.
+		 */
+		if (hrtimer_is_queued(&rq->hrtick_timer))
+			hrtimer_cancel(&rq->hrtick_timer);
+	}
+
+	rq->hrtick_sched =3D HRTICK_SCHED_NONE;
 }
=20
-static inline void hrtick_rq_init(struct rq *rq)
+static void hrtick_rq_init(struct rq *rq)
 {
+	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
+	rq->hrtick_sched =3D HRTICK_SCHED_NONE;
+	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_=
HARD);
 }
+#else /* !CONFIG_SCHED_HRTICK: */
+static inline void hrtick_clear(struct rq *rq) { }
+static inline void hrtick_rq_init(struct rq *rq) { }
+static inline void hrtick_schedule_enter(struct rq *rq) { }
+static inline void hrtick_schedule_exit(struct rq *rq) { }
 #endif /* !CONFIG_SCHED_HRTICK */
=20
 /*
@@ -5028,6 +5066,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
 	__balance_callbacks(rq, NULL);
+	hrtick_schedule_exit(rq);
 	raw_spin_rq_unlock_irq(rq);
 }
=20
@@ -6781,9 +6820,6 @@ static void __sched notrace __schedule(int sched_mode)
=20
 	schedule_debug(prev, preempt);
=20
-	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
-		hrtick_clear(rq);
-
 	klp_sched_try_switch(prev);
=20
 	local_irq_disable();
@@ -6810,6 +6846,8 @@ static void __sched notrace __schedule(int sched_mode)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
=20
+	hrtick_schedule_enter(rq);
+
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<=3D 1;
 	update_rq_clock(rq);
@@ -6911,6 +6949,7 @@ keep_resched:
=20
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq, NULL);
+		hrtick_schedule_exit(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
 	trace_sched_exit_tp(is_switch);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0aa089d..6774fb5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1285,6 +1285,8 @@ struct rq {
 	call_single_data_t	hrtick_csd;
 	struct hrtimer		hrtick_timer;
 	ktime_t			hrtick_time;
+	ktime_t			hrtick_delay;
+	unsigned int		hrtick_sched;
 #endif
=20
 #ifdef CONFIG_SCHEDSTATS

