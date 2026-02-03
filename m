Return-Path: <linux-tip-commits+bounces-8186-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CWoNJbZgWlYKgMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8186-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:18:46 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11552D828D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 350673009E23
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6933321A6;
	Tue,  3 Feb 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LT+t0SwY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzdMj+3J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78B333759;
	Tue,  3 Feb 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117518; cv=none; b=po6a0bfqa26WmrVVrG1cbboL4oSr0zqUIF1a3EU6x3ow1UgbX9QJ/TXEVpzF6v3b6CQGmR2BllguBd5E1Fr/Wtj962F5uvN4/EqPPRhSstb5zJ6iyUij/dnUcw7T9ldC75A3dtbmokY5mqXB+Gpm60S1kvCQ4dGybGJ1Llw7P9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117518; c=relaxed/simple;
	bh=6saCAj2DJS3Rj8sJS4rI8tXPj6TVOm+B6DnD9Rap6wk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QBP6HgGCLoGT2JkFYTJkeRMk7VYs6D3hGFUbpkkecMHNMTjW4kvgduU3pWefZcqGFoM6lTAW2RtHJOvsi0FOCUB54Q6Ow5VAfqFNToG/PiYVlf0QmbSXg4WZLNGChtDX5Dc+Ef87LHwt5pNts6sEjciaP9oq9IaTWnEKhSY0jwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LT+t0SwY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzdMj+3J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XV9dnEwg3VIWp+GkzHLVuhhaJtyDNMdkwHlozw7F5Qs=;
	b=LT+t0SwYk5BlFwNNZiK3M5ZxuaMiT8U8QHB4xMatPEQ9sJfaGC/xK6D9WD6MwXWuvrGms7
	kyE5HOPj/ULkSDa+n0hBVmHqtyRyZeEzK3Cvn0mChWpbbQcqmq0E8a3dycLTrNFVZ6gKO7
	79XUI57iRbzMC1H6n0p7haitrp7+uCGi33xsJYWUZRAonDt7sHdsvs+zUtgFcWx7/OnuJG
	G3NgB4iqCzheIdZn29z82bVb2YdYhQ3kpQym7QfpKpzFD+6EywHZHDxbb0C4qhncc1sVQy
	W/yfqtL3fkVnpOZP+FtJqUdxdhP3tpjIJHqWTV9GJ4ksp6zIFKXH6EK515Wm/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XV9dnEwg3VIWp+GkzHLVuhhaJtyDNMdkwHlozw7F5Qs=;
	b=QzdMj+3Jwqc6ir6DGJ8muKNQDaX7t+U05gFTbg8wLGbTDjCddU22zTBO4oUxsB1PaKlzol
	Z31Pwqt81cQE0SAw==
From: "tip-bot2 for Zicheng Qu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Re-evaluate scheduling when migrating queued
 tasks out of throttled cgroups
Cc: Zicheng Qu <quzicheng@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Aaron Lu <ziqianlu@bytedance.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260130083438.1122457-1-quzicheng@huawei.com>
References: <20260130083438.1122457-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011751256.2495410.3734365532314031073.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8186-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,vger.kernel.org:replyto,infradead.org:email,huawei.com:email,bytedance.com:email]
X-Rspamd-Queue-Id: 11552D828D
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e34881c84c255bc300f24d9fe685324be20da3d1
Gitweb:        https://git.kernel.org/tip/e34881c84c255bc300f24d9fe685324be20=
da3d1
Author:        Zicheng Qu <quzicheng@huawei.com>
AuthorDate:    Fri, 30 Jan 2026 08:34:38=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:19 +01:00

sched: Re-evaluate scheduling when migrating queued tasks out of throttled cg=
roups

Consider the following sequence on a CPU configured with nohz_full:

1) A task P runs in cgroup A, and cgroup A becomes throttled due to CFS
   bandwidth control. The gse (cgroup A) where the task P attached is
dequeued and the CPU switches to idle.

2) Before cgroup A is unthrottled, task P is migrated from cgroup A to
   another cgroup B (not throttled).

   During sched_move_task(), the task P is observed as queued but not
running, and therefore no resched_curr() is triggered.

3) Since the CPU is nohz_full, it remains in do_idle() waiting for an
   explicit scheduling event, i.e., resched_curr().

4) For kernel <=3D 5.10: Later, cgroup A is unthrottled. However, the task
   P has already been migrated out of cgroup A, so unthrottle_cfs_rq()
may observe load_weight =3D=3D 0 and return early without resched_curr()
called. For kernel >=3D 6.6: The unthrottling path normally triggers
`resched_curr()` almost cases even when no runnable tasks remain in the
unthrottled cgroup, preventing the idle stall described above. However,
if cgroup A is removed before it gets unthrottled, the unthrottling path
for cgroup A is never executed. In a result, no `resched_curr()` can be
called.

5) At this point, the task P is runnable in cgroup B (not throttled), but
the CPU remains in do_idle() with no pending reschedule point. The
system stays in this state until an unrelated event (e.g. a new task
wakeup or any cases) that can trigger a resched_curr() breaks the
nohz_full idle state, and then the task P finally gets scheduled.

The root cause is that sched_move_task() may classify the task as only
queued, not running, and therefore fails to trigger a resched_curr(),
while the later unthrottling path no longer has visibility of the
migrated task.

Preserve the existing behavior for running tasks by issuing
resched_curr(), and explicitly invoke check_preempt_curr() for tasks
that were queued at the time of migration. This ensures that runnable
tasks are reconsidered for scheduling even when nohz_full suppresses
periodic ticks.

Fixes: 29f59db3a74b ("sched: group-scheduler core")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Link: https://patch.msgid.link/20260130083438.1122457-1-quzicheng@huawei.com
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f2dc0a..b411e4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9126,6 +9126,7 @@ void sched_move_task(struct task_struct *tsk, bool for_=
autogroup)
 {
 	unsigned int queue_flags =3D DEQUEUE_SAVE | DEQUEUE_MOVE;
 	bool resched =3D false;
+	bool queued =3D false;
 	struct rq *rq;
=20
 	CLASS(task_rq_lock, rq_guard)(tsk);
@@ -9137,10 +9138,13 @@ void sched_move_task(struct task_struct *tsk, bool fo=
r_autogroup)
 			scx_cgroup_move_task(tsk);
 		if (scope->running)
 			resched =3D true;
+		queued =3D scope->queued;
 	}
=20
 	if (resched)
 		resched_curr(rq);
+	else if (queued)
+		wakeup_preempt(rq, tsk, 0);
=20
 	__balance_callbacks(rq, &rq_guard.rf);
 }

