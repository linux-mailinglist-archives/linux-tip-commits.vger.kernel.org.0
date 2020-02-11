Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A541B158F12
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2020 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgBKMsX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 11 Feb 2020 07:48:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46027 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgBKMr4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1UxF-0007b9-6A; Tue, 11 Feb 2020 13:47:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CAFA61C2019;
        Tue, 11 Feb 2020 13:47:47 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:47 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Annotate curr pointer in rq with __rcu
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200201125803.20245-1-madhuparnabhowmik10@gmail.com>
References: <20200201125803.20245-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Message-ID: <158142526758.411.13426115731353964686.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4104a562e0ca62e971089db9d3c47794a0d7d4eb
Gitweb:        https://git.kernel.org/tip/4104a562e0ca62e971089db9d3c47794a0d7d4eb
Author:        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
AuthorDate:    Sat, 01 Feb 2020 18:28:03 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:00:37 +01:00

sched/core: Annotate curr pointer in rq with __rcu

This patch fixes the following sparse warnings in sched/core.c
and sched/membarrier.c:

  kernel/sched/core.c:2372:27: error: incompatible types in comparison expression
  kernel/sched/core.c:4061:17: error: incompatible types in comparison expression
  kernel/sched/core.c:6067:9: error: incompatible types in comparison expression
  kernel/sched/membarrier.c:108:21: error: incompatible types in comparison expression
  kernel/sched/membarrier.c:177:21: error: incompatible types in comparison expression
  kernel/sched/membarrier.c:243:21: error: incompatible types in comparison expression

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200201125803.20245-1-madhuparnabhowmik10@gmail.com
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5876e6b..9ea6478 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -896,7 +896,7 @@ struct rq {
 	 */
 	unsigned long		nr_uninterruptible;
 
-	struct task_struct	*curr;
+	struct task_struct __rcu	*curr;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
