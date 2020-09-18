Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7926F731
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgIRHmc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgIRHmc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B2C06174A;
        Fri, 18 Sep 2020 00:42:32 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4ym9UsBz5rYoVCY4AwPPjFFSAGU6He+DXx+Q/F1kBo=;
        b=o78pEIgVILctWQgk0Rsxm4hpR9H1HSsLAW9tye+eGKrVny/GTdMOuxZqr8VuDij6w3rD8R
        We83crCtl/1DnGj9kg+iUYIfnExPnu6jwwhJttzeHAmnzZ1jXe3Lx8CrQYwMOK8fZlsvIH
        l8hsJuNZBn+zX8Efyd1rZxVm6pla7pf26W2dJdqvYeYL4+4gApTnSZmO8YL/Et1c0Zj+LV
        L7RIlqL0A9U3IcwQhWh8PCpaXpo7bnT2YL2se/GZxNltAfUMWVXmFEPTepzz0HlmQN37Ag
        tkpsTRFT55A/525LLlTnzq7RFOc07ruewT79QUuMSpO0nCyR7+Vr5i+cTViKfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4ym9UsBz5rYoVCY4AwPPjFFSAGU6He+DXx+Q/F1kBo=;
        b=ZtbTDJHQbVgAh13Jq8vf/NOpqH18W2UQZw4WhoZA4z3bbpSZHSwfPUeO8nHsJg6ySECfB2
        xe48L8abAnj37qCA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/mmu: Allocate/free a PASID
Cc:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041494860.15536.17836058382507805954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     20f0afd1fb3d7d44f4a3db5a4b6e904410862140
Gitweb:        https://git.kernel.org/tip/20f0afd1fb3d7d44f4a3db5a4b6e904410862140
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:13 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 20:22:15 +02:00

x86/mmu: Allocate/free a PASID

A PASID is allocated for an "mm" the first time any thread binds to an
SVA-capable device and is freed from the "mm" when the SVA is unbound
by the last thread. It's possible for the "mm" to have different PASID
values in different binding/unbinding SVA cycles.

The mm's PASID (non-zero for valid PASID or 0 for invalid PASID) is
propagated to a per-thread PASID MSR for all threads within the mm
through IPI, context switch, or inherited. This is done to ensure that a
running thread has the right PASID in the MSR matching the mm's PASID.

 [ bp: s/SVM/SVA/g; massage. ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1600187413-163670-10-git-send-email-fenghua.yu@intel.com
---
 arch/x86/include/asm/fpu/api.h      | 12 ++++++-
 arch/x86/include/asm/fpu/internal.h |  7 +++-
 arch/x86/kernel/fpu/xstate.c        | 57 ++++++++++++++++++++++++++++-
 drivers/iommu/intel/svm.c           | 28 +++++++++++++-
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index b774c52..dcd9503 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -62,4 +62,16 @@ extern void switch_fpu_return(void);
  */
 extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
 
+/*
+ * Tasks that are not using SVA have mm->pasid set to zero to note that they
+ * will not have the valid bit set in MSR_IA32_PASID while they are running.
+ */
+#define PASID_DISABLED	0
+
+#ifdef CONFIG_IOMMU_SUPPORT
+/* Update current's PASID MSR/state by mm's PASID. */
+void update_pasid(void);
+#else
+static inline void update_pasid(void) { }
+#endif
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 0a460f2..341d00e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -583,6 +583,13 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 			pkru_val = pk->pkru;
 	}
 	__write_pkru(pkru_val);
+
+	/*
+	 * Expensive PASID MSR write will be avoided in update_pasid() because
+	 * TIF_NEED_FPU_LOAD was set. And the PASID state won't be updated
+	 * unless it's different from mm->pasid to reduce overhead.
+	 */
+	update_pasid();
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 67f1a03..5d80474 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1402,3 +1402,60 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+#ifdef CONFIG_IOMMU_SUPPORT
+void update_pasid(void)
+{
+	u64 pasid_state;
+	u32 pasid;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return;
+
+	if (!current->mm)
+		return;
+
+	pasid = READ_ONCE(current->mm->pasid);
+	/* Set the valid bit in the PASID MSR/state only for valid pasid. */
+	pasid_state = pasid == PASID_DISABLED ?
+		      pasid : pasid | MSR_IA32_PASID_VALID;
+
+	/*
+	 * No need to hold fregs_lock() since the task's fpstate won't
+	 * be changed by others (e.g. ptrace) while the task is being
+	 * switched to or is in IPI.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		/* The MSR is active and can be directly updated. */
+		wrmsrl(MSR_IA32_PASID, pasid_state);
+	} else {
+		struct fpu *fpu = &current->thread.fpu;
+		struct ia32_pasid_state *ppasid_state;
+		struct xregs_state *xsave;
+
+		/*
+		 * The CPU's xstate registers are not currently active. Just
+		 * update the PASID state in the memory buffer here. The
+		 * PASID MSR will be loaded when returning to user mode.
+		 */
+		xsave = &fpu->state.xsave;
+		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
+		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
+		/*
+		 * Since XFEATURE_MASK_PASID is set in xfeatures, ppasid_state
+		 * won't be NULL and no need to check its value.
+		 *
+		 * Only update the task's PASID state when it's different
+		 * from the mm's pasid.
+		 */
+		if (ppasid_state->pasid != pasid_state) {
+			/*
+			 * Invalid fpregs so that state restoring will pick up
+			 * the PASID state.
+			 */
+			__fpu_invalidate_fpregs_state(fpu);
+			ppasid_state->pasid = pasid_state;
+		}
+	}
+}
+#endif /* CONFIG_IOMMU_SUPPORT */
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fc90a07..60ffe08 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -19,6 +19,7 @@
 #include <linux/mm_types.h>
 #include <linux/ioasid.h>
 #include <asm/page.h>
+#include <asm/fpu/api.h>
 
 #include "pasid.h"
 
@@ -444,6 +445,24 @@ out:
 	return ret;
 }
 
+static void _load_pasid(void *unused)
+{
+	update_pasid();
+}
+
+static void load_pasid(struct mm_struct *mm, u32 pasid)
+{
+	mutex_lock(&mm->context.lock);
+
+	/* Synchronize with READ_ONCE in update_pasid(). */
+	smp_store_release(&mm->pasid, pasid);
+
+	/* Update PASID MSR on all CPUs running the mm's tasks. */
+	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
+
+	mutex_unlock(&mm->context.lock);
+}
+
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
@@ -591,6 +610,10 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		}
 
 		list_add_tail(&svm->list, &global_svm_list);
+		if (mm) {
+			/* The newly allocated pasid is loaded to the mm. */
+			load_pasid(mm, svm->pasid);
+		}
 	} else {
 		/*
 		 * Binding a new device with existing PASID, need to setup
@@ -654,8 +677,11 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 
 			if (list_empty(&svm->devs)) {
 				ioasid_free(svm->pasid);
-				if (svm->mm)
+				if (svm->mm) {
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
+					/* Clear mm's pasid. */
+					load_pasid(svm->mm, PASID_DISABLED);
+				}
 				list_del(&svm->list);
 				/* We mandate that no page faults may be outstanding
 				 * for the PASID when intel_svm_unbind_mm() is called.
