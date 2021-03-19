Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555C341DFB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 14:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCSNST (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSNRw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 09:17:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45624C06174A;
        Fri, 19 Mar 2021 06:17:52 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:17:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616159870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ArjPz9hwoJl9auNJ0vto0zGB02WVusPgc04PlXb+uE=;
        b=DeewKvPGX/ezQTWXJaNMGaqz38PO8/Pe2f10kADmBH3pmzBq+zKjgKE/Cj3BNbV73/suRq
        5sONkG/uAGO4fBasgmUe8y92MbKRNxSVv/4c4wQi5Vsf7L1JXQdbytT3KJMVtVLkjOftfT
        cGseuttihRDT1ODYeJAaXn8JwrDmXgE8Q72tydQSMG4ojH3ngA3RfVp4lht4+6+rMMDRr1
        sJnec3xNhkk/z6+6QyuvI0wgr0NG0joSidtvrEAu/SCNrmNhvpgzgqwb3M8wf4WzqxERhd
        YmZJjWCKTsRQJv+NyVr8Fn/8xJHuSrPoGHZSv8JsDG6FDUDlErg3Zz+4dnIncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616159870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ArjPz9hwoJl9auNJ0vto0zGB02WVusPgc04PlXb+uE=;
        b=r3jX9pZrXReLM3XjvCEljhYA9t0m8XwQD8Dk/lakX72JUqj0MLIeo4B0AOEFN0BTqbxzPw
        +gzc/dV+TUYJnYBQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Optimize __sev_es_ist_enter() for better
 readability
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210303141716.29223-4-joro@8bytes.org>
References: <20210303141716.29223-4-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161615987012.398.914043660944501718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     799de1baaf3509a54ff713efb768020f8defd709
Gitweb:        https://git.kernel.org/tip/799de1baaf3509a54ff713efb768020f8defd709
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 03 Mar 2021 15:17:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 19 Mar 2021 13:37:22 +01:00

x86/sev-es: Optimize __sev_es_ist_enter() for better readability

Reorganize the code and improve the comments to make the function more
readable and easier to understand.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210303141716.29223-4-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 225704e..26f5479 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -137,29 +137,41 @@ static __always_inline bool on_vc_stack(struct pt_regs *regs)
 }
 
 /*
- * This function handles the case when an NMI is raised in the #VC exception
- * handler entry code. In this case, the IST entry for #VC must be adjusted, so
- * that any subsequent #VC exception will not overwrite the stack contents of the
- * interrupted #VC handler.
+ * This function handles the case when an NMI is raised in the #VC
+ * exception handler entry code, before the #VC handler has switched off
+ * its IST stack. In this case, the IST entry for #VC must be adjusted,
+ * so that any nested #VC exception will not overwrite the stack
+ * contents of the interrupted #VC handler.
  *
  * The IST entry is adjusted unconditionally so that it can be also be
- * unconditionally adjusted back in sev_es_ist_exit(). Otherwise a nested
- * sev_es_ist_exit() call may adjust back the IST entry too early.
+ * unconditionally adjusted back in __sev_es_ist_exit(). Otherwise a
+ * nested sev_es_ist_exit() call may adjust back the IST entry too
+ * early.
+ *
+ * The __sev_es_ist_enter() and __sev_es_ist_exit() functions always run
+ * on the NMI IST stack, as they are only called from NMI handling code
+ * right now.
  */
 void noinstr __sev_es_ist_enter(struct pt_regs *regs)
 {
 	unsigned long old_ist, new_ist;
 
 	/* Read old IST entry */
-	old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+	new_ist = old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
 
-	/* Make room on the IST stack */
+	/*
+	 * If NMI happened while on the #VC IST stack, set the new IST
+	 * value below regs->sp, so that the interrupted stack frame is
+	 * not overwritten by subsequent #VC exceptions.
+	 */
 	if (on_vc_stack(regs))
-		new_ist = ALIGN_DOWN(regs->sp, 8) - sizeof(old_ist);
-	else
-		new_ist = old_ist - sizeof(old_ist);
+		new_ist = regs->sp;
 
-	/* Store old IST entry */
+	/*
+	 * Reserve additional 8 bytes and store old IST value so this
+	 * adjustment can be unrolled in __sev_es_ist_exit().
+	 */
+	new_ist -= sizeof(old_ist);
 	*(unsigned long *)new_ist = old_ist;
 
 	/* Set new IST entry */
