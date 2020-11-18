Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5963B2B82EB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgKRRSc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgKRRSb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:31 -0500
Date:   Wed, 18 Nov 2020 17:18:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lj5xKezh/hRRSkcxLYhu+3AbrRL+2Df/WzM+/aMISFg=;
        b=vETwEhOhmEtIf9kUtHphjqVBWk5Lpk5Jeby/650iBFDBvucl/BBOBsFCUryM8JmhDKnXH1
        ClKc7lezf0nvNLC9Td5/E+L6z6C5MdgcDnqnyuoi/VWHL10WyJ6L34R5KV/KBsEjm8edjk
        8Pc95uiS7svAmoROm0llvIx9yKeno9JL3GYuAKSLrmgfqzi6T2keZma31dH54PF9eviex3
        blDy9IETxJATmE78t8NLo4e+stOhYb5TAi24WKTxZMFKUowPSSM0PyQ/oEtrcPtn3XGP54
        +8p/VJF1ST6qYxQwmTtQZFbhIPZ12UH7BX0uQxZj8ul+hLB1gNoeT9mvyjrg/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lj5xKezh/hRRSkcxLYhu+3AbrRL+2Df/WzM+/aMISFg=;
        b=u3BtsYBl6JXOCNh70jPthv9xTX08ujrtNk9tWS1VvYgLJVlgm5imrG0M4Rb+rBHyyD+Qzg
        QGDv8gsJbQTG4PAw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/cpufeatures: Add Intel SGX hardware bits
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-4-jarkko@kernel.org>
References: <20201112220135.165028-4-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990886.11244.5648418399015385989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     e7b6385b01d8e9fb7a97887c3ea649abb95bb8c8
Gitweb:        https://git.kernel.org/tip/e7b6385b01d8e9fb7a97887c3ea649abb95bb8c8
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:14 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:13 +01:00

x86/cpufeatures: Add Intel SGX hardware bits

Populate X86_FEATURE_SGX feature from CPUID and tie it to the Kconfig
option with disabled-features.h.

IA32_FEATURE_CONTROL.SGX_ENABLE must be examined in addition to the CPUID
bits to enable full SGX support.  The BIOS must both set this bit and lock
IA32_FEATURE_CONTROL for SGX to be supported (Intel SDM section 36.7.1).
The setting or clearing of this bit has no impact on the CPUID bits above,
which is why it needs to be detected separately.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-4-jarkko@kernel.org
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/include/asm/msr-index.h         | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dad350d..1181f5c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -241,6 +241,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
 #define X86_FEATURE_TSC_ADJUST		( 9*32+ 1) /* TSC adjustment MSR 0x3B */
+#define X86_FEATURE_SGX			( 9*32+ 2) /* Software Guard Extensions */
 #define X86_FEATURE_BMI1		( 9*32+ 3) /* 1st group bit manipulation extensions */
 #define X86_FEATURE_HLE			( 9*32+ 4) /* Hardware Lock Elision */
 #define X86_FEATURE_AVX2		( 9*32+ 5) /* AVX2 instructions */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 5861d34..7947cb1 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -62,6 +62,12 @@
 # define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
 #endif
 
+#ifdef CONFIG_X86_SGX
+# define DISABLE_SGX	0
+#else
+# define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -74,7 +80,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_SMAP)
+#define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 972a34d..258d555 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -609,6 +609,7 @@
 #define FEAT_CTL_LOCKED				BIT(0)
 #define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
 #define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_SGX_ENABLED			BIT(18)
 #define FEAT_CTL_LMCE_ENABLED			BIT(20)
 
 #define MSR_IA32_TSC_ADJUST             0x0000003b
