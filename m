Return-Path: <linux-tip-commits+bounces-8307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DN/KOANo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:40 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DF71C41B6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0AA31AA444
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301547ECD0;
	Sat, 28 Feb 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zW9Tt5av";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjGoxxDG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4247DD4B;
	Sat, 28 Feb 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292999; cv=none; b=QKRt+uFFhNzFtcz62S6g6fo/4/feFuxWuqXKZiSPmoPDdLnEVQgBmkWvz/FX9lFlVvbJ35QS5nPLv7OALi3C6/6GldZtVdAQVGW+SRvUTJ3LtMRygF5VcM9d1lMRjJPKBo7OtlOtqznhCG6Qz+v8eoh1hYm+aJGOdCkcV/WUFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292999; c=relaxed/simple;
	bh=zcnDDG7E3KeV4znpB8sGU5OwQwe9AMlakNp3BTbWAXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=njIAGlKZgtIZJYezextBXCylCoJp0TOkxAwR84O5bK777Ims8CPhKurMSGbDsH3v9p2YZjPHeNUw7h1TLSZEqvzoMC1aQ74CXw2K+dtMcbtP1XREn5Txgr4ZBrBocFm2H5gNZZvW1FA4eoy25dYiRU1GFA1TiWRdgVcAAvF0qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zW9Tt5av; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjGoxxDG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ6miYtTNGTD/Kv71aR1NevKv/GDrVlj3BPXu7E6yEw=;
	b=zW9Tt5avNgVzuUvmTrCeIylG/C0P2i4QKZc8W5dM8lNAhOTUNOa5YOCfBh+0alRreoFrTX
	0M7LLaVw6/f46JLtJbT+iUEgM9p9NzCANtBqvz6urBwEyO2WHaxD8Cq41ezq7cBY6oElBT
	vSBIjoIQpSmYj5OsZnyV8ImNW+EE7IJnlW3oR1GxyBgnt8WzZPbncvfrvdSTyVkW0DUSM2
	B4dtWu9jrB9R97Iv4PhleigTnuPZCbJtWGluOdFdOx/KiJzjJDwAXYuctaQJr3ovUyCyQb
	pOAVhDf89kYKsEy/lLBI0fDtZ236y/2qCielospq+JH4p36wyYCLcyKSbZm+OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ6miYtTNGTD/Kv71aR1NevKv/GDrVlj3BPXu7E6yEw=;
	b=CjGoxxDGug2Zah/40F/OLfZTboaouae1H30gJvFt/PV8UuUQs8bEXz0izEcqrkH0zmNZlp
	1znvOmTHOgepqzBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Convert state and properties to boolean
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.542427240@kernel.org>
References: <20260224163430.542427240@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299516.1647592.9932438678146597759.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8307-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 05DF71C41B6
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     22f011be7aaa77ca8f502b9dd07b7334f9965d18
Gitweb:        https://git.kernel.org/tip/22f011be7aaa77ca8f502b9dd07b7334f99=
65d18
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:11 +01:00

hrtimer: Convert state and properties to boolean

All 'u8' flags are true booleans, so make it entirely clear that these can
only contain true or false.

This is especially true for hrtimer::state, which has a historical leftover
of using the state with bitwise operations. That was used in the early
hrtimer implementation with several bits, but then converted to a boolean
state. But that conversion missed to replace the bit OR and bit check
operations all over the place, which creates suboptimal code. As of today
'state' is a misnomer because it's only purpose is to reflect whether the
timer is enqueued into the RB-tree or not. Rename it to 'is_queued' and
make all operations on it boolean.

This reduces text size from 8926 to 8732 bytes.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.542427240@kernel.org
---
 include/linux/hrtimer.h       | 31 +-----------------
 include/linux/hrtimer_types.h | 12 +++----
 kernel/time/hrtimer.c         | 58 +++++++++++++++++++++++-----------
 kernel/time/timer_list.c      |  2 +-
 4 files changed, 49 insertions(+), 54 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c924bb2..4ad4a45 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -63,33 +63,6 @@ enum hrtimer_mode {
 	HRTIMER_MODE_REL_PINNED_HARD =3D HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HAR=
D,
 };
=20
-/*
- * Values to track state of the timer
- *
- * Possible states:
- *
- * 0x00		inactive
- * 0x01		enqueued into rbtree
- *
- * The callback state is not part of the timer->state because clearing it wo=
uld
- * mean touching the timer after the callback, this makes it impossible to f=
ree
- * the timer from the callback function.
- *
- * Therefore we track the callback state in:
- *
- *	timer->base->cpu_base->running =3D=3D timer
- *
- * On SMP it is possible to have a "callback function running and enqueued"
- * status. It happens for example when a posix timer expired and the callback
- * queued a signal. Between dropping the lock which protects the posix timer
- * and reacquiring the base lock of the hrtimer, another CPU can deliver the
- * signal and rearm the timer.
- *
- * All state transitions are protected by cpu_base->lock.
- */
-#define HRTIMER_STATE_INACTIVE	0x00
-#define HRTIMER_STATE_ENQUEUED	0x01
-
 /**
  * struct hrtimer_sleeper - simple sleeper structure
  * @timer:	embedded timer structure
@@ -300,8 +273,8 @@ extern bool hrtimer_active(const struct hrtimer *timer);
  */
 static inline bool hrtimer_is_queued(struct hrtimer *timer)
 {
-	/* The READ_ONCE pairs with the update functions of timer->state */
-	return !!(READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED);
+	/* The READ_ONCE pairs with the update functions of timer->is_queued */
+	return READ_ONCE(timer->is_queued);
 }
=20
 /*
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index 64381c6..0e22bc9 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -28,7 +28,7 @@ enum hrtimer_restart {
  *		was armed.
  * @function:	timer expiry callback function
  * @base:	pointer to the timer base (per cpu and per clock)
- * @state:	state information (See bit values above)
+ * @is_queued:	Indicates whether a timer is enqueued or not
  * @is_rel:	Set if the timer was armed relative
  * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
  * @is_hard:	Set if hrtimer will be expired in hard interrupt context
@@ -43,11 +43,11 @@ struct hrtimer {
 	ktime_t				_softexpires;
 	enum hrtimer_restart		(*__private function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
-	u8				state;
-	u8				is_rel;
-	u8				is_soft;
-	u8				is_hard;
-	u8				is_lazy;
+	bool				is_queued;
+	bool				is_rel;
+	bool				is_soft;
+	bool				is_hard;
+	bool				is_lazy;
 };
=20
 #endif /* _LINUX_HRTIMER_TYPES_H */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3b80a44..6bab3b7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -50,6 +50,28 @@
 #include "tick-internal.h"
=20
 /*
+ * Constants to set the queued state of the timer (INACTIVE, ENQUEUED)
+ *
+ * The callback state is kept separate in the CPU base because having it in
+ * the timer would required touching the timer after the callback, which
+ * makes it impossible to free the timer from the callback function.
+ *
+ * Therefore we track the callback state in:
+ *
+ *	timer->base->cpu_base->running =3D=3D timer
+ *
+ * On SMP it is possible to have a "callback function running and enqueued"
+ * status. It happens for example when a posix timer expired and the callback
+ * queued a signal. Between dropping the lock which protects the posix timer
+ * and reacquiring the base lock of the hrtimer, another CPU can deliver the
+ * signal and rearm the timer.
+ *
+ * All state transitions are protected by cpu_base->lock.
+ */
+#define HRTIMER_STATE_INACTIVE	false
+#define HRTIMER_STATE_ENQUEUED	true
+
+/*
  * The resolution of the clocks. The resolution value is returned in
  * the clock_getres() system call to give application programmers an
  * idea of the (in)accuracy of timers. Timer values are rounded up to
@@ -1038,7 +1060,7 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now,=
 ktime_t interval)
 	if (delta < 0)
 		return 0;
=20
-	if (WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED))
+	if (WARN_ON(timer->is_queued))
 		return 0;
=20
 	if (interval < hrtimer_resolution)
@@ -1082,7 +1104,7 @@ static bool enqueue_hrtimer(struct hrtimer *timer, stru=
ct hrtimer_clock_base *ba
 	base->cpu_base->active_bases |=3D 1 << base->index;
=20
 	/* Pairs with the lockless read in hrtimer_is_queued() */
-	WRITE_ONCE(timer->state, HRTIMER_STATE_ENQUEUED);
+	WRITE_ONCE(timer->is_queued, HRTIMER_STATE_ENQUEUED);
=20
 	return timerqueue_add(&base->active, &timer->node);
 }
@@ -1096,18 +1118,18 @@ static bool enqueue_hrtimer(struct hrtimer *timer, st=
ruct hrtimer_clock_base *ba
  * anyway (e.g. timer interrupt)
  */
 static void __remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_bas=
e *base,
-			     u8 newstate, bool reprogram)
+			     bool newstate, bool reprogram)
 {
 	struct hrtimer_cpu_base *cpu_base =3D base->cpu_base;
-	u8 state =3D timer->state;
=20
 	lockdep_assert_held(&cpu_base->lock);
=20
-	/* Pairs with the lockless read in hrtimer_is_queued() */
-	WRITE_ONCE(timer->state, newstate);
-	if (!(state & HRTIMER_STATE_ENQUEUED))
+	if (!timer->is_queued)
 		return;
=20
+	/* Pairs with the lockless read in hrtimer_is_queued() */
+	WRITE_ONCE(timer->is_queued, newstate);
+
 	if (!timerqueue_del(&base->active, &timer->node))
 		cpu_base->active_bases &=3D ~(1 << base->index);
=20
@@ -1127,11 +1149,11 @@ static void __remove_hrtimer(struct hrtimer *timer, s=
truct hrtimer_clock_base *b
 static inline bool remove_hrtimer(struct hrtimer *timer, struct hrtimer_cloc=
k_base *base,
 				 bool restart, bool keep_local)
 {
-	u8 state =3D timer->state;
+	bool queued_state =3D timer->is_queued;
=20
 	lockdep_assert_held(&base->cpu_base->lock);
=20
-	if (state & HRTIMER_STATE_ENQUEUED) {
+	if (queued_state) {
 		bool reprogram;
=20
 		debug_hrtimer_deactivate(timer);
@@ -1153,11 +1175,11 @@ static inline bool remove_hrtimer(struct hrtimer *tim=
er, struct hrtimer_clock_ba
 		 * and a moment later when it's requeued).
 		 */
 		if (!restart)
-			state =3D HRTIMER_STATE_INACTIVE;
+			queued_state =3D HRTIMER_STATE_INACTIVE;
 		else
 			reprogram &=3D !keep_local;
=20
-		__remove_hrtimer(timer, base, state, reprogram);
+		__remove_hrtimer(timer, base, queued_state, reprogram);
 		return true;
 	}
 	return false;
@@ -1704,7 +1726,7 @@ bool hrtimer_active(const struct hrtimer *timer)
 		base =3D READ_ONCE(timer->base);
 		seq =3D raw_read_seqcount_begin(&base->seq);
=20
-		if (timer->state !=3D HRTIMER_STATE_INACTIVE || base->running =3D=3D timer)
+		if (timer->is_queued || base->running =3D=3D timer)
 			return true;
=20
 	} while (read_seqcount_retry(&base->seq, seq) || base !=3D READ_ONCE(timer-=
>base));
@@ -1721,7 +1743,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
  *  - callback:	the timer is being ran
  *  - post:	the timer is inactive or (re)queued
  *
- * On the read side we ensure we observe timer->state and cpu_base->running
+ * On the read side we ensure we observe timer->is_queued and cpu_base->runn=
ing
  * from the same section, if anything changed while we looked at it, we retr=
y.
  * This includes timer->base changing because sequence numbers alone are
  * insufficient for that.
@@ -1744,11 +1766,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cp=
u_base, struct hrtimer_cloc
 	base->running =3D timer;
=20
 	/*
-	 * Separate the ->running assignment from the ->state assignment.
+	 * Separate the ->running assignment from the ->is_queued assignment.
 	 *
 	 * As with a regular write barrier, this ensures the read side in
 	 * hrtimer_active() cannot observe base->running =3D=3D NULL &&
-	 * timer->state =3D=3D INACTIVE.
+	 * timer->is_queued =3D=3D INACTIVE.
 	 */
 	raw_write_seqcount_barrier(&base->seq);
=20
@@ -1787,15 +1809,15 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cp=
u_base, struct hrtimer_cloc
 	 * hrtimer_start_range_ns() can have popped in and enqueued the timer
 	 * for us already.
 	 */
-	if (restart !=3D HRTIMER_NORESTART && !(timer->state & HRTIMER_STATE_ENQUEU=
ED))
+	if (restart =3D=3D HRTIMER_RESTART && !timer->is_queued)
 		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS, false);
=20
 	/*
-	 * Separate the ->running assignment from the ->state assignment.
+	 * Separate the ->running assignment from the ->is_queued assignment.
 	 *
 	 * As with a regular write barrier, this ensures the read side in
 	 * hrtimer_active() cannot observe base->running.timer =3D=3D NULL &&
-	 * timer->state =3D=3D INACTIVE.
+	 * timer->is_queued =3D=3D INACTIVE.
 	 */
 	raw_write_seqcount_barrier(&base->seq);
=20
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 488e47e..19e6182 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -47,7 +47,7 @@ print_timer(struct seq_file *m, struct hrtimer *taddr, stru=
ct hrtimer *timer,
 	    int idx, u64 now)
 {
 	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, ACCESS_PRIVATE(timer, function=
));
-	SEQ_printf(m, ", S:%02x", timer->state);
+	SEQ_printf(m, ", S:%02x", timer->is_queued);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
 		(unsigned long long)ktime_to_ns(hrtimer_get_softexpires(timer)),

