Return-Path: <linux-tip-commits+bounces-8305-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCKNAwsNo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8305-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:43:07 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A892E1C410B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFD33128FF3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7047DD4A;
	Sat, 28 Feb 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wC1vvwuh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGZ+2ZWj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AD47DFB6;
	Sat, 28 Feb 2026 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292997; cv=none; b=fEXkEh0TvGnQI8CAY7TfkkC/NWr/lHPvB4qX8JjvmXRrhlwZiM9nWkdfPIyV9GGUqZyZ44NPMg4cp1dxsMTh2h8840IqCZW5MCF9FQEtQvilZjXk7HyxkX2gYHWASd8FS1aep7y0EXkT8XJFggz+jHyWJJxLJ+uNrYGol2eHIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292997; c=relaxed/simple;
	bh=9SXUbjY//gWX0T5DrgpKviRO9kyadvNDPYH0SQtREEs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oozKauomeFmLIvk6F/ByhPKW7qC4t9fOuOQr6NpJVztnp5nOUUqEvIGFPcDnDJiEtzLBnHXxjPyW6ShUvaRp4rlreoecg6BpUC6wuQLMYkyugqVHFFIvOKQplHB775gONnf7j1g06YlxZ7MdPBlQu7wmu5mGKeIrA3KGhy1R4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wC1vvwuh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGZ+2ZWj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AhvJewfMwaLTqTrgx4L44BOlZ58Pv5G1QThcCsgqns=;
	b=wC1vvwuhkZ7vSJAyBYs9OeyGp3gCMbRFW+m0SDaHF692Ojuvo63w0sUzA7roMSp0JICALB
	KTK43osmXUAizMM2f2R1bLMtrGlPmDLF9Yqy8+h2/abU77FwJi6sbGV0w2jnvyblY5olVY
	2JximMfsgNSOln4CgdnQHlaluanbPSMnxI2eOASnm/pStMIpBLiQF6e5k+K086RwbunUGF
	ITlvQ7knvjFvmoJ9RWsDkauOg2RfwbUTAA/J+mZLMxe47WFroqIMX6hYOmRE7d8KjyI7pC
	D22ASuRJfhUjhYxzawp7uSFMNhqmrdLCNjAb1/Lq5Z7udJxYNeJ5bTJKXy/wOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AhvJewfMwaLTqTrgx4L44BOlZ58Pv5G1QThcCsgqns=;
	b=gGZ+2ZWjbq28XVKEOQN5gBCLoG1MdrEP80wyBfKWvJ18krQ+7JCiDQkCi8kGwFuXykOA6d
	cnXmOnBkboawmFDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Separate remove/enqueue handling for
 local timers
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.737600486@kernel.org>
References: <20260224163430.737600486@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299177.1647592.8921298442971811711.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8305-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: A892E1C410B
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     85a690d1c19cc266eed74ec3fcdaacadc03ed1b2
Gitweb:        https://git.kernel.org/tip/85a690d1c19cc266eed74ec3fcdaacadc03=
ed1b2
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:11 +01:00

hrtimer: Separate remove/enqueue handling for local timers

As the base switch can be avoided completely when the base stays the same
the remove/enqueue handling can be more streamlined.

Split it out into a separate function which handles both in one go which is
way more efficient and makes the code simpler to follow.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.737600486@kernel.org
---
 kernel/time/hrtimer.c | 72 +++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4caf2df..c6fc164 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1147,13 +1147,11 @@ static void __remove_hrtimer(struct hrtimer *timer, s=
truct hrtimer_clock_base *b
 }
=20
 static inline bool remove_hrtimer(struct hrtimer *timer, struct hrtimer_cloc=
k_base *base,
-				 bool restart, bool keep_base)
+				  bool newstate)
 {
-	bool queued_state =3D timer->is_queued;
-
 	lockdep_assert_held(&base->cpu_base->lock);
=20
-	if (queued_state) {
+	if (timer->is_queued) {
 		bool reprogram;
=20
 		debug_hrtimer_deactivate(timer);
@@ -1168,23 +1166,35 @@ static inline bool remove_hrtimer(struct hrtimer *tim=
er, struct hrtimer_clock_ba
 		 */
 		reprogram =3D base->cpu_base =3D=3D this_cpu_ptr(&hrtimer_bases);
=20
-		/*
-		 * If the timer is not restarted then reprogramming is
-		 * required if the timer is local. If it is local and about
-		 * to be restarted, avoid programming it twice (on removal
-		 * and a moment later when it's requeued).
-		 */
-		if (!restart)
-			queued_state =3D HRTIMER_STATE_INACTIVE;
-		else
-			reprogram &=3D !keep_base;
-
-		__remove_hrtimer(timer, base, queued_state, reprogram);
+		__remove_hrtimer(timer, base, newstate, reprogram);
 		return true;
 	}
 	return false;
 }
=20
+static inline bool
+remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_bas=
e *base,
+			     const enum hrtimer_mode mode, ktime_t expires, u64 delta_ns)
+{
+	/* Remove it from the timer queue if active */
+	if (timer->is_queued) {
+		debug_hrtimer_deactivate(timer);
+		timerqueue_del(&base->active, &timer->node);
+	}
+
+	/* Set the new expiry time */
+	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
+
+	debug_activate(timer, mode, timer->is_queued);
+	base->cpu_base->active_bases |=3D 1 << base->index;
+
+	/* Pairs with the lockless read in hrtimer_is_queued() */
+	WRITE_ONCE(timer->is_queued, HRTIMER_STATE_ENQUEUED);
+
+	/* Returns true if this is the first expiring timer */
+	return timerqueue_add(&base->active, &timer->node);
+}
+
 static inline ktime_t hrtimer_update_lowres(struct hrtimer *timer, ktime_t t=
im,
 					    const enum hrtimer_mode mode)
 {
@@ -1267,7 +1277,7 @@ static bool __hrtimer_start_range_ns(struct hrtimer *ti=
mer, ktime_t tim, u64 del
 				     const enum hrtimer_mode mode, struct hrtimer_clock_base *base)
 {
 	struct hrtimer_cpu_base *this_cpu_base =3D this_cpu_ptr(&hrtimer_bases);
-	bool is_pinned, first, was_first, was_armed, keep_base =3D false;
+	bool is_pinned, first, was_first, keep_base =3D false;
 	struct hrtimer_cpu_base *cpu_base =3D base->cpu_base;
=20
 	was_first =3D cpu_base->next_timer =3D=3D timer;
@@ -1283,6 +1293,12 @@ static bool __hrtimer_start_range_ns(struct hrtimer *t=
imer, ktime_t tim, u64 del
 		keep_base =3D hrtimer_keep_base(timer, is_local, was_first, is_pinned);
 	}
=20
+	/* Calculate absolute expiry time for relative timers */
+	if (mode & HRTIMER_MODE_REL)
+		tim =3D ktime_add_safe(tim, __hrtimer_cb_get_time(base->clockid));
+	/* Compensate for low resolution granularity */
+	tim =3D hrtimer_update_lowres(timer, tim, mode);
+
 	/*
 	 * Remove an active timer from the queue. In case it is not queued
 	 * on the current CPU, make sure that remove_hrtimer() updates the
@@ -1297,22 +1313,20 @@ static bool __hrtimer_start_range_ns(struct hrtimer *=
timer, ktime_t tim, u64 del
 	 * @keep_base is also true if the timer callback is running on a
 	 * remote CPU and for local pinned timers.
 	 */
-	was_armed =3D remove_hrtimer(timer, base, true, keep_base);
-
-	if (mode & HRTIMER_MODE_REL)
-		tim =3D ktime_add_safe(tim, __hrtimer_cb_get_time(base->clockid));
-
-	tim =3D hrtimer_update_lowres(timer, tim, mode);
+	if (likely(keep_base)) {
+		first =3D remove_and_enqueue_same_base(timer, base, mode, tim, delta_ns);
+	} else {
+		/* Keep the ENQUEUED state in case it is queued */
+		bool was_armed =3D remove_hrtimer(timer, base, HRTIMER_STATE_ENQUEUED);
=20
-	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
+		hrtimer_set_expires_range_ns(timer, tim, delta_ns);
=20
-	/* Switch the timer base, if necessary: */
-	if (!keep_base) {
+		/* Switch the timer base, if necessary: */
 		base =3D switch_hrtimer_base(timer, base, is_pinned);
 		cpu_base =3D base->cpu_base;
-	}
=20
-	first =3D enqueue_hrtimer(timer, base, mode, was_armed);
+		first =3D enqueue_hrtimer(timer, base, mode, was_armed);
+	}
=20
 	/*
 	 * If the hrtimer interrupt is running, then it will reevaluate the
@@ -1432,7 +1446,7 @@ int hrtimer_try_to_cancel(struct hrtimer *timer)
 	base =3D lock_hrtimer_base(timer, &flags);
=20
 	if (!hrtimer_callback_running(timer)) {
-		ret =3D remove_hrtimer(timer, base, false, false);
+		ret =3D remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
 		if (ret)
 			trace_hrtimer_cancel(timer);
 	}

