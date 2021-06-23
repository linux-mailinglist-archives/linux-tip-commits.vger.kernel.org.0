Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782F63B159B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFWIV3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhFWIV2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7166C061574;
        Wed, 23 Jun 2021 01:19:10 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvmuNRkHNMpJnMr2xeAn53Js5Ahjs2Qmz5REv6aVmj8=;
        b=o936KJfLFXUfGKavuwzuAb7UkxX+RAC9Gt8afzUIGQEhcjoXjZRXhLasKbgpKRD7yJtkHC
        RgGhU9cquWM72OE8hEMDIB0yWXYkMR78qy78t57zd4Zd4nfkzmCZAk6rBEbfyblIODur7N
        sktBYtsCAuy/UB9oxtqKeUXhX90AiDtnj23IPZ8IsLKrfQSVGk/5teo+XfS+tplhKzCxC4
        7DLFiXCBzZAInkovmhEgjr+1VrGY5vi6PASkprcH/WCQYIHjn3/1Mb8VJOj8zDJPiRLHVC
        vkrstb4krj0RazyfVneL49K1EwJ/wP/aWoGI/PVFBZGUSeVnjv4JtNjurd3BrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvmuNRkHNMpJnMr2xeAn53Js5Ahjs2Qmz5REv6aVmj8=;
        b=AYtgg3YxrTdgo8pTxCWgZlicJz0lyYuSluxqBvDgRysvshAlvEzrdYhWM9YWaNMfKo6ESo
        Y65dRg0WCh1nxnDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftest: Remove wait-type RCU_CALLBACK tests
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210617190313.384290291@infradead.org>
References: <20210617190313.384290291@infradead.org>
MIME-Version: 1.0
Message-ID: <162443634758.395.13143299842597952033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1a8122960484b19d8d887fb32e1cf42be5647533
Gitweb:        https://git.kernel.org/tip/1a8122960484b19d8d887fb32e1cf42be5647533
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 17 Jun 2021 20:57:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:08 +02:00

lockdep/selftest: Remove wait-type RCU_CALLBACK tests

The problem is that rcu_callback_map doesn't have wait_types defined,
and doing so would make it indistinguishable from SOFTIRQ in any case.
Remove it.

Fixes: 9271a40d2a14 ("lockdep/selftest: Add wait context selftests")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20210617190313.384290291@infradead.org
---
 lib/locking-selftest.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index af12e84..161108e 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2494,16 +2494,6 @@ static void rcu_sched_exit(int *_)
 	int rcu_sched_guard_##name __guard(rcu_sched_exit);	\
 	rcu_read_lock_sched();
 
-static void rcu_callback_exit(int *_)
-{
-	rcu_lock_release(&rcu_callback_map);
-}
-
-#define RCU_CALLBACK_CONTEXT(name, ...)					\
-	int rcu_callback_guard_##name __guard(rcu_callback_exit);	\
-	rcu_lock_acquire(&rcu_callback_map);
-
-
 static void raw_spinlock_exit(raw_spinlock_t **lock)
 {
 	raw_spin_unlock(*lock);
@@ -2560,8 +2550,6 @@ static void __maybe_unused inner##_in_##outer(void)				\
  * ---------------+-------+----------+------+-------
  * RCU_BH         |   o   |    o     |  o   |  x
  * ---------------+-------+----------+------+-------
- * RCU_CALLBACK   |   o   |    o     |  o   |  x
- * ---------------+-------+----------+------+-------
  * RCU_SCHED      |   o   |    o     |  x   |  x
  * ---------------+-------+----------+------+-------
  * RAW_SPIN       |   o   |    o     |  x   |  x
@@ -2578,7 +2566,6 @@ GENERATE_2_CONTEXT_TESTCASE(NOTTHREADED_HARDIRQ, , inner, inner_lock)		\
 GENERATE_2_CONTEXT_TESTCASE(SOFTIRQ, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RCU, , inner, inner_lock)				\
 GENERATE_2_CONTEXT_TESTCASE(RCU_BH, , inner, inner_lock)			\
-GENERATE_2_CONTEXT_TESTCASE(RCU_CALLBACK, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RCU_SCHED, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RAW_SPINLOCK, raw_lock_A, inner, inner_lock)	\
 GENERATE_2_CONTEXT_TESTCASE(SPINLOCK, lock_A, inner, inner_lock)		\
@@ -2640,10 +2627,6 @@ static void wait_context_tests(void)
 	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_BH);
 	pr_cont("\n");
 
-	print_testname("in RCU callback context");
-	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_CALLBACK);
-	pr_cont("\n");
-
 	print_testname("in RCU-sched context");
 	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(RCU_SCHED);
 	pr_cont("\n");
