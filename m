Return-Path: <linux-tip-commits+bounces-8315-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA3VJ0QNo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8315-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:04 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 061601C413A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01D7031B8288
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43C480355;
	Sat, 28 Feb 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cu7Vaz0t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+mF5MNBZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA147ECFD;
	Sat, 28 Feb 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293011; cv=none; b=L8swmy012PIMPvSp1VyOlNm2hLGARns1rRc/MP3TLyEqSlZsXHT0Mhg+uKQauI+AO+UdKX9YLORyAPcvddvBGniXBSmw7McM7MeIYwrPU8aNBmiYaLBFwZRAkzo5dY5+tmFqR9In1yGVxyCY6E4BcEc/fyi145SQDiFW95iJCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293011; c=relaxed/simple;
	bh=nlY1hzNXRrmJSb/QKkcYG9nO93iUcL4M+IFG7htWt0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hrSHBT81dv/0Ja95fuKImv2JZRNhCy/H6JdVqwcauNZgxE5+Vkfv0/I+rjDcLbsf9bFvd+vvSGz80tilpbTZ+gJgP8clqNWAgmsM8B/d6o15jTkDZU0Ezf0VSf0hYpJy8+Ur8NsIeYTlg4WDNtE+l2VtATqyOVm2Tjac74GnVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cu7Vaz0t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+mF5MNBZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=In6ZB9OojpKETKNG7KWIVu3nq2Q8bmOKJ0a5MaMQheE=;
	b=cu7Vaz0t3/461hnt5KzKJKll+MnNN87xnUINrkuVFPgN+54Nq6v8R5vt99FtUuQReilzH9
	J+uXAM0xH05jmFfYBoRElXqR+cza8X4QxBJatxP1xFehnn5d4f9UKME5/uyMuLOTHk2MMs
	4uuN2BcVzIMoF/XeWSAYrBE6Hxdn49S5XeWCjjzO3Sfi+TT6COLWUdIfC2FYwixSeMghhb
	2W0qA/y2Dd0d5U+6x9sHJR+06TxsClWZ6faVrYiE4zLQtMpnNFfmQJ/vuosWWI89oMJZyh
	cSLlYoqkqW5GBL0lR9dVVIEkjbNseKoYlgXdOZ3Q9p4aO1BXn6oPLoP6rGPkVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=In6ZB9OojpKETKNG7KWIVu3nq2Q8bmOKJ0a5MaMQheE=;
	b=+mF5MNBZypXg9QaswLrXU1ZB1W5TJtx7DCfDMnemFGv7TJ52ea4z9HCMqt0VPhmXYQvC3Q
	pptxtivHz9U1vEDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Reduce trace noise in hrtimer_start()
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.208491877@kernel.org>
References: <20260224163430.208491877@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300077.1647592.1242655313282705988.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8315-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 061601C413A
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     f2e388a019e4cf83a15883a3d1f1384298e9a6aa
Gitweb:        https://git.kernel.org/tip/f2e388a019e4cf83a15883a3d1f1384298e=
9a6aa
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:09 +01:00

hrtimer: Reduce trace noise in hrtimer_start()

hrtimer_start() when invoked with an already armed timer traces like:

 <comm>-..   [032] d.h2. 5.002263: hrtimer_cancel: hrtimer=3D ....
 <comm>-..   [032] d.h1. 5.002263: hrtimer_start: hrtimer=3D ....

Which is incorrect as the timer doesn't get canceled. Just the expiry time
changes. The internal dequeue operation which is required for that is not
really interesting for trace analysis. But it makes it tedious to keep real
cancellations and the above case apart.

Remove the cancel tracing in hrtimer_start() and add a 'was_armed'
indicator to the hrtimer start tracepoint, which clearly indicates what the
state of the hrtimer is when hrtimer_start() is invoked:

<comm>-..   [032] d.h1. 6.200103: hrtimer_start: hrtimer=3D .... was_armed=3D0
 <comm>-..   [032] d.h1. 6.200558: hrtimer_start: hrtimer=3D .... was_armed=
=3D1

Fixes: c6a2a1770245 ("hrtimer: Add tracepoint for hrtimers")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.208491877@kernel.org
---
 include/trace/events/timer.h | 11 +++++----
 kernel/time/hrtimer.c        | 43 ++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 1641ae3..ab9a938 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -218,12 +218,13 @@ TRACE_EVENT(hrtimer_setup,
  * hrtimer_start - called when the hrtimer is started
  * @hrtimer:	pointer to struct hrtimer
  * @mode:	the hrtimers mode
+ * @was_armed:	Was armed when hrtimer_start*() was invoked
  */
 TRACE_EVENT(hrtimer_start,
=20
-	TP_PROTO(struct hrtimer *hrtimer, enum hrtimer_mode mode),
+	TP_PROTO(struct hrtimer *hrtimer, enum hrtimer_mode mode, bool was_armed),
=20
-	TP_ARGS(hrtimer, mode),
+	TP_ARGS(hrtimer, mode, was_armed),
=20
 	TP_STRUCT__entry(
 		__field( void *,	hrtimer		)
@@ -231,6 +232,7 @@ TRACE_EVENT(hrtimer_start,
 		__field( s64,		expires		)
 		__field( s64,		softexpires	)
 		__field( enum hrtimer_mode,	mode	)
+		__field( bool,		was_armed	)
 	),
=20
 	TP_fast_assign(
@@ -239,13 +241,14 @@ TRACE_EVENT(hrtimer_start,
 		__entry->expires	=3D hrtimer_get_expires(hrtimer);
 		__entry->softexpires	=3D hrtimer_get_softexpires(hrtimer);
 		__entry->mode		=3D mode;
+		__entry->was_armed	=3D was_armed;
 	),
=20
 	TP_printk("hrtimer=3D%p function=3D%ps expires=3D%llu softexpires=3D%llu "
-		  "mode=3D%s", __entry->hrtimer, __entry->function,
+		  "mode=3D%s was_armed=3D%d", __entry->hrtimer, __entry->function,
 		  (unsigned long long) __entry->expires,
 		  (unsigned long long) __entry->softexpires,
-		  decode_hrtimer_mode(__entry->mode))
+		  decode_hrtimer_mode(__entry->mode), __entry->was_armed)
 );
=20
 /**
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index fa63e0b..6e4ac8d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -529,17 +529,10 @@ static inline void debug_setup_on_stack(struct hrtimer =
*timer, clockid_t clockid
 	trace_hrtimer_setup(timer, clockid, mode);
 }
=20
-static inline void debug_activate(struct hrtimer *timer,
-				  enum hrtimer_mode mode)
+static inline void debug_activate(struct hrtimer *timer, enum hrtimer_mode m=
ode, bool was_armed)
 {
 	debug_hrtimer_activate(timer, mode);
-	trace_hrtimer_start(timer, mode);
-}
-
-static inline void debug_deactivate(struct hrtimer *timer)
-{
-	debug_hrtimer_deactivate(timer);
-	trace_hrtimer_cancel(timer);
+	trace_hrtimer_start(timer, mode, was_armed);
 }
=20
 static struct hrtimer_clock_base *
@@ -1137,9 +1130,9 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
  * Returns true when the new timer is the leftmost timer in the tree.
  */
 static bool enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base=
 *base,
-			    enum hrtimer_mode mode)
+			    enum hrtimer_mode mode, bool was_armed)
 {
-	debug_activate(timer, mode);
+	debug_activate(timer, mode, was_armed);
 	WARN_ON_ONCE(!base->cpu_base->online);
=20
 	base->cpu_base->active_bases |=3D 1 << base->index;
@@ -1199,6 +1192,8 @@ remove_hrtimer(struct hrtimer *timer, struct hrtimer_cl=
ock_base *base,
 	if (state & HRTIMER_STATE_ENQUEUED) {
 		bool reprogram;
=20
+		debug_hrtimer_deactivate(timer);
+
 		/*
 		 * Remove the timer and force reprogramming when high
 		 * resolution mode is active and the timer is on the current
@@ -1207,7 +1202,6 @@ remove_hrtimer(struct hrtimer *timer, struct hrtimer_cl=
ock_base *base,
 		 * reprogramming happens in the interrupt handler. This is a
 		 * rare case and less expensive than a smp call.
 		 */
-		debug_deactivate(timer);
 		reprogram =3D base->cpu_base =3D=3D this_cpu_ptr(&hrtimer_bases);
=20
 		/*
@@ -1274,15 +1268,15 @@ static int __hrtimer_start_range_ns(struct hrtimer *t=
imer, ktime_t tim,
 {
 	struct hrtimer_cpu_base *this_cpu_base =3D this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
-	bool force_local, first;
+	bool force_local, first, was_armed;
=20
 	/*
 	 * If the timer is on the local cpu base and is the first expiring
 	 * timer then this might end up reprogramming the hardware twice
-	 * (on removal and on enqueue). To avoid that by prevent the
-	 * reprogram on removal, keep the timer local to the current CPU
-	 * and enforce reprogramming after it is queued no matter whether
-	 * it is the new first expiring timer again or not.
+	 * (on removal and on enqueue). To avoid that prevent the reprogram
+	 * on removal, keep the timer local to the current CPU and enforce
+	 * reprogramming after it is queued no matter whether it is the new
+	 * first expiring timer again or not.
 	 */
 	force_local =3D base->cpu_base =3D=3D this_cpu_base;
 	force_local &=3D base->cpu_base->next_timer =3D=3D timer;
@@ -1304,7 +1298,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
 	 * avoids programming the underlying clock event twice (once at
 	 * removal and once after enqueue).
 	 */
-	remove_hrtimer(timer, base, true, force_local);
+	was_armed =3D remove_hrtimer(timer, base, true, force_local);
=20
 	if (mode & HRTIMER_MODE_REL)
 		tim =3D ktime_add_safe(tim, __hrtimer_cb_get_time(base->clockid));
@@ -1321,7 +1315,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
 		new_base =3D base;
 	}
=20
-	first =3D enqueue_hrtimer(timer, new_base, mode);
+	first =3D enqueue_hrtimer(timer, new_base, mode, was_armed);
=20
 	/*
 	 * If the hrtimer interrupt is running, then it will reevaluate the
@@ -1439,8 +1433,11 @@ int hrtimer_try_to_cancel(struct hrtimer *timer)
=20
 	base =3D lock_hrtimer_base(timer, &flags);
=20
-	if (!hrtimer_callback_running(timer))
+	if (!hrtimer_callback_running(timer)) {
 		ret =3D remove_hrtimer(timer, base, false, false);
+		if (ret)
+			trace_hrtimer_cancel(timer);
+	}
=20
 	unlock_hrtimer_base(timer, &flags);
=20
@@ -1877,7 +1874,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_=
base,
 	 */
 	if (restart !=3D HRTIMER_NORESTART &&
 	    !(timer->state & HRTIMER_STATE_ENQUEUED))
-		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS);
+		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS, false);
=20
 	/*
 	 * Separate the ->running assignment from the ->state assignment.
@@ -2356,7 +2353,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_b=
ase *old_base,
 	while ((node =3D timerqueue_getnext(&old_base->active))) {
 		timer =3D container_of(node, struct hrtimer, node);
 		BUG_ON(hrtimer_callback_running(timer));
-		debug_deactivate(timer);
+		debug_hrtimer_deactivate(timer);
=20
 		/*
 		 * Mark it as ENQUEUED not INACTIVE otherwise the
@@ -2373,7 +2370,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_b=
ase *old_base,
 		 * sort out already expired timers and reprogram the
 		 * event device.
 		 */
-		enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS);
+		enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS, true);
 	}
 }
=20

