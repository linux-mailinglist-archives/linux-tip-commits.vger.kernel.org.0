Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9989C14C9B8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jan 2020 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgA2LdL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jan 2020 06:33:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51097 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgA2LdK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlaf-0007nW-Dw; Wed, 29 Jan 2020 12:33:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BDBB51C1C1A;
        Wed, 29 Jan 2020 12:32:59 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:59 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Reject negative values in cpu_uclamp_write()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200114210947.14083-1-qais.yousef@arm.com>
References: <20200114210947.14083-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158029757939.396.4291536552223438529.tip-bot2@tip-bot2>
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

Commit-ID:     b562d140649966d4daedd0483a8fe59ad3bb465a
Gitweb:        https://git.kernel.org/tip/b562d140649966d4daedd0483a8fe59ad3bb465a
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Tue, 14 Jan 2020 21:09:47 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:36:56 +01:00

sched/uclamp: Reject negative values in cpu_uclamp_write()

The check to ensure that the new written value into cpu.uclamp.{min,max}
is within range, [0:100], wasn't working because of the signed
comparison

 7301                 if (req.percent > UCLAMP_PERCENT_SCALE) {
 7302                         req.ret = -ERANGE;
 7303                         return req;
 7304                 }

	# echo -1 > cpu.uclamp.min
	# cat cpu.uclamp.min
	42949671.96

Cast req.percent into u64 to force the comparison to be unsigned and
work as intended in capacity_from_percent().

	# echo -1 > cpu.uclamp.min
	sh: write error: Numerical result out of range

Fixes: 2480c093130f ("sched/uclamp: Extend CPU's cgroup controller")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200114210947.14083-1-qais.yousef@arm.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4ff03c2..55b9a9c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7264,7 +7264,7 @@ capacity_from_percent(char *buf)
 					     &req.percent);
 		if (req.ret)
 			return req;
-		if (req.percent > UCLAMP_PERCENT_SCALE) {
+		if ((u64)req.percent > UCLAMP_PERCENT_SCALE) {
 			req.ret = -ERANGE;
 			return req;
 		}
