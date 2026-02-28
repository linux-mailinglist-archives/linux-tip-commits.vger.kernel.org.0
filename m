Return-Path: <linux-tip-commits+bounces-8304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCZ6DdENo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:25 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7E41C41A8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB98631A5886
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9247ECC2;
	Sat, 28 Feb 2026 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Az1zUvrl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2Sz8+Eh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FF47DFAA;
	Sat, 28 Feb 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292996; cv=none; b=bpofQ2cOpHb5QiLkidlPymQYHV6BfUII9k73s/MjRpRWce4oGsBDiZvhUxIl+kwYEXLbIZiiY+KtKsCcHBRFUAx+uUAncuBTEc+C8h2u4//YM4e9qlrXO0pI3uViZtI/NmQsxnSmcS5qNkrVW++jQvK/+a5sIqvjN90ZHwKthKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292996; c=relaxed/simple;
	bh=gNZWKewQhHWRsxyLGCV2L83NtYvpx04GAk46wm3bwho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PEXVVaiOdX2HyA/sb/YwkhDdfCCUmzbqQ5/V0uEBuWk9zNzyJPA4OYeUk8WNpx0igo91UvGCYugQpblxauQvz/etg2gTqTWx+3o8fmcr30qJGp8HJI3hN0Kz4NB0uTFtQ/OIxnUXpa7y1QgayzXKVbb/KRN83PZGPvTMuOO2Ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Az1zUvrl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2Sz8+Eh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u280IN/e7ZtIvLuq/cccgmSa+JcZCEfhO8FRHOpUqrY=;
	b=Az1zUvrlq1ySOIbdaaCu9ErvemcmASuCtkT/f+2zKVZszDuBEOJgn7gGJpi3bVCxByOQ75
	Dw82ZnP7xO6NcQ0/i1PmhFqRecqDqzCxCdc4FQmN7nUe3cWIEVW2jHEmv6J2ax+BcGsnfS
	jrruYZagDbrX/A7eK8gW0tcxqN/UbFD8ZSOu314E6p0+mKtrIYQoskgeLwxw6o1k868Wud
	3oRJEykq2UJyqssAvm6JUPABZXLOmk9UHqhPR3dq3OgQtGkxjUY9zi4nxS5alqEwktj8ZR
	cDv2HnE+nC20qHf6F7ynEx7S0Dsa7G78aXAFy01vnNrNAQO9OPr7tpBbfssw8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u280IN/e7ZtIvLuq/cccgmSa+JcZCEfhO8FRHOpUqrY=;
	b=b2Sz8+Eh9ie1Gw8JEcRlSXcyC89tO/2v6R85C1I5f/EQxn5G9wZhwPGUQJsFUa3KBMMPQx
	3W65ruTycfOoNuDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Re-arrange hrtimer_interrupt()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.870639266@kernel.org>
References: <20260224163430.870639266@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298954.1647592.17487167022597883051.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8304-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 8D7E41C41A8
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     2889243848560b6b0211aba401d2fc122070ba2f
Gitweb:        https://git.kernel.org/tip/2889243848560b6b0211aba401d2fc12207=
0ba2f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:12 +01:00

hrtimer: Re-arrange hrtimer_interrupt()

Rework hrtimer_interrupt() such that reprogramming is split out into an
independent function at the end of the interrupt.

This prepares for reprogramming getting delayed beyond the end of
hrtimer_interrupt().

Notably, this changes the hang handling to always wait 100ms instead of
trying to keep it proportional to the actual delay. This simplifies the
state, also this really shouldn't be happening.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.870639266@kernel.org
---
 kernel/time/hrtimer.c | 93 +++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c6fc164..2e05a18 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -690,6 +690,12 @@ static inline int hrtimer_hres_active(struct hrtimer_cpu=
_base *cpu_base)
 		cpu_base->hres_active : 0;
 }
=20
+static inline void hrtimer_rearm_event(ktime_t expires_next, bool deferred)
+{
+	trace_hrtimer_rearm(expires_next, deferred);
+	tick_program_event(expires_next, 1);
+}
+
 static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base, struct hr=
timer *next_timer,
 				ktime_t expires_next)
 {
@@ -715,7 +721,7 @@ static void __hrtimer_reprogram(struct hrtimer_cpu_base *=
cpu_base, struct hrtime
 	if (!hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
 		return;
=20
-	tick_program_event(expires_next, 1);
+	hrtimer_rearm_event(expires_next, false);
 }
=20
 /*
@@ -1940,6 +1946,28 @@ static __latent_entropy void hrtimer_run_softirq(void)
 #ifdef CONFIG_HIGH_RES_TIMERS
=20
 /*
+ * Very similar to hrtimer_force_reprogram(), except it deals with
+ * in_hrtirq and hang_detected.
+ */
+static void hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+{
+	ktime_t expires_next =3D hrtimer_update_next_event(cpu_base);
+
+	cpu_base->expires_next =3D expires_next;
+	cpu_base->in_hrtirq =3D false;
+
+	if (unlikely(cpu_base->hang_detected)) {
+		/*
+		 * Give the system a chance to do something else than looping
+		 * on hrtimer interrupts.
+		 */
+		expires_next =3D ktime_add_ns(now, 100 * NSEC_PER_MSEC);
+		cpu_base->hang_detected =3D false;
+	}
+	hrtimer_rearm_event(expires_next, false);
+}
+
+/*
  * High resolution timer interrupt
  * Called with interrupts disabled
  */
@@ -1974,63 +2002,30 @@ retry:
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
=20
-	/* Reevaluate the clock bases for the [soft] next expiry */
-	expires_next =3D hrtimer_update_next_event(cpu_base);
-	/*
-	 * Store the new expiry value so the migration code can verify
-	 * against it.
-	 */
-	cpu_base->expires_next =3D expires_next;
-	cpu_base->in_hrtirq =3D false;
-	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
-
-	/* Reprogramming necessary ? */
-	if (!tick_program_event(expires_next, 0)) {
-		cpu_base->hang_detected =3D false;
-		return;
-	}
-
 	/*
 	 * The next timer was already expired due to:
 	 * - tracing
 	 * - long lasting callbacks
 	 * - being scheduled away when running in a VM
 	 *
-	 * We need to prevent that we loop forever in the hrtimer
-	 * interrupt routine. We give it 3 attempts to avoid
-	 * overreacting on some spurious event.
-	 *
-	 * Acquire base lock for updating the offsets and retrieving
-	 * the current time.
+	 * We need to prevent that we loop forever in the hrtiner interrupt
+	 * routine. We give it 3 attempts to avoid overreacting on some
+	 * spurious event.
 	 */
-	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 	now =3D hrtimer_update_base(cpu_base);
-	cpu_base->nr_retries++;
-	if (++retries < 3)
-		goto retry;
-	/*
-	 * Give the system a chance to do something else than looping
-	 * here. We stored the entry time, so we know exactly how long
-	 * we spent here. We schedule the next event this amount of
-	 * time away.
-	 */
-	cpu_base->nr_hangs++;
-	cpu_base->hang_detected =3D true;
-	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	expires_next =3D hrtimer_update_next_event(cpu_base);
+	if (expires_next < now) {
+		if (++retries < 3)
+			goto retry;
+
+		delta =3D ktime_sub(now, entry_time);
+		cpu_base->max_hang_time =3D max_t(unsigned int, cpu_base->max_hang_time, d=
elta);
+		cpu_base->nr_hangs++;
+		cpu_base->hang_detected =3D true;
+	}
=20
-	delta =3D ktime_sub(now, entry_time);
-	if ((unsigned int)delta > cpu_base->max_hang_time)
-		cpu_base->max_hang_time =3D (unsigned int) delta;
-	/*
-	 * Limit it to a sensible value as we enforce a longer
-	 * delay. Give the CPU at least 100ms to catch up.
-	 */
-	if (delta > 100 * NSEC_PER_MSEC)
-		expires_next =3D ktime_add_ns(now, 100 * NSEC_PER_MSEC);
-	else
-		expires_next =3D ktime_add(now, delta);
-	tick_program_event(expires_next, 1);
-	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
+	hrtimer_rearm(cpu_base, now);
+	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 }
 #endif /* !CONFIG_HIGH_RES_TIMERS */
=20

