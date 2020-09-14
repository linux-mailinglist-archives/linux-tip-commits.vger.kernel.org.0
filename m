Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8FF2692CF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgINRQ1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgINRQY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5CC06174A;
        Mon, 14 Sep 2020 10:16:16 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:16:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJtndh+Q7qp0zrdIKsuoXHaaA83pQzXtPICKZCe8ap8=;
        b=VkXkT75ZCZ9JCSnDdKqYlOdra3UwR0RAkrFXAiz5FWv5ueGQ/IEqmIIbEs4b8HxmpxSklL
        qWM0fWAKXJiD5ZyT9vhMMf/mS+xEO448oDXdmTGYk2D82Sqf5YvNcl2i9wdNyGtkO2VMkP
        A1Q1Wgp08RtQzd7+QrVzzKFlG7b3HPaa5eTchg8mKEUnkFfo8E7WlEFKNJCua2RMbV280I
        BdGyW8PRbNAfPu9VWWuLe8FTBea1e5JhqmhM7c9wkQmHWVtcbFm/pIkf+L5zZqvZQLKp0s
        lPToIq3dsgnNQozP7Sn/d/wbdqQarCrC4bTvuAvhXSqFYG0OivkaK2lUpyUXEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJtndh+Q7qp0zrdIKsuoXHaaA83pQzXtPICKZCe8ap8=;
        b=tDupPXkaCvYBbHlSVwI0VHD91RNAws3L/HaduHYvWdZPuSsyGg9rCMFG03X8BPR8oeHIt2
        B9Qh4/EB8S44BPCw==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] kprobes: Free kretprobe_instance with RCU callback
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870616685.1229682.11978742048709542226.stgit@devnote2>
References: <159870616685.1229682.11978742048709542226.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377373.15536.15527515602738803514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     b338817807538c893540e393856b79cbbdf777ea
Gitweb:        https://git.kernel.org/tip/b338817807538c893540e393856b79cbbdf777ea
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:02:47 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:35 +02:00

kprobes: Free kretprobe_instance with RCU callback

Free kretprobe_instance with RCU callback instead of directly
freeing the object in the kretprobe handler context.

This will make kretprobe run safer in NMI context.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870616685.1229682.11978742048709542226.stgit@devnote2
---
 include/linux/kprobes.h |  6 ++++--
 kernel/kprobes.c        | 25 ++++++-------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 72142ae..3389067 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -156,7 +156,10 @@ struct kretprobe {
 };
 
 struct kretprobe_instance {
-	struct hlist_node hlist;
+	union {
+		struct hlist_node hlist;
+		struct rcu_head rcu;
+	};
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
@@ -395,7 +398,6 @@ int register_kretprobes(struct kretprobe **rps, int num);
 void unregister_kretprobes(struct kretprobe **rps, int num);
 
 void kprobe_flush_task(struct task_struct *tk);
-void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
 
 int disable_kprobe(struct kprobe *kp);
 int enable_kprobe(struct kprobe *kp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2111382..0676868 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1223,8 +1223,7 @@ void kprobes_inc_nmissed_count(struct kprobe *p)
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
-void recycle_rp_inst(struct kretprobe_instance *ri,
-		     struct hlist_head *head)
+static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	struct kretprobe *rp = ri->rp;
 
@@ -1236,8 +1235,7 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
 		hlist_add_head(&ri->hlist, &rp->free_instances);
 		raw_spin_unlock(&rp->lock);
 	} else
-		/* Unregistering */
-		hlist_add_head(&ri->hlist, head);
+		kfree_rcu(ri, rcu);
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
@@ -1313,7 +1311,7 @@ void kprobe_busy_end(void)
 void kprobe_flush_task(struct task_struct *tk)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_head *head, empty_rp;
+	struct hlist_head *head;
 	struct hlist_node *tmp;
 	unsigned long hash, flags = 0;
 
@@ -1323,19 +1321,14 @@ void kprobe_flush_task(struct task_struct *tk)
 
 	kprobe_busy_begin();
 
-	INIT_HLIST_HEAD(&empty_rp);
 	hash = hash_ptr(tk, KPROBE_HASH_BITS);
 	head = &kretprobe_inst_table[hash];
 	kretprobe_table_lock(hash, &flags);
 	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
 		if (ri->task == tk)
-			recycle_rp_inst(ri, &empty_rp);
+			recycle_rp_inst(ri);
 	}
 	kretprobe_table_unlock(hash, &flags);
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
 
 	kprobe_busy_end();
 }
@@ -1936,13 +1929,12 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *frame_pointer)
 {
 	struct kretprobe_instance *ri = NULL, *last = NULL;
-	struct hlist_head *head, empty_rp;
+	struct hlist_head *head;
 	struct hlist_node *tmp;
 	unsigned long flags;
 	kprobe_opcode_t *correct_ret_addr = NULL;
 	bool skipped = false;
 
-	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 
 	/*
@@ -2011,7 +2003,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 			__this_cpu_write(current_kprobe, prev);
 		}
 
-		recycle_rp_inst(ri, &empty_rp);
+		recycle_rp_inst(ri);
 
 		if (ri == last)
 			break;
@@ -2019,11 +2011,6 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 
 	kretprobe_hash_unlock(current, &flags);
 
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
 	return (unsigned long)correct_ret_addr;
 }
 NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
