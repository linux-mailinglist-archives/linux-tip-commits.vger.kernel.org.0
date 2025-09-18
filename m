Return-Path: <linux-tip-commits+bounces-6676-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C6B8339D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CF1B2865D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C401917ED;
	Thu, 18 Sep 2025 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vNEeGii1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+3iP3ua"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCC2E2EF2;
	Thu, 18 Sep 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178622; cv=none; b=tevV74QnlAw5lUzcbC/zI9CSz+Yge+Euj6CLcIzXCqHn405jW4LISSuYqL2wiDxydVNpRL8WiRsitGR29SILv34z2nC9DeXN/uPe0cyGxAnHCulz7YzxmO/85fIAzE7ZLSCUjIxO4TsLM1NjXy5mMHL0kEjbh9iIIzXOnzBl+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178622; c=relaxed/simple;
	bh=zAYD7tDV592qw+j/krJ5rgIfIarGsWgaoXlOQYMUJPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BGmxwI4VlhJAFxsxvd5nak6H1EM3igHQpZAUyDV9PEbK4zy/aQiBOeCmrD1METHezuLoH7003TjFOvNFWw69FNebhrucBagFeuYwFN1IVRbfQRsBGyTSS4rs7HFPfDsck0Yt2s+6Izi7MgG8zpsTG0EVZpotK3mbEY9luOYZFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vNEeGii1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+3iP3ua; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 06:56:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758178618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABM4Nf7Z+UJub0iX30CSyN2pItTmPzPPfM7EMbQPMi8=;
	b=vNEeGii1fHEI6SsYsDhHzK3nP8CD9h3Wwi44oZx0Xg3PTs0nMA8nHL8iejeDmj82LZgeEz
	8Y7VdNBkdH64WaAhoa2pZb5aJF6UlPzgsawrhZCCjqfllaFReI7zaq/ibpag2XcD0HI0a2
	4a33BL3GxiQnHXDX3H38hdEr5pz+hmSViQwegLoCQl9FBE3y/p8Lewqu3YUiCBUnYiv5GE
	b9dGOZ45+6Wvr0ugFYTWCxBY/afaM58BlcALcrTyj113yLPGhS21vRCueAgOjPVVdEI0lk
	IqEzGT8vHdv390d+2Kv4C+dEEEHXcWDWTZHmhMR+SvEdmg7Q+bcHRo5tlP/Ltg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758178618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABM4Nf7Z+UJub0iX30CSyN2pItTmPzPPfM7EMbQPMi8=;
	b=0+3iP3ualFtTbpWcgElTLILSK5PVmu+p9sZYazq7e71ReiLfs6Q67beltpfZCkNrH5Sf1d
	0rKHSzSm0UIw7UBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix dl_server behaviour
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
References: <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175817861437.709179.10913499403372809816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2dcbcce9bfac6ddc2e2f9243fa846a875371de79
Gitweb:        https://git.kernel.org/tip/2dcbcce9bfac6ddc2e2f9243fa846a87537=
1de79
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Sep 2025 12:03:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Sep 2025 08:50:05 +02:00

sched/deadline: Fix dl_server behaviour

John reported undesirable behaviour with the dl_server since commit:
cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling").

When starving fair tasks on purpose (starting spinning FIFO tasks),
his fair workload, which often goes (briefly) idle, would delay fair
invocations for a second, running one invocation per second was both
unexpected and terribly slow.

The reason this happens is that when dl_se->server_pick_task() returns
NULL, indicating no runnable tasks, it would yield, pushing any later
jobs out a whole period (1 second).

Instead simply stop the server. This should restore behaviour in that
a later wakeup (which restarts the server) will be able to continue
running (subject to the CBS wakeup rules).

Notably, this does not re-introduce the behaviour cccb45d7c4295 set
out to solve, any start/stop cycle is naturally throttled by the timer
period (no active cancel).

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: John Stultz <jstultz@google.com>
---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 23 ++---------------------
 kernel/sched/sched.h    | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f89313b..e4ce0a7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -706,7 +706,6 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
-	unsigned int			dl_server_idle    : 1;
=20
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5a5080b..72c1f72 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1571,10 +1571,8 @@ void dl_server_update_idle_time(struct rq *rq, struct =
task_struct *p)
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime =3D fair server disabled */
-	if (dl_se->dl_runtime) {
-		dl_se->dl_server_idle =3D 0;
+	if (dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
-	}
 }
=20
 void dl_server_start(struct sched_dl_entity *dl_se)
@@ -1602,20 +1600,6 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	dl_se->dl_server_active =3D 0;
 }
=20
-static bool dl_server_stopped(struct sched_dl_entity *dl_se)
-{
-	if (!dl_se->dl_server_active)
-		return true;
-
-	if (dl_se->dl_server_idle) {
-		dl_server_stop(dl_se);
-		return true;
-	}
-
-	dl_se->dl_server_idle =3D 1;
-	return false;
-}
-
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick_task)
 {
@@ -2384,10 +2368,7 @@ again:
 	if (dl_server(dl_se)) {
 		p =3D dl_se->server_pick_task(dl_se);
 		if (!p) {
-			if (!dl_server_stopped(dl_se)) {
-				dl_se->dl_yielded =3D 1;
-				update_curr_dl_se(rq, dl_se, 0);
-			}
+			dl_server_stop(dl_se);
 			goto again;
 		}
 		rq->dl_server =3D dl_se;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f10d627..cf2109b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -371,10 +371,39 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct s=
ched_dl_entity *dl_se, s6
  *   dl_server_update() -- called from update_curr_common(), propagates runt=
ime
  *                         to the server.
  *
- *   dl_server_start()
- *   dl_server_stop()  -- start/stop the server when it has (no) tasks.
+ *   dl_server_start() -- start the server when it has tasks; it will stop
+ *			  automatically when there are no more tasks, per
+ *			  dl_se::server_pick() returning NULL.
+ *
+ *   dl_server_stop() -- (force) stop the server; use when updating
+ *                       parameters.
  *
  *   dl_server_init() -- initializes the server.
+ *
+ * When started the dl_server will (per dl_defer) schedule a timer for its
+ * zero-laxity point -- that is, unlike regular EDF tasks which run ASAP, a
+ * server will run at the very end of its period.
+ *
+ * This is done such that any runtime from the target class can be accounted
+ * against the server -- through dl_server_update() above -- such that when =
it
+ * becomes time to run, it might already be out of runtime and get deferred
+ * until the next period. In this case dl_server_timer() will alternate
+ * between defer and replenish but never actually enqueue the server.
+ *
+ * Only when the target class does not manage to exhaust the server's runtime
+ * (there's actualy starvation in the given period), will the dl_server get =
on
+ * the runqueue. Once queued it will pick tasks from the target class and run
+ * them until either its runtime is exhaused, at which point its back to
+ * dl_server_timer, or until there are no more tasks to run, at which point
+ * the dl_server stops itself.
+ *
+ * By stopping at this point the dl_server retains bandwidth, which, if a new
+ * task wakes up imminently (starting the server again), can be used --
+ * subject to CBS wakeup rules -- without having to wait for the next period.
+ *
+ * Additionally, because of the dl_defer behaviour the start/stop behaviour =
is
+ * naturally thottled to once per period, avoiding high context switch
+ * workloads from spamming the hrtimer program/cancel paths.
  */
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);

