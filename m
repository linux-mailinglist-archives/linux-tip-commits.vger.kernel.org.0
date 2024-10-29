Return-Path: <linux-tip-commits+bounces-2637-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D59B47F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27EF284FE7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429E205AD9;
	Tue, 29 Oct 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKW3n30o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UF1slmjA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCE204F80;
	Tue, 29 Oct 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200160; cv=none; b=m1l6jvo4TlB2k1WT4stjJQrAq4PDs/wxdLHp0pg+Z6Ta12JVvA7W4J1/cKAKbN0bkEcPOc9gWqBvmPvYCC5y0tJo/an0Tqtt02LrOA+rawS5hTs6iTM1pKiQ1ebfLr6x+Oa1dC6kvZN9JQLROcf+n96vuiaHJmZZELecuV47tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200160; c=relaxed/simple;
	bh=oX6hSllDbIPswBRGOGefL+ast7CZ4tbdN/ESFv75rR0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MQGbdRvrQbVR0USLdIHYRisYRTkFPvOst5ajDjPJBIaLon+C6uqqgOQ5VP6DE/fF6ghmzdAFVVgkYn7qz9wDv8ISu2iWf8O2u1XVJAxz7OrN4tta+1JTzhIiVqiZFaENn9cA2zVexpQWn3FQ0ALqXqFpz+mHaIH6tXGMmYi12NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKW3n30o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UF1slmjA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:09:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730200156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVXHOZCuzUBmA/E7JLoquk5D2UK826YkC+ocjVymdro=;
	b=bKW3n30oXMqaIdrp1lVEu44hEmsAlVvwS9bXXYzmBNsjagc4oWNO7vnz9dpWatjyMH57kh
	3Byg+9dt6d6uh/si0JbPX88g9ZUBjHUAj46a+gqlT/orVZye6719ClAfTjtAoHX3LS2KbJ
	55JM81GVS2FjSlkbpr5qCKcwkJl7a0GZnO24GPGRxyrBPF11s0oYNc2Pt6ndaIIyWpDJRo
	3n05sJ1z7tBy9U1AuAdYJGYJhKPNqq3YRQKHayEkdfDKfPYCvowqljtxMzrXjYhfl5rZhH
	RRiRKOM7IJUGlQqTIxUybLWxnDlvXumc/f2q5fe3Iw2FkjCj+lLWxP2KZXq7Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730200156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVXHOZCuzUBmA/E7JLoquk5D2UK826YkC+ocjVymdro=;
	b=UF1slmjAsV7kZhC7VXxf/ymcoZ2ml3Nza5SdzW+m3URmVhwqd3Prg/DrzBNiqNRpxW/gvT
	EowNm/DfZ8hPPgAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Drop signal if timer has been
 deleted or reprogrammed
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001083835.553646280@linutronix.de>
References: <20241001083835.553646280@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173020015593.1442.3368562536047604306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2860d4d315dc01f001dfd328adaf2ab440c47dd3
Gitweb:        https://git.kernel.org/tip/2860d4d315dc01f001dfd328adaf2ab440c47dd3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 11:43:19 +01:00

posix-timers: Drop signal if timer has been deleted or reprogrammed

No point in delivering a signal from the past. POSIX does not specify the
behaviour here:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which has
been disarmed.

Drop the signal as that is conistent and understandable behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241001083835.553646280@linutronix.de

---
 kernel/time/posix-timers.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd0b1df..22e1d6b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -250,14 +250,14 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 }
 
 /*
- * This function is called from the signal delivery code if
- * info::si_sys_private is not zero, which indicates that the timer has to
- * be rearmed. Restart the timer and update info::si_overrun.
+ * This function is called from the signal delivery code. It decides
+ * whether the signal should be dropped and rearms interval timers.
  */
 bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
+	bool ret = false;
 
 	/*
 	 * Release siglock to ensure proper locking order versus
@@ -279,6 +279,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 
 		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
+	ret = true;
 
 	unlock_timer(timr, flags);
 out:
@@ -286,7 +287,7 @@ out:
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
-	return true;
+	return ret;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)

