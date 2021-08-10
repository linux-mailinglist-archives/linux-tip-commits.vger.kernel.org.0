Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0DB3E7BDB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbhHJPN7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 11:13:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbhHJPN6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 11:13:58 -0400
Date:   Tue, 10 Aug 2021 15:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628608415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAl0g0uvn99c5fSpwTj7CSmYZkg6tv6jBN8BiDwIwXA=;
        b=lNpViEseQiaMj2g1pFxzAfUP52GSoRWM/4ozesRCyoCNLZfRbQ2qFiD7t32pE9JzDyyW00
        41U2lP6/tUDhuTvo7czjWA7TH502U8wo7Grmi/u/xOMiqouMltukhOa9qbK+/mm4K4wrkC
        +JOc2quXCSFQsydRf27j0B+asWGikcVlrukdHm1dF7ckL46ggCZbqR0KKRPqchbBP+neaw
        1kDI7UQ8c2zPl+nfM4O0P9DorZU2aUaVrWxShM6zW2S59HGYCV/PVUEVgzWoaabp3XEeaM
        pSu7l47OogwuIQ7ndUcvL2Ga3G1g9rl+8JwHXvmWeAscN70TAgsex3n554so6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628608415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAl0g0uvn99c5fSpwTj7CSmYZkg6tv6jBN8BiDwIwXA=;
        b=Rtpu8fupZzGZV1BMhgUkxdex+UpL4Rx6gsT4M2Y/drl2UHyID779d5igNDsdt0pXIcsg5Z
        lI6Tcb8j7pLp5pBw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Force next_expiration recalc
 after timer deletion
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210726125513.271824-3-frederic@kernel.org>
References: <20210726125513.271824-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162860841456.395.13269805420473115791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     175cc3ab28e3509ddee8de4f164b563d99daa570
Gitweb:        https://git.kernel.org/tip/175cc3ab28e3509ddee8de4f164b563d99daa570
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 14:55:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:09:59 +02:00

posix-cpu-timers: Force next_expiration recalc after timer deletion

A timer deletion only dequeues the timer but it doesn't shutdown
the related costly process wide cputimer counter and the tick dependency.

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

Make sure the next target's tick recalculates the nearest expiration and
clears the process wide counter and tick dependency if necessary.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210726125513.271824-3-frederic@kernel.org

---
 include/linux/posix-timers.h   |  4 +++-
 kernel/time/posix-cpu-timers.c | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 896c16d..4cf1fbe 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -82,12 +82,14 @@ static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
 	return timerqueue_add(head, &ctmr->node);
 }
 
-static inline void cpu_timer_dequeue(struct cpu_timer *ctmr)
+static inline bool cpu_timer_dequeue(struct cpu_timer *ctmr)
 {
 	if (ctmr->head) {
 		timerqueue_del(ctmr->head, &ctmr->node);
 		ctmr->head = NULL;
+		return true;
 	}
+	return false;
 }
 
 static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 4693d3c..61c78b6 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -408,6 +408,37 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 }
 
 /*
+ * Dequeue the timer and reset the base if it was its earliest expiration.
+ * It makes sure the next tick recalculates the base next expiration so we
+ * don't keep the costly process wide cputime counter around for a random
+ * amount of time, along with the tick dependency.
+ *
+ * If another timer gets queued between this and the next tick, its
+ * expiration will update the base next event if necessary on the next
+ * tick.
+ */
+static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
+{
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct posix_cputimer_base *base;
+	int clkidx;
+
+	if (!cpu_timer_dequeue(ctmr))
+		return;
+
+	clkidx = CPUCLOCK_WHICH(timer->it_clock);
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		base = p->posix_cputimers.bases + clkidx;
+	else
+		base = p->signal->posix_cputimers.bases + clkidx;
+
+	if (cpu_timer_getexpires(ctmr) == base->nextevt)
+		base->nextevt = 0;
+}
+
+
+/*
  * Clean up a CPU-clock timer that is about to be destroyed.
  * This is called from timer deletion with the timer already locked.
  * If we return TIMER_RETRY, it's necessary to release the timer's lock
@@ -441,7 +472,7 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
 		else
-			cpu_timer_dequeue(ctmr);
+			disarm_timer(timer, p);
 
 		unlock_task_sighand(p, &flags);
 	}
