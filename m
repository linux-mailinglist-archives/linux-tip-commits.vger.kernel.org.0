Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832332692D5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgINRQs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:16:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINRQZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:25 -0400
Date:   Mon, 14 Sep 2020 17:16:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tyv+pYPSvqz2+r6mgqlrV3DT7i0c+lUUBJhCy9/1LFk=;
        b=a+Ek0K8GYxldhpz6isIB/HKilL5Abb2jsnMKnNwvzPauBuOUUAyNgCasq0pSRwZobEZGtm
        QJuQoi+J4vuFmD2zviR0aHn64N5DkTWkwtaQEgXdDKxVsFnrdj0Eg+uGUwel4P5E6LJG8U
        mPEOQQh0C6+bBz7BZN1nTCRzMzBQjYBsAwBfEZOgkBQCn1kXThmBpjILg+mzlcnAMyzE2h
        t1EebgbdTBtJYRXb71UDofhR2WOFsyb1sbVb7qosxsyut8Nt1D1yZEOWCmTX+TmaGYeUzc
        DVkp/Tdir1AjclzhTVee0JdM+nZ6MO/0iyjar02rANq20VIbeQHunpx8XriQQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tyv+pYPSvqz2+r6mgqlrV3DT7i0c+lUUBJhCy9/1LFk=;
        b=Y/B3m56RxaP7nlFjzeSuxmhZBgLaDiTT5B1+TGuYMy50WJSvk6zzoMVPAaSH+9YBgLM+8K
        v5QZMGf4N2E3BVCA==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] ia64: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870606883.1229682.12331813108378725668.stgit@devnote2>
References: <159870606883.1229682.12331813108378725668.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377958.15536.15628800320542363117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     e792ff804f49720ce003b3e4c618b5d996256a18
Gitweb:        https://git.kernel.org/tip/e792ff804f49720ce003b3e4c618b5d996256a18
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:01:09 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:33 +02:00

ia64: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870606883.1229682.12331813108378725668.stgit@devnote2
---
 arch/ia64/kernel/kprobes.c | 77 +-------------------------------------
 1 file changed, 2 insertions(+), 75 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 7a7df94..fc1ff8a 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -396,83 +396,9 @@ static void kretprobe_trampoline(void)
 {
 }
 
-/*
- * At this point the target function has been tricked into
- * returning into our trampoline.  Lookup the associated instance
- * and then:
- *    - call the handler function
- *    - cleanup by marking the instance as unused
- *    - long jump back to the original return address
- */
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address =
-		((struct fnptr *)kretprobe_trampoline)->ip;
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
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	regs->cr_iip = orig_ret_address;
-
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
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
@@ -485,6 +411,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->b0;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->b0 = ((struct fnptr *)kretprobe_trampoline)->ip;
