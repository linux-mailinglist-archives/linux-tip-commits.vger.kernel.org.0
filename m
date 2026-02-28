Return-Path: <linux-tip-commits+bounces-8300-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHPmGNAMo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8300-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:08 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044C1C40D1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92D253104BA9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DCE47DD6D;
	Sat, 28 Feb 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RlXMpzQC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Trorl64"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A447DD48;
	Sat, 28 Feb 2026 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292991; cv=none; b=qHz+lZKG1DBfkMd8HPVAiTeSPBQhyZUB1bUm0qvYRinkkomwtUgHv3EnOvgu1cjgPRyUSS92KtKcM7XxQzDRY/G6aOjsk72Lqkk+ydSRg+zemb0CYT4S/iJFFGcgLN2vZRc5Py6psBtF+6lAc7nrGN1KWeO69X6n3LL1L+73Wos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292991; c=relaxed/simple;
	bh=44VFBwpzIQBellYxb8XDm7f6ZPt+YCtC78Oyy/GsVXk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ekc6b3qH0QlpUKOCK5fSRyISPVDkKUluypMlLiC/mIXVbodOUEwYoFOr9BNTELNxkg/8B107/TRYNy/YC8cmRrcy1oAqMBwyRNatLxb4AO7SvXnwlh9HJmp4El85VTb2H/tC/3q+8GmpxSc3WQnmFeY5uplVRissgOPV8vUnDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RlXMpzQC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Trorl64; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzCFlrHMwnH0fr1aA5lUaM3mRXlloI1rBF5iQ/fM8vM=;
	b=RlXMpzQCaLgyrw3RZnLlR0L4IR2hoMkUbg47H+dL0EpdKvqtjuEUNvXQzI9ivnPoDvdlRS
	VfhxWm13wmanTIZ3+1XiV2u8hdU7fxW2mKvt5ja7jwGSi9GKfZ80wrj3eHdBKOyklaDg2A
	ATLT3+Sc+Nrr2Y81WL13NzZ/vrWImV7ELPSM81+1d9uqxZKT+hfJS8AppxGTLOhGlRe+/j
	uCBEvGrTT3D/2FfvIvjdIwIuVeKvnFSxDzkMl1co4AZw8RAUX5Z9MfH4Tf+IirzTGZ7ncw
	Wi/HIUiyCSHz+mpwdE3YLxIFwfzMbP7WWon0ec/BQpgqrbSWPBT2P/MvqXUUBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzCFlrHMwnH0fr1aA5lUaM3mRXlloI1rBF5iQ/fM8vM=;
	b=1Trorl647PXfCZbyJpvQxIK009OiL+OraVvyPS1uyV0xKdQHZwephzTf2cXNrjbs+0qP2K
	0KnH//njsnue80CQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/core: Prepare for deferred hrtimer rearming
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.208580085@kernel.org>
References: <20260224163431.208580085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298414.1647592.6182721468716288875.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8300-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 0044C1C40D1
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     b0a44fa5e2a22ff67752bbc08c651a2efac3e5fe
Gitweb:        https://git.kernel.org/tip/b0a44fa5e2a22ff67752bbc08c651a2efac=
3e5fe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:13 +01:00

sched/core: Prepare for deferred hrtimer rearming

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

Add the rearm checks to the existing sched_hrtick_enter/exit() functions,
which already handle the batched rearm of the hrtick timer.

For now this is just placing empty stubs at the right places which are all
optimized out by the compiler until the guard condition becomes true.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.208580085@kernel.org
---
 kernel/sched/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d1239a..49a64b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -876,6 +876,7 @@ enum {
 	HRTICK_SCHED_NONE		=3D 0,
 	HRTICK_SCHED_DEFER		=3D BIT(1),
 	HRTICK_SCHED_START		=3D BIT(2),
+	HRTICK_SCHED_REARM_HRTIMER	=3D BIT(3)
 };
=20
 static void hrtick_clear(struct rq *rq)
@@ -974,6 +975,8 @@ void hrtick_start(struct rq *rq, u64 delay)
 static inline void hrtick_schedule_enter(struct rq *rq)
 {
 	rq->hrtick_sched =3D HRTICK_SCHED_DEFER;
+	if (hrtimer_test_and_clear_rearm_deferred())
+		rq->hrtick_sched |=3D HRTICK_SCHED_REARM_HRTIMER;
 }
=20
 static inline void hrtick_schedule_exit(struct rq *rq)
@@ -991,6 +994,9 @@ static inline void hrtick_schedule_exit(struct rq *rq)
 			hrtimer_cancel(&rq->hrtick_timer);
 	}
=20
+	if (rq->hrtick_sched & HRTICK_SCHED_REARM_HRTIMER)
+		__hrtimer_rearm_deferred();
+
 	rq->hrtick_sched =3D HRTICK_SCHED_NONE;
 }
=20

