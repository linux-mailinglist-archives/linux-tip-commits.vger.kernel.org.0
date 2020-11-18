Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985062B7D89
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 13:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKRMUk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 07:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgKRMUk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 07:20:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53677C0613D4;
        Wed, 18 Nov 2020 04:20:40 -0800 (PST)
Date:   Wed, 18 Nov 2020 12:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605702038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45nFyw7nelPjO0AqMdm7a6w0iCNxbTMhLeO/+LFCMPM=;
        b=yUDv7oqb9bphTZyU+s1e2sBJxCnQ6WkTOfiNmKdspS40KjU+EcxRnhzivCFw9bP3DHnfF+
        5C8GNXy/5roZIbezF4OMoylJbw/nV6u+Jy3MBoXwKlEVASU1nIOLkpd0fG1l6VwK31ysZw
        JCsSPOcNd2/1Mm3ZKxSHZLT41F0nJ2lHe3jzab/2yS6/6r16xY+KOGl61T5ThVz1PoTWhz
        TxIZyPlzfSJBsr3bhoDPAD9iyOzZQppfUugxwo79N5j2d8U1/28qq9uMoh1oTkwp/t6p+B
        Au/i0oXweMj7Qqskt+dnla6KUYr0QbZUBv4qhmnbVtUwe4/a/T51xNkGO1xfWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605702038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45nFyw7nelPjO0AqMdm7a6w0iCNxbTMhLeO/+LFCMPM=;
        b=ymwHkzG+aXnC/kQF7nIZMT1pvEhyYzPswKPT1+osMV3lVMtnkAjkDR5UT+dnVm0/9DmQuF
        N7j5ZTWesjdM66DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/dumpstack: Do not try to access user space code
 of other tasks
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117202753.667274723@linutronix.de>
References: <20201117202753.667274723@linutronix.de>
MIME-Version: 1.0
Message-ID: <160570203682.11244.2241309729043603979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     860aaabac8235cfde10fe556aa82abbbe3117888
Gitweb:        https://git.kernel.org/tip/860aaabac8235cfde10fe556aa82abbbe3117888
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Nov 2020 21:23:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 12:56:29 +01:00

x86/dumpstack: Do not try to access user space code of other tasks

sysrq-t ends up invoking show_opcodes() for each task which tries to access
the user space code of other processes, which is obviously bogus.

It either manages to dump where the foreign task's regs->ip points to in a
valid mapping of the current task or triggers a pagefault and prints "Code:
Bad RIP value.". Both is just wrong.

Add a safeguard in copy_code() and check whether the @regs pointer matches
currents pt_regs. If not, do not even try to access it.

While at it, add commentary why using copy_from_user_nmi() is safe in
copy_code() even if the function name suggests otherwise.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201117202753.667274723@linutronix.de
---
 arch/x86/kernel/dumpstack.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 25c06b6..97aa900 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -78,6 +78,9 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
 	if (!user_mode(regs))
 		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
 
+	/* The user space code from other tasks cannot be accessed. */
+	if (regs != task_pt_regs(current))
+		return -EPERM;
 	/*
 	 * Make sure userspace isn't trying to trick us into dumping kernel
 	 * memory by pointing the userspace instruction pointer at it.
@@ -85,6 +88,12 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
 	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
 		return -EINVAL;
 
+	/*
+	 * Even if named copy_from_user_nmi() this can be invoked from
+	 * other contexts and will not try to resolve a pagefault, which is
+	 * the correct thing to do here as this code can be called from any
+	 * context.
+	 */
 	return copy_from_user_nmi(buf, (void __user *)src, nbytes);
 }
 
@@ -115,13 +124,19 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 	u8 opcodes[OPCODE_BUFSIZE];
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
 
-	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
-		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
-		       loglvl, prologue);
-	} else {
+	switch (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
+	case 0:
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
 		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
 		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
+		break;
+	case -EPERM:
+		/* No access to the user space stack of other tasks. Ignore. */
+		break;
+	default:
+		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
+		       loglvl, prologue);
+		break;
 	}
 }
 
