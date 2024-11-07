Return-Path: <linux-tip-commits+bounces-2786-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9569BFB86
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B405283968
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836D82866;
	Thu,  7 Nov 2024 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4dBfsTWg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mIX/N8RC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621222338;
	Thu,  7 Nov 2024 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943098; cv=none; b=oFDAdHJ3akjumZGVVrjwSHhWAXSf9R4NIKNuJLNycLdCFj+ARNKg9EBWrUreGPAAuK+SCH5bJZJn9ZLzhr4u8CTej/qWGi4VswBFzxlPllbZjSYkoHm/euIG+1FWCAzlbXwO/Pn6dmu10O8E0/aZ0RsjQr2WWwRw/1uE3yR+5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943098; c=relaxed/simple;
	bh=pyEIP1ODe+GCxhdhbH8urfZhOdHfuXsV19CYWrO0vxA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K5nAzTHjr8QLnwoE9WP73+FLowRiuRD3uAT8p7/Am1PpZjsyRllmewQg1JfHh0Ji+gXuy0Dm3E0W/yLLHY2q9pTBFOko/fhowfjA3i5UZFE3P96kGRKFqCGmQGLojm8ACRymsEm83T0eht3z3/KvD67kYgpPtxn+ZGHUlR1j+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4dBfsTWg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mIX/N8RC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GII8GgbroQiPU5nYskLfK11MYWiLZcm0iMjQHpE0W8=;
	b=4dBfsTWghkokyA5gegq2FHHKWK65J2iv4/q9YgTDimKo+ZolndDkPnmM9He6NA2j2mqMcr
	CNXU4b9y7tl0KH5xz+XOB9Xw6X0GKaBwvIAjTFZYr51MZ5I5iVlwpjbMpKopPVY9Xmy4f3
	0Q79dnRyTFAFCDeal+mXbv8S/Dk+lj49Bf0Ndk3Q9a8Xm4KvGHjF6lbK96/l7DlUhuyYps
	VRK7NvMFQ+N676f11ozVdjQOImcnPggENuVEXatfbtcTRhhMph9cESDUYIJ4SFLep0JhT2
	fPchrJxqi2HLbTEiW0NhsgLx/dXcHlhQmh9W4tUVyXtYwr/fwAuuD+pRAUMmlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GII8GgbroQiPU5nYskLfK11MYWiLZcm0iMjQHpE0W8=;
	b=mIX/N8RCeSAe7vI7mGUztxVFV+wcnKsSbobM7Kc87OmJ+ymHfjy3ZMmi5Qnj0gxTXaRi0c
	zIPeV88G+WQLgdAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-timers: Move sequence logic into struct k_itimer
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.852619866@linutronix.de>
References: <20241105064213.852619866@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309430.32228.12715390263587027409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     647da5f709f112319c0d51e06f330d8afecb1940
Gitweb:        https://git.kernel.org/tip/647da5f709f112319c0d51e06f330d8afecb1940
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:45 +01:00

posix-timers: Move sequence logic into struct k_itimer

The posix timer signal handling uses siginfo::si_sys_private for handling
the sequence counter check. That indirection is not longer required and the
sequence count value at signal queueing time can be stored in struct
k_itimer itself.

This removes the requirement of treating siginfo::si_sys_private special as
it's now always zero as the kernel does not touch it anymore.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/all/20241105064213.852619866@linutronix.de

---
 include/linux/posix-timers.h       | 2 ++
 include/uapi/asm-generic/siginfo.h | 2 +-
 kernel/signal.c                    | 8 +++-----
 kernel/time/posix-timers.c         | 5 +----
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 28c0a30..49a8961 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -162,6 +162,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
  * @it_signal_seq:	Sequence count to control signal delivery
+ * @it_sigqueue_seq:	The sequence count at the point where the signal was queued
  * @it_sigev_notify:	The notify word of sigevent struct for signal delivery
  * @it_interval:	The interval for periodic timers
  * @it_signal:		Pointer to the creators signal struct
@@ -184,6 +185,7 @@ struct k_itimer {
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
+	unsigned int		it_sigqueue_seq;
 	int			it_sigev_notify;
 	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index b7bc545..5a1ca43 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -46,7 +46,7 @@ union __sifields {
 		__kernel_timer_t _tid;	/* timer id */
 		int _overrun;		/* overrun count */
 		sigval_t _sigval;	/* same as below */
-		int _sys_private;       /* not to be passed to user */
+		int _sys_private;       /* Not used by the kernel. Historic leftover. Always 0. */
 	} _timer;
 
 	/* POSIX.1b signals */
diff --git a/kernel/signal.c b/kernel/signal.c
index d267a2c..d2734dc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1976,12 +1976,10 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 		return -1;
 
 	/*
-	 * Update @q::info::si_sys_private for posix timer signals with
-	 * sighand locked to prevent a race against dequeue_signal() which
-	 * decides based on si_sys_private whether to invoke
-	 * posixtimer_rearm() or not.
+	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
+	 * locked to prevent a race against dequeue_signal().
 	 */
-	q->info.si_sys_private = tmr->it_signal_seq;
+	tmr->it_sigqueue_seq = tmr->it_signal_seq;
 
 	ret = 1; /* the signal is ignored */
 	if (!prepare_signal(sig, t, false)) {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2e2c0ed..f20c06d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -259,7 +259,7 @@ static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct k_it
 	 * since the signal was queued. In either case, don't rearm and
 	 * drop the signal.
 	 */
-	if (timr->it_signal_seq != info->si_sys_private || WARN_ON_ONCE(!timr->it_signal))
+	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->it_signal))
 		return false;
 
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
@@ -297,9 +297,6 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *tim
 	posixtimer_putref(timr);
 
 	spin_lock(&current->sighand->siglock);
-
-	/* Don't expose the si_sys_private value to userspace */
-	info->si_sys_private = 0;
 	return ret;
 }
 

