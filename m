Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDF434C8F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJTNtS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhJTNrd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4063DC06161C;
        Wed, 20 Oct 2021 06:44:49 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vLCk/Y7vcemrkO7gK5DGXx1wwAtRRYp3VJBEFFeyrU=;
        b=hmv2O+3YxwTYHQByMmsg7shL2MQrV+F/cVoTixxxI8KWczzsokTz/zbErZ6x+gjKAFdIr3
        LZ+7jkfiPkpT2Pzln9lZe6rZr6A+w0uUJqJkA6jFyU9HjpEnLuOe823Grtl2YSDoknPrxY
        Cp+jfxp66teyJotVu0YqndONyMGZ2sDdyBSfix71wu76P6hX19IV2HAhy/0KlZbfQ1NO92
        m1nVBln20YxRbsCv9MQiw6iaIIqfwjrY3RQtMK8Ijd3BrUVXrUIkmJkdLdNDs2bJr56Z1p
        3C588X00yVZ0o+L5BX0Oa3fyvCs7EAPR4Y+JXRW90QnR5MK9biZ6CGoSyT6O7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vLCk/Y7vcemrkO7gK5DGXx1wwAtRRYp3VJBEFFeyrU=;
        b=MLqV6c9+GhB7v+Lm/P3Oqhbqsof7kGurfl66PyQRXcWimfp07+V04tqEYHr5dZtOqfHA37
        HdKhytiTdint3cAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove pointless argument from switch_fpu_finish()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.433135710@linutronix.de>
References: <20211015011538.433135710@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748635.25758.9303480087639922504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9568bfb4f04bd9a280c592879ccd7a26a77c1390
Gitweb:        https://git.kernel.org/tip/9568bfb4f04bd9a280c592879ccd7a26a77c1390
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:15:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:25 +02:00

x86/fpu: Remove pointless argument from switch_fpu_finish()

Unused since the FPU switching rework.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.433135710@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 arch/x86/kernel/process_32.c        | 3 +--
 arch/x86/kernel/process_64.c        | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 89960e4..1503750 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -521,7 +521,7 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Delay loading of the complete FPU state until the return to userland.
  * PKRU is handled separately.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu)
+static inline void switch_fpu_finish(void)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU))
 		set_thread_flag(TIF_NEED_FPU_LOAD);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e..d008e22 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -160,7 +160,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	struct thread_struct *prev = &prev_p->thread,
 			     *next = &next_p->thread;
 	struct fpu *prev_fpu = &prev->fpu;
-	struct fpu *next_fpu = &next->fpu;
 	int cpu = smp_processor_id();
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
@@ -213,7 +212,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	this_cpu_write(current_task, next_p);
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish();
 
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ec0d836..39f12ef 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -559,7 +559,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	struct thread_struct *prev = &prev_p->thread;
 	struct thread_struct *next = &next_p->thread;
 	struct fpu *prev_fpu = &prev->fpu;
-	struct fpu *next_fpu = &next->fpu;
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
@@ -620,7 +619,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish();
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
