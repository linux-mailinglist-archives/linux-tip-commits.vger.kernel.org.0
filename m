Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83041F062
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354857AbhJAPH1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354817AbhJAPHV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A78C06177D;
        Fri,  1 Oct 2021 08:05:32 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKlMeS8Jo2ZcEsmpT/cTgE4jbp9L+K/qPgo1YqDdxUQ=;
        b=ZFcVAbz8VflBM1bFnD+q2EmF0qfCa2pWKrMUOQVr+q4N7v7Wp/Z/W7H/r4xtcueQTH7vJI
        QTyymaiproHQ8Wj5KdjMghXoVchROO9YeWFp6ZeAB2AZVm4wzuwgPTZSo7qnUEjKxm9lQQ
        vkVMaVeZMgcKaczp+Wa7ylnF2cfuJNqqWT5MlMN1+ZB5024T1XbDS7JBW/pFyeE3sOhrYt
        tyXCLS8jiqmOLNyqvZ4LbnlLlBpF733k5F9NFXBn1el5l6akTs1tdS6+hKS5G/8O0u+fqg
        sp24ThlinlbuNK9e2qilWWL5C0CjRAv17gAfsk6tegpszAlnH4+/zIRaqGf/Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKlMeS8Jo2ZcEsmpT/cTgE4jbp9L+K/qPgo1YqDdxUQ=;
        b=wJKS08jEPaUYjaPfviZn4KutpICrlLe+HQ9krIWNVGAhz6Uk2XW87Bm31HAnrkDTXX7/tz
        quvKxQ0Sfx7LypAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Make might_sleep() output less confusing
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165358.181022656@linutronix.de>
References: <20210923165358.181022656@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310073036.25758.18393889629938340016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8d713b699e84aade6b64e241a35f22e166fc8174
Gitweb:        https://git.kernel.org/tip/8d713b699e84aade6b64e241a35f22e166fc8174
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:50 +02:00

sched: Make might_sleep() output less confusing

might_sleep() output is pretty informative, but can be confusing at times
especially with PREEMPT_RCU when the check triggers due to a voluntary
sleep inside a RCU read side critical section:

 BUG: sleeping function called from invalid context at kernel/test.c:110
 in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 Preemption disabled at: migrate_disable+0x33/0xa0

in_atomic() is 0, but it still tells that preemption was disabled at
migrate_disable(), which is completely useless because preemption is not
disabled. But the interesting information to decode the above, i.e. the RCU
nesting depth, is not printed.

That becomes even more confusing when might_sleep() is invoked from
cond_resched_lock() within a RCU read side critical section. Here the
expected preemption count is 1 and not 0.

 BUG: sleeping function called from invalid context at kernel/test.c:131
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 Preemption disabled at: test_cond_lock+0xf3/0x1c0

So in_atomic() is set, which is expected as the caller holds a spinlock,
but it's unclear why this is broken and the preempt disable IP is just
pointing at the correct place, i.e. spin_lock(), which is obviously not
helpful either.

Make that more useful in general:

 - Print preempt_count() and the expected value

and for the CONFIG_PREEMPT_RCU case:

 - Print the RCU read side critical section nesting depth

 - Print the preempt disable IP only when preempt count
   does not have the expected value.

So the might_sleep() dump from a within a preemptible RCU read side
critical section becomes:

 BUG: sleeping function called from invalid context at kernel/test.c:110
 in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 preempt_count: 0, expected: 0
 RCU nest depth: 1, expected: 0

and the cond_resched_lock() case becomes:

 BUG: sleeping function called from invalid context at kernel/test.c:141
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 preempt_count: 1, expected: 1
 RCU nest depth: 1, expected: 0

which makes is pretty obvious what's going on. For all other cases the
preempt disable IP is still printed as before:

 BUG: sleeping function called from invalid context at kernel/test.c: 156
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
 preempt_count: 1, expected: 0
 RCU nest depth: 0, expected: 0
 Preemption disabled at:
 [<ffffffff82b48326>] test_might_sleep+0xbe/0xf8

 BUG: sleeping function called from invalid context at kernel/test.c: 163
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
 preempt_count: 1, expected: 0
 RCU nest depth: 1, expected: 0
 Preemption disabled at:
 [<ffffffff82b48326>] test_might_sleep+0x1e4/0x280

This also prepares to provide a better debugging output for RT enabled
kernels and their spinlock substitutions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165358.181022656@linutronix.de
---
 kernel/sched/core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7c6069..0a27cb8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9493,6 +9493,18 @@ void __might_sleep(const char *file, int line)
 }
 EXPORT_SYMBOL(__might_sleep);
 
+static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_PREEMPT))
+		return;
+
+	if (preempt_count() == preempt_offset)
+		return;
+
+	pr_err("Preemption disabled at:");
+	print_ip_sym(KERN_ERR, ip);
+}
+
 void __might_resched(const char *file, int line, int preempt_offset)
 {
 	/* Ratelimiting timestamp: */
@@ -9521,6 +9533,13 @@ void __might_resched(const char *file, int line, int preempt_offset)
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
+	pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
+	       preempt_offset);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+		pr_err("RCU nest depth: %d, expected: 0\n",
+		       rcu_preempt_depth());
+	}
 
 	if (task_stack_end_corrupted(current))
 		pr_emerg("Thread overran stack, or stack corrupted\n");
@@ -9528,11 +9547,9 @@ void __might_resched(const char *file, int line, int preempt_offset)
 	debug_show_held_locks(current);
 	if (irqs_disabled())
 		print_irqtrace_events(current);
-	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)
-	    && !preempt_count_equals(preempt_offset)) {
-		pr_err("Preemption disabled at:");
-		print_ip_sym(KERN_ERR, preempt_disable_ip);
-	}
+
+	print_preempt_disable_ip(preempt_offset, preempt_disable_ip);
+
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
