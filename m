Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3838A2692EF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgINRTy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:19:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgINRQ0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:26 -0400
Date:   Mon, 14 Sep 2020 17:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103779;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQjCwc658wg8zQrilCE211sRSNCKT6DpDv/bpg8+wxA=;
        b=fW1L0LR202CuZ0xxpYlH6rOEnMJONJ8xkaWvFFudghm6epOkm1SW7ZBRSpoAxtJOR21ZuE
        a7Qu10LZ4zJVJOiW9nt+9updcA/jKlCmQcFdZweoCJecU1amsEkuoo1J+kJ8KCT5n00ZjH
        Ro9nWUu1Ej0SaP7arpT2TRL9vDVIYzRqcQ4m+tKU42F1yV3KHzcYdVmBIlR+KAoDZvvAo9
        HhpnZ5CiKT5Tc4y3iqyaSCTk4jzcuNkChZQMFu4/+s1Dl3ZF8+9lvgrHbwxmyTVvUvq10t
        /kSST6x7rXI8u0tWi2uwUpW6XvsigNycq/Hvnl9m/YHMeZLnB0JqCvcvQh/DNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103779;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQjCwc658wg8zQrilCE211sRSNCKT6DpDv/bpg8+wxA=;
        b=PkCP+l9/CxpGaeDfWmgSf8iDElus6FJyi/BK7jzYoqUcqMF1lIYUWEuahtYnhtNurQECK+
        EXoPBph30z4ml8Cg==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] mips: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870607968.1229682.12100697467108845587.stgit@devnote2>
References: <159870607968.1229682.12100697467108845587.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377889.15536.48836098631635077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     2ef12450856121f092621d4305885ec20283260e
Gitweb:        https://git.kernel.org/tip/2ef12450856121f092621d4305885ec20283260e
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:01:19 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:33 +02:00

mips: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870607968.1229682.12100697467108845587.stgit@devnote2
---
 arch/mips/kernel/kprobes.c | 54 ++-----------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index d043c2f..54dfba8 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -477,6 +477,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->regs[31];
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->regs[31] = (unsigned long)kretprobe_trampoline;
@@ -488,57 +489,8 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 						struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)kretprobe_trampoline;
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
-	instruction_pointer(regs) = orig_ret_address;
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs,
+						kretprobe_trampoline, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
