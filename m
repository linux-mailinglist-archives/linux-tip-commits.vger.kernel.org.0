Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE952F3CD7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438073AbhALVhV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436758AbhALUM4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:12:56 -0500
Date:   Tue, 12 Jan 2021 20:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFXF/fLpS+2G12nuMp5UGvdBFhRCrSz6OlkS3NneeBQ=;
        b=FLzs2QZ4CO3DC00jmLt/3y01F4CMiJki39suok8tcpu4S6nbfXyyq/QQ2Qzib2rDI+7GKD
        7iHL3s34PsFI/0+BPu9bqErPyumUTU3pEuomPbtT6MaLI4szmfzSsJ1WulnjF3FOOmnU+O
        wwt1CT1Q/kDv/IfJWy2XKCmfKFDhHIJjvN/xU0bTGUVvRt52yyH+JrqDSXu/taotEI0Vaq
        4q4xZOYkutrnf0Y8g5wYALeiLEBEUoIvLiuBhb5Y0rbEPrRCO0ykajW8AzMp3gW0Ad3Yot
        TXuVo78h9OPIGWSHQ1RaR+Nwdrfp81gjIQgQRdy6eZFfnG0cMokXXrhlDOiFeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFXF/fLpS+2G12nuMp5UGvdBFhRCrSz6OlkS3NneeBQ=;
        b=wymUUouyvq+OJx+91Py40xgJPmn0uFtEXp27Zu9mOPdUbguDaBs3xbwZuQ0FGXQEDtiIsa
        6H/r+0KdmbZ+jWBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Fix noinstr fail
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210106144017.472696632@infradead.org>
References: <20210106144017.472696632@infradead.org>
MIME-Version: 1.0
Message-ID: <161048233069.414.9496735374028270732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9caa7ff509add50959a793b811cc7c9339e281cd
Gitweb:        https://git.kernel.org/tip/9caa7ff509add50959a793b811cc7c9339e281cd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 06 Jan 2021 15:36:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:10:58 +01:00

x86/entry: Fix noinstr fail

  vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x47: call to syscall_enter_from_user_mode_work() leaves .noinstr.text section

Fixes: 4facb95b7ada ("x86/entry: Unbreak 32bit fast syscall")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210106144017.472696632@infradead.org

---
 arch/x86/entry/common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 18d8f17..0904f56 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -73,10 +73,8 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
 						  unsigned int nr)
 {
 	if (likely(nr < IA32_NR_syscalls)) {
-		instrumentation_begin();
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
-		instrumentation_end();
 	}
 }
 
@@ -91,8 +89,11 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 	 * or may not be necessary, but it matches the old asm behavior.
 	 */
 	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+	instrumentation_begin();
 
 	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
 
@@ -121,11 +122,12 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		res = get_user(*(u32 *)&regs->bp,
 		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
 	}
-	instrumentation_end();
 
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
+
+		instrumentation_end();
 		syscall_exit_to_user_mode(regs);
 		return false;
 	}
@@ -135,6 +137,8 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 	return true;
 }
