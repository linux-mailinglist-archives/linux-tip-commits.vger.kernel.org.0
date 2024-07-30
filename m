Return-Path: <linux-tip-commits+bounces-1873-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E972941C76
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF531C23598
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1918E037;
	Tue, 30 Jul 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJ4jcxGm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9seK1xdv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824D18C907;
	Tue, 30 Jul 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359194; cv=none; b=kdxKkO9UwaMpWlO5GEni37wEp0AmNbGFd6GynFO8PIc4GGT+omJqNjDZDKKybLdGP3e+r8lh7C2iXC2Gpf50t+OodDn7f/4zHC7gLgN6WRUtEyJVo5zSOk2wbCp/QXlhVgSMuPjOOEJRvPxLEGJlt/rwF0ilU2gZrZAzDACggL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359194; c=relaxed/simple;
	bh=GMQxXL3AVxG2Oph3kHIzPn3gyMUQaekb4MWBGoXx5pI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PdbvLfXzazf6h6I5S/prEbDzKUmwf+zN/XEqWzCAHM7zQni84gSQblzAneYsnhixCy2rGPNgLFCmQdK4vW/fpY3RgsHifNwzEvt0KX8K3w3DyNOAFeJ/uWkJTYNtxcsOr6xprviXtq13wdrEn4P1+4vFW5VPNK2f6rE40HUJpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJ4jcxGm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9seK1xdv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=L/vjPqj/Dmed/+7rD/kONQ1U+Dw/FEAQLsDtLq9X0qM=;
	b=iJ4jcxGm2cLP15vYRVlC7FSOSc/dxpcbpe6VcQ8z5zAU9bFQu5FGMsC1uSk8+5wEBsrz9z
	Vbx1yCv4Jr/5z/HSKApJRyJW5GUg1MvCogQip9UQxZJx2kRBMUe4SUHOtkJz9VHZ+tJMWM
	5UScFQtvtcTEXlQlupvUS3SFHBh6UUeE7o1sOCgbD3xNTYwNESdqAJ/MFFM18PArjQHxf5
	Lk7lwuz6oLjZ0p667/hv/BbD0JY5GK5x1oeq1lpHig+TrgocIQgndgHiqy2V1DfQtSBSZd
	nXt9Mhq1wSOuxYlGI35XUm5gPEYAzw9Pf0xNzwGw+/+9CFXlJtxhWHiLPRt2Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=L/vjPqj/Dmed/+7rD/kONQ1U+Dw/FEAQLsDtLq9X0qM=;
	b=9seK1xdvI+ecDlIERgWKMZi4IGzrLW7yFQdF7vkojEwcUFg0o+/n8FeeXOXEnpXLZy1n1T
	2n0cCwlBjAwerRAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Simplify posix_cpu_timer_set()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919023.2215.13850125037879458535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c20b99e3243f9e72b6fa0e260766adcba115f25b
Gitweb:        https://git.kernel.org/tip/c20b99e3243f9e72b6fa0e260766adcba115f25b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:25 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Simplify posix_cpu_timer_set()

Avoid the late sighand lock/unlock dance when a timer is not armed to
enforce reevaluation of the timer base so that the process wide CPU timer
sampling can be disabled.

Do it right at the point where the arming decision is made which already
has sighand locked.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 44 ++++++++++++---------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index eb28150..c6fe017 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -705,10 +705,16 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	/*
 	 * Arm the timer if it is not disabled, the new expiry value has
 	 * not yet expired and the timer requires signal delivery.
-	 * SIGEV_NONE timers are never armed.
+	 * SIGEV_NONE timers are never armed. In case the timer is not
+	 * armed, enforce the reevaluation of the timer base so that the
+	 * process wide cputime counter can be disabled eventually.
 	 */
-	if (!sigev_none && new_expires && now < new_expires)
-		arm_timer(timer, p);
+	if (likely(!sigev_none)) {
+		if (new_expires && now < new_expires)
+			arm_timer(timer, p);
+		else
+			trigger_base_recalc_expires(timer, p);
+	}
 
 	unlock_task_sighand(p, &flags);
 	/*
@@ -727,30 +733,14 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (!sigev_none && now >= new_expires) {
-		if (new_expires != 0) {
-			/*
-			 * The designated time already passed, so we notify
-			 * immediately, even if the thread never runs to
-			 * accumulate more time on this clock.
-			 */
-			cpu_timer_fire(timer);
-		}
-
-		/*
-		 * Make sure we don't keep around the process wide cputime
-		 * counter or the tick dependency if they are not necessary.
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			goto out;
-
-		if (!cpu_timer_queued(ctmr))
-			trigger_base_recalc_expires(timer, p);
-
-		unlock_task_sighand(p, &flags);
-	}
- out:
+	/*
+	 * If the new expiry time was already in the past the timer was not
+	 * queued. Fire it immediately even if the thread never runs to
+	 * accumulate more time on this clock.
+	 */
+	if (!sigev_none && new_expires && now >= new_expires)
+		cpu_timer_fire(timer);
+out:
 	rcu_read_unlock();
 	if (old)
 		old->it_interval = ns_to_timespec64(old_incr);

