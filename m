Return-Path: <linux-tip-commits+bounces-2096-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C498E95D53C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABC7B214F3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23AC191F7E;
	Fri, 23 Aug 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+wcffDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEQyamN0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53C18E02E;
	Fri, 23 Aug 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437193; cv=none; b=TJT79MZ5g2io1HMbnBghS307cHCxfZHsIiJ/SwnGFugONt+zuFNwU6WcrOa4o0g4g8qiQnfryBUsFh5iBTrSbaAN6RBfNZVlFP6uFUB/A2IQoaBJfiMPnIQuajiqekckgI5xcqXRLh7n2+wD/A8pj1SijJJdnFHSJNJKo5J2nDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437193; c=relaxed/simple;
	bh=LTIJP/xsC4g01ccyCTZZGmcRE+rUXlDSW+WVy60vRro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EhTt+yzN+uwFU/E7qAKI6DOPS2Raslr5yqKAzqAH725UirNlIhxcCxqGWZd1VlHN06DFsW+LT4dVRMSZqiytYodM27qvY10pa4+YAAu3xw3shUC1XuXmrHSQvOn7B9BQvb4U+J9JKLf4qD9MxS2V/0AEdGMFhqTbGyl54hl7eZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+wcffDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEQyamN0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 18:19:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724437190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Vz1gwToajobaPkgaGzDqPc7BWj4Pq3B7EJNW/SUJjE=;
	b=I+wcffDY+53H8PM/wPwaHxu7S7Q293facknUHtse00/0Qn9eOZkvEhaGlmzyWSFGdptGAe
	n2po+ZK5jEagIahxJkAFp/wtNuOiNCG2VPjnHIPUhQLAwGqilz79joGlVN7AzPty60Oz+T
	jqT9oCTKq27iX4AikzYvkFaZZxo7JfUt2txN8f9v2hTMSmnfCsDf8eg42qdfv1WgHK0OJk
	2NKbdTyI5tISRGsti9lIv5eBVwcN/T3XnpbpDy4sYAlSXiMHV7UPRToC7QKAPoDrDLm+p7
	trjearHCQs+bZdzfDT7aZ14+pHldcAG65DzN2os+/kscJL2SozsFNf8bvFb2Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724437190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Vz1gwToajobaPkgaGzDqPc7BWj4Pq3B7EJNW/SUJjE=;
	b=MEQyamN0OTHyCD4ulY75mwSSpxu6p7KTwDowqBXPuTG/PChcQSAmsyLBuGomvi1U0Strsn
	bGzpodaMKls5omBA==
From: "tip-bot2 for Felix Moessbauer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Use and report correct timerslack values
 for realtime tasks
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240814121032.368444-2-felix.moessbauer@siemens.com>
References: <20240814121032.368444-2-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172443718977.2215.5321062634371250950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ed4fb6d7ef68111bb539283561953e5c6e9a6e38
Gitweb:        https://git.kernel.org/tip/ed4fb6d7ef68111bb539283561953e5c6e9a6e38
Author:        Felix Moessbauer <felix.moessbauer@siemens.com>
AuthorDate:    Wed, 14 Aug 2024 14:10:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 20:13:02 +02:00

hrtimer: Use and report correct timerslack values for realtime tasks

The timerslack_ns setting is used to specify how much the hardware
timers should be delayed, to potentially dispatch multiple timers in a
single interrupt. This is a performance optimization. Timers of
realtime tasks (having a realtime scheduling policy) should not be
delayed.

This logic was inconsitently applied to the hrtimers, leading to delays
of realtime tasks which used timed waits for events (e.g. condition
variables). Due to the downstream override of the slack for rt tasks,
the procfs reported incorrect (non-zero) timerslack_ns values.

This is changed by setting the timer_slack_ns task attribute to 0 for
all tasks with a rt policy. By that, downstream users do not need to
specially handle rt tasks (w.r.t. the slack), and the procfs entry
shows the correct value of "0". Setting non-zero slack values (either
via procfs or PR_SET_TIMERSLACK) on tasks with a rt policy is ignored,
as stated in "man 2 PR_SET_TIMERSLACK":

  Timer slack is not applied to threads that are scheduled under a
  real-time scheduling policy (see sched_setscheduler(2)).

The special handling of timerslack on rt tasks in downstream users
is removed as well.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240814121032.368444-2-felix.moessbauer@siemens.com

---
 fs/proc/base.c          |  9 +++++----
 fs/select.c             | 11 ++++-------
 kernel/sched/syscalls.c |  8 ++++++++
 kernel/sys.c            |  2 ++
 kernel/time/hrtimer.c   | 18 +++---------------
 5 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index dd57933..afe573e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2569,10 +2569,11 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 	}
 
 	task_lock(p);
-	if (slack_ns == 0)
-		p->timer_slack_ns = p->default_timer_slack_ns;
-	else
-		p->timer_slack_ns = slack_ns;
+	if (task_is_realtime(p))
+		slack_ns = 0;
+	else if (slack_ns == 0)
+		slack_ns = p->default_timer_slack_ns;
+	p->timer_slack_ns = slack_ns;
 	task_unlock(p);
 
 out:
diff --git a/fs/select.c b/fs/select.c
index 9515c3f..ad171b7 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -77,19 +77,16 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 {
 	u64 ret;
 	struct timespec64 now;
+	u64 slack = current->timer_slack_ns;
 
-	/*
-	 * Realtime tasks get a slack of 0 for obvious reasons.
-	 */
-
-	if (rt_task(current))
+	if (slack == 0)
 		return 0;
 
 	ktime_get_ts64(&now);
 	now = timespec64_sub(*tv, now);
 	ret = __estimate_accuracy(&now);
-	if (ret < current->timer_slack_ns)
-		return current->timer_slack_ns;
+	if (ret < slack)
+		return slack;
 	return ret;
 }
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b427..195d2f2 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -406,6 +406,14 @@ static void __setscheduler_params(struct task_struct *p,
 	else if (fair_policy(policy))
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
 
+	/* rt-policy tasks do not have a timerslack */
+	if (task_is_realtime(p)) {
+		p->timer_slack_ns = 0;
+	} else if (p->timer_slack_ns == 0) {
+		/* when switching back to non-rt policy, restore timerslack */
+		p->timer_slack_ns = p->default_timer_slack_ns;
+	}
+
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
 	 * !rt_policy. Always setting this ensures that things like
diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1b..e3c4cff 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2557,6 +2557,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
+		if (task_is_realtime(current))
+			break;
 		if (arg2 <= 0)
 			current->timer_slack_ns =
 					current->default_timer_slack_ns;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f56ef23..a023946 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2074,14 +2074,9 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
 	int ret = 0;
-	u64 slack;
-
-	slack = current->timer_slack_ns;
-	if (rt_task(current))
-		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -2251,7 +2246,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2278,13 +2273,6 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	/*
-	 * Override any slack passed by the user if under
-	 * rt contraints.
-	 */
-	if (rt_task(current))
-		delta = 0;
-
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2304,7 +2292,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has

