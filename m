Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B182EF63F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Jan 2021 18:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAHRKE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Jan 2021 12:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAHRKD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Jan 2021 12:10:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF756C061380;
        Fri,  8 Jan 2021 09:09:23 -0800 (PST)
Date:   Fri, 08 Jan 2021 17:09:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610125759;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ff9fNH+hT7ppLQ/Xd6Ur1chU2JR9vJx7pvGQ6v6tvaQ=;
        b=wPkRE4lPrXdRC7g7vL7Q7XYFhVwvdarI5uWU05R1GH5PGCtBMOjy0kpR1e2KKulcyzmpRC
        thcHH3voC6uhP3IuBWuNoOnHCP4+EI/FPEW3wr8/A6haUCFjELTDQFeeFdT5aYJCmj91f3
        lrWcKIw4610hvaJnZv9UbJzmcSjG+wyvWPwJZMpUTB4aX9ZOFXA3R/zh8/Aj+piYdFWufN
        XcDFCZEzwcwJ+Y1zQA9rYzcg0+E87OTf+8CDEwtuoIKXSCTh3kMapVMl6++1JMJU/96v57
        URe3I/e/qSj0irI+Lpi0PHJTg+GgwOXeNnGHEDZZZV5pGMYrShpSSi2IQrchlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610125759;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ff9fNH+hT7ppLQ/Xd6Ur1chU2JR9vJx7pvGQ6v6tvaQ=;
        b=pIrO6j0VvrFa5yuMO+iPjX8LqnmcSK1sMCHwY552NJ8dG5RAxbfnT9AX6oQkKySfVjWVaG
        qIbIbD/B0yC3fxCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Make mce_timed_out() identify holdout CPUs
Cc:     Jonathan Lemon <bsd@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210106174102.GA23874@paulmck-ThinkPad-P72>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Message-ID: <161012575824.414.16780348692116495179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     7bb39313cd6239e7eb95198950a02b4ad2a08316
Gitweb:        https://git.kernel.org/tip/7bb39313cd6239e7eb95198950a02b4ad2a08316
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 23 Dec 2020 17:04:19 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Jan 2021 18:00:09 +01:00

x86/mce: Make mce_timed_out() identify holdout CPUs

The

  "Timeout: Not all CPUs entered broadcast exception handler"

message will appear from time to time given enough systems, but this
message does not identify which CPUs failed to enter the broadcast
exception handler. This information would be valuable if available,
for example, in order to correlate with other hardware-oriented error
messages.

Add a cpumask of CPUs which maintains which CPUs have entered this
handler, and print out which ones failed to enter in the event of a
timeout.

 [ bp: Massage. ]

Reported-by: Jonathan Lemon <bsd@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20210106174102.GA23874@paulmck-ThinkPad-P72
---
 arch/x86/kernel/cpu/mce/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1c..6c81d09 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -878,6 +878,12 @@ static atomic_t mce_executing;
 static atomic_t mce_callin;
 
 /*
+ * Track which CPUs entered the MCA broadcast synchronization and which not in
+ * order to print holdouts.
+ */
+static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
+
+/*
  * Check if a timeout waiting for other CPUs happened.
  */
 static int mce_timed_out(u64 *t, const char *msg)
@@ -894,8 +900,12 @@ static int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1)
+		if (mca_cfg.tolerant <= 1) {
+			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
+				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
+					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
+		}
 		cpu_missing = 1;
 		return 1;
 	}
@@ -1006,6 +1016,7 @@ static int mce_start(int *no_way_out)
 	 * is updated before mce_callin.
 	 */
 	order = atomic_inc_return(&mce_callin);
+	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
 	/*
 	 * Wait for everyone.
@@ -1114,6 +1125,7 @@ static int mce_end(int order)
 reset:
 	atomic_set(&global_nwo, 0);
 	atomic_set(&mce_callin, 0);
+	cpumask_setall(&mce_missing_cpus);
 	barrier();
 
 	/*
@@ -2712,6 +2724,7 @@ static void mce_reset(void)
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);
 	atomic_set(&global_nwo, 0);
+	cpumask_setall(&mce_missing_cpus);
 }
 
 static int fake_panic_get(void *data, u64 *val)
