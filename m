Return-Path: <linux-tip-commits+bounces-6122-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F5DB07327
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E6A41404
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC402F2C5A;
	Wed, 16 Jul 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xiypQgZo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UIAP95Cg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D22F3643;
	Wed, 16 Jul 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661153; cv=none; b=MyMLagCmSSWQ5n0cCKnHBfg+mowgbn3bsj1+vMu5N5mqorXNNJ8C89wK+t+tPtea91xuYnGHieRGlRo8FAtjbAYc1wseDUYwONSmtfQx2EA9rum6tXVg0Feqj3PdCh1O/ZTTAzZ7ezDHtHd1NWCspuQ5w5cc1gbzollBYgpsa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661153; c=relaxed/simple;
	bh=dWx3lE0Oluia463vcQ6dFzI2NW8+/vOygcPeDt62Dn8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UQWnu2l572pmBEaAI79xgzzKj3OJBVETBvvcrlD7GwaV4flO00LW9Kzq3D56t80tZjFjJY9thr7DkTUxioZ7I0VAcjO+CaDXB+68DckTV3rcDvyCJtRVPBQcGhiMQvFabajhbmhur8d6Sot3k+Oqhn8vOsonSnp5Mb75O1M84XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xiypQgZo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UIAP95Cg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5P0rcU56d3KD5w0GfT1aGVYBx5dqRenk94Cnj0Egis=;
	b=xiypQgZogezcAiEvsQt5xtN88DkK1fBKhIeI4B/LLxq5UKrsutxSxP/vsrKR8jVZCeGU+L
	0EjNPT545Fzp/iXwW02CQ6bkxCPEIwOx/3BwiRKrBfwj7xYoVaKTw/7BNBD1TcY1pW5+jc
	4DdR2/3LJjILKoybbiavSFgmI6LnfjXT7YJNjk9cIJc6Ewb06i/nsPQX9ulnbsDctt0FbN
	uqqhHkOo3H2IvkNVUMejphBgajf7Om5kjY3l6V7ZdL7ioyj5HoNmq6CsyMNQnGehtLSAW8
	Zemr1WpWCYoSf6QYNsfQl3NhPQvWh3XdgewcRy+fh6EQHblEfsCbUR43e698+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5P0rcU56d3KD5w0GfT1aGVYBx5dqRenk94Cnj0Egis=;
	b=UIAP95CgTB14VUKxqVHQshERk0OHPFrTsK8RWD7uBSQSCFSzwQ9a1SZNFarnMXt55C+swA
	EmSI1dnxARltAWAg==
From: "tip-bot2 for Luis Claudio R. Goncalves" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Do not call __put_task_struct() on rt if
 pi_blocked_on is set
Cc: Crystal Wood <crwood@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Wander Lairson Costa <wander@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <aGvTz5VaPFyj0pBV@uudg.org>
References: <aGvTz5VaPFyj0pBV@uudg.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266114691.406.7896002779139561970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8671bad873ebeb082afcf7b4501395c374da6023
Gitweb:        https://git.kernel.org/tip/8671bad873ebeb082afcf7b4501395c374da6023
Author:        Luis Claudio R. Goncalves <lgoncalv@redhat.com>
AuthorDate:    Mon, 07 Jul 2025 11:03:59 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:33 +02:00

sched: Do not call __put_task_struct() on rt if pi_blocked_on is set

With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
from rt_mutex_adjust_prio_chain() could happen in preemptible context and
with a mutex enqueued. That could lead to this sequence:

        rt_mutex_adjust_prio_chain()
          put_task_struct()
            __put_task_struct()
              sched_ext_free()
                spin_lock_irqsave()
                  rtlock_lock() --->  TRIGGERS
                                      lockdep_assert(!current->pi_blocked_on);

This is not a SCHED_EXT bug. The first cleanup function called by
__put_task_struct() is sched_ext_free() and it happens to take a
(RT) spin_lock, which in the scenario described above, would trigger
the lockdep assertion of "!current->pi_blocked_on".

Crystal Wood was able to identify the problem as __put_task_struct()
being called during rt_mutex_adjust_prio_chain(), in the context of
a process with a mutex enqueued.

Instead of adding more complex conditions to decide when to directly
call __put_task_struct() and when to defer the call, unconditionally
resort to the deferred call on PREEMPT_RT to simplify the code.

Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/aGvTz5VaPFyj0pBV@uudg.org
---
 include/linux/sched/task.h | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index c517dbc..ea41795 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -131,24 +131,17 @@ static inline void put_task_struct(struct task_struct *t)
 		return;
 
 	/*
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Under RT, we can only call it in preemptible context.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
-		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
-
-		lock_map_acquire_try(&put_task_map);
-		__put_task_struct(t);
-		lock_map_release(&put_task_map);
-		return;
-	}
-
-	/*
-	 * under PREEMPT_RT, we can't call put_task_struct
+	 * Under PREEMPT_RT, we can't call __put_task_struct
 	 * in atomic context because it will indirectly
-	 * acquire sleeping locks.
+	 * acquire sleeping locks. The same is true if the
+	 * current process has a mutex enqueued (blocked on
+	 * a PI chain).
+	 *
+	 * In !RT, it is always safe to call __put_task_struct().
+	 * Though, in order to simplify the code, resort to the
+	 * deferred call too.
 	 *
-	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * call_rcu() will schedule __put_task_struct_rcu_cb()
 	 * to be called in process context.
 	 *
 	 * __put_task_struct() is called when
@@ -161,7 +154,7 @@ static inline void put_task_struct(struct task_struct *t)
 	 *
 	 * delayed_free_task() also uses ->rcu, but it is only called
 	 * when it fails to fork a process. Therefore, there is no
-	 * way it can conflict with put_task_struct().
+	 * way it can conflict with __put_task_struct().
 	 */
 	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }

