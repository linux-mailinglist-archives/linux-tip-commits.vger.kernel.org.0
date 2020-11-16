Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2292B538A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbgKPVLx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgKPVLf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C68C0613CF;
        Mon, 16 Nov 2020 13:11:35 -0800 (PST)
Date:   Mon, 16 Nov 2020 21:11:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NOtUmASKIohaC7zeIBH1GT1Dmp5jTL9mfPDvu8PF/E=;
        b=SacVsG6PnS+NmVe/zHFcSvM2ClI3wUypvxPCvkZqUM/jrX4DRmyKEf3t1WZcUH/SaIr42L
        xo9S+x6HNAlxStiW6TZzLILiPakuT0fUawGBE214ze76SZEhilcCl4Bv5fPfVI6gSMrOCn
        RZ9fp9dtYbH0VglwEcHw9pWdupQDvyFXsTGqjukeeZFfh781VUT2LTRubYxHC4kUo/SlcO
        zo0oHb07NTNf3xccjtk1Wa3pl6NzUAsU6gRy7WCplP4iZAaEegfExWq3UWUWdtSOWE6dgm
        GlRUuB8JrJy5Qwb3iiN/c5/yYjSyXy8vrWPWqqWtbGe4tmxYoJELcgU+gyQAcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NOtUmASKIohaC7zeIBH1GT1Dmp5jTL9mfPDvu8PF/E=;
        b=VKFxQZkrNiZdKLi5PQnMTAJePYCfzuGhQOcGqm4LQv1p5cXcHv3X9T345S/8fz0Cgi8nzU
        hFdQDIfNmf1jFhCw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Wire up syscall_work in common entry code
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-4-krisman@collabora.com>
References: <20201116174206.2639648-4-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109310.11244.5834808142783757653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     b86678cf0f1d76062aa964c5f0c6c89fe5a6dcfd
Gitweb:        https://git.kernel.org/tip/b86678cf0f1d76062aa964c5f0c6c89fe5a6dcfd
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:41:59 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:15 +01:00

entry: Wire up syscall_work in common entry code

Prepare the common entry code to use the SYSCALL_WORK flags. They will
be defined in subsequent patches for each type of syscall
work. SYSCALL_WORK_ENTRY/EXIT are defined for the transition, as they
will replace the TIF_ equivalent defines.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-4-krisman@collabora.com


---
 include/linux/entry-common.h |  3 +++
 kernel/entry/common.c        | 15 +++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index aab5490..3fe8f86 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -64,6 +64,9 @@
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
 	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
 
+#define SYSCALL_WORK_ENTER	(0)
+#define SYSCALL_WORK_EXIT	(0)
+
 /*
  * TIF flags handled in exit_to_user_mode_loop()
  */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index fa17baa..e7a11e3 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -42,7 +42,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 }
 
 static long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long ti_work)
+				unsigned long ti_work, unsigned long work)
 {
 	long ret = 0;
 
@@ -74,11 +74,12 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 static __always_inline long
 __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long ti_work;
 
 	ti_work = READ_ONCE(current_thread_info()->flags);
-	if (ti_work & SYSCALL_ENTER_WORK)
-		syscall = syscall_trace_enter(regs, syscall, ti_work);
+	if (work & SYSCALL_WORK_ENTER || ti_work & SYSCALL_ENTER_WORK)
+		syscall = syscall_trace_enter(regs, syscall, ti_work, work);
 
 	return syscall;
 }
@@ -225,7 +226,8 @@ static inline bool report_single_step(unsigned long ti_work)
 }
 #endif
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
+static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
+			      unsigned long work)
 {
 	bool step;
 
@@ -245,6 +247,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
  */
 static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	u32 cached_flags = READ_ONCE(current_thread_info()->flags);
 	unsigned long nr = syscall_get_nr(current, regs);
 
@@ -262,8 +265,8 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	 * enabled, we want to run them exactly once per syscall exit with
 	 * interrupts enabled.
 	 */
-	if (unlikely(cached_flags & SYSCALL_EXIT_WORK))
-		syscall_exit_work(regs, cached_flags);
+	if (unlikely(work & SYSCALL_WORK_EXIT || cached_flags & SYSCALL_EXIT_WORK))
+		syscall_exit_work(regs, cached_flags, work);
 }
 
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
