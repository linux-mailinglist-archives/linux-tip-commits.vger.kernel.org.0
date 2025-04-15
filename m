Return-Path: <linux-tip-commits+bounces-4993-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC6A8A943
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 22:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E13E1900BEE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03330254872;
	Tue, 15 Apr 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yxAn/d20";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nvV4T/W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA2251790;
	Tue, 15 Apr 2025 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748804; cv=none; b=cIja7BdiKIybrKSG4cT54xqyMq41dvRS6OkYy+q3X6dmnRb55GGkDyxtAAV8/fSgUMWMSPqvwvicyMda9wpe2k190Q6838RhCaKluDgO7g+qKWZ+fjw8bGWM7ZnjTfv94eNelbkI3SF2EQYFQyYtRta1UajFptvcN7kSGkJp92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748804; c=relaxed/simple;
	bh=3zSv6tt/8UWvGb3NyynfypH3Nubv1KM3HCgDQjGpZpM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M+tjXkU5ZIQ3HOucZ17wG+nvSmdgLa5jlkVF7RCxXJiWqBNwKr9widVMpSnmeQLb/joUhYIok+QknlSHNjNcL18hv3eWKs7PmsxH7gFChF/y49b6pYWcpyFFA541u8qvWd5h1xCdl5zEj6s9oijdbqueMIEemyxfjYQdAva5O8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yxAn/d20; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nvV4T/W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 20:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744748795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBRjhv9ePgPQmnVnwWtoD5ZqcJe8IVtsg6FHj+Sup2s=;
	b=yxAn/d208OtgaB0PHHg2vq9m4cgTf47NLp5PBzIxA8DmuTd6CVRjPROOqD3EqKk2F0Hl+Y
	6liRGvih3YvydZup8j4l/PwyUqnZd6MMQa0SRoLZxXc3gTrbBxRo+bKOWzZUguoxUTtHI5
	AHPpJ5JWC+SDekF6bv4EJxM0t7uHrTHrOAFVlk13FGN24LiN0xJv4ZckLJtyyoPC7HMPMa
	H7X0wnGo0pvjuaBib30Mg399COyEX5cVTeaKTLvHf2NsBxCOJ+1Ht3ROn9y30kIf9eqDB2
	DXzJ8lcGRRr4Gk1E1iibjwXs8JN+1lS4zXrHLIAze6BWOMXbA7RIzmwMxcFKEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744748795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBRjhv9ePgPQmnVnwWtoD5ZqcJe8IVtsg6FHj+Sup2s=;
	b=0nvV4T/WFYBVo1PuPiazke1SzD+hTBGFEHtFQsI6+kYw3e8l3tkpjv+0uo6ofsNFD1Bnnz
	KbEAP6c2mzmYMJAQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpufeatures: Shorten X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415175410.2944032-3-xin@zytor.com>
References: <20250415175410.2944032-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174474879408.31282.1332107078743444126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     13327fada7ff0ae858e28b9515cd7d6ccb5fccc7
Gitweb:        https://git.kernel.org/tip/13327fada7ff0ae858e28b9515cd7d6ccb5fccc7
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 15 Apr 2025 10:54:09 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 15 Apr 2025 22:09:16 +02:00

x86/cpufeatures: Shorten X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT

Shorten X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT to
X86_FEATURE_CLEAR_BHB_VMEXIT to make the last column aligned
consistently in the whole file.

There's no need to explain in the name what the mitigation does.

No functional changes.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250415175410.2944032-3-xin@zytor.com
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/include/asm/nospec-branch.h     | 2 +-
 arch/x86/kernel/cpu/bugs.c               | 6 +++---
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 60b4a4c..bd27a1d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -476,7 +476,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* Clear branch history at syscall entry using SW loop */
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
-#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_CLEAR_BHB_VMEXIT	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 8a5cc8e..707ee52 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -327,7 +327,7 @@
 .endm
 
 .macro CLEAR_BRANCH_HISTORY_VMEXIT
-	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT
+	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_VMEXIT
 .endm
 #else
 #define CLEAR_BRANCH_HISTORY
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a91a1ca..3228f5d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1701,13 +1701,13 @@ static void __init bhi_select_mitigation(void)
 
 	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
 		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit only\n");
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
 		return;
 	}
 
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and VM exit\n");
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
 }
 
 static void __init spectre_v2_select_mitigation(void)
@@ -2891,7 +2891,7 @@ static const char *spectre_bhi_state(void)
 		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
 		 rrsba_disabled)
 		return "; BHI: Retpoline";
-	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";
 
 	return "; BHI: Vulnerable";
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 2e219be..e10c3f4 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -466,7 +466,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* Clear branch history at syscall entry using SW loop */
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
-#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_CLEAR_BHB_VMEXIT	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */

