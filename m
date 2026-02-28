Return-Path: <linux-tip-commits+bounces-8295-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGD1IFMMo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8295-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:40:03 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D915D1C408F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66443164A16
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08347D920;
	Sat, 28 Feb 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rbh9n7Yb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QwrR4lX0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0547CC9A;
	Sat, 28 Feb 2026 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292985; cv=none; b=VY8CeCvWctCiLlbBCB4y6YrbRGbAXeA+ggGWqHXQ7Y/kmhcCqwMu6IN0UTjmLVNplP9Mm0zcyfNj3f2C48LS2i8F0ZHOY6kMvIL/9IRdF8a2CtMo5ZO+uv3uxt3OW1aaaah1PUuv/cICuYliu2BjhelRAvPCeIge5Hrbb38z+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292985; c=relaxed/simple;
	bh=ZKlewoCZIDVANipnPwELMwsnW1DjDIkKHLC+LBFwbq4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ut3MFxet/sFJHFzfpJAYmM3yCrh7WgQN62MMfI0p5ZQyocyyap+m4NSKVu1XLOgnCAyB5v9c3YMhsuqhmrXwCXrSG5ObIRY6azSIc3RBDBEa1qOq92iibTdEsP4TSE6d+zW6dUIvtYqnvkADK3np+zOqbGdTKylnX/ZX0e9/XiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rbh9n7Yb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QwrR4lX0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r/+qZ/zZG7JfheB18AXVAHnIxBZ8Ry7yp1I1LM0Cz8=;
	b=Rbh9n7Yb3mPhdNEj6RDhd10ebZMBFNpVoSREjM1L4pydtqVUsFOCSVIm+l1ssvxX+CDr0c
	HPMxW07WF2XKfhx4Tn8JlIig26X8/6UDzELhdZbWJJv4X5vuPCihzXyRwlgy5em3aGAHP6
	2Thx9oWlYSwxH9vq7ldPviDFCLBZFzu8krwhNF25n2NxxP6bW1pjeUNtsF/HlJACwPpFKx
	9/MjF0RWqHulmxWDXi10Z3PPyMfhal6rLf7BdQUZl1DtDFP1oBK8OvYkX1t8aF1TuyZCNf
	Hc5UzLPY86DIFOY3fuWa9cSuzWIDBfTSLodYgJnslqMZEqNme9dTDEzy08hdwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r/+qZ/zZG7JfheB18AXVAHnIxBZ8Ry7yp1I1LM0Cz8=;
	b=QwrR4lX0NVSqxFrDj8oTBqVGccni84TNjqhKspKPPjZkKRtGno6ElT8wr/uD5t6KHst6co
	ixQOgTh7YFe2OCBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Keep track of first expiring timer per
 clock base
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.404839710@kernel.org>
References: <20260224163431.404839710@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298083.1647592.8117193284060087461.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8295-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: D915D1C408F
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     eddffab8282e388dddf032f3295fcec87eb08095
Gitweb:        https://git.kernel.org/tip/eddffab8282e388dddf032f3295fcec87eb=
08095
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:14 +01:00

hrtimer: Keep track of first expiring timer per clock base

Evaluating the next expiry time of all clock bases is cache line expensive
as the expiry time of the first expiring timer is not cached in the base
and requires to access the timer itself, which is definitely in a different
cache line.

It's way more efficient to keep track of the expiry time on enqueue and
dequeue operations as the relevant data is already in the cache at that
point.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.404839710@kernel.org
---
 include/linux/hrtimer_defs.h |  2 ++-
 kernel/time/hrtimer.c        | 37 ++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index b6846ef..fb38df4 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -19,6 +19,7 @@
  *			timer to a base on another cpu.
  * @clockid:		clock id for per_cpu support
  * @seq:		seqcount around __run_hrtimer
+ * @expires_next:	Absolute time of the next event in this clock base
  * @running:		pointer to the currently running hrtimer
  * @active:		red black tree root node for the active timers
  * @offset:		offset of this clock to the monotonic base
@@ -28,6 +29,7 @@ struct hrtimer_clock_base {
 	unsigned int		index;
 	clockid_t		clockid;
 	seqcount_raw_spinlock_t	seq;
+	ktime_t			expires_next;
 	struct hrtimer		*running;
 	struct timerqueue_head	active;
 	ktime_t			offset;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e9592cb..d70899a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1107,7 +1107,18 @@ static bool enqueue_hrtimer(struct hrtimer *timer, str=
uct hrtimer_clock_base *ba
 	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->is_queued, HRTIMER_STATE_ENQUEUED);
=20
-	return timerqueue_add(&base->active, &timer->node);
+	if (!timerqueue_add(&base->active, &timer->node))
+		return false;
+
+	base->expires_next =3D hrtimer_get_expires(timer);
+	return true;
+}
+
+static inline void base_update_next_timer(struct hrtimer_clock_base *base)
+{
+	struct timerqueue_node *next =3D timerqueue_getnext(&base->active);
+
+	base->expires_next =3D next ? next->expires : KTIME_MAX;
 }
=20
 /*
@@ -1122,6 +1133,7 @@ static void __remove_hrtimer(struct hrtimer *timer, str=
uct hrtimer_clock_base *b
 			     bool newstate, bool reprogram)
 {
 	struct hrtimer_cpu_base *cpu_base =3D base->cpu_base;
+	bool was_first;
=20
 	lockdep_assert_held(&cpu_base->lock);
=20
@@ -1131,9 +1143,17 @@ static void __remove_hrtimer(struct hrtimer *timer, st=
ruct hrtimer_clock_base *b
 	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->is_queued, newstate);
=20
+	was_first =3D &timer->node =3D=3D timerqueue_getnext(&base->active);
+
 	if (!timerqueue_del(&base->active, &timer->node))
 		cpu_base->active_bases &=3D ~(1 << base->index);
=20
+	/* Nothing to update if this was not the first timer in the base */
+	if (!was_first)
+		return;
+
+	base_update_next_timer(base);
+
 	/*
 	 * If reprogram is false don't update cpu_base->next_timer and do not
 	 * touch the clock event device.
@@ -1182,9 +1202,12 @@ static inline bool
 remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_bas=
e *base,
 			     const enum hrtimer_mode mode, ktime_t expires, u64 delta_ns)
 {
+	bool was_first =3D false;
+
 	/* Remove it from the timer queue if active */
 	if (timer->is_queued) {
 		debug_hrtimer_deactivate(timer);
+		was_first =3D &timer->node =3D=3D timerqueue_getnext(&base->active);
 		timerqueue_del(&base->active, &timer->node);
 	}
=20
@@ -1197,8 +1220,16 @@ remove_and_enqueue_same_base(struct hrtimer *timer, st=
ruct hrtimer_clock_base *b
 	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->is_queued, HRTIMER_STATE_ENQUEUED);
=20
-	/* Returns true if this is the first expiring timer */
-	return timerqueue_add(&base->active, &timer->node);
+	/* If it's the first expiring timer now or again, update base */
+	if (timerqueue_add(&base->active, &timer->node)) {
+		base->expires_next =3D expires;
+		return true;
+	}
+
+	if (was_first)
+		base_update_next_timer(base);
+
+	return false;
 }
=20
 static inline ktime_t hrtimer_update_lowres(struct hrtimer *timer, ktime_t t=
im,

