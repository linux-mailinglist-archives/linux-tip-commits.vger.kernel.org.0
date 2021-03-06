Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466C232FA00
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhCFLmc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCFLmX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFEC061763;
        Sat,  6 Mar 2021 03:42:23 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4SnCY2Rq9mm8tFIt7rsJ1CXYJtM1gt18iPllrIwk6M=;
        b=X1mzMRLjLnw4NSm9tqF9y43LVQLSvZd1lssdHJVbDFW1v7iIMX+blzwXIA+/LAifQTNezf
        RhsDv1X84NsDkZC2wlnputHJbPFZjjT5Ota99gS9cz4dKkvcswZ4t0wS7P4qj5HO62V9cV
        p3IKJb6C1r6YHaxw+X4pcIobBOPwYN3ftPMc6pdzSUbrF9UJPMFWVvVVbydpgJFFgaie9f
        w4o3kLOKygw8nwAjfY24hkUPytf9Cfkt/yksKIG17saCcoSu4lLBJRNid/dd2KpAZNRWXI
        MKuGnpX/lYPF77V3VdobpRYjyGgAVHWwOHl5bj2nCJ657lcdjSXVL+QLkDOySw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4SnCY2Rq9mm8tFIt7rsJ1CXYJtM1gt18iPllrIwk6M=;
        b=lqV4wBl0lXlV6O4cJBobYg3IBuzWaoAly3xG/873Qv8m6Gg/tzfU6o1NttonZ8RIz/9m/C
        baKJMGI2ArEardCQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix shift-out-of-bounds in load_balance()
Cc:     syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <000000000000ffac1205b9a2112f@google.com>
References: <000000000000ffac1205b9a2112f@google.com>
MIME-Version: 1.0
Message-ID: <161503094104.398.1006229858374113985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     39a2a6eb5c9b66ea7c8055026303b3aa681b49a5
Gitweb:        https://git.kernel.org/tip/39a2a6eb5c9b66ea7c8055026303b3aa681b49a5
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 25 Feb 2021 17:56:56 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
