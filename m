Return-Path: <linux-tip-commits+bounces-5490-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B472FAAF83C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040EF188390B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0A20C005;
	Thu,  8 May 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fh3Wp7Wc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iA9NkgaP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE842AB0;
	Thu,  8 May 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701028; cv=none; b=igzpI2h0I4VGuVjN7Ei269fyXMf+PudRyrqBFlHSx9IE0DzXidlk6nUwTGXhsU4O88wjkupdmgafz28UVbGmlPsd7QQ4RgrkFpWY+DXQxb9bz5KgY2cuBL1+3QsGZvqTbolRshwAuRfs2cRHrfXN9I4xgQCqovFToGzLXoWSa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701028; c=relaxed/simple;
	bh=SShU7eKVdBBt5Izkeo9ACVtPNcohKBaUf3Hy7WUnUwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e4Fq7MSPeBhTDE5E4xiNzQWw1XscR+HiADXveLWs4dPgEs5uaRUFshuQzI0BAw8pNGzcLKkIH8jjsZIbL9WgW9V8GCbcylUg1o1hnFblGmfM1C7IY53ndMBo/Doqocsbyf+jEWeA6Q/7xCDDKX+/Lyt+hMHMVLC1FWvifSqVe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fh3Wp7Wc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iA9NkgaP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:43:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746701024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojcWYoOszSDt9bLipuu+MivUkZHGSkB8g3o9wb8+WPw=;
	b=fh3Wp7Wck9pY6yoCHH+zBxnJwDr/0HqYin1nZ39xTvlDEhhJXvXPW1ab72gBH+Uq0NwLb3
	f4cgeDBS3tdA0xs7ANG9MlkQlH8cOG3QYtvimwE8WA/Oj9ToJ9r+U0jA+KFcUJdEfJ9sR7
	kPGremBhlb22n6gKssNlO+6N9QasnpQ4Kkn+hDPVU++pPaOcJv6LE2FmBgGb8oaU6Ou0Jx
	QTIY2fzsYRaZkIxLLD9dEuPHXC6oClMEQZaWsfPqfk2es1oT9HZtJoGgw1IzSCl+a2nyio
	qXCfA3Qj8hDDPQ9SKI9dCk6eAxaqR4B2Gz1FfgplDrYl6VH4mRpCqyl1/CHskQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746701024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojcWYoOszSDt9bLipuu+MivUkZHGSkB8g3o9wb8+WPw=;
	b=iA9NkgaPFfvJNfugePzQ1DgsHyDmOvMisMrUCKQt9gXFZOS5J45Tx6AA9FrDKAEXVpYJdQ
	4gVb5d2gECg9khDQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks
Cc: peter-yc.chang@mediatek.com, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250429150736.3778580-1-jstultz@google.com>
References: <20250429150736.3778580-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670102367.406.15930935491833687192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b7ca5743a2604156d6083b88cefacef983f3a3a6
Gitweb:        https://git.kernel.org/tip/b7ca5743a2604156d6083b88cefacef983f3a3a6
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Tue, 29 Apr 2025 08:07:26 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Apr 2025 14:45:41 +02:00

sched/core: Tweak wait_task_inactive() to force dequeue sched_delayed tasks

It was reported that in 6.12, smpboot_create_threads() was
taking much longer then in 6.6.

I narrowed down the call path to:
 smpboot_create_threads()
 -> kthread_create_on_cpu()
    -> kthread_bind()
       -> __kthread_bind_mask()
          ->wait_task_inactive()

Where in wait_task_inactive() we were regularly hitting the
queued case, which sets a 1 tick timeout, which when called
multiple times in a row, accumulates quickly into a long
delay.

I noticed disabling the DELAY_DEQUEUE sched feature recovered
the performance, and it seems the newly create tasks are usually
sched_delayed and left on the runqueue.

So in wait_task_inactive() when we see the task
p->se.sched_delayed, manually dequeue the sched_delayed task
with DEQUEUE_DELAYED, so we don't have to constantly wait a
tick.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: peter-yc.chang@mediatek.com
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250429150736.3778580-1-jstultz@google.com
---
 kernel/sched/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 79692f8..a3507ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2283,6 +2283,12 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * just go back and repeat.
 		 */
 		rq = task_rq_lock(p, &rf);
+		/*
+		 * If task is sched_delayed, force dequeue it, to avoid always
+		 * hitting the tick timeout in the queued case
+		 */
+		if (p->se.sched_delayed)
+			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		trace_sched_wait_task(p);
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);

