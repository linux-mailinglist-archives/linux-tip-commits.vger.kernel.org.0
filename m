Return-Path: <linux-tip-commits+bounces-8010-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E901D28937
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 366D430524C6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F02326945;
	Thu, 15 Jan 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yITmWvS6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LuZfI0bF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7251322A3E;
	Thu, 15 Jan 2026 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510866; cv=none; b=nRlSm1fu/Ajh33iEJmkWJyVjYnUH8ZjuBT7iH6lgVneDHaKvmMVaTSeXiBeHLNV1PIjBZmJl7ORaK2RWrCqrmEB0HlVhqNUPsSRovzeMR7fD82qCk8lYCIqdcHBNbILQISIZAITMtMv/bytpadEEFyL7VCr0xAXMMUpPCrjaF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510866; c=relaxed/simple;
	bh=uAcrq4ca2SKM8MSjJlqOrTeeR2a3pQ+YhhP0o8uxzjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bf/eb0YT6Ku15Ca+tH427cSfy+BTlhszAois4ZjXBeoyZygvOVc4RMTj3uwymzRr75afvRIjMuFWrNZxoElIrCjehjmX3LjwLLrSYglWoJqEwX+w01HBdGgfHaa+8FUJPSW271k/B7EwJlBBK+Fwa7cvJLCijaXEiPCRnd9lj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yITmWvS6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LuZfI0bF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768510861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13zemSSMl2gkhamf0NIvJN+hDnlRoXDPZiv7xfBesAk=;
	b=yITmWvS6eAEFiebX5cb3wSeU7gpvsBF8lAPww7wk8MAtGQFw8fcSq7/KnGAswqumqVnvHg
	l3GX0Ttzs84l1aN3hUpvvA0a++7Qpn0xcRVSQDofkqgjvbwa3PHPFSPSH8fgx2JVxUJqpK
	NbXxaCKijIpz4darjBamJdvhLPA3V6AXMa+s0QIDz13PaqIn38cu+DdfiRk7b4V39HCaQG
	KyX1ctZM3/jxY6rtVgYeW1yTbD8UOs37INrWBj+lGrUiAi6tJmtyQRY/0kGTR9R653GlhO
	EuJpzB6yq3iYJgyhDFpvw7KLEZgvRHKbHT80E6QRntc6NHcXr55B94sQbzwZhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768510861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13zemSSMl2gkhamf0NIvJN+hDnlRoXDPZiv7xfBesAk=;
	b=LuZfI0bFmLlH6qMdCEjWaxrJzyDWOAB25AYrgN/WWNhJMlK6nrdcD58eq2XccDGg8eZCHy
	M20WyQVp0us+u7BA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Audit MOVE vs balance_callbacks
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
References: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851086058.510.7502048410934027613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     53439363c0a111f11625982b69c88ee2ce8608ec
Gitweb:        https://git.kernel.org/tip/53439363c0a111f11625982b69c88ee2ce8=
608ec
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Jan 2026 09:17:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 21:57:53 +01:00

sched: Audit MOVE vs balance_callbacks

The {DE,EN}QUEUE_MOVE flag indicates a task is allowed to change
priority, which means there could be balance callbacks queued.

Therefore audit all MOVE users and make sure they do run balance
callbacks before dropping rq-lock.

Fixes: 6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change=
 pattern")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20260114130528.GB831285@noisy.programming.kick=
s-ass.net
---
 kernel/sched/core.c  | 4 +++-
 kernel/sched/ext.c   | 1 +
 kernel/sched/sched.h | 5 ++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 842a3ad..4d925d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4950,7 +4950,7 @@ struct balance_callback *splice_balance_callbacks(struc=
t rq *rq)
 	return __splice_balance_callbacks(rq, true);
 }
=20
-static void __balance_callbacks(struct rq *rq, struct rq_flags *rf)
+void __balance_callbacks(struct rq *rq, struct rq_flags *rf)
 {
 	if (rf)
 		rq_unpin_lock(rq, rf);
@@ -9126,6 +9126,8 @@ void sched_move_task(struct task_struct *tsk, bool for_=
autogroup)
=20
 	if (resched)
 		resched_curr(rq);
+
+	__balance_callbacks(rq, &rq_guard.rf);
 }
=20
 static struct cgroup_subsys_state *
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8f6d8d7..afe28c0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -545,6 +545,7 @@ static void scx_task_iter_start(struct scx_task_iter *ite=
r)
 static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
 {
 	if (iter->locked_task) {
+		__balance_callbacks(iter->rq, &iter->rf);
 		task_rq_unlock(iter->rq, iter->locked_task, &iter->rf);
 		iter->locked_task =3D NULL;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e885a93..93fce4b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2388,7 +2388,8 @@ extern const u32		sched_prio_to_wmult[40];
  *                should preserve as much state as possible.
  *
  * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
- *        in the runqueue.
+ *        in the runqueue. IOW the priority is allowed to change. Callers
+ *        must expect to deal with balance callbacks.
  *
  * NOCLOCK - skip the update_rq_clock() (avoids double updates)
  *
@@ -3969,6 +3970,8 @@ extern void enqueue_task(struct rq *rq, struct task_str=
uct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
=20
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
+
+extern void __balance_callbacks(struct rq *rq, struct rq_flags *rf);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
=20
 /*

