Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7439BF70CF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2019 10:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKKJcr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 Nov 2019 04:32:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfKKJcr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 Nov 2019 04:32:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63m-00037x-7n; Mon, 11 Nov 2019 10:32:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB3A51C03AB;
        Mon, 11 Nov 2019 10:32:33 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:33 -0000
From:   "tip-bot2 for Zheng Yongjun" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Remove set but not used variable 'active'
Cc:     Hulk Robot <hulkci@huawei.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <mark.rutland@arm.com>,
        <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191110094453.113001-1-zhengyongjun3@huawei.com>
References: <20191110094453.113001-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Message-ID: <157346475356.29376.17366628370555604591.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8f05c1ff8bfb8cbae0898e5dc6791927d1e5c503
Gitweb:        https://git.kernel.org/tip/8f05c1ff8bfb8cbae0898e5dc6791927d1e5c503
Author:        Zheng Yongjun <zhengyongjun3@huawei.com>
AuthorDate:    Sun, 10 Nov 2019 17:44:53 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 08:31:55 +01:00

perf/x86/amd: Remove set but not used variable 'active'

'-Wunused-but-set-variable' triggers this warning:

  arch/x86/events/amd/core.c: In function amd_pmu_handle_irq:
  arch/x86/events/amd/core.c:656:6: warning: variable active set but not used [-Wunused-but-set-variable]

GCC is right, 'active' is not used anymore.

This variable was introduced earlier this year and then removed in:

  df4d29732fdad perf/x86/amd: Change/fix NMI latency mitigation to use a timestamp

[ mingo: Improved the changelog, fixed build warning caused by this fix, improved surrounding code. ]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Cc: <acme@kernel.org>
Cc: <alexander.shishkin@linux.intel.com>
Cc: <mark.rutland@arm.com>
Cc: <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191110094453.113001-1-zhengyongjun3@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 64c3e70..a7752cd 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -652,15 +652,7 @@ static void amd_pmu_disable_event(struct perf_event *event)
  */
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int active, handled;
-
-	/*
-	 * Obtain the active count before calling x86_pmu_handle_irq() since
-	 * it is possible that x86_pmu_handle_irq() may make a counter
-	 * inactive (through x86_pmu_stop).
-	 */
-	active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
+	int handled;
 
 	/* Process any counter overflows */
 	handled = x86_pmu_handle_irq(regs);
@@ -670,8 +662,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	 * NMIs will be claimed if arriving within that window.
 	 */
 	if (handled) {
-		this_cpu_write(perf_nmi_tstamp,
-			       jiffies + perf_nmi_window);
+		this_cpu_write(perf_nmi_tstamp, jiffies + perf_nmi_window);
 
 		return handled;
 	}
