Return-Path: <linux-tip-commits+bounces-8013-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A99D28958
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C0E53083697
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABBD32AACE;
	Thu, 15 Jan 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WLEr7Hwr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mFTMij14"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74E328263;
	Thu, 15 Jan 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510868; cv=none; b=hs+8cQqY47/i6HuJZ9ODyd9C/CuEQ4HuqaVfcaeDRuz1i/+mAJQ1XUJAS8rC2ToF+k0liGjLWxS/ZrmN8N7itw+YXhOrSWwJZwXln+Nv7O3V3YX7WYW2MrN7LerKJ45/Ql6mjwKfFF2QLhwVyTy8caDrhmTMGFNdRx2ByP7sBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510868; c=relaxed/simple;
	bh=bcqwIf0KHrelfMZv0YcMpkK7Hrvl1i9nkQj2ruW/8F8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WyyZSunbyhLZhLAsx/mF/PrCSLEYQdOxQJhtIHCwjmFLRT4ZxS0yug5MTHEiIxrqL6aIhxKwmoiYkWk0i0X8oUMnigDxwaIrCj/9r1TYLlDEpIeA5t0vBtiQBCZm7BfNW3+GfOzzBfNchITrjbI89p6qPYQyqkEWHsxWSe0XCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WLEr7Hwr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mFTMij14; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768510865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elDq9ijNLlIplF++CMPcIf3+aodvqBSs3Q6JR9X+fgY=;
	b=WLEr7Hwr41nhDmceCZeQpaEQ/D0d87v3Ual/K80Yc5L3Doc9PEvIAWWwcNiBiXZ0w94PSP
	qp5XO47cPQTo9NqdT2kQq+R/DsrOhhhrNoLK/9LEPh80kVB90kS+DVujDnP60AD69lunom
	xexSaQ8Z11NW14qxUTVU5aweBJXINtEHYw6+7C9zSsdXbpA3O4IqkOQs6BvDlHOvAZvsZu
	fMjF/dj6JWu5EFo/EVvCa6396HEO07mYoB3AGqG1nNh7YpdIOZ9gJiL+JQTqBU/MkMDdAL
	5dsgcabAWk2kKyde4wnk6KKAk+cVrMJZX6Fr94H9cuUmMsYRvKPAIKGzxFg3Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768510865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elDq9ijNLlIplF++CMPcIf3+aodvqBSs3Q6JR9X+fgY=;
	b=mFTMij14qRW1OsnguSXDslNsr4NzHVsJufuR4oP7G8mhwSxUcHFjOFpyxx8j/lR3DwFvdp
	zz4tdAkMMX+380Cw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/deadline: Ensure get_prio_dl() is up-to-date
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260106104113.GX3707891@noisy.programming.kicks-ass.net>
References: <20260106104113.GX3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851086404.510.18122560875480513196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     375410bb9a403009a44af3cc7f087090da076e09
Gitweb:        https://git.kernel.org/tip/375410bb9a403009a44af3cc7f087090da0=
76e09
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 06 Jan 2026 11:41:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 21:57:52 +01:00

sched/deadline: Ensure get_prio_dl() is up-to-date

Pratheek tripped a WARN and noted the following issue:

> Inspecting the set of events that led to the warning being triggered
> showed the following:
>
>     systemd-1  [008] dN.31 ...: do_set_cpus_allowed: set_cpus_allowed begin!
>
>     systemd-1  [008] dN.31 ...: sched_change_begin: Begin!
>     systemd-1  [008] dN.31 ...: sched_change_begin: Before dequeue_task()!
>     systemd-1  [008] dN.31 ...: update_curr_dl_se: update_curr_dl_se: ENQUE=
UE_REPLENISH
>     systemd-1  [008] dN.31 ...: enqueue_dl_entity: enqueue_dl_entity: ENQUE=
UE_REPLENISH
>     systemd-1  [008] dN.31 ...: replenish_dl_entity: Replenish before: 1481=
5760217
>     systemd-1  [008] dN.31 ...: replenish_dl_entity: Replenish after: 14816=
960047
>     systemd-1  [008] dN.31 ...: sched_change_begin: Before put_prev_task()!
>
>     systemd-1  [008] dN.31 ...: sched_change_end: Before enqueue_task()!
>     systemd-1  [008] dN.31 ...: sched_change_end: Before put_prev_task()!
>     systemd-1  [008] dN.31 ...: prio_changed_dl: Queuing pull task on prio =
change: 14815760217 -> 14816960047
>     systemd-1  [008] dN.31 ...: prio_changed_dl: Queuing balance callback!
>     systemd-1  [008] dN.31 ...: sched_change_end: End!
>
>     systemd-1  [008] dN.31 ...: do_set_cpus_allowed: set_cpus_allowed end!
>     systemd-1  [008] dN.21 ...: __schedule: Woops! Balance callback found!
>
> 1. sched_change_begin() from guard(sched_change) in
>    do_set_cpus_allowed() stashes the priority, which for the deadline
>    task, is "p->dl.deadline".
> 2. The dequeue of the deadline task replenishes the deadline.
> 3. The task is enqueued back after guard's scope ends and since there is
>    no *_CLASS flags set, sched_change_end() calls
>    dl_sched_class->prio_changed() which compares the deadline.
> 4. Since deadline was moved on dequeue, prio_changed_dl() sees the value
>    differ from the stashed value and queues a balance pull callback.
> 5. do_set_cpus_allowed() finishes and drops the rq_lock without doing a
>    do_balance_callbacks().
> 6. Grabbing the rq_lock() at subsequent __schedule() triggers the
>    warning since the balance pull callback was never executed before
>    dropping the lock.

Meaning get_prio_dl() ought to update current and return an up-to-date
value.

Fixes: 6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change=
 pattern")
Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://patch.msgid.link/20260106104113.GX3707891@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/deadline.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b5c19b1..b7acf74 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3296,6 +3296,12 @@ static void switched_to_dl(struct rq *rq, struct task_=
struct *p)
=20
 static u64 get_prio_dl(struct rq *rq, struct task_struct *p)
 {
+	/*
+	 * Make sure to update current so we don't return a stale value.
+	 */
+	if (task_current_donor(rq, p))
+		update_curr_dl(rq);
+
 	return p->dl.deadline;
 }
=20

