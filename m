Return-Path: <linux-tip-commits+bounces-3140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B29A9FC182
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1E7164F22
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F921325F;
	Tue, 24 Dec 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXf5056V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7VsUgrae"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E61213244;
	Tue, 24 Dec 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066484; cv=none; b=kBS1Xeo77I4LOMBI0hlyW13l/j4mhGabQ89njl2P2KUkaW5b8+mr/6IlT1XPcw3NkVeaXbYgj5KVLm6Ie58TWKeuWwJ7RNKCWMbGQKophMMbyxWyG9AQM/Goge/61o7jPzaXcM3J4k3XxbYceCVSw7MTTyKFgacwcnFcZt6wyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066484; c=relaxed/simple;
	bh=NzzGZ4UxZO1bOuTBAwadAibQ2gID+QL2r8QPSM3n1SQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kjWy+s0rxnPNgcj/pzcx4cz2Je/oeys6H5IcPkQIwhc9r5ytEKK+A3dZt5W+h0AZJj91oSn97T7pGBq8dgKAh+Tnu8DBHrlNWn+MNZXzCkJTvUZs6mQrAbRCN2sQphnyQWQp+nUZOfl2Zv9griIyYXHRgs/b74IVOUNYBO3LMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXf5056V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7VsUgrae; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoXSJjTwCMrTl6S+VWaw/PmtE81VpVibSRZWGZUh2Qc=;
	b=WXf5056Vx24BCaDRXV2vKkDrTSriktfLuizrsTg3n0gFusNCuBHZ5rkw9CmoQpsH4GF1o/
	Qn7JsMlAL0Ei9vzzFcVHTGY0+aRvY5w7Zqqe2Okf8SOJAFv8S+fB9mxX6+cua1e9WgAlld
	+/HTgHz5hJmjR5kaVciappdNR/iiHXCoIjPOaVpC4i0XTTlR9Ac4GfXoiJyzb4EyAc+aH6
	N2pouvUUMahTL4rlzRsvAAgSnnOWQosKLFpiHnAHn9v79Y018Xo8MBMMeWThx88xpRCcV7
	zkelD9rUTsFK3a1BU/p3w+kERRNfJ0xn3qxWfi9RsguhnAXMD3sQm1icAPJbNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoXSJjTwCMrTl6S+VWaw/PmtE81VpVibSRZWGZUh2Qc=;
	b=7VsUgraeKfOP6O9rbQ/0pkJzSHZh9uPJ906cxlywvsdhHHTVNUVqddo5F1FEwrmwOo5jxm
	gcoBx7Ph3Op+O/CA==
From: "tip-bot2 for Swapnil Sapkal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Report the different kinds of imbalances in
 /proc/schedstat
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220063224.17767-4-swapnil.sapkal@amd.com>
References: <20241220063224.17767-4-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506648048.399.1263453588174769917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3b2a793ea70fd14136b442df31e53935e8095034
Gitweb:        https://git.kernel.org/tip/3b2a793ea70fd14136b442df31e53935e8095034
Author:        Swapnil Sapkal <swapnil.sapkal@amd.com>
AuthorDate:    Fri, 20 Dec 2024 06:32:21 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:17 +01:00

sched: Report the different kinds of imbalances in /proc/schedstat

In /proc/schedstat, lb_imbalance reports the sum of imbalances
discovered in sched domains with each call to sched_balance_rq(), which is
not very useful because lb_imbalance does not mention whether the imbalance
is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
from /proc/schedstat.

Currently there is no field in /proc/schedstat to report different types
of imbalances. Introduce new fields in /proc/schedstat to report the
total imbalances in load, utilization, nr_tasks or misfit_tasks.

Added fields to /proc/schedstat:
        - lb_imbalance_load: Total imbalance due to load.
        - lb_imbalance_util: Total imbalance due to utilization.
        - lb_imbalance_task: Total imbalance due to number of tasks.
        - lb_imbalance_misfit: Total imbalance due to misfit tasks.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20241220063224.17767-4-swapnil.sapkal@amd.com
---
 include/linux/sched/topology.h |  5 ++++-
 kernel/sched/fair.c            | 24 +++++++++++++++++++++++-
 kernel/sched/stats.c           |  7 +++++--
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 4237daa..76a662e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -114,7 +114,10 @@ struct sched_domain {
 	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_failed[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_balanced[CPU_MAX_IDLE_TYPES];
-	unsigned int lb_imbalance[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_load[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_util[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_task[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_imbalance_misfit[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_gained[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_hot_gained[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_nobusyg[CPU_MAX_IDLE_TYPES];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5c0c61..b3418b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11705,6 +11705,28 @@ static int should_we_balance(struct lb_env *env)
 	return group_balance_cpu(sg) == env->dst_cpu;
 }
 
+static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd,
+				     enum cpu_idle_type idle)
+{
+	if (!schedstat_enabled())
+		return;
+
+	switch (env->migration_type) {
+	case migrate_load:
+		__schedstat_add(sd->lb_imbalance_load[idle], env->imbalance);
+		break;
+	case migrate_util:
+		__schedstat_add(sd->lb_imbalance_util[idle], env->imbalance);
+		break;
+	case migrate_task:
+		__schedstat_add(sd->lb_imbalance_task[idle], env->imbalance);
+		break;
+	case migrate_misfit:
+		__schedstat_add(sd->lb_imbalance_misfit[idle], env->imbalance);
+		break;
+	}
+}
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -11755,7 +11777,7 @@ redo:
 
 	WARN_ON_ONCE(busiest == env.dst_rq);
 
-	schedstat_add(sd->lb_imbalance[idle], env.imbalance);
+	update_lb_imbalance_stat(&env, sd, idle);
 
 	env.src_cpu = busiest->cpu;
 	env.src_rq = busiest;
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index eb0cdcd..802bd93 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -141,11 +141,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
 			seq_printf(seq, "domain%d %*pb", dcount++,
 				   cpumask_pr_args(sched_domain_span(sd)));
 			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u",
+				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
 				    sd->lb_count[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
-				    sd->lb_imbalance[itype],
+				    sd->lb_imbalance_load[itype],
+				    sd->lb_imbalance_util[itype],
+				    sd->lb_imbalance_task[itype],
+				    sd->lb_imbalance_misfit[itype],
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],

