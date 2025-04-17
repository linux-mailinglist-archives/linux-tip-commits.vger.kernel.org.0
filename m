Return-Path: <linux-tip-commits+bounces-5039-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E05A91D31
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473CE3A715C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DFB24CECE;
	Thu, 17 Apr 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nQEiibq0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nw9N1Cqm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04324C06F;
	Thu, 17 Apr 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894899; cv=none; b=OXxCk9/lcqnhkWSozjeO6p3dJQtlk/UKLdXpAVuV9mZeGnf/iBZI3O7oNrHL6kWrkVLjvncpyeUf2xQtMXWzDr9A6tAH3vLX4mrklLMgPuDcIy5qc+zjpdoUzx2rjrkfjXbTRLafuPd/sO5RsweLWP7/PVXK6ebCHikkdcXNh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894899; c=relaxed/simple;
	bh=tkFQ1Lx70usIiXgBTZjnEcU0PDYj2osp4CgS0oJ+M2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ohNMtrUTmS0GrA6QZXpus+TR2pcTZ8TwfAzsTHSrDykZ+0i08lHw8zzbSVawTsCp6OIKiavwpDomIe3qr7lVANYyx0HyWQhzaOEIbR3kG5vdo59DXmkGxZ7jJ0Z8576jpRnvMEwH2mVq6cfhxBkmfnKFnATyS8Abu5mxg/0S6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nQEiibq0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nw9N1Cqm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/2R45slX9HXTAqukWSoX+Crdu0zX4SVp6IFUfsj5UU=;
	b=nQEiibq0asNff2ynGxEw/pRhpXi7wP2UTiLEkP4T3HIUFGQ5Sj66fDn3Hj7nrt8I8lMXc3
	qxK2qxous0000/MipnuWBqLVy18liByZGm5CCpULqfd/l9/TmfvPEumVwjGRiCyNGi2UGT
	41/GhERyDIUuCIfURb7XdlrnnsyicxEnhY3JUDq4UrdXrrzD9H0bRPQ017L29Kuq9nRYEC
	qjtCOjE/ouD/H+I+zwa51vA1JFAfjq5wiICNU8ln+twv89R1ywyyD+1yoQPgk8exaJqN+e
	ciJA+IIg0m1u6K/4g5fXAq4AxSTp74Mz40TKDQtsOhid/U0E/QPTTpsdIKICzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/2R45slX9HXTAqukWSoX+Crdu0zX4SVp6IFUfsj5UU=;
	b=nw9N1CqmbYTn6kix3CnENARTCQCYlTH8sPsu+BqTy+Ipw12oJFOyWqm5wDpX694k6Ksspt
	7n1yAPAhBFhzboBA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix put_ctx() ordering
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Z_ZvmEhjkAhplCBE@localhost.localdomain>
References: <Z_ZvmEhjkAhplCBE@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489366.31282.15544367638246694854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2839f393c69456bc356738e521b2e70b82977f46
Gitweb:        https://git.kernel.org/tip/2839f393c69456bc356738e521b2e70b82977f46
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 15:01:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:15 +02:00

perf/core: Fix put_ctx() ordering

So there are three situations:

* If perf_event_free_task() has removed all the children from the parent list
  before perf_event_release_kernel() got a chance to even iterate them, then
  it's all good as there is no get_ctx() pending.

* If perf_event_release_kernel() iterates a child event, but it gets freed
  meanwhile by perf_event_free_task() while the mutexes are temporarily
  unlocked, it's all good because while locking again the ctx mutex,
  perf_event_release_kernel() observes TASK_TOMBSTONE.

* But if perf_event_release_kernel() frees the child event before
  perf_event_free_task() got a chance, we may face this scenario:

    perf_event_release_kernel()                                  perf_event_free_task()
    --------------------------                                   ------------------------
    mutex_lock(&event->child_mutex)
    get_ctx(child->ctx)
    mutex_unlock(&event->child_mutex)

    mutex_lock(ctx->mutex)
    mutex_lock(&event->child_mutex)
    perf_remove_from_context(child)
    mutex_unlock(&event->child_mutex)
    mutex_unlock(ctx->mutex)

                                                                 // This lock acquires ctx->refcount == 2
                                                                 // visibility
                                                                 mutex_lock(ctx->mutex)
                                                                 ctx->task = TASK_TOMBSTONE
                                                                 mutex_unlock(ctx->mutex)

                                                                 wait_var_event()
                                                                     // enters prepare_to_wait() since
                                                                     // ctx->refcount == 2
                                                                     // is guaranteed to be seen
                                                                     set_current_state(TASK_INTERRUPTIBLE)
                                                                     smp_mb()
                                                                     if (ctx->refcount != 1)
                                                                         schedule()
    put_ctx()
       // NOT fully ordered! Only RELEASE semantics
       refcount_dec_and_test()
           atomic_fetch_sub_release()
       // So TASK_TOMBSTONE is not guaranteed to be seen
       if (ctx->task == TASK_TOMBSTONE)
           wake_up_var()

Basically it's a broken store buffer:

    perf_event_release_kernel()                                  perf_event_free_task()
    --------------------------                                   ------------------------
    ctx->task = TASK_TOMBSTONE                                   smp_store_release(&ctx->refcount, ctx->refcount - 1)
    smp_mb()
    READ_ONCE(ctx->refcount)                                     READ_ONCE(ctx->task)

So we need a smp_mb__after_atomic() before looking at ctx->task.

Fixes: 59f3aa4a3ee2 ("perf: Simplify perf_event_free_task() wait")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/Z_ZvmEhjkAhplCBE@localhost.localdomain
---
 kernel/events/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e4d7a0c..1a19df9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1271,9 +1271,10 @@ static void put_ctx(struct perf_event_context *ctx)
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
 			put_task_struct(ctx->task);
 		call_rcu(&ctx->rcu_head, free_ctx);
-	} else if (ctx->task == TASK_TOMBSTONE) {
-		smp_mb(); /* pairs with wait_var_event() */
-		wake_up_var(&ctx->refcount);
+	} else {
+		smp_mb__after_atomic(); /* pairs with wait_var_event() */
+		if (ctx->task == TASK_TOMBSTONE)
+			wake_up_var(&ctx->refcount);
 	}
 }
 

