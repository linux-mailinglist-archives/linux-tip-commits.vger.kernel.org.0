Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA12C37EDE5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbhELU4D (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:56:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbhELUDH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 16:03:07 -0400
Date:   Wed, 12 May 2021 20:01:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620849707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNNWCnyZavCf3oBct79KcydlQfuXDFo9EH5ShcvhKts=;
        b=3rFR8XODEUKo/2feK567qOIT+K/t5/A6an+RTnQIqqWwlb60qUnAhQPQUatgQNmVhYMIEe
        yGrz3abdHYjgZMeDGtoe+SzoybXxZXaDkVV8xdsawnvmh6MIW2LA7/NGfCiIQAAgZ31Z/O
        +3+/h0KUjGSgIHzudK9EAUSIblAgexny7HLl5BOai0/GxXqySstSZv+YUr9JhksHlBVek9
        G1rmBkVvf7t6Ij+OLgOzdoUTChmSQeEhuRQl8VXYSUytVM0odFb8AaJN5b1on9j2V+laEI
        wZ/CsChUtvx+/PNAK3e6fFJuedwqHph1fJLJSRWTp+i2RBP0E5Z3adjW+xLt5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620849707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNNWCnyZavCf3oBct79KcydlQfuXDFo9EH5ShcvhKts=;
        b=r+XnRm92U/KiCAqfaQ2zvnD/fY+zSixr1ck08d9rLpCZqhUK2PZ9FIR4jiFYsrN/tqonHP
        u9fv5HDPdmQWgXAA==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make nr_iowait_cpu() return 32-bit value
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422200228.1423391-3-adobriyan@gmail.com>
References: <20210422200228.1423391-3-adobriyan@gmail.com>
MIME-Version: 1.0
Message-ID: <162084970625.29796.535929681999700472.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8fc2858e572ce761bffcade81a42ac72005e76f9
Gitweb:        https://git.kernel.org/tip/8fc2858e572ce761bffcade81a42ac72005e76f9
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Thu, 22 Apr 2021 23:02:27 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 21:34:16 +02:00

sched: Make nr_iowait_cpu() return 32-bit value

Runqueue ->nr_iowait counters are 32-bit anyway.

Propagate 32-bitness into other code, but don't try too hard.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210422200228.1423391-3-adobriyan@gmail.com
---
 drivers/cpuidle/governors/menu.c | 6 +++---
 include/linux/sched/stat.h       | 2 +-
 kernel/sched/core.c              | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index c3aa8d6..2e56704 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -117,7 +117,7 @@ struct menu_device {
 	int		interval_ptr;
 };
 
-static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
+static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
 {
 	int bucket = 0;
 
@@ -150,7 +150,7 @@ static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
  * to be, the higher this multiplier, and thus the higher
  * the barrier to go to an expensive C state.
  */
-static inline int performance_multiplier(unsigned long nr_iowaiters)
+static inline int performance_multiplier(unsigned int nr_iowaiters)
 {
 	/* for IO wait tasks (per cpu!) we add 10x each */
 	return 1 + 10 * nr_iowaiters;
@@ -270,7 +270,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int predicted_us;
 	u64 predicted_ns;
 	u64 interactivity_req;
-	unsigned long nr_iowaiters;
+	unsigned int nr_iowaiters;
 	ktime_t delta, delta_tick;
 	int i, idx;
 
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 81d9b53..0108a38 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -20,7 +20,7 @@ extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned int nr_iowait(void);
-extern unsigned long nr_iowait_cpu(int cpu);
+extern unsigned int nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fadf2bf..24fd795 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4739,7 +4739,7 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned long nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_cpu(int cpu)
 {
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
