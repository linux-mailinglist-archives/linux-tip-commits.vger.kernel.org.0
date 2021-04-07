Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7453568D0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350514AbhDGKE2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350528AbhDGKDw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1BC0613D9;
        Wed,  7 Apr 2021 03:03:36 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nziLcGO2w3qVZKyHGNyygANdQ6GxIGwlaGLGMjHg0/E=;
        b=11y+m88Jv+KixYoUPQHrsUeaQvFJiMovM21YSE6Xo1KoZRRu3WcQBC3U1aTenyrM5Rv8fv
        FAetLVxwy84NJRZ8Uf0iYw339zXjUMN5nixFa4RyiZogxRbcPI/cIrxf36mpDg3t860Lix
        tpiIKvkPQZ7koG87ivNjCeW5IgNSMLoRZ9uar2szG1mxd/HwG8LT/lSIYNPk3WSBQMfwxv
        BtoE4TYvmQ8IB9SG6tnnrUI0kt7DwCZKqnTLL1OiAmSPF5b3WUC/P3N53EolOGdrswDyhd
        5TRqW0LPpHq6hwXYYJX+x1JPpEequ88m8bJKyoqRZ/OOAMjJJPtqMS6Er4lMQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nziLcGO2w3qVZKyHGNyygANdQ6GxIGwlaGLGMjHg0/E=;
        b=9TRdcrrvD1/xYiMGJnV/arMXxck57bDeQ8Fx9q4OEs61uF5DwJ+0RhWLWXgLNPkSe0ebew
        2fEAtnSCpH5vYrDw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/cpufeatures: Add SGX1 and SGX2 sub-features
Cc:     Sean Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d787827dbfca6b3210ac3e432e3ac1202727e786.1616136308.git.kai.huang@intel.com>
References: <d787827dbfca6b3210ac3e432e3ac1202727e786.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981435.29796.4135853860293456647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     b8921dccf3b25798409d35155b5d127085de72c2
Gitweb:        https://git.kernel.org/tip/b8921dccf3b25798409d35155b5d127085de72c2
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 19 Mar 2021 20:22:18 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 25 Mar 2021 17:33:11 +01:00

x86/cpufeatures: Add SGX1 and SGX2 sub-features

Add SGX1 and SGX2 feature flags, via CPUID.0x12.0x0.EAX, as scattered
features, since adding a new leaf for only two bits would be wasteful.
As part of virtualizing SGX, KVM will expose the SGX CPUID leafs to its
guest, and to do so correctly needs to query hardware and kernel support
for SGX1 and SGX2.

Suppress both SGX1 and SGX2 from /proc/cpuinfo. SGX1 basically means
SGX, and for SGX2 there is no concrete use case of using it in
/proc/cpuinfo.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/d787827dbfca6b3210ac3e432e3ac1202727e786.1616136308.git.kai.huang@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c   | 2 ++
 arch/x86/kernel/cpu/scattered.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26..1f918f5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -290,6 +290,8 @@
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
 #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
 #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
+#define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */
+#define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Management (EDMM) */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index d40f8e0..defda61 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -73,6 +73,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
+	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
+	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 972ec3b..21d1f06 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -36,6 +36,8 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
 	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3 },
+	{ X86_FEATURE_SGX1,		CPUID_EAX,  0, 0x00000012, 0 },
+	{ X86_FEATURE_SGX2,		CPUID_EAX,  1, 0x00000012, 0 },
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
