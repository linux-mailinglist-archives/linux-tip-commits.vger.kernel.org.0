Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD6F3FA1F4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 01:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhH0Xyb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Aug 2021 19:54:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhH0Xya (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Aug 2021 19:54:30 -0400
Date:   Fri, 27 Aug 2021 23:53:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630108420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGfAgSq6CIx8/O/To3qMVWyUz3TUwXxuvDbFv2NHKkY=;
        b=2+MLHYpCHonatSssKCa3RX0SR9oPW3kHycY6L9eT8ylFy4Dcu6vprYO56zsXKVBojm822g
        wMPl6otNrBvCzaJ1kV2ppRfXAuxLFXvibt18QQu56Wy5Bk7QdYz7ZbE770RSHX0lu+jbSc
        ae41WJ0B7fUE9faXzW3c6IcDCdfUefNhz6Y+lOCBAzQOzISK6Lz80wgZ9cwZvQCeqvlWRh
        uHKGohs8IU0d//CrFaAWg5hSDaRbam8Dr+4PN+TjXXdzTkH4+32AYTyRlhN9L6frhbPzpU
        JFCb0Qq1TJjGy6JtYOLgMIsSrFUJ6LcPmvWBGNbrAg3+NOvPoXEXvTntfA2vhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630108420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGfAgSq6CIx8/O/To3qMVWyUz3TUwXxuvDbFv2NHKkY=;
        b=wdWOKF7VzCLpEnHgL2FQyBjnsjIB/s0/uy/tFhpOISrZRkeXI/03ySgu6i97Sumcamn4ye
        wXuWRG43YQ/ntMCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] mm: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-21-bigeasy@linutronix.de>
References: <20210803141621.780504-21-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163010841892.25758.5911986436398501642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     7625eccd1852ac84d3aa6a06ffc2f710e683b3fe
Gitweb:        https://git.kernel.org/tip/7625eccd1852ac84d3aa6a06ffc2f710e683b3fe
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Aug 2021 01:46:17 +02:00

mm: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-21-bigeasy@linutronix.de

---
 mm/swap_slots.c |  4 ++--
 mm/vmstat.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index a66f3e0..16f706c 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -70,9 +70,9 @@ void disable_swap_slots_cache_lock(void)
 	swap_slot_cache_enabled = false;
 	if (swap_slot_cache_initialized) {
 		/* serialize with cpu hotplug operations */
-		get_online_cpus();
+		cpus_read_lock();
 		__drain_swap_slots_cache(SLOTS_CACHE|SLOTS_CACHE_RET);
-		put_online_cpus();
+		cpus_read_unlock();
 	}
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e0..a7ed56a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -129,9 +129,9 @@ static void sum_vm_events(unsigned long *ret)
 */
 void all_vm_events(unsigned long *ret)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	sum_vm_events(ret);
-	put_online_cpus();
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(all_vm_events);
 
@@ -1948,7 +1948,7 @@ static void vmstat_shepherd(struct work_struct *w)
 {
 	int cpu;
 
-	get_online_cpus();
+	cpus_read_lock();
 	/* Check processors whose vmstat worker threads have been disabled */
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
@@ -1958,7 +1958,7 @@ static void vmstat_shepherd(struct work_struct *w)
 
 		cond_resched();
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 
 	schedule_delayed_work(&shepherd,
 		round_jiffies_relative(sysctl_stat_interval));
@@ -2037,9 +2037,9 @@ void __init init_mm_internals(void)
 	if (ret < 0)
 		pr_err("vmstat: failed to register 'online' hotplug state\n");
 
-	get_online_cpus();
+	cpus_read_lock();
 	init_cpu_node_state();
-	put_online_cpus();
+	cpus_read_unlock();
 
 	start_shepherd_timer();
 #endif
