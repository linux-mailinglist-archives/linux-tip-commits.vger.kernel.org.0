Return-Path: <linux-tip-commits+bounces-2543-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB539AFBD7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD96B23D65
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDDF1C4A29;
	Fri, 25 Oct 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XE7qdKQj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hbJ+YNnM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0F19993F;
	Fri, 25 Oct 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843333; cv=none; b=fc8ZKIHZnZ/g72Xatibaro2P2yd8h62XVPyXdOwq7il9wwfvZdN8RUrC7peymn1JmJK41azndVQTN8iNU3EsDnU88vci28D7dujynrwnhfit5lJRBTFkuKKKQvyUpQy4y9goZyKfrESCZcMpSRqV1pIieintw5H0mR+ZZOUfLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843333; c=relaxed/simple;
	bh=y73+Xg5ml7JyMYXIPjANukuZ9iSry1NgBEW1MBL286s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RyxjWIIMq1LTy9q8LPidJyOtmG3sAlJE1+IZ5jvliFFJJRTEQWuS9M4YEkZaMdGeulSWIxFU09PCEZ1unJVkHIl42qWDwhJHOg1ToKOHIQBI94DjnASSl2X0GJIk5taEq4RK0atloFyo2ABfGvNRi6KWh06HhkdbVeQ7h9jN+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XE7qdKQj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hbJ+YNnM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 08:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729843329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tubrfHUNGZj1k9uNTDBraHQs1gAplDDvGKvrBuqczdk=;
	b=XE7qdKQj83M1O28//UwEo3xbMawVW+/IWbXmUwSTzNymiOByGTPjvzdurNs9lAHHz46Kc1
	LcBemIfbYku6+bSCWw0frSlKQFjqMeKf7pcTC9CACywttqKfaLWQ+NZwhCkMnGVO1gfdqm
	l6FFG/1L1ihTUj9WUxD39cxBlRn7hbjqX+XwGK3pvrP5dBgeu7IYF+WQtC7bm0aWDFCCBY
	3T8ZZkkViTSfp8gu6nk4g5wHwTqdWvZzjlzhIBNsphNRsmpAffmyTbnfnrd0j1IwSK2FDk
	SCe0UhFbHTpafzRmcdhmFwdNRiINYYWnEdLSjkuZcWKCrLsFcGv8o2ybpiik0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729843329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tubrfHUNGZj1k9uNTDBraHQs1gAplDDvGKvrBuqczdk=;
	b=hbJ+YNnMt+q7Ut/pzxB+yPvL17uK69a8MzUPxjUW/gFBYgPtnHEWjcNQ3Ev37oGY3vC6uv
	Dpur7jgENvgCBrBA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobe: Add support for session consumer
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241018202252.693462-3-jolsa@kernel.org>
References: <20241018202252.693462-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172984332808.1442.15585333840318648012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4d756095d3994cb41393817dc696b458938a6bd0
Gitweb:        https://git.kernel.org/tip/4d756095d3994cb41393817dc696b458938a6bd0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 18 Oct 2024 22:22:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Oct 2024 20:52:27 +02:00

uprobe: Add support for session consumer

This change allows the uprobe consumer to behave as session which
means that 'handler' and 'ret_handler' callbacks are connected in
a way that allows to:

  - control execution of 'ret_handler' from 'handler' callback
  - share data between 'handler' and 'ret_handler' callbacks

The session concept fits to our common use case where we do filtering
on entry uprobe and based on the result we decide to run the return
uprobe (or not).

It's also convenient to share the data between session callbacks.

To achive this we are adding new return value the uprobe consumer
can return from 'handler' callback:

  UPROBE_HANDLER_IGNORE
  - Ignore 'ret_handler' callback for this consumer.

And store cookie and pass it to 'ret_handler' when consumer has both
'handler' and 'ret_handler' callbacks defined.

We store shared data in the return_consumer object array as part of
the return_instance object. This way the handle_uretprobe_chain can
find related return_consumer and its shared data.

We also store entry handler return value, for cases when there are
multiple consumers on single uprobe and some of them are ignored and
some of them not, in which case the return probe gets installed and
we need to have a way to find out which consumer needs to be ignored.

The tricky part is when consumer is registered 'after' the uprobe
entry handler is hit. In such case this consumer's 'ret_handler' gets
executed as well, but it won't have the proper data pointer set,
so we can filter it out.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20241018202252.693462-3-jolsa@kernel.org
---
 include/linux/uprobes.h |  21 +++++-
 kernel/events/uprobes.c | 148 +++++++++++++++++++++++++++++++--------
 2 files changed, 139 insertions(+), 30 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index bb265a6..dbaf041 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -23,8 +23,17 @@ struct inode;
 struct notifier_block;
 struct page;
 
+/*
+ * Allowed return values from uprobe consumer's handler callback
+ * with following meaning:
+ *
+ * UPROBE_HANDLER_REMOVE
+ * - Remove the uprobe breakpoint from current->mm.
+ * UPROBE_HANDLER_IGNORE
+ * - Ignore ret_handler callback for this consumer.
+ */
 #define UPROBE_HANDLER_REMOVE		1
-#define UPROBE_HANDLER_MASK		1
+#define UPROBE_HANDLER_IGNORE		2
 
 #define MAX_URETPROBE_DEPTH		64
 
@@ -44,6 +53,8 @@ struct uprobe_consumer {
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct list_head cons_node;
+
+	__u64 id;	/* set when uprobe_consumer is registered */
 };
 
 #ifdef CONFIG_UPROBES
@@ -83,14 +94,22 @@ struct uprobe_task {
 	unsigned int			depth;
 };
 
+struct return_consumer {
+	__u64	cookie;
+	__u64	id;
+};
+
 struct return_instance {
 	struct uprobe		*uprobe;
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
+	int			consumers_cnt;
 
 	struct return_instance	*next;		/* keep as stack */
+
+	struct return_consumer	consumers[] __counted_by(consumers_cnt);
 };
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6b44c38..4ef4b51 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -64,7 +64,7 @@ struct uprobe {
 	struct rcu_head		rcu;
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
-	unsigned long		flags;
+	unsigned long		flags;		/* "unsigned long" so bitops work */
 
 	/*
 	 * The generic code assumes that it has two members of unknown type
@@ -823,8 +823,11 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	static atomic64_t id;
+
 	down_write(&uprobe->consumer_rwsem);
 	list_add_rcu(&uc->cons_node, &uprobe->consumers);
+	uc->id = (__u64) atomic64_inc_return(&id);
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -1761,6 +1764,34 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
+static size_t ri_size(int consumers_cnt)
+{
+	struct return_instance *ri;
+
+	return sizeof(*ri) + sizeof(ri->consumers[0]) * consumers_cnt;
+}
+
+#define DEF_CNT 4
+
+static struct return_instance *alloc_return_instance(void)
+{
+	struct return_instance *ri;
+
+	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
+	if (!ri)
+		return ZERO_SIZE_PTR;
+
+	ri->consumers_cnt = DEF_CNT;
+	return ri;
+}
+
+static struct return_instance *dup_return_instance(struct return_instance *old)
+{
+	size_t size = ri_size(old->consumers_cnt);
+
+	return kmemdup(old, size, GFP_KERNEL);
+}
+
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
@@ -1773,11 +1804,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
-		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
+		n = dup_return_instance(o);
 		if (!n)
 			return -ENOMEM;
 
-		*n = *o;
 		/*
 		 * uprobe's refcnt has to be positive at this point, kept by
 		 * utask->return_instances items; return_instances can't be
@@ -1870,35 +1900,31 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 	utask->return_instances = ri;
 }
 
-static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
+static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
+			      struct return_instance *ri)
 {
 	struct uprobe_task *utask = current->utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
-	struct return_instance *ri;
 	bool chained;
 
 	if (!get_xol_area())
-		return;
+		goto free;
 
 	if (utask->depth >= MAX_URETPROBE_DEPTH) {
 		printk_ratelimited(KERN_INFO "uprobe: omit uretprobe due to"
 				" nestedness limit pid/tgid=%d/%d\n",
 				current->pid, current->tgid);
-		return;
+		goto free;
 	}
 
 	/* we need to bump refcount to store uprobe in utask */
 	if (!try_get_uprobe(uprobe))
-		return;
-
-	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
-	if (!ri)
-		goto fail;
+		goto free;
 
 	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
-		goto fail;
+		goto put;
 
 	/* drop the entries invalidated by longjmp() */
 	chained = (orig_ret_vaddr == trampoline_vaddr);
@@ -1916,7 +1942,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 			 * attack from user-space.
 			 */
 			uprobe_warn(current, "handle tail call");
-			goto fail;
+			goto put;
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
@@ -1931,9 +1957,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	utask->return_instances = ri;
 
 	return;
-fail:
-	kfree(ri);
+put:
 	put_uprobe(uprobe);
+free:
+	kfree(ri);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2077,34 +2104,90 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	return uprobe;
 }
 
+static struct return_instance*
+push_consumer(struct return_instance *ri, int idx, __u64 id, __u64 cookie)
+{
+	if (unlikely(ri == ZERO_SIZE_PTR))
+		return ri;
+
+	if (unlikely(idx >= ri->consumers_cnt)) {
+		struct return_instance *old_ri = ri;
+
+		ri->consumers_cnt += DEF_CNT;
+		ri = krealloc(old_ri, ri_size(old_ri->consumers_cnt), GFP_KERNEL);
+		if (!ri) {
+			kfree(old_ri);
+			return ZERO_SIZE_PTR;
+		}
+	}
+
+	ri->consumers[idx].id = id;
+	ri->consumers[idx].cookie = cookie;
+	return ri;
+}
+
+static struct return_consumer *
+return_consumer_find(struct return_instance *ri, int *iter, int id)
+{
+	struct return_consumer *ric;
+	int idx = *iter;
+
+	for (ric = &ri->consumers[idx]; idx < ri->consumers_cnt; idx++, ric++) {
+		if (ric->id == id) {
+			*iter = idx + 1;
+			return ric;
+		}
+	}
+	return NULL;
+}
+
+static bool ignore_ret_handler(int rc)
+{
+	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
+}
+
 static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
-	int remove = UPROBE_HANDLER_REMOVE;
-	bool need_prep = false; /* prepare return uprobe, when needed */
-	bool has_consumers = false;
+	bool has_consumers = false, remove = true;
+	struct return_instance *ri = NULL;
+	int push_idx = 0;
 
 	current->utask->auprobe = &uprobe->arch;
 
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
+		bool session = uc->handler && uc->ret_handler;
+		__u64 cookie = 0;
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs, NULL);
-			WARN(rc & ~UPROBE_HANDLER_MASK,
+			rc = uc->handler(uc, regs, &cookie);
+			WARN(rc < 0 || rc > 2,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
 
-		if (uc->ret_handler)
-			need_prep = true;
-
-		remove &= rc;
+		remove &= rc == UPROBE_HANDLER_REMOVE;
 		has_consumers = true;
+
+		if (!uc->ret_handler || ignore_ret_handler(rc))
+			continue;
+
+		if (!ri)
+			ri = alloc_return_instance();
+
+		if (session)
+			ri = push_consumer(ri, push_idx++, uc->id, cookie);
 	}
 	current->utask->auprobe = NULL;
 
-	if (need_prep && !remove)
-		prepare_uretprobe(uprobe, regs); /* put bp at return */
+	if (!ZERO_OR_NULL_PTR(ri)) {
+		/*
+		 * The push_idx value has the final number of return consumers,
+		 * and ri->consumers_cnt has number of allocated consumers.
+		 */
+		ri->consumers_cnt = push_idx;
+		prepare_uretprobe(uprobe, regs, ri);
+	}
 
 	if (remove && has_consumers) {
 		down_read(&uprobe->register_rwsem);
@@ -2123,12 +2206,19 @@ static void
 handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
+	struct return_consumer *ric;
 	struct uprobe_consumer *uc;
+	int ric_idx = 0;
 
 	rcu_read_lock_trace();
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
-		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs, NULL);
+		bool session = uc->handler && uc->ret_handler;
+
+		if (uc->ret_handler) {
+			ric = return_consumer_find(ri, &ric_idx, uc->id);
+			if (!session || ric)
+				uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
+		}
 	}
 	rcu_read_unlock_trace();
 }

