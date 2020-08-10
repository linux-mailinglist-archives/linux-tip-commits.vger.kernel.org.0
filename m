Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF3E241191
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Aug 2020 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgHJUP4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 Aug 2020 16:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgHJUPz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 Aug 2020 16:15:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B5C061756;
        Mon, 10 Aug 2020 13:15:55 -0700 (PDT)
Date:   Mon, 10 Aug 2020 20:15:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597090554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irUkFqykKqMti+lm3cLQmGnnfwNNE0XtxTsoUxBK10g=;
        b=ntarJ+UCeX6sTDJbBOcJqc5CNRdCvnUcQ3v10XE3SQJKQgEKj4nmcl+13p6NhL/kYhOuiy
        2Q14tsYTIOyq86sUEFrlXCHWfMNqLyO7sIAYMYuMRhr4Ko7qpIEAut2R7eYJgWO0hbWXIQ
        pfqyG32aFm+aaQuo+3ELIRc6nI1BlQB3sbqdkX28jVXJunnYMuQIs7K97XGZzwE+eVl7Tm
        WvzspUxgvuOjIHzR/jO3ngdmQdA8BaJEMaHhhu6rYLQ/y5cODgrVwlyR7PLlv33AXseuHO
        Z7MgsIuIJ7cS2ykHL3oUnCOJH7TsfVq2gSumQ3i7GXlDi6RiX0hF0E0joP+v/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597090554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irUkFqykKqMti+lm3cLQmGnnfwNNE0XtxTsoUxBK10g=;
        b=k/bbFjhxY08pvA0bhNlkbppEzZe2YWirL0DoItV4Kyr7+tsXGIMuY07YGfa+hdD3hcvRc2
        c9VqaZ0pxQxSuQBw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time: Delete repeated words in comments
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807033248.8452-1-rdunlap@infradead.org>
References: <20200807033248.8452-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <159709055286.3192.1189188445404949142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b0294f30256bb6023b2044fd607855123863d98f
Gitweb:        https://git.kernel.org/tip/b0294f30256bb6023b2044fd607855123863d98f
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Thu, 06 Aug 2020 20:32:48 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Aug 2020 22:14:07 +02:00

time: Delete repeated words in comments

Drop repeated words in kernel/time/.  {when, one, into}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <john.stultz@linaro.org>
Link: https://lore.kernel.org/r/20200807033248.8452-1-rdunlap@infradead.org
---
 kernel/time/alarmtimer.c  | 2 +-
 kernel/time/sched_clock.c | 2 +-
 kernel/time/timekeeping.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 2ffb466..ca223a8 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -192,7 +192,7 @@ static void alarmtimer_dequeue(struct alarm_base *base, struct alarm *alarm)
  * When a alarm timer fires, this runs through the timerqueue to
  * see which alarms expired, and runs those. If there are more alarm
  * timers queued for the future, we set the hrtimer to fire when
- * when the next future alarm timer expires.
+ * the next future alarm timer expires.
  */
 static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 {
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 0deaf4b..1c03eec 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -229,7 +229,7 @@ void __init generic_sched_clock_init(void)
 {
 	/*
 	 * If no sched_clock() function has been provided at that point,
-	 * make it the final one one.
+	 * make it the final one.
 	 */
 	if (cd.actual_read_sched_clock == jiffy_sched_clock_read)
 		sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c7212f..35cd10f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2001,7 +2001,7 @@ static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
  * logarithmic_accumulation - shifted accumulation of cycles
  *
  * This functions accumulates a shifted interval of cycles into
- * into a shifted interval nanoseconds. Allows for O(log) accumulation
+ * a shifted interval nanoseconds. Allows for O(log) accumulation
  * loop.
  *
  * Returns the unconsumed cycles.
