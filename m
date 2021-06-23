Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E713B233F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFWWNK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhFWWMD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:03 -0400
Date:   Wed, 23 Jun 2021 22:09:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9tx7HjwI9vc93jpHb9OZeLgrsdvrTR8BXXFRRYIiRo=;
        b=l+EdPAqsdmgOH/4WgFADmqpYnR668tkFrvigixh4GaedmjRQF2YtjTb7gqI+lfZeuszLfj
        nC9ZQKmRuZmZ1FIpnyt3EdJug9BbjAy16n67tTmL2RHbvCpfiwW9ftNQsf12sO1tIbHIHk
        lEsPe7MCL49hwY6kaA3Qdf+xWn7fnNTfoTph1lFTgEZrZJrNYLUMhluvhEGFGraPjy2/DY
        F+LvhE0SdllWRdV2w5U8lsf5bDknwtk8VrwfiN7sbVLQowu3lJBx01hU+mJAFftHCn/Fn3
        Y94Jjbci66ku0XuW6jrLbGv6aV14QoY8h4L2E7hVRQhp7DBp9Lj6WVFMG2F2WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9tx7HjwI9vc93jpHb9OZeLgrsdvrTR8BXXFRRYIiRo=;
        b=NQlQSoQny2zkAbCQQGwjMvUczbpbZG+ErzeTqnt8V61VSqGCPoaizdY2N+bSWyFqk3a8wo
        oQ2Zv64KPBAIGNBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Sanitize xstateregs_set()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.214903673@linutronix.de>
References: <20210623121452.214903673@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617971.395.11215710936470498853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     43be46e89698a41dbf4fff81a322f4c2ae21b5e2
Gitweb:        https://git.kernel.org/tip/43be46e89698a41dbf4fff81a322f4c2ae21b5e2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:36 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Sanitize xstateregs_set()

xstateregs_set() operates on a stopped task and tries to copy the provided
buffer into the task's fpu.state.xsave buffer.

Any error while copying or invalid state detected after copying results in
wiping the target task's FPU state completely including supervisor states.

That's just wrong. The caller supplied invalid data or has a problem with
unmapped memory, so there is absolutely no justification to corrupt the
target state.

Fix this with the following modifications:

 1) If data has to be copied from userspace, allocate a buffer and copy from
    user first.

 2) Use copy_kernel_to_xstate() unconditionally so that header checking
    works correctly.

 3) Return on error without corrupting the target state.

This prevents corrupting states and lets the caller deal with the problem
it caused in the first place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.214903673@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h |  4 +---
 arch/x86/kernel/fpu/regset.c      | 42 ++++++++++++------------------
 arch/x86/kernel/fpu/xstate.c      | 14 +++++-----
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index d22e973..1bb2d16 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -111,8 +111,4 @@ void copy_supervisor_to_kernel(struct xregs_state *xsave);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
-
-/* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr);
-
 #endif
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6bb8744..a50c0a9 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -2,11 +2,13 @@
 /*
  * FPU register's regset abstraction, for ptrace, core dumps, etc.
  */
+#include <linux/sched/task_stack.h>
+#include <linux/vmalloc.h>
+
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
-#include <linux/sched/task_stack.h>
 
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
@@ -108,10 +110,10 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		  const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
+	struct xregs_state *tmpbuf = NULL;
 	int ret;
 
-	if (!boot_cpu_has(X86_FEATURE_XSAVE))
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
 	/*
@@ -120,32 +122,22 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	if (pos != 0 || count != fpu_user_xstate_size)
 		return -EFAULT;
 
-	xsave = &fpu->state.xsave;
-
-	fpu__prepare_write(fpu);
+	if (!kbuf) {
+		tmpbuf = vmalloc(count);
+		if (!tmpbuf)
+			return -ENOMEM;
 
-	if (using_compacted_format()) {
-		if (kbuf)
-			ret = copy_kernel_to_xstate(xsave, kbuf);
-		else
-			ret = copy_user_to_xstate(xsave, ubuf);
-	} else {
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
-		if (!ret)
-			ret = validate_user_xstate_header(&xsave->header);
+		if (copy_from_user(tmpbuf, ubuf, count)) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 
-	/*
-	 * mxcsr reserved bits must be masked to zero for security reasons.
-	 */
-	xsave->i387.mxcsr &= mxcsr_feature_mask;
-
-	/*
-	 * In case of failure, mark all states as init:
-	 */
-	if (ret)
-		fpstate_init(&fpu->state);
+	fpu__prepare_write(fpu);
+	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
+out:
+	vfree(tmpbuf);
 	return ret;
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b82879c..2b7b579 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -543,7 +543,7 @@ int using_compacted_format(void)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr)
+static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
 	if (hdr->xfeatures & ~xfeatures_mask_user())
@@ -1155,7 +1155,7 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 }
 
 /*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
+ * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
  */
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
@@ -1202,14 +1202,16 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
 
+	/* mxcsr reserved bits must be masked to zero for historical reasons. */
+	xsave->i387.mxcsr &= mxcsr_feature_mask;
+
 	return 0;
 }
 
 /*
- * Convert from a ptrace or sigreturn standard-format user-space buffer to
- * kernel XSAVES format and copy to the target thread. This is called from
- * xstateregs_set(), as well as potentially from the sigreturn() and
- * rt_sigreturn() system calls.
+ * Convert from a sigreturn standard-format user-space buffer to kernel
+ * XSAVE[S] format and copy to the target thread. This is called from the
+ * sigreturn() and rt_sigreturn() system calls.
  */
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 {
