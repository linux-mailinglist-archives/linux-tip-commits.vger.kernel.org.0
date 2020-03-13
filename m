Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BB183580
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Mar 2020 16:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLPxQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Mar 2020 11:53:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44194 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCLPxQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Mar 2020 11:53:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jCQ93-0005cI-3A; Thu, 12 Mar 2020 16:53:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 93E6C1C224A;
        Thu, 12 Mar 2020 16:53:12 +0100 (CET)
Date:   Thu, 12 Mar 2020 15:53:12 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/kmmio: Use this_cpu_ptr() instead get_cpu_var()
 for kmmio_ctx
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200205143426.2592512-1-bigeasy@linutronix.de>
References: <20200205143426.2592512-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <158402839227.28353.593101974747491831.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6a9feaa8774f3b8210dfe40626a75ca047e4ecae
Gitweb:        https://git.kernel.org/tip/6a9feaa8774f3b8210dfe40626a75ca047e4ecae
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 05 Feb 2020 15:34:26 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 12 Mar 2020 16:41:40 +01:00

x86/mm/kmmio: Use this_cpu_ptr() instead get_cpu_var() for kmmio_ctx

Both call sites that access kmmio_ctx, access kmmio_ctx with interrupts
disabled. There is no need to use get_cpu_var() which additionally
disables preemption.

Use this_cpu_ptr() to access the kmmio_ctx variable of the current CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200205143426.2592512-1-bigeasy@linutronix.de
---
 arch/x86/mm/kmmio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index 49d7814..9994353 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -260,7 +260,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 		goto no_kmmio;
 	}
 
-	ctx = &get_cpu_var(kmmio_ctx);
+	ctx = this_cpu_ptr(&kmmio_ctx);
 	if (ctx->active) {
 		if (page_base == ctx->addr) {
 			/*
@@ -285,7 +285,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 			pr_emerg("previous hit was at 0x%08lx.\n", ctx->addr);
 			disarm_kmmio_fault_page(faultpage);
 		}
-		goto no_kmmio_ctx;
+		goto no_kmmio;
 	}
 	ctx->active++;
 
@@ -314,11 +314,8 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 	 * the user should drop to single cpu before tracing.
 	 */
 
-	put_cpu_var(kmmio_ctx);
 	return 1; /* fault handled */
 
-no_kmmio_ctx:
-	put_cpu_var(kmmio_ctx);
 no_kmmio:
 	rcu_read_unlock();
 	preempt_enable_no_resched();
@@ -333,7 +330,7 @@ no_kmmio:
 static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
 {
 	int ret = 0;
-	struct kmmio_context *ctx = &get_cpu_var(kmmio_ctx);
+	struct kmmio_context *ctx = this_cpu_ptr(&kmmio_ctx);
 
 	if (!ctx->active) {
 		/*
@@ -371,7 +368,6 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
 	if (!(regs->flags & X86_EFLAGS_TF))
 		ret = 1;
 out:
-	put_cpu_var(kmmio_ctx);
 	return ret;
 }
 
