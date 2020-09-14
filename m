Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C52692D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINRRB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgINRQY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C76C06178B;
        Mon, 14 Sep 2020 10:16:18 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdaQ/y5Lr4/8/YMRvLd6ieS1aFJezy9dlEVQTLd1L7A=;
        b=PJnQ4J3niY8YKhw/oMmrCn21OAso+NHxuJaJP84VKCpe5/JWqXWrv0bZ9yqRmKRwVWWDjW
        3LfkXwWcnv3NgrobCydbAR0ZoyHAW1yJi5yLt9VA/1uGGNoRwAPD1Nn6RuMOYpqUYlBVVF
        Zb5kl9rjkZwoBx3WhA1UMH7iTYRRlhOWxwWMaOBjcoNzQAsYfBP+W8G9+9lJIFsoAP/wGN
        SQEZrj0GnMGUcUZ1i9VoLDu84wO6rXRDjMhbbzVR4pIBHMwHvvfo68GjUyOLnHl9aXtXNu
        yd4oOjzt7Zg9IvOyP5bZP9x4voTjTyXk7hKM05nG1WvECz+r+lX1HrmkLI/DeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdaQ/y5Lr4/8/YMRvLd6ieS1aFJezy9dlEVQTLd1L7A=;
        b=O/y7Jo60jtHzQwbbKkCm3A/cYG07S0duqzN96u/Ah14iqa2TOh+dZeU7kiwaYjjFCl45/j
        S6cmZKgov5cPufCg==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] sh: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870613547.1229682.15519965962108261812.stgit@devnote2>
References: <159870613547.1229682.15519965962108261812.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377593.15536.13192390736971768902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     0cf0e2fe91fade050bfda2a7240550ba6106b760
Gitweb:        https://git.kernel.org/tip/0cf0e2fe91fade050bfda2a7240550ba6106b760
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:02:15 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:34 +02:00

sh: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870613547.1229682.15519965962108261812.stgit@devnote2
---
 arch/sh/kernel/kprobes.c | 58 ++-------------------------------------
 1 file changed, 3 insertions(+), 55 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 318296f..756100b 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -204,6 +204,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->pr;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->pr = (unsigned long)kretprobe_trampoline;
@@ -302,62 +303,9 @@ static void __used kretprobe_trampoline_holder(void)
  */
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
+	regs->pc = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because an multiple functions in the call path
-	 * have a return probe installed on them, and/or more then one return
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
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
-		}
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
-
-	regs->pc = orig_ret_address;
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
-	return orig_ret_address;
+	return 1;
 }
 
 static int __kprobes post_kprobe_handler(struct pt_regs *regs)
