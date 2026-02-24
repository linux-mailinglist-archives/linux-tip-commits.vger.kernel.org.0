Return-Path: <linux-tip-commits+bounces-8248-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEbNOMlrnWnhPwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8248-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:45 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0A184596
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6F6F303EFD2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715736A03F;
	Tue, 24 Feb 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7w9vOWx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hI0OPGGm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2D36AB6F;
	Tue, 24 Feb 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924404; cv=none; b=nf9wiA9VKZ0fI65A4o2DAms/foK2D4eddnKnKkO9Nj/eRfDORYMeYlhMOeNt3mWBIWLnMIjYKjLE+lSiwwWYHfyIkJ/38UGtAGIJ5iMQQD76nFeosiRAwfCrw9F9SccHv+wk7yrD7SXDFkc9N+c6xDOht4MpFYN84b/ZbL4pVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924404; c=relaxed/simple;
	bh=RP6BYvGCrPt0MoSnfBR3dg4ltXzjA4TYTUeHKzg8CmY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MjyiCr0q+rhYXLtSQQsTARWqrQk5zgxJR2REgtv0U+BkNDzfHjr0js7XCfKcokPx+VFePN7m44AiSsZQ2n7temrGouyvuoXv4fvAghFdcF2jRsXE2YR9JyvJ5vGgWfvvrQ2OAbJxPG8tC+aotPEEvtcxVptT0DxGmYIshvSjnts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7w9vOWx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hI0OPGGm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIEsHcbJ/AJxihbyBX7O6QxThxryfbBdGxPku4YVq5w=;
	b=Z7w9vOWxy99BmS5WKIuNRrpnQs1IHFiHwZowuJODEfKVqZayE37Kcevl8wI651KpX5Q2Y6
	xt9O1Uox/Wh3HpDm+Tft1WdTogaMSm+V9/jqwZb7lkl9WoV83jIkzL/9j8MwTi89OA4s/g
	EoqPpduE8jaR1LAefpN9fKG/vNhVeEXsUMcwzNzKgkdmY4EgZRxKUSXhNqyEoU8XbIuLAh
	F3mHskXwK+b3ss2dWtGKjMG8lNvgdyV5n/UU+BnGF5IP4PhqycaEPWmoBVnfru4cDaj8dd
	LiZTNbOOb3z7djunR73C1Owfv9tdLqGVv62PJk3eINTsUiE1hD4WV+Ysli6tjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIEsHcbJ/AJxihbyBX7O6QxThxryfbBdGxPku4YVq5w=;
	b=hI0OPGGmmWfKzIkC8/CBx3miQcLDT7Go98WYNHgPyINRBv+vWgbhhZzjY3i0wzIo6wLxX3
	pDCDeMMu+bKvDBAQ==
From: "tip-bot2 for Dengjun Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Fix incorrect schedstats for rt and dl thread
Cc: Dengjun Su <dengjun.su@mediatek.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260204115959.3183567-1-dengjun.su@mediatek.com>
References: <20260204115959.3183567-1-dengjun.su@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192439672.1647592.12060557099883000432.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8248-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,vger.kernel.org:replyto,msgid.link:url];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 2BE0A184596
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c0e1832ba6dad7057acf3f485a87e0adccc23141
Gitweb:        https://git.kernel.org/tip/c0e1832ba6dad7057acf3f485a87e0adccc=
23141
Author:        Dengjun Su <dengjun.su@mediatek.com>
AuthorDate:    Wed, 04 Feb 2026 19:59:29 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:11 +01:00

sched: Fix incorrect schedstats for rt and dl thread

For RT and DL thread, only 'set_next_task_(rt/dl)' will call
'update_stats_wait_end_(rt/dl)' to update schedstats information.
However, during the migration process,
'update_stats_wait_start_(rt/dl)' will be called twice, which
will cause the values of wait_max and wait_sum to be incorrect.
The specific output as follows:
$ cat /proc/6046/task/6046/sched | grep wait
wait_start                                   :             0.000000
wait_max                                     :        496717.080029
wait_sum                                     :       7921540.776553

A complete schedstats information update flow of migrate should be
__update_stats_wait_start() [enter queue A, stage 1] ->
__update_stats_wait_end()   [leave queue A, stage 2] ->
__update_stats_wait_start() [enter queue B, stage 3] ->
__update_stats_wait_end()   [start running on queue B, stage 4]

    Stage 1: prev_wait_start is 0, and in the end, wait_start records the
    time of entering the queue.
    Stage 2: task_on_rq_migrating(p) is true, and wait_start is updated to
    the waiting time on queue A.
    Stage 3: prev_wait_start is the waiting time on queue A, wait_start is
    the time of entering queue B, and wait_start is expected to be greater
    than prev_wait_start. Under this condition, wait_start is updated to
    (the moment of entering queue B) - (the waiting time on queue A).
    Stage 4: the final wait time =3D (time when starting to run on queue B)
    - (time of entering queue B) + (waiting time on queue A) =3D waiting
    time on queue B + waiting time on queue A.

The current problem is that stage 2 does not call __update_stats_wait_end
to update wait_start, which causes the final computed wait time =3D waiting
time on queue B + the moment of entering queue A, leading to incorrect
wait_max and wait_sum.

Add 'update_stats_wait_end_(rt/dl)' in 'update_stats_dequeue_(rt/dl)' to
update schedstats information when dequeue_task.

Signed-off-by: Dengjun Su <dengjun.su@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260204115959.3183567-1-dengjun.su@mediatek.c=
om
---
 kernel/sched/deadline.c | 4 ++++
 kernel/sched/rt.c       | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d08b004..2de5727 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2142,10 +2142,14 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct s=
ched_dl_entity *dl_se,
 			int flags)
 {
 	struct task_struct *p =3D dl_task_of(dl_se);
+	struct rq *rq =3D rq_of_dl_rq(dl_rq);
=20
 	if (!schedstat_enabled())
 		return;
=20
+	if (p !=3D rq->curr)
+		update_stats_wait_end_dl(dl_rq, dl_se);
+
 	if ((flags & DEQUEUE_SLEEP)) {
 		unsigned int state;
=20
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f69e1f1..3d823f5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1302,13 +1302,18 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct s=
ched_rt_entity *rt_se,
 			int flags)
 {
 	struct task_struct *p =3D NULL;
+	struct rq *rq =3D rq_of_rt_rq(rt_rq);
=20
 	if (!schedstat_enabled())
 		return;
=20
-	if (rt_entity_is_task(rt_se))
+	if (rt_entity_is_task(rt_se)) {
 		p =3D rt_task_of(rt_se);
=20
+		if (p !=3D rq->curr)
+			update_stats_wait_end_rt(rt_rq, rt_se);
+	}
+
 	if ((flags & DEQUEUE_SLEEP) && p) {
 		unsigned int state;
=20

