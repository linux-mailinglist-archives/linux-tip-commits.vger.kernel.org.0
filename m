Return-Path: <linux-tip-commits+bounces-2598-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC849B0C92
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9943928493C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0C217652;
	Fri, 25 Oct 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HjUlKE7F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vOzH6e4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91892216E1D;
	Fri, 25 Oct 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879292; cv=none; b=lvhtr4Rn7oyyM7sxdUYkHcETaP2+tXztOpeJdVeMur3maul124/OeJ2n6cJKVhJiaz97FzxlWetY27ISg2fntZtsqnSzDMDH6bAdTEJ/dqXwoOC8R2LsekkuYTDIQujp+/TggFYzkxu3KJbmvj2SgsuTV8GskEpDnxFeteli7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879292; c=relaxed/simple;
	bh=uaiTIBXNWjLNwpeB8bTSdqcaa5zUqmJYyHCO0dzeL1I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GXZqGjyfjwzOk0VdjaUVXbkxUiZe+w9/Xw7bD1s5/l0If/LwFgCi9Cuh+twCB7mUmai3Wk3S9I04BR9ef9S9DVTzrGzHaDnRuRW+CU9jBGlGIXG8BZmRo1qN4/hpfazAw3iTbYIs+G0pVIjrJj3zj8Br1HEPHe5vLm9zDFuvTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HjUlKE7F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vOzH6e4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayoyN6PjufVm8j7d+VZjbZ1Svf/KoArAtTeyV8n5NaY=;
	b=HjUlKE7FkOdn4ZfDHzIJIgDUs7EgEXSXJ8AYRj5Tfa1SedUk1PZqek8/azoC0LQhVXXi69
	3FDc2+3wL9nuCIdqntHBuaqJT4YOq28ouwoOkKjcul6mXP2L9Zbi/Ng7GzUY5vD6Ukg7F3
	VLLqBOW99ED4eJbGcPmEpk/s789H2eSlEgzRwOCBqqTW1iVoL5Emin0nMY0ZQpYi8Tu+kZ
	6wIUsU+/C2YnBtBQMkubLjjeFmgHBoYLkO6ZMcXYDT+B7YNT0FWDLkieCA6S+RJPPqKpDT
	zimj2rKgs4OEjkY4QNUyOs82j2tyupvyiowa1Hdmyw5vMySx+3CtbFnRwcSbCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayoyN6PjufVm8j7d+VZjbZ1Svf/KoArAtTeyV8n5NaY=;
	b=0vOzH6e4HfDDFudUUV3IvbTG16/kH22sUfMzCIc7SFF8A+0FcHZDQnEIbN9a2e5MoO/w1m
	YHqqak1ZobL6g6AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Abort clocksource change in case of failure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-4-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-4-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928841.1442.7815317996708852437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1f7226b1e70a0e2ca3b305808cc7f1ae3acbd127
Gitweb:        https://git.kernel.org/tip/1f7226b1e70a0e2ca3b305808cc7f1ae3acbd127
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:13 +02:00

timekeeping: Abort clocksource change in case of failure

There is no point to go through a full timekeeping update when acquiring a
module reference or enabling the new clocksource fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-4-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 14aaa44..a9550f6 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1608,33 +1608,29 @@ static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
 static int change_clocksource(void *data)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	struct clocksource *new, *old = NULL;
+	struct clocksource *new = data, *old = NULL;
 	unsigned long flags;
-	bool change = false;
-
-	new = (struct clocksource *) data;
 
 	/*
-	 * If the cs is in module, get a module reference. Succeeds
-	 * for built-in code (owner == NULL) as well.
+	 * If the clocksource is in a module, get a module reference.
+	 * Succeeds for built-in code (owner == NULL) as well. Abort if the
+	 * reference can't be acquired.
 	 */
-	if (try_module_get(new->owner)) {
-		if (!new->enable || new->enable(new) == 0)
-			change = true;
-		else
-			module_put(new->owner);
+	if (!try_module_get(new->owner))
+		return 0;
+
+	/* Abort if the device can't be enabled */
+	if (new->enable && new->enable(new) != 0) {
+		module_put(new->owner);
+		return 0;
 	}
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
-
-	if (change) {
-		old = tk->tkr_mono.clock;
-		tk_setup_internals(tk, new);
-	}
-
+	old = tk->tkr_mono.clock;
+	tk_setup_internals(tk, new);
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
@@ -1643,7 +1639,6 @@ static int change_clocksource(void *data)
 	if (old) {
 		if (old->disable)
 			old->disable(old);
-
 		module_put(old->owner);
 	}
 

