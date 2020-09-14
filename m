Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280CC2692D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgINRQ2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgINRQY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDBEC06178A;
        Mon, 14 Sep 2020 10:16:17 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnC0BBRdLpDkoDJDIHbRO7vMU4/ABMUnokc3JMyDZjU=;
        b=cMvoL7wfqfbbnukra0gcViZdMoQy8tVcdFGOWlJajx4XzbcRwsQV1f+cYsWsF+Wq0X2RFw
        N7BybqGnbvthVV6btHNOPxxpH8bpTTYYnBPW1HyYtK6uFrhsj31hb+39vOuDvDOu+7RoIV
        WOw0YxHWLBeHXPQblTvhI4ZbGrQE60KrvOqzO/gG/PuEYlXgfRosFKDspaUeb05qtGem+I
        XplzT4Mj4iG79xJhDnON0Fq0xnw7We3WMXkJCkicEfzD3MOR/ETWn8wBlNqMAY+u+pNbQB
        Q2BoITwPJ74WnvcyCbNzRYHoCG5lH/GgzQ/hlYiohvKalaXCArZ3/wErBrmbvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnC0BBRdLpDkoDJDIHbRO7vMU4/ABMUnokc3JMyDZjU=;
        b=+czFiAFKm6+unWsDAdFHvqQPt+SLuTzE4nPH6HTaqvVXSDGWG7bydHYx2x1YuI6IFW6PBZ
        dML1spW/bdPd7jCA==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] sparc: kprobes: Use generic kretprobe trampoline handler
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870614572.1229682.2273450776108579676.stgit@devnote2>
References: <159870614572.1229682.2273450776108579676.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377523.15536.175221749531504584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     5e96ce8ae5b1428e6f4953be5fb1daf0a6d18426
Gitweb:        https://git.kernel.org/tip/5e96ce8ae5b1428e6f4953be5fb1daf0a6d18426
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:02:25 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:35 +02:00

sparc: kprobes: Use generic kretprobe trampoline handler

Use the generic kretprobe trampoline handler. Don't use
framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870614572.1229682.2273450776108579676.stgit@devnote2
---
 arch/sparc/kernel/kprobes.c | 51 ++----------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index dfbca24..217c21a 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -453,6 +453,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)(regs->u_regs[UREG_RETPC] + 8);
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->u_regs[UREG_RETPC] =
@@ -465,58 +466,12 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
+	unsigned long orig_ret_address = 0;
 
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
+	orig_ret_address = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 	regs->tpc = orig_ret_address;
 	regs->tnpc = orig_ret_address + 4;
 
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
