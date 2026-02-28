Return-Path: <linux-tip-commits+bounces-8306-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FudOVkNo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8306-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:25 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D041C4148
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 673FE301A697
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10347ECCA;
	Sat, 28 Feb 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="449LcyMK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rDpvr79M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E247ECC0;
	Sat, 28 Feb 2026 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292998; cv=none; b=GIJOXMLYToFxKGGE5p/gVFeFVhVfyrWTHKQZAW9/YWfNGpR0wwdVMdoJJHphUuxKEYP8Vahbs3RKw1xeyeMRR0LpN3YrCB5eIKBZL/5VywYL40VvXgegk4zBBqUn96aMeAHLeKsOtlD9stV+NvCXrY8F2Oxeq/9GqBUXQfquopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292998; c=relaxed/simple;
	bh=X/YNZU/5iAmlwREMSR0bC8cUQ5brZVIRG6gCHAWbXKA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fyw/aY0IKInhbWirVlKZYEKNdnk6VkjgSO4NcETti8+oDeahKFGsCDpsBlBCy+vg3MsX56TFfwfkQM/zHP2Zb9wpmd/mZCLTTRJYJOKZeutbtT+U+NFl1BlBLezKMyq1qRfHMk9/QtqAZJ7eQf6+TvQ3Gec9hNcqS3iOeykDU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=449LcyMK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rDpvr79M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6hZROSin6Rtv/jMiWDgrQRHlTdaHOhllRmwKAmgfqE=;
	b=449LcyMK5WNZBX5YkPYZQLdyjOBLX8sHxJ+/JW5wdAcDcuRHNucXS41gNDwyLrdgnuvQKd
	yocBD3uK6fnNjPYouKxseZ4kXy6IZFOOXhajFmjd+RaZv+xr2TL3+ivUFRVQbrkr+AlKU2
	Ov/p/vx4VUAouU9Sw/eareG/bU4ds/yFW38hlmIWI9JuzYVmAPfJezvtMqTEObdujpt+56
	4f3py6N/pN02LNwbWt4YmH7RA2oB/LbvwFCiB1lPRsdzmNUxla1ocvhkdY5J6kkukrZh7c
	QZLcbApWway0mxQRH85awqFXsigUjdY/1V8zngido2X16+h6UsXN/SHGQ+P1ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6hZROSin6Rtv/jMiWDgrQRHlTdaHOhllRmwKAmgfqE=;
	b=rDpvr79MzTrqqQKohwUdqvR9k4M06UU5CT180G1P0182ejb49ieRW2FBDNYN18897K68Sd
	3DeJljDkVD5PyDBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Optimize for local timers
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.607935269@kernel.org>
References: <20260224163430.607935269@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299402.1647592.8596181974417111395.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8306-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 13D041C4148
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     3288cd486376b322868c9fb41f10e35916e7e989
Gitweb:        https://git.kernel.org/tip/3288cd486376b322868c9fb41f10e35916e=
7e989
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:11 +01:00

hrtimer: Optimize for local timers

The decision whether to keep timers on the local CPU or on the CPU they are
associated to is suboptimal and causes the expensive switch_hrtimer_base()
mechanism to be invoked more than necessary. This is especially true for
pinned timers.

Rewrite the decision logic so that the current base is kept if:

   1) The callback is running on the base

   2) The timer is associated to the local CPU and the first expiring timer as
      that allows to optimize for reprogramming avoidance

   3) The timer is associated to the local CPU and pinned

   4) The timer is associated to the local CPU and timer migration is
      disabled.

Only #2 was covered by the original code, but especially #3 makes a
difference for high frequency rearming timers like the scheduler hrtick
timer. If timer migration is disabled, then #4 avoids most of the base
switches.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.607935269@kernel.org
---
 kernel/time/hrtimer.c | 101 ++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 36 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6bab3b7..b87995f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1147,7 +1147,7 @@ static void __remove_hrtimer(struct hrtimer *timer, str=
uct hrtimer_clock_base *b
 }
=20
 static inline bool remove_hrtimer(struct hrtimer *timer, struct hrtimer_cloc=
k_base *base,
-				 bool restart, bool keep_local)
+				 bool restart, bool keep_base)
 {
 	bool queued_state =3D timer->is_queued;
=20
@@ -1177,7 +1177,7 @@ static inline bool remove_hrtimer(struct hrtimer *timer=
, struct hrtimer_clock_ba
 		if (!restart)
 			queued_state =3D HRTIMER_STATE_INACTIVE;
 		else
-			reprogram &=3D !keep_local;
+			reprogram &=3D !keep_base;
=20
 		__remove_hrtimer(timer, base, queued_state, reprogram);
 		return true;
@@ -1220,29 +1220,57 @@ static void hrtimer_update_softirq_timer(struct hrtim=
er_cpu_base *cpu_base, bool
 	hrtimer_reprogram(cpu_base->softirq_next_timer, reprogram);
 }
=20
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+static __always_inline bool hrtimer_prefer_local(bool is_local, bool is_firs=
t, bool is_pinned)
+{
+	if (static_branch_likely(&timers_migration_enabled)) {
+		/*
+		 * If it is local and the first expiring timer keep it on the local
+		 * CPU to optimize reprogramming of the clockevent device. Also
+		 * avoid switch_hrtimer_base() overhead when local and pinned.
+		 */
+		if (!is_local)
+			return false;
+		return is_first || is_pinned;
+	}
+	return is_local;
+}
+#else
+static __always_inline bool hrtimer_prefer_local(bool is_local, bool is_firs=
t, bool is_pinned)
+{
+	return is_local;
+}
+#endif
+
+static inline bool hrtimer_keep_base(struct hrtimer *timer, bool is_local, b=
ool is_first,
+				     bool is_pinned)
+{
+	/* If the timer is running the callback it has to stay on its CPU base. */
+	if (unlikely(timer->base->running =3D=3D timer))
+		return true;
+
+	return hrtimer_prefer_local(is_local, is_first, is_pinned);
+}
+
 static bool __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim, u64=
 delta_ns,
 				     const enum hrtimer_mode mode, struct hrtimer_clock_base *base)
 {
 	struct hrtimer_cpu_base *this_cpu_base =3D this_cpu_ptr(&hrtimer_bases);
-	struct hrtimer_clock_base *new_base;
-	bool force_local, first, was_armed;
+	bool is_pinned, first, was_first, was_armed, keep_base =3D false;
+	struct hrtimer_cpu_base *cpu_base =3D base->cpu_base;
=20
-	/*
-	 * If the timer is on the local cpu base and is the first expiring
-	 * timer then this might end up reprogramming the hardware twice
-	 * (on removal and on enqueue). To avoid that prevent the reprogram
-	 * on removal, keep the timer local to the current CPU and enforce
-	 * reprogramming after it is queued no matter whether it is the new
-	 * first expiring timer again or not.
-	 */
-	force_local =3D base->cpu_base =3D=3D this_cpu_base;
-	force_local &=3D base->cpu_base->next_timer =3D=3D timer;
+	was_first =3D cpu_base->next_timer =3D=3D timer;
+	is_pinned =3D !!(mode & HRTIMER_MODE_PINNED);
=20
 	/*
-	 * Don't force local queuing if this enqueue happens on a unplugged
-	 * CPU after hrtimer_cpu_dying() has been invoked.
+	 * Don't keep it local if this enqueue happens on a unplugged CPU
+	 * after hrtimer_cpu_dying() has been invoked.
 	 */
-	force_local &=3D this_cpu_base->online;
+	if (likely(this_cpu_base->online)) {
+		bool is_local =3D cpu_base =3D=3D this_cpu_base;
+
+		keep_base =3D hrtimer_keep_base(timer, is_local, was_first, is_pinned);
+	}
=20
 	/*
 	 * Remove an active timer from the queue. In case it is not queued
@@ -1254,8 +1282,11 @@ static bool __hrtimer_start_range_ns(struct hrtimer *t=
imer, ktime_t tim, u64 del
 	 * reprogramming later if it was the first expiring timer.  This
 	 * avoids programming the underlying clock event twice (once at
 	 * removal and once after enqueue).
+	 *
+	 * @keep_base is also true if the timer callback is running on a
+	 * remote CPU and for local pinned timers.
 	 */
-	was_armed =3D remove_hrtimer(timer, base, true, force_local);
+	was_armed =3D remove_hrtimer(timer, base, true, keep_base);
=20
 	if (mode & HRTIMER_MODE_REL)
 		tim =3D ktime_add_safe(tim, __hrtimer_cb_get_time(base->clockid));
@@ -1265,21 +1296,21 @@ static bool __hrtimer_start_range_ns(struct hrtimer *=
timer, ktime_t tim, u64 del
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
=20
 	/* Switch the timer base, if necessary: */
-	if (!force_local)
-		new_base =3D switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
-	else
-		new_base =3D base;
+	if (!keep_base) {
+		base =3D switch_hrtimer_base(timer, base, is_pinned);
+		cpu_base =3D base->cpu_base;
+	}
=20
-	first =3D enqueue_hrtimer(timer, new_base, mode, was_armed);
+	first =3D enqueue_hrtimer(timer, base, mode, was_armed);
=20
 	/*
 	 * If the hrtimer interrupt is running, then it will reevaluate the
 	 * clock bases and reprogram the clock event device.
 	 */
-	if (new_base->cpu_base->in_hrtirq)
+	if (cpu_base->in_hrtirq)
 		return false;
=20
-	if (!force_local) {
+	if (!was_first || cpu_base !=3D this_cpu_base) {
 		/*
 		 * If the current CPU base is online, then the timer is never
 		 * queued on a remote CPU if it would be the first expiring
@@ -1288,7 +1319,7 @@ static bool __hrtimer_start_range_ns(struct hrtimer *ti=
mer, ktime_t tim, u64 del
 		 * re-evaluate the first expiring timer after completing the
 		 * callbacks.
 		 */
-		if (hrtimer_base_is_online(this_cpu_base))
+		if (likely(hrtimer_base_is_online(this_cpu_base)))
 			return first;
=20
 		/*
@@ -1296,11 +1327,8 @@ static bool __hrtimer_start_range_ns(struct hrtimer *t=
imer, ktime_t tim, u64 del
 		 * already offline. If the timer is the first to expire,
 		 * kick the remote CPU to reprogram the clock event.
 		 */
-		if (first) {
-			struct hrtimer_cpu_base *new_cpu_base =3D new_base->cpu_base;
-
-			smp_call_function_single_async(new_cpu_base->cpu, &new_cpu_base->csd);
-		}
+		if (first)
+			smp_call_function_single_async(cpu_base->cpu, &cpu_base->csd);
 		return false;
 	}
=20
@@ -1314,16 +1342,17 @@ static bool __hrtimer_start_range_ns(struct hrtimer *=
timer, ktime_t tim, u64 del
 	 * required.
 	 */
 	if (timer->is_lazy) {
-		if (new_base->cpu_base->expires_next <=3D hrtimer_get_expires(timer))
+		if (cpu_base->expires_next <=3D hrtimer_get_expires(timer))
 			return false;
 	}
=20
 	/*
-	 * Timer was forced to stay on the current CPU to avoid
-	 * reprogramming on removal and enqueue. Force reprogram the
-	 * hardware by evaluating the new first expiring timer.
+	 * Timer was the first expiring timer and forced to stay on the
+	 * current CPU to avoid reprogramming on removal and enqueue. Force
+	 * reprogram the hardware by evaluating the new first expiring
+	 * timer.
 	 */
-	hrtimer_force_reprogram(new_base->cpu_base, /* skip_equal */ true);
+	hrtimer_force_reprogram(cpu_base, /* skip_equal */ true);
 	return false;
 }
=20

