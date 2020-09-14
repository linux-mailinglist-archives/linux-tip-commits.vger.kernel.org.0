Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822A72692E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgINRTV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:19:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgINRQ0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:26 -0400
Date:   Mon, 14 Sep 2020 17:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLG9yEbhfzjKMQOnGAENID9F89xkk0rQSS9rVo4eL3o=;
        b=IPuND0N6ZhiTMYXIs7pCa33wmmGuVU3kIW3dL7UqSbwcrXikmUKF+Gd/II9sB0NDq/r1ar
        ePrmqymV/xVUmV9Jmu7Xeqjsjfjo9bWinWwCXzAMcw9BLHco7DWFVvLlCPAPj9WPAhV//k
        Hz3KUIPe0Wd8//It5u1+fefxhoGaBQqhuz3V7bh6tAe9Wfy/pfZzjXI/fIVy5rT35Lr2sf
        aZgLRiojMwpPZ2gofKkZyFceeItRrj/gMfyn4LI2yidbKbDkADMSb6OF/4M2slT61OJZHA
        SgwpiAy9NU3g4vokJEJ0RpkOw+dMQtMsKBAO49dF6szMlVZAfdMMBM9MHFaEGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLG9yEbhfzjKMQOnGAENID9F89xkk0rQSS9rVo4eL3o=;
        b=/64/E3XXoQ5q2EyfZeQvlL8cyQHwngjA0gTTlmGJjVNM7rxEk89qyfW+oBQwtSRyxjpMyr
        uxvhDGHIdBwQ8fBw==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] powerpc: kprobes: Use generic kretprobe
 trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870610825.1229682.2090635992093223399.stgit@devnote2>
References: <159870610825.1229682.2090635992093223399.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377739.15536.14273758940900599982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     b6c5a58dd89e683e66b52a57a6f022fda79a0aab
Gitweb:        https://git.kernel.org/tip/b6c5a58dd89e683e66b52a57a6f022fda79a0aab
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:01:48 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:34 +02:00

powerpc: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870610825.1229682.2090635992093223399.stgit@devnote2
---
 arch/powerpc/kernel/kprobes.c | 53 +---------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 6ab9b4d..01ab216 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -218,6 +218,7 @@ bool arch_kprobe_on_func_entry(unsigned long offset)
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->link;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->link = (unsigned long)kretprobe_trampoline;
@@ -396,50 +397,9 @@ asm(".global kretprobe_trampoline\n"
  */
 static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
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
-	 *       function, the first instance's ret_addr will point to the
-	 *       real return address, and all the rest will point to
-	 *       kretprobe_trampoline
-	 */
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		if (ri->rp && ri->rp->handler)
-			ri->rp->handler(ri, regs);
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
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
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
+	unsigned long orig_ret_address;
 
+	orig_ret_address = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 	/*
 	 * We get here through one of two paths:
 	 * 1. by taking a trap -> kprobe_handler() -> here
@@ -458,13 +418,6 @@ static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 	regs->nip = orig_ret_address - 4;
 	regs->link = orig_ret_address;
 
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
 	return 0;
 }
 NOKPROBE_SYMBOL(trampoline_probe_handler);
