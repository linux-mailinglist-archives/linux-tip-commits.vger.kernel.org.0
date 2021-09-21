Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF86E412FBF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhIUHyY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhIUHyY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:54:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCFC061574;
        Tue, 21 Sep 2021 00:52:56 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:52:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632210774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjXvsy3Z/50ORRiKG9iCQPOaiGQm7B/uIN3YWIln1Qs=;
        b=gtd3gLQHTvb+hzwt7bHmj3vq2tvR6RMCmdehLYzKPavOXpst09Rt0CeGv8s9VgZ2Gpxm1r
        L78ZSso1p/QAP4rd/r8bUD8rTQbft49rSwP5PoLY/vZSJg/brKNMfUTNCv7cIfIUm1l2lV
        20ZdsPV9jysZw4mjI0QES1AAexaqeKZKBC2TnkpKdH0KB5KZ7HCcnlabLVPtAmcoJUoYqe
        kbXN116yJuXq3oPdzsnrgNT0BT/EMHqX0jqLeqsFy8RhiwqciMRZIvEtDi1/5hU4D11/Kp
        ohkeT8COWeYgOXnoNFfa7nZBuNmjRC4z8OCLEMAPloUJVVxjID79umngg+lKWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632210774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjXvsy3Z/50ORRiKG9iCQPOaiGQm7B/uIN3YWIln1Qs=;
        b=GRk0JvIhZhCP1GRVcfiTSUyLNBw4wjJ+OMyp3N/q+eFTfPUOHLmAapBHdHL+afvzwF6NMG
        zHJMxxPRBiyuOOAg==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Change to not send SIGBUS error during copy
 from user
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210818002942.1607544-3-tony.luck@intel.com>
References: <20210818002942.1607544-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163221077390.25758.9394361131538462134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a6e3cf70b772541c2388abdb86e5a562cfe18e63
Gitweb:        https://git.kernel.org/tip/a6e3cf70b772541c2388abdb86e5a562cfe18e63
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 17 Aug 2021 17:29:41 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Sep 2021 10:55:41 +02:00

x86/mce: Change to not send SIGBUS error during copy from user

Sending a SIGBUS for a copy from user is not the correct semantic.
System calls should return -EFAULT (or a short count for write(2)).

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210818002942.1607544-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 35 ++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 193204a..69768fe 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1272,7 +1272,7 @@ static void kill_me_maybe(struct callback_head *cb)
 		flags |= MF_MUST_KILL;
 
 	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
-	if (!ret && !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
+	if (!ret) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
@@ -1286,15 +1286,21 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (ret == -EHWPOISON)
 		return;
 
-	if (p->mce_vaddr != (void __user *)-1l) {
-		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
-	} else {
-		pr_err("Memory error not recovered");
-		kill_me_now(cb);
-	}
+	pr_err("Memory error not recovered");
+	kill_me_now(cb);
+}
+
+static void kill_me_never(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+
+	p->mce_count = 0;
+	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 }
 
-static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
+static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
 {
 	int count = ++current->mce_count;
 
@@ -1304,11 +1310,7 @@ static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
 		current->mce_kflags = m->kflags;
 		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
 		current->mce_whole_page = whole_page(m);
-
-		if (kill_current_task)
-			current->mce_kill_me.func = kill_me_now;
-		else
-			current->mce_kill_me.func = kill_me_maybe;
+		current->mce_kill_me.func = func;
 	}
 
 	/* Ten is likely overkill. Don't expect more than two faults before task_work() */
@@ -1459,7 +1461,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, msg, kill_current_task);
+		if (kill_current_task)
+			queue_task_work(&m, msg, kill_me_now);
+		else
+			queue_task_work(&m, msg, kill_me_maybe);
 
 	} else {
 		/*
@@ -1477,7 +1482,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, msg, kill_current_task);
+			queue_task_work(&m, msg, kill_me_never);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
