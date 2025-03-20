Return-Path: <linux-tip-commits+bounces-4408-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96695A6A201
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 10:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAD3BFBB6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE222422D;
	Thu, 20 Mar 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRV+pKPw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQiunrPu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706F22259F;
	Thu, 20 Mar 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461209; cv=none; b=tBYUG1fU5Q9mZT0fU2k84R4ji/+HbG0K+XcZn4pPcoi/W3eZFQ5NPRYcA8vfyAc2iSaqukWKRauc03TWmxrhKqgz1Mln5SEq4pQAa4pHnBkya52VFomTLx41vqGqnvMuKI+SR2X8rWoEV+gTVl6MWlWt/mzuh5IyTKgDHoeHC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461209; c=relaxed/simple;
	bh=rGAtucbfQDSgT6LiW6Xj82VpPFYolVmtdGWGiZ6WFOw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GJl/iyCkWYklYcqV/I4yYh8vDXTZDkSDWHlQDJeS2qqHUyeDBDJsAWIA0YS4iXCefK+iJUas6cC1ACgrJ3D3aZ/JeMrJbArwKxjH4YA4wahgaxFAalMdcWz4oPM/MEiX9d+RpGu6PGcHHZbZjOiBTVj5wILn6nuxsqv2zuY1CGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRV+pKPw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQiunrPu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 09:00:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742461204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVmd7kS88DNqB3EdhjOM0mStloNzIglBvTtFQAeQx88=;
	b=yRV+pKPwHZjUiQ5jGeHnQK1Kc9MlzpiS3HtCPXkulPBxL6CfQ2KpYwE5AwmOOgtpLG9/5U
	8pxJ0lepZh1A+pA2Q7fquZS5+NArCx4a5CEPMhupf8lgaxg0CnHsUXss/j83Mx7sq6WDKv
	4xpM3UPc/jnq7nucNjQ8azjsinJwD+r14kkmtPO+fBy1obrweLBBgfOfDB5W3JsDmSMyYn
	Sy2EfdQ3JNhuWwa4xZXJhFI9aWzjeeIyBIjtJ5i50VoDgC/pX1LLumqXBxlTR31HmlShii
	nAiKwKcGSh9w3C5sgPeXUEpii5c6Y+kH1tuUAgocZypjdrwsse4vGn8Mzaa0Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742461204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVmd7kS88DNqB3EdhjOM0mStloNzIglBvTtFQAeQx88=;
	b=kQiunrPuI0BKnt3LTx3fOWCyn9wFw/HAvzEQDyBKyLRGXMpYXAZKnpVBTyL3XkPOZnapUu
	9UCGrBlVJQzasgDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Make 'const_debug' tunables
 unconditional __read_mostly
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250317104257.3496611-3-mingo@kernel.org>
References: <20250317104257.3496611-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174246120330.14745.16501280562362931634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     57903f72f270a3deb9de408ac61001a3fd94bf2f
Gitweb:        https://git.kernel.org/tip/57903f72f270a3deb9de408ac61001a3fd94bf2f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 11:42:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 22:20:53 +01:00

sched/debug: Make 'const_debug' tunables unconditional __read_mostly

With CONFIG_SCHED_DEBUG becoming unconditional, remove the
extra 'const_debug' indirection towards __read_mostly.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250317104257.3496611-3-mingo@kernel.org
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/fair.c  |  2 +-
 kernel/sched/sched.h | 15 +++++----------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6f666b4..3589abc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -128,7 +128,7 @@ DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
  */
 #define SCHED_FEAT(name, enabled)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
-const_debug unsigned int sysctl_sched_features =
+__read_mostly unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
@@ -148,7 +148,7 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
-const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
+__read_mostly unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89609eb..35ee8d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -79,7 +79,7 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 unsigned int sysctl_sched_base_slice			= 700000ULL;
 static unsigned int normalized_sysctl_sched_base_slice	= 700000ULL;
 
-const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
+__read_mostly unsigned int sysctl_sched_migration_cost	= 500000UL;
 
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fadaabe..d8e4040 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2194,13 +2194,8 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 }
 
 /*
- * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
+ * Tunables:
  */
-#ifdef CONFIG_SCHED_DEBUG
-# define const_debug __read_mostly
-#else
-# define const_debug const
-#endif
 
 #define SCHED_FEAT(name, enabled)	\
 	__SCHED_FEAT_##name ,
@@ -2218,7 +2213,7 @@ enum {
  * To support run-time toggling of sched features, all the translation units
  * (but core.c) reference the sysctl_sched_features defined in core.c.
  */
-extern const_debug unsigned int sysctl_sched_features;
+extern __read_mostly unsigned int sysctl_sched_features;
 
 #ifdef CONFIG_JUMP_LABEL
 
@@ -2249,7 +2244,7 @@ extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
  */
 #define SCHED_FEAT(name, enabled)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
-static const_debug __maybe_unused unsigned int sysctl_sched_features =
+static __read_mostly __maybe_unused unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
@@ -2837,8 +2832,8 @@ extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
 # define SCHED_NR_MIGRATE_BREAK 32
 #endif
 
-extern const_debug unsigned int sysctl_sched_nr_migrate;
-extern const_debug unsigned int sysctl_sched_migration_cost;
+extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+extern __read_mostly unsigned int sysctl_sched_migration_cost;
 
 extern unsigned int sysctl_sched_base_slice;
 

