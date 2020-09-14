Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8784E2692F4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgINRUN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgINRQY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDECC06178C;
        Mon, 14 Sep 2020 10:16:18 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOdK4WUx+PFRUf54PjmY35K8rG9zaF84eY43sLsjwM8=;
        b=nzeJ0q3ueBOwmaPSrv0GHBNgW/0QjKW73Fkz85IJtyTh3b7E7lvJ2B/Q/kBgnNRJY/FhDy
        IkJ4d+RuZD6F18vPFqMrc3vwyguAiLBq1U84SI1c1QqqCmH9If0s1x5zXn3U3l5An2VBHn
        ZLMFNp5DMAZMsW8MN94xhJfM27fYllfYdZSs8Jn3fBZDt8k7FRJ96Qt3nER+Tv9j7RentJ
        O2rWxxliQxGA4bIE2Y4p6MchYwnWQN/l37pc23EFyF9ROM040TUy9FStiN/Za0rfocrBHe
        1rpbC7W2HY/5kqgWqwkMZ+RgwPfAUnLg/kRfgVOBb8ktSOkHwvukETcQgZ7v9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOdK4WUx+PFRUf54PjmY35K8rG9zaF84eY43sLsjwM8=;
        b=9VXjHmHEK9KfqDlYUobJePkbBMEqadPxj0YJ6QfC6XsVgrNn5VSV/OcHpmpNqWsnWQzP1L
        xra+fo40jba5Y5Cg==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] s390: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870612453.1229682.15950927742606892302.stgit@devnote2>
References: <159870612453.1229682.15950927742606892302.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377663.15536.642471850976104031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     26a24a6b43d51c6fc70bef9b9016d81e4cf75e6e
Gitweb:        https://git.kernel.org/tip/26a24a6b43d51c6fc70bef9b9016d81e4cf75e6e
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:02:04 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:34 +02:00

s390: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870612453.1229682.15950927742606892302.stgit@devnote2
---
 arch/s390/kernel/kprobes.c | 79 +-------------------------------------
 1 file changed, 2 insertions(+), 77 deletions(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index d2a71d8..fc30e79 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -228,6 +228,7 @@ NOKPROBE_SYMBOL(pop_kprobe);
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->gprs[14];
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->gprs[14] = (unsigned long) &kretprobe_trampoline;
@@ -331,83 +332,7 @@ static void __used kretprobe_trampoline_holder(void)
  */
 static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address;
-	unsigned long trampoline_address;
-	kprobe_opcode_t *correct_ret_addr;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because an multiple functions in the call path
-	 * have a return probe installed on them, and/or more than one return
-	 * return probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always inserted at the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *	 function, the first instance's ret_addr will point to the
-	 *	 real return address, and all the rest will point to
-	 *	 kretprobe_trampoline
-	 */
-	ri = NULL;
-	orig_ret_address = 0;
-	correct_ret_addr = NULL;
-	trampoline_address = (unsigned long) &kretprobe_trampoline;
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		orig_ret_address = (unsigned long) ri->ret_addr;
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
-		orig_ret_address = (unsigned long) ri->ret_addr;
-
-		if (ri->rp && ri->rp->handler) {
-			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
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
-	regs->psw.addr = orig_ret_address;
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	regs->psw.addr = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
