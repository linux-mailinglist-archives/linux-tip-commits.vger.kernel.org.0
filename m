Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB082CAA80
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404249AbgLASGn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 13:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgLASGh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 13:06:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAEAC0613D4;
        Tue,  1 Dec 2020 10:05:56 -0800 (PST)
Date:   Tue, 01 Dec 2020 18:05:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606845955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uha+06ixXkfFHXvbPZjsSyxNlFm6uuHzkMK4tZPYt2w=;
        b=sKmbKlMQN/b/n7XZ8dcnGUo6FYsjm3xyJtFsIAeiFhUtYyD1x/VK9O9/JnAbuFCmteU5qV
        zN82jg/YfNvb2Dwpc/gTiwIC1FLEsCvUGcrTVZwjANP3zb99wFl9ldd5jsJBc4bS168XMP
        Iasx7l1G75RRqc6TgFXHGhkYJn+zZets2DnWrD6CLvswoHj/Yijr25WE0jDjsYlqgvRogJ
        GMdcom4RpgJ+RaXVJYu0+0AIjDtjbpJDTjIEvYI2GlTyCoGGuxHwcC+RSj9T0/gaWUjQiz
        7otOwxT3CTojgJA4+ukv2yNAgdq4kLV5CUYjd+fWEuGnc/YnN0PPjMjZ1iPOFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606845955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uha+06ixXkfFHXvbPZjsSyxNlFm6uuHzkMK4tZPYt2w=;
        b=iRaqzlBHqhOgDEKtPC9wmI841swB2hRkn6q8ykQIeu4uxyUgeCPrzKrX3oaz5HGmhNmalv
        uf4i5DTsZ8UgiNBA==
From:   "tip-bot2 for Gabriele Paoloni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Rename kill_it to kill_current_task
Cc:     Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127161819.3106432-6-gabriele.paoloni@intel.com>
References: <20201127161819.3106432-6-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Message-ID: <160684595368.3364.2232510071471640636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e1c06d2366e743475b91045ef0c2ce1bbd028cb6
Gitweb:        https://git.kernel.org/tip/e1c06d2366e743475b91045ef0c2ce1bbd028cb6
Author:        Gabriele Paoloni <gabriele.paoloni@intel.com>
AuthorDate:    Fri, 27 Nov 2020 16:18:19 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 18:58:50 +01:00

x86/mce: Rename kill_it to kill_current_task

Currently, if an MCE happens in user-mode or while the kernel is copying
data from user space, 'kill_it' is used to check if execution of the
interrupted task can be recovered or not; the flag name however is not
very meaningful, hence rename it to match its goal.

 [ bp: Massage commit message, rename the queue_task_work() arg too. ]

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201127161819.3106432-6-gabriele.paoloni@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a9991a9..6af6a3c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1266,14 +1266,14 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 }
 
-static void queue_task_work(struct mce *m, int kill_it)
+static void queue_task_work(struct mce *m, int kill_current_task)
 {
 	current->mce_addr = m->addr;
 	current->mce_kflags = m->kflags;
 	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
 	current->mce_whole_page = whole_page(m);
 
-	if (kill_it)
+	if (kill_current_task)
 		current->mce_kill_me.func = kill_me_now;
 	else
 		current->mce_kill_me.func = kill_me_maybe;
@@ -1321,10 +1321,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	int no_way_out = 0;
 
 	/*
-	 * If kill_it gets set, there might be a way to recover from this
+	 * If kill_current_task is not set, there might be a way to recover from this
 	 * error.
 	 */
-	int kill_it = 0;
+	int kill_current_task = 0;
 
 	/*
 	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
@@ -1351,7 +1351,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
 	if (!(m.mcgstatus & MCG_STATUS_RIPV))
-		kill_it = (cfg->tolerant == 3) ? 0 : 1;
+		kill_current_task = (cfg->tolerant == 3) ? 0 : 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
@@ -1406,7 +1406,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
-	if (worst != MCE_AR_SEVERITY && !kill_it)
+	if (worst != MCE_AR_SEVERITY && !kill_current_task)
 		goto out;
 
 	/* Fault was in user mode and we need to take some action */
@@ -1414,7 +1414,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_it);
+		queue_task_work(&m, kill_current_task);
 
 	} else {
 		/*
@@ -1432,7 +1432,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_it);
+			queue_task_work(&m, kill_current_task);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
