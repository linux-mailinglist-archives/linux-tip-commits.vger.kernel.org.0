Return-Path: <linux-tip-commits+bounces-2181-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E296DD37
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 17:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3821F22461
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603231A0BE1;
	Thu,  5 Sep 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KH0MUIFM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SNsezR5n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6719EED3;
	Thu,  5 Sep 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548612; cv=none; b=QHmU6ygMaQ8qJLMaoF6d7Kb++9eOsO/54fm5JaE3g1wOabDVdqpRflj/jRokw4DrGT13W5VDE4bj/7lOwxz0HRuiKx7i1bxsTqJr4TY6GCLQhR9oRCe74NQHWUfo4FQyi1Oq/93hKcMTm0tiU3CWfGnVZNemMyturXsjIw6L5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548612; c=relaxed/simple;
	bh=p6xE+GUZVyfNomOzU5KrIJVQvC8ebV6pZIdMh7qQS1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GtbFV8XpkZz4fUnhNI03ZXfb1n8RC3YM1l/jRjhoRJOKihojAeDTJt5w+Rg0XX5pgmYYVvfLBS/bCfy3LBq8FdHCfPjUUtaBIO+qyhjV5la/ferrcTmXsdykML61AJJKV6unEW+hb8zwHOtaa1ZFOxExvKJZK3FpI6I95Dj8TOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KH0MUIFM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SNsezR5n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+L53W6x82nO7NLn+hoQ+OjzN+HQdZWM0Q2RGjydwDk0=;
	b=KH0MUIFMcGAKlLHEbVyh0aQDBzxR3g6GDIKzJNX7MA9ltkhT6/QpMRdg9B7m/gjiHmL54E
	NWNnfbSO7x54OxwJlVKwCkQXGokrlAsl4unlMmoIvvxHQiAIAno8Q03s5RILRjQMg0hA2c
	nxOy2rjMjWztIACPF78cbJalGbYLeIQYYri+fVOhbEiTEfbM4fxgOcA3I9LmkxXnbkwYiL
	wIf/+tJ3tv+EpgpMx8fgTsNrGxSjImaWAyRFMhewCty2jROetsNZQ8aF7Y8sL22kEuQ67e
	RGsT1WzkzBLfF8qXJB9NyrLt2PVUf3MjZvucMzLwwIdz2ZGz8atLEEe6LZn9Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+L53W6x82nO7NLn+hoQ+OjzN+HQdZWM0Q2RGjydwDk0=;
	b=SNsezR5nL9hWl+Npx/wCqysGw7D4U5YPbqT5XhK29R8n5cQeO5FQ0uKutBNauTepmdhluJ
	DVDCEtsW+FtARWAw==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: protected uprobe lifetime with SRCU
Cc: Andrii Nakryiko <andrii@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903174603.3554182-3-andrii@kernel.org>
References: <20240903174603.3554182-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860684.2215.13498469141604876139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8617408f7a01e94ce1f73e40a7704530e5dfb25c
Gitweb:        https://git.kernel.org/tip/8617408f7a01e94ce1f73e40a7704530e5dfb25c
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Tue, 03 Sep 2024 10:45:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:13 +02:00

uprobes: protected uprobe lifetime with SRCU

To avoid unnecessarily taking a (brief) refcount on uprobe during
breakpoint handling in handle_swbp for entry uprobes, make find_uprobe()
not take refcount, but protect the lifetime of a uprobe instance with
RCU. This improves scalability, as refcount gets quite expensive due to
cache line bouncing between multiple CPUs.

Specifically, we utilize our own uprobe-specific SRCU instance for this
RCU protection. put_uprobe() will delay actual kfree() using call_srcu().

For now, uretprobe and single-stepping handling will still acquire
refcount as necessary. We'll address these issues in follow up patches
by making them use SRCU with timeout.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240903174603.3554182-3-andrii@kernel.org
---
 kernel/events/uprobes.c | 94 ++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cd92e8d..d228d2b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -41,6 +41,8 @@ static struct rb_root uprobes_tree = RB_ROOT;
 
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
 
+DEFINE_STATIC_SRCU(uprobes_srcu);
+
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
 static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
@@ -59,6 +61,7 @@ struct uprobe {
 	struct list_head	pending_list;
 	struct uprobe_consumer	*consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
+	struct rcu_head		rcu;
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;
@@ -617,6 +620,13 @@ static inline bool uprobe_is_active(struct uprobe *uprobe)
 	return !RB_EMPTY_NODE(&uprobe->rb_node);
 }
 
+static void uprobe_free_rcu(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+
+	kfree(uprobe);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (!refcount_dec_and_test(&uprobe->ref))
@@ -638,7 +648,7 @@ static void put_uprobe(struct uprobe *uprobe)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	kfree(uprobe);
+	call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
 }
 
 static __always_inline
@@ -680,33 +690,25 @@ static inline int __uprobe_cmp(struct rb_node *a, const struct rb_node *b)
 	return uprobe_cmp(u->inode, u->offset, __node_2_uprobe(b));
 }
 
-static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
+/*
+ * Assumes being inside RCU protected region.
+ * No refcount is taken on returned uprobe.
+ */
+static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
 {
 	struct __uprobe_key key = {
 		.inode = inode,
 		.offset = offset,
 	};
-	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
-
-	if (node)
-		return try_get_uprobe(__node_2_uprobe(node));
-
-	return NULL;
-}
+	struct rb_node *node;
 
-/*
- * Find a uprobe corresponding to a given inode:offset
- * Acquires uprobes_treelock
- */
-static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
-{
-	struct uprobe *uprobe;
+	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
 
 	read_lock(&uprobes_treelock);
-	uprobe = __find_uprobe(inode, offset);
+	node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
 	read_unlock(&uprobes_treelock);
 
-	return uprobe;
+	return node ? __node_2_uprobe(node) : NULL;
 }
 
 /*
@@ -1080,10 +1082,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 			goto free;
 		/*
 		 * We take mmap_lock for writing to avoid the race with
-		 * find_active_uprobe() which takes mmap_lock for reading.
+		 * find_active_uprobe_rcu() which takes mmap_lock for reading.
 		 * Thus this install_breakpoint() can not make
-		 * is_trap_at_addr() true right after find_uprobe()
-		 * returns NULL in find_active_uprobe().
+		 * is_trap_at_addr() true right after find_uprobe_rcu()
+		 * returns NULL in find_active_uprobe_rcu().
 		 */
 		mmap_write_lock(mm);
 		vma = find_vma(mm, info->vaddr);
@@ -1884,9 +1886,13 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		return;
 	}
 
+	/* we need to bump refcount to store uprobe in utask */
+	if (!try_get_uprobe(uprobe))
+		return;
+
 	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
 	if (!ri)
-		return;
+		goto fail;
 
 	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
@@ -1913,11 +1919,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
-	/*
-	 * uprobe's refcnt is positive, held by caller, so it's safe to
-	 * unconditionally bump it one more time here
-	 */
-	ri->uprobe = get_uprobe(uprobe);
+	ri->uprobe = uprobe;
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
@@ -1928,8 +1930,9 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	utask->return_instances = ri;
 
 	return;
- fail:
+fail:
 	kfree(ri);
+	put_uprobe(uprobe);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -1944,9 +1947,14 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	if (!utask)
 		return -ENOMEM;
 
+	if (!try_get_uprobe(uprobe))
+		return -EINVAL;
+
 	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr)
-		return -ENOMEM;
+	if (!xol_vaddr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
 	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
@@ -1954,12 +1962,15 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
 		xol_free_insn_slot(current);
-		return err;
+		goto err_out;
 	}
 
 	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
 	return 0;
+err_out:
+	put_uprobe(uprobe);
+	return err;
 }
 
 /*
@@ -2043,7 +2054,8 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	return is_trap_insn(&opcode);
 }
 
-static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
+/* assumes being inside RCU protected region */
+static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swbp)
 {
 	struct mm_struct *mm = current->mm;
 	struct uprobe *uprobe = NULL;
@@ -2056,7 +2068,7 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 			struct inode *inode = file_inode(vma->vm_file);
 			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
 
-			uprobe = find_uprobe(inode, offset);
+			uprobe = find_uprobe_rcu(inode, offset);
 		}
 
 		if (!uprobe)
@@ -2202,13 +2214,15 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int is_swbp;
+	int is_swbp, srcu_idx;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == uprobe_get_trampoline_vaddr())
 		return uprobe_handle_trampoline(regs);
 
-	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
+	srcu_idx = srcu_read_lock(&uprobes_srcu);
+
+	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
 	if (!uprobe) {
 		if (is_swbp > 0) {
 			/* No matching uprobe; signal SIGTRAP. */
@@ -2224,7 +2238,7 @@ static void handle_swbp(struct pt_regs *regs)
 			 */
 			instruction_pointer_set(regs, bp_vaddr);
 		}
-		return;
+		goto out;
 	}
 
 	/* change it in advance for ->handler() and restart */
@@ -2259,12 +2273,12 @@ static void handle_swbp(struct pt_regs *regs)
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-	if (!pre_ssout(uprobe, regs, bp_vaddr))
-		return;
+	if (pre_ssout(uprobe, regs, bp_vaddr))
+		goto out;
 
-	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
 out:
-	put_uprobe(uprobe);
+	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
+	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }
 
 /*

