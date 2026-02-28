Return-Path: <linux-tip-commits+bounces-8289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPlyF40Lo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:45 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D61121C3FFE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04FE330F8519
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD047CC7A;
	Sat, 28 Feb 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lo0w4siO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PSn6HABC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F2332EA1;
	Sat, 28 Feb 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292978; cv=none; b=SFmokXvQoPAThbQJ1mqmajHSMU7N+wbgwsJ3VjYL7CzqqKfsXVLLK6F4D0kE6KkdA2z2ryIG4LoR4RIbIE7xpI9GpESVpVtpPJqpxYpp7CWOlx//WXBzoHAZzVfxfnmO9u28FpchNKF3JQpAbl/PYdFxSXxxfehZQ5dKO1VYwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292978; c=relaxed/simple;
	bh=ESK4V1ZzCGa2QFZWbEzqZ7i/MTkyetIF1A/k1MvSEAE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NDGv9o2b4iDKx1fWoV06vWjXw2Yj3BPGuPocHWKtmn3w+dYgv75HQEa704LzeBZZZrKDrr11Kkp5y/9Bh4/mWjI7UsN45G3j2O6a6eh7E6ObjJ5oYQ0v6iWkDRmE1PHFw9Ox+MQFXjPUzyB+QVcwObf+fte/QHHJ543s61VHWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lo0w4siO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PSn6HABC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWH121U3ohmBC6IVhJm0Sj5foBgPTa00/fNLeYfToew=;
	b=lo0w4siOLfQ0LHPMshhLRSibrjqrSvG6U0apbiBg4zLtE/s7+HICTBgvTOZPrZjPFqwJwX
	EB6dMtkNTjxq6gZnkfetJo7BgyLV+BjvKbpQVRvB5itxbflM9DUhVA6c7Os+U5Hy1a+/dm
	XJhu/+YrgCxv0q92smeOu72QBjuPW85eNEmDSck4buB3m73ZLSyZgDiLCfSLdxdVlD3stn
	VFjRFmSJb/7UpGoR6oWCvZc0kCY0QNT81CItmStO0UtVRBVtIw/lVR4kiO5s6psVCnZqeB
	A7CwamUTL7mcV118jZis58rCF8WUnoRe/2fSci+DwQA0+ddtHjrMryvoLJJMGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWH121U3ohmBC6IVhJm0Sj5foBgPTa00/fNLeYfToew=;
	b=PSn6HABCUWhfTY8PI10Q4aIW9EaL3MEC6vL4pzcjiBjANXWPvjDFWi6LF6U+KUNn7Z5lmR
	89ZgpkLc0WXF+WCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Use linked timerqueue
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.806643179@kernel.org>
References: <20260224163431.806643179@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297394.1647592.273934701213726341.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8289-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: D61121C3FFE
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     b7418e6e9b87b849af4df93d527ff83498d1e4c3
Gitweb:        https://git.kernel.org/tip/b7418e6e9b87b849af4df93d527ff83498d=
1e4c3
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:16 +01:00

hrtimer: Use linked timerqueue

To prepare for optimizing the rearming of enqueued timers, switch to the
linked timerqueue. That allows to check whether the new expiry time changes
the position of the timer in the RB tree or not, by checking the new expiry
time against the previous and the next timers expiry.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.806643179@kernel.org
---
 include/linux/hrtimer_defs.h  | 16 ++++++++--------
 include/linux/hrtimer_types.h |  8 ++++----
 kernel/time/hrtimer.c         | 34 +++++++++++++++++-----------------
 kernel/time/timer_list.c      | 10 ++++------
 4 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index fb38df4..0f851b2 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -25,14 +25,14 @@
  * @offset:		offset of this clock to the monotonic base
  */
 struct hrtimer_clock_base {
-	struct hrtimer_cpu_base	*cpu_base;
-	unsigned int		index;
-	clockid_t		clockid;
-	seqcount_raw_spinlock_t	seq;
-	ktime_t			expires_next;
-	struct hrtimer		*running;
-	struct timerqueue_head	active;
-	ktime_t			offset;
+	struct hrtimer_cpu_base		*cpu_base;
+	unsigned int			index;
+	clockid_t			clockid;
+	seqcount_raw_spinlock_t		seq;
+	ktime_t				expires_next;
+	struct hrtimer			*running;
+	struct timerqueue_linked_head	active;
+	ktime_t				offset;
 } __hrtimer_clock_base_align;
=20
 enum  hrtimer_base_type {
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index 0e22bc9..b5dacc8 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -17,7 +17,7 @@ enum hrtimer_restart {
=20
 /**
  * struct hrtimer - the basic hrtimer structure
- * @node:	timerqueue node, which also manages node.expires,
+ * @node:	Linked timerqueue node, which also manages node.expires,
  *		the absolute expiry time in the hrtimers internal
  *		representation. The time is related to the clock on
  *		which the timer is based. Is setup by adding
@@ -39,15 +39,15 @@ enum hrtimer_restart {
  * The hrtimer structure must be initialized by hrtimer_setup()
  */
 struct hrtimer {
-	struct timerqueue_node		node;
-	ktime_t				_softexpires;
-	enum hrtimer_restart		(*__private function)(struct hrtimer *);
+	struct timerqueue_linked_node	node;
 	struct hrtimer_clock_base	*base;
 	bool				is_queued;
 	bool				is_rel;
 	bool				is_soft;
 	bool				is_hard;
 	bool				is_lazy;
+	ktime_t				_softexpires;
+	enum hrtimer_restart		(*__private function)(struct hrtimer *);
 };
=20
 #endif /* _LINUX_HRTIMER_TYPES_H */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d1e5848..5e45982 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -557,10 +557,10 @@ static ktime_t hrtimer_bases_next_event_without(struct =
hrtimer_cpu_base *cpu_bas
 		 * If the excluded timer is the first on this base evaluate the
 		 * next timer.
 		 */
-		struct timerqueue_node *node =3D timerqueue_getnext(&base->active);
+		struct timerqueue_linked_node *node =3D timerqueue_linked_first(&base->act=
ive);
=20
 		if (unlikely(&exclude->node =3D=3D node)) {
-			node =3D timerqueue_iterate_next(node);
+			node =3D timerqueue_linked_next(node);
 			if (!node)
 				continue;
 			expires =3D ktime_sub(node->expires, base->offset);
@@ -576,7 +576,7 @@ static ktime_t hrtimer_bases_next_event_without(struct hr=
timer_cpu_base *cpu_bas
=20
 static __always_inline struct hrtimer *clock_base_next_timer(struct hrtimer_=
clock_base *base)
 {
-	struct timerqueue_node *next =3D timerqueue_getnext(&base->active);
+	struct timerqueue_linked_node *next =3D timerqueue_linked_first(&base->acti=
ve);
=20
 	return container_of(next, struct hrtimer, node);
 }
@@ -938,9 +938,9 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *cpu=
_base, unsigned int act
 	active &=3D cpu_base->active_bases;
=20
 	for_each_active_base(base, cpu_base, active) {
-		struct timerqueue_node *next;
+		struct timerqueue_linked_node *next;
=20
-		next =3D timerqueue_getnext(&base->active);
+		next =3D timerqueue_linked_first(&base->active);
 		expires =3D ktime_sub(next->expires, base->offset);
 		if (expires < cpu_base->expires_next)
 			return true;
@@ -1112,7 +1112,7 @@ static bool enqueue_hrtimer(struct hrtimer *timer, stru=
ct hrtimer_clock_base *ba
 	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->is_queued, HRTIMER_STATE_ENQUEUED);
=20
-	if (!timerqueue_add(&base->active, &timer->node))
+	if (!timerqueue_linked_add(&base->active, &timer->node))
 		return false;
=20
 	base->expires_next =3D hrtimer_get_expires(timer);
@@ -1121,7 +1121,7 @@ static bool enqueue_hrtimer(struct hrtimer *timer, stru=
ct hrtimer_clock_base *ba
=20
 static inline void base_update_next_timer(struct hrtimer_clock_base *base)
 {
-	struct timerqueue_node *next =3D timerqueue_getnext(&base->active);
+	struct timerqueue_linked_node *next =3D timerqueue_linked_first(&base->acti=
ve);
=20
 	base->expires_next =3D next ? next->expires : KTIME_MAX;
 }
@@ -1148,9 +1148,9 @@ static void __remove_hrtimer(struct hrtimer *timer, str=
uct hrtimer_clock_base *b
 	/* Pairs with the lockless read in hrtimer_is_queued() */
 	WRITE_ONCE(timer->is_queued, newstate);
=20
-	was_first =3D &timer->node =3D=3D timerqueue_getnext(&base->active);
+	was_first =3D !timerqueue_linked_prev(&timer->node);
=20
-	if (!timerqueue_del(&base->active, &timer->node))
+	if (!timerqueue_linked_del(&base->active, &timer->node))
 		cpu_base->active_bases &=3D ~(1 << base->index);
=20
 	/* Nothing to update if this was not the first timer in the base */
@@ -1212,8 +1212,8 @@ remove_and_enqueue_same_base(struct hrtimer *timer, str=
uct hrtimer_clock_base *b
 	/* Remove it from the timer queue if active */
 	if (timer->is_queued) {
 		debug_hrtimer_deactivate(timer);
-		was_first =3D &timer->node =3D=3D timerqueue_getnext(&base->active);
-		timerqueue_del(&base->active, &timer->node);
+		was_first =3D !timerqueue_linked_prev(&timer->node);
+		timerqueue_linked_del(&base->active, &timer->node);
 	}
=20
 	/* Set the new expiry time */
@@ -1226,7 +1226,7 @@ remove_and_enqueue_same_base(struct hrtimer *timer, str=
uct hrtimer_clock_base *b
 	WRITE_ONCE(timer->is_queued, HRTIMER_STATE_ENQUEUED);
=20
 	/* If it's the first expiring timer now or again, update base */
-	if (timerqueue_add(&base->active, &timer->node)) {
+	if (timerqueue_linked_add(&base->active, &timer->node)) {
 		base->expires_next =3D expires;
 		return true;
 	}
@@ -1758,7 +1758,7 @@ static void __hrtimer_setup(struct hrtimer *timer, enum=
 hrtimer_restart (*fn)(st
 	timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);
 	timer->is_lazy =3D !!(mode & HRTIMER_MODE_LAZY_REARM);
 	timer->base =3D &cpu_base->clock_base[base];
-	timerqueue_init(&timer->node);
+	timerqueue_linked_init(&timer->node);
=20
 	if (WARN_ON_ONCE(!fn))
 		ACCESS_PRIVATE(timer, function) =3D hrtimer_dummy_timeout;
@@ -1923,7 +1923,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_=
base, struct hrtimer_cloc
=20
 static __always_inline struct hrtimer *clock_base_next_timer_safe(struct hrt=
imer_clock_base *base)
 {
-	struct timerqueue_node *next =3D timerqueue_getnext(&base->active);
+	struct timerqueue_linked_node *next =3D timerqueue_linked_first(&base->acti=
ve);
=20
 	return next ? container_of(next, struct hrtimer, node) : NULL;
 }
@@ -2369,7 +2369,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
=20
 		clock_b->cpu_base =3D cpu_base;
 		seqcount_raw_spinlock_init(&clock_b->seq, &cpu_base->lock);
-		timerqueue_init_head(&clock_b->active);
+		timerqueue_linked_init_head(&clock_b->active);
 	}
=20
 	cpu_base->cpu =3D cpu;
@@ -2399,10 +2399,10 @@ int hrtimers_cpu_starting(unsigned int cpu)
 static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 				struct hrtimer_clock_base *new_base)
 {
-	struct timerqueue_node *node;
+	struct timerqueue_linked_node *node;
 	struct hrtimer *timer;
=20
-	while ((node =3D timerqueue_getnext(&old_base->active))) {
+	while ((node =3D timerqueue_linked_first(&old_base->active))) {
 		timer =3D container_of(node, struct hrtimer, node);
 		BUG_ON(hrtimer_callback_running(timer));
 		debug_hrtimer_deactivate(timer);
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 19e6182..e2e14fd 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -56,13 +56,11 @@ print_timer(struct seq_file *m, struct hrtimer *taddr, st=
ruct hrtimer *timer,
 		(long long)(ktime_to_ns(hrtimer_get_expires(timer)) - now));
 }
=20
-static void
-print_active_timers(struct seq_file *m, struct hrtimer_clock_base *base,
-		    u64 now)
+static void print_active_timers(struct seq_file *m, struct hrtimer_clock_bas=
e *base, u64 now)
 {
+	struct timerqueue_linked_node *curr;
 	struct hrtimer *timer, tmp;
 	unsigned long next =3D 0, i;
-	struct timerqueue_node *curr;
 	unsigned long flags;
=20
 next_one:
@@ -72,13 +70,13 @@ next_one:
=20
 	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
=20
-	curr =3D timerqueue_getnext(&base->active);
+	curr =3D timerqueue_linked_first(&base->active);
 	/*
 	 * Crude but we have to do this O(N*N) thing, because
 	 * we have to unlock the base when printing:
 	 */
 	while (curr && i < next) {
-		curr =3D timerqueue_iterate_next(curr);
+		curr =3D timerqueue_linked_next(curr);
 		i++;
 	}
=20

