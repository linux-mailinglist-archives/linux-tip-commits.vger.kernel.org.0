Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9BD17C074
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2020 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgCFOmW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Mar 2020 09:42:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgCFOmV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB5-0006Jv-QA; Fri, 06 Mar 2020 15:42:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0B24D1C21DB;
        Fri,  6 Mar 2020 15:42:08 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:07 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix kernel build warning in
 test_idle_cores() for !SMT NUMA
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200303110258.1092-3-mgorman@techsingularity.net>
References: <20200303110258.1092-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158350572776.28353.575560040960927128.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     76c389ab2b5e300698eab87f9d4b7916f14117ba
Gitweb:        https://git.kernel.org/tip/76c389ab2b5e300698eab87f9d4b7916f14117ba
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 03 Mar 2020 11:02:57 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:22 +01:00

sched/fair: Fix kernel build warning in test_idle_cores() for !SMT NUMA

Building against the tip/sched/core as ff7db0bf24db ("sched/numa: Prefer
using an idle CPU as a migration target instead of comparing tasks") with
the arm64 defconfig (which doesn't have CONFIG_SCHED_SMT set) leads to:

  kernel/sched/fair.c:1525:20: warning: 'test_idle_cores' declared 'static' but never defined [-Wunused-function]
   static inline bool test_idle_cores(int cpu, bool def);
		      ^~~~~~~~~~~~~~~

Rather than define it in its own CONFIG_SCHED_SMT #define island, bunch it
up with test_idle_cores().

Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
[mgorman@techsingularity.net: Edit changelog, minor style change]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
Link: https://lkml.kernel.org/r/20200303110258.1092-3-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 79bb423..bba9452 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1533,9 +1533,6 @@ static inline bool is_core_idle(int cpu)
 	return true;
 }
 
-/* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu, bool def);
-
 struct task_numa_env {
 	struct task_struct *p;
 
@@ -1571,9 +1568,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 	return node_fully_busy;
 }
 
+#ifdef CONFIG_SCHED_SMT
+/* Forward declarations of select_idle_sibling helpers */
+static inline bool test_idle_cores(int cpu, bool def);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
-#ifdef CONFIG_SCHED_SMT
 	if (!static_branch_likely(&sched_smt_present) ||
 	    idle_core >= 0 || !test_idle_cores(cpu, false))
 		return idle_core;
@@ -1584,10 +1583,15 @@ static inline int numa_idle_core(int idle_core, int cpu)
 	 */
 	if (is_core_idle(cpu))
 		idle_core = cpu;
-#endif
 
 	return idle_core;
 }
+#else
+static inline int numa_idle_core(int idle_core, int cpu)
+{
+	return idle_core;
+}
+#endif
 
 /*
  * Gather all necessary information to make NUMA balancing placement
