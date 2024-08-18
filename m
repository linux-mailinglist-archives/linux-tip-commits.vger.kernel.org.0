Return-Path: <linux-tip-commits+bounces-2064-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4351955B2E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725CB282550
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120751805E;
	Sun, 18 Aug 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sq/HhCZg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GB/1X5sF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1E156CF;
	Sun, 18 Aug 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962193; cv=none; b=Zhmm5yX8AZGyv6WE/ZnsdaSA3CpVrF1jeG4q/Ep+TFsR2F7RI7yJAvOD2WuSMFTMRJtgYHxh1HQlfy7QVLW7xzPjz4ylV/c7ZpSNrgE7ARnSpXzg6JrUosZeYYJHWtdLKEKD+bFnYy+P+75GcJlrJvh1m5u9CFtZHnzzU+AFmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962193; c=relaxed/simple;
	bh=HF5MsAFJrSn6ZZbI3X/vez7PAO+dY6mh+31HuWkncbc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PRiCKoP4UULMpQjr9wsArKM4i+mcFKDnxokU44MkQb1EK//6WBXd8g4T5JwV9wwLNr4J+vApnXClhzP2zkLRW7D+BjcLkizLuLDxImwIfMOIo5ujnVP0EzwuF9YcmP1q5pPffv/V0pOYm+rH8XLNprtHngLX/qLnucY0lvrdayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sq/HhCZg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GB/1X5sF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88rT8LmOoWNSL6faPaVKVmPB48yDxOI7UvxJ+nNt0Ns=;
	b=sq/HhCZgRWEJubGNjK3kv2iLzef3zQPX/CZsOAlxwvR9/r21rV4Tu2JMrqdwrKjpaZx0nt
	CaobAIxbd2o9dNSc+UO/4OtED7gPbT/BSkJUl5LA2aL9Y0loo0j0ngUslMoiFxfGJPR0OT
	nV/y4+6xaRFgGg0aVkaRadAkbSN97JTH+xp0vbyak/7AY9FP3neFAWJYEk+C3aOkkGVS2S
	dnWnhBFKJ++YjBWw9dcLx4diA7gwl0JnkBQ/BjG4PF1rgcjkd72szT5ujNBbivYu14dDbI
	WAF2frh40FMOMxg0rpxrGkCrT3yA1aSc08mQ41p2cxt7nO7BK5xskmxOMrJF9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88rT8LmOoWNSL6faPaVKVmPB48yDxOI7UvxJ+nNt0Ns=;
	b=GB/1X5sFvHuEBL6Uy1aV1bwYV7aIb5nOYMNNzuFcbBIkoaRQ6x1LcygrS3WdNaYm7L7zS6
	Zjnaiy0Cu/4h9aDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Teach dequeue_task() about special task states
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.110439521@infradead.org>
References: <20240727105030.110439521@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218801.2215.11112602893847347950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e1459a50ba31831efdfc35278023d959e4ba775b
Gitweb:        https://git.kernel.org/tip/e1459a50ba31831efdfc35278023d959e4ba775b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Jul 2024 21:38:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:44 +02:00

sched: Teach dequeue_task() about special task states

Since special task states must not suffer spurious wakeups, and the
proposed delayed dequeue can cause exactly these (under some boundary
conditions), propagate this knowledge into dequeue_task() such that it
can do the right thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105030.110439521@infradead.org
---
 kernel/sched/core.c  | 7 ++++++-
 kernel/sched/sched.h | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 80e639e..868b71b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6530,11 +6530,16 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
+			int flags = DEQUEUE_NOCLOCK;
+
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
 				!(prev_state & TASK_FROZEN);
 
+			if (unlikely(is_special_task_state(prev_state)))
+				flags |= DEQUEUE_SPECIAL;
+
 			/*
 			 * __schedule()			ttwu()
 			 *   prev_state = prev->state;    if (p->on_rq && ...)
@@ -6546,7 +6551,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
-			block_task(rq, prev, DEQUEUE_NOCLOCK);
+			block_task(rq, prev, flags);
 		}
 		switch_count = &prev->nvcsw;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ffca977..263b4de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2248,10 +2248,11 @@ extern const u32		sched_prio_to_wmult[40];
  *
  */
 
-#define DEQUEUE_SLEEP		0x01
+#define DEQUEUE_SLEEP		0x01 /* Matches ENQUEUE_WAKEUP */
 #define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
+#define DEQUEUE_SPECIAL		0x10
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
 

