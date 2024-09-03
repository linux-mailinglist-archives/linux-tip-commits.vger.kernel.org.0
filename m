Return-Path: <linux-tip-commits+bounces-2151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5E969F2B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7201C23CFC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D98EAD2;
	Tue,  3 Sep 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owGsSSlJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3L0OSgxW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6828F45;
	Tue,  3 Sep 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370704; cv=none; b=fH4TRlIc/u7afpS5xHe8G6pBEK1Gr4GYlA2FgUORb0Q6dRlbKlNK4khpP5/S5Ysu8lc7yrjeOf9rpuZSkO5CSWk9O8L/S/ERFNfY36F9ZPL5ywHWyTCNfkT6QImyw7sWqElrVboMcxrzETpn19i2+gMhcLo3VInazbBC2SB2lDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370704; c=relaxed/simple;
	bh=aT7Ns45/bTWDTV5pB8plpDfKzkiDPYHcI43zO5yPuCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BjraaS5cH2zQT3un4RZi+vlb3AJq3TIJ/IY8GlGXDXdM9n5Fe6/atWYf94H1fMv4hocvATA1uq99YnF6lVGtKTfeX7JT3enoIExbU+haSRTSq9VeYA5zeZvJuYPQMcL2BLIlsthB6+obM916HIAtd0jsLOkS+QLnX44wCbqtpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owGsSSlJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3L0OSgxW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7tA3gbmsBCbImecMYODl0e2F6859o8j94UFbyMfmMs=;
	b=owGsSSlJR85bktNxkVusqsx3gRFQ07XGd7PcpJM/1SpWJP5Qut+EAPPEYxXwNvg5RmEzjF
	1CeISDsra6CPFqxZVf7v8/B//w97DX75JnmmNUpIJ2PaeiMKFdvTg/tJF+DIcNmmzvUCZM
	2+8D+LzohoiaLgrtOK3mnBVuxlKFQfEGkeykbqmF0qkjDznFRZTCZ8YUiLRUzyn84kzL0A
	LD9cFGq8G/kGUnW705rr8+N1Y9e1+PUnGYX52yyQl6wbuCtDqE4zZoavarErz6Ekk97j/q
	Pofj1m5ze/4WLEe5MLPG28z0aY9ID/tsmbWM29BdWg43diBP6zhGzRw11lSJsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7tA3gbmsBCbImecMYODl0e2F6859o8j94UFbyMfmMs=;
	b=3L0OSgxWJsdOXbHnsWLzzHzX5Df6ogQ2rV7NZZPh4Cxah2CbidgJPx5zWGhCD5PUG8T8j/
	I0BAPaJLMEb+AWAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Split up put_prev_task_balance()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224015.943143811@infradead.org>
References: <20240813224015.943143811@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070106.2215.9756073674434114144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     260598f142c34811d226fdde5ab0346b48181439
Gitweb:        https://git.kernel.org/tip/260598f142c34811d226fdde5ab0346b48181439
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:31 +02:00

sched: Split up put_prev_task_balance()

With the goal of pushing put_prev_task() after pick_task() / into
pick_next_task().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224015.943143811@infradead.org
---
 kernel/sched/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 406b794..36f9bc5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5841,8 +5841,8 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 	schedstat_inc(this_rq()->sched_count);
 }
 
-static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
-				  struct rq_flags *rf)
+static void prev_balance(struct rq *rq, struct task_struct *prev,
+			 struct rq_flags *rf)
 {
 #ifdef CONFIG_SMP
 	const struct sched_class *class;
@@ -5860,8 +5860,6 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	}
 #endif
 
-	put_prev_task(rq, prev);
-
 	/*
 	 * We've updated @prev and no longer need the server link, clear it.
 	 * Must be done before ->pick_next_task() because that can (re)set
@@ -5917,7 +5915,8 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 restart:
-	put_prev_task_balance(rq, prev, rf);
+	prev_balance(rq, prev, rf);
+	put_prev_task(rq, prev);
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
@@ -6017,7 +6016,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		goto out;
 	}
 
-	put_prev_task_balance(rq, prev, rf);
+	prev_balance(rq, prev, rf);
+	put_prev_task(rq, prev);
 
 	smt_mask = cpu_smt_mask(cpu);
 	need_sync = !!rq->core->core_cookie;

