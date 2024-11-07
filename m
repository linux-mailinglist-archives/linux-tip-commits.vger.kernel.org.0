Return-Path: <linux-tip-commits+bounces-2796-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D847C9BFB9B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680191F22A8A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C3194C92;
	Thu,  7 Nov 2024 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ujocd8rc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/FsS6AG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D38192D86;
	Thu,  7 Nov 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943105; cv=none; b=pomHahmAUxV9xL6msjANOB/OALia7FDtY6T40uOYA7Ge62W2aCjJsXOpCRQNk7y6gxfX+9auvUOeNLUHuZoOSNS1HhTIqOMPQm9a1grdy7KCwMsf6pdN2bhX6Rkdpw23mH4ra7bqNjHK/hzK+YZLkmtMyVgAWcuKVwnO4vXqG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943105; c=relaxed/simple;
	bh=Wima3fuorNh9PU6RP6c7BFzRv7IKTIFnkqIOxcPRXl8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PwQUmGMOEDc4p4mJxbuBLMJP5/hS9xLo3FICh4VRcO/Tg26BgyB5FEqSKjqR79b/ry8VX4q52rEk3hQ/lFSExcDwFeZfWuBhUF2issR/0lKhTiILYV0+rsK6C3gn9c134z4n1XLi7X19gH1rJr1nERFL1kMDi2FNUhGzS7S/hoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ujocd8rc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/FsS6AG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63BIdjqSauJDqwJJAzTlTti2CNt4ZNHxvKNBhZkDnZ4=;
	b=ujocd8rc+Cx1xwC+C6TBIP5keGHbpbWKNWOLDIq6AgJ6FOssIe4G979cqq9XuVXZfm5Qrp
	SWlPivySEqqIMxVTYVNdrR8DVv1kJLuraB/s5YPFiPAwVl4XqehpFM2PD5Cy+ER1IhRGQH
	/SBB8sxr5q8c742o1YmzAzFvMJLJ1pdGRgxk5uWxVjcaMkze5rqqtHzxlTYI9KXS/uGTBZ
	HBSp+o/EbKNlUjKHkDclvVNWYWWAnWc/fIpBtoGcrLyhohefGs+dzf79NuHi0RWF6+nBsA
	g924ok6EmlBEkiYm4OjFqGjO7/9/cQlol6vDwvFzdPoRkBuEWkF14zvWsKYvdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63BIdjqSauJDqwJJAzTlTti2CNt4ZNHxvKNBhZkDnZ4=;
	b=m/FsS6AGqEi3S6Sn+Vlwqn7XCpu8e7yVV6lRDRcvGbHjBo6+awxQPrAaM4EBNqoTO2x9ZI
	fdMTleBpJI0G9RBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Cleanup the firing logic
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.172848618@linutronix.de>
References: <20241105064213.172848618@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094310153.32228.16642720649384404193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bf635681c906ad056d1fda325de8d1c12c9f8201
Gitweb:        https://git.kernel.org/tip/bf635681c906ad056d1fda325de8d1c12c9f8201
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:43 +01:00

posix-cpu-timers: Cleanup the firing logic

The firing flag of a posix CPU timer is tristate:

  0: when the timer is not about to deliver a signal

  1: when the timer has expired, but the signal has not been delivered yet

 -1: when the timer was queued for signal delivery and a rearm operation
     raced against it and supressed the signal delivery.

This is a pointless exercise as this can be simply expressed with a
boolean. Only if set, the signal is delivered. This makes delete and rearm
consistent with the rest of the posix timers.

Convert firing to bool and fixup the usage sites accordingly and add
comments why the timer cannot be dequeued right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241105064213.172848618@linutronix.de

---
 include/linux/posix-timers.h   |  2 +-
 kernel/time/posix-cpu-timers.c | 34 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 8c6d974..b1de217 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -49,7 +49,7 @@ struct cpu_timer {
 	struct timerqueue_head		*head;
 	struct pid			*pid;
 	struct list_head		elist;
-	int				firing;
+	bool				firing;
 	struct task_struct __rcu	*handling;
 };
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 4305c00..a282a3c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -493,10 +493,18 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		 */
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
-		if (timer->it.cpu.firing)
+		if (timer->it.cpu.firing) {
+			/*
+			 * Prevent signal delivery. The timer cannot be dequeued
+			 * because it is on the firing list which is not protected
+			 * by sighand->lock. The delivery path is waiting for
+			 * the timer lock. So go back, unlock and retry.
+			 */
+			timer->it.cpu.firing = false;
 			ret = TIMER_RETRY;
-		else
+		} else {
 			disarm_timer(timer, p);
+		}
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -668,7 +676,13 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	old_expires = cpu_timer_getexpires(ctmr);
 
 	if (unlikely(timer->it.cpu.firing)) {
-		timer->it.cpu.firing = -1;
+		/*
+		 * Prevent signal delivery. The timer cannot be dequeued
+		 * because it is on the firing list which is not protected
+		 * by sighand->lock. The delivery path is waiting for
+		 * the timer lock. So go back, unlock and retry.
+		 */
+		timer->it.cpu.firing = false;
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
@@ -809,7 +823,7 @@ static u64 collect_timerqueue(struct timerqueue_head *head,
 		if (++i == MAX_COLLECTED || now < expires)
 			return expires;
 
-		ctmr->firing = 1;
+		ctmr->firing = true;
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
@@ -1364,7 +1378,7 @@ static void handle_posix_cpu_timers(struct task_struct *tsk)
 	 * timer call will interfere.
 	 */
 	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
-		int cpu_firing;
+		bool cpu_firing;
 
 		/*
 		 * spin_lock() is sufficient here even independent of the
@@ -1376,13 +1390,13 @@ static void handle_posix_cpu_timers(struct task_struct *tsk)
 		spin_lock(&timer->it_lock);
 		list_del_init(&timer->it.cpu.elist);
 		cpu_firing = timer->it.cpu.firing;
-		timer->it.cpu.firing = 0;
+		timer->it.cpu.firing = false;
 		/*
-		 * The firing flag is -1 if we collided with a reset
-		 * of the timer, which already reported this
-		 * almost-firing as an overrun.  So don't generate an event.
+		 * If the firing flag is cleared then this raced with a
+		 * timer rearm/delete operation. So don't generate an
+		 * event.
 		 */
-		if (likely(cpu_firing >= 0))
+		if (likely(cpu_firing))
 			cpu_timer_fire(timer);
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(timer->it.cpu.handling, NULL);

