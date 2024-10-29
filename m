Return-Path: <linux-tip-commits+bounces-2629-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621179B449B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 09:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852DB1C221CC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC2204019;
	Tue, 29 Oct 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G/L49Zx6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WNkistG1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7E2038DD;
	Tue, 29 Oct 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191526; cv=none; b=H6SvSSuMenSOq0tG/d6XpZWtBBapF9oCeXvgiIgjOf+SFxFpw6wObxJU0smdHs694LXG/EBbhtv6gDb/BgW5O76Sgq7UowAIyzSK/9swZaCe0jhjdY6o1iYnEuOx2YQ61PfU7WcyRVPWrcRE/1IY6x80j3PFeR+klsOAWZURv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191526; c=relaxed/simple;
	bh=UK+zTtEU2dt3xAHeY6d5tB8jDGnNv2ln7WHDMf2H5gc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=D8FE/ztxyOXWI7FzUN8Y9rRAguU4BlQtIp9O81O72F/ONLLzq12Qhch9qmm36q/t3lTE/+UgAzxmjzKMq6A75SNauQTPUBHQWTPj8SAD4ipq/t+TMa72UbEVFygsMhnA2VMD9qTc9YLeRlynFnSeenfdZWpnwxML35kE5JmC8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G/L49Zx6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WNkistG1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 08:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730191522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1xtuR9NejDhRa0mAcBPDV2F1LIDchpXAZhpwx7VG1ek=;
	b=G/L49Zx6XiEV0gVZWPpoCvXLbpMtNLm10Z4HLYLceSbEadbOyIhddU1R3W2ZmkqAJE80ui
	BV7DLxoB4ZZceKqwwMwQlI5IKQC36xQJq7I3zTcJVrj0BRCDK0RoEGxSyt2evs7JUnBeo9
	rgMpwfLi7QymQUrHgVarsi2brn/c9HIoTSueHAO8s6uYoYZe+AwGlPpPKwehlxKp7yDH+J
	74FKR0UQUuFUVAIAWAC+yu3maGTWlJUOGgdzrjnrcF6lwSj/qmbaZ1C/tSSvy+hYnBAhcP
	EykIsmY6xUBokPNdgQGl27WefGoYW7oagwbdxjSFN5aflA84g3stjvzDGTZ3qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730191522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1xtuR9NejDhRa0mAcBPDV2F1LIDchpXAZhpwx7VG1ek=;
	b=WNkistG1l4NvYAISFq5KmJ1c8uR9f0/cSXggHWnxgYX5ZAhufnZl+rCwFA5bDEY8dtgVLX
	OuzfFM01XSkmtzAg==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173019152148.1442.15715631718621389845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4d5b2b89b90da486be0f393a1e86232d14228091
Gitweb:        https://git.kernel.org/tip/4d5b2b89b90da486be0f393a1e86232d14228091
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 09:39:06 +01:00

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

