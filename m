Return-Path: <linux-tip-commits+bounces-6842-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92ABE26E3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF0501D47
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83715320CB2;
	Thu, 16 Oct 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQj1ZbtZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="laHv6T0b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD155320A2E;
	Thu, 16 Oct 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607224; cv=none; b=hnW6ItRFICNinyBrJDGRsAQXEnN63Xwvi/KG5Kr3zGN3y3/L/bxuf/P97seqGxfKyqraGo8JqN2HoybTcQ61B6u6AzqW1jHcZU99yK4H6BmxshjDmUDtwtt8HUE3GweOwXcdAtqHl6pjqp+i0aZb/iQNhX0WZ6IZs50SXfDfAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607224; c=relaxed/simple;
	bh=oKJhGgYQaV8IYmd+2yjjH2hBvW/5O+JXV2+lXdHscl8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bf1C+Rk36IEXgKYAk66/iTrZeWbpfos4//fgV357aPkkTYpVf8eYS4nGBLWnfiTq3M3nDi18tJmQgyXKJHXYFOh/igWAxOGyk+xcOOeAhuJ9S6WNclfUndpLgR6VpSu8zF1l7d9y+HmcKkUsg2CTa6S4syUtOhofR7nuQLifzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZQj1ZbtZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=laHv6T0b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CH73qc9eP76juAWyRQLnXXmj8j0HklSbezJiB9Iv5rI=;
	b=ZQj1ZbtZyAl4vNISLEwum/Y+C0c54kQOIUC6CRC0+sSE848gdtnDuc7Klb2QUggGPEIRMa
	KmqTI3i9GAaMY7m9rCx9jqwGGaEHCAH4n+rwa+hWzH1/pUZKoBbaZ4BCPKeTYrr96XRN07
	F+FK6Cb/G4a9f1WppdVs4c79nkwJP9aCZsxluC/zKwpEs8PVZ+5ElQdqVWCERNJq7Q4PKg
	rrxv0kBwLUARjxDsRFMzzfkHDmZcjtNYJWREioBhkkueDs0X2OR814SXT/fS0AE4nxCzs1
	RcA6f0F0CDQmUZN1vC3Nu2YjWJ06x1hmOmr1S8cGzgifDVO2DNjH+VYr1rpSBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CH73qc9eP76juAWyRQLnXXmj8j0HklSbezJiB9Iv5rI=;
	b=laHv6T0bG55dO9tRQFC3nXOdOXAAfCv9qNm4LT7oqxDVUMQQGg6DAXf8OSLxH2UeIO3E1b
	ThX8jt4pIowfSCBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Prepare for switched_from() change
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251009140925.GD4068168@noisy.programming.kicks-ass.net>
References: <20251009140925.GD4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721804.709179.14529626426508592907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5e42d4c123ba9b89ce19b3aa7e22b7684cbfa49c
Gitweb:        https://git.kernel.org/tip/5e42d4c123ba9b89ce19b3aa7e22b7684cb=
fa49c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 09 Oct 2025 16:09:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:51 +02:00

sched/deadline: Prepare for switched_from() change

Prepare for the sched_class::switch*() methods getting folded into the
change pattern. As a result of that, the location of switched_from
will change slightly. SCHED_DEADLINE is affected by this change in
location:

  OLD                              NEW
				|
				|  switching_from()
  dequeue_task();		|  dequeue_task()
  put_prev_task();		|  put_prev_task()
				|  switched_from()
				|
  ... change task ...		|  ... change task ...
				|
  switching_to();		|  switching_to()
  enqueue_task();		|  enqueue_task()
  set_next_task();		|  set_next_task()
  prev_class->switched_from()	|
  switched_to()			|  switched_to()
				|

Notably, where switched_from() was called *after* the change to the
task, it will get called before it. Specifically, switched_from_dl()
uses dl_task(p) which uses p->prio; which is changed when switching
class (it might be the reason to switch class in case of PI).

When switched_from_dl() gets called, the task will have left the
deadline class and dl_task() must be false, while when doing
dequeue_dl_entity() the task must be a dl_task(), otherwise we'd have
called a different dequeue method.

Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 933bd1f..fd147a7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -405,7 +405,7 @@ static void __dl_clear_params(struct sched_dl_entity *dl_=
se);
  * up, and checks if the task is still in the "ACTIVE non contending"
  * state or not (in the second case, it updates running_bw).
  */
-static void task_non_contending(struct sched_dl_entity *dl_se)
+static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 {
 	struct hrtimer *timer =3D &dl_se->inactive_timer;
 	struct rq *rq =3D rq_of_dl_se(dl_se);
@@ -444,10 +444,10 @@ static void task_non_contending(struct sched_dl_entity =
*dl_se)
 		} else {
 			struct task_struct *p =3D dl_task_of(dl_se);
=20
-			if (dl_task(p))
+			if (dl_task)
 				sub_running_bw(dl_se, dl_rq);
=20
-			if (!dl_task(p) || READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
+			if (!dl_task || READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
 				struct dl_bw *dl_b =3D dl_bw_of(task_cpu(p));
=20
 				if (READ_ONCE(p->__state) =3D=3D TASK_DEAD)
@@ -2045,7 +2045,7 @@ static void dequeue_dl_entity(struct sched_dl_entity *d=
l_se, int flags)
 	 * or "inactive")
 	 */
 	if (flags & DEQUEUE_SLEEP)
-		task_non_contending(dl_se);
+		task_non_contending(dl_se, true);
 }
=20
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
@@ -2970,7 +2970,7 @@ static void switched_from_dl(struct rq *rq, struct task=
_struct *p)
 	 * will reset the task parameters.
 	 */
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
-		task_non_contending(&p->dl);
+		task_non_contending(&p->dl, false);
=20
 	/*
 	 * In case a task is setscheduled out from SCHED_DEADLINE we need to

