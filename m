Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6B1A9825
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Apr 2020 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635934AbgDOJO0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Apr 2020 05:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635933AbgDOJOZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Apr 2020 05:14:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4DC061A0C;
        Wed, 15 Apr 2020 02:14:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOe7g-00057l-OP; Wed, 15 Apr 2020 11:14:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 20FFC1C0081;
        Wed, 15 Apr 2020 11:14:20 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:14:19 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/vtime: Work around an unitialized variable warning
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327214334.GF8015@zn.tnic>
References: <20200327214334.GF8015@zn.tnic>
MIME-Version: 1.0
Message-ID: <158694205962.28353.1365613618253108237.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e0d648f9d883ec1efab261af158d73aa30e9dd12
Gitweb:        https://git.kernel.org/tip/e0d648f9d883ec1efab261af158d73aa30e9dd12
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 27 Mar 2020 22:43:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 15 Apr 2020 11:06:50 +02:00

sched/vtime: Work around an unitialized variable warning

Work around this warning:

  kernel/sched/cputime.c: In function ‘kcpustat_field’:
  kernel/sched/cputime.c:1007:6: warning: ‘val’ may be used uninitialized in this function [-Wmaybe-uninitialized]

because GCC can't see that val is used only when err is 0.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200327214334.GF8015@zn.tnic
---
 kernel/sched/cputime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index dac9104..ff9435d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1003,12 +1003,12 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 		   enum cpu_usage_stat usage, int cpu)
 {
 	u64 *cpustat = kcpustat->cpustat;
+	u64 val = cpustat[usage];
 	struct rq *rq;
-	u64 val;
 	int err;
 
 	if (!vtime_accounting_enabled_cpu(cpu))
-		return cpustat[usage];
+		return val;
 
 	rq = cpu_rq(cpu);
 
