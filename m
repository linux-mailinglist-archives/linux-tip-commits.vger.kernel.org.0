Return-Path: <linux-tip-commits+bounces-2779-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302589BFB78
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539BC1C20ECD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20227D515;
	Thu,  7 Nov 2024 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkLD3ZeF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywl92Nlh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323614431;
	Thu,  7 Nov 2024 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943094; cv=none; b=qEWkYmVbfyN2cSOQory8jqExoEsR23yS3AIySJfDgoHtUBx3chMNhvm0vT/VMoj0r4cVHeBNyL1XlIPZzodET474/Fyx5X6tQU22NfhgFi6PYNxlmMSMgzeDzs9gGd2j9ka4H+HLcnGzK3XxYbshO/yLwJA6UlcEYwzMxuVXQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943094; c=relaxed/simple;
	bh=1gXwOrmrPEn8IkSK3eSRfWnzhaGKELz5rKOepQs6rJI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o0CxR8W28S5L5ixqoT9YD+R5zs/Guem575GiuHdEWH4KiRE6XCq/9AHTH4h8cgIOKXmH0TsuPn03ENhw4XULV2frpeBFV0d4TKy8LFkozakXy32R0wlIc3gYLKbF1FzZeXVk1Jy6fvCy8Q7dNiYq9+Xg9hycI/MMhBZ/8IJURH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkLD3ZeF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywl92Nlh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dvwVxpYoZ5M/Fn990soagGKWafK+z4E6IBxaBE/UHU=;
	b=dkLD3ZeF2LPOWpUBDNPExLNnOuXDLrh1mUwdrsVGK4/g6uU8DnkdBfP41QxsCo/Kl0nkNn
	5p89lCy4JwkVNtHWv6EEhGTnRS5K6jMBFvyV5IAFddZbj8RfScMybeWpFLBnhr8YN4rXOG
	rZWcrF0yhDVCvQcecPzwn5uHeeZvI5xqN8JG26Oe5veDs50Q6oHzlVw8BGPCyZhfRvMrq8
	Z2pNiUSsA2ej0F8/2Ey8Ai/WFSZBYJ1ArWiAVoSk8ax+4grqGKDTkrnmxye4a6VsptgVZ6
	JaS3eyZzJtoI1X1SQnl76aYg/TMHY+1Xd0nY6x2Ldu6qsPRi+ZRdMaWMps78wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dvwVxpYoZ5M/Fn990soagGKWafK+z4E6IBxaBE/UHU=;
	b=ywl92Nlh/LrQ58E3/lwEJZI4UPy6pZUfO8kOLe3+pKXwMtWRVkZgvqAI7VtLABU6ph6ozl
	3c0KVNpDqLyophAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] alarmtimers: Remove return value from alarm functions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064214.318837272@linutronix.de>
References: <20241105064214.318837272@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094308937.32228.6678702010414552445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2634303f8773b0c602069887565cd412440be15d
Gitweb:        https://git.kernel.org/tip/2634303f8773b0c602069887565cd412440be15d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:46 +01:00

alarmtimers: Remove return value from alarm functions

Now that the SIG_IGN problem is solved in the core code, the alarmtimer
callbacks do not require a return value anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241105064214.318837272@linutronix.de

---
 drivers/power/supply/charger-manager.c |  3 +--
 fs/timerfd.c                           |  4 +---
 include/linux/alarmtimer.h             | 10 ++--------
 kernel/time/alarmtimer.c               | 16 +++++-----------
 net/netfilter/xt_IDLETIMER.c           |  4 +---
 5 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 96f0a7f..09ec0ec 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1412,10 +1412,9 @@ static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
 	return dev_get_platdata(&pdev->dev);
 }
 
-static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t now)
+static void cm_timer_func(struct alarm *alarm, ktime_t now)
 {
 	cm_timer_set = false;
-	return ALARMTIMER_NORESTART;
 }
 
 static int charger_manager_probe(struct platform_device *pdev)
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 137523e..f10c99a 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -79,13 +79,11 @@ static enum hrtimer_restart timerfd_tmrproc(struct hrtimer *htmr)
 	return HRTIMER_NORESTART;
 }
 
-static enum alarmtimer_restart timerfd_alarmproc(struct alarm *alarm,
-	ktime_t now)
+static void timerfd_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct timerfd_ctx *ctx = container_of(alarm, struct timerfd_ctx,
 					       t.alarm);
 	timerfd_triggered(ctx);
-	return ALARMTIMER_NORESTART;
 }
 
 /*
diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 05e758b..3ffa534 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -20,12 +20,6 @@ enum alarmtimer_type {
 	ALARM_BOOTTIME_FREEZER,
 };
 
-enum alarmtimer_restart {
-	ALARMTIMER_NORESTART,
-	ALARMTIMER_RESTART,
-};
-
-
 #define ALARMTIMER_STATE_INACTIVE	0x00
 #define ALARMTIMER_STATE_ENQUEUED	0x01
 
@@ -42,14 +36,14 @@ enum alarmtimer_restart {
 struct alarm {
 	struct timerqueue_node	node;
 	struct hrtimer		timer;
-	enum alarmtimer_restart	(*function)(struct alarm *, ktime_t now);
+	void			(*function)(struct alarm *, ktime_t now);
 	enum alarmtimer_type	type;
 	int			state;
 	void			*data;
 };
 
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t));
+		void (*function)(struct alarm *, ktime_t));
 void alarm_start(struct alarm *alarm, ktime_t start);
 void alarm_start_relative(struct alarm *alarm, ktime_t start);
 void alarm_restart(struct alarm *alarm);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 593e7d5..37d2d79 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -321,7 +321,7 @@ static int alarmtimer_resume(struct device *dev)
 
 static void
 __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+	     void (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
 	alarm->timer.function = alarmtimer_fired;
@@ -337,7 +337,7 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
  * @function: callback that is run when the alarm fires
  */
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
 		     HRTIMER_MODE_ABS);
@@ -530,14 +530,12 @@ static enum alarmtimer_type clock2alarm(clockid_t clockid)
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm, ktime_t now)
+static void alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
 	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 
 	guard(spinlock_irqsave)(&ptr->it_lock);
 	posix_timer_queue_signal(ptr);
-
-	return ALARMTIMER_NORESTART;
 }
 
 /**
@@ -698,18 +696,14 @@ static int alarm_timer_create(struct k_itimer *new_timer)
  * @now: time at the timer expiration
  *
  * Wakes up the task that set the alarmtimer
- *
- * Return: ALARMTIMER_NORESTART
  */
-static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
-								ktime_t now)
+static void alarmtimer_nsleep_wakeup(struct alarm *alarm, ktime_t now)
 {
 	struct task_struct *task = alarm->data;
 
 	alarm->data = NULL;
 	if (task)
 		wake_up_process(task);
-	return ALARMTIMER_NORESTART;
 }
 
 /**
@@ -761,7 +755,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 
 static void
 alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
-		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		    void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
 			      HRTIMER_MODE_ABS);
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index db720ef..5514600 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -107,14 +107,12 @@ static void idletimer_tg_expired(struct timer_list *t)
 	schedule_work(&timer->work);
 }
 
-static enum alarmtimer_restart idletimer_tg_alarmproc(struct alarm *alarm,
-							  ktime_t now)
+static void idletimer_tg_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct idletimer_tg *timer = alarm->data;
 
 	pr_debug("alarm %s expired\n", timer->attr.attr.name);
 	schedule_work(&timer->work);
-	return ALARMTIMER_NORESTART;
 }
 
 static int idletimer_check_sysfs_name(const char *name, unsigned int size)

