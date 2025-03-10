Return-Path: <linux-tip-commits+bounces-4106-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9266A597FC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703853A49ED
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3F1C68B6;
	Mon, 10 Mar 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kzYOvGRi"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89717C91;
	Mon, 10 Mar 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617871; cv=none; b=CLwM4JlGit/v+q6xytBqxHULdmZqEaeP/NZQ6dAoff40eQmvhdzE2FGOOxS/DVFFX3TaRNa6WE9qxfbgUxsoukmFcU47zHRcy/PKuwHIGQa7ouwra9ThtbbZDOUYTUjOQP+0IuArgGBimc7WHtcknWLPmU4tv8fqQ0Ol5s6e40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617871; c=relaxed/simple;
	bh=AWGdILAJCqyYw70Fz71s/VUq9OD4bGclRpIIaKy0rbQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=r4CV5rtiXv+7XNa/sR7qJxGquO7Vk/kK5z1OElSF3x9nD8ozSFk2sMeN0Vgoe3aYDh+YQkOUBTPZWgHL/Exl+97E7DyYQ18K88OqsMIZa/TTNcAvJyWiaDBg8U/nU3bG+op4OvyN+waX5OOqpLZwt4Q/Z70EnkJGdgDOSTIPB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=kzYOvGRi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52AEhlDh1651296
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 10 Mar 2025 07:43:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52AEhlDh1651296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741617828;
	bh=0uA3V382m3l0tHHlvz8LxRrQ3w3WQneW8pBx2P3/oJg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=kzYOvGRiCDaEPMPYdEHfeipKCgighAk/B3PAIB9hpENPKr7rgteR1v5u+irHsnvIL
	 9tnH4gj/2uIbdQnzB8Xb5ebyCMc3sWELNFDXUc+w/J+BHrOTIjQJsfC8h2eh4LWBSy
	 kh3lZkEAQoWwJEBrccurPtMVCWksmUoICYaWpcIPC3jkdWpiLsEpbgzs1yh1tYAsn0
	 OgyukXcbKCpCluz9kZPjPqgF263C3i1WIikiHBsAnuDAp0H+fsuK2TIAi3ruou8ndg
	 WtWAbcHMf/8nNkoQ6dfYu6zpTVH/ACcNVGj3GfahDytC3otbahgrfT8DWpwKTmYxmB
	 njIla0YG321QA==
Date: Mon, 10 Mar 2025 07:43:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org,
        "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC: "Xin Li (Intel)" <xin@zytor.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/cpu=5D_x86/cpufeatures=3A_A?=
 =?US-ASCII?Q?dd_=7BREQUIRED=2CDISABLED=7D_feature_configs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <174159470920.14745.5729743445717865267.tip-bot2@tip-bot2>
References: <20250228082338.73859-3-xin@zytor.com> <174159470920.14745.5729743445717865267.tip-bot2@tip-bot2>
Message-ID: <A0C784F1-EF4F-4CCC-98AE-954197CD7554@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 10, 2025 1:18:29 AM PDT, "tip-bot2 for H=2E Peter Anvin (Intel)" <=
tip-bot2@linutronix=2Ede> wrote:
>The following commit has been merged into the x86/cpu branch of tip:
>
>Commit-ID:     dc6e8bfc0c9e27cbfed27c7ed50c71205a7c9551
>Gitweb:        https://git=2Ekernel=2Eorg/tip/dc6e8bfc0c9e27cbfed27c7ed50=
c71205a7c9551
>Author:        H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>AuthorDate:    Fri, 28 Feb 2025 00:23:35 -08:00
>Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>CommitterDate: Mon, 10 Mar 2025 09:02:30 +01:00
>
>x86/cpufeatures: Add {REQUIRED,DISABLED} feature configs
>
>Required and disabled feature masks completely rely on build configs,
>i=2Ee=2E, once a build config is fixed, so are the feature masks=2E
>
>To prepare for auto-generating the <asm/cpufeaturemasks=2Eh> header
>with required and disabled feature masks based on a build config,
>add feature Kconfig items:
>
>  - X86_REQUIRED_FEATURE_x
>  - X86_DISABLED_FEATURE_x
>
>each of which may be set to "y" if and only if its preconditions from
>current build config are met=2E
>
>Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>Link: https://lore=2Ekernel=2Eorg/r/20250228082338=2E73859-3-xin@zytor=2E=
com
>---
> arch/x86/Kconfig             |   2 +-
> arch/x86/Kconfig=2Ecpufeatures | 201 ++++++++++++++++++++++++++++++++++-
> 2 files changed, 203 insertions(+)
> create mode 100644 arch/x86/Kconfig=2Ecpufeatures
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 017035f=2E=2E7caf2fd 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -3128,4 +3128,6 @@ config HAVE_ATOMIC_IOMAP
>=20
> source "arch/x86/kvm/Kconfig"
>=20
>+source "arch/x86/Kconfig=2Ecpufeatures"
>+
> source "arch/x86/Kconfig=2Eassembler"
>diff --git a/arch/x86/Kconfig=2Ecpufeatures b/arch/x86/Kconfig=2Ecpufeatu=
res
>new file mode 100644
>index 0000000=2E=2Ee12d5b7
>--- /dev/null
>+++ b/arch/x86/Kconfig=2Ecpufeatures
>@@ -0,0 +1,201 @@
>+# SPDX-License-Identifier: GPL-2=2E0
>+#
>+# x86 feature bits (see arch/x86/include/asm/cpufeatures=2Eh) that are
>+# either REQUIRED to be enabled, or DISABLED (always ignored) for this
>+# particular compile-time configuration=2E  The tests for these features
>+# are turned into compile-time constants via the generated
>+# <asm/cpufeaturemasks=2Eh>=2E
>+#
>+# The naming of these variables *must* match asm/cpufeatures=2Eh, e=2Eg=
=2E,
>+#     X86_FEATURE_ALWAYS <=3D=3D> X86_REQUIRED_FEATURE_ALWAYS
>+#     X86_FEATURE_FRED   <=3D=3D> X86_DISABLED_FEATURE_FRED
>+#
>+# And these REQUIRED and DISABLED config options are manipulated in an
>+# AWK script as the following example:
>+#
>+#                          +----------------------+
>+#                          |    X86_FRED =3D y ?    |
>+#                          +----------------------+
>+#                              /             \
>+#                           Y /               \ N
>+#  +-------------------------------------+   +--------------------------=
-----+
>+#  | X86_DISABLED_FEATURE_FRED undefined |   | X86_DISABLED_FEATURE_FRED=
 =3D y |
>+#  +-------------------------------------+   +--------------------------=
-----+
>+#                                                        |
>+#                                                        |
>+#     +-------------------------------------------+      |
>+#     | X86_FEATURE_FRED: feature word 12, bit 17 | ---->|
>+#     +-------------------------------------------+      |
>+#                                                        |
>+#                                                        |
>+#                                     +-------------------------------+
>+#                                     | set bit 17 of DISABLED_MASK12 |
>+#                                     +-------------------------------+
>+#
>+
>+config X86_REQUIRED_FEATURE_ALWAYS
>+	def_bool y
>+
>+config X86_REQUIRED_FEATURE_NOPL
>+	def_bool y
>+	depends on X86_64 || X86_P6_NOP
>+
>+config X86_REQUIRED_FEATURE_CX8
>+	def_bool y
>+	depends on X86_CX8
>+
>+# this should be set for all -march=3D=2E=2E options where the compiler
>+# generates cmov=2E
>+config X86_REQUIRED_FEATURE_CMOV
>+	def_bool y
>+	depends on X86_CMOV
>+
>+# this should be set for all -march=3D options where the compiler
>+# generates movbe=2E
>+config X86_REQUIRED_FEATURE_MOVBE
>+	def_bool y
>+	depends on MATOM
>+
>+config X86_REQUIRED_FEATURE_CPUID
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_REQUIRED_FEATURE_UP
>+	def_bool y
>+	depends on !SMP
>+
>+config X86_REQUIRED_FEATURE_FPU
>+	def_bool y
>+	depends on !MATH_EMULATION
>+
>+config X86_REQUIRED_FEATURE_PAE
>+	def_bool y
>+	depends on X86_64 || X86_PAE
>+
>+config X86_REQUIRED_FEATURE_PSE
>+	def_bool y
>+	depends on X86_64 && !PARAVIRT_XXL
>+
>+config X86_REQUIRED_FEATURE_PGE
>+	def_bool y
>+	depends on X86_64 && !PARAVIRT_XXL
>+
>+config X86_REQUIRED_FEATURE_MSR
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_REQUIRED_FEATURE_FXSR
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_REQUIRED_FEATURE_XMM
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_REQUIRED_FEATURE_XMM2
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_REQUIRED_FEATURE_LM
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_DISABLED_FEATURE_UMIP
>+	def_bool y
>+	depends on !X86_UMIP
>+
>+config X86_DISABLED_FEATURE_VME
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_DISABLED_FEATURE_K6_MTRR
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_DISABLED_FEATURE_CYRIX_ARR
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_DISABLED_FEATURE_CENTAUR_MCR
>+	def_bool y
>+	depends on X86_64
>+
>+config X86_DISABLED_FEATURE_PCID
>+	def_bool y
>+	depends on !X86_64
>+
>+config X86_DISABLED_FEATURE_PKU
>+	def_bool y
>+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
>+
>+config X86_DISABLED_FEATURE_OSPKE
>+	def_bool y
>+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
>+
>+config X86_DISABLED_FEATURE_LA57
>+	def_bool y
>+	depends on !X86_5LEVEL
>+
>+config X86_DISABLED_FEATURE_PTI
>+	def_bool y
>+	depends on !MITIGATION_PAGE_TABLE_ISOLATION
>+
>+config X86_DISABLED_FEATURE_RETPOLINE
>+	def_bool y
>+	depends on !MITIGATION_RETPOLINE
>+
>+config X86_DISABLED_FEATURE_RETPOLINE_LFENCE
>+	def_bool y
>+	depends on !MITIGATION_RETPOLINE
>+
>+config X86_DISABLED_FEATURE_RETHUNK
>+	def_bool y
>+	depends on !MITIGATION_RETHUNK
>+
>+config X86_DISABLED_FEATURE_UNRET
>+	def_bool y
>+	depends on !MITIGATION_UNRET_ENTRY
>+
>+config X86_DISABLED_FEATURE_CALL_DEPTH
>+	def_bool y
>+	depends on !MITIGATION_CALL_DEPTH_TRACKING
>+
>+config X86_DISABLED_FEATURE_LAM
>+	def_bool y
>+	depends on !ADDRESS_MASKING
>+
>+config X86_DISABLED_FEATURE_ENQCMD
>+	def_bool y
>+	depends on !INTEL_IOMMU_SVM
>+
>+config X86_DISABLED_FEATURE_SGX
>+	def_bool y
>+	depends on !X86_SGX
>+
>+config X86_DISABLED_FEATURE_XENPV
>+	def_bool y
>+	depends on !XEN_PV
>+
>+config X86_DISABLED_FEATURE_TDX_GUEST
>+	def_bool y
>+	depends on !INTEL_TDX_GUEST
>+
>+config X86_DISABLED_FEATURE_USER_SHSTK
>+	def_bool y
>+	depends on !X86_USER_SHADOW_STACK
>+
>+config X86_DISABLED_FEATURE_IBT
>+	def_bool y
>+	depends on !X86_KERNEL_IBT
>+
>+config X86_DISABLED_FEATURE_FRED
>+	def_bool y
>+	depends on !X86_FRED
>+
>+config X86_DISABLED_FEATURE_SEV_SNP
>+	def_bool y
>+	depends on !KVM_AMD_SEV
>+
>+config X86_DISABLED_FEATURE_INVLPGB
>+	def_bool y
>+	depends on !BROADCAST_TLB_FLUSH

I think it is worth noting that the list here was intentionally unchanged =
from the previous definitions, but that several of these could and probably=
 should be overhauled=2E=20

For example, CPUID is actually required by any i586+ configuration=2E

