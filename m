Return-Path: <linux-tip-commits+bounces-8298-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGX7Or4Mo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8298-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:41:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 541DB1C40C3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB4130F9B6D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429747DD60;
	Sat, 28 Feb 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KW+VKDE/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7YdDKkwe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B147DD58;
	Sat, 28 Feb 2026 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292990; cv=none; b=XRx7D6rvH/SJs4dFpEIJh1v+ebaycXEdi/4r/Z7/f2fy5w7ns8h1o420EJavnw8WxRAkBAZ+KB9ckLSO0fVTkVMl3Enl9oQlLUWby9Wq13yrDfIGgnYXZAf2sSNE1ECDh8+QDnlwfXK4adKiH4VSE7bV+XDzQ8uzO2VfVQE2Ya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292990; c=relaxed/simple;
	bh=1KoAvRKEr/9QaT2fi8n1KcGGoxzE7D92ImZ1MCpcQyU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G+Cd/+dHo14BXXqjeOl7R+WlTgeWMATtMTRsXji10R1NGa82TTuOQYGk6zrav02f7gmxPs7ydVS5AzlfkwQ5gZO6BWWwoZk8KooFaXI2CMhBqAd+TGosUo1VWUQgfSGR7m80UFO2L8W6y9BMiipOZaIxNSfKxxg61pbdEnKpGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KW+VKDE/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7YdDKkwe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IAGoTovybRPKatNx7gK3N7e9jseR6r5u8AnsE1moMU=;
	b=KW+VKDE/EO9B+KEOmhgMIpetFj/2OoXS7WdUWnwd1QWgHUaZ7NqgMbTXU5tTnISpqedn2U
	41GLT78Lpy/hRK80SCVE5kgf19w6CrT1lfVBCkPYW6mf7gIUNowfTZRQB7/aNflfK9whcn
	0DB9nN/qLKT6r4df9QE3cmal0SLrEd/YF9t/14cVzsPoL8x/O2xC3jxJJ5Df4QmVR/epcj
	EVepH6gKgL9sZVo25jBSW9ylvp3vYgoVCN0sdckqIyQhRvEnLYAnvWpEkDFOGBeYKvPdCP
	SRC4MkAREwdk7XOWuN38hwEME6hH1Fit0UXMrlbhJdjIMW/FRQwQXMi0MulF7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IAGoTovybRPKatNx7gK3N7e9jseR6r5u8AnsE1moMU=;
	b=7YdDKkwen0vqP9YwOUjpnRHhRBoqQGqV6RQ5n0cZDwVlnlgMHpss1Uezt7742YWjnDTQI3
	FqOFrTAGg1HYTXCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] softirq: Prepare for deferred hrtimer rearming
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.142854488@kernel.org>
References: <20260224163431.142854488@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298522.1647592.8640464147966116326.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8298-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 541DB1C40C3
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     7e641e52cf5f284706514f789df8c497aea984e1
Gitweb:        https://git.kernel.org/tip/7e641e52cf5f284706514f789df8c497aea=
984e1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:13 +01:00

softirq: Prepare for deferred hrtimer rearming

The hrtimer interrupt expires timers and at the end of the interrupt it
rearms the clockevent device for the next expiring timer.

That's obviously correct, but in the case that a expired timer sets
NEED_RESCHED the return from interrupt ends up in schedule(). If HRTICK is
enabled then schedule() will modify the hrtick timer, which causes another
reprogramming of the hardware.

That can be avoided by deferring the rearming to the return from interrupt
path and if the return results in a immediate schedule() invocation then it
can be deferred until the end of schedule(), which avoids multiple rearms
and re-evaluation of the timer wheel.

In case that the return from interrupt ends up handling softirqs before
reaching the rearm conditions in the return to user entry code functions, a
deferred rearm has to be handled before softirq handling enables interrupts
as soft interrupt handling can be long and would therefore introduce hard
to diagnose latencies to the timer interrupt.

Place the for now empty stub call right before invoking the softirq
handling routine.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.142854488@kernel.org
---
 kernel/softirq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7719891..4425d8d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -663,6 +663,13 @@ void irq_enter_rcu(void)
 {
 	__irq_enter_raw();
=20
+	/*
+	 * If this is a nested interrupt that hits the exit_to_user_mode_loop
+	 * where it has enabled interrupts but before it has hit schedule() we
+	 * could have hrtimers in an undefined state. Fix it up here.
+	 */
+	hrtimer_rearm_deferred();
+
 	if (tick_nohz_full_cpu(smp_processor_id()) ||
 	    (is_idle_task(current) && (irq_count() =3D=3D HARDIRQ_OFFSET)))
 		tick_irq_enter();
@@ -719,8 +726,14 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending())
+	if (!in_interrupt() && local_softirq_pending()) {
+		/*
+		 * If we left hrtimers unarmed, make sure to arm them now,
+		 * before enabling interrupts to run SoftIRQ.
+		 */
+		hrtimer_rearm_deferred();
 		invoke_softirq();
+	}
=20
 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
 	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))

