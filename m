Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAABB1C1CF1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 May 2020 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgEASWN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 May 2020 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730460AbgEASWM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 May 2020 14:22:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A1C08E859;
        Fri,  1 May 2020 11:22:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIa-0003X6-73; Fri, 01 May 2020 20:22:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AD8C21C0085;
        Fri,  1 May 2020 20:22:07 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:07 -0000
From:   "tip-bot2 for Muchun Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use __this_cpu_read() in wake_wide()
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421144123.33580-1-songmuchun@bytedance.com>
References: <20200421144123.33580-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Message-ID: <158835732766.8414.17788678090839078001.tip-bot2@tip-bot2>
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

Commit-ID:     17c891ab349138e8d8a59ca2700f42ce8af96f4e
Gitweb:        https://git.kernel.org/tip/17c891ab349138e8d8a59ca2700f42ce8af96f4e
Author:        Muchun Song <songmuchun@bytedance.com>
AuthorDate:    Tue, 21 Apr 2020 22:41:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:41 +02:00

sched/fair: Use __this_cpu_read() in wake_wide()

The code is executed with preemption(and interrupts) disabled,
so it's safe to use __this_cpu_write().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421144123.33580-1-songmuchun@bytedance.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd7fd7e..46b7bd4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5718,7 +5718,7 @@ static int wake_wide(struct task_struct *p)
 {
 	unsigned int master = current->wakee_flips;
 	unsigned int slave = p->wakee_flips;
-	int factor = this_cpu_read(sd_llc_size);
+	int factor = __this_cpu_read(sd_llc_size);
 
 	if (master < slave)
 		swap(master, slave);
