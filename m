Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C2737EDD0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbhELUzJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355850AbhELS3Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 14:29:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E46C061760;
        Wed, 12 May 2021 11:26:24 -0700 (PDT)
Date:   Wed, 12 May 2021 18:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620843983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AWD3mej6+YH1TsbEsjmBeiMwRHlC/JaiyzjcGBD0EsM=;
        b=gwzpUIFkSNGaaTqvuoNt/GFEuoNckR14ypb/RBoWW4R6lYackRDmDkevtpOioGuIJB3vn6
        aapUoIzQJFPVHCB7VyoQm0OhOCJ4tiYjAAowH4Gl+2ozf50Q2m4501TqYLvJ1XAJ7roiXe
        JwG8gLJpGrJk2xHYaD1yUFZW2A1pKdHJOGAb2T+GqrUlKkvHVZplCACwrSRPcoKMvpqExj
        yimcKDCDkPy5d+Ck4uPB5uIWC9kmCHD8a0Syc/Jjao/FNUE8tk60zZNKF4TzYO785va50e
        33JO8veWtUPHh1UJHo62GfWg8aBf42mVnPIKjLXSHXi4vwuZ1X8GxMQ36XU3cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620843983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AWD3mej6+YH1TsbEsjmBeiMwRHlC/JaiyzjcGBD0EsM=;
        b=MMqR+gtusJw7Eimwc3HhrAm+tFi2JwoYK79o/jQ6NIyTsjsV1cCVvzWrTp493w0A8buAjn
        JJH3gecx9kuIkEBA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix leftover comment typos
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162084398226.29796.274994682161914739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c43426334b3169b6c9e6855483aa7384ff09fd33
Gitweb:        https://git.kernel.org/tip/c43426334b3169b6c9e6855483aa7384ff09fd33
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 12 May 2021 19:58:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 20:00:51 +02:00

x86: Fix leftover comment typos

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/hyperv/hv_init.c             | 2 +-
 arch/x86/include/asm/sgx.h            | 2 +-
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/kprobes/core.c        | 2 +-
 arch/x86/kvm/mmu/mmu.c                | 2 +-
 arch/x86/kvm/mmu/tdp_mmu.c            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index bb0ae4b..256ad0e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -623,7 +623,7 @@ bool hv_query_ext_cap(u64 cap_query)
 	 * output parameter to the hypercall below and so it should be
 	 * compatible with 'virt_to_phys'. Which means, it's address should be
 	 * directly mapped. Use 'static' to keep it compatible; stack variables
-	 * can be virtually mapped, making them imcompatible with
+	 * can be virtually mapped, making them incompatible with
 	 * 'virt_to_phys'.
 	 * Hypercall input/output addresses should also be 8-byte aligned.
 	 */
diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 9c31e0e..05f3e21 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -13,7 +13,7 @@
 /*
  * This file contains both data structures defined by SGX architecture and Linux
  * defined software data structures and functions.  The two should not be mixed
- * together for better readibility.  The architectural definitions come first.
+ * together for better readability.  The architectural definitions come first.
  */
 
 /* The SGX specific CPUID function. */
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index b6ffe58..24a8d6c 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -11,7 +11,7 @@
  * The same segment is shared by percpu area and stack canary.  On
  * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
  * base of percpu area.  The first occupant of the percpu area is always
- * fixed_percpu_data which contains stack_canary at the approproate
+ * fixed_percpu_data which contains stack_canary at the appropriate
  * offset.  On x86_32, the stack canary is just a regular percpu
  * variable.
  *
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index d3d6554..7c4d073 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -674,7 +674,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 			break;
 
 		if (insn->addr_bytes != sizeof(unsigned long))
-			return -EOPNOTSUPP;	/* Don't support differnt size */
+			return -EOPNOTSUPP;	/* Don't support different size */
 		if (X86_MODRM_MOD(opcode) != 3)
 			return -EOPNOTSUPP;	/* TODO: support memory addressing */
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0144c40..5e60b00 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2374,7 +2374,7 @@ static int make_mmu_pages_available(struct kvm_vcpu *vcpu)
 	 * page is available, while the caller may end up allocating as many as
 	 * four pages, e.g. for PAE roots or for 5-level paging.  Temporarily
 	 * exceeding the (arbitrary by default) limit will not harm the host,
-	 * being too agressive may unnecessarily kill the guest, and getting an
+	 * being too aggressive may unnecessarily kill the guest, and getting an
 	 * exact count is far more trouble than it's worth, especially in the
 	 * page fault paths.
 	 */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 95eeb5a..e09cb1f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1017,7 +1017,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 
 		if (!is_shadow_present_pte(iter.old_spte)) {
 			/*
-			 * If SPTE has been forzen by another thread, just
+			 * If SPTE has been frozen by another thread, just
 			 * give up and retry, avoiding unnecessary page table
 			 * allocation and free.
 			 */
