Return-Path: <linux-tip-commits+bounces-3567-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1EFA3F6D1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A093B7A21A6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9B1F3FE2;
	Fri, 21 Feb 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xoIGTI8R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBiR1rKh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5A204C02;
	Fri, 21 Feb 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146783; cv=none; b=LzfWway6ID1Yd+JyCDMuu3kfitk4BPCxGpyan5VbiG+cuH3PM15PrmJA6SMFRRDNjCug8ADRFP1dl1vO1HnbtR5AuOJQE3Ky3bSiEVSIIe0RsV+zLm2rBZvw+MKwcLwE9385JuA4cxrvH4lVHqiS2VJ3GzK/pbQzca7kxxPQ5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146783; c=relaxed/simple;
	bh=ft6WYPIhpb61Ha568Ut9PMPIYetGzfCFn8mEl62ZaLc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KJ+d+s38wRYfY0OqJoG7yfNBKzMQu35COlGg5IWXM1InGwo8dLO2H6ivi+j9gNpad0iVzk0khUcv9OHUlvBwfJ0qKYn9xCx02KGYJLywxTAeJ8O6SV2wxIZdacNOt7TvogK2MQqJE43jACWminm67nXTf2xacsiUUCdz4lhUTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xoIGTI8R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBiR1rKh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 14:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740146773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWWeahjM+fpoznf//d6TVmE3vmG16Wmeio+LX3LQBaQ=;
	b=xoIGTI8Ry50xkLh7fCVle7/QrGWyZa6x0zfnDhGKFob8XUijANkhvE75bUJinOCAOyDcpO
	rMq0d4RRT+lcj0ibB1GfiixfilJXIJKfe6hfZiMzJVzA+Hgz9ChKLN3amtuYzXgK4hmrtT
	zQDfJ+yoUJtG/Ykg91ibvrUQOdbrQIJoV0m33N41gVO3N4lCtRADDfY1Zk+ANNfw8tBybU
	F9/6hd3kTeboW30Yx3RoXkeBQ7WLuZuYfqDB4yXuV/KdADtYurC6ft6LBJ53F1nzsG3LeB
	eKSwdTwddIbsckVLodYMQRwjuNAMLGVagcO3D8raRDQy/lDnIMml7PkLITrZZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740146773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWWeahjM+fpoznf//d6TVmE3vmG16Wmeio+LX3LQBaQ=;
	b=lBiR1rKhOVZ4d+KqjlDUk3dbDNdgUGp7EIZsEINkX4TdHj1Fpb+m/PW18s86ad8MrJvhM2
	flz9IT6U/VcrnsAg==
From: "tip-bot2 for Joel Granados" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Move perf_event sysctls into kernel/events
Cc: Joel Granados <joel.granados@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250218-jag-mv_ctltables-v1-5-cd3698ab8d29@kernel.org>
References: <20250218-jag-mv_ctltables-v1-5-cd3698ab8d29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014677034.10177.14884250079507564395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8aeacf257070469ff78a998a968a61d0cadc0de3
Gitweb:        https://git.kernel.org/tip/8aeacf257070469ff78a998a968a61d0cadc0de3
Author:        Joel Granados <joel.granados@kernel.org>
AuthorDate:    Tue, 18 Feb 2025 10:56:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 14:53:02 +01:00

perf/core: Move perf_event sysctls into kernel/events

Move ctl tables to two files:

 - perf_event_{paranoid,mlock_kb,max_sample_rate} and
   perf_cpu_time_max_percent into kernel/events/core.c

 - perf_event_max_{stack,context_per_stack} into
   kernel/events/callchain.c

Make static variables and functions that are fully contained in core.c
and callchain.cand remove them from include/linux/perf_event.h.
Additionally six_hundred_forty_kb is moved to callchain.c.

Two new sysctl tables are added ({callchain,events_core}_sysctl_table)
with their respective sysctl registration functions.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kerenel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250218-jag-mv_ctltables-v1-5-cd3698ab8d29@kernel.org
---
 include/linux/perf_event.h |  9 +-----
 kernel/events/callchain.c  | 38 ++++++++++++++++++----
 kernel/events/core.c       | 57 +++++++++++++++++++++++++++++----
 kernel/sysctl.c            | 64 +-------------------------------------
 4 files changed, 83 insertions(+), 85 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d07bc1..c4525ba 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1652,19 +1652,10 @@ static inline int perf_callchain_store(struct perf_callchain_entry_ctx *ctx, u64
 }
 
 extern int sysctl_perf_event_paranoid;
-extern int sysctl_perf_event_mlock;
 extern int sysctl_perf_event_sample_rate;
-extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
-int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int perf_event_max_stack_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-
 /* Access to perf_event_open(2) syscall. */
 #define PERF_SECURITY_OPEN		0
 
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 8a47e52..6c83ad6 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -22,6 +22,7 @@ struct callchain_cpus_entries {
 
 int sysctl_perf_event_max_stack __read_mostly = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack __read_mostly = PERF_MAX_CONTEXTS_PER_STACK;
+static const int six_hundred_forty_kb = 640 * 1024;
 
 static inline size_t perf_callchain_entry__sizeof(void)
 {
@@ -266,12 +267,8 @@ exit_put:
 	return entry;
 }
 
-/*
- * Used for sysctl_perf_event_max_stack and
- * sysctl_perf_event_max_contexts_per_stack.
- */
-int perf_event_max_stack_handler(const struct ctl_table *table, int write,
-				 void *buffer, size_t *lenp, loff_t *ppos)
+static int perf_event_max_stack_handler(const struct ctl_table *table, int write,
+					void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *value = table->data;
 	int new_value = *value, ret;
@@ -292,3 +289,32 @@ int perf_event_max_stack_handler(const struct ctl_table *table, int write,
 
 	return ret;
 }
+
+static const struct ctl_table callchain_sysctl_table[] = {
+	{
+		.procname	= "perf_event_max_stack",
+		.data		= &sysctl_perf_event_max_stack,
+		.maxlen		= sizeof(sysctl_perf_event_max_stack),
+		.mode		= 0644,
+		.proc_handler	= perf_event_max_stack_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&six_hundred_forty_kb,
+	},
+	{
+		.procname	= "perf_event_max_contexts_per_stack",
+		.data		= &sysctl_perf_event_max_contexts_per_stack,
+		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
+		.mode		= 0644,
+		.proc_handler	= perf_event_max_stack_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_THOUSAND,
+	},
+};
+
+static int __init init_callchain_sysctls(void)
+{
+	register_sysctl_init("kernel", callchain_sysctl_table);
+	return 0;
+}
+core_initcall(init_callchain_sysctls);
+
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0f8c559..45ad0f6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -452,8 +452,8 @@ static struct kmem_cache *perf_event_cache;
  */
 int sysctl_perf_event_paranoid __read_mostly = 2;
 
-/* Minimum for 512 kiB + 1 user control page */
-int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' kiB per user */
+/* Minimum for 512 kiB + 1 user control page. 'free' kiB per user. */
+static int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024);
 
 /*
  * max perf event sample rate
@@ -463,6 +463,7 @@ int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' 
 #define DEFAULT_CPU_TIME_MAX_PERCENT	25
 
 int sysctl_perf_event_sample_rate __read_mostly	= DEFAULT_MAX_SAMPLE_RATE;
+static int sysctl_perf_cpu_time_max_percent __read_mostly = DEFAULT_CPU_TIME_MAX_PERCENT;
 
 static int max_samples_per_tick __read_mostly	= DIV_ROUND_UP(DEFAULT_MAX_SAMPLE_RATE, HZ);
 static int perf_sample_period_ns __read_mostly	= DEFAULT_SAMPLE_PERIOD_NS;
@@ -484,7 +485,7 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
-int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
+static int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -506,9 +507,7 @@ int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
 	return 0;
 }
 
-int sysctl_perf_cpu_time_max_percent __read_mostly = DEFAULT_CPU_TIME_MAX_PERCENT;
-
-int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
+static int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
@@ -528,6 +527,52 @@ int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
 	return 0;
 }
 
+static const struct ctl_table events_core_sysctl_table[] = {
+	/*
+	 * User-space relies on this file as a feature check for
+	 * perf_events being enabled. It's an ABI, do not remove!
+	 */
+	{
+		.procname	= "perf_event_paranoid",
+		.data		= &sysctl_perf_event_paranoid,
+		.maxlen		= sizeof(sysctl_perf_event_paranoid),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "perf_event_mlock_kb",
+		.data		= &sysctl_perf_event_mlock,
+		.maxlen		= sizeof(sysctl_perf_event_mlock),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "perf_event_max_sample_rate",
+		.data		= &sysctl_perf_event_sample_rate,
+		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
+		.mode		= 0644,
+		.proc_handler	= perf_event_max_sample_rate_handler,
+		.extra1		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "perf_cpu_time_max_percent",
+		.data		= &sysctl_perf_cpu_time_max_percent,
+		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
+		.mode		= 0644,
+		.proc_handler	= perf_cpu_time_max_percent_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+};
+
+static int __init init_events_core_sysctls(void)
+{
+	register_sysctl_init("kernel", events_core_sysctl_table);
+	return 0;
+}
+core_initcall(init_events_core_sysctls);
+
+
 /*
  * perf samples are done in some very critical code paths (NMIs).
  * If they take too much CPU time, the system can lock up and not
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb57da4..4484cdb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -54,7 +54,6 @@
 #include <linux/acpi.h>
 #include <linux/reboot.h>
 #include <linux/ftrace.h>
-#include <linux/perf_event.h>
 #include <linux/oom.h>
 #include <linux/kmod.h>
 #include <linux/capability.h>
@@ -91,12 +90,6 @@ EXPORT_SYMBOL_GPL(sysctl_long_vals);
 #if defined(CONFIG_SYSCTL)
 
 /* Constants used for minimum and maximum */
-
-#ifdef CONFIG_PERF_EVENTS
-static const int six_hundred_forty_kb = 640 * 1024;
-#endif
-
-
 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
@@ -1933,63 +1926,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_PERF_EVENTS
-	/*
-	 * User-space scripts rely on the existence of this file
-	 * as a feature check for perf_events being enabled.
-	 *
-	 * So it's an ABI, do not remove!
-	 */
-	{
-		.procname	= "perf_event_paranoid",
-		.data		= &sysctl_perf_event_paranoid,
-		.maxlen		= sizeof(sysctl_perf_event_paranoid),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "perf_event_mlock_kb",
-		.data		= &sysctl_perf_event_mlock,
-		.maxlen		= sizeof(sysctl_perf_event_mlock),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "perf_event_max_sample_rate",
-		.data		= &sysctl_perf_event_sample_rate,
-		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
-		.mode		= 0644,
-		.proc_handler	= perf_event_max_sample_rate_handler,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "perf_cpu_time_max_percent",
-		.data		= &sysctl_perf_cpu_time_max_percent,
-		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
-		.mode		= 0644,
-		.proc_handler	= perf_cpu_time_max_percent_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "perf_event_max_stack",
-		.data		= &sysctl_perf_event_max_stack,
-		.maxlen		= sizeof(sysctl_perf_event_max_stack),
-		.mode		= 0644,
-		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&six_hundred_forty_kb,
-	},
-	{
-		.procname	= "perf_event_max_contexts_per_stack",
-		.data		= &sysctl_perf_event_max_contexts_per_stack,
-		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
-		.mode		= 0644,
-		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
-	},
-#endif
 	{
 		.procname	= "panic_on_warn",
 		.data		= &panic_on_warn,

