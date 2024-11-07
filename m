Return-Path: <linux-tip-commits+bounces-2785-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09BF9BFB83
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CD61C212D2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D739AEB;
	Thu,  7 Nov 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2pL1ksFa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QyOYlD+L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB279179BF;
	Thu,  7 Nov 2024 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943097; cv=none; b=dl0im/GYrqWcHaOdl9QgtLpJ3TLA6Zm2W1be1VfbohuCKH+gCNl02QiIFMUZABHxUGxi5BDfoEne/PVX9obhFliXKdLv7pBvbni+r3XkQ1mQBmyCyN0Kbcbz9TkyCYGjAePpKZyG73xzAtG2RPttw5wwifAeCDbV+mWRmd9qDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943097; c=relaxed/simple;
	bh=zxdIx3uGOQd70wNHo4gXsaqcIcwJx/x1tmFOg4Fh9wc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lBfcdH5l9Y0fLWK5Gzdnnd7QO0eLY7Z7sG8oOXpLzE92amfpHHjOPHujQ47dCcwSTXUpHuLtha60b0igqnJvyLYA3pDqDGgFdZ8eJsWw0PBIxGRdQRfhCNFl8mCg7/KR+bARdoJpzGVcdXHgUyMZ0IECPdGKbMs4ucchVlLsY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2pL1ksFa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QyOYlD+L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFn7dvDKQr+z9vzYz/pa4RfwVrypMkf6aN6JMEoawVQ=;
	b=2pL1ksFaOT3rKilonbWTJwRR9v6FdUS5RREGizPVqxG8X/5oMhDRrJ8pEg6FU6CCi5mund
	RvVwilzY06yLPPq+u4Ss5uvc3O3/Al24Vxla9tGA/EAbVq3pjuyriExFcvvGiyAWsVzk4c
	aZfqlwdRO13fXxfd7K44VNbpv4B5TshKKs3rRgGz0RFkUK7qbSnrKtYPoztiMU/db8oNBc
	jqdu8lYsTdZrmZvFCHW/Yle9Sk6ASCeE6KxHvn5QiuOdpNwv+/sIrQBwjK4fNxZNr17U9R
	XnE7gw7qLBn0T+8BF2N2MvPOzViKuObqfyeGny7iWssxcHfhvhFL+7yupOMOIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFn7dvDKQr+z9vzYz/pa4RfwVrypMkf6aN6JMEoawVQ=;
	b=QyOYlD+Lcumjzbss45b0RcGU/U+Mw9rEroatE8d1xj8oR6fNPa3bVjQeHxy4ARe+W1Xhyv
	6GH7AUBrSEHEv9Dw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Provide ignored_posix_timers list
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.920101900@linutronix.de>
References: <20241105064213.920101900@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309361.32228.16885228457351234466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     69f032c92cf883ea74a4b69ba3d91317aa6f174e
Gitweb:        https://git.kernel.org/tip/69f032c92cf883ea74a4b69ba3d91317aa6f174e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:45 +01:00

signal: Provide ignored_posix_timers list

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a list to task::signal.

This list will be used to queue posix timers so their signal can be
requeued when SIG_IGN is lifted later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.920101900@linutronix.de


---
 include/linux/sched/signal.h | 1 +
 init/init_task.c             | 5 +++--
 kernel/fork.c                | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 02972fd..d5d03d9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -138,6 +138,7 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
 	struct hlist_head	posix_timers;
+	struct hlist_head	ignored_posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
diff --git a/init/init_task.c b/init/init_task.c
index 136a823..e557f62 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,8 +30,9 @@ static struct signal_struct init_signals = {
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers	= HLIST_HEAD_INIT,
-	.cputimer	= {
+	.posix_timers		= HLIST_HEAD_INIT,
+	.ignored_posix_timers	= HLIST_HEAD_INIT,
+	.cputimer		= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 60c0b48..c2bd836 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1864,6 +1864,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif

