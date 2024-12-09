Return-Path: <linux-tip-commits+bounces-3046-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC19E999D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6991887676
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A61F2C47;
	Mon,  9 Dec 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NljW+6hl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5ussdrg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55231F0E4F;
	Mon,  9 Dec 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756125; cv=none; b=ChF8u13xUSKcP4Czd1p1UEIgZbBQR8xhhvRbNZXn4rKchofQQkWEgy4JnEMYlUX1t/HZ6ChoobbH9giqi0F4BxSPzwc/lyIdNAIINJWAUi9yXdGW5k/W+G7DNCJaix4+K1p0tCkzsvM5Jkqyj3nfEIu23jk5BGo3u15FzF7YRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756125; c=relaxed/simple;
	bh=11704BSdLQPyjA3nCbdYmDh4lW5t5ay2ijw6QhZopME=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lDswSx1SsirMHHZJuLtEY285hu2HdJq47z9YyMhcbG+oAo34t+1sLC6PQ7jAXlCumO+cLJF+M7h61Ch+QtBELO7MlivMAxyjm8cx8gG7yeCCkSYROvXGThpCtQz5o2iYkMmp0TPjKJT3XYzFjKK1aIMaeFjpo7ncKMXSm+49P1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NljW+6hl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5ussdrg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 14:55:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733756122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Jp6RFv3Cfdp1yW5xEPopNh49TVWFUyAHeWO4YCcOkM=;
	b=NljW+6hlCg2tz/lLJsz1qK6thInthGnvc4eqhUPUyj9ZnsJAVFR8dZ6ZxWoahYpLUQKO38
	2ZPWsakRXDq0IkQK+n4jMvS57ETDb6ooDsEwkvBvoLbBx5e40Kn+udtl1XJj1Qqrno0CsK
	UMc97FVPuTO/Q3z8dQneCHjR1pMP8VwfNolYkZZ56m9nPJEa9oqodGTnhYGirzIL9qKh1m
	rXqylCCC74TCz6GfxaoG6qyzoz/0crhTLZsuHKPjGZmiXV/tlms+VCxr5KQO0E55hB94bI
	J2jOEK2FESXFIcunjKnhKjfRkeIepQ6zJIMlphq6YzZAhRXRlNwnHF1L5tTOkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733756122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Jp6RFv3Cfdp1yW5xEPopNh49TVWFUyAHeWO4YCcOkM=;
	b=O5ussdrgGJ7yBKyOrfklt0Z3/TBYzFkNVJ/wIw/8mjQTYaxje4lyG3pdFVuTA4xtsNFOWp
	9r0IXdOWCOdDgiCQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Simplify session consumer tracking
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206002417.3295533-2-andrii@kernel.org>
References: <20241206002417.3295533-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173375612102.412.4857272173245718280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2ff913ab3f472321ac1931b663314edd6c211a0c
Gitweb:        https://git.kernel.org/tip/2ff913ab3f472321ac1931b663314edd6c211a0c
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 16:24:14 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Dec 2024 15:50:23 +01:00

uprobes: Simplify session consumer tracking

In practice, each return_instance will typically contain either zero or
one return_consumer, depending on whether it has any uprobe session
consumer attached or not. It's highly unlikely that more than one uprobe
session consumers will be attached to any given uprobe, so there is no
need to optimize for that case. But the way we currently do memory
allocation and accounting is by pre-allocating the space for 4 session
consumers in contiguous block of memory next to struct return_instance
fixed part. This is unnecessarily wasteful.

This patch changes this to keep struct return_instance fixed-sized with one
pre-allocated return_consumer, while (in a highly unlikely scenario)
allowing for more session consumers in a separate dynamically
allocated and reallocated array.

We also simplify accounting a bit by not maintaining a separate
temporary capacity for consumers array, and, instead, relying on
krealloc() to be a no-op if underlying memory can accommodate a slightly
bigger allocation (but again, it's very uncommon scenario to even have
to do this reallocation).

All this gets rid of ri_size(), simplifies push_consumer() and removes
confusing ri->consumers_cnt re-assignment, while containing this
singular preallocated consumer logic contained within a few simple
preexisting helpers.

Having fixed-sized struct return_instance simplifies and speeds up
return_instance reuse that we ultimately add later in this patch set,
see follow up patches.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20241206002417.3295533-2-andrii@kernel.org
---
 include/linux/uprobes.h | 10 ++++--
 kernel/events/uprobes.c | 72 ++++++++++++++++++++--------------------
 2 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e0a4c20..1d44997 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -154,12 +154,18 @@ struct return_instance {
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
-	int			consumers_cnt;
+	int			cons_cnt;	/* total number of session consumers */
 
 	struct return_instance	*next;		/* keep as stack */
 	struct rcu_head		rcu;
 
-	struct return_consumer	consumers[] __counted_by(consumers_cnt);
+	/* singular pre-allocated return_consumer instance for common case */
+	struct return_consumer	consumer;
+	/*
+	 * extra return_consumer instances for rare cases of multiple session consumers,
+	 * contains (cons_cnt - 1) elements
+	 */
+	struct return_consumer	*extra_consumers;
 } ____cacheline_aligned;
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index daf4314..6beac52 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1899,6 +1899,7 @@ static struct return_instance *free_ret_instance(struct return_instance *ri, boo
 		hprobe_finalize(&ri->hprobe, hstate);
 	}
 
+	kfree(ri->extra_consumers);
 	kfree_rcu(ri, rcu);
 	return next;
 }
@@ -1974,32 +1975,34 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
-static size_t ri_size(int consumers_cnt)
-{
-	struct return_instance *ri;
-
-	return sizeof(*ri) + sizeof(ri->consumers[0]) * consumers_cnt;
-}
-
-#define DEF_CNT 4
-
 static struct return_instance *alloc_return_instance(void)
 {
 	struct return_instance *ri;
 
-	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
 		return ZERO_SIZE_PTR;
 
-	ri->consumers_cnt = DEF_CNT;
 	return ri;
 }
 
 static struct return_instance *dup_return_instance(struct return_instance *old)
 {
-	size_t size = ri_size(old->consumers_cnt);
+	struct return_instance *ri;
+
+	ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);
+
+	if (unlikely(old->cons_cnt > 1)) {
+		ri->extra_consumers = kmemdup(old->extra_consumers,
+					      sizeof(ri->extra_consumers[0]) * (old->cons_cnt - 1),
+					      GFP_KERNEL);
+		if (!ri->extra_consumers) {
+			kfree(ri);
+			return NULL;
+		}
+	}
 
-	return kmemdup(old, size, GFP_KERNEL);
+	return ri;
 }
 
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
@@ -2369,25 +2372,28 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	return uprobe;
 }
 
-static struct return_instance*
-push_consumer(struct return_instance *ri, int idx, __u64 id, __u64 cookie)
+static struct return_instance *push_consumer(struct return_instance *ri, __u64 id, __u64 cookie)
 {
+	struct return_consumer *ric;
+
 	if (unlikely(ri == ZERO_SIZE_PTR))
 		return ri;
 
-	if (unlikely(idx >= ri->consumers_cnt)) {
-		struct return_instance *old_ri = ri;
-
-		ri->consumers_cnt += DEF_CNT;
-		ri = krealloc(old_ri, ri_size(old_ri->consumers_cnt), GFP_KERNEL);
-		if (!ri) {
-			kfree(old_ri);
+	if (unlikely(ri->cons_cnt > 0)) {
+		ric = krealloc(ri->extra_consumers, sizeof(*ric) * ri->cons_cnt, GFP_KERNEL);
+		if (!ric) {
+			kfree(ri->extra_consumers);
+			kfree_rcu(ri, rcu);
 			return ZERO_SIZE_PTR;
 		}
+		ri->extra_consumers = ric;
 	}
 
-	ri->consumers[idx].id = id;
-	ri->consumers[idx].cookie = cookie;
+	ric = likely(ri->cons_cnt == 0) ? &ri->consumer : &ri->extra_consumers[ri->cons_cnt - 1];
+	ric->id = id;
+	ric->cookie = cookie;
+
+	ri->cons_cnt++;
 	return ri;
 }
 
@@ -2395,14 +2401,17 @@ static struct return_consumer *
 return_consumer_find(struct return_instance *ri, int *iter, int id)
 {
 	struct return_consumer *ric;
-	int idx = *iter;
+	int idx;
 
-	for (ric = &ri->consumers[idx]; idx < ri->consumers_cnt; idx++, ric++) {
+	for (idx = *iter; idx < ri->cons_cnt; idx++)
+	{
+		ric = likely(idx == 0) ? &ri->consumer : &ri->extra_consumers[idx - 1];
 		if (ric->id == id) {
 			*iter = idx + 1;
 			return ric;
 		}
 	}
+
 	return NULL;
 }
 
@@ -2416,7 +2425,6 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_consumer *uc;
 	bool has_consumers = false, remove = true;
 	struct return_instance *ri = NULL;
-	int push_idx = 0;
 
 	current->utask->auprobe = &uprobe->arch;
 
@@ -2441,18 +2449,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 			ri = alloc_return_instance();
 
 		if (session)
-			ri = push_consumer(ri, push_idx++, uc->id, cookie);
+			ri = push_consumer(ri, uc->id, cookie);
 	}
 	current->utask->auprobe = NULL;
 
-	if (!ZERO_OR_NULL_PTR(ri)) {
-		/*
-		 * The push_idx value has the final number of return consumers,
-		 * and ri->consumers_cnt has number of allocated consumers.
-		 */
-		ri->consumers_cnt = push_idx;
+	if (!ZERO_OR_NULL_PTR(ri))
 		prepare_uretprobe(uprobe, regs, ri);
-	}
 
 	if (remove && has_consumers) {
 		down_read(&uprobe->register_rwsem);

