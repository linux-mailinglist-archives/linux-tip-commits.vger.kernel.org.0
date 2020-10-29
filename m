Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3214529E9A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgJ2Kwi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgJ2Kvt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:49 -0400
Date:   Thu, 29 Oct 2020 10:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qa9Pius7PDYQS1Um0kXpuOHyJKGRkQwfzxxeZPnIRYk=;
        b=JXeM/IGP5iim1WnmlYJfk3SdCjYyCJ3KAXTHer1TR+BfszejaVAXXxjOF1A4TmJYeb+yd1
        cbPpNvtzeJ2Tu+I4ORvZ5m5xi1GTtru5M7pijIUd13pjSrOgqnXTFLYLCJ5wvuq8Yd9AgZ
        jxAWwruj0wPbvrNNQBT8WDHQ9JZfPYiKVj/YzrPxd7x77Vowd+a0+U0eKqnI7K4hWfgbu4
        HUe2F4m/qTmY4hZYIYbDOofDYJbFaY7I6lUEcYKx899iKnun5pGSh1cSG34E+Wx1O+0OK2
        GuSuXPPQOxuL5qdHmfbtbQTIfGolqwSmBu4fkPO4wL4hZPfCOUZbaty42EuMjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qa9Pius7PDYQS1Um0kXpuOHyJKGRkQwfzxxeZPnIRYk=;
        b=poKTBUN2b+/czTvbILyneL5yob0lcfcGMkEvA7wtxIlNUFTzW6kFC0UUuhPU/b8GJuS5Ig
        9KaUVdXE7PWQ5wCw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: membarrier: document memory ordering scenarios
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201020134715.13909-4-mathieu.desnoyers@efficios.com>
References: <20201020134715.13909-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <160396870620.397.14578688911290044946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     25595eb6aaa9fbb31330f1e0b400642694bc6574
Gitweb:        https://git.kernel.org/tip/25595eb6aaa9fbb31330f1e0b400642694bc6574
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 20 Oct 2020 09:47:15 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:31 +01:00

sched: membarrier: document memory ordering scenarios

Document membarrier ordering scenarios in membarrier.c. Thanks to Alan
Stern for refreshing my memory. Now that I have those in mind, it seems
appropriate to serialize them to comments for posterity.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201020134715.13909-4-mathieu.desnoyers@efficios.com
---
 kernel/sched/membarrier.c | 128 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index f223f35..5a40b38 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -7,6 +7,134 @@
 #include "sched.h"
 
 /*
+ * For documentation purposes, here are some membarrier ordering
+ * scenarios to keep in mind:
+ *
+ * A) Userspace thread execution after IPI vs membarrier's memory
+ *    barrier before sending the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the start of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU0 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU1 after the IPI-induced memory barrier:
+ *
+ *         CPU0                              CPU1
+ *
+ *         x = 1
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r2 = y
+ *                                           y = 1
+ *                                           barrier()
+ *                                           r1 = x
+ *
+ *                     BUG_ON(r1 == 0 && r2 == 0)
+ *
+ * The write to y and load from x by CPU1 are unordered by the hardware,
+ * so it's possible to have "r1 = x" reordered before "y = 1" at any
+ * point after (b).  If the memory barrier at (a) is omitted, then "x = 1"
+ * can be reordered after (a) (although not after (c)), so we get r1 == 0
+ * and r2 == 0.  This violates the guarantee that membarrier() is
+ * supposed by provide.
+ *
+ * The timing of the memory barrier at (a) has to ensure that it executes
+ * before the IPI-induced memory barrier on CPU1.
+ *
+ * B) Userspace thread execution before IPI vs membarrier's memory
+ *    barrier after completing the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the end of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU1 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU0 after the membarrier():
+ *
+ *         CPU0                              CPU1
+ *
+ *                                           x = 1
+ *                                           barrier()
+ *                                           y = 1
+ *         r2 = y
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r1 = x
+ *         BUG_ON(r1 == 0 && r2 == 1)
+ *
+ * The writes to x and y are unordered by the hardware, so it's possible to
+ * have "r2 = 1" even though the write to x doesn't execute until (b).  If
+ * the memory barrier at (c) is omitted then "r1 = x" can be reordered
+ * before (b) (although not before (a)), so we get "r1 = 0".  This violates
+ * the guarantee that membarrier() is supposed to provide.
+ *
+ * The timing of the memory barrier at (c) has to ensure that it executes
+ * after the IPI-induced memory barrier on CPU1.
+ *
+ * C) Scheduling userspace thread -> kthread -> userspace thread vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           d: switch to kthread (includes mb)
+ *           b: read rq->curr->mm == NULL
+ *                                           e: switch to user (includes mb)
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (e). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ *
+ * D) exit_mm vs membarrier
+ *
+ * Two thread groups are created, A and B.  Thread group B is created by
+ * issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
+ * Let's assume we have a single thread within each thread group (Thread A
+ * and Thread B).  Thread A runs on CPU0, Thread B runs on CPU1.
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *             a: smp_mb()
+ *                                           exit_mm():
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *             b: read rq->curr->mm == NULL
+ *             c: smp_mb()
+ *
+ * Using scenario (B), we can show that (c) needs to be paired with (d).
+ *
+ * E) kthread_{use,unuse}_mm vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           kthread_unuse_mm()
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *           b: read rq->curr->mm == NULL
+ *                                           kthread_use_mm()
+ *                                             f: current->mm = mm
+ *                                             g: smp_mb()
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (g). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ */
+
+/*
  * Bitmask made from a "or" of all commands within enum membarrier_cmd,
  * except MEMBARRIER_CMD_QUERY.
  */
