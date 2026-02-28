Return-Path: <linux-tip-commits+bounces-8311-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB1KJN0No2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8311-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:37 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B931C41AF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60DA230668C9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6F47ECE2;
	Sat, 28 Feb 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yX+vQc4U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsRoG8iz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333A47D93C;
	Sat, 28 Feb 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293005; cv=none; b=NlrlR5/FjaUT1g2XHh2w3z2sVjTkFXSMRfuMGSC9UCID2Ojb950Jiybnl98ZUoiPljtwPweChYmieBjDWVDWik9JgOPGAlZUf1o3BocHCUpmdW0vXxEs9fZZdzs/9Qjpl/ZCRgsfC1CWsxU4mMfRUjIIMfKVH5fUsViKrrPxyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293005; c=relaxed/simple;
	bh=yC6BObXhVf8FYK9tEs0PVgZj3j32u5x5ie6aU5zRZjI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vELxJOVHLyBnkYmT6nCI1YAusAS6T3ohCdQGXUNabdhSq0NPuuxce7rTfByjpTNiiKTbICD9dUbKRfjD65tBZ6J+sf2ICiQAJmZCKIsgwiGMXwTt6HNt+n4HyTk3yXvl3Xp8wBIIzjbH+mZj5+LeJRCZnHqF4o/5dbZ0axEHfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yX+vQc4U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsRoG8iz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEZaPHx4Ylvpp0ZvlGnl5/6ta0MTClfntJpjPJ/k588=;
	b=yX+vQc4UjG5kUTNkqnGiwE8139031uYxdfFt2AHfyTd4KEz2SAWS9OdqJJRbpBYtl6Khah
	sfJmBrqiqzperAUoLBKZ20jtdvD0DJwwUws8N/QIMlaJBKiSWe15Ir0XR83zYHVAGmCnla
	1VlpWu5KvWkWuZCwH7u05QKoC47b8mYhL5d3tej2Ln5ikLXzR+tQxZRiustgLraAu2sI1n
	6aA8g94mlG4tVdlY8pBShsr8ITgVBmxPyv96NQbrUOrVNk+mrJd2zXJ5EsCnxBJ1zU5bpb
	Vr5blyb5QVGAXlWv+4dRNz+ndL0XLBuHERZ5IcO50+dvVECfJG9g0eN2bBYKzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEZaPHx4Ylvpp0ZvlGnl5/6ta0MTClfntJpjPJ/k588=;
	b=hsRoG8izG8KLgS2DEfwe7VDOZmBIPjHGLLoW1RtDs5w0XcjBgg/jLzA/+Y1/+KOMOFdiAM
	PAM+3Cdb7z6Oj+Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Use guards where appropriate
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.275551488@kernel.org>
References: <20260224163430.275551488@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299967.1647592.16737545281030643516.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8311-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto];
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
X-Rspamd-Queue-Id: A5B931C41AF
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     6abfc2bd5b0cff70db99a273f2a161e2273eae6d
Gitweb:        https://git.kernel.org/tip/6abfc2bd5b0cff70db99a273f2a161e2273=
eae6d
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:09 +01:00

hrtimer: Use guards where appropriate

Simplify and tidy up the code where possible.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.275551488@kernel.org
---
 kernel/time/hrtimer.c | 48 +++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6e4ac8d..a5df3c4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -838,13 +838,12 @@ static void retrigger_next_event(void *arg)
 	 * In periodic low resolution mode, the next softirq expiration
 	 * must also be updated.
 	 */
-	raw_spin_lock(&base->lock);
+	guard(raw_spinlock)(&base->lock);
 	hrtimer_update_base(base);
 	if (hrtimer_hres_active(base))
 		hrtimer_force_reprogram(base, 0);
 	else
 		hrtimer_update_next_event(base);
-	raw_spin_unlock(&base->lock);
 }
=20
 /*
@@ -994,7 +993,6 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *cpu=
_base,
 void clock_was_set(unsigned int bases)
 {
 	cpumask_var_t mask;
-	int cpu;
=20
 	if (!hrtimer_highres_enabled() && !tick_nohz_is_active())
 		goto out_timerfd;
@@ -1005,24 +1003,19 @@ void clock_was_set(unsigned int bases)
 	}
=20
 	/* Avoid interrupting CPUs if possible */
-	cpus_read_lock();
-	for_each_online_cpu(cpu) {
-		struct hrtimer_cpu_base *cpu_base;
-		unsigned long flags;
+	scoped_guard(cpus_read_lock) {
+		int cpu;
=20
-		cpu_base =3D &per_cpu(hrtimer_bases, cpu);
-		raw_spin_lock_irqsave(&cpu_base->lock, flags);
+		for_each_online_cpu(cpu) {
+			struct hrtimer_cpu_base *cpu_base =3D &per_cpu(hrtimer_bases, cpu);
=20
-		if (update_needs_ipi(cpu_base, bases))
-			cpumask_set_cpu(cpu, mask);
-
-		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+			guard(raw_spinlock_irqsave)(&cpu_base->lock);
+			if (update_needs_ipi(cpu_base, bases))
+				cpumask_set_cpu(cpu, mask);
+		}
+		scoped_guard(preempt)
+			smp_call_function_many(mask, retrigger_next_event, NULL, 1);
 	}
-
-	preempt_disable();
-	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
-	preempt_enable();
-	cpus_read_unlock();
 	free_cpumask_var(mask);
=20
 out_timerfd:
@@ -1600,15 +1593,11 @@ u64 hrtimer_get_next_event(void)
 {
 	struct hrtimer_cpu_base *cpu_base =3D this_cpu_ptr(&hrtimer_bases);
 	u64 expires =3D KTIME_MAX;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&cpu_base->lock, flags);
=20
+	guard(raw_spinlock_irqsave)(&cpu_base->lock);
 	if (!hrtimer_hres_active(cpu_base))
 		expires =3D __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
=20
-	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
-
 	return expires;
 }
=20
@@ -1623,25 +1612,18 @@ u64 hrtimer_next_event_without(const struct hrtimer *=
exclude)
 {
 	struct hrtimer_cpu_base *cpu_base =3D this_cpu_ptr(&hrtimer_bases);
 	u64 expires =3D KTIME_MAX;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&cpu_base->lock, flags);
=20
+	guard(raw_spinlock_irqsave)(&cpu_base->lock);
 	if (hrtimer_hres_active(cpu_base)) {
 		unsigned int active;
=20
 		if (!cpu_base->softirq_activated) {
 			active =3D cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
-			expires =3D __hrtimer_next_event_base(cpu_base, exclude,
-							    active, KTIME_MAX);
+			expires =3D __hrtimer_next_event_base(cpu_base, exclude, active, KTIME_MA=
X);
 		}
 		active =3D cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
-		expires =3D __hrtimer_next_event_base(cpu_base, exclude, active,
-						    expires);
+		expires =3D __hrtimer_next_event_base(cpu_base, exclude, active, expires);
 	}
-
-	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
-
 	return expires;
 }
 #endif

