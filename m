Return-Path: <linux-tip-commits+bounces-2792-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F29BFB90
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3B91F22808
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E53191F98;
	Thu,  7 Nov 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OidZo8G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PL5noSJH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7712B63;
	Thu,  7 Nov 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943102; cv=none; b=UrltPhvGJTHdnZN7EPP3hTzOnRaDezIZs0EBvS6/YHNzlM0GJmeAvWR3NjdH67V7LCYHvHw+tw2kVuSpB8lpbgnOZhrHtvsiFNEYxZ+u/Izabn5RowAnXH7nnbkxbB5qK03TlZK/TaqzG5Kyc/cSsmck71y1ApWXxGZpoYuZ3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943102; c=relaxed/simple;
	bh=OQPRSeClxl5OeFsLX63WI1/HTgnVjCY74ZpaDhWzDWo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=knZOcb781BTFi1xg+VeFb86cevEvQPvl25JzKSrCjJxhWxCDbCpEjroNwVXDMeRJ5B9kqbUj/MMLrhCe5qgin4wmswCTruC06W0sYKCRrpunD6WNET6vxW6jOusOk7b82tlMLcPBbM2PqeQxeha6EeAtWY/IBtQKolvEJSXumxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OidZo8G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PL5noSJH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/bni+hzTgUNzLcD9bw2rk2/4vPMQPwkE+bV2rLzZnU=;
	b=4OidZo8Ge4kogr0qr5hfLj6nPMmUkFVFmnjQ/Ja7RwFxvtLjuwrF+gyoHQ0MvfXnXjiHoR
	6s2bodsmZBAaMs7wU5w5MOMCMjT1HiXeQOLrTGVzV1T52B4ohZQboKwy5yeNWRP1G2L9Hu
	qeCeCGTa/FaN3MjdbgUlbuLvc0RzbNRKjad/ifqOqzpAZ/5BjM6kVB1Ec91zKgik6OMKCA
	xnZ4bK2hF/DsJXv3+ifLrHp2QCdU/QTJHZ0+r/w9paCYFGRrBjLh5SDna8h+Z7d3By57+Y
	FuqfruOz74AECKenITIH7CxHSZyxyfZEIdl+qxM4E0xaD5L8jAyXoWRaws+j4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/bni+hzTgUNzLcD9bw2rk2/4vPMQPwkE+bV2rLzZnU=;
	b=PL5noSJHgPk4CmrR9AsF6NlqlKOxjJXmSvQUrrSIdwS3LxQUAqzT44kUkKR8uvkpnkn0dv
	8H/AbW+/lWS/O9Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Provide posixtimer_sigqueue_init()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.450427515@linutronix.de>
References: <20241105064213.450427515@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309874.32228.10936085976203178327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     54f1dd642fd088ba969206f09e7afffad7d9db2c
Gitweb:        https://git.kernel.org/tip/54f1dd642fd088ba969206f09e7afffad7d9db2c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:44 +01:00

signal: Provide posixtimer_sigqueue_init()

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.450427515@linutronix.de

---
 include/linux/posix-timers.h |  2 ++
 kernel/signal.c              | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 9740fd0..200098d 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -12,6 +12,7 @@
 
 struct kernel_siginfo;
 struct task_struct;
+struct sigqueue;
 struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
@@ -106,6 +107,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 }
 
 void posixtimer_rearm_itimer(struct task_struct *p);
+bool posixtimer_init_sigqueue(struct sigqueue *q);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index dbd4247..911ed3a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1905,6 +1905,17 @@ void flush_itimer_signals(void)
 	__flush_itimer_signals(&tsk->signal->shared_pending);
 }
 
+bool posixtimer_init_sigqueue(struct sigqueue *q)
+{
+	struct ucounts *ucounts = sig_get_ucounts(current, -1, 0);
+
+	if (!ucounts)
+		return false;
+	clear_siginfo(&q->info);
+	__sigqueue_init(q, ucounts, SIGQUEUE_PREALLOC);
+	return true;
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);

