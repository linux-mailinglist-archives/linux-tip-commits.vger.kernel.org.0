Return-Path: <linux-tip-commits+bounces-1869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B28941C6C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120AD283B67
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A3818B492;
	Tue, 30 Jul 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMcSSQH1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5TUU9NE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714A8189522;
	Tue, 30 Jul 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359192; cv=none; b=sGebQLwPpMzzo6GLCLO0yzcO6gTQ4DVcVgtzcmKCDMw2HAYh9uwpzD7WTu5TQ77bEreG62SO5VSabbVwJootHETiKNgcjtoztmOQeT05brLc1Tdg9rTX8t2drYESKVcF9vfdjDkxoZSK11CbtKU9k3OPvFmKUVIuJe6eHm/bI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359192; c=relaxed/simple;
	bh=xuDLP5hW/wLoNUKroPvlcmroxZKv+ADzHVamNhMBoRQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=UrlzHSEO0zYdSsc555bxSZih0+emnKo6Esg5Wl0395gSNaHgKvq8JcLukJiCaUSgFb1Udu68r+FjOwkSRjXiptoQb/KW9RVNcCr3ksQ9Tjo9XyxsEHT0u+w3uLceYgq6LLca7CBqVCfAvkFiTacRY16z8fd6vtuu+mDGl//310U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMcSSQH1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5TUU9NE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IXBzNr+YGwTC39gg8LMLwZonneNLkjkOsllEBDp82jE=;
	b=CMcSSQH1dCY7ikXhLi+plW1D+3S4r6mr6Im08VH3s5VZckfqorEcfiD51GSqcxQ68g476R
	gDDOqGa80WRTxUrDYVMlUMkwXZ5cC3kebh7xk7FLmNnjcORXyvYxlBzMMDHbaJME1/6boO
	+SlnuhhDPoGBsCkrl2XtlVg8DomC1TzyRX/kmDX/YBV+VcArj2ethXotXSSE6sneJXhRID
	zg42WFql3FjSCcWabQ4+Nw1/RLkAVCpPJDxjDp6Y41SnCIr1S+F/KR/RCoJaAu7yictK2f
	cb+Mn14TBWA6bF9PiGyJwaphoHxVjsQEhM81fueB3V0tic7wJDsCqvQDZa1CHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IXBzNr+YGwTC39gg8LMLwZonneNLkjkOsllEBDp82jE=;
	b=C5TUU9NEYVHVgjBUTGjhcBpazFbwSTsaxey4dGyKL8CmJEzKuZMRt5i1hotESrc4pamqSC
	A0l6WE2c/Az7P4DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Consolidate timer setup
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235918845.2215.1121030540824757359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     20f13385b5836d00d64698748565fc6d3ce9b419
Gitweb:        https://git.kernel.org/tip/20f13385b5836d00d64698748565fc6d3ce9b419
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:30 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

posix-timers: Consolidate timer setup

hrtimer based and CPU timers have their own way to install the new interval
and to reset overrun and signal handling related data.

Create a helper function and do the same operation for all variants.

This also makes the handling of the interval consistent. It's only stored
when the timer is actually armed, i.e. timer->it_value != 0. Before that it
was stored unconditionally for posix CPU timers and conditionally for the
other posix timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 15 +--------------
 kernel/time/posix-timers.c     | 25 +++++++++++++++++++------
 kernel/time/posix-timers.h     |  1 +
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 4107977..43cf3f6 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -714,21 +714,8 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	}
 
 	unlock_task_sighand(p, &flags);
-	/*
-	 * Install the new reload setting, and
-	 * set up the signal and overrun bookkeeping.
-	 */
-	timer->it_interval = timespec64_to_ktime(new->it_interval);
 
-	/*
-	 * This acts as a modification timestamp for the timer,
-	 * so any automatic reload attempt will punt on seeing
-	 * that we have reset the timer manually.
-	 */
-	timer->it_requeue_pending = (timer->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timer->it_overrun_last = 0;
-	timer->it_overrun = -1;
+	posix_timer_set_common(timer, new);
 
 	/*
 	 * If the new expiry time was already in the past the timer was not
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fa75e94..679be90 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -856,6 +856,23 @@ static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 	return lock_timer(timer_id, flags);
 }
 
+/*
+ * Set up the new interval and reset the signal delivery data
+ */
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_setting)
+{
+	if (new_setting->it_value.tv_sec || new_setting->it_value.tv_nsec)
+		timer->it_interval = timespec64_to_ktime(new_setting->it_interval);
+	else
+		timer->it_interval = 0;
+
+	/* Prevent reloading in case there is a signal pending */
+	timer->it_requeue_pending = (timer->it_requeue_pending + 2) & ~REQUEUE_PENDING;
+	/* Reset overrun accounting */
+	timer->it_overrun_last = 0;
+	timer->it_overrun = -1LL;
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -878,16 +895,12 @@ int common_timer_set(struct k_itimer *timr, int flags,
 		return TIMER_RETRY;
 
 	timr->it_active = 0;
-	timr->it_requeue_pending = (timr->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timr->it_overrun_last = 0;
-	timr->it_overrun = -1LL;
+	posix_timer_set_common(timr, new_setting);
 
-	/* Switch off the timer when it_value is zero */
+	/* Keep timer disarmed when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
 		return 0;
 
-	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
 	if (flags & TIMER_ABSTIME)
 		expires = timens_ktime_to_host(timr->it_clock, expires);
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index f32a2eb..630a77b 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -42,4 +42,5 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
 		     struct itimerspec64 *old_setting);
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_setting);
 int common_timer_del(struct k_itimer *timer);

