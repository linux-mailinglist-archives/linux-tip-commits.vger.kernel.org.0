Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0651C1D14
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 May 2020 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgEASXX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 May 2020 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730655AbgEASWZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 May 2020 14:22:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E2FC08E934;
        Fri,  1 May 2020 11:22:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIa-0003XS-P2; Fri, 01 May 2020 20:22:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C4B81C0450;
        Fri,  1 May 2020 20:22:08 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:08 -0000
From:   "tip-bot2 for Muchun Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Mark sched_init_granularity __init
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200406074750.56533-1-songmuchun@bytedance.com>
References: <20200406074750.56533-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Message-ID: <158835732841.8414.7492668002654800060.tip-bot2@tip-bot2>
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

Commit-ID:     f38f12d1e0811c0ee59260b2bdadedf99e16c4af
Gitweb:        https://git.kernel.org/tip/f38f12d1e0811c0ee59260b2bdadedf99e16c4af
Author:        Muchun Song <songmuchun@bytedance.com>
AuthorDate:    Mon, 06 Apr 2020 15:47:50 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:41 +02:00

sched/fair: Mark sched_init_granularity __init

Function sched_init_granularity() is only called from __init
functions, so mark it __init as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20200406074750.56533-1-songmuchun@bytedance.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fac5b2f..cd7fd7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -191,7 +191,7 @@ static void update_sysctl(void)
 #undef SET_SYSCTL
 }
 
-void sched_init_granularity(void)
+void __init sched_init_granularity(void)
 {
 	update_sysctl();
 }
