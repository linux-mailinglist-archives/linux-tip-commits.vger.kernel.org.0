Return-Path: <linux-tip-commits+bounces-8302-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHeVI+kMo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8302-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA41C40F5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFD1319B8D8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1347DF83;
	Sat, 28 Feb 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCGTByJt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24r84heU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C647D947;
	Sat, 28 Feb 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292992; cv=none; b=jLYCA9S3wj36MpXoQn5byal4NyaIKAYiOO9whEjW+Dd/02YnQ2ayN14GZspTBd+UZRrsDEKoiLpX9+9eAn70ZplkZT6hQjimMAlIVBfBMAkdRaf7W2lMt6W17lOB1+uht6a7G6WNWe1SyQMyD8Kn0P+Rka51lsU/dP+Qq52YikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292992; c=relaxed/simple;
	bh=o4XOi7ieVyqo8awr8BspU0SqtRlo3xKL2sHQ7xpsH6c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pljCdsLuBIdd66+hR61jeuMHuW3EYsyV4VbC0kVDSHQa/IgzbdrMb1x1qr/+k0se9NAtwJEGpps4xBuL72jejW6sEPsJPimfG8fWRVIufy4H6ftFsQ60zZlTpe3S5aJEl0oouAxu3JaJciWVLyWyDrci5Hg+art5SQrzyK44Ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OCGTByJt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24r84heU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54nCZHDsVRlOC58HVz+O/rE7sAGIQ2tgLd2vDGhBUu4=;
	b=OCGTByJtx1GBgftiS/3IaQ4BWb08BFH0ivEzgPyCtxUjwjN2IEM8O5665StoC2SPnANOWc
	nzgjjaQb/WQv/kewvsPvL0YyGBsV8g3LYSHkWeFElId3CnGfmdAYiYcCveRh1t3cXZYAZK
	RpYFTljfCk/J/6a21svdG19yypNC31ZqDbdhaVw6MvYGLH59JBmihu28dKi/KiY8AkmZG3
	JQGtOwupUOc83ttQDYOEidPjLLezUJyneb6Iz9BPE4sR9Vj38DDDwVjnsx389++35N2rxM
	HkqU9cIMkrp+aoVE7wdUPO5NYFGz8rYgpBS/evgvqjtQdlIn19hbtC+gy4vYwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54nCZHDsVRlOC58HVz+O/rE7sAGIQ2tgLd2vDGhBUu4=;
	b=24r84heU8ZMWXTlmmiW4KpEvuiWP3ORDjm383Jgaz8r8BhNRLtFuQn1GWZvARpIEBWI0EP
	d0F92UCkwzNgAMCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Rename hrtimer_cpu_base::in_hrtirq to
 deferred_rearm
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.935623347@kernel.org>
References: <20260224163430.935623347@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298847.1647592.5967975715419886898.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8302-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 2FAA41C40F5
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     9e07a9c980eaa93fd1bba722d31eeb4bf0cbbfb4
Gitweb:        https://git.kernel.org/tip/9e07a9c980eaa93fd1bba722d31eeb4bf0c=
bbfb4
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:12 +01:00

hrtimer: Rename hrtimer_cpu_base::in_hrtirq to deferred_rearm

The upcoming deferred rearming scheme has the same effect as the deferred
rearming when the hrtimer interrupt is executing. So it can reuse the
in_hrtirq flag, but when it gets deferred beyond the hrtimer interrupt
path, then the name does not make sense anymore.

Rename it to deferred_rearm upfront to keep the actual functional change
separate from the mechanical rename churn.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.935623347@kernel.org
---
 include/linux/hrtimer_defs.h |  4 ++--
 kernel/time/hrtimer.c        | 28 +++++++++-------------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index f9fbf9a..2c3bdbd 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -53,7 +53,7 @@ enum  hrtimer_base_type {
  * @active_bases:	Bitfield to mark bases with active timers
  * @clock_was_set_seq:	Sequence counter of clock was set events
  * @hres_active:	State of high resolution mode
- * @in_hrtirq:		hrtimer_interrupt() is currently executing
+ * @deferred_rearm:	A deferred rearm is pending
  * @hang_detected:	The last hrtimer interrupt detected a hang
  * @softirq_activated:	displays, if the softirq is raised - update of softirq
  *			related settings is not required then.
@@ -84,7 +84,7 @@ struct hrtimer_cpu_base {
 	unsigned int			active_bases;
 	unsigned int			clock_was_set_seq;
 	bool				hres_active;
-	bool				in_hrtirq;
+	bool				deferred_rearm;
 	bool				hang_detected;
 	bool				softirq_activated;
 	bool				online;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2e05a18..6f05d25 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -883,11 +883,8 @@ static void hrtimer_reprogram(struct hrtimer *timer, boo=
l reprogram)
 	if (expires >=3D cpu_base->expires_next)
 		return;
=20
-	/*
-	 * If the hrtimer interrupt is running, then it will reevaluate the
-	 * clock bases and reprogram the clock event device.
-	 */
-	if (cpu_base->in_hrtirq)
+	/* If a deferred rearm is pending skip reprogramming the device */
+	if (cpu_base->deferred_rearm)
 		return;
=20
 	cpu_base->next_timer =3D timer;
@@ -921,12 +918,8 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *cp=
u_base, unsigned int act
 	if (seq =3D=3D cpu_base->clock_was_set_seq)
 		return false;
=20
-	/*
-	 * If the remote CPU is currently handling an hrtimer interrupt, it
-	 * will reevaluate the first expiring timer of all clock bases
-	 * before reprogramming. Nothing to do here.
-	 */
-	if (cpu_base->in_hrtirq)
+	/* If a deferred rearm is pending the remote CPU will take care of it */
+	if (cpu_base->deferred_rearm)
 		return false;
=20
 	/*
@@ -1334,11 +1327,8 @@ static bool __hrtimer_start_range_ns(struct hrtimer *t=
imer, ktime_t tim, u64 del
 		first =3D enqueue_hrtimer(timer, base, mode, was_armed);
 	}
=20
-	/*
-	 * If the hrtimer interrupt is running, then it will reevaluate the
-	 * clock bases and reprogram the clock event device.
-	 */
-	if (cpu_base->in_hrtirq)
+	/* If a deferred rearm is pending skip reprogramming the device */
+	if (cpu_base->deferred_rearm)
 		return false;
=20
 	if (!was_first || cpu_base !=3D this_cpu_base) {
@@ -1947,14 +1937,14 @@ static __latent_entropy void hrtimer_run_softirq(void)
=20
 /*
  * Very similar to hrtimer_force_reprogram(), except it deals with
- * in_hrtirq and hang_detected.
+ * deferred_rearm and hang_detected.
  */
 static void hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	ktime_t expires_next =3D hrtimer_update_next_event(cpu_base);
=20
 	cpu_base->expires_next =3D expires_next;
-	cpu_base->in_hrtirq =3D false;
+	cpu_base->deferred_rearm =3D false;
=20
 	if (unlikely(cpu_base->hang_detected)) {
 		/*
@@ -1985,7 +1975,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 	entry_time =3D now =3D hrtimer_update_base(cpu_base);
 retry:
-	cpu_base->in_hrtirq =3D true;
+	cpu_base->deferred_rearm =3D true;
 	/*
 	 * Set expires_next to KTIME_MAX, which prevents that remote CPUs queue
 	 * timers while __hrtimer_run_queues() is expiring the clock bases.

