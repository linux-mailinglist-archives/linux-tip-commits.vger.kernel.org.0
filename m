Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8B43B6D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhJZQTT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbhJZQTL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:11 -0400
Date:   Tue, 26 Oct 2021 16:16:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhRv5KYhzL5n+F6xM+YD0OseinxQELeUYtJFqKclIcA=;
        b=nRE1EJ1Ig/yob53mURX8rKjVMabgijjEuSXTjCgcIYcL6EysidvTpgPwNhvdPlAAsqOAdr
        SKYw6wLANcbVZROeGu82KK0nPuwivpyzZU1zzXaJslUFBG2iPyk7Vey+XJ2+k0DuUV2Am4
        Oq6dh9SRoNw5oaJ/+YAN4OX1Od5mxZw+sPcL1TUVxAQfZCtdRdjtJc+KT7wBWwqnoaz6JZ
        AUsMA9nLeuyFR5pqChwXmXuGXEO/kNFc3ULVpHebBMsrOeaTp+lugwy7trTHcR3wMnHNS0
        TbvO7iOtzdUXU6RxVoAmFT+RMe+RWeZNdnzw+btOcdARdABwOMNB318TylB1BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhRv5KYhzL5n+F6xM+YD0OseinxQELeUYtJFqKclIcA=;
        b=U3l9LBAoDymYgCe88Op1iDJyRpmlCPFE9PN+ViQX+ykjPpl/1otzyrXK6XM+G4Yd1pq+L2
        2L0euG66yaUMFkAQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/arch_prctl: Add controls for dynamic XSTATE components
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-7-chang.seok.bae@intel.com>
References: <20211021225527.10184-7-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500560.626.15446300690121145682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     db8268df0983adc2bb1fb48c9e5f7bfbb5f617f3
Gitweb:        https://git.kernel.org/tip/db8268df0983adc2bb1fb48c9e5f7bfbb5f617f3
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/arch_prctl: Add controls for dynamic XSTATE components

Dynamically enabled XSTATE features are by default disabled for all
processes. A process has to request permission to use such a feature.

To support this implement a architecture specific prctl() with the options:

   - ARCH_GET_XCOMP_SUPP

     Copies the supported feature bitmap into the user space provided
     u64 storage. The pointer is handed in via arg2

   - ARCH_GET_XCOMP_PERM

     Copies the process wide permitted feature bitmap into the user space
     provided u64 storage. The pointer is handed in via arg2

   - ARCH_REQ_XCOMP_PERM

     Request permission for a feature set. A feature set can be mapped to a
     facility, e.g. AMX, and can require one or more XSTATE components to
     be enabled.

     The feature argument is the number of the highest XSTATE component
     which is required for a facility to work.

     The request argument is not a user supplied bitmap because that makes
     filtering harder (think seccomp) and even impossible because to
     support 32bit tasks the argument would have to be a pointer.

The permission mechanism works this way:

   Task asks for permission for a facility and kernel checks whether that's
   supported. If supported it does:

     1) Check whether permission has already been granted

     2) Compute the size of the required kernel and user space buffer
        (sigframe) size.

     3) Validate that no task has a sigaltstack installed
        which is smaller than the resulting sigframe size

     4) Add the requested feature bit(s) to the permission bitmap of
        current->group_leader->fpu and store the sizes in the group
        leaders fpu struct as well.

If that is successful then the feature is still not enabled for any of the
tasks. The first usage of a related instruction will result in a #NM
trap. The trap handler validates the permission bit of the tasks group
leader and if permitted it installs a larger kernel buffer and transfers
the permission and size info to the new fpstate container which makes all
the FPU functions which require per task information aware of the extended
feature set.

  [ tglx: Adopted to new base code, added missing serialization,
          massaged namings, comments and changelog ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-7-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/api.h    |   4 +-
 arch/x86/include/asm/proto.h      |   2 +-
 arch/x86/include/uapi/asm/prctl.h |   4 +-
 arch/x86/kernel/fpu/xstate.c      | 156 +++++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/xstate.h      |   6 +-
 arch/x86/kernel/process.c         |   9 +-
 6 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index e9379d7..798ae92 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -151,4 +151,8 @@ static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 	return gfpu->fpstate->is_confidential;
 }
 
+/* prctl */
+struct task_struct;
+extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2);
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 8c5d191..feed36d 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -40,6 +40,6 @@ void x86_report_nx(void);
 extern int reboot_force;
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled);
+			  unsigned long arg2);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9..754a078 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,10 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012
 
+#define ARCH_GET_XCOMP_SUPP	0x1021
+#define ARCH_GET_XCOMP_PERM	0x1022
+#define ARCH_REQ_XCOMP_PERM	0x1023
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 310c420..c837cff 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -8,6 +8,7 @@
 #include <linux/compat.h>
 #include <linux/cpu.h>
 #include <linux/mman.h>
+#include <linux/nospec.h>
 #include <linux/pkeys.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
@@ -18,6 +19,8 @@
 #include <asm/fpu/xcr.h>
 
 #include <asm/tlbflush.h>
+#include <asm/prctl.h>
+#include <asm/elf.h>
 
 #include "internal.h"
 #include "legacy.h"
@@ -1298,6 +1301,159 @@ void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature)
 EXPORT_SYMBOL_GPL(fpstate_clear_xstate_component);
 #endif
 
+#ifdef CONFIG_X86_64
+static int validate_sigaltstack(unsigned int usize)
+{
+	struct task_struct *thread, *leader = current->group_leader;
+	unsigned long framesize = get_sigframe_size();
+
+	lockdep_assert_held(&current->sighand->siglock);
+
+	/* get_sigframe_size() is based on fpu_user_cfg.max_size */
+	framesize -= fpu_user_cfg.max_size;
+	framesize += usize;
+	for_each_thread(leader, thread) {
+		if (thread->sas_ss_size && thread->sas_ss_size < framesize)
+			return -ENOSPC;
+	}
+	return 0;
+}
+
+static int __xstate_request_perm(u64 permitted, u64 requested)
+{
+	/*
+	 * This deliberately does not exclude !XSAVES as we still might
+	 * decide to optionally context switch XCR0 or talk the silicon
+	 * vendors into extending XFD for the pre AMX states.
+	 */
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
+	struct fpu *fpu = &current->group_leader->thread.fpu;
+	unsigned int ksize, usize;
+	u64 mask;
+	int ret;
+
+	/* Check whether fully enabled */
+	if ((permitted & requested) == requested)
+		return 0;
+
+	/* Calculate the resulting kernel state size */
+	mask = permitted | requested;
+	ksize = xstate_calculate_size(mask, compacted);
+
+	/* Calculate the resulting user state size */
+	mask &= XFEATURE_MASK_USER_SUPPORTED;
+	usize = xstate_calculate_size(mask, false);
+
+	ret = validate_sigaltstack(usize);
+	if (ret)
+		return ret;
+
+	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
+	WRITE_ONCE(fpu->perm.__state_perm, requested);
+	/* Protected by sighand lock */
+	fpu->perm.__state_size = ksize;
+	fpu->perm.__user_state_size = usize;
+	return ret;
+}
+
+/*
+ * Permissions array to map facilities with more than one component
+ */
+static const u64 xstate_prctl_req[XFEATURE_MAX] = {
+	/* [XFEATURE_XTILE_DATA] = XFEATURE_MASK_XTILE, */
+};
+
+static int xstate_request_perm(unsigned long idx)
+{
+	u64 permitted, requested;
+	int ret;
+
+	if (idx >= XFEATURE_MAX)
+		return -EINVAL;
+
+	/*
+	 * Look up the facility mask which can require more than
+	 * one xstate component.
+	 */
+	idx = array_index_nospec(idx, ARRAY_SIZE(xstate_prctl_req));
+	requested = xstate_prctl_req[idx];
+	if (!requested)
+		return -EOPNOTSUPP;
+
+	if ((fpu_user_cfg.max_features & requested) != requested)
+		return -EOPNOTSUPP;
+
+	/* Lockless quick check */
+	permitted = xstate_get_host_group_perm();
+	if ((permitted & requested) == requested)
+		return 0;
+
+	/* Protect against concurrent modifications */
+	spin_lock_irq(&current->sighand->siglock);
+	permitted = xstate_get_host_group_perm();
+	ret = __xstate_request_perm(permitted, requested);
+	spin_unlock_irq(&current->sighand->siglock);
+	return ret;
+}
+#else /* CONFIG_X86_64 */
+static inline int xstate_request_perm(unsigned long idx)
+{
+	return -EPERM;
+}
+#endif  /* !CONFIG_X86_64 */
+
+/**
+ * fpu_xstate_prctl - xstate permission operations
+ * @tsk:	Redundant pointer to current
+ * @option:	A subfunction of arch_prctl()
+ * @arg2:	option argument
+ * Return:	0 if successful; otherwise, an error code
+ *
+ * Option arguments:
+ *
+ * ARCH_GET_XCOMP_SUPP: Pointer to user space u64 to store the info
+ * ARCH_GET_XCOMP_PERM: Pointer to user space u64 to store the info
+ * ARCH_REQ_XCOMP_PERM: Facility number requested
+ *
+ * For facilities which require more than one XSTATE component, the request
+ * must be the highest state component number related to that facility,
+ * e.g. for AMX which requires XFEATURE_XTILE_CFG(17) and
+ * XFEATURE_XTILE_DATA(18) this would be XFEATURE_XTILE_DATA(18).
+ */
+long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2)
+{
+	u64 __user *uptr = (u64 __user *)arg2;
+	u64 permitted, supported;
+	unsigned long idx = arg2;
+
+	if (tsk != current)
+		return -EPERM;
+
+	switch (option) {
+	case ARCH_GET_XCOMP_SUPP:
+		supported = fpu_user_cfg.max_features |	fpu_user_cfg.legacy_features;
+		return put_user(supported, uptr);
+
+	case ARCH_GET_XCOMP_PERM:
+		/*
+		 * Lockless snapshot as it can also change right after the
+		 * dropping the lock.
+		 */
+		permitted = xstate_get_host_group_perm();
+		permitted &= XFEATURE_MASK_USER_SUPPORTED;
+		return put_user(permitted, uptr);
+
+	case ARCH_REQ_XCOMP_PERM:
+		if (!IS_ENABLED(CONFIG_X86_64))
+			return -EOPNOTSUPP;
+
+		return xstate_request_perm(idx);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a1aa0ba..4ce1dc0 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -15,6 +15,12 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
 }
 
+static inline u64 xstate_get_host_group_perm(void)
+{
+	/* Pairs with WRITE_ONCE() in xstate_request_perm() */
+	return READ_ONCE(current->group_leader->thread.fpu.perm.__state_perm);
+}
+
 enum xstate_copy_mode {
 	XSTATE_COPY_FP,
 	XSTATE_COPY_FX,
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c74c7e8..97fea16 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -30,6 +30,7 @@
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
+#include <asm/fpu/api.h>
 #include <asm/fpu/sched.h>
 #include <asm/debugreg.h>
 #include <asm/nmi.h>
@@ -1003,13 +1004,17 @@ out:
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, cpuid_enabled);
+		return set_cpuid_mode(task, arg2);
+	case ARCH_GET_XCOMP_SUPP:
+	case ARCH_GET_XCOMP_PERM:
+	case ARCH_REQ_XCOMP_PERM:
+		return fpu_xstate_prctl(task, option, arg2);
 	}
 
 	return -EINVAL;
