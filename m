Return-Path: <linux-tip-commits+bounces-4381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7BA68B16
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D21B62988
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9CE26036D;
	Wed, 19 Mar 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4qVKyS+6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGjK+Kjr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860A25E811;
	Wed, 19 Mar 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382245; cv=none; b=CJVFe/J4ibbbLkn7zpdaXh0SLRGRKY5PdBPxrRDUNXC+GMkrzWDiEvx3iCf4uDDqwh9Qc1L/jUOW0nmMQx2FGTzCoZj3yKznbRjwvgWb5uEud84t0JnY1C1ROBhTSsjsdR20/3J70zRyKouMGhtpYPZ4T2ga3TA/6gt94lcodaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382245; c=relaxed/simple;
	bh=l+on7R5Y6+XecxoITPJgS3Csw2vA1NK3XOoX1qqh34U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=toqrVNB9FUUlguZNr+cksj7fBj+GUFbpDK6A96B5XCnToNaFQ5MQPHUqh1xGtW8xw6Nc8/TOvDPqdVBrOJCijON8bsi9MchDnTf/x/LpNEorw622nCdi5GUmPfwsyXnYIE41pLiGSe6Pz/BxUMZpEv2edMAEHNGoglROhbdqGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4qVKyS+6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGjK+Kjr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNS9ff1cuq8WEgIjZdejiuqYCw85FhSA0J4XZFIyqCA=;
	b=4qVKyS+6fppByLBr9c7CVag6ObEfr+1bmojW6HbAwz/wMkqV/zHABvhyOUST7NqYrQ1jQB
	E2CjH96g49FTpI2cnAaZmJSggljPnGA419S0EcInnlywTjNOriQyWLbqCLS8msZcFoWDor
	ZDhB0HAoXjrOMHcV6nRVVDZUVZlr2/JkwHL8eHNoPpKyo7f3Zq7kGImUoFZxI3aczoHsaj
	uZxmCy2elkzV3guCXtcGyYQxPqfgx94dJT48jz3fOEisqO6GcjcUDM2iSNMnGjrYq25g+J
	9sVf3EKD8e9ZlFUHMIB9LiBoJ88cwyWWPCeQcf7ya8VFYHfvUZsHxjGfS2YRiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNS9ff1cuq8WEgIjZdejiuqYCw85FhSA0J4XZFIyqCA=;
	b=rGjK+KjrVuHFxKuy717dZNCTThHbvUYQuAU7jdH3MaXgliVz48tM9NLMHBhqyCskYK6Wsn
	gulmEYs2BPPxW7AQ==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/cpufeatures: Add {REQUIRED,DISABLED} feature configs
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228082338.73859-3-xin@zytor.com>
References: <20250228082338.73859-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224055.14745.16503088533485434000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3d37d9396eb37a62ba75bf8f3bd934500cf64bf0
Gitweb:        https://git.kernel.org/tip/3d37d9396eb37a62ba75bf8f3bd934500cf64bf0
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Fri, 28 Feb 2025 00:23:35 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:15:11 +01:00

x86/cpufeatures: Add {REQUIRED,DISABLED} feature configs

Required and disabled feature masks completely rely on build configs,
i.e., once a build config is fixed, so are the feature masks.

To prepare for auto-generating the <asm/cpufeaturemasks.h> header
with required and disabled feature masks based on a build config,
add feature Kconfig items:

  - X86_REQUIRED_FEATURE_x
  - X86_DISABLED_FEATURE_x

each of which may be set to "y" if and only if its preconditions from
current build config are met.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250228082338.73859-3-xin@zytor.com
---
 arch/x86/Kconfig             |   2 +-
 arch/x86/Kconfig.cpufeatures | 201 ++++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+)
 create mode 100644 arch/x86/Kconfig.cpufeatures

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ddef352..98bd493 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3130,4 +3130,6 @@ config HAVE_ATOMIC_IOMAP
 
 source "arch/x86/kvm/Kconfig"
 
+source "arch/x86/Kconfig.cpufeatures"
+
 source "arch/x86/Kconfig.assembler"
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
new file mode 100644
index 0000000..e12d5b7
--- /dev/null
+++ b/arch/x86/Kconfig.cpufeatures
@@ -0,0 +1,201 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
+# either REQUIRED to be enabled, or DISABLED (always ignored) for this
+# particular compile-time configuration.  The tests for these features
+# are turned into compile-time constants via the generated
+# <asm/cpufeaturemasks.h>.
+#
+# The naming of these variables *must* match asm/cpufeatures.h, e.g.,
+#     X86_FEATURE_ALWAYS <==> X86_REQUIRED_FEATURE_ALWAYS
+#     X86_FEATURE_FRED   <==> X86_DISABLED_FEATURE_FRED
+#
+# And these REQUIRED and DISABLED config options are manipulated in an
+# AWK script as the following example:
+#
+#                          +----------------------+
+#                          |    X86_FRED = y ?    |
+#                          +----------------------+
+#                              /             \
+#                           Y /               \ N
+#  +-------------------------------------+   +-------------------------------+
+#  | X86_DISABLED_FEATURE_FRED undefined |   | X86_DISABLED_FEATURE_FRED = y |
+#  +-------------------------------------+   +-------------------------------+
+#                                                        |
+#                                                        |
+#     +-------------------------------------------+      |
+#     | X86_FEATURE_FRED: feature word 12, bit 17 | ---->|
+#     +-------------------------------------------+      |
+#                                                        |
+#                                                        |
+#                                     +-------------------------------+
+#                                     | set bit 17 of DISABLED_MASK12 |
+#                                     +-------------------------------+
+#
+
+config X86_REQUIRED_FEATURE_ALWAYS
+	def_bool y
+
+config X86_REQUIRED_FEATURE_NOPL
+	def_bool y
+	depends on X86_64 || X86_P6_NOP
+
+config X86_REQUIRED_FEATURE_CX8
+	def_bool y
+	depends on X86_CX8
+
+# this should be set for all -march=.. options where the compiler
+# generates cmov.
+config X86_REQUIRED_FEATURE_CMOV
+	def_bool y
+	depends on X86_CMOV
+
+# this should be set for all -march= options where the compiler
+# generates movbe.
+config X86_REQUIRED_FEATURE_MOVBE
+	def_bool y
+	depends on MATOM
+
+config X86_REQUIRED_FEATURE_CPUID
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_UP
+	def_bool y
+	depends on !SMP
+
+config X86_REQUIRED_FEATURE_FPU
+	def_bool y
+	depends on !MATH_EMULATION
+
+config X86_REQUIRED_FEATURE_PAE
+	def_bool y
+	depends on X86_64 || X86_PAE
+
+config X86_REQUIRED_FEATURE_PSE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_PGE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_MSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_FXSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM2
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_LM
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_UMIP
+	def_bool y
+	depends on !X86_UMIP
+
+config X86_DISABLED_FEATURE_VME
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_K6_MTRR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CYRIX_ARR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CENTAUR_MCR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_PCID
+	def_bool y
+	depends on !X86_64
+
+config X86_DISABLED_FEATURE_PKU
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_OSPKE
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_LA57
+	def_bool y
+	depends on !X86_5LEVEL
+
+config X86_DISABLED_FEATURE_PTI
+	def_bool y
+	depends on !MITIGATION_PAGE_TABLE_ISOLATION
+
+config X86_DISABLED_FEATURE_RETPOLINE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETPOLINE_LFENCE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETHUNK
+	def_bool y
+	depends on !MITIGATION_RETHUNK
+
+config X86_DISABLED_FEATURE_UNRET
+	def_bool y
+	depends on !MITIGATION_UNRET_ENTRY
+
+config X86_DISABLED_FEATURE_CALL_DEPTH
+	def_bool y
+	depends on !MITIGATION_CALL_DEPTH_TRACKING
+
+config X86_DISABLED_FEATURE_LAM
+	def_bool y
+	depends on !ADDRESS_MASKING
+
+config X86_DISABLED_FEATURE_ENQCMD
+	def_bool y
+	depends on !INTEL_IOMMU_SVM
+
+config X86_DISABLED_FEATURE_SGX
+	def_bool y
+	depends on !X86_SGX
+
+config X86_DISABLED_FEATURE_XENPV
+	def_bool y
+	depends on !XEN_PV
+
+config X86_DISABLED_FEATURE_TDX_GUEST
+	def_bool y
+	depends on !INTEL_TDX_GUEST
+
+config X86_DISABLED_FEATURE_USER_SHSTK
+	def_bool y
+	depends on !X86_USER_SHADOW_STACK
+
+config X86_DISABLED_FEATURE_IBT
+	def_bool y
+	depends on !X86_KERNEL_IBT
+
+config X86_DISABLED_FEATURE_FRED
+	def_bool y
+	depends on !X86_FRED
+
+config X86_DISABLED_FEATURE_SEV_SNP
+	def_bool y
+	depends on !KVM_AMD_SEV
+
+config X86_DISABLED_FEATURE_INVLPGB
+	def_bool y
+	depends on !BROADCAST_TLB_FLUSH

