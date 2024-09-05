Return-Path: <linux-tip-commits+bounces-2178-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2E96DD32
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0201C235FE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5A19F110;
	Thu,  5 Sep 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUgerZRH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QiLkahFF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F6199EA1;
	Thu,  5 Sep 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548609; cv=none; b=sbSen9BaE+y6ioij9Nl+34LkMHBcuSdXRGaJtyQHTMueau/7bTwDUWqjA2jVtbjFfoRSOFpWmCV4UOEWqBhMlCJsKywf/PEI11OfEXBvq09KCP2Ypa2yqTPzT158D42eq8lu9vVCwKdZ5QyhaztWuE/6dTe4pMDHjMZ31sS3KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548609; c=relaxed/simple;
	bh=mJNdOVCAGEMJgo/BAvFE8eGrWi+SfojZbpP9J0AmDzU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RtyS2xcU7jIQAQowe5d0Sn5qgPPqrYgTyCaYBl4ajBu5Dfch7vr6Le82mpttZFbiIVC3E95g//9caYyhoQQAAVrzC5kmJNMwOtCD7omQXeR4Jj6wNdsJJM0JbvjJ6GTjC+8dhRh80HTRdGOcRrz9wOukfVVNAVt5fSwK7ylKd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUgerZRH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QiLkahFF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgGo8YOoWiJnsQRyhj3nALS0SK9Tlmp5/yvdyVvpwHE=;
	b=oUgerZRHXv4Qizxk2nYfAiCbKGKI8baUZQ6KTbroYpFVYp50o87e9GkUQem48YAA1O0rdo
	D+vzVsA/QCTEscrFAC9LfaNXC2L0HGrVVALDOqZwE+3AXT0XNcMhUheieIdA1JrrCqOTPP
	ks8TtJCYlp8TGNSeP5rPj59++e2n5yLohYQ16NDIxKfVOPq7Gl2EEHBjdnYixZNr1zaXkG
	r5tdExCOehRUW50zROyTp/VBfiGG9tZz8pf1jvnkLI6NyT9ra/6j77TiGmJCJQ0tbEYMVr
	a7iE1FGznyqRz+S1dEZ83+duUko4QG9FcrdIKuVcXjWBU1G1/0Icue0pGa1adg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgGo8YOoWiJnsQRyhj3nALS0SK9Tlmp5/yvdyVvpwHE=;
	b=QiLkahFF9jf9Geg9IMfsAtnUuFqmeGR3X3jvSmq0ju9VMw+OvJH1Ldd6bUC2/uoOYCOuP1
	XEz7YgGL95ZUu8CA==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
Cc: Andrii Nakryiko <andrii@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903174603.3554182-5-andrii@kernel.org>
References: <20240903174603.3554182-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860568.2215.6596675718890036840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cc01bd044e6a521d2cd128f685ee8d23ef0067f2
Gitweb:        https://git.kernel.org/tip/cc01bd044e6a521d2cd128f685ee8d23ef0067f2
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Tue, 03 Sep 2024 10:45:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:14 +02:00

uprobes: travers uprobe's consumer list locklessly under SRCU protection

uprobe->register_rwsem is one of a few big bottlenecks to scalability of
uprobes, so we need to get rid of it to improve uprobe performance and
multi-CPU scalability.

First, we turn uprobe's consumer list to a typical doubly-linked list
and utilize existing RCU-aware helpers for traversing such lists, as
well as adding and removing elements from it.

For entry uprobes we already have SRCU protection active since before
uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
won't go away from under us, but we add SRCU protection around consumer
list traversal.

Lastly, to keep handler_chain()'s UPROBE_HANDLER_REMOVE handling simple,
we remember whether any removal was requested during handler calls, but
then we double-check the decision under a proper register_rwsem using
consumers' filter callbacks. Handler removal is very rare, so this extra
lock won't hurt performance, overall, but we also avoid the need for any
extra protection (e.g., seqcount locks).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240903174603.3554182-5-andrii@kernel.org
---
 include/linux/uprobes.h |  10 +++-
 kernel/events/uprobes.c | 104 ++++++++++++++++++++++-----------------
 2 files changed, 70 insertions(+), 44 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 63ae2ad..f112b56 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -29,13 +29,21 @@ struct page;
 #define MAX_URETPROBE_DEPTH		64
 
 struct uprobe_consumer {
+	/*
+	 * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
+	 * unregister uprobe for current process. If UPROBE_HANDLER_REMOVE is
+	 * returned, filter() callback has to be implemented as well and it
+	 * should return false to "confirm" the decision to uninstall uprobe
+	 * for the current process. If filter() is omitted or returns true,
+	 * UPROBE_HANDLER_REMOVE is effectively ignored.
+	 */
 	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
 				struct pt_regs *regs);
 	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
-	struct uprobe_consumer *next;
+	struct list_head cons_node;
 };
 
 #ifdef CONFIG_UPROBES
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 87b499c..e15c030 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -59,7 +59,7 @@ struct uprobe {
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
-	struct uprobe_consumer	*consumers;
+	struct list_head	consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
 	struct rcu_head		rcu;
 	loff_t			offset;
@@ -783,6 +783,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->inode = inode;
 	uprobe->offset = offset;
 	uprobe->ref_ctr_offset = ref_ctr_offset;
+	INIT_LIST_HEAD(&uprobe->consumers);
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 	RB_CLEAR_NODE(&uprobe->rb_node);
@@ -808,32 +809,19 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
-	uc->next = uprobe->consumers;
-	uprobe->consumers = uc;
+	list_add_rcu(&uc->cons_node, &uprobe->consumers);
 	up_write(&uprobe->consumer_rwsem);
 }
 
 /*
  * For uprobe @uprobe, delete the consumer @uc.
- * Return true if the @uc is deleted successfully
- * or return false.
+ * Should never be called with consumer that's not part of @uprobe->consumers.
  */
-static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static void consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
-	struct uprobe_consumer **con;
-	bool ret = false;
-
 	down_write(&uprobe->consumer_rwsem);
-	for (con = &uprobe->consumers; *con; con = &(*con)->next) {
-		if (*con == uc) {
-			*con = uc->next;
-			ret = true;
-			break;
-		}
-	}
+	list_del_rcu(&uc->cons_node);
 	up_write(&uprobe->consumer_rwsem);
-
-	return ret;
 }
 
 static int __copy_insn(struct address_space *mapping, struct file *filp,
@@ -929,7 +917,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1125,18 +1114,29 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	int err;
 
 	down_write(&uprobe->register_rwsem);
-	if (WARN_ON(!consumer_del(uprobe, uc))) {
-		err = -ENOENT;
-	} else {
-		err = register_for_each_vma(uprobe, NULL);
-		/* TODO : cant unregister? schedule a worker thread */
-		if (unlikely(err))
-			uprobe_warn(current, "unregister, leaking uprobe");
-	}
+	consumer_del(uprobe, uc);
+	err = register_for_each_vma(uprobe, NULL);
 	up_write(&uprobe->register_rwsem);
 
-	if (!err)
-		put_uprobe(uprobe);
+	/* TODO : cant unregister? schedule a worker thread */
+	if (unlikely(err)) {
+		uprobe_warn(current, "unregister, leaking uprobe");
+		goto out_sync;
+	}
+
+	put_uprobe(uprobe);
+
+out_sync:
+	/*
+	 * Now that handler_chain() and handle_uretprobe_chain() iterate over
+	 * uprobe->consumers list under RCU protection without holding
+	 * uprobe->register_rwsem, we need to wait for RCU grace period to
+	 * make sure that we can't call into just unregistered
+	 * uprobe_consumer's callbacks anymore. If we don't do that, fast and
+	 * unlucky enough caller can free consumer's memory and cause
+	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
+	 */
+	synchronize_srcu(&uprobes_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
@@ -1214,13 +1214,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
 int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
 {
 	struct uprobe_consumer *con;
-	int ret = -ENOENT;
+	int ret = -ENOENT, srcu_idx;
 
 	down_write(&uprobe->register_rwsem);
-	for (con = uprobe->consumers; con && con != uc ; con = con->next)
-		;
-	if (con)
-		ret = register_for_each_vma(uprobe, add ? uc : NULL);
+
+	srcu_idx = srcu_read_lock(&uprobes_srcu);
+	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
+		if (con == uc) {
+			ret = register_for_each_vma(uprobe, add ? uc : NULL);
+			break;
+		}
+	}
+	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+
 	up_write(&uprobe->register_rwsem);
 
 	return ret;
@@ -2085,10 +2092,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
+	bool has_consumers = false;
 
-	down_read(&uprobe->register_rwsem);
 	current->utask->auprobe = &uprobe->arch;
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2101,17 +2110,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 			need_prep = true;
 
 		remove &= rc;
+		has_consumers = true;
 	}
 	current->utask->auprobe = NULL;
 
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
 
-	if (remove && uprobe->consumers) {
-		WARN_ON(!uprobe_is_active(uprobe));
-		unapply_uprobe(uprobe, current->mm);
+	if (remove && has_consumers) {
+		down_read(&uprobe->register_rwsem);
+
+		/* re-check that removal is still required, this time under lock */
+		if (!filter_chain(uprobe, current->mm)) {
+			WARN_ON(!uprobe_is_active(uprobe));
+			unapply_uprobe(uprobe, current->mm);
+		}
+
+		up_read(&uprobe->register_rwsem);
 	}
-	up_read(&uprobe->register_rwsem);
 }
 
 static void
@@ -2119,13 +2135,15 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
+	int srcu_idx;
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	srcu_idx = srcu_read_lock(&uprobes_srcu);
+	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
+				 srcu_read_lock_held(&uprobes_srcu)) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	up_read(&uprobe->register_rwsem);
+	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }
 
 static struct return_instance *find_next_ret_chain(struct return_instance *ri)

