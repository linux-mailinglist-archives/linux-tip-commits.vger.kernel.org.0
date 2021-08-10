Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE023E7BDA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbhHJPN7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 11:13:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44000 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242327AbhHJPN6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 11:13:58 -0400
Date:   Tue, 10 Aug 2021 15:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628608413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyUDIpCTTQ/pu1Ud7VhDIZCEVOwLiG4DUhibXMR4XEk=;
        b=1TMpji/1YOjkLakwQZnXD8Tbb01uNEu3cdXadbVKFUoC6FKr8k6lxAESnTh9fNxNps1DUt
        xaFlPwQknaF6png9+mez4b/aoAWpXRlMurwGWYLDdgaFrDqY66SAewS+q4sh4PzwVx8GDV
        kzSTln5QEpDXK9HP3AZi+X6sNTjI7i2VjFmPS/iJrpby4wqNpT00y++vGi+Ulz7ODDF+F0
        T8rahWV7IoRiwXITHa2iQzUMgbzCiw7zG6AY4LDj6FjrP7KX7081bU6LvM8CQNhXkSpbbX
        vLExc1Uu8izNrAq43C/t7xfQEV6gcE40Dx8IPbMS1/aUsGPqXvk6SduEo2pz4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628608413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyUDIpCTTQ/pu1Ud7VhDIZCEVOwLiG4DUhibXMR4XEk=;
        b=RTm7NzRyDbZcATrb5rPEjv6JvhSQy4yGUcKaXXdpUkKJwm+bGW35UaMPFMojqr9iEDpkek
        znfxJzKsIsT+02Ag==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Consolidate timer base accessor
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210726125513.271824-6-frederic@kernel.org>
References: <20210726125513.271824-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162860841273.395.2362644052634240500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5c8f23e6b73c13d9f7b52614783dcb9169883296
Gitweb:        https://git.kernel.org/tip/5c8f23e6b73c13d9f7b52614783dcb9169883296
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 14:55:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:09:59 +02:00

posix-cpu-timers: Consolidate timer base accessor

Remove the ad-hoc timer base accessors and provide a consolidated one.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210726125513.271824-6-frederic@kernel.org

---
 kernel/time/posix-cpu-timers.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 4fbbbc8..0d91811 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -407,6 +407,17 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	return 0;
 }
 
+static struct posix_cputimer_base *timer_base(struct k_itimer *timer,
+					      struct task_struct *tsk)
+{
+	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		return tsk->posix_cputimers.bases + clkidx;
+	else
+		return tsk->signal->posix_cputimers.bases + clkidx;
+}
+
 /*
  * Dequeue the timer and reset the base if it was its earliest expiration.
  * It makes sure the next tick recalculates the base next expiration so we
@@ -421,18 +432,11 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
-	int clkidx;
 
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
-	clkidx = CPUCLOCK_WHICH(timer->it_clock);
-
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		base = p->posix_cputimers.bases + clkidx;
-	else
-		base = p->signal->posix_cputimers.bases + clkidx;
-
+	base = timer_base(timer, p);
 	if (cpu_timer_getexpires(ctmr) == base->nextevt)
 		base->nextevt = 0;
 }
@@ -531,15 +535,9 @@ void posix_cpu_timers_exit_group(struct task_struct *tsk)
  */
 static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 {
-	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+	struct posix_cputimer_base *base = timer_base(timer, p);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
-	struct posix_cputimer_base *base;
-
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		base = p->posix_cputimers.bases + clkidx;
-	else
-		base = p->signal->posix_cputimers.bases + clkidx;
 
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
