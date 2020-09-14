Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580402692EB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgINRTs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgINRQ0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D0C061797;
        Mon, 14 Sep 2020 10:16:23 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:16:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pH/+tl5cHpjM41RgWnBdcxB/tW0Cpry4VwFznAKwePE=;
        b=HgkBeJviS9t6WK+zSeORAaG4P4pg6f6KvTR6osGSj3/+lyqVYsRPiPd3ubwE2uhIbwGNGY
        dpdVMYUoyPe8H2rY4BFPl944KvLGn6kdU5QPG30cOAqY+i8c733bh3STBNY9esZyrg4fpE
        XRry6KiGnF9fbE8R7uX6LPILE6JTAaxzLmDLe1/ksstQKSTUEK0v2YLEx89NmhmsZfCJWv
        nlP0j6wrLh3PJj30f1BPOntSCF2k2KjWMz9k9tLe8URb7SNPn92GqSbEZq7l+XlK8Lrze/
        Lb/qEc9Pxe96y41C/37X68ggrfgGwQgAs2R6yd+zOI7aU1ATEWquvkA2sWVdfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pH/+tl5cHpjM41RgWnBdcxB/tW0Cpry4VwFznAKwePE=;
        b=xlcRvXi2l9oe+oHmgE4AOtzycpQ2T1PcO3Erqe//dYm8CfGTYoi+aHrxZUl9oee8Qh+NbU
        Az6XkZJaurpTjiAw==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] arc: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870604671.1229682.13639386820521358456.stgit@devnote2>
References: <159870604671.1229682.13639386820521358456.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010378102.15536.2934966464230346763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     f75dd136b65cccfaf3869be5380f401538fa9f72
Gitweb:        https://git.kernel.org/tip/f75dd136b65cccfaf3869be5380f401538fa9f72
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:00:46 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:32 +02:00

arc: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870604671.1229682.13639386820521358456.stgit@devnote2
---
 arch/arc/kernel/kprobes.c | 54 +-------------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 7d3efe8..cabef45 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -388,6 +388,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 {
 
 	ri->ret_addr = (kprobe_opcode_t *) regs->blink;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->blink = (unsigned long)&kretprobe_trampoline;
@@ -396,58 +397,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
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
-		if (orig_ret_address != trampoline_address) {
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-		}
-	}
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-	regs->ret = orig_ret_address;
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	regs->ret = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 
 	/* By returning a non zero value, we are telling the kprobe handler
 	 * that we don't want the post_handler to run
