Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6BB283106
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Oct 2020 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEHnX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Oct 2020 03:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEHnX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Oct 2020 03:43:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E622C0613CE;
        Mon,  5 Oct 2020 00:43:23 -0700 (PDT)
Date:   Mon, 05 Oct 2020 07:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601883801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3f7cb4JGax3j0kcxMrjEHzsgtWg1+sPkRlb+Z2FCofI=;
        b=alR2jJMSEUKfQdtRBe8WKA8ThKDIXnXP/TX0Hxto7iETnjyRz4/bl+jpidsJ5FfOqXyFgD
        DNCm4Tq/Cxo4eZ71IIl5OTwnU+yZh74c9SY5pBXFG/lI5LJK+vSIPQlutx4StFwTmKnLaf
        w5fZF5hEnjdnfOtscluffyWSwNnkA7HTq/pmtoC2WlA+J5z/kXPEkbBxtcCTfn2r3zJB6Y
        hzT+4U6Ii+LPtWhtIeTCaCgy9JTpoJFPpYN70FVKutL9JV/BqwOZ66XUt196kL88gTgj4f
        Gjvo0Oc5a13tSyqjtEps9yH/rDMTaP/hcn8VBLUdyuHss+6CsbFrHfUHdW/8NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601883801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3f7cb4JGax3j0kcxMrjEHzsgtWg1+sPkRlb+Z2FCofI=;
        b=mI424fJQ3yF8tgLhwUHwdElQ4nG/sLfv89k77uot7/K9fCGml2JCNsyF/sgzxOweP2wJqH
        /xm2WmS4zm1SvFDg==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Add new tracepoint to track cpu_capacity
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <160188380057.7002.3344944669205330668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     51cf18c90ca1b51d1cb4af3064e85fcf8610b5d2
Gitweb:        https://git.kernel.org/tip/51cf18c90ca1b51d1cb4af3064e85fcf8610b5d2
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Fri, 28 Aug 2020 10:00:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 Oct 2020 16:30:52 +02:00

sched/debug: Add new tracepoint to track cpu_capacity

rq->cpu_capacity is a key element in several scheduler parts, such as EAS
task placement and load balancing. Tracking this value enables testing
and/or debugging by a toolkit.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1598605249-72651-1-git-send-email-vincent.donnefort@arm.com
---
 include/linux/sched.h        |  1 +
 include/trace/events/sched.h |  4 ++++
 kernel/sched/core.c          |  1 +
 kernel/sched/fair.c          | 14 ++++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2bf0af1..f516c18 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2044,6 +2044,7 @@ const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
 const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
 
 int sched_trace_rq_cpu(struct rq *rq);
+int sched_trace_rq_cpu_capacity(struct rq *rq);
 int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fec25b9..c96a433 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -630,6 +630,10 @@ DECLARE_TRACE(pelt_se_tp,
 	TP_PROTO(struct sched_entity *se),
 	TP_ARGS(se));
 
+DECLARE_TRACE(sched_cpu_capacity_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
 DECLARE_TRACE(sched_overutilized_tp,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd32d85..3dc415f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cec6cf9..aa4c622 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8108,6 +8108,8 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 		capacity = 1;
 
 	cpu_rq(cpu)->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
+
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
 	sdg->sgc->max_capacity = capacity;
@@ -11321,6 +11323,18 @@ int sched_trace_rq_cpu(struct rq *rq)
 }
 EXPORT_SYMBOL_GPL(sched_trace_rq_cpu);
 
+int sched_trace_rq_cpu_capacity(struct rq *rq)
+{
+	return rq ?
+#ifdef CONFIG_SMP
+		rq->cpu_capacity
+#else
+		SCHED_CAPACITY_SCALE
+#endif
+		: -1;
+}
+EXPORT_SYMBOL_GPL(sched_trace_rq_cpu_capacity);
+
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
 {
 #ifdef CONFIG_SMP
