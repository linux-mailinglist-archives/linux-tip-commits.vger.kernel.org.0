Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757636248E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhDPPyN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhDPPyH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:07 -0400
Date:   Fri, 16 Apr 2021 15:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B6Kvs/5k7Y3AGYLFl4UKY5yvYnlzyznWBSzi9t4oOQw=;
        b=dTem9veCXzyhVtGlCcQ8X+pFNzvbsT2oUlKVFPzXLFYar0gnvGo1T4aGGVTULNcpdiq3T0
        f301uI1f6t2GUFi9LHvGqZZrmh8zjZcmea+DpecIP/dSAOLr8PYdljUybnxvxJoRD7jlFj
        K6UgTRSeX7tKHDN4E1Kj41nDZF1aCuWP/HNQUcnYTwqLVwTVuRtTJooCDiNR4gsn0kY4WS
        VscFU/7QbXp8nb+ZNXxl8pua022qIWCXZ8Jsmq6EJNzW/1vbUzE7irh17ZhBRC135yn/cL
        8kgjCfyEhxicvGNw8d4PjBIJ+IFgDgAjNOmORmmiUjnTTvIWRctuk01UbURo2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B6Kvs/5k7Y3AGYLFl4UKY5yvYnlzyznWBSzi9t4oOQw=;
        b=Ymj1b4f/0l2g6UF3AvwctCJrh490Dsi4fchgK3txwD2GtDxigUassbxrTj5fLYBZBJNqOg
        H5pIFy/aYt+mAZBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Rename the sched_debug parameter to
 sched_verbose
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161858842031.29796.9498578394584791041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a1b93fc0377e73dd54f819a993f83291324bb54a
Gitweb:        https://git.kernel.org/tip/a1b93fc0377e73dd54f819a993f83291324bb54a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Apr 2021 18:23:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:35 +02:00

sched/debug: Rename the sched_debug parameter to sched_verbose

CONFIG_SCHED_DEBUG is the build-time Kconfig knob, the boot param
sched_debug and the /debug/sched/debug_enabled knobs control the
sched_debug_enabled variable, but what they really do is make
SCHED_DEBUG more verbose, so rename the lot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 Documentation/scheduler/sched-domains.rst       | 10 +++++-----
 kernel/sched/debug.c                            |  4 ++--
 kernel/sched/topology.c                         | 12 ++++++------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..9e4c026 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4725,7 +4725,7 @@
 
 	sbni=		[NET] Granch SBNI12 leased line adapter
 
-	sched_debug	[KNL] Enables verbose scheduler debug messages.
+	sched_verbose	[KNL] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
 			Allowed values are enable and disable. This feature
diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 8582fa5..14ea2f2 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -74,8 +74,8 @@ for a given topology level by creating a sched_domain_topology_level array and
 calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG and adding 'sched_debug' to your cmdline. If you forgot to
-tweak your cmdline, you can also flip the /sys/kernel/debug/sched_debug
-knob. This enables an error checking parse of the sched domains which should
-catch most possible errors (described above). It also prints out the domain
-structure in a visual format.
+CONFIG_SCHED_DEBUG and adding 'sched_debug_verbose' to your cmdline. If you
+forgot to tweak your cmdline, you can also flip the
+/sys/kernel/debug/sched/verbose knob. This enables an error checking parse of
+the sched domains which should catch most possible errors (described above). It
+also prints out the domain structure in a visual format.
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bf199d6..461342f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -275,7 +275,7 @@ static const struct file_operations sched_dynamic_fops = {
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
-__read_mostly bool sched_debug_enabled;
+__read_mostly bool sched_debug_verbose;
 
 static const struct seq_operations sched_debug_sops;
 
@@ -300,7 +300,7 @@ static __init int sched_init_debug(void)
 	debugfs_sched = debugfs_create_dir("sched", NULL);
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
-	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
+	debugfs_create_bool("verbose", 0644, debugfs_sched, &sched_debug_verbose);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c343aed..55a0a24 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -14,15 +14,15 @@ static cpumask_var_t sched_domains_tmpmask2;
 
 static int __init sched_debug_setup(char *str)
 {
-	sched_debug_enabled = true;
+	sched_debug_verbose = true;
 
 	return 0;
 }
-early_param("sched_debug", sched_debug_setup);
+early_param("sched_verbose", sched_debug_setup);
 
 static inline bool sched_debug(void)
 {
-	return sched_debug_enabled;
+	return sched_debug_verbose;
 }
 
 #define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
@@ -131,7 +131,7 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 {
 	int level = 0;
 
-	if (!sched_debug_enabled)
+	if (!sched_debug_verbose)
 		return;
 
 	if (!sd) {
@@ -152,7 +152,7 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 }
 #else /* !CONFIG_SCHED_DEBUG */
 
-# define sched_debug_enabled 0
+# define sched_debug_verbose 0
 # define sched_domain_debug(sd, cpu) do { } while (0)
 static inline bool sched_debug(void)
 {
@@ -2141,7 +2141,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
-	if (rq && sched_debug_enabled) {
+	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
 	}
