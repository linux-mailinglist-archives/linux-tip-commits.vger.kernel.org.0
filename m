Return-Path: <linux-tip-commits+bounces-3231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99347A11D4B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B97162BFA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82263242242;
	Wed, 15 Jan 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OFkRpi7w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtPikWzo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72C28EC73;
	Wed, 15 Jan 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932644; cv=none; b=qK7K1yWUWa88aTXWzZmsgD9BAKv4KOQO4L8goXCbmkSUHukMiWO1E3e6LubBZ1w2IOeZ+OcWqgAY9IbE9i5H1Lhm31SWXr4eYvvfGOqzObL26HnJQVcJzt9611VyBs7eif0OFVzyihZBf+872wBYrvDTdDoVIumzCAsQPcqoPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932644; c=relaxed/simple;
	bh=O6LI2HkqJAFdyeiZv4F0qCDOI9nMMCJQgys63ipHfUU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lTiJ8jAJEknkq2cklFcXuctKWfgCQpbWewbqznR6S1PKygdKlO6X2uy25SBNvRod15rd4B54XlHcy8etf9LtTYSKkknAyh1TpuYbngewXX86XWsYBK9/+gUFCPsRBicbp/hXIi4HH4nsgctOJWzXNVsaJXTIB+QDGMaWhy2FZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OFkRpi7w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OtPikWzo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urayvfIdbsqsK+qFY07tFrij5pcqHbfo48H4uIUZCcw=;
	b=OFkRpi7wXE8N7Y7KvG6Z18y25LPag+5JApXqLQD9O3e/JlYimpiGvBZFSozYoPyu/Zxled
	rbVC91ouxzOPVK61Dc9po9sFQE9w5fiJlfeMHTqz4JF/FfxtnSuLJSRV34FIV6i3xPPMsR
	ul5Upf6VGazZmefxX9SGucbjL5XpWHeUX3Phhb96oOILdmzKjMLi510D5s1JPhU9Hn9W9p
	k5H7OwmS/3scL2gEFQ/60+C55yIfztCw/0PiHhiWw3sopmh1u4mm4L3sHX58kiff1NY/Wu
	JszzeVO8hDgM4GBBwYFOBPRNTBvlPFYow14qumPBmV4oG+wcG4SR4f90zNrJkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urayvfIdbsqsK+qFY07tFrij5pcqHbfo48H4uIUZCcw=;
	b=OtPikWzorJ4ecUtiZBjwqktFdsncePVk7b0lbBput3wSivWmM5JiL3g4Kk3WRxGuvX8Iz0
	XsTVvUxyEogREnCQ==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Encapsulate set custom slice in a
 __setparam_fair() function
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250110144656.484601-1-vincent.guittot@linaro.org>
References: <20250110144656.484601-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263906.31546.14629399223607968639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2cf9ac40073ddb6a70dd5ef94f1cf45501b696ed
Gitweb:        https://git.kernel.org/tip/2cf9ac40073ddb6a70dd5ef94f1cf45501b696ed
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Sat, 11 Jan 2025 10:14:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:22 +01:00

sched/fair: Encapsulate set custom slice in a __setparam_fair() function

Similarly to dl, create a __setparam_fair() function to set parameters
related to fair class and move it in the fair.c file.

No functional changes expected

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20250110144656.484601-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c     | 19 +++++++++++++++++++
 kernel/sched/sched.h    |  2 ++
 kernel/sched/syscalls.c | 16 +++-------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3418b5..7ec2587 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -37,6 +37,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/nohz.h>
+#include <linux/sched/prio.h>
 
 #include <linux/cpuidle.h>
 #include <linux/interrupt.h>
@@ -51,6 +52,8 @@
 
 #include <asm/switch_to.h>
 
+#include <uapi/linux/sched/types.h>
+
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
@@ -5258,6 +5261,22 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
 #endif /* CONFIG_SMP */
 
+void __setparam_fair(struct task_struct *p, const struct sched_attr *attr)
+{
+	struct sched_entity *se = &p->se;
+
+	p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+	if (attr->sched_runtime) {
+		se->custom_slice = 1;
+		se->slice = clamp_t(u64, attr->sched_runtime,
+				      NSEC_PER_MSEC/10,   /* HZ=1000 * 10 */
+				      NSEC_PER_MSEC*100); /* HZ=100  / 10 */
+	} else {
+		se->custom_slice = 0;
+		se->slice = sysctl_sched_base_slice;
+	}
+}
+
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aef716c..300db6f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3500,6 +3500,8 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 
 #endif /* !CONFIG_HAVE_SCHED_AVG_IRQ */
 
+extern void __setparam_fair(struct task_struct *p, const struct sched_attr *attr);
+
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 
 #define perf_domain_span(pd) (to_cpumask(((pd)->em_pd->cpus)))
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 943406c..149e2c8 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -300,20 +300,10 @@ static void __setscheduler_params(struct task_struct *p,
 
 	p->policy = policy;
 
-	if (dl_policy(policy)) {
+	if (dl_policy(policy))
 		__setparam_dl(p, attr);
-	} else if (fair_policy(policy)) {
-		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
-		if (attr->sched_runtime) {
-			p->se.custom_slice = 1;
-			p->se.slice = clamp_t(u64, attr->sched_runtime,
-					      NSEC_PER_MSEC/10,   /* HZ=1000 * 10 */
-					      NSEC_PER_MSEC*100); /* HZ=100  / 10 */
-		} else {
-			p->se.custom_slice = 0;
-			p->se.slice = sysctl_sched_base_slice;
-		}
-	}
+	else if (fair_policy(policy))
+		__setparam_fair(p, attr);
 
 	/* rt-policy tasks do not have a timerslack */
 	if (rt_or_dl_task_policy(p)) {

