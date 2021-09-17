Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7440F8F3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhIQNSn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 09:18:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhIQNSm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 09:18:42 -0400
Date:   Fri, 17 Sep 2021 13:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631884639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YqRDUJteSJFBPKelOqsHztpFf8JBqeQncF6TCkWpu0=;
        b=362Nd8CZaPKif0cnvGAeO97HDmWT09qwzASrsx2SeiNpNNAHN1cK+9c6CS1Cdq5ZlTEZXe
        yebJSsQ/4QMLibyfNmR62Vc9hZjYSWj98OC9SIxARCH3UCD+alONcj+qr7vEHdz8UfGRyz
        08vXc6norkA2Ztbo5J1eQ22dWL0UiGjIiog6cOGp6p6Cc5vb3+viBVVfV9AII28/kkCAvS
        VHkBegVTNLiq+/joEM4TkhIeAj1UlIf9rppipDd7c2ZNlBfZC8IDnr0sXp/a1yoOB/dFWU
        Qcj+9+PMNKQvcAVKeht4Zo1zMZqGxEPCE1qRpRkMO1j/6ZWiqQXSUI+TMIHYaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631884639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YqRDUJteSJFBPKelOqsHztpFf8JBqeQncF6TCkWpu0=;
        b=xYSgF4VySwmFmhhRL3SXkPxJ8LND1klxhUoCj10awgkxmELl4wkV20pXUsvVo0dSbJe9Yh
        GrHDNLNEKL+1tjDw==
From:   "tip-bot2 for Zhouyi Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Improve comments in wait-type checks
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210811025920.20751-1-zhouzhouyi@gmail.com>
References: <20210811025920.20751-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Message-ID: <163188463897.25758.12154045033309013884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a2e05ddda11b0bd529f443df9089ab498b2c2642
Gitweb:        https://git.kernel.org/tip/a2e05ddda11b0bd529f443df9089ab498b2c2642
Author:        Zhouyi Zhou <zhouzhouyi@gmail.com>
AuthorDate:    Wed, 11 Aug 2021 10:59:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 15:08:45 +02:00

lockdep: Improve comments in wait-type checks

Comments in wait-type checks be improved by mentioning the
PREEPT_RT kernel configure option.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20210811025920.20751-1-zhouzhouyi@gmail.com
---
 include/linux/lockdep_types.h | 2 +-
 kernel/locking/lockdep.c      | 2 +-
 kernel/rcu/update.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 3e726ac..d224308 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -21,7 +21,7 @@ enum lockdep_wait_type {
 	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
-	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
+	LD_WAIT_CONFIG,		/* preemptible in PREEMPT_RT, spinlock_t etc.. */
 #else
 	LD_WAIT_CONFIG = LD_WAIT_SPIN,
 #endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bfa0a34..4e63129 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4671,7 +4671,7 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 /*
  * Verify the wait_type context.
  *
- * This check validates we takes locks in the right wait-type order; that is it
+ * This check validates we take locks in the right wait-type order; that is it
  * ensures that we do not take mutexes inside spinlocks and do not attempt to
  * acquire spinlocks inside raw_spinlocks and the sort.
  *
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38c..690b0ce 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -247,7 +247,7 @@ struct lockdep_map rcu_lock_map = {
 	.name = "rcu_read_lock",
 	.key = &rcu_lock_key,
 	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* XXX PREEMPT_RCU ? */
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT implies PREEMPT_RCU */
 };
 EXPORT_SYMBOL_GPL(rcu_lock_map);
 
@@ -256,7 +256,7 @@ struct lockdep_map rcu_bh_lock_map = {
 	.name = "rcu_read_lock_bh",
 	.key = &rcu_bh_lock_key,
 	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_LOCK also makes BH preemptible */
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
 };
 EXPORT_SYMBOL_GPL(rcu_bh_lock_map);
 
