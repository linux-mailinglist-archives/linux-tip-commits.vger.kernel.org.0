Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3930D27A04B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgI0JiE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0JiE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:38:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E63C0613CE;
        Sun, 27 Sep 2020 02:38:03 -0700 (PDT)
Date:   Sun, 27 Sep 2020 09:38:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601199482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htHzXy77MnnTbhQjtxNRUbK5U+bbsu86mp/9qyVbfZQ=;
        b=PX5mKtDstLhPlXn7ED+ZFkhtIi4mELSUviru7AkVdLnSUuwRlvxJbBUo/807zppYNYhTuA
        Jvm53E4b5J0KxJ0HBn9hoA8YLpuu3QAR6h5q4JtWNu2a3rNqbebAC8aqXic4QwfcIweY2z
        /gcdtLRNVZz4sfKs4/1lRLhtBxiGryqZ0Y4x1yAoNsYCb+sXyDyuexblqAtgrV2aM2Y1j3
        TT85L0dG6uih0xg/Y/09U8Yfq+yEHK1fhttv0fHYJk7pcpLr6dOzxrfYUfLUGiQVIjxzS3
        8l8EMkbfNwmGle9nSmam+kYzdUsZa1DFsjT3coWoM7OACIb4iR9qJ5qOvyEtrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601199482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htHzXy77MnnTbhQjtxNRUbK5U+bbsu86mp/9qyVbfZQ=;
        b=far8J8s00f/PH15VdzAhi9lYcU7VhgSt77taIR7n9/c7c8BV+pm6iBvWtuB2U3JNZvs2PJ
        xB+PUBbK0vWmkBBQ==
From:   "tip-bot2 for Joseph Salisbury" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/hyperv] x86/hyperv: Remove aliases with X64 in their name
Cc:     Joseph Salisbury <joseph.salisbury@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601130386-11111-1-git-send-email-jsalisbury@linux.microsoft.com>
References: <1601130386-11111-1-git-send-email-jsalisbury@linux.microsoft.com>
MIME-Version: 1.0
Message-ID: <160119948116.7002.8330625958203673427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/hyperv branch of tip:

Commit-ID:     dfc53baae3c6a165a35735b789e3e083786271d6
Gitweb:        https://git.kernel.org/tip/dfc53baae3c6a165a35735b789e3e083786271d6
Author:        Joseph Salisbury <joseph.salisbury@microsoft.com>
AuthorDate:    Sat, 26 Sep 2020 07:26:26 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 27 Sep 2020 11:34:54 +02:00

x86/hyperv: Remove aliases with X64 in their name

In the architecture independent version of hyperv-tlfs.h, commit c55a844f46f958b
removed the "X64" in the symbol names so they would make sense for both x86 and
ARM64.  That commit added aliases with the "X64" in the x86 version of hyperv-tlfs.h 
so that existing x86 code would continue to compile.

As a cleanup, update the x86 code to use the symbols without the "X64", then remove 
the aliases.  There's no functional change.

Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/1601130386-11111-1-git-send-email-jsalisbury@linux.microsoft.com

---
 arch/x86/hyperv/hv_init.c          |  8 +++----
 arch/x86/hyperv/hv_spinlock.c      |  2 +-
 arch/x86/include/asm/hyperv-tlfs.h | 33 +-----------------------------
 arch/x86/kernel/cpu/mshyperv.c     |  8 +++----
 arch/x86/kvm/hyperv.c              | 20 +++++++++---------
 5 files changed, 19 insertions(+), 52 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6035df1..e04d90a 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -148,9 +148,9 @@ static inline bool hv_reenlightenment_available(void)
 	 * Check for required features and priviliges to make TSC frequency
 	 * change notifications work.
 	 */
-	return ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
+	return ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 		ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE &&
-		ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT;
+		ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT;
 }
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_reenlightenment)
@@ -330,8 +330,8 @@ void __init hyperv_init(void)
 		return;
 
 	/* Absolutely required MSRs */
-	required_msrs = HV_X64_MSR_HYPERCALL_AVAILABLE |
-		HV_X64_MSR_VP_INDEX_AVAILABLE;
+	required_msrs = HV_MSR_HYPERCALL_AVAILABLE |
+		HV_MSR_VP_INDEX_AVAILABLE;
 
 	if ((ms_hyperv.features & required_msrs) != required_msrs)
 		return;
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 07f21a0..f3270c1 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -66,7 +66,7 @@ void __init hv_init_spinlocks(void)
 {
 	if (!hv_pvspin || !apic ||
 	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
-	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
+	    !(ms_hyperv.features & HV_MSR_GUEST_IDLE_AVAILABLE)) {
 		pr_info("PV spinlocks disabled\n");
 		return;
 	}
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 7a4d206..0ed20e8 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -28,39 +28,6 @@
 #define HYPERV_CPUID_MAX			0x4000ffff
 
 /*
- * Aliases for Group A features that have X64 in the name.
- * On x86/x64 these are HYPERV_CPUID_FEATURES.EAX bits.
- */
-
-#define HV_X64_MSR_VP_RUNTIME_AVAILABLE		\
-		HV_MSR_VP_RUNTIME_AVAILABLE
-#define HV_X64_MSR_SYNIC_AVAILABLE		\
-		HV_MSR_SYNIC_AVAILABLE
-#define HV_X64_MSR_APIC_ACCESS_AVAILABLE	\
-		HV_MSR_APIC_ACCESS_AVAILABLE
-#define HV_X64_MSR_HYPERCALL_AVAILABLE		\
-		HV_MSR_HYPERCALL_AVAILABLE
-#define HV_X64_MSR_VP_INDEX_AVAILABLE		\
-		HV_MSR_VP_INDEX_AVAILABLE
-#define HV_X64_MSR_RESET_AVAILABLE		\
-		HV_MSR_RESET_AVAILABLE
-#define HV_X64_MSR_GUEST_IDLE_AVAILABLE		\
-		HV_MSR_GUEST_IDLE_AVAILABLE
-#define HV_X64_ACCESS_FREQUENCY_MSRS		\
-		HV_ACCESS_FREQUENCY_MSRS
-#define HV_X64_ACCESS_REENLIGHTENMENT		\
-		HV_ACCESS_REENLIGHTENMENT
-#define HV_X64_ACCESS_TSC_INVARIANT		\
-		HV_ACCESS_TSC_INVARIANT
-
-/*
- * Aliases for Group B features that have X64 in the name.
- * On x86/x64 these are HYPERV_CPUID_FEATURES.EBX bits.
- */
-#define HV_X64_POST_MESSAGES		HV_POST_MESSAGES
-#define HV_X64_SIGNAL_EVENTS		HV_SIGNAL_EVENTS
-
-/*
  * Group D Features.  The bit assignments are custom to each architecture.
  * On x86/x64 these are HYPERV_CPUID_FEATURES.EDX bits.
  */
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3112544..9834a43 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -248,7 +248,7 @@ static void __init ms_hyperv_init_platform(void)
 			hv_host_info_edx >> 24, hv_host_info_edx & 0xFFFFFF);
 	}
 
-	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
+	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
@@ -270,7 +270,7 @@ static void __init ms_hyperv_init_platform(void)
 		crash_kexec_post_notifiers = true;
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
+	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		/*
 		 * Get the APIC frequency.
@@ -296,7 +296,7 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.shutdown = hv_machine_shutdown;
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
-	if (ms_hyperv.features & HV_X64_ACCESS_TSC_INVARIANT) {
+	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	} else {
@@ -330,7 +330,7 @@ static void __init ms_hyperv_init_platform(void)
 	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
 
 	/* Setup the IDT for reenlightenment notifications */
-	if (ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT) {
+	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
 		alloc_intr_gate(HYPERV_REENLIGHTENMENT_VECTOR,
 				asm_sysvec_hyperv_reenlightenment);
 	}
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 1d33056..8c1e833 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2000,20 +2000,20 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			break;
 
 		case HYPERV_CPUID_FEATURES:
-			ent->eax |= HV_X64_MSR_VP_RUNTIME_AVAILABLE;
+			ent->eax |= HV_MSR_VP_RUNTIME_AVAILABLE;
 			ent->eax |= HV_MSR_TIME_REF_COUNT_AVAILABLE;
-			ent->eax |= HV_X64_MSR_SYNIC_AVAILABLE;
+			ent->eax |= HV_MSR_SYNIC_AVAILABLE;
 			ent->eax |= HV_MSR_SYNTIMER_AVAILABLE;
-			ent->eax |= HV_X64_MSR_APIC_ACCESS_AVAILABLE;
-			ent->eax |= HV_X64_MSR_HYPERCALL_AVAILABLE;
-			ent->eax |= HV_X64_MSR_VP_INDEX_AVAILABLE;
-			ent->eax |= HV_X64_MSR_RESET_AVAILABLE;
+			ent->eax |= HV_MSR_APIC_ACCESS_AVAILABLE;
+			ent->eax |= HV_MSR_HYPERCALL_AVAILABLE;
+			ent->eax |= HV_MSR_VP_INDEX_AVAILABLE;
+			ent->eax |= HV_MSR_RESET_AVAILABLE;
 			ent->eax |= HV_MSR_REFERENCE_TSC_AVAILABLE;
-			ent->eax |= HV_X64_ACCESS_FREQUENCY_MSRS;
-			ent->eax |= HV_X64_ACCESS_REENLIGHTENMENT;
+			ent->eax |= HV_ACCESS_FREQUENCY_MSRS;
+			ent->eax |= HV_ACCESS_REENLIGHTENMENT;
 
-			ent->ebx |= HV_X64_POST_MESSAGES;
-			ent->ebx |= HV_X64_SIGNAL_EVENTS;
+			ent->ebx |= HV_POST_MESSAGES;
+			ent->ebx |= HV_SIGNAL_EVENTS;
 
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
 			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
