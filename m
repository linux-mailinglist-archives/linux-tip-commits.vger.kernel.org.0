Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AAE3E7BD9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbhHJPN6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbhHJPN6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 11:13:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37916C0613C1;
        Tue, 10 Aug 2021 08:13:35 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:13:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628608412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMHNbs3RwI85s2VEN40mwTzrANc6ZmsucTIObwsPvGk=;
        b=tICRaOcldPy8jwsS2yiI89BTUgWqMw64e6870n72+mzwskqD/hv0VJ7aJ45EAaM2Qu0Zia
        tE3JnBpLZu65cbAnc0UjJ83lsVtrVJUg/otlVY8IEE6asubezDtsDnE7rghEAG34rE5NDN
        V3ogoFIxBSoHQDuRPbqBVWeU5VndV+OOpnCR0kLUJSZbS5aqzv/16N1XTpkI575QztcZM1
        69zxG48ez7/6ppX4k2NJI9e60Yvr/W+G+WzNyJOd5Hgo4265bQd+ktuMvGcf3ZLE3VtYwl
        VToLmu3zeH86B+noaXRnq4k2XDXxVwuzaTOqdGnJ9xu/X3WGsvi+8MBvLQ2KJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628608412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMHNbs3RwI85s2VEN40mwTzrANc6ZmsucTIObwsPvGk=;
        b=sNMokRpa9ggKC6lWB+SY0zg6Ig/YKLR3gDJm1bxWYy9tGejNXlYe9puAcEzcqE5SYNpi1c
        YrWliB5Tm9+jvbAA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Recalc next expiration when
 timer_settime() ends up not queueing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210726125513.271824-7-frederic@kernel.org>
References: <20210726125513.271824-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162860841197.395.1494711677947211961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ee375328f579f94251eb66d5dc91aba056019a31
Gitweb:        https://git.kernel.org/tip/ee375328f579f94251eb66d5dc91aba056019a31
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 14:55:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:09:59 +02:00

posix-cpu-timers: Recalc next expiration when timer_settime() ends up not queueing

There are several scenarios that can result in posix_cpu_timer_set()
not queueing the timer but still leaving the threadgroup cputime counter
running or keeping the tick dependency around for a random amount of time.

1) If timer_settime() is called with a 0 expiration on a timer that is
   already disabled, the process wide cputime counter will be started
   and won't ever get a chance to be stopped by stop_process_timer()
   since no timer is actually armed to be processed.

   The following snippet is enough to trigger the issue.

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
		timer_delete(id);
	}

2) If timer_settime() is called with a 0 expiration on a timer that is
   already armed, the timer is dequeued but not really disarmed. So the
   process wide cputime counter and the tick dependency may still remain
   a while around.

   The following code snippet keeps this overhead around for one week after
   the timer deletion:

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		val.it_value.tv_sec = 604800;
		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		timer_settime(id, 0, &val, NULL);
		timer_delete(id);
	}

3) If the timer was initially deactivated, this call to timer_settime()
   with an early expiration may have started the process wide cputime
   counter even though the timer hasn't been queued and armed because it
   has fired early and inline within posix_cpu_timer_set() itself. As a
   result the process wide cputime counter may never stop until a new
   timer is ever armed in the future.

   The following code snippet can reproduce this:

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		signal(SIGALRM, SIG_IGN);
		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		val.it_value.tv_nsec = 1;
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
	}

4) If the timer was initially armed with a former expiration value
   before this call to timer_settime() and the current call sets an
   early deadline that has already expired, the timer fires inline
   within posix_cpu_timer_set(). In this case it must have been dequeued
   before firing inline with its new expiration value, yet it hasn't
   been disarmed in this case. So the process wide cputime counter and
   the tick dependency may still be around for a while even after the
   timer fired.

   The following code snippet can reproduce this:

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		signal(SIGALRM, SIG_IGN);
		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		val.it_value.tv_sec = 100;
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
		val.it_value.tv_sec = 0;
		val.it_value.tv_nsec = 1;
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
	}

Fix all these issues with triggering the related base next expiration
recalculation on the next tick. This also implies to re-evaluate the need
to keep around the process wide cputime counter and the tick dependency, in
a similar fashion to disarm_timer().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210726125513.271824-7-frederic@kernel.org

---
 include/linux/posix-timers.h   |  7 +++++-
 kernel/time/posix-cpu-timers.c | 41 ++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 4cf1fbe..00fef00 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -82,9 +82,14 @@ static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
 	return timerqueue_add(head, &ctmr->node);
 }
 
+static inline bool cpu_timer_queued(struct cpu_timer *ctmr)
+{
+	return !!ctmr->head;
+}
+
 static inline bool cpu_timer_dequeue(struct cpu_timer *ctmr)
 {
-	if (ctmr->head) {
+	if (cpu_timer_queued(ctmr)) {
 		timerqueue_del(ctmr->head, &ctmr->node);
 		ctmr->head = NULL;
 		return true;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0d91811..ee73686 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -419,6 +419,20 @@ static struct posix_cputimer_base *timer_base(struct k_itimer *timer,
 }
 
 /*
+ * Force recalculating the base earliest expiration on the next tick.
+ * This will also re-evaluate the need to keep around the process wide
+ * cputime counter and tick dependency and eventually shut these down
+ * if necessary.
+ */
+static void trigger_base_recalc_expires(struct k_itimer *timer,
+					struct task_struct *tsk)
+{
+	struct posix_cputimer_base *base = timer_base(timer, tsk);
+
+	base->nextevt = 0;
+}
+
+/*
  * Dequeue the timer and reset the base if it was its earliest expiration.
  * It makes sure the next tick recalculates the base next expiration so we
  * don't keep the costly process wide cputime counter around for a random
@@ -438,7 +452,7 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 
 	base = timer_base(timer, p);
 	if (cpu_timer_getexpires(ctmr) == base->nextevt)
-		base->nextevt = 0;
+		trigger_base_recalc_expires(timer, p);
 }
 
 
@@ -734,13 +748,28 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (new_expires != 0 && !(val < new_expires)) {
+	if (val >= new_expires) {
+		if (new_expires != 0) {
+			/*
+			 * The designated time already passed, so we notify
+			 * immediately, even if the thread never runs to
+			 * accumulate more time on this clock.
+			 */
+			cpu_timer_fire(timer);
+		}
+
 		/*
-		 * The designated time already passed, so we notify
-		 * immediately, even if the thread never runs to
-		 * accumulate more time on this clock.
+		 * Make sure we don't keep around the process wide cputime
+		 * counter or the tick dependency if they are not necessary.
 		 */
-		cpu_timer_fire(timer);
+		sighand = lock_task_sighand(p, &flags);
+		if (!sighand)
+			goto out;
+
+		if (!cpu_timer_queued(ctmr))
+			trigger_base_recalc_expires(timer, p);
+
+		unlock_task_sighand(p, &flags);
 	}
  out:
 	rcu_read_unlock();
