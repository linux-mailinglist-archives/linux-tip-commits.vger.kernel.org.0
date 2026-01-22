Return-Path: <linux-tip-commits+bounces-8092-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB80Dlr6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8092-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:22:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECE652C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E2AA669789
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4A6356A24;
	Thu, 22 Jan 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRnS7Tcj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhuLkBLB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770413370E2;
	Thu, 22 Jan 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076939; cv=none; b=HU0/BglHWGEkEYxO/oBQxLWiQqMJZV9rxXPfWxOwZsa3sGepx/fUOO+6FjcaIExzlvv/ozNHV3E06bNRhaxWSetTa82kqlKiPbjDIc61mEVdcE7iIsdwskiknqwGXLXHUoCN4WarGPxTNs4wwytbnF/wDa0fdXpF7AidzPXoPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076939; c=relaxed/simple;
	bh=cySwJIPJKbaxtCc5eCWYoCl9wOGMRGVM4PvgHx0teR8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u3quHDp7TawGqdrINewyVMF8SrxfsFSKm0R37HtOLuHTODn70aVI0E5/Yq5lMxeBeZAKZ4LOzN8wiZcDVIRyj6ggteUkNiUhegqqXHtu60vPy/xICFIjKRGf8bbpPwQy80V3fVkZDFy0gQ9mv+WyKS6fFq8uq8yFOOoOXxJsfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRnS7Tcj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhuLkBLB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUVYu6x5pFijLW/wSfrXtxULHdWq2HVtgIbCLkDBxzE=;
	b=dRnS7Tcjpbo5WJOyk8jKs5vGC9n/DVLbIESKWEOOU3rwdvWPbi8C/0XqIJG1WvD3wGxCvu
	o+tJLrcwScjWWlMUdwAqgRY3ANkB8TXuq7mjCf3JCSrkbARVT9HBHSCUfv+ccgGT/CTIQx
	PPpR19o7+4kniGKDs8U6rsNwDgqoeUZHzVhRAzltHZWX48flJORUYF6eZxpG3Ujb9Cwy8d
	dx3XBMBfyLsov9HvWGo27guU8urEo8d6k7jXMKj8KwUZy21igL3Pi58vY+Ryu2uCFWiQ/2
	rpmXJTYFQkARXWXYNh+ShJFymIn+r1ua7eG85KduB2XicWaNvM6RvLXk63s0dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUVYu6x5pFijLW/wSfrXtxULHdWq2HVtgIbCLkDBxzE=;
	b=PhuLkBLBr1ybEl6u4YuFIOpavblY9ibhaP66UrrQrz+vzjMtagShNdD+ecpvtrJevAJScY
	FQ1zHWMG6ZsyBHDQ==
From: "tip-bot2 for Shubhang Kaushik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Update rq->avg_idle when a task is moved to
 an idle CPU
Cc: Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20260121-v8-patch-series-v8-1-b7f1cbee5055@os.amperecomputing.com>
References:
 <20260121-v8-patch-series-v8-1-b7f1cbee5055@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907693368.510.564694445484485322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amperecomputing.com:email,msgid.link:url,vger.kernel.org:replyto,linaro.org:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linutronix.de:dkim,infradead.org:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8092-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: DCECE652C2
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4b603f1551a73e2868b9e7a14b3938c23275cefb
Gitweb:        https://git.kernel.org/tip/4b603f1551a73e2868b9e7a14b3938c2327=
5cefb
Author:        Shubhang Kaushik <shubhang@os.amperecomputing.com>
AuthorDate:    Wed, 21 Jan 2026 01:31:53 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:21 +01:00

sched: Update rq->avg_idle when a task is moved to an idle CPU

Currently, rq->idle_stamp is only used to calculate avg_idle during
wakeups. This means other paths that move a task to an idle CPU such as
fork/clone, execve, or migrations, do not end the CPU's idle status in
the scheduler's eyes, leading to an inaccurate avg_idle.

This patch introduces update_rq_avg_idle() to provide a more accurate
measurement of CPU idle duration. By invoking this helper in
put_prev_task_idle(), we ensure avg_idle is updated whenever a CPU
stops being idle, regardless of how the new task arrived.

Testing on an 80-core Ampere Altra (ARMv8) with 6.19-rc5 baseline:
 - Hackbench : +7.2% performance gain at 16 threads.
 - Schbench: Reduced p99.9 tail latencies at high concurrency.

Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260121-v8-patch-series-v8-1-b7f1cbee5055@os.=
amperecomputing.com
---
 kernel/sched/core.c  | 24 ++++++++++++------------
 kernel/sched/idle.c  |  1 +
 kernel/sched/sched.h |  1 +
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cca012..c5431af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3613,6 +3613,18 @@ static inline void ttwu_do_wakeup(struct task_struct *=
p)
 	trace_sched_wakeup(p);
 }
=20
+void update_rq_avg_idle(struct rq *rq)
+{
+	u64 delta =3D rq_clock(rq) - rq->idle_stamp;
+	u64 max =3D 2*rq->max_idle_balance_cost;
+
+	update_avg(&rq->avg_idle, delta);
+
+	if (rq->avg_idle > max)
+		rq->avg_idle =3D max;
+	rq->idle_stamp =3D 0;
+}
+
 static void
 ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		 struct rq_flags *rf)
@@ -3648,18 +3660,6 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p,=
 int wake_flags,
 		p->sched_class->task_woken(rq, p);
 		rq_repin_lock(rq, rf);
 	}
-
-	if (rq->idle_stamp) {
-		u64 delta =3D rq_clock(rq) - rq->idle_stamp;
-		u64 max =3D 2*rq->max_idle_balance_cost;
-
-		update_avg(&rq->avg_idle, delta);
-
-		if (rq->avg_idle > max)
-			rq->avg_idle =3D max;
-
-		rq->idle_stamp =3D 0;
-	}
 }
=20
 /*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 65eb8f8..aba5ad5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -460,6 +460,7 @@ static void put_prev_task_idle(struct rq *rq, struct task=
_struct *prev, struct t
 {
 	update_curr_idle(rq);
 	scx_update_idle(rq, false, true);
+	update_rq_avg_idle(rq);
 }
=20
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool=
 first)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58c9d24..127633b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1670,6 +1670,7 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_=
entity *grp)
=20
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
=20
+extern void update_rq_avg_idle(struct rq *rq);
 extern void update_rq_clock(struct rq *rq);
=20
 /*

