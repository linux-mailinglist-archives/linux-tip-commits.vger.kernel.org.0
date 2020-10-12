Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6628BEB7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404047AbgJLRI2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Oct 2020 13:08:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403845AbgJLRI2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Oct 2020 13:08:28 -0400
Date:   Mon, 12 Oct 2020 17:08:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602522506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqPxZnfywW+ztZ5cdwA8OmBYMPSQ0kxlCZ9kAZHRBOg=;
        b=EzhEVRb6GEY1sBChpSi2q5jEC6URr1mPuWF6ZbItfUgeR+K/EaFO9MypWjVva0QwrSWAQ/
        CTqif8WypsJB+45HaDLnyk0UoS0IoqOeQI5mLyUaePsHLtES3Z71NUH0J+e66PX7wDXUlG
        Hu5IkrYfFWtbQHnDsTTljRXANwwAE10TJIlheJwSJe4ucI/ZacomusONU9OEnM7Ydl4PWe
        BwnLCCbusnyjllYSFsqqOh0XFQcHzU5mbOaMc/QkTA/+AuW30OwGr4KcdvWmkWh42cDTKN
        zoqD5pWUnHb7heK5VXhxW6Kic1FBRgzqcKZ6mrZgtdRVE+obqVeQwgQx5KVe6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602522506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqPxZnfywW+ztZ5cdwA8OmBYMPSQ0kxlCZ9kAZHRBOg=;
        b=wwqwaNNgFgVWVEveuuVmP44zTHlrvKfkq8A5bIxxKxOWitSBtyyYCtQ+8zfLNJ+zajVaOk
        IMifNdCrERXfnzCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] kprobes: Replace rp->free_instance with freelist
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870623583.1229682.17472357584134058687.stgit@devnote2>
References: <159870623583.1229682.17472357584134058687.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160252250482.7002.18034659363554741944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     6e426e0fcd20ce144bb93e00b70df51e9f2e08c3
Gitweb:        https://git.kernel.org/tip/6e426e0fcd20ce144bb93e00b70df51e9f2e08c3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 29 Aug 2020 22:03:56 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 12 Oct 2020 18:27:28 +02:00

kprobes: Replace rp->free_instance with freelist

Gets rid of rp->lock, and as a result kretprobes are now fully
lockless.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870623583.1229682.17472357584134058687.stgit@devnote2
---
 include/linux/kprobes.h |  8 +++---
 kernel/kprobes.c        | 56 +++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 00cf442..b7824e3 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
 #include <linux/refcount.h>
+#include <linux/freelist.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -157,17 +158,16 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct hlist_head free_instances;
+	struct freelist_head freelist;
 	struct kretprobe_holder *rph;
-	raw_spinlock_t lock;
 };
 
 struct kretprobe_instance {
 	union {
-		struct llist_node llist;
-		struct hlist_node hlist;
+		struct freelist_node freelist;
 		struct rcu_head rcu;
 	};
+	struct llist_node llist;
 	struct kretprobe_holder *rph;
 	kprobe_opcode_t *ret_addr;
 	void *fp;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 850ee36..30b8fe7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1228,11 +1228,8 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
 
-	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
-		raw_spin_lock(&rp->lock);
-		hlist_add_head(&ri->hlist, &rp->free_instances);
-		raw_spin_unlock(&rp->lock);
+		freelist_add(&ri->freelist, &rp->freelist);
 	} else
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
@@ -1290,11 +1287,14 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 static inline void free_rp_inst(struct kretprobe *rp)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_node *next;
+	struct freelist_node *node;
 	int count = 0;
 
-	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
-		hlist_del(&ri->hlist);
+	node = rp->freelist.head;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, freelist);
+		node = node->next;
+
 		kfree(ri);
 		count++;
 	}
@@ -1925,32 +1925,26 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	unsigned long flags = 0;
 	struct kretprobe_instance *ri;
+	struct freelist_node *fn;
 
-	/* TODO: consider to only swap the RA after the last pre_handler fired */
-	raw_spin_lock_irqsave(&rp->lock, flags);
-	if (!hlist_empty(&rp->free_instances)) {
-		ri = hlist_entry(rp->free_instances.first,
-				struct kretprobe_instance, hlist);
-		hlist_del(&ri->hlist);
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
-
-		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			raw_spin_lock_irqsave(&rp->lock, flags);
-			hlist_add_head(&ri->hlist, &rp->free_instances);
-			raw_spin_unlock_irqrestore(&rp->lock, flags);
-			return 0;
-		}
-
-		arch_prepare_kretprobe(ri, regs);
+	fn = freelist_try_get(&rp->freelist);
+	if (!fn) {
+		rp->nmissed++;
+		return 0;
+	}
 
-		__llist_add(&ri->llist, &current->kretprobe_instances);
+	ri = container_of(fn, struct kretprobe_instance, freelist);
 
-	} else {
-		rp->nmissed++;
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
+	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
+		freelist_add(&ri->freelist, &rp->freelist);
+		return 0;
 	}
+
+	arch_prepare_kretprobe(ri, regs);
+
+	__llist_add(&ri->llist, &current->kretprobe_instances);
+
 	return 0;
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
@@ -2007,8 +2001,7 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
-	raw_spin_lock_init(&rp->lock);
-	INIT_HLIST_HEAD(&rp->free_instances);
+	rp->freelist.head = NULL;
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
 	if (!rp->rph)
 		return -ENOMEM;
@@ -2023,8 +2016,7 @@ int register_kretprobe(struct kretprobe *rp)
 			return -ENOMEM;
 		}
 		inst->rph = rp->rph;
-		INIT_HLIST_NODE(&inst->hlist);
-		hlist_add_head(&inst->hlist, &rp->free_instances);
+		freelist_add(&inst->freelist, &rp->freelist);
 	}
 	refcount_set(&rp->rph->ref, i);
 
