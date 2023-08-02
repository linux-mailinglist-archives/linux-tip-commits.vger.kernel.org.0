Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F35776DA9E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Aug 2023 00:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjHBWUh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Aug 2023 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjHBWTz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Aug 2023 18:19:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8BC2D68;
        Wed,  2 Aug 2023 15:19:37 -0700 (PDT)
Date:   Wed, 02 Aug 2023 22:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691014776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gcyn36Jv3HtGUnwQSizKMwQBNb1jMXnbeMRFzDKvjBo=;
        b=R6BsfNuYzJt2kvvcTkeP3m1c73bq/38RqaQ4BT3Nt/PCsEfKKFUuw7i2TWWF/A/eL13N/k
        RcIJDafLG4yAtOutumjL/osRy3chncGnTXRLSZRTYtp+djCWc3r5PzHiZJdHTExurnFnII
        v+5eYPAxBrNCWkhZEbvsj2UZqBUjUrbGiCtI9gSs1JbDTrgf3h/v/pVxcowlgEN/qGX2EP
        2po5JIoo9c50R38yK9CbPpsnV7fah32WpgqjFdagQ77UDAhxJurwl7RrVxBBWycx1eZpZt
        uHUpu1n3mrSMU+4qdAQK65cPibe5wUVySWKldXtcAOe9DLmkRzjYplsJ6U2XaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691014776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gcyn36Jv3HtGUnwQSizKMwQBNb1jMXnbeMRFzDKvjBo=;
        b=g8rnXANsc0TqrXQZmd8vZaaHcBqXm2+NR00fd/tpojRmwuf6JaWktVPIU1wmJmT7ywR/pb
        tC/iIHOaReufZlAA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Add user-mode shadow stack support
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169101477502.28540.12081103518877160423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     2d39a6add422ac78254927ec2194838c33ae4fb2
Gitweb:        https://git.kernel.org/tip/2d39a6add422ac78254927ec2194838c33ae4fb2
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Aug 2023 15:01:50 -07:00

x86/shstk: Add user-mode shadow stack support

Introduce basic shadow stack enabling/disabling/allocation routines.
A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
and has a fixed size of min(RLIMIT_STACK, 4GB).

Keep the task's shadow stack address and size in thread_struct. This will
be copied when cloning new threads, but needs to be cleared during exec,
so add a function to do this.

32 bit shadow stack is not expected to have many users and it will
complicate the signal implementation. So do not support IA32 emulation
or x32.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-29-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/processor.h  |   2 +-
 arch/x86/include/asm/shstk.h      |   7 +-
 arch/x86/include/uapi/asm/prctl.h |   3 +-
 arch/x86/kernel/shstk.c           | 145 +++++++++++++++++++++++++++++-
 4 files changed, 157 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4e35f40..b216ac8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -479,6 +479,8 @@ struct thread_struct {
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 	unsigned long		features;
 	unsigned long		features_locked;
+
+	struct thread_shstk	shstk;
 #endif
 
 	/* Floating point and extended processor state */
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ec75380..2b1f7c9 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -8,12 +8,19 @@
 struct task_struct;
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
+struct thread_shstk {
+	u64	base;
+	u64	size;
+};
+
 long shstk_prctl(struct task_struct *task, int option, unsigned long features);
 void reset_thread_features(void);
+void shstk_free(struct task_struct *p);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
+static inline void shstk_free(struct task_struct *p) {}
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 1cd44ec..6a8e0e1 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -34,4 +34,7 @@
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
 
+/* ARCH_SHSTK_ features bits */
+#define ARCH_SHSTK_SHSTK		(1ULL <<  0)
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 41ed655..3cb8522 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -8,14 +8,159 @@
 
 #include <linux/sched.h>
 #include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/sched/signal.h>
+#include <linux/compat.h>
+#include <linux/sizes.h>
+#include <linux/user.h>
+#include <asm/msr.h>
+#include <asm/fpu/xstate.h>
+#include <asm/fpu/types.h>
+#include <asm/shstk.h>
+#include <asm/special_insns.h>
+#include <asm/fpu/api.h>
 #include <asm/prctl.h>
 
+static bool features_enabled(unsigned long features)
+{
+	return current->thread.features & features;
+}
+
+static void features_set(unsigned long features)
+{
+	current->thread.features |= features;
+}
+
+static void features_clr(unsigned long features)
+{
+	current->thread.features &= ~features;
+}
+
+static unsigned long alloc_shstk(unsigned long size)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, unused;
+
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
+
+	mmap_write_unlock(mm);
+
+	return addr;
+}
+
+static unsigned long adjust_shstk_size(unsigned long size)
+{
+	if (size)
+		return PAGE_ALIGN(size);
+
+	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
+}
+
+static void unmap_shadow_stack(u64 base, u64 size)
+{
+	while (1) {
+		int r;
+
+		r = vm_munmap(base, size);
+
+		/*
+		 * vm_munmap() returns -EINTR when mmap_lock is held by
+		 * something else, and that lock should not be held for a
+		 * long time.  Retry it for the case.
+		 */
+		if (r == -EINTR) {
+			cond_resched();
+			continue;
+		}
+
+		/*
+		 * For all other types of vm_munmap() failure, either the
+		 * system is out of memory or there is bug.
+		 */
+		WARN_ON_ONCE(r);
+		break;
+	}
+}
+
+static int shstk_setup(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long addr, size;
+
+	/* Already enabled */
+	if (features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	/* Also not supported for 32 bit and x32 */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_32bit_syscall())
+		return -EOPNOTSUPP;
+
+	size = adjust_shstk_size(0);
+	addr = alloc_shstk(size);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
+	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
+	fpregs_unlock();
+
+	shstk->base = addr;
+	shstk->size = size;
+	features_set(ARCH_SHSTK_SHSTK);
+
+	return 0;
+}
+
 void reset_thread_features(void)
 {
+	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
 	current->thread.features = 0;
 	current->thread.features_locked = 0;
 }
 
+void shstk_free(struct task_struct *tsk)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return;
+
+	if (!tsk->mm)
+		return;
+
+	unmap_shadow_stack(shstk->base, shstk->size);
+}
+
+static int shstk_disable(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -EOPNOTSUPP;
+
+	/* Already disabled? */
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	fpregs_lock_and_load();
+	/* Disable WRSS too when disabling shadow stack */
+	wrmsrl(MSR_IA32_U_CET, 0);
+	wrmsrl(MSR_IA32_PL3_SSP, 0);
+	fpregs_unlock();
+
+	shstk_free(current);
+	features_clr(ARCH_SHSTK_SHSTK);
+
+	return 0;
+}
+
 long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 {
 	if (option == ARCH_SHSTK_LOCK) {
