Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDB455E15
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhKROhn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhKROhl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:41 -0500
Date:   Thu, 18 Nov 2021 14:34:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XB0yrhfv3sssqomSQ4HSXXRtimmdj724HP8rI26qNZ4=;
        b=vdo2SsYv64iQYdAZpu0EB6lOuTEEeqRt/lSEHsIWerDK5y9B+jzQYApIOwphPFwt1XKdFi
        p0gAc0Ym4VG5HM9MNJAd38+JAWEbmPgTG7IsXA2sq6oN960mVsYI6DSte/jaeosGp6suRP
        JOtR7oMGpfYIsFRjE5EmTIiewTY2/iQWG9gCAkWf5t1WtLgUlN6/60AWYE+8xx9toaqvsn
        4UN+dqFJzAu3xfS/o1INdHF4/AbN/yHSJAHNw6AhEtEyk3L22RAwyP2OhM/Y0VsHCIq9op
        tP2tLWBMY21LriGlQb0enlb2ezsVNuvVNqaiddLFatu4w7aC1uf9ygF6BJsvzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XB0yrhfv3sssqomSQ4HSXXRtimmdj724HP8rI26qNZ4=;
        b=fZXr78ZF4cpt96fE+1EaKMXTuhbfTkZ2wNftJ0Folx7v+eDiAo1CvHIpaWbc4LJD3bvU9M
        WG8eJ4J1ewozsNBw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] KVM: x86: Move Intel Processor Trace interrupt
 handler to vmx.c
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-14-seanjc@google.com>
References: <20211111020738.2512932-14-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724607950.11128.17507543152649000197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     33271a9e2b52e07e278a67c900d2d2afb5c55bd5
Gitweb:        https://git.kernel.org/tip/33271a9e2b52e07e278a67c900d2d2afb5c55bd5
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:34 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:10 +01:00

KVM: x86: Move Intel Processor Trace interrupt handler to vmx.c

Now that all state needed for VMX's PT interrupt handler is exposed to
vmx.c (specifically the currently running vCPU), move the handler into
vmx.c where it belongs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211111020738.2512932-14-seanjc@google.com
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 22 +++++++++++++++++++++-
 arch/x86/kvm/x86.c              | 20 +-------------------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8957654..298224f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1517,7 +1517,7 @@ struct kvm_x86_init_ops {
 	int (*disabled_by_bios)(void);
 	int (*check_processor_compatibility)(void);
 	int (*hardware_setup)(void);
-	bool (*intel_pt_intr_in_guest)(void);
+	unsigned int (*handle_intel_pt_intr)(void);
 
 	struct kvm_x86_ops *runtime_ops;
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a0c2497..b258f90 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7655,6 +7655,20 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
 };
 
+static unsigned int vmx_handle_intel_pt_intr(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	/* '0' on failure so that the !PT case can use a RET0 static call. */
+	if (!kvm_arch_pmi_in_guest(vcpu))
+		return 0;
+
+	kvm_make_request(KVM_REQ_PMI, vcpu);
+	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+		  (unsigned long *)&vcpu->arch.pmu.global_status);
+	return 1;
+}
+
 static __init void vmx_setup_user_return_msrs(void)
 {
 
@@ -7681,6 +7695,8 @@ static __init void vmx_setup_user_return_msrs(void)
 		kvm_add_user_return_msr(vmx_uret_msrs_list[i]);
 }
 
+static struct kvm_x86_init_ops vmx_init_ops __initdata;
+
 static __init int hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -7839,6 +7855,10 @@ static __init int hardware_setup(void)
 		return -EINVAL;
 	if (!enable_ept || !cpu_has_vmx_intel_pt())
 		pt_mode = PT_MODE_SYSTEM;
+	if (pt_mode == PT_MODE_HOST_GUEST)
+		vmx_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
+	else
+		vmx_init_ops.handle_intel_pt_intr = NULL;
 
 	setup_default_sgx_lepubkeyhash();
 
@@ -7867,7 +7887,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 	.disabled_by_bios = vmx_disabled_by_bios,
 	.check_processor_compatibility = vmx_check_processor_compat,
 	.hardware_setup = hardware_setup,
-	.intel_pt_intr_in_guest = vmx_pt_mode_is_host_guest,
+	.handle_intel_pt_intr = NULL,
 
 	.runtime_ops = &vmx_x86_ops,
 };
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32cb6f9..4e0ed2f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8469,20 +8469,6 @@ static void kvm_timer_init(void)
 			  kvmclock_cpu_online, kvmclock_cpu_down_prep);
 }
 
-static unsigned int kvm_handle_intel_pt_intr(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	/* '0' on failure so that the !PT case can use a RET0 static call. */
-	if (!kvm_arch_pmi_in_guest(vcpu))
-		return 0;
-
-	kvm_make_request(KVM_REQ_PMI, vcpu);
-	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
-			(unsigned long *)&vcpu->arch.pmu.global_status);
-	return 1;
-}
-
 #ifdef CONFIG_X86_64
 static void pvclock_gtod_update_fn(struct work_struct *work)
 {
@@ -11192,11 +11178,7 @@ int kvm_arch_hardware_setup(void *opaque)
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 	kvm_ops_static_call_update();
 
-	/* Temporary ugliness. */
-	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
-		kvm_register_perf_callbacks(kvm_handle_intel_pt_intr);
-	else
-		kvm_register_perf_callbacks(NULL);
+	kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
 
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		supported_xss = 0;
