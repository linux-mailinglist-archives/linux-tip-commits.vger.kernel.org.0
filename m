Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8032C7C6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447353AbhCDAcr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843069AbhCCKZM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB82C08EC28;
        Wed,  3 Mar 2021 01:49:37 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYqMWc+dOHJzPAkdUI0nqbHKYKszu3Hf49jS0FYkSBw=;
        b=OhwWEeexY3SqhYVkGXi4iGkbMkZjpGERm1jzM9Vf0l8x3j4sLvKrWbyNKAqvqK6d4QQSJF
        3FzpSSzjzsJEXelSUX4i4lb6sJ02rGhGmMzuc5oA57SG7T8pZBEQ4fT3ncD5NCyKOSN4Bs
        YxjZsX0yFUYLKNZCdY/8u9pikjp50WeXzdX3HQKLw8aXDiGyZGfa9AUDS15X9qal/CJU74
        rIVCf1xsUYSX6sZbTNliKTrJ+XM1vEaNPME19jzZkg5NbWRSDOnLdnki+3UQRSZxUtyOXX
        xWJ5dn97Xqj1tg8cUsKxBQwrDlP8Br7iEUvxPh3mUcI+SvTVkbi1Q37B8GU91w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYqMWc+dOHJzPAkdUI0nqbHKYKszu3Hf49jS0FYkSBw=;
        b=3QusnBzKYhc59+EU3qGGPg/rp2QjdvIK7DZK1Dq7ibfcdRKvo9bHn3v6BlnqqFcOplWQNA
        VxE5U1MxE9K5+GBA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix shift-out-of-bounds in load_balance()
Cc:     syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <000000000000ffac1205b9a2112f@google.com>
References: <000000000000ffac1205b9a2112f@google.com>
MIME-Version: 1.0
Message-ID: <161476497574.20312.4405097692363474964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9ab8f620eea3a797667add72eae5e235d2ca2fc8
Gitweb:        https://git.kernel.org/tip/9ab8f620eea3a797667add72eae5e235d2ca2fc8
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 25 Feb 2021 17:56:56 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:33:00 +01:00

sched/fair: Fix shift-out-of-bounds in load_balance()

Syzbot reported a handful of occurrences where an sd->nr_balance_failed can
grow to much higher values than one would expect.

A successful load_balance() resets it to 0; a failed one increments
it. Once it gets to sd->cache_nice_tries + 3, this *should* trigger an
active balance, which will either set it to sd->cache_nice_tries+1 or reset
it to 0. However, in case the to-be-active-balanced task is not allowed to
run on env->dst_cpu, then the increment is done without any further
modification.

This could then be repeated ad nauseam, and would explain the absurdly high
values reported by syzbot (86, 149). VincentG noted there is value in
letting sd->cache_nice_tries grow, so the shift itself should be
fixed. That means preventing:

  """
  If the value of the right operand is negative or is greater than or equal
  to the width of the promoted left operand, the behavior is undefined.
  """

Thus we need to cap the shift exponent to
  BITS_PER_TYPE(typeof(lefthand)) - 1.

I had a look around for other similar cases via coccinelle:

  @expr@
  position pos;
  expression E1;
  expression E2;
  @@
  (
  E1 >> E2@pos
  |
  E1 >> E2@pos
  )

  @cst depends on expr@
  position pos;
  expression expr.E1;
  constant cst;
  @@
  (
  E1 >> cst@pos
  |
  E1 << cst@pos
  )

  @script:python depends on !cst@
  pos << expr.pos;
  exp << expr.E2;
  @@
  # Dirty hack to ignore constexpr
  if exp.upper() != exp:
     coccilib.report.print_report(pos[0], "Possible UB shift here")

The only other match in kernel/sched is rq_clock_thermal() which employs
sched_thermal_decay_shift, and that exponent is already capped to 10, so
that one is fine.

Fixes: 5a7f55590467 ("sched/fair: Relax constraint on task's load during load balance")
Reported-by: syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lore.kernel.org/r/000000000000ffac1205b9a2112f@google.com
---
 kernel/sched/fair.c  | 3 +--
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b2fac0..1af51a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7722,8 +7722,7 @@ static int detach_tasks(struct lb_env *env)
 			 * scheduler fails to find a good waiting task to
 			 * migrate.
 			 */
-
-			if ((load >> env->sd->nr_balance_failed) > env->imbalance)
+			if (shr_bound(load, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= load;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ddc9a6..bb8bb06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -205,6 +205,13 @@ static inline void update_avg(u64 *avg, u64 sample)
 }
 
 /*
+ * Shifting a value by an exponent greater *or equal* to the size of said value
+ * is UB; cap at size-1.
+ */
+#define shr_bound(val, shift)							\
+	(val >> min_t(typeof(shift), shift, BITS_PER_TYPE(typeof(val)) - 1))
+
+/*
  * !! For sched_setattr_nocheck() (kernel) only !!
  *
  * This is actually gross. :(
