Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2154F33F45D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhCQPtV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhCQPsz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:55 -0400
Date:   Wed, 17 Mar 2021 15:48:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izDthQ637yPB2Yls5FK42zQpV9M1ewAP01SVYxGXsdQ=;
        b=ZatGjM9zxczBFsrkBHBw6VmexolNKPlB0lXzSwBvJnNZdAZV22ZxJGq0b25YzL1pwaRtPn
        bJd9OCMZ+i4GE6oW88AJ9hCt4SSS/3z7QJ+a5lc5clOfNstovH3/bAl6sjiV0wx7f+3ZZe
        5ui4mWafQsxfRAzfJ1jQffsjAAzMqqUzarOXKlWdx3y6EsnPhW8o564Pkk6elckguM3vH/
        aG1hK3ZQwYH1iSPO6dZJZKWJFUBgDePJpNsM8IsIvDDGne7enYoyM2Nu4YbSPvIUtEkuXQ
        Ixkssqq8ltK82kdBjBl9qboxjW6/KPG0w7MDJEzUsLGsLzqajYv71GUN5ZUbSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izDthQ637yPB2Yls5FK42zQpV9M1ewAP01SVYxGXsdQ=;
        b=14rlHcQeldODDAtq6UxdpEeNfo+jDx3MXVybUuVrKXM/JQgswBxLIVhsYb8gIQVjIwMahV
        6uvuDfJq+mMa6qAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Move various protections into inline helpers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309085727.310118772@linutronix.de>
References: <20210309085727.310118772@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613394.398.17554333538333616799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f02fc963e91160e7343933823e8b73a0b2ab0a16
Gitweb:        https://git.kernel.org/tip/f02fc963e91160e7343933823e8b73a0b2ab0a16
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:55:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:10 +01:00

softirq: Move various protections into inline helpers

To allow reuse of the bulk of softirq processing code for RT and to avoid
#ifdeffery all over the place, split protections for various code sections
out into inline helpers so the RT variant can just replace them in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309085727.310118772@linutronix.de

---
 kernel/softirq.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index f1eb83d..eaca333 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -207,6 +207,32 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void softirq_handle_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
+static inline void softirq_handle_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(in_interrupt());
+}
+
+static inline void ksoftirqd_run_begin(void)
+{
+	local_irq_disable();
+}
+
+static inline void ksoftirqd_run_end(void)
+{
+	local_irq_enable();
+}
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return true;
+}
+
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
@@ -319,7 +345,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
@@ -370,8 +396,7 @@ restart:
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	softirq_handle_end();
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -466,7 +491,7 @@ inline void raise_softirq_irqoff(unsigned int nr)
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt() && should_wake_ksoftirqd())
 		wakeup_softirqd();
 }
 
@@ -698,18 +723,18 @@ static int ksoftirqd_should_run(unsigned int cpu)
 
 static void run_ksoftirqd(unsigned int cpu)
 {
-	local_irq_disable();
+	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
 		__do_softirq();
-		local_irq_enable();
+		ksoftirqd_run_end();
 		cond_resched();
 		return;
 	}
-	local_irq_enable();
+	ksoftirqd_run_end();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
