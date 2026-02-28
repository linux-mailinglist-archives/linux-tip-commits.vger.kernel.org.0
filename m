Return-Path: <linux-tip-commits+bounces-8313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILG7JzMOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:48:03 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9141C41DE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4C8B30A2445
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4D48032F;
	Sat, 28 Feb 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eyWxgtn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BqzeXCZ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE847ECF5;
	Sat, 28 Feb 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293008; cv=none; b=nulsPxQ5Sp8hHUeDPIoZtwAPy0KOavHjz2OHHHM2zjxpxnabMPWrVsuMjsMrJ1HgoskQXHMbHAEsh+HhTLKlO/lFJXYUuQ/9zHEYS56Y4J6bSd5rmRyPd7PnxqqNFdr0Km6QhHIBfnPHZINvz3jTOvoqFtK0n3tOjPRbicxv0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293008; c=relaxed/simple;
	bh=zGtX/XhJWrdO1nPRdSjBbY3csrTKZLa1+Wsq+DFHowI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C1NwuU+TasoECxLToi0Ed0DTxHmnDo2OS7piFM+c+FizY2C1SH4TC1J2kDFTTpvKlbDCQcu4EpLQ30CICaoSAAF5qZr22O3M7w1ayyBdALuh52PejReLSjnAvkg1q1Fmy1p3FGCg9O5WUO8n6HfkbZTaW3lI1RAUfcS48ZP8hME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eyWxgtn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BqzeXCZ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM2MXP3ovk7bFp/C3fz3uI5mmIr3JP6vm3ytw5La6dQ=;
	b=eyWxgtn1i6dlLQjuOipdEle9zGv9/KSxUBEjBIHyfbD+5wdIRu4m3JYokJZbL6ZaF4MZJj
	7UM9Y87eauQ0KD6kaxsdHftFIQm42B8mZzJ29CVDTXe+PQlTCeKgDfUHCEcPnn4D/Kys66
	myMdaXxcUUGOP86UMwgwwUdaZNnI9Wsn7o1+1r63vFMh0Tl5HBsO/eCuuheZv0p0yw7GXc
	v0HTysWXDpFOmSG7DNIJPr2FPE7UfjQ4RlfUc1C/4j9Nyd7XFxkVU1vVTVpK12gcVjh6iL
	qJ3n/yCEyB5gr+rlSvQBfWC+lzcMHGmQWuZBhP6O/DVL/FFOlRC5JZ6PdZ50ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM2MXP3ovk7bFp/C3fz3uI5mmIr3JP6vm3ytw5La6dQ=;
	b=BqzeXCZ2DsEjQJrq0KRMIzFuDvz/7UZ8kJGgur0SsrXCIi40ZvEbX5PPDEeeIzj6BBENeq
	lvbfj2rUJEYF3rAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Cleanup coding style and comments
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.342740952@kernel.org>
References: <20260224163430.342740952@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299850.1647592.5306377113854159544.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8313-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,msgid.link:url,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: AF9141C41DE
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     0c6af0ea51bd2774f41a00a81ac276800975c3cc
Gitweb:        https://git.kernel.org/tip/0c6af0ea51bd2774f41a00a81ac27680097=
5c3cc
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:10 +01:00

hrtimer: Cleanup coding style and comments

As this code has some major surgery ahead, clean up coding style and bring
comments up to date.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.342740952@kernel.org
---
 kernel/time/hrtimer.c | 364 ++++++++++++++++-------------------------
 1 file changed, 143 insertions(+), 221 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a5df3c4..0448ba9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -77,43 +77,22 @@ static ktime_t __hrtimer_cb_get_time(clockid_t clock_id);
  * to reach a base using a clockid, hrtimer_clockid_to_base()
  * is used to convert from clockid to the proper hrtimer_base_type.
  */
+
+#define BASE_INIT(idx, cid)			\
+	[idx] =3D { .index =3D idx, .clockid =3D cid }
+
 DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =3D
 {
 	.lock =3D __RAW_SPIN_LOCK_UNLOCKED(hrtimer_bases.lock),
-	.clock_base =3D
-	{
-		{
-			.index =3D HRTIMER_BASE_MONOTONIC,
-			.clockid =3D CLOCK_MONOTONIC,
-		},
-		{
-			.index =3D HRTIMER_BASE_REALTIME,
-			.clockid =3D CLOCK_REALTIME,
-		},
-		{
-			.index =3D HRTIMER_BASE_BOOTTIME,
-			.clockid =3D CLOCK_BOOTTIME,
-		},
-		{
-			.index =3D HRTIMER_BASE_TAI,
-			.clockid =3D CLOCK_TAI,
-		},
-		{
-			.index =3D HRTIMER_BASE_MONOTONIC_SOFT,
-			.clockid =3D CLOCK_MONOTONIC,
-		},
-		{
-			.index =3D HRTIMER_BASE_REALTIME_SOFT,
-			.clockid =3D CLOCK_REALTIME,
-		},
-		{
-			.index =3D HRTIMER_BASE_BOOTTIME_SOFT,
-			.clockid =3D CLOCK_BOOTTIME,
-		},
-		{
-			.index =3D HRTIMER_BASE_TAI_SOFT,
-			.clockid =3D CLOCK_TAI,
-		},
+	.clock_base =3D {
+		BASE_INIT(HRTIMER_BASE_MONOTONIC,	CLOCK_MONOTONIC),
+		BASE_INIT(HRTIMER_BASE_REALTIME,	CLOCK_REALTIME),
+		BASE_INIT(HRTIMER_BASE_BOOTTIME,	CLOCK_BOOTTIME),
+		BASE_INIT(HRTIMER_BASE_TAI,		CLOCK_TAI),
+		BASE_INIT(HRTIMER_BASE_MONOTONIC_SOFT,	CLOCK_MONOTONIC),
+		BASE_INIT(HRTIMER_BASE_REALTIME_SOFT,	CLOCK_REALTIME),
+		BASE_INIT(HRTIMER_BASE_BOOTTIME_SOFT,	CLOCK_BOOTTIME),
+		BASE_INIT(HRTIMER_BASE_TAI_SOFT,	CLOCK_TAI),
 	},
 	.csd =3D CSD_INIT(retrigger_next_event, NULL)
 };
@@ -150,18 +129,19 @@ static inline void hrtimer_schedule_hres_work(void) { }
  * single place
  */
 #ifdef CONFIG_SMP
-
 /*
  * We require the migration_base for lock_hrtimer_base()/switch_hrtimer_base=
()
  * such that hrtimer_callback_running() can unconditionally dereference
  * timer->base->cpu_base
  */
 static struct hrtimer_cpu_base migration_cpu_base =3D {
-	.clock_base =3D { {
-		.cpu_base =3D &migration_cpu_base,
-		.seq      =3D SEQCNT_RAW_SPINLOCK_ZERO(migration_cpu_base.seq,
-						     &migration_cpu_base.lock),
-	}, },
+	.clock_base =3D {
+		[0] =3D {
+			.cpu_base =3D &migration_cpu_base,
+			.seq      =3D SEQCNT_RAW_SPINLOCK_ZERO(migration_cpu_base.seq,
+							     &migration_cpu_base.lock),
+		},
+	},
 };
=20
 #define migration_base	migration_cpu_base.clock_base[0]
@@ -178,15 +158,13 @@ static struct hrtimer_cpu_base migration_cpu_base =3D {
  * possible to set timer->base =3D &migration_base and drop the lock: the ti=
mer
  * remains locked.
  */
-static
-struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
-					     unsigned long *flags)
+static struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *ti=
mer,
+						    unsigned long *flags)
 	__acquires(&timer->base->lock)
 {
-	struct hrtimer_clock_base *base;
-
 	for (;;) {
-		base =3D READ_ONCE(timer->base);
+		struct hrtimer_clock_base *base =3D READ_ONCE(timer->base);
+
 		if (likely(base !=3D &migration_base)) {
 			raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
 			if (likely(base =3D=3D timer->base))
@@ -239,7 +217,7 @@ static bool hrtimer_suitable_target(struct hrtimer *timer=
, struct hrtimer_clock_
 	return expires >=3D new_base->cpu_base->expires_next;
 }
=20
-static inline struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_ba=
se *base, int pinned)
+static inline struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_ba=
se *base, bool pinned)
 {
 	if (!hrtimer_base_is_online(base)) {
 		int cpu =3D cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_=
TIMER));
@@ -267,8 +245,7 @@ static inline struct hrtimer_cpu_base *get_target_base(st=
ruct hrtimer_cpu_base *
  * the timer callback is currently running.
  */
 static inline struct hrtimer_clock_base *
-switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
-		    int pinned)
+switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base, =
bool pinned)
 {
 	struct hrtimer_cpu_base *new_cpu_base, *this_cpu_base;
 	struct hrtimer_clock_base *new_base;
@@ -281,13 +258,12 @@ again:
=20
 	if (base !=3D new_base) {
 		/*
-		 * We are trying to move timer to new_base.
-		 * However we can't change timer's base while it is running,
-		 * so we keep it on the same CPU. No hassle vs. reprogramming
-		 * the event source in the high resolution case. The softirq
-		 * code will take care of this when the timer function has
-		 * completed. There is no conflict as we hold the lock until
-		 * the timer is enqueued.
+		 * We are trying to move timer to new_base. However we can't
+		 * change timer's base while it is running, so we keep it on
+		 * the same CPU. No hassle vs. reprogramming the event source
+		 * in the high resolution case. The remote CPU will take care
+		 * of this when the timer function has completed. There is no
+		 * conflict as we hold the lock until the timer is enqueued.
 		 */
 		if (unlikely(hrtimer_callback_running(timer)))
 			return base;
@@ -297,8 +273,7 @@ again:
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
=20
-		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base,
-					     this_cpu_base)) {
+		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base, this_cpu_base)=
) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base =3D this_cpu_base;
@@ -317,14 +292,13 @@ again:
=20
 #else /* CONFIG_SMP */
=20
-static inline struct hrtimer_clock_base *
-lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+static inline struct hrtimer_clock_base *lock_hrtimer_base(const struct hrti=
mer *timer,
+							   unsigned long *flags)
 	__acquires(&timer->base->cpu_base->lock)
 {
 	struct hrtimer_clock_base *base =3D timer->base;
=20
 	raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
-
 	return base;
 }
=20
@@ -484,8 +458,7 @@ static inline void debug_hrtimer_init_on_stack(struct hrt=
imer *timer)
 	debug_object_init_on_stack(timer, &hrtimer_debug_descr);
 }
=20
-static inline void debug_hrtimer_activate(struct hrtimer *timer,
-					  enum hrtimer_mode mode)
+static inline void debug_hrtimer_activate(struct hrtimer *timer, enum hrtime=
r_mode mode)
 {
 	debug_object_activate(timer, &hrtimer_debug_descr);
 }
@@ -510,8 +483,7 @@ EXPORT_SYMBOL_GPL(destroy_hrtimer_on_stack);
=20
 static inline void debug_hrtimer_init(struct hrtimer *timer) { }
 static inline void debug_hrtimer_init_on_stack(struct hrtimer *timer) { }
-static inline void debug_hrtimer_activate(struct hrtimer *timer,
-					  enum hrtimer_mode mode) { }
+static inline void debug_hrtimer_activate(struct hrtimer *timer, enum hrtime=
r_mode mode) { }
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 static inline void debug_hrtimer_assert_init(struct hrtimer *timer) { }
 #endif
@@ -549,13 +521,12 @@ __next_base(struct hrtimer_cpu_base *cpu_base, unsigned=
 int *active)
 	return &cpu_base->clock_base[idx];
 }
=20
-#define for_each_active_base(base, cpu_base, active)	\
+#define for_each_active_base(base, cpu_base, active)		\
 	while ((base =3D __next_base((cpu_base), &(active))))
=20
 static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
 					 const struct hrtimer *exclude,
-					 unsigned int active,
-					 ktime_t expires_next)
+					 unsigned int active, ktime_t expires_next)
 {
 	struct hrtimer_clock_base *base;
 	ktime_t expires;
@@ -618,29 +589,24 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer=
_cpu_base *cpu_base,
  *  - HRTIMER_ACTIVE_SOFT, or
  *  - HRTIMER_ACTIVE_HARD.
  */
-static ktime_t
-__hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int act=
ive_mask)
+static ktime_t __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, u=
nsigned int active_mask)
 {
-	unsigned int active;
 	struct hrtimer *next_timer =3D NULL;
 	ktime_t expires_next =3D KTIME_MAX;
+	unsigned int active;
=20
 	if (!cpu_base->softirq_activated && (active_mask & HRTIMER_ACTIVE_SOFT)) {
 		active =3D cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
 		cpu_base->softirq_next_timer =3D NULL;
-		expires_next =3D __hrtimer_next_event_base(cpu_base, NULL,
-							 active, KTIME_MAX);
-
+		expires_next =3D __hrtimer_next_event_base(cpu_base, NULL, active, KTIME_M=
AX);
 		next_timer =3D cpu_base->softirq_next_timer;
 	}
=20
 	if (active_mask & HRTIMER_ACTIVE_HARD) {
 		active =3D cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
 		cpu_base->next_timer =3D next_timer;
-		expires_next =3D __hrtimer_next_event_base(cpu_base, NULL, active,
-							 expires_next);
+		expires_next =3D __hrtimer_next_event_base(cpu_base, NULL, active, expires=
_next);
 	}
-
 	return expires_next;
 }
=20
@@ -681,8 +647,8 @@ static inline ktime_t hrtimer_update_base(struct hrtimer_=
cpu_base *base)
 	ktime_t *offs_boot =3D &base->clock_base[HRTIMER_BASE_BOOTTIME].offset;
 	ktime_t *offs_tai =3D &base->clock_base[HRTIMER_BASE_TAI].offset;
=20
-	ktime_t now =3D ktime_get_update_offsets_now(&base->clock_was_set_seq,
-					    offs_real, offs_boot, offs_tai);
+	ktime_t now =3D ktime_get_update_offsets_now(&base->clock_was_set_seq, offs=
_real,
+						   offs_boot, offs_tai);
=20
 	base->clock_base[HRTIMER_BASE_REALTIME_SOFT].offset =3D *offs_real;
 	base->clock_base[HRTIMER_BASE_BOOTTIME_SOFT].offset =3D *offs_boot;
@@ -702,8 +668,7 @@ static inline int hrtimer_hres_active(struct hrtimer_cpu_=
base *cpu_base)
 		cpu_base->hres_active : 0;
 }
=20
-static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
-				struct hrtimer *next_timer,
+static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base, struct hr=
timer *next_timer,
 				ktime_t expires_next)
 {
 	cpu_base->expires_next =3D expires_next;
@@ -736,12 +701,9 @@ static void __hrtimer_reprogram(struct hrtimer_cpu_base =
*cpu_base,
  * next event
  * Called with interrupts disabled and base->lock held
  */
-static void
-hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+static void hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, bool =
skip_equal)
 {
-	ktime_t expires_next;
-
-	expires_next =3D hrtimer_update_next_event(cpu_base);
+	ktime_t expires_next =3D hrtimer_update_next_event(cpu_base);
=20
 	if (skip_equal && expires_next =3D=3D cpu_base->expires_next)
 		return;
@@ -752,41 +714,31 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_ba=
se, int skip_equal)
 /* High resolution timer related functions */
 #ifdef CONFIG_HIGH_RES_TIMERS
=20
-/*
- * High resolution timer enabled ?
- */
+/* High resolution timer enabled ? */
 static bool hrtimer_hres_enabled __read_mostly  =3D true;
 unsigned int hrtimer_resolution __read_mostly =3D LOW_RES_NSEC;
 EXPORT_SYMBOL_GPL(hrtimer_resolution);
=20
-/*
- * Enable / Disable high resolution mode
- */
+/* Enable / Disable high resolution mode */
 static int __init setup_hrtimer_hres(char *str)
 {
 	return (kstrtobool(str, &hrtimer_hres_enabled) =3D=3D 0);
 }
-
 __setup("highres=3D", setup_hrtimer_hres);
=20
-/*
- * hrtimer_high_res_enabled - query, if the highres mode is enabled
- */
-static inline int hrtimer_is_hres_enabled(void)
+/* hrtimer_high_res_enabled - query, if the highres mode is enabled */
+static inline bool hrtimer_is_hres_enabled(void)
 {
 	return hrtimer_hres_enabled;
 }
=20
-/*
- * Switch to high resolution mode
- */
+/* Switch to high resolution mode */
 static void hrtimer_switch_to_hres(void)
 {
 	struct hrtimer_cpu_base *base =3D this_cpu_ptr(&hrtimer_bases);
=20
 	if (tick_init_highres()) {
-		pr_warn("Could not switch to high resolution mode on CPU %u\n",
-			base->cpu);
+		pr_warn("Could not switch to high resolution mode on CPU %u\n",	base->cpu);
 		return;
 	}
 	base->hres_active =3D 1;
@@ -800,10 +752,11 @@ static void hrtimer_switch_to_hres(void)
=20
 #else
=20
-static inline int hrtimer_is_hres_enabled(void) { return 0; }
+static inline bool hrtimer_is_hres_enabled(void) { return 0; }
 static inline void hrtimer_switch_to_hres(void) { }
=20
 #endif /* CONFIG_HIGH_RES_TIMERS */
+
 /*
  * Retrigger next event is called after clock was set with interrupts
  * disabled through an SMP function call or directly from low level
@@ -841,7 +794,7 @@ static void retrigger_next_event(void *arg)
 	guard(raw_spinlock)(&base->lock);
 	hrtimer_update_base(base);
 	if (hrtimer_hres_active(base))
-		hrtimer_force_reprogram(base, 0);
+		hrtimer_force_reprogram(base, /* skip_equal */ false);
 	else
 		hrtimer_update_next_event(base);
 }
@@ -887,8 +840,7 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool=
 reprogram)
 		timer_cpu_base->softirq_next_timer =3D timer;
 		timer_cpu_base->softirq_expires_next =3D expires;
=20
-		if (!ktime_before(expires, timer_cpu_base->expires_next) ||
-		    !reprogram)
+		if (!ktime_before(expires, timer_cpu_base->expires_next) || !reprogram)
 			return;
 	}
=20
@@ -914,8 +866,7 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool=
 reprogram)
 	__hrtimer_reprogram(cpu_base, timer, expires);
 }
=20
-static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
-			     unsigned int active)
+static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base, unsigned int=
 active)
 {
 	struct hrtimer_clock_base *base;
 	unsigned int seq;
@@ -1050,11 +1001,8 @@ void hrtimers_resume_local(void)
 	retrigger_next_event(NULL);
 }
=20
-/*
- * Counterpart to lock_hrtimer_base above:
- */
-static inline
-void unlock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+/* Counterpart to lock_hrtimer_base above */
+static inline void unlock_hrtimer_base(const struct hrtimer *timer, unsigned=
 long *flags)
 	__releases(&timer->base->cpu_base->lock)
 {
 	raw_spin_unlock_irqrestore(&timer->base->cpu_base->lock, *flags);
@@ -1071,7 +1019,7 @@ void unlock_hrtimer_base(const struct hrtimer *timer, u=
nsigned long *flags)
  * .. note::
  *  This only updates the timer expiry value and does not requeue the timer.
  *
- * There is also a variant of the function hrtimer_forward_now().
+ * There is also a variant of this function: hrtimer_forward_now().
  *
  * Context: Can be safely called from the callback function of @timer. If ca=
lled
  *          from other contexts @timer must neither be enqueued nor running =
the
@@ -1081,8 +1029,8 @@ void unlock_hrtimer_base(const struct hrtimer *timer, u=
nsigned long *flags)
  */
 u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 {
-	u64 orun =3D 1;
 	ktime_t delta;
+	u64 orun =3D 1;
=20
 	delta =3D ktime_sub(now, hrtimer_get_expires(timer));
=20
@@ -1118,13 +1066,15 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
  * enqueue_hrtimer - internal function to (re)start a timer
  *
  * The timer is inserted in expiry order. Insertion into the
- * red black tree is O(log(n)). Must hold the base lock.
+ * red black tree is O(log(n)).
  *
  * Returns true when the new timer is the leftmost timer in the tree.
  */
 static bool enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base=
 *base,
 			    enum hrtimer_mode mode, bool was_armed)
 {
+	lockdep_assert_held(&base->cpu_base->lock);
+
 	debug_activate(timer, mode, was_armed);
 	WARN_ON_ONCE(!base->cpu_base->online);
=20
@@ -1139,20 +1089,19 @@ static bool enqueue_hrtimer(struct hrtimer *timer, st=
ruct hrtimer_clock_base *ba
 /*
  * __remove_hrtimer - internal function to remove a timer
  *
- * Caller must hold the base lock.
- *
  * High resolution timer mode reprograms the clock event device when the
  * timer is the one which expires next. The caller can disable this by setti=
ng
  * reprogram to zero. This is useful, when the context does a reprogramming
  * anyway (e.g. timer interrupt)
  */
-static void __remove_hrtimer(struct hrtimer *timer,
-			     struct hrtimer_clock_base *base,
-			     u8 newstate, int reprogram)
+static void __remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_bas=
e *base,
+			     u8 newstate, bool reprogram)
 {
 	struct hrtimer_cpu_base *cpu_base =3D base->cpu_base;
 	u8 state =3D timer->state;
=20
+	lockdep_assert_held(&cpu_base->lock);
+
 	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->state, newstate);
 	if (!(state & HRTIMER_STATE_ENQUEUED))
@@ -1162,26 +1111,25 @@ static void __remove_hrtimer(struct hrtimer *timer,
 		cpu_base->active_bases &=3D ~(1 << base->index);
=20
 	/*
-	 * Note: If reprogram is false we do not update
-	 * cpu_base->next_timer. This happens when we remove the first
-	 * timer on a remote cpu. No harm as we never dereference
-	 * cpu_base->next_timer. So the worst thing what can happen is
-	 * an superfluous call to hrtimer_force_reprogram() on the
-	 * remote cpu later on if the same timer gets enqueued again.
+	 * If reprogram is false don't update cpu_base->next_timer and do not
+	 * touch the clock event device.
+	 *
+	 * This happens when removing the first timer on a remote CPU, which
+	 * will be handled by the remote CPU's interrupt. It also happens when
+	 * a local timer is removed to be immediately restarted. That's handled
+	 * at the call site.
 	 */
 	if (reprogram && timer =3D=3D cpu_base->next_timer && !timer->is_lazy)
-		hrtimer_force_reprogram(cpu_base, 1);
+		hrtimer_force_reprogram(cpu_base, /* skip_equal */ true);
 }
=20
-/*
- * remove hrtimer, called with base lock held
- */
-static inline int
-remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base,
-	       bool restart, bool keep_local)
+static inline bool remove_hrtimer(struct hrtimer *timer, struct hrtimer_cloc=
k_base *base,
+				 bool restart, bool keep_local)
 {
 	u8 state =3D timer->state;
=20
+	lockdep_assert_held(&base->cpu_base->lock);
+
 	if (state & HRTIMER_STATE_ENQUEUED) {
 		bool reprogram;
=20
@@ -1209,9 +1157,9 @@ remove_hrtimer(struct hrtimer *timer, struct hrtimer_cl=
ock_base *base,
 			reprogram &=3D !keep_local;
=20
 		__remove_hrtimer(timer, base, state, reprogram);
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
=20
 static inline ktime_t hrtimer_update_lowres(struct hrtimer *timer, ktime_t t=
im,
@@ -1230,34 +1178,27 @@ static inline ktime_t hrtimer_update_lowres(struct hr=
timer *timer, ktime_t tim,
 	return tim;
 }
=20
-static void
-hrtimer_update_softirq_timer(struct hrtimer_cpu_base *cpu_base, bool reprogr=
am)
+static void hrtimer_update_softirq_timer(struct hrtimer_cpu_base *cpu_base, =
bool reprogram)
 {
-	ktime_t expires;
+	ktime_t expires =3D __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_SOFT);
=20
 	/*
-	 * Find the next SOFT expiration.
-	 */
-	expires =3D __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_SOFT);
-
-	/*
-	 * reprogramming needs to be triggered, even if the next soft
-	 * hrtimer expires at the same time than the next hard
+	 * Reprogramming needs to be triggered, even if the next soft
+	 * hrtimer expires at the same time as the next hard
 	 * hrtimer. cpu_base->softirq_expires_next needs to be updated!
 	 */
 	if (expires =3D=3D KTIME_MAX)
 		return;
=20
 	/*
-	 * cpu_base->*next_timer is recomputed by __hrtimer_get_next_event()
-	 * cpu_base->*expires_next is only set by hrtimer_reprogram()
+	 * cpu_base->next_timer is recomputed by __hrtimer_get_next_event()
+	 * cpu_base->expires_next is only set by hrtimer_reprogram()
 	 */
 	hrtimer_reprogram(cpu_base->softirq_next_timer, reprogram);
 }
=20
-static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
-				    u64 delta_ns, const enum hrtimer_mode mode,
-				    struct hrtimer_clock_base *base)
+static bool __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim, u64=
 delta_ns,
+				     const enum hrtimer_mode mode, struct hrtimer_clock_base *base)
 {
 	struct hrtimer_cpu_base *this_cpu_base =3D this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
@@ -1301,12 +1242,10 @@ static int __hrtimer_start_range_ns(struct hrtimer *t=
imer, ktime_t tim,
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
=20
 	/* Switch the timer base, if necessary: */
-	if (!force_local) {
-		new_base =3D switch_hrtimer_base(timer, base,
-					       mode & HRTIMER_MODE_PINNED);
-	} else {
+	if (!force_local)
+		new_base =3D switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
+	else
 		new_base =3D base;
-	}
=20
 	first =3D enqueue_hrtimer(timer, new_base, mode, was_armed);
=20
@@ -1319,9 +1258,12 @@ static int __hrtimer_start_range_ns(struct hrtimer *ti=
mer, ktime_t tim,
=20
 	if (!force_local) {
 		/*
-		 * If the current CPU base is online, then the timer is
-		 * never queued on a remote CPU if it would be the first
-		 * expiring timer there.
+		 * If the current CPU base is online, then the timer is never
+		 * queued on a remote CPU if it would be the first expiring
+		 * timer there unless the timer callback is currently executed
+		 * on the remote CPU. In the latter case the remote CPU will
+		 * re-evaluate the first expiring timer after completing the
+		 * callbacks.
 		 */
 		if (hrtimer_base_is_online(this_cpu_base))
 			return first;
@@ -1336,7 +1278,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
=20
 			smp_call_function_single_async(new_cpu_base->cpu, &new_cpu_base->csd);
 		}
-		return 0;
+		return false;
 	}
=20
 	/*
@@ -1350,7 +1292,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
 	 */
 	if (timer->is_lazy) {
 		if (new_base->cpu_base->expires_next <=3D hrtimer_get_expires(timer))
-			return 0;
+			return false;
 	}
=20
 	/*
@@ -1358,8 +1300,8 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
 	 * reprogramming on removal and enqueue. Force reprogram the
 	 * hardware by evaluating the new first expiring timer.
 	 */
-	hrtimer_force_reprogram(new_base->cpu_base, 1);
-	return 0;
+	hrtimer_force_reprogram(new_base->cpu_base, /* skip_equal */ true);
+	return false;
 }
=20
 /**
@@ -1371,8 +1313,8 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
  *		relative (HRTIMER_MODE_REL), and pinned (HRTIMER_MODE_PINNED);
  *		softirq based mode is considered for debug purpose only!
  */
-void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
-			    u64 delta_ns, const enum hrtimer_mode mode)
+void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim, u64 delta_ns,
+			    const enum hrtimer_mode mode)
 {
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
@@ -1464,8 +1406,7 @@ static void hrtimer_cpu_base_unlock_expiry(struct hrtim=
er_cpu_base *base)
  * the timer callback to finish. Drop expiry_lock and reacquire it. That
  * allows the waiter to acquire the lock and make progress.
  */
-static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
-				      unsigned long flags)
+static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base, uns=
igned long flags)
 {
 	if (atomic_read(&cpu_base->timer_waiters)) {
 		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
@@ -1530,14 +1471,10 @@ void hrtimer_cancel_wait_running(const struct hrtimer=
 *timer)
 	spin_unlock_bh(&base->cpu_base->softirq_expiry_lock);
 }
 #else
-static inline void
-hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base *base) { }
-static inline void
-hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base) { }
-static inline void
-hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base) { }
-static inline void hrtimer_sync_wait_running(struct hrtimer_cpu_base *base,
-					     unsigned long flags) { }
+static inline void hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base=
 *base) { }
+static inline void hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *bas=
e) { }
+static inline void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *b=
ase) { }
+static inline void hrtimer_sync_wait_running(struct hrtimer_cpu_base *base, =
unsigned long fl) { }
 #endif
=20
 /**
@@ -1668,8 +1605,7 @@ ktime_t hrtimer_cb_get_time(const struct hrtimer *timer)
 }
 EXPORT_SYMBOL_GPL(hrtimer_cb_get_time);
=20
-static void __hrtimer_setup(struct hrtimer *timer,
-			    enum hrtimer_restart (*function)(struct hrtimer *),
+static void __hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fn=
)(struct hrtimer *),
 			    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	bool softtimer =3D !!(mode & HRTIMER_MODE_SOFT);
@@ -1705,10 +1641,10 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	timer->base =3D &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
=20
-	if (WARN_ON_ONCE(!function))
+	if (WARN_ON_ONCE(!fn))
 		ACCESS_PRIVATE(timer, function) =3D hrtimer_dummy_timeout;
 	else
-		ACCESS_PRIVATE(timer, function) =3D function;
+		ACCESS_PRIVATE(timer, function) =3D fn;
 }
=20
 /**
@@ -1767,12 +1703,10 @@ bool hrtimer_active(const struct hrtimer *timer)
 		base =3D READ_ONCE(timer->base);
 		seq =3D raw_read_seqcount_begin(&base->seq);
=20
-		if (timer->state !=3D HRTIMER_STATE_INACTIVE ||
-		    base->running =3D=3D timer)
+		if (timer->state !=3D HRTIMER_STATE_INACTIVE || base->running =3D=3D timer)
 			return true;
=20
-	} while (read_seqcount_retry(&base->seq, seq) ||
-		 base !=3D READ_ONCE(timer->base));
+	} while (read_seqcount_retry(&base->seq, seq) || base !=3D READ_ONCE(timer-=
>base));
=20
 	return false;
 }
@@ -1795,11 +1729,9 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
  * a false negative if the read side got smeared over multiple consecutive
  * __run_hrtimer() invocations.
  */
-
-static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
-			  struct hrtimer_clock_base *base,
-			  struct hrtimer *timer, ktime_t *now,
-			  unsigned long flags) __must_hold(&cpu_base->lock)
+static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_=
clock_base *base,
+			  struct hrtimer *timer, ktime_t *now, unsigned long flags)
+	__must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	bool expires_in_hardirq;
@@ -1819,7 +1751,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_=
base,
 	 */
 	raw_write_seqcount_barrier(&base->seq);
=20
-	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
+	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, false);
 	fn =3D ACCESS_PRIVATE(timer, function);
=20
 	/*
@@ -1854,8 +1786,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_=
base,
 	 * hrtimer_start_range_ns() can have popped in and enqueued the timer
 	 * for us already.
 	 */
-	if (restart !=3D HRTIMER_NORESTART &&
-	    !(timer->state & HRTIMER_STATE_ENQUEUED))
+	if (restart !=3D HRTIMER_NORESTART && !(timer->state & HRTIMER_STATE_ENQUEU=
ED))
 		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS, false);
=20
 	/*
@@ -1874,8 +1805,8 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_=
base,
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t =
now,
 				 unsigned long flags, unsigned int active_mask)
 {
-	struct hrtimer_clock_base *base;
 	unsigned int active =3D cpu_base->active_bases & active_mask;
+	struct hrtimer_clock_base *base;
=20
 	for_each_active_base(base, cpu_base, active) {
 		struct timerqueue_node *node;
@@ -1951,11 +1882,10 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 retry:
 	cpu_base->in_hrtirq =3D 1;
 	/*
-	 * We set expires_next to KTIME_MAX here with cpu_base->lock
-	 * held to prevent that a timer is enqueued in our queue via
-	 * the migration code. This does not affect enqueueing of
-	 * timers which run their callback and need to be requeued on
-	 * this CPU.
+	 * Set expires_next to KTIME_MAX, which prevents that remote CPUs queue
+	 * timers while __hrtimer_run_queues() is expiring the clock bases.
+	 * Timers which are re/enqueued on the local CPU are not affected by
+	 * this.
 	 */
 	cpu_base->expires_next =3D KTIME_MAX;
=20
@@ -2069,8 +1999,7 @@ void hrtimer_run_queues(void)
  */
 static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 {
-	struct hrtimer_sleeper *t =3D
-		container_of(timer, struct hrtimer_sleeper, timer);
+	struct hrtimer_sleeper *t =3D container_of(timer, struct hrtimer_sleeper, t=
imer);
 	struct task_struct *task =3D t->task;
=20
 	t->task =3D NULL;
@@ -2088,8 +2017,7 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtim=
er *timer)
  * Wrapper around hrtimer_start_expires() for hrtimer_sleeper based timers
  * to allow PREEMPT_RT to tweak the delivery mode (soft/hardirq context)
  */
-void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
-				   enum hrtimer_mode mode)
+void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl, enum hrtimer_=
mode mode)
 {
 	/*
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
@@ -2105,8 +2033,8 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleep=
er *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
=20
-static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl,
-				    clockid_t clock_id, enum hrtimer_mode mode)
+static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl, clockid_t cl=
ock_id,
+				    enum hrtimer_mode mode)
 {
 	/*
 	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitly
@@ -2142,8 +2070,8 @@ static void __hrtimer_setup_sleeper(struct hrtimer_slee=
per *sl,
  * @clock_id:	the clock to be used
  * @mode:	timer mode abs/rel
  */
-void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
-				    clockid_t clock_id, enum hrtimer_mode mode)
+void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clockid_t cl=
ock_id,
+				    enum hrtimer_mode mode)
 {
 	debug_setup_on_stack(&sl->timer, clock_id, mode);
 	__hrtimer_setup_sleeper(sl, clock_id, mode);
@@ -2216,8 +2144,7 @@ static long __sched hrtimer_nanosleep_restart(struct re=
start_block *restart)
 	return ret;
 }
=20
-long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
-		       const clockid_t clockid)
+long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode, const clo=
ckid_t clockid)
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
@@ -2260,8 +2187,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __u=
ser *, rqtp,
 	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp =3D rmtp;
-	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
-				 CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_M=
ONOTONIC);
 }
=20
 #endif
@@ -2269,7 +2195,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __u=
ser *, rqtp,
 #ifdef CONFIG_COMPAT_32BIT_TIME
=20
 SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
-		       struct old_timespec32 __user *, rmtp)
+		struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 tu;
=20
@@ -2282,8 +2208,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32=
 __user *, rqtp,
 	current->restart_block.fn =3D do_no_restart_syscall;
 	current->restart_block.nanosleep.type =3D rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp =3D rmtp;
-	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
-				 CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_M=
ONOTONIC);
 }
 #endif
=20
@@ -2293,9 +2218,8 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32=
 __user *, rqtp,
 int hrtimers_prepare_cpu(unsigned int cpu)
 {
 	struct hrtimer_cpu_base *cpu_base =3D &per_cpu(hrtimer_bases, cpu);
-	int i;
=20
-	for (i =3D 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
+	for (int i =3D 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
 		struct hrtimer_clock_base *clock_b =3D &cpu_base->clock_base[i];
=20
 		clock_b->cpu_base =3D cpu_base;
@@ -2329,8 +2253,8 @@ int hrtimers_cpu_starting(unsigned int cpu)
 static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 				struct hrtimer_clock_base *new_base)
 {
-	struct hrtimer *timer;
 	struct timerqueue_node *node;
+	struct hrtimer *timer;
=20
 	while ((node =3D timerqueue_getnext(&old_base->active))) {
 		timer =3D container_of(node, struct hrtimer, node);
@@ -2342,7 +2266,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_b=
ase *old_base,
 		 * timer could be seen as !active and just vanish away
 		 * under us on another CPU
 		 */
-		__remove_hrtimer(timer, old_base, HRTIMER_STATE_ENQUEUED, 0);
+		__remove_hrtimer(timer, old_base, HRTIMER_STATE_ENQUEUED, false);
 		timer->base =3D new_base;
 		/*
 		 * Enqueue the timers on the new cpu. This does not
@@ -2358,7 +2282,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_b=
ase *old_base,
=20
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
-	int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TY=
PE_TIMER));
+	int ncpu =3D cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_=
TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
=20
 	old_base =3D this_cpu_ptr(&hrtimer_bases);
@@ -2371,10 +2295,8 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	raw_spin_lock(&old_base->lock);
 	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
=20
-	for (i =3D 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		migrate_hrtimer_list(&old_base->clock_base[i],
-				     &new_base->clock_base[i]);
-	}
+	for (int i =3D 0; i < HRTIMER_MAX_CLOCK_BASES; i++)
+		migrate_hrtimer_list(&old_base->clock_base[i], &new_base->clock_base[i]);
=20
 	/* Tell the other CPU to retrigger the next event */
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);

