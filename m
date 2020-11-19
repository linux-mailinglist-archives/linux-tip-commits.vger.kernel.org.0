Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A482B8F8C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgKSJzK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgKSJzK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:10 -0500
Date:   Thu, 19 Nov 2020 09:55:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZUlvazKo7SUA8NIQ3s5W0oiDmaMb3Yh40+W+fnQCHU=;
        b=syJSbF0c6OWyE++vXHiDoz0xsxgC8rDoAN0K04K9DJvx4Q17/WlZRhYF5GHqU7DX+AUFk/
        tDJaIlCSWKw4bcA8mrebkf86zjAa1Z0smskQngyGR1TQigWyWh4kHhCAUgZEJ11r2MHzsI
        vwHZwVLL+emciVTbfVi5qsePEO07xEX8OVTh5zOLeDqK2jfmld4yoBCLy7Pr/HZDgTsvf+
        aVhLBPu6UxmAZ8yv3ZKuwEvRFy+nPvbbOukNvPZ3IySFZk7UYcLPIlxs/c2sU/gzE1tNpU
        bhGh74zB2nEXxumH4QNzXx9RpGzZPY+78IHLoWdMoLHLphwEicjJmGjaAXC1gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZUlvazKo7SUA8NIQ3s5W0oiDmaMb3Yh40+W+fnQCHU=;
        b=NtCrZ7kgBlOExckYmSIPJeSRyTObrcryD9MuKvB2CtgJ1BgiIvGbjU94x80KKNgazmHWmr
        7I+nTOg9rwrhroBw==
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Release seqcount before invoking
 calc_load_global()
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117132006.660902274@linutronix.de>
References: <20201117132006.660902274@linutronix.de>
MIME-Version: 1.0
Message-ID: <160577970772.11244.568999884653345712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     896b969e6732b68ee3c12ae4e1aeddf5db99bc46
Gitweb:        https://git.kernel.org/tip/896b969e6732b68ee3c12ae4e1aeddf5db99bc46
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Tue, 17 Nov 2020 14:19:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 10:48:29 +01:00

tick/sched: Release seqcount before invoking calc_load_global()

calc_load_global() does not need the sequence count protection.

[ tglx: Split it up properly and added comments ]

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.660902274@linutronix.de

---
 kernel/time/tick-sched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 306adeb..33c897b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -20,6 +20,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/nohz.h>
+#include <linux/sched/loadavg.h>
 #include <linux/module.h>
 #include <linux/irq_work.h>
 #include <linux/posix-timers.h>
@@ -107,7 +108,8 @@ static void tick_do_update_jiffies64(ktime_t now)
 						tick_period);
 	}
 
-	do_timer(ticks);
+	/* Advance jiffies to complete the jiffies_seq protected job */
+	jiffies_64 += ticks;
 
 	/*
 	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
@@ -116,7 +118,15 @@ static void tick_do_update_jiffies64(ktime_t now)
 	WRITE_ONCE(tick_next_period,
 		   ktime_add(last_jiffies_update, tick_period));
 
+	/*
+	 * Release the sequence count. calc_global_load() below is not
+	 * protected by it, but jiffies_lock needs to be held to prevent
+	 * concurrent invocations.
+	 */
 	write_seqcount_end(&jiffies_seq);
+
+	calc_global_load();
+
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
 }
