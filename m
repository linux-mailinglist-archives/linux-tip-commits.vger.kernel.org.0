Return-Path: <linux-tip-commits+bounces-2798-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65719BFBA1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB24283499
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835F1991CD;
	Thu,  7 Nov 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cn2tu0E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsMrj076"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B33195FD1;
	Thu,  7 Nov 2024 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943108; cv=none; b=BqPMgz6uFKOJPPbKyZRt5mU346sEJFKy6hyHNl+h1QVBXAr49ZNpJKFWYB8L+ZbcStZF7RrKJO24H/g/WvEarpRe75Vc1AF2pGd3hEkQQL7i7o3zswrlZpD+OhEWPxrga+Pkg8q5r6YCnJ+3PqLAIIdCmVhhZMGeKc5M38m6Qbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943108; c=relaxed/simple;
	bh=7PiFOuwQqalbriufdErP3RIJB9kULQFsqKErv5VwIts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J30+JFL1YNvS0qovAPx12trfuSOZd2qpqhHNDixCycG3XCfHnZLJ8YXAkP8OhOSt/RUAqr1SCY/06G4psR0hzwiZJ9yR26RPX6BNDyiZtxgYvo8at64QtcqSGRWFs1FMtSI/1YhzsA6gvw1tVID4lmUHiVMMr4A/BG2clke1sM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2cn2tu0E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsMrj076; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gL65KiPGHmFdxlUqqKIGhLHaGu8WxzRqgeOXpAnTT7A=;
	b=2cn2tu0E4rl1qzi3GsSzTLfqNxrcjTF2F3KLsu5n5GgSn08NddfxxvTUs/SJ2nSOBTRkma
	fn8R9tPd6zN96nPrvxHwGKwk9SIHA9MFlSLfA42WsoHDod5HJdphOh9KOME8+ETSGgtg9K
	wama1dgW7iGIXwOoLQIdHk6YYve2HKdOzo1hD7UNJYfGxTPKYaIVU1bTrCoa0SK1CuENk9
	lo//y7RzTuKcCNbNJyGpOvuJNmeFjJuHii0UPGo+v4IIBSCI7df9r9TL5KHFrtIeeSfVJ0
	aIak5tqjqyAKbruqRshUZp34iNkYR4pCKpM+smfYY6CR9XTZp6RJutc3MtAtCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gL65KiPGHmFdxlUqqKIGhLHaGu8WxzRqgeOXpAnTT7A=;
	b=SsMrj076lCjqkyzZNyo0YebjwL9dBg0DIfnG8NJ0rv15trGDynQId0GaPZ2aOTHetVdFKc
	drQGHlLz8gtdmqCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Correctly update timer status in
 posix_cpu_timer_del()
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064212.974053438@linutronix.de>
References: <20241105064212.974053438@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094310370.32228.9829878952290850699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     15cbfb92efee5c7f09e531a331e19759dbe0ac3c
Gitweb:        https://git.kernel.org/tip/15cbfb92efee5c7f09e531a331e19759dbe0ac3c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:43 +01:00

posix-cpu-timers: Correctly update timer status in posix_cpu_timer_del()

If posix_cpu_timer_del() exits early due to task not found or sighand
invalid, it fails to clear the state of the timer. That's harmless but
inconsistent.

These early exits are accounted as successful delete. Move the update of
the timer state into the success return path, so all "successful" deletions
are handled.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241105064212.974053438@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 12f828d..5f444e3 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -493,20 +493,20 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		 */
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
-		if (timer->it.cpu.firing) {
+		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
-		} else {
+		else
 			disarm_timer(timer, p);
-			timer->it_status = POSIX_TIMER_DISARMED;
-		}
 		unlock_task_sighand(p, &flags);
 	}
 
 out:
 	rcu_read_unlock();
-	if (!ret)
-		put_pid(ctmr->pid);
 
+	if (!ret) {
+		put_pid(ctmr->pid);
+		timer->it_status = POSIX_TIMER_DISARMED;
+	}
 	return ret;
 }
 

