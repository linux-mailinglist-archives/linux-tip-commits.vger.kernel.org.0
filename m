Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005522692E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgINRTS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgINRQ2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C084EC061352;
        Mon, 14 Sep 2020 10:16:24 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:16:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlBanbMnIVXgx7swjYOyx1lC3eXsXdtk9+WqTj2pd8M=;
        b=A745HWNNVHGvl5LZ6TPuQ+q96hP4crmcmu+muRWFP9w6tANChXK8l8BErLSWY7AITTy/hU
        73UwD6fPdGzWmoLAwFk9xrEcPfw3n5ZcqxMivZNolB2dclTBMK6Z+zfxlWrAQCjOu3KSwb
        SQ58WAd3RwbmdBYx+uSuH0DVJc9Hiw1A29281BTl/5TkEbbHVvICgq41vC8GF+bhML84/G
        c9ZxRMiPbkXcU2J2nCJpb2KqjnbMtPvfsSFkjGRzGuXGQebW9+/XfhvygR5/WZ1k5uYhAB
        QCXZgGiva/v5ewky+SK/M+InD/tMV/fSFFWJpp5Mjhh1FNAvbCrM3N43AUXy8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlBanbMnIVXgx7swjYOyx1lC3eXsXdtk9+WqTj2pd8M=;
        b=yxqJLe0escD8CBU6+E1pndbFT9XJF/zfdp5v3uq6QoXLb531oZAGom0Wi7p0DdQ1eAKgWz
        AP+wHuksgZUtcNCg==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] arm: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870602406.1229682.10496730247473708592.stgit@devnote2>
References: <159870602406.1229682.10496730247473708592.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010378260.15536.6528187294460469042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     94509582d1d173c4777b8832ecbac6dff2ccbfa7
Gitweb:        https://git.kernel.org/tip/94509582d1d173c4777b8832ecbac6dff2ccbfa7
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:00:24 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:32 +02:00

arm: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Use regs->ARM_fp
for framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870602406.1229682.10496730247473708592.stgit@devnote2
---
 arch/arm/probes/kprobes/core.c | 78 +--------------------------------
 1 file changed, 3 insertions(+), 75 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index feefa20..a965311 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -413,87 +413,15 @@ void __naked __kprobes kretprobe_trampoline(void)
 /* Called from kretprobe_trampoline */
 static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
-	kprobe_opcode_t *correct_ret_addr = NULL;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because multiple functions in the call path have
-	 * a return probe installed on them, and/or more than one return
-	 * probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always inserted at the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *       function, the first instance's ret_addr will point to the
-	 *       real return address, and all the rest will point to
-	 *       kretprobe_trampoline
-	 */
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-
-	correct_ret_addr = ri->ret_addr;
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
-			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
-		}
-
-		recycle_rp_inst(ri, &empty_rp);
-
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
-	return (void *)orig_ret_address;
+	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
+						    (void *)regs->ARM_fp);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->ARM_lr;
+	ri->fp = (void *)regs->ARM_fp;
 
 	/* Replace the return addr with trampoline addr. */
 	regs->ARM_lr = (unsigned long)&kretprobe_trampoline;
