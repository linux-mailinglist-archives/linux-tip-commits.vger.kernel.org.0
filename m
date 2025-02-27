Return-Path: <linux-tip-commits+bounces-3695-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32979A479D8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9464D16F589
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF0229B32;
	Thu, 27 Feb 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWcKUxWi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVbucNur"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC05227E9F;
	Thu, 27 Feb 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651127; cv=none; b=NlUTN7M5Qh1/stPxh76sBqgjNxZ3V/o07jWVc5DnV/iPobDoB1NAtNmkyiRJQFnJxI96zffvT+ovBOnPsVepfalBK2rDhrp7G41wOuNevlGy1Syfn0QtJQSAj4CBOOLkWSB4gtcleId1Y/Oh46FvXGNx5vlTnqUbTu52VCeVLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651127; c=relaxed/simple;
	bh=yPPjYg2MPC3loQddpXdHS122QuJb6BDP+DiCTIUaOas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NHVIqYUAcn/H7EWCLeG1sD0+Yv+GG4uVQSSLPPMgwEwRwh2ZQa85XoJPLL7XSfj8o8F393nrmcndheTxDuo7p3Z8kq5FjwPh5hzTXpWCQxaK0xFrDi35woyl5uGegkOMTbvrKoUXNUUkjUSh3QIuQ73QuVNre/SuzajFW63sKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWcKUxWi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVbucNur; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740651123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ey3fjvBrGuE99ckrkrimsJPnUnDZi8vpt+g8vEP7gE=;
	b=MWcKUxWiaordh7VZ8TAJ3faEMwApmh+lkzAGez5s15HGtf82Fai4+BN0EeOySaaL0c4+wU
	BAOLOB+uI/TlKQ46zj6y3foHH/rn/hhNp8GyMKIk9VIiACuoy/lkD9B+shJ/1mm3iqv3NI
	IEYLUAYSOuv5QLiH3X4VaxxoNvxS6zrV0XMDB1Fp1WrdyKh/fC6PtNkgd5NIufK/xW768B
	9vyzQLFpXGjOwcCFgQcfJvTe1HFuin/U+nwf2iGHeeMKkCnuf8eJVD9Ip+umjq432KF8i0
	gy1IgcqQ7Po184XPXhG6OEQgUYsUqvjIrg1ga2mC2sZiGb8c4UGtjgRUmjGVyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740651123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ey3fjvBrGuE99ckrkrimsJPnUnDZi8vpt+g8vEP7gE=;
	b=HVbucNuronL5onImWlvU6dGajF56NdJOdvmV46SpilycKVmZrPBMX01EMUBNDHbnMczk2z
	K1X02uaNjf1stsAQ==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Use a static branch to guard IBPB on vCPU switch
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Sean Christopherson <seanjc@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250227012712.3193063-5-yosry.ahmed@linux.dev>
References: <20250227012712.3193063-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065112276.10177.15875859543519400534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     80dacb080461edfc1d854721ee6933a4cfa3b602
Gitweb:        https://git.kernel.org/tip/80dacb080461edfc1d854721ee6933a4cfa3b602
Author:        Yosry Ahmed <yosry.ahmed@linux.dev>
AuthorDate:    Thu, 27 Feb 2025 01:27:10 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:57:20 +01:00

x86/bugs: Use a static branch to guard IBPB on vCPU switch

Instead of using X86_FEATURE_USE_IBPB to guard the IBPB execution in KVM
when a new vCPU is loaded, introduce a static branch, similar to
switch_mm_*_ibpb.

This makes it obvious in spectre_v2_user_select_mitigation() what
exactly is being toggled, instead of the unclear X86_FEATURE_USE_IBPB
(which will be shortly removed). It also provides more fine-grained
control, making it simpler to change/add paths that control the IBPB in
the vCPU switch path without affecting other IBPBs.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250227012712.3193063-5-yosry.ahmed@linux.dev
---
 arch/x86/include/asm/nospec-branch.h | 2 ++
 arch/x86/kernel/cpu/bugs.c           | 5 +++++
 arch/x86/kvm/svm/svm.c               | 2 +-
 arch/x86/kvm/vmx/vmx.c               | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7cbb76a..36bc395 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -552,6 +552,8 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
+DECLARE_STATIC_KEY_FALSE(switch_vcpu_ibpb);
+
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1d7afc4..7f904d0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -113,6 +113,10 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
+/* Control IBPB on vCPU load */
+DEFINE_STATIC_KEY_FALSE(switch_vcpu_ibpb);
+EXPORT_SYMBOL_GPL(switch_vcpu_ibpb);
+
 /* Control MDS CPU buffer clear before idling (halt, mwait) */
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
@@ -1365,6 +1369,7 @@ spectre_v2_user_select_mitigation(void)
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
+		static_branch_enable(&switch_vcpu_ibpb);
 
 		spectre_v2_user_ibpb = mode;
 		switch (cmd) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 57222c3..a73875f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1566,7 +1566,7 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		sd->current_vmcb = svm->vmcb;
 
 		if (!cpu_feature_enabled(X86_FEATURE_IBPB_ON_VMEXIT) &&
-		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		    static_branch_likely(&switch_vcpu_ibpb))
 			indirect_branch_prediction_barrier();
 	}
 	if (kvm_vcpu_apicv_active(vcpu))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 042b7a8..956f914 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1477,7 +1477,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 		 * performs IBPB on nested VM-Exit (a single nested transition
 		 * may switch the active VMCS multiple times).
 		 */
-		if (cpu_feature_enabled(X86_FEATURE_USE_IBPB) &&
+		if (static_branch_likely(&switch_vcpu_ibpb) &&
 		    (!buddy || WARN_ON_ONCE(buddy->vmcs != prev)))
 			indirect_branch_prediction_barrier();
 	}

