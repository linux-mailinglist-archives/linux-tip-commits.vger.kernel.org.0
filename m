Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C67311005
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Feb 2021 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhBEQyI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 11:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhBEQto (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 11:49:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557A7C061A2E;
        Fri,  5 Feb 2021 10:29:18 -0800 (PST)
Date:   Fri, 05 Feb 2021 18:29:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612549757;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sb5GcEh9if5NGgSGVu0nGTYCjgLQMWVdk4Mo4Rwo+eg=;
        b=TFCR3Y/+8jtnarrAGnm9EC/SrOXb7ano917GU25q1kMis5k8lg0Zg8FY2Ibm8imzd4MT76
        12BJtn8Dk6F+k7jxY7YTdfUjp+sXUgUZ5oiI2iPms1tsW6LvF381TD3boaGDRK2kWSZ/5E
        6yS3ZHxBGzDxGbTqJTjjg3oP1Fppek7ghTIRhR0lK6S4lYiM1YI4XLJRfnmvhJ33wqrn3B
        BgK0bk3knlWTbtm0IjJmJf00HZPQ9BmCWRcSXnON/ij15NVIuUt8omkJOGcqF6HhAMRhuj
        vHzhMTUzx1Aqn3Ao/lejsGVaxtAC2z/EDJ6Wg6Ub1L+sF1OILg3toCU7oVRceQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612549757;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sb5GcEh9if5NGgSGVu0nGTYCjgLQMWVdk4Mo4Rwo+eg=;
        b=Zv4tmMcj8NloO2VhFioICeiM2gmKlcTSkj66DClRpFFRPNnygvsL/+/kmfPL3ll6t79WeG
        KYDdMiGoLmBIugCA==
From:   "tip-bot2 for Alexandre Belloni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Update kerneldoc
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210202013457.3482388-1-alexandre.belloni@bootlin.com>
References: <20210202013457.3482388-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <161254975618.23325.8904208407309453586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b5c28ea601b801d0ecd5ec703b8d54f77bfe5365
Gitweb:        https://git.kernel.org/tip/b5c28ea601b801d0ecd5ec703b8d54f77bfe5365
Author:        Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate:    Tue, 02 Feb 2021 02:34:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Feb 2021 19:26:41 +01:00

alarmtimer: Update kerneldoc

Update kerneldoc comments to reflect the actual arguments and return values
of the documented functions.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210202013457.3482388-1-alexandre.belloni@bootlin.com

---
 kernel/time/alarmtimer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f4ace1b..98d7a15 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -527,8 +527,11 @@ static enum alarmtimer_type clock2alarm(clockid_t clockid)
 /**
  * alarm_handle_timer - Callback for posix timers
  * @alarm: alarm that fired
+ * @now: time at the timer expiration
  *
  * Posix timer callback for expired alarm timers.
+ *
+ * Return: whether the timer is to be restarted
  */
 static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 							ktime_t now)
@@ -715,8 +718,11 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 /**
  * alarmtimer_nsleep_wakeup - Wakeup function for alarm_timer_nsleep
  * @alarm: ptr to alarm that fired
+ * @now: time at the timer expiration
  *
  * Wakes up the task that set the alarmtimer
+ *
+ * Return: ALARMTIMER_NORESTART
  */
 static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
 								ktime_t now)
@@ -733,6 +739,7 @@ static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
  * alarmtimer_do_nsleep - Internal alarmtimer nsleep implementation
  * @alarm: ptr to alarmtimer
  * @absexp: absolute expiration time
+ * @type: alarm type (BOOTTIME/REALTIME).
  *
  * Sets the alarm timer and sleeps until it is fired or interrupted.
  */
@@ -806,7 +813,6 @@ static long __sched alarm_timer_nsleep_restart(struct restart_block *restart)
  * @which_clock: clockid
  * @flags: determins abstime or relative
  * @tsreq: requested sleep time (abs or rel)
- * @rmtp: remaining sleep time saved
  *
  * Handles clock_nanosleep calls against _ALARM clockids
  */
