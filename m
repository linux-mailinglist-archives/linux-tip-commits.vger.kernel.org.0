Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5B2B8F94
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgKSJzR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgKSJzM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA7C0613CF;
        Thu, 19 Nov 2020 01:55:12 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:55:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6App+KcX+r/jWBAsb55NuXVlCWquOXczy9PqAyZ7CY=;
        b=xG/ygSLV7WX8RhK/BADeg1HfN1qO88WpAmROBpO3VUvPqcagFGG/4WI44dbgdOaYAAOmDb
        OsrsfON8CAK52wBPXbqcuUwLpUKFsybw4k9Er0wwCcOFMU8wKvRrcEd8mo5e82VzPsD5pT
        ptN8cCG7ooVlk68aN59z6mmPyRBJBPVmZArUlylyRyr2TVi7xhU7g98iSD4BuoqnyR7k4U
        nWJMx9V48XpygbNGNXMc+Uy+vipfBjq/z+zLfdrLGp3V04A0wIs80rHGJP5DR23Yba3sQb
        QZfeZ4V0OfsrfJIxTRP0iZP9Rf3VSRccRSCkynk3o8fXFou3ssLfeT93rHgjCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6App+KcX+r/jWBAsb55NuXVlCWquOXczy9PqAyZ7CY=;
        b=4DT4f+R9TeX+TFXBL8Zo+myoOSU3FIPtWcR2x4aUDgQkLEe6uVNfdEGr1C4wN2I8hnzm23
        Roz1oUtdZ4VdzcBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Document protections for tick related data
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117132006.197713794@linutronix.de>
References: <20201117132006.197713794@linutronix.de>
MIME-Version: 1.0
Message-ID: <160577971028.11244.17384834287904608390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c398960cd82b233886fbff163986f998b5a5c008
Gitweb:        https://git.kernel.org/tip/c398960cd82b233886fbff163986f998b5a5c008
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Nov 2020 14:19:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 10:48:28 +01:00

tick: Document protections for tick related data

The protection rules for tick_next_period and last_jiffies_update are blury
at best. Clarify this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.197713794@linutronix.de

---
 kernel/time/tick-common.c | 4 +++-
 kernel/time/tick-sched.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 6c9c342..68504eb 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -27,7 +27,9 @@
  */
 DEFINE_PER_CPU(struct tick_device, tick_cpu_device);
 /*
- * Tick next event: keeps track of the tick time
+ * Tick next event: keeps track of the tick time. It's updated by the
+ * CPU which handles the tick and protected by jiffies_lock. There is
+ * no requirement to write hold the jiffies seqcount for it.
  */
 ktime_t tick_next_period;
 ktime_t tick_period;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81632cd..15360e6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -44,7 +44,9 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
- * The time, when the last jiffy update happened. Protected by jiffies_lock.
+ * The time, when the last jiffy update happened. Write access must hold
+ * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
+ * consistent view of jiffies and last_jiffies_update.
  */
 static ktime_t last_jiffies_update;
 
