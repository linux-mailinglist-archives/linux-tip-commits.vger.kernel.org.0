Return-Path: <linux-tip-commits+bounces-5015-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65699A90A98
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73465A14ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F5204598;
	Wed, 16 Apr 2025 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXoFOOUM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nIvTe/0X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CE17A302;
	Wed, 16 Apr 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826227; cv=none; b=j2FyNsd56GvybUQ4RuPvaKcbg7NvMEJ93gcpr69BoccK+5a/hD4bCfRKfRsAA6O/07sb55V1jEs86IBcgXICVmflYB5tpUs+xd2KdjU3Cxo4m1xrTQwyn2OfdZ7dhk42AMw5CYB/TWi4pgN/LNohJIP24G3lvgaDVbQVhKeDXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826227; c=relaxed/simple;
	bh=w/+VvnaX9XqMugN34PceUSxBXDforvtEajVM/0HAoeE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pQJ4Cs1YWJHJR5YxdO3aplShBoiTUy1p/HXea+/Doy2dQhQwAucBp40zo5PGtjT4jSxFVwbL1uriqsfxUlDcp0oviQOcz6YSAT/z06DL9ZJBlrJn2CvK+fjnwOsSTTTapvriCnzlDdUBL8rk9BRTo0stUVPggipyyrQC5Xw/t+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXoFOOUM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nIvTe/0X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 17:56:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744826223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Xsf10dIAqnAF2ECrxgcaAvbZRzlsqA/1bTFId4bg/k=;
	b=cXoFOOUMR+svZUItFvGyzQ27aHHUUuLndyKS+M88+1Hs3G6dBbSyyBeECmnr5YvjYhZLW5
	TPnUDGCuw6Hciux0XQxt8/d2Pg5v8FX8hQfh9EcmeyryG5IqWJI/3DaV0ziYjuWQ+D5B9D
	+6KN6/cyk6i8vVjmHhGm9wULwqMSi3UHQ+KDbgXrlHgYMRhI4l5YOFaeAOa4DvZbYe7A7r
	JuDKOK8jQqexeAdILTuFUh4VP6oRTrrOM2lpJzW7jibWfPehs/Yg5HlJuvFv4YRGLjIc/x
	v1huFxzYdaIfpf5Fr2YyvEzn2Xkg1zEnYnO4/QtFW67vWFbzjXCAC0tECluxmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744826223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Xsf10dIAqnAF2ECrxgcaAvbZRzlsqA/1bTFId4bg/k=;
	b=nIvTe/0Xh11vsMKAIaAlNiwpETrMhpA+uJGQaeIgzZ26GlarFJx2HVTHZBUtP99R8HLY+7
	5p8PSa87DTr3aOCw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Rename mmio_stale_data_clear to cpu_buf_vm_clear
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416-mmio-rename-v2-1-ad1f5488767c@linux.intel.com>
References: <20250416-mmio-rename-v2-1-ad1f5488767c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174482621725.31282.15395514760827222939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     d9b79111fd9945931b7a2b2a3e7db7625dd953fe
Gitweb:        https://git.kernel.org/tip/d9b79111fd9945931b7a2b2a3e7db7625dd953fe
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 16 Apr 2025 06:47:51 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Apr 2025 19:40:01 +02:00

x86/bugs: Rename mmio_stale_data_clear to cpu_buf_vm_clear

The static key mmio_stale_data_clear controls the KVM-only mitigation for MMIO
Stale Data vulnerability. Rename it to reflect its purpose.

No functional change.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250416-mmio-rename-v2-1-ad1f5488767c@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           | 16 ++++++++++------
 arch/x86/kvm/vmx/vmx.c               |  6 +++++-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5c43f14..81c4a13 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -561,7 +561,7 @@ DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
-DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
+DECLARE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
 
 extern u16 mds_verw_sel;
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 362602b..9131e61 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -127,9 +127,13 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
  */
 DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
-/* Controls CPU Fill buffer clear before KVM guest MMIO accesses */
-DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
-EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
+/*
+ * Controls CPU Fill buffer clear before VMenter. This is a subset of
+ * X86_FEATURE_CLEAR_CPU_BUF, and should only be enabled when KVM-only
+ * mitigation is required.
+ */
+DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
+EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
 
 void __init cpu_select_mitigations(void)
 {
@@ -449,9 +453,9 @@ static void __init mmio_select_mitigation(void)
 	 * mitigations, disable KVM-only mitigation in that case.
 	 */
 	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
-		static_branch_disable(&mmio_stale_data_clear);
+		static_branch_disable(&cpu_buf_vm_clear);
 	else
-		static_branch_enable(&mmio_stale_data_clear);
+		static_branch_enable(&cpu_buf_vm_clear);
 
 	/*
 	 * If Processor-MMIO-Stale-Data bug is present and Fill Buffer data can
@@ -571,7 +575,7 @@ static void __init md_clear_update_mitigation(void)
 		taa_select_mitigation();
 	}
 	/*
-	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
+	 * MMIO_MITIGATION_OFF is not checked here so that cpu_buf_vm_clear
 	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
 	 */
 	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c57664..a1754f7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7358,10 +7358,14 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	 * mitigation for MDS is done late in VMentry and is still
 	 * executed in spite of L1D Flush. This is because an extra VERW
 	 * should not matter much after the big hammer L1D Flush.
+	 *
+	 * cpu_buf_vm_clear is used when system is not vulnerable to MDS/TAA,
+	 * and is affected by MMIO Stale Data. In such cases mitigation in only
+	 * needed against an MMIO capable guest.
 	 */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
-	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
+	else if (static_branch_unlikely(&cpu_buf_vm_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
 		mds_clear_cpu_buffers();
 

