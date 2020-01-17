Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A01140763
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jan 2020 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAQKJB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jan 2020 05:09:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQKJA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jan 2020 05:09:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYZ-0005TI-GC; Fri, 17 Jan 2020 11:08:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B26671C19D3;
        Fri, 17 Jan 2020 11:08:42 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:42 -0000
From:   "tip-bot2 for Li Guanglei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix size of rq::uclamp initialization
Cc:     Li Guanglei <guanglei.li@unisoc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1577259844-12677-1-git-send-email-guangleix.li@gmail.com>
References: <1577259844-12677-1-git-send-email-guangleix.li@gmail.com>
MIME-Version: 1.0
Message-ID: <157925572248.396.13151894178940447793.tip-bot2@tip-bot2>
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

Commit-ID:     dcd6dffb0a75741471297724640733fa4e958d72
Gitweb:        https://git.kernel.org/tip/dcd6dffb0a75741471297724640733fa4e958d72
Author:        Li Guanglei <guanglei.li@unisoc.com>
AuthorDate:    Wed, 25 Dec 2019 15:44:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:20 +01:00

sched/core: Fix size of rq::uclamp initialization

rq::uclamp is an array of struct uclamp_rq, make sure we clear the
whole thing.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcountinga")
Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lkml.kernel.org/r/1577259844-12677-1-git-send-email-guangleix.li@gmail.com
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d0270b1..fc1dfc0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1253,7 +1253,8 @@ static void __init init_uclamp(void)
 	mutex_init(&uclamp_mutex);
 
 	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		memset(&cpu_rq(cpu)->uclamp, 0,
+				sizeof(struct uclamp_rq)*UCLAMP_CNT);
 		cpu_rq(cpu)->uclamp_flags = 0;
 	}
 
