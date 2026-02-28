Return-Path: <linux-tip-commits+bounces-8296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGFAEWsMo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:40:27 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A18311C40A4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 632703173AAE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3547DD40;
	Sat, 28 Feb 2026 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rTWpvofk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qkudomq4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC0280CF6;
	Sat, 28 Feb 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292986; cv=none; b=WRecDrq/q7AoD/iAyrWLgO3uzikbI32USDy/0oNv792ehWrvk8HN2J3bpNtNk3ktyIagqHAsvI2oMRgfLAk+JSh4htbvxq0xt8uJtpWhr0AdpCGoZAwE+pSQRIywfVLiMam1KZBRj93gFyirAXJHHep2Msg5cINbBAlcBP6KW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292986; c=relaxed/simple;
	bh=Ihzwd0IT+9IparAGtjSHr4ICbxRxpWaIhjPIBL5SLYU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HPBlSzbdr4o/PsI/oDdB4e0NFY7r/7HKbEFAshzKbiWQl0njLIKp7EAro5YlIX+rJePM4un3XpPb/cszJ1VqRqgFHydT2Nw6ztHal+tw12Ym9otkM7vlZ+rnXkhbGwfKXDpkvxcZXbDfj75ZkZoQE4/ahMwgpXzUn8y7DermMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rTWpvofk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qkudomq4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Oi1NMM5Tp/rQXRk1yYHqo3C5SYuCoA9H9EbJX6Nz5k=;
	b=rTWpvofkmGRbmO20nCJ0k+Lvds7c7IiUjj3xwCzz7Wa9oGXBFR5w8YU7hGpzBlY7DzjZov
	Qn3SzjKAe0d8Us1CTf0+D/Jvp1sDfRW1ia2HIGBzqmTo8KDariuwjWmhRQk6sAtATYIeEr
	Icd/eftgojvF+hWHb9hsh0lvc3llYA2cvqUSnAKQuvVCj78xKIf+sEYfoTMz/1zuxzVbW3
	rPG2MBYHNymnZR66um1/N8i0N7RA6YgzytdXxRQa78CsWw3QyXgneeRsOUv2SD+LaJMm0N
	LySW7l+9JwntjhhmOMjqdS+4Jx4bqDGT8Hbsa9lywJ0H1+of1W86+W6r3HsRcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Oi1NMM5Tp/rQXRk1yYHqo3C5SYuCoA9H9EbJX6Nz5k=;
	b=Qkudomq4mSxPf2GBy/aYxAOhhddpNieam1MQmHZZLFdhsH/GYlFlQV8YKQ7C5wZOsRiqYV
	+IM+sWWh36hXDAAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Avoid re-evaluation when nothing changed
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.338569372@kernel.org>
References: <20260224163431.338569372@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298193.1647592.15940221507703270036.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8296-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: A18311C40A4
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     b95c4442b02162904e9012e670b602ebeb3c6c1b
Gitweb:        https://git.kernel.org/tip/b95c4442b02162904e9012e670b602ebeb3=
c6c1b
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:14 +01:00

hrtimer: Avoid re-evaluation when nothing changed

Most times there is no change between hrtimer_interrupt() deferring the rearm
and the invocation of hrtimer_rearm_deferred(). In those cases it's a pointle=
ss
exercise to re-evaluate the next expiring timer.

Cache the required data and use it if nothing changed.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.338569372@kernel.org
---
 include/linux/hrtimer_defs.h | 53 +++++++++++++++++------------------
 kernel/time/hrtimer.c        | 45 ++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index 2c3bdbd..b6846ef 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -47,32 +47,31 @@ enum  hrtimer_base_type {
=20
 /**
  * struct hrtimer_cpu_base - the per cpu clock bases
- * @lock:		lock protecting the base and associated clock bases
- *			and timers
- * @cpu:		cpu number
- * @active_bases:	Bitfield to mark bases with active timers
- * @clock_was_set_seq:	Sequence counter of clock was set events
- * @hres_active:	State of high resolution mode
- * @deferred_rearm:	A deferred rearm is pending
- * @hang_detected:	The last hrtimer interrupt detected a hang
- * @softirq_activated:	displays, if the softirq is raised - update of softirq
- *			related settings is not required then.
- * @nr_events:		Total number of hrtimer interrupt events
- * @nr_retries:		Total number of hrtimer interrupt retries
- * @nr_hangs:		Total number of hrtimer interrupt hangs
- * @max_hang_time:	Maximum time spent in hrtimer_interrupt
- * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
- *			 expired
- * @online:		CPU is online from an hrtimers point of view
- * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
- *			callback to finish.
- * @expires_next:	absolute time of the next event, is required for remote
- *			hrtimer enqueue; it is the total first expiry time (hard
- *			and soft hrtimer are taken into account)
- * @next_timer:		Pointer to the first expiring timer
- * @softirq_expires_next: Time to check, if soft queues needs also to be exp=
ired
- * @softirq_next_timer: Pointer to the first expiring softirq based timer
- * @clock_base:		array of clock bases for this cpu
+ * @lock:			lock protecting the base and associated clock bases and timers
+ * @cpu:			cpu number
+ * @active_bases:		Bitfield to mark bases with active timers
+ * @clock_was_set_seq:		Sequence counter of clock was set events
+ * @hres_active:		State of high resolution mode
+ * @deferred_rearm:		A deferred rearm is pending
+ * @deferred_needs_update:	The deferred rearm must re-evaluate the first tim=
er
+ * @hang_detected:		The last hrtimer interrupt detected a hang
+ * @softirq_activated:		displays, if the softirq is raised - update of softi=
rq
+ *				related settings is not required then.
+ * @nr_events:			Total number of hrtimer interrupt events
+ * @nr_retries:			Total number of hrtimer interrupt retries
+ * @nr_hangs:			Total number of hrtimer interrupt hangs
+ * @max_hang_time:		Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock:	Lock which is taken while softirq based hrtimer are=
 expired
+ * @online:			CPU is online from an hrtimers point of view
+ * @timer_waiters:		A hrtimer_cancel() waiters for the timer callback to fin=
ish.
+ * @expires_next:		Absolute time of the next event, is required for remote
+ *				hrtimer enqueue; it is the total first expiry time (hard
+ *				and soft hrtimer are taken into account)
+ * @next_timer:			Pointer to the first expiring timer
+ * @softirq_expires_next:	Time to check, if soft queues needs also to be exp=
ired
+ * @softirq_next_timer:		Pointer to the first expiring softirq based timer
+ * @deferred_expires_next:	Cached expires next value for deferred rearm
+ * @clock_base:			Array of clock bases for this cpu
  *
  * Note: next_timer is just an optimization for __remove_hrtimer().
  *	 Do not dereference the pointer because it is not reliable on
@@ -85,6 +84,7 @@ struct hrtimer_cpu_base {
 	unsigned int			clock_was_set_seq;
 	bool				hres_active;
 	bool				deferred_rearm;
+	bool				deferred_needs_update;
 	bool				hang_detected;
 	bool				softirq_activated;
 	bool				online;
@@ -102,6 +102,7 @@ struct hrtimer_cpu_base {
 	struct hrtimer			*next_timer;
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
+	ktime_t				deferred_expires_next;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
 	call_single_data_t		csd;
 } ____cacheline_aligned;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2e5f0e2..e9592cb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -919,8 +919,10 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *cp=
u_base, unsigned int act
 		return false;
=20
 	/* If a deferred rearm is pending the remote CPU will take care of it */
-	if (cpu_base->deferred_rearm)
+	if (cpu_base->deferred_rearm) {
+		cpu_base->deferred_needs_update =3D true;
 		return false;
+	}
=20
 	/*
 	 * Walk the affected clock bases and check whether the first expiring
@@ -1141,7 +1143,12 @@ static void __remove_hrtimer(struct hrtimer *timer, st=
ruct hrtimer_clock_base *b
 	 * a local timer is removed to be immediately restarted. That's handled
 	 * at the call site.
 	 */
-	if (reprogram && timer =3D=3D cpu_base->next_timer && !timer->is_lazy)
+	if (!reprogram || timer !=3D cpu_base->next_timer || timer->is_lazy)
+		return;
+
+	if (cpu_base->deferred_rearm)
+		cpu_base->deferred_needs_update =3D true;
+	else
 		hrtimer_force_reprogram(cpu_base, /* skip_equal */ true);
 }
=20
@@ -1328,8 +1335,10 @@ static bool __hrtimer_start_range_ns(struct hrtimer *t=
imer, ktime_t tim, u64 del
 	}
=20
 	/* If a deferred rearm is pending skip reprogramming the device */
-	if (cpu_base->deferred_rearm)
+	if (cpu_base->deferred_rearm) {
+		cpu_base->deferred_needs_update =3D true;
 		return false;
+	}
=20
 	if (!was_first || cpu_base !=3D this_cpu_base) {
 		/*
@@ -1939,8 +1948,7 @@ static __latent_entropy void hrtimer_run_softirq(void)
  * Very similar to hrtimer_force_reprogram(), except it deals with
  * deferred_rearm and hang_detected.
  */
-static void hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now,
-			  ktime_t expires_next, bool deferred)
+static void hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t expires=
_next, bool deferred)
 {
 	cpu_base->expires_next =3D expires_next;
 	cpu_base->deferred_rearm =3D false;
@@ -1950,7 +1958,7 @@ static void hrtimer_rearm(struct hrtimer_cpu_base *cpu_=
base, ktime_t now,
 		 * Give the system a chance to do something else than looping
 		 * on hrtimer interrupts.
 		 */
-		expires_next =3D ktime_add_ns(now, 100 * NSEC_PER_MSEC);
+		expires_next =3D ktime_add_ns(ktime_get(), 100 * NSEC_PER_MSEC);
 		cpu_base->hang_detected =3D false;
 	}
 	hrtimer_rearm_event(expires_next, deferred);
@@ -1960,27 +1968,36 @@ static void hrtimer_rearm(struct hrtimer_cpu_base *cp=
u_base, ktime_t now,
 void __hrtimer_rearm_deferred(void)
 {
 	struct hrtimer_cpu_base *cpu_base =3D this_cpu_ptr(&hrtimer_bases);
-	ktime_t now, expires_next;
+	ktime_t expires_next;
=20
 	if (!cpu_base->deferred_rearm)
 		return;
=20
 	guard(raw_spinlock)(&cpu_base->lock);
-	now =3D hrtimer_update_base(cpu_base);
-	expires_next =3D hrtimer_update_next_event(cpu_base);
-	hrtimer_rearm(cpu_base, now, expires_next, true);
+	if (cpu_base->deferred_needs_update) {
+		hrtimer_update_base(cpu_base);
+		expires_next =3D hrtimer_update_next_event(cpu_base);
+	} else {
+		/* No timer added/removed. Use the cached value */
+		expires_next =3D cpu_base->deferred_expires_next;
+	}
+	hrtimer_rearm(cpu_base, expires_next, true);
 }
=20
 static __always_inline void
-hrtimer_interrupt_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now, ktim=
e_t expires_next)
+hrtimer_interrupt_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t expires_n=
ext)
 {
+	/* hrtimer_interrupt() just re-evaluated the first expiring timer */
+	cpu_base->deferred_needs_update =3D false;
+	/* Cache the expiry time */
+	cpu_base->deferred_expires_next =3D expires_next;
 	set_thread_flag(TIF_HRTIMER_REARM);
 }
 #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
 static __always_inline void
-hrtimer_interrupt_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now, ktim=
e_t expires_next)
+hrtimer_interrupt_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t expires_n=
ext)
 {
-	hrtimer_rearm(cpu_base, now, expires_next, false);
+	hrtimer_rearm(cpu_base, expires_next, false);
 }
 #endif  /* !CONFIG_HRTIMER_REARM_DEFERRED */
=20
@@ -2041,7 +2058,7 @@ retry:
 		cpu_base->hang_detected =3D true;
 	}
=20
-	hrtimer_interrupt_rearm(cpu_base, now, expires_next);
+	hrtimer_interrupt_rearm(cpu_base, expires_next);
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 }
=20

