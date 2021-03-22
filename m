Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83C2343768
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Mar 2021 04:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVD3D (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 21 Mar 2021 23:29:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51232 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVD2z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 21 Mar 2021 23:28:55 -0400
Date:   Mon, 22 Mar 2021 03:28:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616383734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DTBRHVpM41husgGn1OzRT6VaeJlpH8WrfLjesvzsWXs=;
        b=cNFOTBvuSQbRlZILqF4NdSeBYhWTOfdpwLZTljjYmymc03q+OElIJ+V4ut2r8/go3fHlVt
        ddjGX6tF6tbvw7L63ZHb7eU3DZl3Dr2CPX6HaxSGPxunASIgOQm4Si6EzG5eWO4AR0o4ZV
        Y2x1biU55X+3yAckQEfE9oEcOVn7CD4OrW13RD6I6LLVD+EZbtCoKb1dEYaH/sCYYVkxMt
        TKI0/CX9JQlhBATi6hIGhY0i02dLJr6UbD8nZb0cqbNuH1yEdR67Iu7b0i76BMMaefn5y6
        tm4/LtNbi+uf0NI/Ba7MaCmnk7s5TuDjCbnh8luAnwqHkxQeZ0XPMN4U+ezWcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616383734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DTBRHVpM41husgGn1OzRT6VaeJlpH8WrfLjesvzsWXs=;
        b=xzvDb0kXok/FTCAzF2gSAEPpQPiGNCZWDSrnKlEoI4r3zZ51jqqH21lapbkIcr66s65Xad
        P7z3788e6IVrCYCQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Fix typos in comments
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161638373388.398.674620674336249442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     97258ce902d1e1c396a4d7c38f6ae7085adb73c5
Gitweb:        https://git.kernel.org/tip/97258ce902d1e1c396a4d7c38f6ae7085adb73c5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 22 Mar 2021 03:55:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 22 Mar 2021 03:57:39 +01:00

entry: Fix typos in comments

Fix 3 single-word typos in the generic syscall entry code.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/entry-common.h | 4 ++--
 kernel/entry/common.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 883acef..2e2b8d6 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -360,7 +360,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  *
  * This is a combination of syscall_exit_to_user_mode_work() (1,2) and
  * exit_to_user_mode(). This function is preferred unless there is a
- * compelling architectural reason to use the seperate functions.
+ * compelling architectural reason to use the separate functions.
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 
@@ -381,7 +381,7 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
  * irqentry_exit_to_user_mode - Interrupt exit work
  * @regs:	Pointer to current's pt_regs
  *
- * Invoked with interrupts disbled and fully valid regs. Returns with all
+ * Invoked with interrupts disabled and fully valid regs. Returns with all
  * work handled, interrupts disabled such that the caller can immediately
  * switch to user mode. Called from architecture specific interrupt
  * handling code.
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 8442e5c..8d996dd 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -341,7 +341,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * Checking for rcu_is_watching() here would prevent the nesting
 	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
-	 * assume that it is the first interupt and eventually claim
+	 * assume that it is the first interrupt and eventually claim
 	 * quiescent state and end grace periods prematurely.
 	 *
 	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
