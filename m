Return-Path: <linux-tip-commits+bounces-6130-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8891EB07337
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6DDA4168F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EBC2F50BD;
	Wed, 16 Jul 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nC9usXmi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2dkwCKa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46A2F508B;
	Wed, 16 Jul 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661160; cv=none; b=UIxDXdlpnVaiBmNW/YumAxXl1sS6bmp9TCuBWyapT+S0F3zEr1Ee7oKuEdgdHnJWKmASJM4rKnDQ2Henjq2k9GDN5aB/0RKkgnTVojH5bW2Zp61QVQzq4pVdqyr68OGc37U25ro3WulLY3nYPmHHU4h/GrnHT9lbdg2z2KEs0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661160; c=relaxed/simple;
	bh=i24rPXtwcaXawT4X/488HCzdUqNOhRaP8nMMq/Tyi6c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rf4vyqsNFbLKmojhplPWb1gmUkzfjj0nd40DIhKApVno5EoP8nyiX+5wpRBv+FZXlDVd4Nqnv5pBKHhXIYeWTyJ/TAiu7gxZCz9uWamhpCic78+85HqVCx+sL8ji9ZUYpjnT2eEZBaGWt7XZ+EdixfK48toR3I+lIaiVmTcDXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nC9usXmi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2dkwCKa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsIev5yaufdyMDiGXRs7EMi2kHD84x6aZIVmnDxc/rs=;
	b=nC9usXmibuncwrN1UJTpondnUWj3SWn2BEH5r0nOONv09M7kuJkD6J8VoTmVQyerBC4+Cy
	YEizYLpUZpFWvl5PZ5JBsLYLSsXd+87OjgrJlqarsI8tuveGe8SatqqkdrAr27jyCLzwZJ
	TxHjJUB+zgmtsP5ya96RN7emUkPEqPOd0f/XNsfXVBvuyI6YPeBpvEICeqicrUXc+ksssH
	MAwqHbTioGEVWmZM50zB4PnZPdLyVlLiMw0lAjvPsK4sat8SS8ZkBZ8tnAFKZlUEoKY+KL
	YAQ0huwv+UvrQINvMZF6Z366rYuWP/nnJRrWiSRsHztoEs76wQSfKJU9AY4Gdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsIev5yaufdyMDiGXRs7EMi2kHD84x6aZIVmnDxc/rs=;
	b=A2dkwCKaZzTewk33lBgNBQb0zfIPleWUoaTXxFBytVnOruH3zCZJLswpIWgfbQGRbjDmCu
	qD6sCBe2BuQedPBQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument
 to enable/disable
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250712033407.2383110-2-jstultz@google.com>
References: <20250712033407.2383110-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266115435.406.15916021190678492115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     25c411fce735dda29de26f58d3fce52d4824380c
Gitweb:        https://git.kernel.org/tip/25c411fce735dda29de26f58d3fce52d4824380c
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Sat, 12 Jul 2025 03:33:42 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:31 +02:00

sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument to enable/disable

Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
sched_proxy_exec= that can be used to disable the feature at boot
time if CONFIG_SCHED_PROXY_EXEC was enabled.

Also uses this option to allow the rq->donor to be different from
rq->curr.

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250712033407.2383110-2-jstultz@google.com
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++-
 include/linux/sched.h                           | 13 +++++++-
 init/Kconfig                                    | 12 +++++++-
 kernel/sched/core.c                             | 29 ++++++++++++++++-
 kernel/sched/sched.h                            | 12 +++++++-
 5 files changed, 71 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba..00b8357 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6387,6 +6387,11 @@
 	sa1100ir	[NET]
 			See drivers/net/irda/sa1100_ir.c.
 
+	sched_proxy_exec= [KNL]
+			Enables or disables "proxy execution" style
+			solution to mutex-based priority inversion.
+			Format: <bool>
+
 	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 54a9126..f225b6b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1656,6 +1656,19 @@ struct task_struct {
 	randomized_struct_fields_end
 } __attribute__ ((aligned (64)));
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static inline bool sched_proxy_exec(void)
+{
+	return static_branch_likely(&__sched_proxy_exec);
+}
+#else
+static inline bool sched_proxy_exec(void)
+{
+	return false;
+}
+#endif
+
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
 
diff --git a/init/Kconfig b/init/Kconfig
index 965699c..24dd42d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -878,6 +878,18 @@ config UCLAMP_BUCKETS_COUNT
 
 	  If in doubt, use the default value.
 
+config SCHED_PROXY_EXEC
+	bool "Proxy Execution"
+	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
+	depends on !PREEMPT_RT
+	# Need to investigate how to inform sched_ext of split contexts
+	depends on !SCHED_CLASS_EXT
+	# Not particularly useful until we get to multi-rq proxying
+	depends on EXPERT
+	help
+	  This option enables proxy execution, a mechanism for mutex-owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9c8bda..dd9f5c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static int __init setup_proxy_exec(char *str)
+{
+	bool proxy_enable = true;
+
+	if (*str && kstrtobool(str + 1, &proxy_enable)) {
+		pr_warn("Unable to parse sched_proxy_exec=\n");
+		return 0;
+	}
+
+	if (proxy_enable) {
+		pr_info("sched_proxy_exec enabled via boot arg\n");
+		static_branch_enable(&__sched_proxy_exec);
+	} else {
+		pr_info("sched_proxy_exec disabled via boot arg\n");
+		static_branch_disable(&__sched_proxy_exec);
+	}
+	return 1;
+}
+#else
+static int __init setup_proxy_exec(char *str)
+{
+	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so it cannot be enabled or disabled at boot time\n");
+	return 0;
+}
+#endif
+__setup("sched_proxy_exec", setup_proxy_exec);
+
 /*
  * Debugging: various feature bits
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ac953fa..e53d0b8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1142,10 +1142,15 @@ struct rq {
 	 */
 	unsigned long 		nr_uninterruptible;
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	struct task_struct __rcu	*donor;  /* Scheduling context */
+	struct task_struct __rcu	*curr;   /* Execution context */
+#else
 	union {
 		struct task_struct __rcu *donor; /* Scheduler context */
 		struct task_struct __rcu *curr;  /* Execution context */
 	};
+#endif
 	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
@@ -1326,10 +1331,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
+{
+	rcu_assign_pointer(rq->donor, t);
+}
+#else
 static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
 {
 	/* Do nothing */
 }
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);

