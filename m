Return-Path: <linux-tip-commits+bounces-4028-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92017A5491F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 12:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0AB188AE66
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1B20C016;
	Thu,  6 Mar 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lcb96Wol";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JC9PCGBt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82711FC7CC;
	Thu,  6 Mar 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259999; cv=none; b=BcdGaZ1f6FtrxEOeQD9LIarbqzQDAfgAzc7ksTXL6lJfpfRyM55Tr2jJIdgiI88r+WbwWfn40CsoMIINdrDpiucZ0/ENrCNxeFdHgefO8H1ZjVkeNyfCCNLAheo4i34ooF+9XX6gAFaWqTlgL4/u69nX4/4HFv+4d4jFviwQ4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259999; c=relaxed/simple;
	bh=3TT9dCB2AG4PRA+ywZXf2y5m2VM21RFqOYuAozM63qA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FukRI/7jLDPvK6/j8B7MkqNoCm+cROsXzUAQ0KNLbRNnmL8iXkDRsNotfF5QMyciK4x8CBL+2Qo6q9elnKUXczCt4/b1zN3JemzaQjXJgSxqGpK9xiIG8iIgcgIRX/8qLKBDsZW/x6XzLEoHKFgzsoHNKGyWTHfDbLfbTzzrDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lcb96Wol; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JC9PCGBt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 11:19:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741259995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOVES1WQTUzDDQAcydXUdBdqvXN85GIAIu26HbLvyYs=;
	b=Lcb96WollmySRCNQzhJ85//sr06CrwagpV5Qpb/x2Z12TrLuR7bq1jHoBf2eioSceUIvQf
	P5O4K7Ykgw6hSLH+LZFjw5RoDobfvmFjXjv2lgUCS3K6DJ9Q2G7Sr/YtYkRV6iUR9nqWx3
	+daHlVlaPG8DUdZO3cZ+XP+aDgOQvBQmNV6I0kfWzZRL+2TXZ4Zf3ksWCujgWn7lAcqnAs
	laZMuYeGwhdNN4hmH73qjsL7KrgOGffSkP9dS9l8U1sfQhsR7js5fQDMjG52dmoTN88Egk
	Mc/BzNt5zbQMLPRCmLs8e+U+GpyuaCjsL46pwCzkp4SBvLRqsiwRkDds2tebIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741259995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOVES1WQTUzDDQAcydXUdBdqvXN85GIAIu26HbLvyYs=;
	b=JC9PCGBtXZ7HTLDZJvYpP921XxEZCJSK5kLI5aMhD9GXdsRHUJKfwq+Sig0zyIs+Z/6qL1
	eR/RmH+dQ1CFgPDw==
From: "tip-bot2 for Li Huafei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] watchdog/hardlockup/perf: Fix perf_event memory leak
Cc: Li Huafei <lihuafei1@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241021193004.308303-1-lihuafei1@huawei.com>
References: <20241021193004.308303-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174125999490.14745.17183897343230864991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d6834d9c990333bfa433bc1816e2417f268eebbe
Gitweb:        https://git.kernel.org/tip/d6834d9c990333bfa433bc1816e2417f268eebbe
Author:        Li Huafei <lihuafei1@huawei.com>
AuthorDate:    Tue, 22 Oct 2024 03:30:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 12:05:33 +01:00

watchdog/hardlockup/perf: Fix perf_event memory leak

During stress-testing, we found a kmemleak report for perf_event:

  unreferenced object 0xff110001410a33e0 (size 1328):
    comm "kworker/4:11", pid 288, jiffies 4294916004
    hex dump (first 32 bytes):
      b8 be c2 3b 02 00 11 ff 22 01 00 00 00 00 ad de  ...;....".......
      f0 33 0a 41 01 00 11 ff f0 33 0a 41 01 00 11 ff  .3.A.....3.A....
    backtrace (crc 24eb7b3a):
      [<00000000e211b653>] kmem_cache_alloc_node_noprof+0x269/0x2e0
      [<000000009d0985fa>] perf_event_alloc+0x5f/0xcf0
      [<00000000084ad4a2>] perf_event_create_kernel_counter+0x38/0x1b0
      [<00000000fde96401>] hardlockup_detector_event_create+0x50/0xe0
      [<0000000051183158>] watchdog_hardlockup_enable+0x17/0x70
      [<00000000ac89727f>] softlockup_start_fn+0x15/0x40
      ...

Our stress test includes CPU online and offline cycles, and updating the
watchdog configuration.

After reading the code, I found that there may be a race between cleaning up
perf_event after updating watchdog and disabling event when the CPU goes offline:

  CPU0                          CPU1                           CPU2
  (update watchdog)                                            (hotplug offline CPU1)

  ...                                                          _cpu_down(CPU1)
  cpus_read_lock()                                             // waiting for cpu lock
    softlockup_start_all
      smp_call_on_cpu(CPU1)
                                softlockup_start_fn
                                ...
                                  watchdog_hardlockup_enable(CPU1)
                                    perf create E1
                                    watchdog_ev[CPU1] = E1
  cpus_read_unlock()
                                                               cpus_write_lock()
                                                               cpuhp_kick_ap_work(CPU1)
                                cpuhp_thread_fun
                                ...
                                  watchdog_hardlockup_disable(CPU1)
                                    watchdog_ev[CPU1] = NULL
                                    dead_event[CPU1] = E1
  __lockup_detector_cleanup
    for each dead_events_mask
      release each dead_event
      /*
       * CPU1 has not been added to
       * dead_events_mask, then E1
       * will not be released
       */
                                    CPU1 -> dead_events_mask
    cpumask_clear(&dead_events_mask)
    // dead_events_mask is cleared, E1 is leaked

In this case, the leaked perf_event E1 matches the perf_event leak
reported by kmemleak. Due to the low probability of problem recurrence
(only reported once), I added some hack delays in the code:

  static void __lockup_detector_reconfigure(void)
  {
    ...
          watchdog_hardlockup_start();
          cpus_read_unlock();
  +       mdelay(100);
          /*
           * Must be called outside the cpus locked section to prevent
           * recursive locking in the perf code.
    ...
  }

  void watchdog_hardlockup_disable(unsigned int cpu)
  {
    ...
                  perf_event_disable(event);
                  this_cpu_write(watchdog_ev, NULL);
                  this_cpu_write(dead_event, event);
  +               mdelay(100);
                  cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
                  atomic_dec(&watchdog_cpus);
    ...
  }

  void hardlockup_detector_perf_cleanup(void)
  {
    ...
                          perf_event_release_kernel(event);
                  per_cpu(dead_event, cpu) = NULL;
          }
  +       mdelay(100);
          cpumask_clear(&dead_events_mask);
  }

Then, simultaneously performing CPU on/off and switching watchdog, it is
almost certain to reproduce this leak.

The problem here is that releasing perf_event is not within the CPU
hotplug read-write lock. Commit:

  941154bd6937 ("watchdog/hardlockup/perf: Prevent CPU hotplug deadlock")

introduced deferred release to solve the deadlock caused by calling
get_online_cpus() when releasing perf_event. Later, commit:

  efe951d3de91 ("perf/x86: Fix perf,x86,cpuhp deadlock")

removed the get_online_cpus() call on the perf_event release path to solve
another deadlock problem.

Therefore, it is now possible to move the release of perf_event back
into the CPU hotplug read-write lock, and release the event immediately
after disabling it.

Fixes: 941154bd6937 ("watchdog/hardlockup/perf: Prevent CPU hotplug deadlock")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241021193004.308303-1-lihuafei1@huawei.com
---
 include/linux/nmi.h    |  4 ----
 kernel/cpu.c           |  5 -----
 kernel/watchdog.c      | 25 -------------------------
 kernel/watchdog_perf.c | 28 +---------------------------
 4 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index a8dfb38..e78fa53 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -17,7 +17,6 @@
 void lockup_detector_init(void);
 void lockup_detector_retry_init(void);
 void lockup_detector_soft_poweroff(void);
-void lockup_detector_cleanup(void);
 
 extern int watchdog_user_enabled;
 extern int watchdog_thresh;
@@ -37,7 +36,6 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
-static inline void lockup_detector_cleanup(void) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -104,12 +102,10 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
-extern void hardlockup_detector_perf_cleanup(void);
 extern void hardlockup_config_perf_event(const char *str);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
-static inline void hardlockup_detector_perf_cleanup(void) { }
 static inline void hardlockup_config_perf_event(const char *str) { }
 #endif
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07455d2..ad755db 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1453,11 +1453,6 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 
 out:
 	cpus_write_unlock();
-	/*
-	 * Do post unplug cleanup. This is still protected against
-	 * concurrent CPU hotplug via cpu_add_remove_lock.
-	 */
-	lockup_detector_cleanup();
 	arch_smt_update();
 	return ret;
 }
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b2da7de..1815602 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -347,8 +347,6 @@ static int __init watchdog_thresh_setup(char *str)
 }
 __setup("watchdog_thresh=", watchdog_thresh_setup);
 
-static void __lockup_detector_cleanup(void);
-
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
 enum stats_per_group {
 	STATS_SYSTEM,
@@ -886,11 +884,6 @@ static void __lockup_detector_reconfigure(void)
 
 	watchdog_hardlockup_start();
 	cpus_read_unlock();
-	/*
-	 * Must be called outside the cpus locked section to prevent
-	 * recursive locking in the perf code.
-	 */
-	__lockup_detector_cleanup();
 }
 
 void lockup_detector_reconfigure(void)
@@ -940,24 +933,6 @@ static inline void lockup_detector_setup(void)
 }
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
-static void __lockup_detector_cleanup(void)
-{
-	lockdep_assert_held(&watchdog_mutex);
-	hardlockup_detector_perf_cleanup();
-}
-
-/**
- * lockup_detector_cleanup - Cleanup after cpu hotplug or sysctl changes
- *
- * Caller must not hold the cpu hotplug rwsem.
- */
-void lockup_detector_cleanup(void)
-{
-	mutex_lock(&watchdog_mutex);
-	__lockup_detector_cleanup();
-	mutex_unlock(&watchdog_mutex);
-}
-
 /**
  * lockup_detector_soft_poweroff - Interface to stop lockup detector(s)
  *
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 59c1d86..2fdb96e 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -21,8 +21,6 @@
 #include <linux/perf_event.h>
 
 static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
-static DEFINE_PER_CPU(struct perf_event *, dead_event);
-static struct cpumask dead_events_mask;
 
 static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
@@ -181,37 +179,13 @@ void watchdog_hardlockup_disable(unsigned int cpu)
 
 	if (event) {
 		perf_event_disable(event);
+		perf_event_release_kernel(event);
 		this_cpu_write(watchdog_ev, NULL);
-		this_cpu_write(dead_event, event);
-		cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
 		atomic_dec(&watchdog_cpus);
 	}
 }
 
 /**
- * hardlockup_detector_perf_cleanup - Cleanup disabled events and destroy them
- *
- * Called from lockup_detector_cleanup(). Serialized by the caller.
- */
-void hardlockup_detector_perf_cleanup(void)
-{
-	int cpu;
-
-	for_each_cpu(cpu, &dead_events_mask) {
-		struct perf_event *event = per_cpu(dead_event, cpu);
-
-		/*
-		 * Required because for_each_cpu() reports  unconditionally
-		 * CPU0 as set on UP kernels. Sigh.
-		 */
-		if (event)
-			perf_event_release_kernel(event);
-		per_cpu(dead_event, cpu) = NULL;
-	}
-	cpumask_clear(&dead_events_mask);
-}
-
-/**
  * hardlockup_detector_perf_stop - Globally stop watchdog events
  *
  * Special interface for x86 to handle the perf HT bug.

