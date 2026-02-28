Return-Path: <linux-tip-commits+bounces-8326-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBsPCZIOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8326-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:49:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C71C4212
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2C7831DF554
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9338D481658;
	Sat, 28 Feb 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZoIDLu7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yCyXxC4+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0BD480DC7;
	Sat, 28 Feb 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293024; cv=none; b=JfUXpkZbYq0xUVPM6wVQeT4d/RoENnZnUrm50q/g//X/poPbT+1EB6gGZ2xr+QRsf+SQnMhPinqnRUw6RnsngWW8t1WZ/iLAhQ+cF94tzWlUgrDMwA69ntZ7TbFZmQbhRWFRF4Gz2Ell1mYoqZVPmDrgtjYRxvoL5wJihbsUtuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293024; c=relaxed/simple;
	bh=jYrkPI9t7fCPYEBBBWGXdyF5lYfq8Td7u3bTAxGxBmI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L0wDFkgS6zYY9dFO0Qut2mNqBcttT4hKg6CLcj87JtkihU7EDL4pv70xziwSHr0/VgyW4ED3XfzMsQXZhBBfLrlqUrOl7sCiikXPqWRpIb8PP28FijmlBSxLwu+ZOvOUA0EN5CqhodlKrUwGspv4DFtgXFQb5MeyzM6/6h2/Q8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZoIDLu7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yCyXxC4+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2ZeEaqqxPdVJXrGMvH5d/45bphKz1WIUm/AeZ9ZfkU=;
	b=fZoIDLu7iRrWcQuD3CPRKEha5QR6ptjeVY9tD3AUnKFfNPzlGrgSJGf4oCn4lqm5cWwbeF
	aTWvRm/7IZ0JJnfWigsYY3qk/ejk9I7BM1BYtXrEL/t8gT5PtF0dG5exgx6eStv4COKbO0
	ud3MEqf+CwjwreQ90kkoc8iX3vARWlywZN2aD09ha6qTvQX3BCRsNLUX8Mw1ybRzB2g8Qf
	I6ed/lQKeN29yYFrnhIlDTsj62Y5cPjW0wAoIBUC/NcwxyQP8n7Jnd0AlfdcLck27Nokov
	niTg0IDfSDxFOBeoE2TJ1sT7CpktP2A2wPYCQWvNw9kOxFfiSZ+rZQpjhfl86Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2ZeEaqqxPdVJXrGMvH5d/45bphKz1WIUm/AeZ9ZfkU=;
	b=yCyXxC4+iFDNzaVFusO8VBpQgvNOPLr8JeZ3cUV9XqyuKTNF0CFT+W7NaJRc9kMLcrSoA8
	pPw8kozQv/4XSjBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/hrtick: Avoid tiny hrtick rearms
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.340593047@kernel.org>
References: <20260224163429.340593047@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301496.1647592.1576123173658201640.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8326-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 7C0C71C4212
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     c8cdb9b516407a0b8c653c9c1d6f0931c3864384
Gitweb:        https://git.kernel.org/tip/c8cdb9b516407a0b8c653c9c1d6f0931c38=
64384
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:05 +01:00

sched/hrtick: Avoid tiny hrtick rearms

Tiny adjustments to the hrtick expiry time below 5 microseconds are just
causing extra work for no real value. Filter them out when restarting the
hrtick.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.340593047@kernel.org
---
 kernel/sched/core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a868f0a..5bc446e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -903,12 +903,24 @@ static enum hrtimer_restart hrtick(struct hrtimer *time=
r)
 	return HRTIMER_NORESTART;
 }
=20
-static void __hrtick_restart(struct rq *rq)
+static inline bool hrtick_needs_rearm(struct hrtimer *timer, ktime_t expires)
+{
+	/*
+	 * Queued is false when the timer is not started or currently
+	 * running the callback. In both cases, restart. If queued check
+	 * whether the expiry time actually changes substantially.
+	 */
+	return !hrtimer_is_queued(timer) ||
+		abs(expires - hrtimer_get_expires(timer)) > 5000;
+}
+
+static void hrtick_cond_restart(struct rq *rq)
 {
 	struct hrtimer *timer =3D &rq->hrtick_timer;
 	ktime_t time =3D rq->hrtick_time;
=20
-	hrtimer_start(timer, time, HRTIMER_MODE_ABS_PINNED_HARD);
+	if (hrtick_needs_rearm(timer, time))
+		hrtimer_start(timer, time, HRTIMER_MODE_ABS_PINNED_HARD);
 }
=20
 /*
@@ -920,7 +932,7 @@ static void __hrtick_start(void *arg)
 	struct rq_flags rf;
=20
 	rq_lock(rq, &rf);
-	__hrtick_restart(rq);
+	hrtick_cond_restart(rq);
 	rq_unlock(rq, &rf);
 }
=20
@@ -950,9 +962,11 @@ void hrtick_start(struct rq *rq, u64 delay)
 	}
=20
 	rq->hrtick_time =3D ktime_add_ns(ktime_get(), delta);
+	if (!hrtick_needs_rearm(&rq->hrtick_timer, rq->hrtick_time))
+		return;
=20
 	if (rq =3D=3D this_rq())
-		__hrtick_restart(rq);
+		hrtimer_start(&rq->hrtick_timer, rq->hrtick_time, HRTIMER_MODE_ABS_PINNED_=
HARD);
 	else
 		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
 }
@@ -966,7 +980,7 @@ static inline void hrtick_schedule_exit(struct rq *rq)
 {
 	if (rq->hrtick_sched & HRTICK_SCHED_START) {
 		rq->hrtick_time =3D ktime_add_ns(ktime_get(), rq->hrtick_delay);
-		__hrtick_restart(rq);
+		hrtick_cond_restart(rq);
 	} else if (idle_rq(rq)) {
 		/*
 		 * No need for using hrtimer_is_active(). The timer is CPU local

