Return-Path: <linux-tip-commits+bounces-6056-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3340B0024A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60723B8EBC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570711CA0;
	Thu, 10 Jul 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKvLjKfp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2QSx0JW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F43195FE8;
	Thu, 10 Jul 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151574; cv=none; b=UEk7qv9pyQ8fnZu+jsBBdxpIpW6YuQ/JGpYIPRvmAXauaSVosMRL9ggwhI9p1vimfaQKg7eDkuRxYhjFmKuZRZZvtvradEwLktB5l7nlkXp/+cU1BoGXgi/YJWOd5/JVQ27mVWHTvq6K/sWAIgY0jtqR1uD4qC6VZNsNPR6OIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151574; c=relaxed/simple;
	bh=jRSjBPiMGPq/h1rUkqrtXAs73AlE4m5U5MCfnsGsVjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FWcRR956xOa0algMXdp5+x2BMSr5dCPUUE+Zt3pFqI1WeL5UjvJ34PirreevEWGnutyuM41mX1WVb+AuvhE0hg9nGmQGPYnC36csxB8X80I3rFjSzgjdn22j8tGIwiRCXfMsIYA0rvuoLiME1U+4jFJNuUPe63i1AqPlQJipjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKvLjKfp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2QSx0JW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GpoaO58hsCkN19WFhqBzJSOFJ0U0XhMGcD93MD3UWI=;
	b=IKvLjKfpkwVCQNw8egGy7sBCkuL4t3oMAQgCQTbOZp0V7JWct3/r2f6JMcrGBurgkvf66I
	rbpcyARNF+buIU8tRWlUY2K6kVpE/usV++ry2dr01a7f/jfYYc7nC8nvc+3jeUJwITuoip
	28s5DVY+z89d32uEfyEIq2m3MMl3zphx1HBg9cYQ050egVs6I9DsJrLYrXavYMhOyyjUPD
	dDkFefWUNe3bA24KpnAQb2ord9LegcZvwQ1inMWe5AShEighDoGp3IKnI6lb8YiEUyOUrZ
	dUMb0JvHV5v2C2XBmJ6huzQRbmPl+LBES/AVJmvaYTNfbDQAUz8v3k2/AXC4PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GpoaO58hsCkN19WFhqBzJSOFJ0U0XhMGcD93MD3UWI=;
	b=b2QSx0JWgYWtl7OgtuU1iu4MZr26ZVqkzSEDRp53qOdvVXs6Fl76YqolmHefPCSzf53FbY
	Nh4rOVxXk+cYR6CQ==
From: "tip-bot2 for Tetsuo Handa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix WARN in perf_sigtrap()
Cc: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <b1c224bd-97f9-462c-a3e3-125d5e19c983@I-love.SAKURA.ne.jp>
References: <b1c224bd-97f9-462c-a3e3-125d5e19c983@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215156980.406.5266536077191342299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3da6bb419750f3ad834786d6ba7c9d5d062c770b
Gitweb:        https://git.kernel.org/tip/3da6bb419750f3ad834786d6ba7c9d5d062c770b
Author:        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate:    Wed, 09 Jul 2025 20:27:52 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:17 +02:00

perf/core: Fix WARN in perf_sigtrap()

Since exit_task_work() runs after perf_event_exit_task_context() updated
ctx->task to TASK_TOMBSTONE, perf_sigtrap() from perf_pending_task() might
observe event->ctx->task == TASK_TOMBSTONE.

Swap the early exit tests in order not to hit WARN_ON_ONCE().

Closes: https://syzkaller.appspot.com/bug?extid=2fe61cb2a86066be6985
Reported-by: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/b1c224bd-97f9-462c-a3e3-125d5e19c983@I-love.SAKURA.ne.jp
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0db36b2..22fdf0c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7204,18 +7204,18 @@ void perf_event_wakeup(struct perf_event *event)
 static void perf_sigtrap(struct perf_event *event)
 {
 	/*
-	 * We'd expect this to only occur if the irq_work is delayed and either
-	 * ctx->task or current has changed in the meantime. This can be the
-	 * case on architectures that do not implement arch_irq_work_raise().
+	 * Both perf_pending_task() and perf_pending_irq() can race with the
+	 * task exiting.
 	 */
-	if (WARN_ON_ONCE(event->ctx->task != current))
+	if (current->flags & PF_EXITING)
 		return;
 
 	/*
-	 * Both perf_pending_task() and perf_pending_irq() can race with the
-	 * task exiting.
+	 * We'd expect this to only occur if the irq_work is delayed and either
+	 * ctx->task or current has changed in the meantime. This can be the
+	 * case on architectures that do not implement arch_irq_work_raise().
 	 */
-	if (current->flags & PF_EXITING)
+	if (WARN_ON_ONCE(event->ctx->task != current))
 		return;
 
 	send_sig_perf((void __user *)event->pending_addr,

