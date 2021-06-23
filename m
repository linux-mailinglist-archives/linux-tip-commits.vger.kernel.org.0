Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703893B2300
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFWWL3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFWWLV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:21 -0400
Date:   Wed, 23 Jun 2021 22:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c51Jo6XB8CJvenXT/5iMKOaecC3K1aApCQLuSgB7MpU=;
        b=QW8UHMaeSw8/y/MC8dTrZAgtbrW2LzgD/vsmGqHTU5Igx3cZMyVOuwCWqvzJ6O6d8NEJZB
        dKRH8ToRa7nQqy5FMhyAjqhHZRfer7Wh4G8qXKYSnQ8eWyxsos2btRFNd7eiw3GbsvKLrQ
        glL9guH7V+kShhqk63rRrSR9s77GZLoM2xvLRdzew/lhhHWdRvrIPppsAt4fTSi6GMdAiL
        CwATHq1bMXuHzx3pPIpRHzl9HXUu+TNL0eZYWwCURHUtanrMh+any2KX6rTZVvf7GptU0h
        zhX9kh4srSRb0EeP5PVZkS0QfLRv6ayHCblEauiW41NMrV9WkXZuHmJFceHxCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c51Jo6XB8CJvenXT/5iMKOaecC3K1aApCQLuSgB7MpU=;
        b=ibTfmtsEiKjFn9LQi1+IvFmWMU0vuQJtov5upnaf+JA9pwcmui1xFl+70dagfkRy0vAJRw
        CAJqpiZvAZeKFsCA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add PKRU storage outside of task XSAVE buffer
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.399107624@linutronix.de>
References: <20210623121456.399107624@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614083.395.11847441468501832818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9782a712eb971ce483442076e79eb1d8d608646e
Gitweb:        https://git.kernel.org/tip/9782a712eb971ce483442076e79eb1d8d608646e
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 23 Jun 2021 14:02:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:37:45 +02:00

x86/fpu: Add PKRU storage outside of task XSAVE buffer

PKRU is currently partly XSAVE-managed and partly not. It has space
in the task XSAVE buffer and is context-switched by XSAVE/XRSTOR.
However, it is switched more eagerly than FPU because there may be a
need for PKRU to be up-to-date for things like copy_to/from_user() since
PKRU affects user-permission memory accesses, not just accesses from
userspace itself.

This leaves PKRU in a very odd position. XSAVE brings very little value
to the table for how Linux uses PKRU except for signal related XSTATE
handling.

Prepare to move PKRU away from being XSAVE-managed. Allocate space in
the thread_struct for it and save/restore it in the context-switch path
separately from the XSAVE-managed features. task->thread_struct.pkru
is only valid when the task is scheduled out. For the current task the
authoritative source is the hardware, i.e. it has to be retrieved via
rdpkru().

Leave the XSAVE code in place for now to ensure bisectability.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.399107624@linutronix.de
---
 arch/x86/include/asm/processor.h |  9 +++++++++
 arch/x86/kernel/process.c        |  7 +++++++
 arch/x86/kernel/process_64.c     | 25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 556b2b1..91946fc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -518,6 +518,15 @@ struct thread_struct {
 
 	unsigned int		sig_on_uaccess_err:1;
 
+	/*
+	 * Protection Keys Register for Userspace.  Loaded immediately on
+	 * context switch. Store it in thread_struct to avoid a lookup in
+	 * the tasks's FPU xstate buffer. This value is only valid when a
+	 * task is scheduled out. For 'current' the authoritative source of
+	 * PKRU is the hardware itself.
+	 */
+	u32			pkru;
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index de942b0..fa6c8fa 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -156,11 +156,18 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		p->thread.pkru = pkru_get_init_value();
 		memset(childregs, 0, sizeof(struct pt_regs));
 		kthread_frame_init(frame, sp, arg);
 		return 0;
 	}
 
+	/*
+	 * Clone current's PKRU value from hardware. tsk->thread.pkru
+	 * is only valid when scheduled out.
+	 */
+	p->thread.pkru = read_pkru();
+
 	frame->bx = 0;
 	*childregs = *current_pt_regs();
 	childregs->ax = 0;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 40a9638..ec0d836 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -340,6 +340,29 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+/*
+ * Store prev's PKRU value and load next's PKRU value if they differ. PKRU
+ * is not XSTATE managed on context switch because that would require a
+ * lookup in the task's FPU xsave buffer and require to keep that updated
+ * in various places.
+ */
+static __always_inline void x86_pkru_load(struct thread_struct *prev,
+					  struct thread_struct *next)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	/* Stash the prev task's value: */
+	prev->pkru = rdpkru();
+
+	/*
+	 * PKRU writes are slightly expensive.  Avoid them when not
+	 * strictly necessary:
+	 */
+	if (prev->pkru != next->pkru)
+		wrpkru(next->pkru);
+}
+
 static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 					      struct thread_struct *next)
 {
@@ -589,6 +612,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	x86_fsgsbase_load(prev, next);
 
+	x86_pkru_load(prev, next);
+
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
