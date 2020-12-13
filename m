Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B204F2D8FE8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgLMTS1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391132AbgLMTDA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABCC0619DE;
        Sun, 13 Dec 2020 11:01:15 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Eor1ZbZTCQhTVwOGoaESGbcOgEitGbGGK9r923MDekQ=;
        b=MAvaNDIJ0JEZtmE1mkoCrXbaijMo2wK8m79wyZHyrSC+rw4NfIfDP/1fxM6E88oqqoOyDn
        zlHc6FPOdV+rfm8j6VwxiJ2vLOnyLcDsYYwKXmIJ726o1RsP4GbVvOEjl/Oea2Vaetbx1g
        rFH4ALc5Lh7m+px1JbDbLI6I1mDuIaNTgDat/UeJeptcK7EZy9y0eBXRSxK0+kKERmPmjz
        0S8CfZvcSplxo5hk+dfdv058EjVUzdngXA7oPep7i3Ert7ZgxSLatycwRctjxYsJ9gFjwH
        NfZDSaSOVylzHV25xP1YnblfXOQayaE7vUjaZya3pkOMzd/TvjxyD7jTwAPRtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Eor1ZbZTCQhTVwOGoaESGbcOgEitGbGGK9r923MDekQ=;
        b=L7QdidWG7+CSYnbOkS4qOTQDWSS7LFpov80BZXOTTAKMIW86VdU7IaEuJBferPGtS5uc5j
        lLXv40bTXqXlbvCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607194.3364.15032224502118959416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3fcd6a230fa7d03bffcb831a81b40435c146c12b
Gitweb:        https://git.kernel.org/tip/3fcd6a230fa7d03bffcb831a81b40435c146c12b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 03 Sep 2020 15:23:29 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 16:59:11 -08:00

x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs

Currently, accessing /proc/cpuinfo sends IPIs to idle CPUs in order to
learn their clock frequency.  Which is a bit strange, given that waking
them from idle likely significantly changes their clock frequency.
This commit therefore avoids sending /proc/cpuinfo-induced IPIs to
idle CPUs.

[ paulmck: Also check for idle in arch_freq_prepare_all(). ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/cpu/aperfmperf.c | 6 ++++++
 include/linux/rcutiny.h          | 2 ++
 include/linux/rcutree.h          | 1 +
 kernel/rcu/tree.c                | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index dd3261d..22911de 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
 #include <linux/sched/isolation.h>
+#include <linux/rcupdate.h>
 
 #include "cpu.h"
 
@@ -93,6 +94,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 		return 0;
 
+	if (rcu_is_idle_cpu(cpu))
+		return 0; /* Idle CPUs are completely uninteresting. */
+
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
 	return per_cpu(samples.khz, cpu);
 }
@@ -112,6 +116,8 @@ void arch_freq_prepare_all(void)
 	for_each_online_cpu(cpu) {
 		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 			continue;
+		if (rcu_is_idle_cpu(cpu))
+			continue; /* Idle CPUs are completely uninteresting. */
 		if (!aperfmperf_snapshot_cpu(cpu, now, false))
 			wait = true;
 	}
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7c1ecdb..2a97334 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -89,6 +89,8 @@ static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_preempt(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
+#define rcu_is_idle_cpu(cpu) \
+	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 59eb5cd..df578b7 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -50,6 +50,7 @@ void rcu_irq_exit(void);
 void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
+bool rcu_is_idle_cpu(int cpu);
 
 #ifdef CONFIG_PROVE_RCU
 void rcu_irq_exit_check_preempt(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef..1d84c0b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -341,6 +341,14 @@ static bool rcu_dynticks_in_eqs(int snap)
 	return !(snap & RCU_DYNTICK_CTRL_CTR);
 }
 
+/* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
+bool rcu_is_idle_cpu(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+}
+
 /*
  * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
