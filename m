Return-Path: <linux-tip-commits+bounces-8294-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO25ONkLo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8294-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:38:01 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 017501C4048
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58B2930636ED
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC66747D95C;
	Sat, 28 Feb 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Wi/3jwg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nfwtHkb/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A947D949;
	Sat, 28 Feb 2026 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292984; cv=none; b=jxtRc3NgGxvNCE1U4bcsZtnnp4GdUuX6k9IxrIz7GhAcvonkve6eo4ckzikIXIdd7HcE2et/Ebn+3+gQnNw9+XOKyW2eLQ7dDheYwONSt5ogeKQYhaxJeJm2zTX3NTuErxEFMOxCzZTeqQg7PkLZTjZe0D2jcMTug/9DZTp7vSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292984; c=relaxed/simple;
	bh=MC2vGlwVmbDvyj16aKKNHfYPoMlmaXZCjYMWNBp9v4Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sIYuH1BAhF7BDGvFAPgFNS2A5gOMpbNJ1xOKIOYymfP97iAVdbVl+vdgLgIX8rbUHUKAYnFJrgZVBEhzVNvE1V+TwY6oaQpgis65/ucxBPxA2T82hjJWmGdFDiYBy4R25SSjWPPCbhTrvoZmpR5b7jMxhQeUzn+ArDzZQwf2irU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Wi/3jwg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nfwtHkb/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxeU7pILmsmnx/2waWNuh/0sGMwPP0y/xDqRMs8Vq00=;
	b=3Wi/3jwgNE8vEwIH/I6OMVpKrf+m6x565V3ZiYvNOz3MBxvUAdMBTSkgsf0TaLnQS0G5Mc
	Ix8c0SHYd/Ncw1dxt8+VSBQkOD+ubNYhRVn8BiP0PF3rsUlKIzS3Ab80tuXKwujO8ybIKD
	pZlcj3h/sDOESSm4X97eRei80F7/2USi94+IsA8y2l8iyWTsk+dZYUZyd07wDPLcXRmfQs
	6PtSpz9HlaQmieT/n7B23A0cxDrH5gKvr4ccpLADOyluGm9P7SHTzrSgEnKa8AkikyalYg
	UrVUwovmnOVhKTAsNMQH2fUTakU0zn1ok9L2gRZcC405NYv6NSYcZrDkBAaD9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxeU7pILmsmnx/2waWNuh/0sGMwPP0y/xDqRMs8Vq00=;
	b=nfwtHkb/xvyO8ifHHB6q7bbvhRXRZ2uUxBr9DuerkbNqGBMyj7Ugg1Au7oogbtjf3WwtY+
	3jsDe0ziBd0wRRAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Rework next event evaluation
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.468186893@kernel.org>
References: <20260224163431.468186893@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297962.1647592.9036759819639121526.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8294-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,infradead.org:email,linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 017501C4048
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     2bd1cc24fafc84be844c9ef66aa819d7dec285bf
Gitweb:        https://git.kernel.org/tip/2bd1cc24fafc84be844c9ef66aa819d7dec=
285bf
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:15 +01:00

hrtimer: Rework next event evaluation

The per clock base cached expiry time allows to do a more efficient
evaluation of the next expiry on a CPU.

Separate the reprogramming evaluation from the NOHZ idle evaluation which
needs to exclude the NOHZ timer to keep the reprogramming path lean and
clean.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.468186893@kernel.org
---
 kernel/time/hrtimer.c | 120 +++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 51 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d70899a..aa1cb4f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -546,49 +546,67 @@ __next_base(struct hrtimer_cpu_base *cpu_base, unsigned=
 int *active)
 #define for_each_active_base(base, cpu_base, active)		\
 	while ((base =3D __next_base((cpu_base), &(active))))
=20
-static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
-					 const struct hrtimer *exclude,
-					 unsigned int active, ktime_t expires_next)
+#if defined(CONFIG_NO_HZ_COMMON)
+/*
+ * Same as hrtimer_bases_next_event() below, but skips the excluded timer and
+ * does not update cpu_base->next_timer/expires.
+ */
+static ktime_t hrtimer_bases_next_event_without(struct hrtimer_cpu_base *cpu=
_base,
+						const struct hrtimer *exclude,
+						unsigned int active, ktime_t expires_next)
 {
 	struct hrtimer_clock_base *base;
 	ktime_t expires;
=20
+	lockdep_assert_held(&cpu_base->lock);
+
 	for_each_active_base(base, cpu_base, active) {
-		struct timerqueue_node *next;
-		struct hrtimer *timer;
+		expires =3D ktime_sub(base->expires_next, base->offset);
+		if (expires >=3D expires_next)
+			continue;
=20
-		next =3D timerqueue_getnext(&base->active);
-		timer =3D container_of(next, struct hrtimer, node);
-		if (timer =3D=3D exclude) {
-			/* Get to the next timer in the queue. */
-			next =3D timerqueue_iterate_next(next);
-			if (!next)
-				continue;
+		/*
+		 * If the excluded timer is the first on this base evaluate the
+		 * next timer.
+		 */
+		struct timerqueue_node *node =3D timerqueue_getnext(&base->active);
=20
-			timer =3D container_of(next, struct hrtimer, node);
+		if (unlikely(&exclude->node =3D=3D node)) {
+			node =3D timerqueue_iterate_next(node);
+			if (!node)
+				continue;
+			expires =3D ktime_sub(node->expires, base->offset);
+			if (expires >=3D expires_next)
+				continue;
 		}
-		expires =3D ktime_sub(hrtimer_get_expires(timer), base->offset);
-		if (expires < expires_next) {
-			expires_next =3D expires;
+		expires_next =3D expires;
+	}
+	/* If base->offset changed, the result might be negative */
+	return max(expires_next, 0);
+}
+#endif
=20
-			/* Skip cpu_base update if a timer is being excluded. */
-			if (exclude)
-				continue;
+static __always_inline struct hrtimer *clock_base_next_timer(struct hrtimer_=
clock_base *base)
+{
+	struct timerqueue_node *next =3D timerqueue_getnext(&base->active);
+
+	return container_of(next, struct hrtimer, node);
+}
=20
-			if (timer->is_soft)
-				cpu_base->softirq_next_timer =3D timer;
-			else
-				cpu_base->next_timer =3D timer;
+/* Find the base with the earliest expiry */
+static void hrtimer_bases_first(struct hrtimer_cpu_base *cpu_base,unsigned i=
nt active,
+				ktime_t *expires_next, struct hrtimer **next_timer)
+{
+	struct hrtimer_clock_base *base;
+	ktime_t expires;
+
+	for_each_active_base(base, cpu_base, active) {
+		expires =3D ktime_sub(base->expires_next, base->offset);
+		if (expires < *expires_next) {
+			*expires_next =3D expires;
+			*next_timer =3D clock_base_next_timer(base);
 		}
 	}
-	/*
-	 * clock_was_set() might have changed base->offset of any of
-	 * the clock bases so the result might be negative. Fix it up
-	 * to prevent a false positive in clockevents_program_event().
-	 */
-	if (expires_next < 0)
-		expires_next =3D 0;
-	return expires_next;
 }
=20
 /*
@@ -617,19 +635,22 @@ static ktime_t __hrtimer_get_next_event(struct hrtimer_=
cpu_base *cpu_base, unsig
 	ktime_t expires_next =3D KTIME_MAX;
 	unsigned int active;
=20
+	lockdep_assert_held(&cpu_base->lock);
+
 	if (!cpu_base->softirq_activated && (active_mask & HRTIMER_ACTIVE_SOFT)) {
 		active =3D cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
-		cpu_base->softirq_next_timer =3D NULL;
-		expires_next =3D __hrtimer_next_event_base(cpu_base, NULL, active, KTIME_M=
AX);
-		next_timer =3D cpu_base->softirq_next_timer;
+		if (active)
+			hrtimer_bases_first(cpu_base, active, &expires_next, &next_timer);
+		cpu_base->softirq_next_timer =3D next_timer;
 	}
=20
 	if (active_mask & HRTIMER_ACTIVE_HARD) {
 		active =3D cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
+		if (active)
+			hrtimer_bases_first(cpu_base, active, &expires_next, &next_timer);
 		cpu_base->next_timer =3D next_timer;
-		expires_next =3D __hrtimer_next_event_base(cpu_base, NULL, active, expires=
_next);
 	}
-	return expires_next;
+	return max(expires_next, 0);
 }
=20
 static ktime_t hrtimer_update_next_event(struct hrtimer_cpu_base *cpu_base)
@@ -724,11 +745,7 @@ static void __hrtimer_reprogram(struct hrtimer_cpu_base =
*cpu_base, struct hrtime
 	hrtimer_rearm_event(expires_next, false);
 }
=20
-/*
- * Reprogram the event source with checking both queues for the
- * next event
- * Called with interrupts disabled and base->lock held
- */
+/* Reprogram the event source with a evaluation of all clock bases */
 static void hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, bool =
skip_equal)
 {
 	ktime_t expires_next =3D hrtimer_update_next_event(cpu_base);
@@ -1662,19 +1679,20 @@ u64 hrtimer_next_event_without(const struct hrtimer *=
exclude)
 {
 	struct hrtimer_cpu_base *cpu_base =3D this_cpu_ptr(&hrtimer_bases);
 	u64 expires =3D KTIME_MAX;
+	unsigned int active;
=20
 	guard(raw_spinlock_irqsave)(&cpu_base->lock);
-	if (hrtimer_hres_active(cpu_base)) {
-		unsigned int active;
+	if (!hrtimer_hres_active(cpu_base))
+		return expires;
=20
-		if (!cpu_base->softirq_activated) {
-			active =3D cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
-			expires =3D __hrtimer_next_event_base(cpu_base, exclude, active, KTIME_MA=
X);
-		}
-		active =3D cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
-		expires =3D __hrtimer_next_event_base(cpu_base, exclude, active, expires);
-	}
-	return expires;
+	active =3D cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
+	if (active && !cpu_base->softirq_activated)
+		expires =3D hrtimer_bases_next_event_without(cpu_base, exclude, active, KT=
IME_MAX);
+
+	active =3D cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
+	if (!active)
+		return expires;
+	return hrtimer_bases_next_event_without(cpu_base, exclude, active, expires);
 }
 #endif
=20

