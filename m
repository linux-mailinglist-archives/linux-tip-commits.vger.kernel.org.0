Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997AD2692F2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgINRUI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:20:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgINRQZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:25 -0400
Date:   Mon, 14 Sep 2020 17:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEj6d9dgp1RaJJkaoyihML9XhKgd8zgiueN4KYGz4Yc=;
        b=h3rndOFb0EDXpmwYnX4eGjIizCUPVNt8Rfzf34Z1HbsXpIRL/K1zxbAoAsEjJOtoBu4X+R
        V6APHgtiTEkK2lxZ5PDWCx1KQQf4wVSxvBtIA83TLLPUhIdHLIL1JQubNDZc02Vzgw4cNK
        qxkxKxqiRB8BSWWwoybAw8f1gPU0ObnWJUNEe3A8WJ5TIB/ZcmEjdi+ZDLeks6sEoP961Q
        WzSzmTT1WwiocmXC0tYlCLrCMtyzgnfjN63Gzom0t8aBsJZToILYwGYYfvHIwGdloQs/y4
        eBechrdIRCSohvbGnTrPDkhWpFtfpCCUhFilDGsy3u3of9DLUJJsKq+dYiPOyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEj6d9dgp1RaJJkaoyihML9XhKgd8zgiueN4KYGz4Yc=;
        b=3VIm7dm3ENRJxsIqCECZGuB9vsDMTeDjT+dztTJZ4tfTzNOmvd3gktjfK70Imihm8Ox6JZ
        mnMvqSDqKmTIv7Cw==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] parisc: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870609708.1229682.1861714117180719169.stgit@devnote2>
References: <159870609708.1229682.1861714117180719169.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377817.15536.2150331242145771205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     16ff6f7ac92e506a05d3720e4d9fa0647bb0b5c4
Gitweb:        https://git.kernel.org/tip/16ff6f7ac92e506a05d3720e4d9fa0647bb0b5c4
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:01:37 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:33 +02:00

parisc: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870609708.1229682.1861714117180719169.stgit@devnote2
---
 arch/parisc/kernel/kprobes.c | 76 +----------------------------------
 1 file changed, 4 insertions(+), 72 deletions(-)

diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
index 77ec518..6d21a51 100644
--- a/arch/parisc/kernel/kprobes.c
+++ b/arch/parisc/kernel/kprobes.c
@@ -191,80 +191,11 @@ static struct kprobe trampoline_p = {
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)trampoline_p.addr;
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
+	unsigned long orig_ret_address;
 
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	orig_ret_address = __kretprobe_trampoline_handler(regs, trampoline_p.addr, NULL);
 	instruction_pointer_set(regs, orig_ret_address);
+
 	return 1;
 }
 
@@ -272,6 +203,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->gr[2];
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr. */
 	regs->gr[2] = (unsigned long)trampoline_p.addr;
