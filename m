Return-Path: <linux-tip-commits+bounces-3698-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A13A479DE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C748B172C93
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6FB22ACF7;
	Thu, 27 Feb 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyeaTlhd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJow0rjS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAA229B27;
	Thu, 27 Feb 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651130; cv=none; b=Sh5U1JS9tjlQomG2Xe+a1PESewysDOZVxiGKRE8j3vpYbl4bvr28Ouh/VbOr6mjG+/KoV4YJGXxtZDQUwm6D4YhXRAuNlua9/kwXAzpVye6o2/WOYMxFOVvA8618JcC5aRo4k8/Zbj3hHPgvtlLdD/UWH6/bnfK0HSPVAAzjNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651130; c=relaxed/simple;
	bh=ADX3WX6eNoBxRZ6nUTBfwOyan34FOcNMP+IoeH5X/ao=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S9oPTK7W0szxaMXwilDzrGM0sLb2xoIWZC5h2As5d0Pr6GV5sTd2+NCqFUytJthecgek/mWoIMee1N1dciK7N3WqpBXaFNw5SeYlvtJzfVQ8AtpzBpRFMAnTIfjFTI3QuvVTPahVPFrVL4la1TQ25OHyJmb1jfrRGMx08j0Mr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyeaTlhd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJow0rjS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:12:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740651125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3XII2LpOmo3joNcFi4IL9GMHxWZrmHUidcOciNhJ0Y=;
	b=AyeaTlhdPeIoLXb3AyKvLt0OtxrEZlOBatU01LAi9176VOVe0wgdOG8bT1cJHqAA8Rdpip
	CMCvh8YfMFIgC9xfEkzdOQL36Yyo512a5NHmnfTZlmN2sJ250lP3XrUnjfuuBoZ1GOvQWD
	RnCtNRkrAkvuR27L6JafaVarlMXeflmExBQ2WJF2qcuS+V6dx4y5US8vYji6UA0GYNShIe
	ow+5HHSah56aeYwGt9qfqlGyVvievxCdIqWEJbmQZw9HwmB1O1WYqXuW5e4cNSgmy57bu6
	r688FPtu2xEWRkUqzwR65RgHK0WLH30hzc7Zp8K3y2qNwi4x7a+ji+91DPXwZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740651125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3XII2LpOmo3joNcFi4IL9GMHxWZrmHUidcOciNhJ0Y=;
	b=xJow0rjST78sg10O/weCZph9erejes6H2mw6lqhN4uSnqdEqpPdZ1T4eagag7BaHqoPIh8
	mQ6rL9mHplFMzRAQ==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Move the X86_FEATURE_USE_IBPB check into callers
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Sean Christopherson <seanjc@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250227012712.3193063-2-yosry.ahmed@linux.dev>
References: <20250227012712.3193063-2-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065112507.10177.1542837749277153210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     549435aab49ae83d60a08795de6cf0e866f3b2ec
Gitweb:        https://git.kernel.org/tip/549435aab49ae83d60a08795de6cf0e866f3b2ec
Author:        Yosry Ahmed <yosry.ahmed@linux.dev>
AuthorDate:    Thu, 27 Feb 2025 01:27:07 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:57:20 +01:00

x86/bugs: Move the X86_FEATURE_USE_IBPB check into callers

indirect_branch_prediction_barrier() only performs the MSR write if
X86_FEATURE_USE_IBPB is set, using alternative_msr_write(). In
preparation for removing X86_FEATURE_USE_IBPB, move the feature check
into the callers so that they can be addressed one-by-one, and use
X86_FEATURE_IBPB instead to guard the MSR write.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250227012712.3193063-2-yosry.ahmed@linux.dev
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 arch/x86/kernel/cpu/bugs.c           | 2 +-
 arch/x86/kvm/svm/svm.c               | 3 ++-
 arch/x86/kvm/vmx/nested.c            | 3 ++-
 arch/x86/kvm/vmx/vmx.c               | 3 ++-
 arch/x86/mm/tlb.c                    | 7 ++++---
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7e8bf78..7cbb76a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -515,7 +515,7 @@ extern u64 x86_pred_cmd;
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_msr_write(MSR_IA32_PRED_CMD, x86_pred_cmd, X86_FEATURE_USE_IBPB);
+	alternative_msr_write(MSR_IA32_PRED_CMD, x86_pred_cmd, X86_FEATURE_IBPB);
 }
 
 /* The Intel SPEC CTRL MSR base value cache */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1d7afc4..754150f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2272,7 +2272,7 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
 			task_set_spec_ib_force_disable(task);
 		task_update_spec_tif(task);
-		if (task == current)
+		if (task == current && cpu_feature_enabled(X86_FEATURE_USE_IBPB))
 			indirect_branch_prediction_barrier();
 		break;
 	default:
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 77ab66c..57222c3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1565,7 +1565,8 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (sd->current_vmcb != svm->vmcb) {
 		sd->current_vmcb = svm->vmcb;
 
-		if (!cpu_feature_enabled(X86_FEATURE_IBPB_ON_VMEXIT))
+		if (!cpu_feature_enabled(X86_FEATURE_IBPB_ON_VMEXIT) &&
+		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
 			indirect_branch_prediction_barrier();
 	}
 	if (kvm_vcpu_apicv_active(vcpu))
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8a7af02..1df427a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5026,7 +5026,8 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	 * doesn't isolate different VMCSs, i.e. in this case, doesn't provide
 	 * separate modes for L2 vs L1.
 	 */
-	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL))
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+	    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
 		indirect_branch_prediction_barrier();
 
 	/* Update any VMCS fields that might have changed while L2 ran */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6c56d52..042b7a8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1477,7 +1477,8 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 		 * performs IBPB on nested VM-Exit (a single nested transition
 		 * may switch the active VMCS multiple times).
 		 */
-		if (!buddy || WARN_ON_ONCE(buddy->vmcs != prev))
+		if (cpu_feature_enabled(X86_FEATURE_USE_IBPB) &&
+		    (!buddy || WARN_ON_ONCE(buddy->vmcs != prev)))
 			indirect_branch_prediction_barrier();
 	}
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6cf881a..4f61d11 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -437,7 +437,8 @@ static void cond_mitigation(struct task_struct *next)
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
-		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
+		    (next_mm | prev_mm) & LAST_USER_MM_IBPB &&
+		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
 			indirect_branch_prediction_barrier();
 	}
 
@@ -447,8 +448,8 @@ static void cond_mitigation(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=
-					(unsigned long)next->mm)
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) != (unsigned long)next->mm &&
+		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
 			indirect_branch_prediction_barrier();
 	}
 

