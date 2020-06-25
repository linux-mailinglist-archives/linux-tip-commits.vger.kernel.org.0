Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9582D209DC4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Jun 2020 13:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404355AbgFYLxh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Jun 2020 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404352AbgFYLxg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04FC061573;
        Thu, 25 Jun 2020 04:53:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRY-0005pv-Au; Thu, 25 Jun 2020 13:53:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED3B51C0470;
        Thu, 25 Jun 2020 13:53:23 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:23 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove mmdrop() definition
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200618190810.790211-1-bigeasy@linutronix.de>
References: <20200618190810.790211-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <159308600375.16989.9629111920355709564.tip-bot2@tip-bot2>
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

Commit-ID:     01e377c539ca52a6c753d0fdbe93b3b8fcd66a1c
Gitweb:        https://git.kernel.org/tip/01e377c539ca52a6c753d0fdbe93b3b8fcd66a1c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 18 Jun 2020 21:08:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:45 +02:00

sched/core: Remove mmdrop() definition

Commit
   bf2c59fce4074 ("sched/core: Fix illegal RCU from offline CPUs")

introduced a definition for mmdrop() but a a few lines above there is
already mmdrop() defined as static inline.

Remove the newly introduced mmdrop() definition.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200618190810.790211-1-bigeasy@linutronix.de
---
 include/linux/sched/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 480a4d1..a98604e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,8 +49,6 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
-void mmdrop(struct mm_struct *mm);
-
 /*
  * This has to be called after a get_task_mm()/mmget_not_zero()
  * followed by taking the mmap_lock for writing before modifying the
