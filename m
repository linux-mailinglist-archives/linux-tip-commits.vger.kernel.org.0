Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CAE40B7E7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhINTVH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhINTU6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7084AC061767;
        Tue, 14 Sep 2021 12:19:38 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:19:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huhEn4ApII0J+fqCg99Fp16u1MDkbAWSCNH6SNtChSQ=;
        b=HsXk7Ru9afk1XmDBedNBPnH37oUnH6qmFXKm5y7NzbY9K2zKU1kscNveTuWxCGb5YNT9xr
        4Y4errcx/v+GXtrZhjltQt5FNbO6XqlaiaixER3KYVx7fqrYXds8lWWVWqQqopPuccQCw7
        eGQlctoI9Es5JjPwVZEAa0p+X9zaZV1CiuQNtM7HgChc2aYRN3/p6G6vlzkzKyP1OCadcC
        3SnJSu5lqznmDaLBMTnOdC6FYChicQGC6MTUuWmaHpFWYzTiJOzWjoU9VnZedjXJST09WX
        KDmZGRo2H2lTv6dxRtFwi0mcpsnP8gr0lkZ3e9A0ckXYR/LcFuAgG95zKzGcOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huhEn4ApII0J+fqCg99Fp16u1MDkbAWSCNH6SNtChSQ=;
        b=+S/q9uzn6Q6BXt81MYzIgrrt46rzKETVH5+7/n542MOB3KPECq08OmIr2fONUzhxAGajju
        TPDr0YDqDJgGELCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/mce: Deduplicate exception handling
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.096452100@linutronix.de>
References: <20210908132525.096452100@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717636.25758.8676151426891714729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     e42404afc4ca856c48f1e05752541faa3587c472
Gitweb:        https://git.kernel.org/tip/e42404afc4ca856c48f1e05752541faa3587c472
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 17:00:23 +02:00

x86/mce: Deduplicate exception handling

Prepare code for further simplification. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.096452100@linutronix.de
---
 arch/x86/kernel/cpu/mce/core.c | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8cb7816..428eed9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -373,13 +373,16 @@ static int msr_to_offset(u32 msr)
 	return -1;
 }
 
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
+static void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 {
-	pr_emerg("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
-		 (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+	if (wrmsr) {
+		pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
+			 regs->ip, (void *)regs->ip);
+	} else {
+		pr_emerg("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+	}
 
 	show_stack_regs(regs);
 
@@ -387,7 +390,14 @@ __visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
 
 	while (true)
 		cpu_relax();
+}
 
+__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
+				      struct pt_regs *regs, int trapnr,
+				      unsigned long error_code,
+				      unsigned long fault_addr)
+{
+	ex_handler_msr_mce(regs, false);
 	return true;
 }
 
@@ -432,17 +442,7 @@ __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
 				      unsigned long error_code,
 				      unsigned long fault_addr)
 {
-	pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
-		 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
-		  regs->ip, (void *)regs->ip);
-
-	show_stack_regs(regs);
-
-	panic("MCA architectural violation!\n");
-
-	while (true)
-		cpu_relax();
-
+	ex_handler_msr_mce(regs, true);
 	return true;
 }
 
