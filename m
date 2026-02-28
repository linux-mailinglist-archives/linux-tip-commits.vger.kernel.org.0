Return-Path: <linux-tip-commits+bounces-8309-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JplJsINo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8309-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:10 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D41C41A1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34D6630981AD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08A47ECDB;
	Sat, 28 Feb 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5bkLDNt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEAv9PB9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7247DD53;
	Sat, 28 Feb 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293004; cv=none; b=nrIGALoZSyv+7VvIl9+buyvCKK5LNw2qTQzhFjib6Zt3qf17GR6SoNBEM895z6RaO3pU2pq8mvqBQW07o6Zat6O69ACbquwM3sAx3Kj8yuQZKFIRsmG19YsHWbtitKCLNrTy010HHGszCVO8MByk3C2dsCiL3Yo5QiQa4vMDkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293004; c=relaxed/simple;
	bh=Q8QodRLPlGPJNzp1SiQtpEDHgFCixVvdEkT9uYGrR1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JnYZ9WXoA8ai7J+0krf9BsI/MmvjPWkofEaCNuNnyPC5g5thSOsO+J95s0zIX3m/NOt2V9qJgK7CYAmrb+WVo3x4POsUvbI9GtOxt4iDkpNqr5U3D9e+5wyb9Qk5Q2psXJh6EvXpdOKD8AHudrHQi02uTn748QzW26g1La0JE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5bkLDNt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEAv9PB9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyvTZnhrze40/x78pKzDmVA2h3Jm9Oq36/GhckS+ycw=;
	b=Y5bkLDNtyvM0rqja1RZ8Ww0ZxVRzwBTLhOag/oDbZU02bfs9uHobhXIXW+vvqESU2lmKs6
	+8FWMFkfg+z4iX/smkiUpGKJXj5LICh+nJC8X58VQXYo2laFcHzfgmiarR5k+oO4UiDOcI
	1308iZO/ncZWQGyui+r0YyNutNtTwYtYTSh46LgJPlYm4pNZ335KlsBDkCukGQtA3B/giq
	ETkgcwM1cYCMVVfinRf1R/KzeIJZx7g4OlIN6tgPk8yJL8qR+Lkx2IV3SG0WxtgyrFVfV0
	jFWyA34y/bMP3FlVu9z5LvXFXVCj+Q8afyeEeFCIdxD4IY/lVQnlwbDJo5VTDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyvTZnhrze40/x78pKzDmVA2h3Jm9Oq36/GhckS+ycw=;
	b=gEAv9PB9vkfqDuCfCE8jZhaFbNA81o3Tj4Q9cz3+CxnlUVBOCBd22/HqlNsvC4wy4hGft8
	tsUMipPBj6fAc9Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Replace the bitfield in hrtimer_cpu_base
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.475262618@kernel.org>
References: <20260224163430.475262618@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299627.1647592.11344414544935103165.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8309-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: BA0D41C41A1
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     7d27eafe54659d19cef10dab4520cbcdfb17b0e3
Gitweb:        https://git.kernel.org/tip/7d27eafe54659d19cef10dab4520cbcdfb1=
7b0e3
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:10 +01:00

hrtimer: Replace the bitfield in hrtimer_cpu_base

Use bool for the various flags as that creates better code in the hot path.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.475262618@kernel.org
---
 include/linux/hrtimer_defs.h | 10 +++++-----
 kernel/time/hrtimer.c        | 25 +++++++++++++------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index 02b010d..f9fbf9a 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -83,11 +83,11 @@ struct hrtimer_cpu_base {
 	unsigned int			cpu;
 	unsigned int			active_bases;
 	unsigned int			clock_was_set_seq;
-	unsigned int			hres_active		: 1,
-					in_hrtirq		: 1,
-					hang_detected		: 1,
-					softirq_activated       : 1,
-					online			: 1;
+	bool				hres_active;
+	bool				in_hrtirq;
+	bool				hang_detected;
+	bool				softirq_activated;
+	bool				online;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e6f02e9..3b80a44 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -741,7 +741,7 @@ static void hrtimer_switch_to_hres(void)
 		pr_warn("Could not switch to high resolution mode on CPU %u\n",	base->cpu);
 		return;
 	}
-	base->hres_active =3D 1;
+	base->hres_active =3D true;
 	hrtimer_resolution =3D HIGH_RES_NSEC;
=20
 	tick_setup_sched_timer(true);
@@ -1854,7 +1854,7 @@ static __latent_entropy void hrtimer_run_softirq(void)
 	now =3D hrtimer_update_base(cpu_base);
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_SOFT);
=20
-	cpu_base->softirq_activated =3D 0;
+	cpu_base->softirq_activated =3D false;
 	hrtimer_update_softirq_timer(cpu_base, true);
=20
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
@@ -1881,7 +1881,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 	entry_time =3D now =3D hrtimer_update_base(cpu_base);
 retry:
-	cpu_base->in_hrtirq =3D 1;
+	cpu_base->in_hrtirq =3D true;
 	/*
 	 * Set expires_next to KTIME_MAX, which prevents that remote CPUs queue
 	 * timers while __hrtimer_run_queues() is expiring the clock bases.
@@ -1892,7 +1892,7 @@ retry:
=20
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
-		cpu_base->softirq_activated =3D 1;
+		cpu_base->softirq_activated =3D true;
 		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
=20
@@ -1905,12 +1905,12 @@ retry:
 	 * against it.
 	 */
 	cpu_base->expires_next =3D expires_next;
-	cpu_base->in_hrtirq =3D 0;
+	cpu_base->in_hrtirq =3D false;
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
=20
 	/* Reprogramming necessary ? */
 	if (!tick_program_event(expires_next, 0)) {
-		cpu_base->hang_detected =3D 0;
+		cpu_base->hang_detected =3D false;
 		return;
 	}
=20
@@ -1939,7 +1939,7 @@ retry:
 	 * time away.
 	 */
 	cpu_base->nr_hangs++;
-	cpu_base->hang_detected =3D 1;
+	cpu_base->hang_detected =3D true;
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
=20
 	delta =3D ktime_sub(now, entry_time);
@@ -1987,7 +1987,7 @@ void hrtimer_run_queues(void)
=20
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
-		cpu_base->softirq_activated =3D 1;
+		cpu_base->softirq_activated =3D true;
 		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
=20
@@ -2239,13 +2239,14 @@ int hrtimers_cpu_starting(unsigned int cpu)
=20
 	/* Clear out any left over state from a CPU down operation */
 	cpu_base->active_bases =3D 0;
-	cpu_base->hres_active =3D 0;
-	cpu_base->hang_detected =3D 0;
+	cpu_base->hres_active =3D false;
+	cpu_base->hang_detected =3D false;
 	cpu_base->next_timer =3D NULL;
 	cpu_base->softirq_next_timer =3D NULL;
 	cpu_base->expires_next =3D KTIME_MAX;
 	cpu_base->softirq_expires_next =3D KTIME_MAX;
-	cpu_base->online =3D 1;
+	cpu_base->softirq_activated =3D false;
+	cpu_base->online =3D true;
 	return 0;
 }
=20
@@ -2303,7 +2304,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
=20
 	raw_spin_unlock(&new_base->lock);
-	old_base->online =3D 0;
+	old_base->online =3D false;
 	raw_spin_unlock(&old_base->lock);
=20
 	return 0;

