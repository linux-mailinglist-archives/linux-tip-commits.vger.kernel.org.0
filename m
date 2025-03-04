Return-Path: <linux-tip-commits+bounces-3860-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E93A4D730
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311321759BD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B271FCF57;
	Tue,  4 Mar 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fsCvliyL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQAxvQCt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6D1FBCBF;
	Tue,  4 Mar 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078622; cv=none; b=B9YdjhIz60hnKALkjOCerzCS77U8W4UYyrGzqQhFTq9En+3vMULEfes+oBUEnLryLmbpUiPYNQw4LbOXrWjVT8HTph2VjirP+1v8v3QqBJwjYJMYiTpnuGQQqQIAGoXkQOqba8HQh6C1Xrd1xhvvxOYGodQPEqHwPX7jTLh9aHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078622; c=relaxed/simple;
	bh=Wz9RA5zGqQ736CGCYqeRdV968wIx/X9HtqdI06bhlpw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C1L4O3B6BqyrovYcqovqIMA+PZCeEJ5DdZUXLIcsZzmUTWN7AFV804n5eR0jf67ESQ6nnO6qVdiGjGhs19C35or2R4gfHuNbs0VSBrNNBww5Y74HdsYdEyAY0+zn+nvdp2bPMgX1ST39VSDuZo3dQCnaqKD1BgwK7eseVxeEavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fsCvliyL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQAxvQCt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:56:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYmgFWe4X8vhIIMH6Y52OKg/F/u3BkK8RXl7LDW5qHM=;
	b=fsCvliyLBn87tz791j1MqTRgnbyQr/iallu9VJDWYnuG1BYHmKwpJELCsQLXORM4ClQDXE
	fANckBE5eo+dOUCygpcP5oOJ1+9rdGKr5PUl82xvAEJqn99+CMR+msA4YgTgEiZTDhofP8
	pezm3FsNA0imz2DWqumRTTZXi5IioSnE0PnXjt8I1Wluz97+ZiCMA8KGAA3qMBHZiSt7x7
	MIlMzDA4K9mz/qQEC3FC21I/z76nU544OU8n6dhF5dcS/I3hOlnYDRnD0NdRYbhGlVDrWp
	mOAHZWWAjaUZuOk2imcEDG9ljpNeN0ysKaig479qcpfpBLe1Z1DZnvXOjgqFXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYmgFWe4X8vhIIMH6Y52OKg/F/u3BkK8RXl7LDW5qHM=;
	b=fQAxvQCtrn3XoDTAjCdBMtoql2CzqlM5Nwm037/8c1Jte5YTUZd9Q5Cspav0LQuOjd2cQ6
	DX9xtiJA45LXrrCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Detach 'struct perf_cpu_pmu_context' and
 'struct pmu' lifetimes
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.760214287@infradead.org>
References: <20241104135518.760214287@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107861794.14745.277990751281167883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4eabf533fb1886089ef57e0c8ec52048b1741e39
Gitweb:        https://git.kernel.org/tip/4eabf533fb1886089ef57e0c8ec52048b1741e39
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:43:22 +01:00

perf/core: Detach 'struct perf_cpu_pmu_context' and 'struct pmu' lifetimes

In prepration for being able to unregister a PMU with existing events,
it becomes important to detach struct perf_cpu_pmu_context lifetimes
from that of struct pmu.

Notably struct perf_cpu_pmu_context embeds a struct perf_event_pmu_context
that can stay referenced until the last event goes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135518.760214287@infradead.org
---
 include/linux/perf_event.h |  4 +--
 kernel/events/core.c       | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5f293e6..76f4265 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -343,7 +343,7 @@ struct pmu {
 	 */
 	unsigned int			scope;
 
-	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
+	struct perf_cpu_pmu_context __percpu **cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;
@@ -922,7 +922,7 @@ struct perf_event_pmu_context {
 	struct list_head		pinned_active;
 	struct list_head		flexible_active;
 
-	/* Used to avoid freeing per-cpu perf_event_pmu_context */
+	/* Used to identify the per-cpu perf_event_pmu_context */
 	unsigned int			embedded : 1;
 
 	unsigned int			nr_events;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 773875a..8b2a8c3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1219,7 +1219,7 @@ static int perf_mux_hrtimer_restart_ipi(void *arg)
 
 static __always_inline struct perf_cpu_pmu_context *this_cpc(struct pmu *pmu)
 {
-	return this_cpu_ptr(pmu->cpu_pmu_context);
+	return *this_cpu_ptr(pmu->cpu_pmu_context);
 }
 
 void perf_pmu_disable(struct pmu *pmu)
@@ -5007,11 +5007,14 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		 */
 		struct perf_cpu_pmu_context *cpc;
 
-		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
+		cpc = *per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
 		epc = &cpc->epc;
 		raw_spin_lock_irq(&ctx->lock);
 		if (!epc->ctx) {
-			atomic_set(&epc->refcount, 1);
+			/*
+			 * One extra reference for the pmu; see perf_pmu_free().
+			 */
+			atomic_set(&epc->refcount, 2);
 			epc->embedded = 1;
 			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
 			epc->ctx = ctx;
@@ -5087,6 +5090,15 @@ static void get_pmu_ctx(struct perf_event_pmu_context *epc)
 	WARN_ON_ONCE(!atomic_inc_not_zero(&epc->refcount));
 }
 
+static void free_cpc_rcu(struct rcu_head *head)
+{
+	struct perf_cpu_pmu_context *cpc =
+		container_of(head, typeof(*cpc), epc.rcu_head);
+
+	kfree(cpc->epc.task_ctx_data);
+	kfree(cpc);
+}
+
 static void free_epc_rcu(struct rcu_head *head)
 {
 	struct perf_event_pmu_context *epc = container_of(head, typeof(*epc), rcu_head);
@@ -5121,8 +5133,10 @@ static void put_pmu_ctx(struct perf_event_pmu_context *epc)
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
-	if (epc->embedded)
+	if (epc->embedded) {
+		call_rcu(&epc->rcu_head, free_cpc_rcu);
 		return;
+	}
 
 	call_rcu(&epc->rcu_head, free_epc_rcu);
 }
@@ -11752,7 +11766,7 @@ perf_event_mux_interval_ms_store(struct device *dev,
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct perf_cpu_pmu_context *cpc;
-		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
 		cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
 		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc);
@@ -11925,7 +11939,25 @@ static void perf_pmu_free(struct pmu *pmu)
 		device_del(pmu->dev);
 		put_device(pmu->dev);
 	}
-	free_percpu(pmu->cpu_pmu_context);
+
+	if (pmu->cpu_pmu_context) {
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			struct perf_cpu_pmu_context *cpc;
+
+			cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+			if (!cpc)
+				continue;
+			if (cpc->epc.embedded) {
+				/* refcount managed */
+				put_pmu_ctx(&cpc->epc);
+				continue;
+			}
+			kfree(cpc);
+		}
+		free_percpu(pmu->cpu_pmu_context);
+	}
 }
 
 DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) perf_pmu_free(_T))
@@ -11964,14 +11996,20 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 			return ret;
 	}
 
-	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
+	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context *);
 	if (!pmu->cpu_pmu_context)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
-		struct perf_cpu_pmu_context *cpc;
+		struct perf_cpu_pmu_context *cpc =
+			kmalloc_node(sizeof(struct perf_cpu_pmu_context),
+				     GFP_KERNEL | __GFP_ZERO,
+				     cpu_to_node(cpu));
+
+		if (!cpc)
+			return -ENOMEM;
 
-		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		*per_cpu_ptr(pmu->cpu_pmu_context, cpu) = cpc;
 		__perf_init_event_pmu_context(&cpc->epc, pmu);
 		__perf_mux_hrtimer_init(cpc, cpu);
 	}

