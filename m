Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADF30BBBC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 11:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBBKFX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 05:05:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhBBKEh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 05:04:37 -0500
Date:   Tue, 02 Feb 2021 10:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612260233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8cAsFK8lFNJaAbN8W82Rx79RWWZcSFP21OIo8I3N+Y=;
        b=GkBQbSNuIQoHUafQyJokZXwy3UXrLBETPkTjR8meHeKvo2/TDAbHxzT8gaHHewCMvzw2I3
        Bt27aEe4fvzq7HLgU8PuRFc6m1Au2nd/uMdfc7aGGxT/+bkjSzokLp7JP1iUDN5Az4aeYH
        zRBEAHAOKkLOzxqn7Itfrosn+1sbkse+FzK5KylylyZgjqediS/Rjynj2RVVWAUk1reuQf
        /0I1Om35vKxVOeTSISR8IhYkPJYyLGr0zxVdAf7CPxp1S4ryYDBDxtag6h5BINWeWMFDzB
        QOZJb8gh1nZuH5z8c8ZZBIa7iT8yim4byl45/dcDSbLc4duUTDDlhAEQ32RvWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612260233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8cAsFK8lFNJaAbN8W82Rx79RWWZcSFP21OIo8I3N+Y=;
        b=yILKj4NOiLXfEu3sb+WKJSH+EIbWutXAQlwI4yrG+vNOHm9XDKw4598jDtxLUlkLbeIAQQ
        HC81n9cRw8YiWeCA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210128131040.296856-3-dietmar.eggemann@arm.com>
References: <20210128131040.296856-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161226023208.23325.6027956760315640238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c18b4a67cc459fb8389f6a89ce28e404aafe562c
Gitweb:        https://git.kernel.org/tip/c18b4a67cc459fb8389f6a89ce28e404aafe562c
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Jan 2021 14:10:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:39 +01:00

sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO

The only remaining use of MAX_USER_PRIO (and USER_PRIO) is the
SCALE_PRIO() definition in the PowerPC Cell architecture's Synergistic
Processor Unit (SPU) scheduler. TASK_USER_PRIO isn't used anymore.

Commit fe443ef2ac42 ("[POWERPC] spusched: Dynamic timeslicing for
SCHED_OTHER") copied SCALE_PRIO() from the task scheduler in v2.6.23.

Commit a4ec24b48dde ("sched: tidy up SCHED_RR") removed it from the task
scheduler in v2.6.24.

Commit 3ee237dddcd8 ("sched/prio: Add 3 macros of MAX_NICE, MIN_NICE and
NICE_WIDTH in prio.h") introduced NICE_WIDTH much later.

With:

  MAX_USER_PRIO = USER_PRIO(MAX_PRIO)

                = MAX_PRIO - MAX_RT_PRIO

       MAX_PRIO = MAX_RT_PRIO + NICE_WIDTH

  MAX_USER_PRIO = MAX_RT_PRIO + NICE_WIDTH - MAX_RT_PRIO

  MAX_USER_PRIO = NICE_WIDTH

MAX_USER_PRIO can be replaced by NICE_WIDTH to be able to remove all the
{*_}USER_PRIO defines.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210128131040.296856-3-dietmar.eggemann@arm.com
---
 arch/powerpc/platforms/cell/spufs/sched.c |  2 +-
 include/linux/sched/prio.h                |  9 ---------
 kernel/sched/sched.h                      |  2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index f18d506..aeb7f39 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -72,7 +72,7 @@ static struct timer_list spuloadavg_timer;
 #define DEF_SPU_TIMESLICE	(100 * HZ / (1000 * SPUSCHED_TICK))
 
 #define SCALE_PRIO(x, prio) \
-	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_SPU_TIMESLICE)
+	max(x * (MAX_PRIO - prio) / (NICE_WIDTH / 2), MIN_SPU_TIMESLICE)
 
 /*
  * scale user-nice values [ -20 ... 0 ... 19 ] to time slice values:
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index d111f2f..ab83d85 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -27,15 +27,6 @@
 #define PRIO_TO_NICE(prio)	((prio) - DEFAULT_PRIO)
 
 /*
- * 'User priority' is the nice value converted to something we
- * can work with better when scaling various scheduler parameters,
- * it's a [ 0 ... 39 ] range.
- */
-#define USER_PRIO(p)		((p)-MAX_RT_PRIO)
-#define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
-#define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-
-/*
  * Convert nice value [19,-20] to rlimit style value [1,40].
  */
 static inline long nice_to_rlimit(long nice)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 045b010..6edc67d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -140,7 +140,7 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
  * scale_load() and scale_load_down(w) to convert between them. The
  * following must be true:
  *
- *  scale_load(sched_prio_to_weight[USER_PRIO(NICE_TO_PRIO(0))]) == NICE_0_LOAD
+ *  scale_load(sched_prio_to_weight[NICE_TO_PRIO(0)-MAX_RT_PRIO]) == NICE_0_LOAD
  *
  */
 #define NICE_0_LOAD		(1L << NICE_0_LOAD_SHIFT)
