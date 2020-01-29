Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D568914C9AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jan 2020 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgA2LdT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jan 2020 06:33:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51125 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgA2LdQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlae-0007mI-Tt; Wed, 29 Jan 2020 12:33:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4762C1C1C1B;
        Wed, 29 Jan 2020 12:32:59 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:59 -0000
From:   "tip-bot2 for Wanpeng Li" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/nohz: Optimize get_nohz_timer_target()
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578876627-11938-1-git-send-email-wanpengli@tencent.com>
References: <1578876627-11938-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Message-ID: <158029757906.396.16628642864164316826.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: 1.5
X-Linutronix-Spam-Level: +
X-Linutronix-Spam-Status: No , 1.5 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_DBL_ABUSE_MALW=2.5
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e938b9c94164e4d981039f1cf6007d7453883e5a
Gitweb:        https://git.kernel.org/tip/e938b9c94164e4d981039f1cf6007d7453883e5a
Author:        Wanpeng Li <wanpengli@tencent.com>
AuthorDate:    Mon, 13 Jan 2020 08:50:27 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:36:57 +01:00

sched/nohz: Optimize get_nohz_timer_target()

On a machine, CPU 0 is used for housekeeping, the other 39 CPUs in the
same socket are in nohz_full mode. We can observe huge time burn in the
loop for seaching nearest busy housekeeper cpu by ftrace.

  2)               |                        get_nohz_timer_target() {
  2)   0.240 us    |                          housekeeping_test_cpu();
  2)   0.458 us    |                          housekeeping_test_cpu();

  ...

  2)   0.292 us    |                          housekeeping_test_cpu();
  2)   0.240 us    |                          housekeeping_test_cpu();
  2)   0.227 us    |                          housekeeping_any_cpu();
  2) + 43.460 us   |                        }

This patch optimizes the searching logic by finding a nearest housekeeper
CPU in the housekeeping cpumask, it can minimize the worst searching time
from ~44us to < 10us in my testing. In addition, the last iterated busy
housekeeper can become a random candidate while current CPU is a better
fallback if it is a housekeeper.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/1578876627-11938-1-git-send-email-wanpengli@tencent.com
---
 kernel/sched/core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55b9a9c..a8a5d5b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -552,27 +552,32 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu = smp_processor_id();
+	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
 
-	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		return cpu;
+	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
+		if (!idle_cpu(cpu))
+			return cpu;
+		default_cpu = cpu;
+	}
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
+		for_each_cpu_and(i, sched_domain_span(sd),
+			housekeeping_cpumask(HK_FLAG_TIMER)) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
+			if (!idle_cpu(i)) {
 				cpu = i;
 				goto unlock;
 			}
 		}
 	}
 
-	if (!housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	if (default_cpu == -1)
+		default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	cpu = default_cpu;
 unlock:
 	rcu_read_unlock();
 	return cpu;
