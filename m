Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1318A288224
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgJIGfL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgJIGfL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56652C0613D2;
        Thu,  8 Oct 2020 23:35:11 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rmTRUsdoWtb+yIEc12aTcbetcWajKGyAKKNK1ugCU7M=;
        b=njQ8Oxm1WHnBenv89LJ33g3J7BFgbEifxqmPkruNwERdXV80t3fwiqdRjIDVMxHEDmCqzq
        92/SnH5J3lLoGsVm0yVG61XzJBQotecA0Mw6YKwDLeYJ4DY83gWKpB459qnA6YwunNLDWC
        W/Qv97DDQFGII5EpsjEK3zo375av4PAlSTuu94aJ2y5uHmYNWol5QKbmlJawKVMGewNYDf
        D4fdfmaupxRlilicV2ZVjr3magjizRTJovbJt7AefNQlebS3P5FNTwZmfcjOJ8Zk1UaPmJ
        HMUuktQdUV1Zosg3sKVC97/0UaaM5roalmwX1wBngfZ1PmdxbvKYVmXyKMUXRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rmTRUsdoWtb+yIEc12aTcbetcWajKGyAKKNK1ugCU7M=;
        b=IGlBvmhJvH8SYHPADtUKVQ6kJzap0Zv8HVYtkzOnIp9xTrbINPQb/iCGo72jLZp85wcz6L
        3rmBnRyJBw+IZoCg==
From:   "tip-bot2 for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] smp: Make symbol 'csd_bug_count' static
Cc:     Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222530770.7002.13737992899322117558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2b722160f1a7929f38dfb648c7bbb45f96e65a5b
Gitweb:        https://git.kernel.org/tip/2b722160f1a7929f38dfb648c7bbb45f96e65a5b
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Mon, 06 Jul 2020 21:49:41 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 04 Sep 2020 11:53:12 -07:00

smp: Make symbol 'csd_bug_count' static

The sparse tool complains as follows:

kernel/smp.c:107:10: warning:
 symbol 'csd_bug_count' was not declared. Should it be static?

Because variable is not used outside of smp.c, this commit marks it
static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index c5d3188..b25383d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -106,7 +106,7 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
 
 #define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
-atomic_t csd_bug_count = ATOMIC_INIT(0);
+static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
 static void csd_lock_record(call_single_data_t *csd)
