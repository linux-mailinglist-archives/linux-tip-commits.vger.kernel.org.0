Return-Path: <linux-tip-commits+bounces-2791-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2579BFB8F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0121C20B80
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A00191496;
	Thu,  7 Nov 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/2NAEZU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0Cu4VVm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427CC186E2D;
	Thu,  7 Nov 2024 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943102; cv=none; b=klzgFl3RC0jMyB2JB8GfTqfjhsQqpVVMhuyvRG56c5UcmdSaOB3STPqDel1fGli6pWfKdc9+8QYZyA3hXWUiLZaQIYbKxySBqdE0NCcFYmR9saVSkiiSRP7IPftgXXY/hTgmH8tLHLe0/b3BvqCeeVt8F7rt5M+BnvZN5ahTc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943102; c=relaxed/simple;
	bh=2VqDLajh2LVp2ON0FCQjtEEXVIOb4KyvuGnjIuUoZtE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ospCBZpNzFEc+ev/A9C1MBhD6wjkM9jI7Jht5iPL4unxkQZLZt5ku3XR1iAmucQT9QcAglqWoEeUrbQ2pKkJ9PahPYEdl+Lln7Icdc3cTzpmthf5xd9Yqh69HCxLm8B1kgt01DmamYR0M4QPS/e43eqAborxAcekt1TIhjGO4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/2NAEZU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0Cu4VVm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qSAG2MqrTEYjM+jlrwp0du2hguCjJ74Epx8Cz3XGb0=;
	b=C/2NAEZUKxYAvGmanIMUtg3frWjG5er+TSSfaUl6ZdXiHsA2q22VbM0AoSMtH4yXGMt4cU
	iUY8qWlG1EcACkDmh4blrMg2Ul0sGsjctT1cRsLJIHtk54/t5MhztiwNXreKQXLO2joV1H
	3MUZmoPdvXmisN20Q75K998XaP6tbWeLp/x2d90sCUQZBHjmSBWPBWXmRIyT/RSABKr5pS
	8ew71cXqzdYvSepRDFxWtYyzI10CQllRk4lqe4FJ3RFeAbO7h5OOR2GCSSoamNtmFB9m6Y
	7br3orql2fKprtLVBzQ125SFwcxVafIJPAH7F5gQlnG8y4Ju7ZakreAdqS8yOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qSAG2MqrTEYjM+jlrwp0du2hguCjJ74Epx8Cz3XGb0=;
	b=J0Cu4VVmjgMo2E85SnfQh+QvKYLgJFUioU1GyE7/KM5G3wHfr0gs5GKSWvmiQsKkHFoTlB
	WOZGCe3AbyKC5zCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Store PID type in the timer
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.519086500@linutronix.de>
References: <20241105064213.519086500@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309803.32228.245418747883315389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ef1c5bcd6daa674392bdf89b8ae889aafd73f956
Gitweb:        https://git.kernel.org/tip/ef1c5bcd6daa674392bdf89b8ae889aafd73f956
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:44 +01:00

posix-timers: Store PID type in the timer

instead of re-evaluating the signal delivery mode everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.519086500@linutronix.de

---
 include/linux/posix-timers.h |  2 ++
 kernel/time/posix-timers.c   |  9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 200098d..9471765 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -5,6 +5,7 @@
 #include <linux/alarmtimer.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/pid.h>
 #include <linux/posix-timers_types.h>
 #include <linux/rcuref.h>
 #include <linux/spinlock.h>
@@ -180,6 +181,7 @@ struct k_itimer {
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
 	union {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 53bd3c4..f18d64c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -298,7 +298,6 @@ out:
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	enum pid_type type;
 	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
@@ -308,8 +307,7 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 
 	timr->it_status = state;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -496,6 +494,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
+	if (new_timer->it_sigev_notify & SIGEV_THREAD_ID)
+		new_timer->it_pid_type = PIDTYPE_PID;
+	else
+		new_timer->it_pid_type = PIDTYPE_TGID;
+
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 

