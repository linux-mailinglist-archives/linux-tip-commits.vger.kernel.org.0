Return-Path: <linux-tip-commits+bounces-1997-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A594BB13
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C23E1F26918
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5111118A930;
	Thu,  8 Aug 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEomjBdg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/ShCj+r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969D18A6DD;
	Thu,  8 Aug 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113131; cv=none; b=pJuxehM7j0iPWRdwOLjLDBhwAjA+uCq8vMhFEjUd8cB7nL/y6wnjtXkC8Wo8+Bb02Ude+TM9E9nRygdh04TKQP4cAqLSQZEUbQUqTp0Ox/DVoUsKrCyyT86t468BppOJnnZpp7NbwTc6T1WxwQB680tmVLVQD2lgxY4P7e4HNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113131; c=relaxed/simple;
	bh=mZ0HiSBjCAjeHjCyIuTqH+7taXrnWSuDlLNB/YSt4uo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t3oGMXNvJQgS9yK7qqfiYxjFtejmLiACJNDLLyQ56DM0yW0hPuc0X9w40mh0DeY0Mvi8rcmOil2GJPHFyhsST73n/tto+O03gFgjnhDJsksZjQZj1TekMlvI7NnbaViRpHBuIGHAINeyNBz6uIvqhkEDGAz3LsIGaoW6bqEMeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEomjBdg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/ShCj+r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:32:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723113128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZdZRsVWV7XR543zE9D3PQTHo50emc7Sh0jVWHTqn6o=;
	b=sEomjBdgy9aIco7UMWhKefmKjD5gbnNvbXgpxyimMNLvyeBXPNWcH7ZF/QpxKbEQtFKvNY
	qYxqfE8yT2IxOjA/P/cVx8qtN1W2hDHIKUVf3+FfOlzA3hILu//2fIJly8tJRLSR2G5RaI
	9usu9hVW6HAhAhpmVpyDurt5rAOnBjevgcFdikYFfPYq1WKGOcPYOmffeCTOJxpRHRTfqa
	AUOfoXy/V0s1B4LHOam4fXxItJ5eu9N8qcezCnWU/OxH9vc8D432SWeNSuMPDEawJX/6J8
	Wn80cIRPiwsan9K9yhn0fnMlycxw3edwkTC5Sl3j2Rx805ZC8FDGtivQrbDUnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723113128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZdZRsVWV7XR543zE9D3PQTHo50emc7Sh0jVWHTqn6o=;
	b=F/ShCj+rHJvKPCLaimeSL+/EQv+lb5CWF92R4NFLwvqmwJJsUL6SI8GqSTpXgiCYKqAAo5
	2UB++ikeKQxdEkBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix event_function_call() locking
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240807115550.138301094@infradead.org>
References: <20240807115550.138301094@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311312801.2215.8572777928731385731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     558abc7e3f895049faa46b08656be4c60dc6e9fd
Gitweb:        https://git.kernel.org/tip/558abc7e3f895049faa46b08656be4c60dc6e9fd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2024 13:29:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Aug 2024 12:27:31 +02:00

perf: Fix event_function_call() locking

All the event_function/@func call context already uses perf_ctx_lock()
except for the !ctx->is_active case. Make it all consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240807115550.138301094@infradead.org
---
 kernel/events/core.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eb03c9a..ab49dea 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -263,6 +263,7 @@ unlock:
 static void event_function_call(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
 	struct event_function_struct efs = {
 		.event = event,
@@ -291,22 +292,22 @@ again:
 	if (!task_function_call(task, event_function, &efs))
 		return;
 
-	raw_spin_lock_irq(&ctx->lock);
+	perf_ctx_lock(cpuctx, ctx);
 	/*
 	 * Reload the task pointer, it might have been changed by
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
 	if (task == TASK_TOMBSTONE) {
-		raw_spin_unlock_irq(&ctx->lock);
+		perf_ctx_unlock(cpuctx, ctx);
 		return;
 	}
 	if (ctx->is_active) {
-		raw_spin_unlock_irq(&ctx->lock);
+		perf_ctx_unlock(cpuctx, ctx);
 		goto again;
 	}
 	func(event, NULL, ctx, data);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_ctx_unlock(cpuctx, ctx);
 }
 
 /*

