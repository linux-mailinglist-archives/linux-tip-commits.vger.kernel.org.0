Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B14455E18
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhKROhp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhKROhm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:42 -0500
Date:   Thu, 18 Nov 2021 14:34:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQdzq1DsmxcH0GD0n93+JdmlRYs9Fs8QH5ImpFeuNfM=;
        b=317AWbp/i/iCwLcaJoRQa6TSHtk45WfeBPfshjKmQomXdbnnaxjGd9EhNORzR/jgSxu9Yt
        gVAT9URWB9i9zJAgCbJsYsxIYVre6Yv/03J7PeaXgC5T+TpAKq+s7IB0Dc1oEvGFKy/2bI
        eNoUyYTfC6p0EHN9b6ibtxYDIMn4lqtKKxei7Pmg2A029hZ19rZ0hjkCuPAnDypnoH/HNV
        3Pkuqu0tLFLGGBW4mL3nRBpv7sDkfh/fZoaGC/cChNfM8adEDlJ7lEs6Gt4ELDKWn+aGMA
        LZwi6ZUu6ahDrskYiMdZNb0oUysKHnvAIqqfa26WoG71OU4nhRN6recEAwlIFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQdzq1DsmxcH0GD0n93+JdmlRYs9Fs8QH5ImpFeuNfM=;
        b=i9bzm6W6oaT/6yAezOwJFs8wZVJ+JyE/8XGv2musYhWt4DhchNGnmdpwEOVtcBWh+KOfb2
        WbgWD4tiEnnEv0CA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] KVM: Move x86's perf guest info callbacks to generic KVM
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-13-seanjc@google.com>
References: <20211111020738.2512932-13-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724608024.11128.11754092008754286426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e1bfc24577cc65c95dc519d7621a9c985b97e567
Gitweb:        https://git.kernel.org/tip/e1bfc24577cc65c95dc519d7621a9c985b97e567
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:33 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:10 +01:00

KVM: Move x86's perf guest info callbacks to generic KVM

Move x86's perf guest callbacks into common KVM, as they are semantically
identical to arm64's callbacks (the only other such KVM callbacks).
arm64 will convert to the common versions in a future patch.

Implement the necessary arm64 arch hooks now to avoid having to provide
stubs or a temporary #define (from x86) to avoid arm64 compilation errors
when CONFIG_GUEST_PERF_EVENTS=y.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211111020738.2512932-13-seanjc@google.com
---
 arch/arm64/include/asm/kvm_host.h | 10 ++++++-
 arch/arm64/kvm/arm.c              |  5 +++-
 arch/x86/include/asm/kvm_host.h   |  3 ++-
 arch/x86/kvm/x86.c                | 53 ++++++------------------------
 include/linux/kvm_host.h          | 10 ++++++-
 virt/kvm/kvm_main.c               | 44 +++++++++++++++++++++++++-
 6 files changed, 83 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f680f30..aa28b8e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -678,6 +678,16 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 void kvm_perf_init(void);
 void kvm_perf_teardown(void);
 
+/*
+ * Returns true if a Performance Monitoring Interrupt (PMI), a.k.a. perf event,
+ * arrived in guest context.  For arm64, any event that arrives while a vCPU is
+ * loaded is considered to be "in guest".
+ */
+static inline bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu)
+{
+	return IS_ENABLED(CONFIG_GUEST_PERF_EVENTS) && !!vcpu;
+}
+
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
 gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu);
 void kvm_update_stolen_time(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 2f03cbf..b400be9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -496,6 +496,11 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu_mode_priv(vcpu);
 }
 
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
+{
+	return *vcpu_pc(vcpu);
+}
+
 /* Just ensure a guest exit from a particular CPU */
 static void exit_vm_noop(void *info)
 {
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 38f01b0..8957654 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1567,6 +1567,9 @@ static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
 		return -ENOTSUPP;
 }
 
+#define kvm_arch_pmi_in_guest(vcpu) \
+	((vcpu) && (vcpu)->arch.handling_intr_from_guest)
+
 int kvm_mmu_module_init(void);
 void kvm_mmu_module_exit(void);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ab032ef..32cb6f9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8469,43 +8469,12 @@ static void kvm_timer_init(void)
 			  kvmclock_cpu_online, kvmclock_cpu_down_prep);
 }
 
-static inline bool kvm_pmi_in_guest(struct kvm_vcpu *vcpu)
-{
-	return vcpu && vcpu->arch.handling_intr_from_guest;
-}
-
-static unsigned int kvm_guest_state(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-	unsigned int state;
-
-	if (!kvm_pmi_in_guest(vcpu))
-		return 0;
-
-	state = PERF_GUEST_ACTIVE;
-	if (static_call(kvm_x86_get_cpl)(vcpu))
-		state |= PERF_GUEST_USER;
-
-	return state;
-}
-
-static unsigned long kvm_guest_get_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	/* Retrieving the IP must be guarded by a call to kvm_guest_state(). */
-	if (WARN_ON_ONCE(!kvm_pmi_in_guest(vcpu)))
-		return 0;
-
-	return kvm_rip_read(vcpu);
-}
-
 static unsigned int kvm_handle_intel_pt_intr(void)
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 
 	/* '0' on failure so that the !PT case can use a RET0 static call. */
-	if (!kvm_pmi_in_guest(vcpu))
+	if (!kvm_arch_pmi_in_guest(vcpu))
 		return 0;
 
 	kvm_make_request(KVM_REQ_PMI, vcpu);
@@ -8514,12 +8483,6 @@ static unsigned int kvm_handle_intel_pt_intr(void)
 	return 1;
 }
 
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.state			= kvm_guest_state,
-	.get_ip			= kvm_guest_get_ip,
-	.handle_intel_pt_intr	= NULL,
-};
-
 #ifdef CONFIG_X86_64
 static void pvclock_gtod_update_fn(struct work_struct *work)
 {
@@ -11229,9 +11192,11 @@ int kvm_arch_hardware_setup(void *opaque)
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 	kvm_ops_static_call_update();
 
+	/* Temporary ugliness. */
 	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
-		kvm_guest_cbs.handle_intel_pt_intr = kvm_handle_intel_pt_intr;
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+		kvm_register_perf_callbacks(kvm_handle_intel_pt_intr);
+	else
+		kvm_register_perf_callbacks(NULL);
 
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		supported_xss = 0;
@@ -11260,8 +11225,7 @@ int kvm_arch_hardware_setup(void *opaque)
 
 void kvm_arch_hardware_unsetup(void)
 {
-	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
-	kvm_guest_cbs.handle_intel_pt_intr = NULL;
+	kvm_unregister_perf_callbacks();
 
 	static_call(kvm_x86_hardware_unsetup)();
 }
@@ -11852,6 +11816,11 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu->arch.preempted_in_kernel;
 }
 
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
+{
+	return kvm_rip_read(vcpu);
+}
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9e0667e..9df7ab2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1170,6 +1170,16 @@ static inline bool kvm_arch_intc_initialized(struct kvm *kvm)
 }
 #endif
 
+#ifdef CONFIG_GUEST_PERF_EVENTS
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu);
+
+void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void));
+void kvm_unregister_perf_callbacks(void);
+#else
+static inline void kvm_register_perf_callbacks(void *ign) {}
+static inline void kvm_unregister_perf_callbacks(void) {}
+#endif /* CONFIG_GUEST_PERF_EVENTS */
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type);
 void kvm_arch_destroy_vm(struct kvm *kvm);
 void kvm_arch_sync_events(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d317245..76778dd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5479,6 +5479,50 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
         return &kvm_running_vcpu;
 }
 
+#ifdef CONFIG_GUEST_PERF_EVENTS
+static unsigned int kvm_guest_state(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+	unsigned int state;
+
+	if (!kvm_arch_pmi_in_guest(vcpu))
+		return 0;
+
+	state = PERF_GUEST_ACTIVE;
+	if (!kvm_arch_vcpu_in_kernel(vcpu))
+		state |= PERF_GUEST_USER;
+
+	return state;
+}
+
+static unsigned long kvm_guest_get_ip(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	/* Retrieving the IP must be guarded by a call to kvm_guest_state(). */
+	if (WARN_ON_ONCE(!kvm_arch_pmi_in_guest(vcpu)))
+		return 0;
+
+	return kvm_arch_vcpu_get_ip(vcpu);
+}
+
+static struct perf_guest_info_callbacks kvm_guest_cbs = {
+	.state			= kvm_guest_state,
+	.get_ip			= kvm_guest_get_ip,
+	.handle_intel_pt_intr	= NULL,
+};
+
+void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void))
+{
+	kvm_guest_cbs.handle_intel_pt_intr = pt_intr_handler;
+	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+}
+void kvm_unregister_perf_callbacks(void)
+{
+	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+}
+#endif
+
 struct kvm_cpu_compat_check {
 	void *opaque;
 	int *ret;
