Return-Path: <linux-tip-commits+bounces-2784-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D24F9BFB81
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F4028336C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1238FAD;
	Thu,  7 Nov 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0I3RPkQe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="brw1ffVl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194F168B1;
	Thu,  7 Nov 2024 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943097; cv=none; b=cr/0XVCab20/28igyPJpAVcQwzR8Fho38rWwxjpFbhZedIIyUWgWnLHmQjpH4QM7jVIiflJ0d9w1I0vzl3ca19lVvKb9z3AlEkE+kGG68uD21ot40YGT8VI7weByB8Blvg3cNcTXE8eD8rFjbQVvsIaw21plQUYJ7Jidp8ogRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943097; c=relaxed/simple;
	bh=ycGeJ75vvb1UcU+NwS6P6TKhKImm4wIl+dzOv7/ve6E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kuRNyJXoRnld9ImlCULQ4mRUaEZMf+2bjCx0Hy+2HwPa4MLUNwBq/su6Kpv4VSy+7e9UtUS4H6+R0Jme33ntHxOH3hrWmKnG4VSXhoJmL0OjssHVqycKK+yxQyfNiMxjLWd6ASlroAgDPMy0Ka/TWjPH+h7PvyrNnNSTZdeefcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0I3RPkQe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=brw1ffVl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7g/Rfs1Dlt2chdk5mBdMpyBp30+kS6OfC6Ma9hGyE0=;
	b=0I3RPkQe7YHAfU7XdfMGYe7EVhzjooyVivY9kcYQgU4nExFN7sw5DA/vd2OWIjU9AjqH5P
	wiL+h0Ryn7fxatFbNy3gTjItd2fkppOyBnECvyke836jVSRbo5JpR+2fP8Af0K2V9/Q5OF
	VABhJ1jgobVvzk3nT8fG8Va9Ww4YvdRTiGZYZ5LDxxxHlt5Yhyntr1muEN/LtQivJj3IGd
	NtCfXngr5j5PeAL7NFWt0QSAscKF0wSAwL9uw2Jw1Y/L4PW5voE3j4PNJ5YgBYPKwXjaPR
	/sLIxiPQHyw96gYrpibz5vVlaR3k2BHxRQCo1WL9bo99YSsuvIXvlqThgdWytg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7g/Rfs1Dlt2chdk5mBdMpyBp30+kS6OfC6Ma9hGyE0=;
	b=brw1ffVljQKOWIuy2+D8oUsbuEOHQZrHiIhozr1FV7ZM24zHwAIlJcv+JhoTGangkQb5SS
	ytdSvJdBWdA3vxDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-timers: Handle ignored list on delete and exit
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.987530588@linutronix.de>
References: <20241105064213.987530588@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309295.32228.2746273198149452298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0e20cd33acc7a173b23900550331ee82a23e9f00
Gitweb:        https://git.kernel.org/tip/0e20cd33acc7a173b23900550331ee82a23e9f00
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:45 +01:00

posix-timers: Handle ignored list on delete and exit

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.987530588@linutronix.de

---
 include/linux/posix-timers.h |  4 +++-
 kernel/time/posix-timers.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 49a8961..1608b52 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -152,7 +152,8 @@ static inline void posix_cputimers_init_work(void) { }
 
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
@@ -176,6 +177,7 @@ static inline void posix_cputimers_init_work(void) { }
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index f20c06d..2b88fb4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1027,6 +1027,18 @@ int common_timer_del(struct k_itimer *timer)
 	return 0;
 }
 
+/*
+ * If the deleted timer is on the ignored list, remove it and
+ * drop the associated reference.
+ */
+static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
+{
+	if (!hlist_unhashed(&tmr->ignored_list)) {
+		hlist_del_init(&tmr->ignored_list);
+		posixtimer_putref(tmr);
+	}
+}
+
 static inline int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
@@ -1059,6 +1071,7 @@ retry_delete:
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1110,6 +1123,8 @@ retry_delete:
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1142,6 +1157,19 @@ void exit_itimers(struct task_struct *tsk)
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers))
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+
+	/*
+	 * There should be no timers on the ignored list. itimer_delete() has
+	 * mopped them up.
+	 */
+	if (!WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers)))
+		return;
+
+	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
+	while (!hlist_empty(&timers)) {
+		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer,
+							ignored_list));
+	}
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,

