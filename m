Return-Path: <linux-tip-commits+bounces-5180-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A59AA6FB1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AFA1BC11F3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62FD20E6E7;
	Fri,  2 May 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vs3+W5ZS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I9PlMOPf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0E79D2;
	Fri,  2 May 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182004; cv=none; b=iyApB61+dnjmQYe8jSYuaQUjoXFgB9pJtgT3L7uiWQLiaarjOaXU7evQV19yUfnqEq7LJyjtG4tvih/6OK4LTggkCGxbrBVii4gEtH2y43+apyw80Fk0+lDmuA0hwT2vgqfp9u+G4bH1/J03vRoE4OpfyiRQgx9Kr9k2zeSzklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182004; c=relaxed/simple;
	bh=kWVYp1X9EMVkhHKe2qMihc1zNSk46s7GyfQUw0nJkjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sQPYkt/zjWWM3VSDTr55AgbjFIzXCKruZk2y2g4hluU7yTCU+HjrZCve4Kpc4/5GeKmJQiv2jmoWSfK2gGhLJr9hPltN31YTSPVGXyr7l9EuC4+uiMCqRqzL3mShLDvIcCLbG9jjMi/un8QEl2q5EF4gYMPuLC+q+IkVFAtYpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vs3+W5ZS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I9PlMOPf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 10:33:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746182000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiH/hk0vZo1sihawLn/P10wG4NsxuCpp+GocUDhesl4=;
	b=Vs3+W5ZS3JSKsovNWvBfGhDM8Rx6gD3qMv1KJqEVHhW1NJVfcb+fxhFE08asdheoJURil0
	CBjH2Ny/4RDPlNHMpVOLKEr4VQI4Mi9QD7ZdOo9nSFvu+gki4icqfRJfSg4X1/O8mpi9s2
	VA6cUOb1/xN98ubxYpevOixhTYf/AH3GECYcRepHBISnYQ5qsLvp9HBecFbFPJ3OAV9KpL
	0pORIkoS0gaOmQuIpitg7Rg39g2piiod77bKmFmNRyQnjxjW18+stymZBUUQ0kID6qbUnk
	vMVcmSmyIkKSbozbHRfITKha6as+deZcsKg5rZZRpfbL1yOIofN1nTvsLzTEAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746182000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiH/hk0vZo1sihawLn/P10wG4NsxuCpp+GocUDhesl4=;
	b=I9PlMOPf5EcKybqgFszhEjJzzpRqHFpN3t5fZPInCaKaA+aKxKZN57MtbMEv7A02M5PNsV
	gIVDnKMieSkzvbCA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Restructure L1TF mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418161721.1855190-16-david.kaplan@amd.com>
References: <20250418161721.1855190-16-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174618199974.22196.12832189173399649709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     d43ba2dc8eeeca21811fd9b30e3bd15bb35caaec
Gitweb:        https://git.kernel.org/tip/d43ba2dc8eeeca21811fd9b30e3bd15bb35caaec
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:17:20 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 29 Apr 2025 18:57:30 +02:00

x86/bugs: Restructure L1TF mitigation

Restructure L1TF to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for L1TF.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/20250418161721.1855190-16-david.kaplan@amd.com
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 25 +++++++++++++++++++------
 arch/x86/kvm/vmx/vmx.c           |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5..0973bed 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -734,6 +734,7 @@ void store_cpu_caps(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
+	L1TF_MITIGATION_AUTO,
 	L1TF_MITIGATION_FLUSH_NOWARN,
 	L1TF_MITIGATION_FLUSH,
 	L1TF_MITIGATION_FLUSH_NOSMT,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fbb4f13..25d84e2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -67,6 +67,7 @@ static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init ssb_apply_mitigation(void);
 static void __init l1tf_select_mitigation(void);
+static void __init l1tf_apply_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
 static void __init mds_apply_mitigation(void);
@@ -245,6 +246,7 @@ void __init cpu_select_mitigations(void)
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
 	ssb_apply_mitigation();
+	l1tf_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2538,7 +2540,7 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 
 /* Default mitigation for L1TF-affected CPUs */
 enum l1tf_mitigations l1tf_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_AUTO : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
@@ -2586,22 +2588,33 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 
 static void __init l1tf_select_mitigation(void)
 {
+	if (!boot_cpu_has_bug(X86_BUG_L1TF) || cpu_mitigations_off()) {
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
+		return;
+	}
+
+	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
+		if (cpu_mitigations_auto_nosmt())
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+		else
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+	}
+}
+
+static void __init l1tf_apply_mitigation(void)
+{
 	u64 half_pa;
 
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
-	if (cpu_mitigations_off())
-		l1tf_mitigation = L1TF_MITIGATION_OFF;
-	else if (cpu_mitigations_auto_nosmt())
-		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-
 	override_cache_bits(&boot_cpu_data);
 
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
 	case L1TF_MITIGATION_FLUSH:
+	case L1TF_MITIGATION_AUTO:
 		break;
 	case L1TF_MITIGATION_FLUSH_NOSMT:
 	case L1TF_MITIGATION_FULL:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a1754f7..0aba471 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -273,6 +273,7 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		case L1TF_MITIGATION_OFF:
 			l1tf = VMENTER_L1D_FLUSH_NEVER;
 			break;
+		case L1TF_MITIGATION_AUTO:
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
@@ -7704,6 +7705,7 @@ int vmx_vm_init(struct kvm *kvm)
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 			/* 'I explicitly don't care' is set */
 			break;
+		case L1TF_MITIGATION_AUTO:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
 		case L1TF_MITIGATION_FULL:

