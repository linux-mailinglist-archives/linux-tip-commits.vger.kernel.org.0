Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783A433E04D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Mar 2021 22:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCPVRX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Mar 2021 17:17:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhCPVRG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:06 -0400
Date:   Tue, 16 Mar 2021 21:17:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615929425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoNMDikrzdQnTSZWUxIv2TtLLTCuisaD+z+/cFMHJHM=;
        b=Bho99YBmF8gqT+TZ+rMVsij0ZW+P32xuSuKl0iaTrhpPWPwugKWILOt8Rs3Rb29r6blZ+Q
        QHfemJCu1pcTjDpy9kCDccKy0MrDbvkzb3ze5kS9A/rJqdp1m/3QutZZ70Yzxm5mqNI5lS
        QgQR4j0ffmFDcExgSEmH+JVLxb9vw4QHcQJbNfo5/F61cYTG8LLsEpOmioIMCNcQBw21sc
        O+TKh/OwSr7v9J9kwI5HE9W24GYdycBYmbMQWhc3/NrnTqxIbu1I9gbIdZ4Gk51bt4A8Ht
        ZoSq+O9UKfEvNzksTOWZotxDUTGiHm/UVcstC69vPw/zbasLVO2XecF5jPCY0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615929425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoNMDikrzdQnTSZWUxIv2TtLLTCuisaD+z+/cFMHJHM=;
        b=QpDMfMRjArU3du/c+vv3a9w56CZNia4CkClxkz1l0c4Os3L6MxkZiXFGREk/H/R6U2uisq
        9odnesIR8Ko/9/Cw==
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Introduce restart_block->arch_data to remove
 TS_COMPAT_RESTART
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210201174716.GA17898@redhat.com>
References: <20210201174716.GA17898@redhat.com>
MIME-Version: 1.0
Message-ID: <161592942436.398.12649793098780339574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b2e9df850c58c2b36e915e7d3bed3f6107cccba6
Gitweb:        https://git.kernel.org/tip/b2e9df850c58c2b36e915e7d3bed3f6107cccba6
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Mon, 01 Feb 2021 18:47:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 16 Mar 2021 22:13:11 +01:00

x86: Introduce restart_block->arch_data to remove TS_COMPAT_RESTART

Save the current_thread_info()->status of X86 in the new
restart_block->arch_data field so TS_COMPAT_RESTART can be removed again.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210201174716.GA17898@redhat.com

---
 arch/x86/include/asm/thread_info.h | 12 ++----------
 arch/x86/kernel/signal.c           |  2 +-
 include/linux/restart_block.h      |  1 +
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 30d1d18..06b740b 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -217,18 +217,10 @@ static inline int arch_within_stack_frames(const void * const stack,
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED	0x0004	/* regs poked by 32-bit ptracer */
-#define TS_COMPAT_RESTART	0x0008
 
-#define arch_set_restart_data	arch_set_restart_data
+#define arch_set_restart_data(restart)	\
+	do { restart->arch_data = current_thread_info()->status; } while (0)
 
-static inline void arch_set_restart_data(struct restart_block *restart)
-{
-	struct thread_info *ti = current_thread_info();
-	if (ti->status & TS_COMPAT)
-		ti->status |= TS_COMPAT_RESTART;
-	else
-		ti->status &= ~TS_COMPAT_RESTART;
-}
 #endif
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 6c26d2c..f306e85 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -767,7 +767,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
 {
 #ifdef CONFIG_IA32_EMULATION
-	if (current_thread_info()->status & TS_COMPAT_RESTART)
+	if (current->restart_block.arch_data & TS_COMPAT)
 		return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bba2920..980a655 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -23,6 +23,7 @@ enum timespec_type {
  * System call restart block.
  */
 struct restart_block {
+	unsigned long arch_data;
 	long (*fn)(struct restart_block *);
 	union {
 		/* For futex_wait and futex_wait_requeue_pi */
