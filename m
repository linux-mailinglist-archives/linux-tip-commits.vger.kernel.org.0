Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6C2692DF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgINRSV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:18:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgINRQ2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:28 -0400
Date:   Mon, 14 Sep 2020 17:16:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FsUog+r+POly/Z8fyPdgm3YxD1dsKgoR0/JVZmeEYY4=;
        b=EwVR9+Sf47jHhw9Xnq8DT1+h5Vs2jEmawwNYYPzwmpwWeEdl6REVcAM0LapLiwxrDt8LW7
        538LtB0ter1h6rRlBhowGz0b4jn2P+rj3RdCsYaRey2DuVnmfS2LiYqehT6N6VVVpUIbuR
        SnB91zh8gRNxuh4rv8ymnQ0DNYYstFCNHRYHqAVD8i4oKUPNuFOWMKVbJLzD01ayaiBh+O
        bzIbfucQavmBamdAEA8Yj1aWCDcpLPsjhw2IqbjAoFBI4wSj0FwMnGsjehZk9H9E9Mz1cA
        dFhER011IhV/koMx2DFiLJQhWxj2sPFW/FnrXMH56gWX/omfYx7pieH2da2IsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FsUog+r+POly/Z8fyPdgm3YxD1dsKgoR0/JVZmeEYY4=;
        b=JxxJz4uYbc4BMZFJ/IiPW8udKfOQAIN9jscErXhpviW4AF4LshrXFVumc1XAUQEBpzdpU4
        A4ZnPB3l+2jCrtCA==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] kprobes: Add generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870600138.1229682.3424065380448088833.stgit@devnote2>
References: <159870600138.1229682.3424065380448088833.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010378402.15536.1881417790206204524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     66ada2ccae4ed4dd07ba91df3b5fdb4c11335bd1
Gitweb:        https://git.kernel.org/tip/66ada2ccae4ed4dd07ba91df3b5fdb4c11335bd1
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:00:01 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:31 +02:00

kprobes: Add generic kretprobe trampoline handler

Add a generic kretprobe trampoline handler for unifying
the all cloned /arch/* kretprobe trampoline handlers.

The generic kretprobe trampoline handler is based on the
x86 implementation, because it is the latest implementation.
It has frame pointer checking, kprobe_busy_begin/end and
return address fixup for user handlers.

[ mingo: Minor edits. ]

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870600138.1229682.3424065380448088833.stgit@devnote2
---
 include/linux/kprobes.h | 32 +++++++++++--
 kernel/kprobes.c        | 98 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9be1bff..72142ae 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -187,10 +187,38 @@ static inline int kprobes_built_in(void)
 	return 1;
 }
 
+extern struct kprobe kprobe_busy;
+extern void kprobe_busy_begin(void);
+extern void kprobe_busy_end(void);
+
 #ifdef CONFIG_KRETPROBES
 extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
 extern int arch_trampoline_kprobe(struct kprobe *p);
+
+/* If the trampoline handler called from a kprobe, use this version */
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+				void *trampoline_address,
+				void *frame_pointer);
+
+static nokprobe_inline
+unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
+				void *trampoline_address,
+				void *frame_pointer)
+{
+	unsigned long ret;
+	/*
+	 * Set a dummy kprobe for avoiding kretprobe recursion.
+	 * Since kretprobe never runs in kprobe handler, no kprobe must
+	 * be running at this point.
+	 */
+	kprobe_busy_begin();
+	ret = __kretprobe_trampoline_handler(regs, trampoline_address, frame_pointer);
+	kprobe_busy_end();
+
+	return ret;
+}
+
 #else /* CONFIG_KRETPROBES */
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
@@ -354,10 +382,6 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
 
-extern struct kprobe kprobe_busy;
-void kprobe_busy_begin(void);
-void kprobe_busy_end(void);
-
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263..a0afaa7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1927,6 +1927,104 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 }
 
 #ifdef CONFIG_KRETPROBES
+
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+					     void *trampoline_address,
+					     void *frame_pointer)
+{
+	struct kretprobe_instance *ri = NULL, *last = NULL;
+	struct hlist_head *head, empty_rp;
+	struct hlist_node *tmp;
+	unsigned long flags;
+	kprobe_opcode_t *correct_ret_addr = NULL;
+	bool skipped = false;
+
+	INIT_HLIST_HEAD(&empty_rp);
+	kretprobe_hash_lock(current, &head, &flags);
+
+	/*
+	 * It is possible to have multiple instances associated with a given
+	 * task either because multiple functions in the call path have
+	 * return probes installed on them, and/or more than one
+	 * return probe was registered for a target function.
+	 *
+	 * We can handle this because:
+	 *     - instances are always pushed into the head of the list
+	 *     - when multiple return probes are registered for the same
+	 *	 function, the (chronologically) first instance's ret_addr
+	 *	 will be the real return address, and all the rest will
+	 *	 point to kretprobe_trampoline.
+	 */
+	hlist_for_each_entry(ri, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+		/*
+		 * Return probes must be pushed on this hash list correct
+		 * order (same as return order) so that it can be popped
+		 * correctly. However, if we find it is pushed it incorrect
+		 * order, this means we find a function which should not be
+		 * probed, because the wrong order entry is pushed on the
+		 * path of processing other kretprobe itself.
+		 */
+		if (ri->fp != frame_pointer) {
+			if (!skipped)
+				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
+			skipped = true;
+			continue;
+		}
+
+		correct_ret_addr = ri->ret_addr;
+		if (skipped)
+			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
+				ri->rp->kp.addr);
+
+		if (correct_ret_addr != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_assert(ri, (unsigned long)correct_ret_addr,
+			     (unsigned long)trampoline_address);
+	last = ri;
+
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+		if (ri->fp != frame_pointer)
+			continue;
+
+		if (ri->rp && ri->rp->handler) {
+			struct kprobe *prev = kprobe_running();
+
+			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			ri->ret_addr = correct_ret_addr;
+			ri->rp->handler(ri, regs);
+			__this_cpu_write(current_kprobe, prev);
+		}
+
+		recycle_rp_inst(ri, &empty_rp);
+
+		if (ri == last)
+			break;
+	}
+
+	kretprobe_hash_unlock(current, &flags);
+
+	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
+		hlist_del(&ri->hlist);
+		kfree(ri);
+	}
+
+	return (unsigned long)correct_ret_addr;
+}
+NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
+
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.
