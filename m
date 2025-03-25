Return-Path: <linux-tip-commits+bounces-4476-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3924A6EC2A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3F91895483
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF584255255;
	Tue, 25 Mar 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qm3OF0On";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDUCav4+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B79253F32;
	Tue, 25 Mar 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893544; cv=none; b=YQ9V2KrvlK60cjtzMtu68/rudoxpOuS3aLn7/sWR0o9rFnAGL2aTJYL7YnXrLANneQw6oYg8nCKOmXCgEB15kUQx1imSQzjrq+Vs0LfE6BDTcukk+xiLZEL0aP9ZRHrr3zrK/ItD+AdwKGqGXX6qP7XIIP/BgM/CT9NGf1puf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893544; c=relaxed/simple;
	bh=xriHIAK2H+XTy7mr5rQRn247vUAj2q+XGOvETsd/upU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lb8xF9+PXiBqb2XSn9ybXbDmEJjw1QbgcgmPb0NDcbQuTxffPGs6Kn1tXWX6+ge8U1U+xHmPGhPvn8IVrlm/5mZ8u3RKQtn7gH/USPsUT7GJj43TyXrNWmZJKR7D7qTGFGh6TqTV1lk9VjZ4ZFEiWtSllBN+OqZPLctX+QSV1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qm3OF0On; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDUCav4+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T90kYuiVI0PBCb/UxoyxLj75w5G4y1KGa0fwYjt8LfA=;
	b=Qm3OF0Ona+qiHTeub5ZlWpRpEpxss4CUTLDwOs0LtbWE7U5F5TFZLUGclTXTmpjniKy8w+
	l21Ztx1T3lEaeyqx2SNmlG9BcpXUk9cEJSEiJo94A3+IGrYrukIpavrZxLHWMEMbcibkxL
	TsU9cNc+DRJV1tgVhBexg+Hyj/3RJAVSen7Uww0fKQpef2de1sHbff9TyS9nWVufMdQ5Nm
	byIjBTKQBrORTtzMqKIPEmt0WRaUUDRdB6g7Quw1F3tR8fmruq/NxxfDDrTz1xpx1IAKop
	J1PANyNpFapHrOAkKj6ei5e6CrqveXTmoNpqFQHru2k6/gEINuImCi4BmgyC0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T90kYuiVI0PBCb/UxoyxLj75w5G4y1KGa0fwYjt8LfA=;
	b=CDUCav4++7cXF8TeClOdiTkv8oQF3rpwWEWkuYhq6mWu1I0w399f5zQcSflUVPk0H2VR/d
	ZlL/h63bNf465GBQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.0
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-17-darwi@linutronix.de>
References: <20250324142042.29010-17-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353853.14745.11293123470738304389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e1dde2f5a4ef4a0e91a67adebb7037bbfbcb0c50
Gitweb:        https://git.kernel.org/tip/e1dde2f5a4ef4a0e91a67adebb7037bbfbcb0c50
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:47 +01:00

tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.0

Update kcpuid's CSV file to version v2.0, as generated by x86-cpuid-db.

Summary of the v2.0 changes:

* Introduce the leaves:

  - Leaf 0x00000003, Transmeta Processor serial number
  - Leaf 0x80860000, Transmeta max leaf number + CPU vendor ID
  - Leaf 0x80860001, Transmeta extended CPU information
  - Leaf 0x80860002, Transmeta Code Morphing Software (CMS) enumeration
  - Leaf 0x80860003 => 0x80860006, Transmeta CPU information string
  - Leaf 0x80860007, Transmeta "live" CPU information
  - Leaf 0xc0000000, Centaur/Zhaoxin's max leaf number
  - Leaf 0xc0000001, Centaur/Zhaoxin's extended CPU features

* Add a 0x prefix for leaves 0x0 to 0x9.  This maintains consistency with
  the rest of the CSV entries.

* Add the new bitfields:

  - Leaf 0x7: nmi_src, NMI-source reporting
  - Leaf 0x80000001: e_base_type and e_mmx (Transmeta)

* Update the section headers for leaves 0x80000000 and 0x80000005 to
  indicate that they are also valid for Transmeta.

Notes:
    Leaf 0x3, being not unique to Transmeta, is handled at the generated
    CSV file v2.3 update, later in this patch queue.

    Leaf 0x80000001 EDX:23 bit, e_mmx, is also available on AMD.  A bugfix
    is already merged at x86-cpuid-db's -tip for that, and it will be part
    of the project's upcoming v2.4 release.:

        https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/commit/65fff25daa41

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.0/CHANGELOG.rst
Link: https://lore.kernel.org/r/20250324142042.29010-17-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/cpuid.csv | 648 ++++++++++++++++++-------------
 1 file changed, 382 insertions(+), 266 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index d751eb8..d0f7159 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: CC0-1.0
-# Generator: x86-cpuid-db v1.0
+# Generator: x86-cpuid-db v2.0
 
 #
 # Auto-generated file.
@@ -12,297 +12,306 @@
 # Leaf 0H
 # Maximum standard leaf number + CPU vendor string
 
-         0,         0,  eax,    31:0,    max_std_leaf           , Highest cpuid standard leaf supported
-         0,         0,  ebx,    31:0,    cpu_vendorid_0         , CPU vendor ID string bytes 0 - 3
-         0,         0,  ecx,    31:0,    cpu_vendorid_2         , CPU vendor ID string bytes 8 - 11
-         0,         0,  edx,    31:0,    cpu_vendorid_1         , CPU vendor ID string bytes 4 - 7
+       0x0,         0,  eax,    31:0,    max_std_leaf           , Highest cpuid standard leaf supported
+       0x0,         0,  ebx,    31:0,    cpu_vendorid_0         , CPU vendor ID string bytes 0 - 3
+       0x0,         0,  ecx,    31:0,    cpu_vendorid_2         , CPU vendor ID string bytes 8 - 11
+       0x0,         0,  edx,    31:0,    cpu_vendorid_1         , CPU vendor ID string bytes 4 - 7
 
 # Leaf 1H
 # CPU FMS (Family/Model/Stepping) + standard feature flags
 
-         1,         0,  eax,     3:0,    stepping               , Stepping ID
-         1,         0,  eax,     7:4,    base_model             , Base CPU model ID
-         1,         0,  eax,    11:8,    base_family_id         , Base CPU family ID
-         1,         0,  eax,   13:12,    cpu_type               , CPU type
-         1,         0,  eax,   19:16,    ext_model              , Extended CPU model ID
-         1,         0,  eax,   27:20,    ext_family             , Extended CPU family ID
-         1,         0,  ebx,     7:0,    brand_id               , Brand index
-         1,         0,  ebx,    15:8,    clflush_size           , CLFLUSH instruction cache line size
-         1,         0,  ebx,   23:16,    n_logical_cpu          , Logical CPU (HW threads) count
-         1,         0,  ebx,   31:24,    local_apic_id          , Initial local APIC physical ID
-         1,         0,  ecx,       0,    pni                    , Streaming SIMD Extensions 3 (SSE3)
-         1,         0,  ecx,       1,    pclmulqdq              , PCLMULQDQ instruction support
-         1,         0,  ecx,       2,    dtes64                 , 64-bit DS save area
-         1,         0,  ecx,       3,    monitor                , MONITOR/MWAIT support
-         1,         0,  ecx,       4,    ds_cpl                 , CPL Qualified Debug Store
-         1,         0,  ecx,       5,    vmx                    , Virtual Machine Extensions
-         1,         0,  ecx,       6,    smx                    , Safer Mode Extensions
-         1,         0,  ecx,       7,    est                    , Enhanced Intel SpeedStep
-         1,         0,  ecx,       8,    tm2                    , Thermal Monitor 2
-         1,         0,  ecx,       9,    ssse3                  , Supplemental SSE3
-         1,         0,  ecx,      10,    cid                    , L1 Context ID
-         1,         0,  ecx,      11,    sdbg                   , Sillicon Debug
-         1,         0,  ecx,      12,    fma                    , FMA extensions using YMM state
-         1,         0,  ecx,      13,    cx16                   , CMPXCHG16B instruction support
-         1,         0,  ecx,      14,    xtpr                   , xTPR Update Control
-         1,         0,  ecx,      15,    pdcm                   , Perfmon and Debug Capability
-         1,         0,  ecx,      17,    pcid                   , Process-context identifiers
-         1,         0,  ecx,      18,    dca                    , Direct Cache Access
-         1,         0,  ecx,      19,    sse4_1                 , SSE4.1
-         1,         0,  ecx,      20,    sse4_2                 , SSE4.2
-         1,         0,  ecx,      21,    x2apic                 , X2APIC support
-         1,         0,  ecx,      22,    movbe                  , MOVBE instruction support
-         1,         0,  ecx,      23,    popcnt                 , POPCNT instruction support
-         1,         0,  ecx,      24,    tsc_deadline_timer     , APIC timer one-shot operation
-         1,         0,  ecx,      25,    aes                    , AES instructions
-         1,         0,  ecx,      26,    xsave                  , XSAVE (and related instructions) support
-         1,         0,  ecx,      27,    osxsave                , XSAVE (and related instructions) are enabled by OS
-         1,         0,  ecx,      28,    avx                    , AVX instructions support
-         1,         0,  ecx,      29,    f16c                   , Half-precision floating-point conversion support
-         1,         0,  ecx,      30,    rdrand                 , RDRAND instruction support
-         1,         0,  ecx,      31,    guest_status           , System is running as guest; (para-)virtualized system
-         1,         0,  edx,       0,    fpu                    , Floating-Point Unit on-chip (x87)
-         1,         0,  edx,       1,    vme                    , Virtual-8086 Mode Extensions
-         1,         0,  edx,       2,    de                     , Debugging Extensions
-         1,         0,  edx,       3,    pse                    , Page Size Extension
-         1,         0,  edx,       4,    tsc                    , Time Stamp Counter
-         1,         0,  edx,       5,    msr                    , Model-Specific Registers (RDMSR and WRMSR support)
-         1,         0,  edx,       6,    pae                    , Physical Address Extensions
-         1,         0,  edx,       7,    mce                    , Machine Check Exception
-         1,         0,  edx,       8,    cx8                    , CMPXCHG8B instruction
-         1,         0,  edx,       9,    apic                   , APIC on-chip
-         1,         0,  edx,      11,    sep                    , SYSENTER, SYSEXIT, and associated MSRs
-         1,         0,  edx,      12,    mtrr                   , Memory Type Range Registers
-         1,         0,  edx,      13,    pge                    , Page Global Extensions
-         1,         0,  edx,      14,    mca                    , Machine Check Architecture
-         1,         0,  edx,      15,    cmov                   , Conditional Move Instruction
-         1,         0,  edx,      16,    pat                    , Page Attribute Table
-         1,         0,  edx,      17,    pse36                  , Page Size Extension (36-bit)
-         1,         0,  edx,      18,    pn                     , Processor Serial Number
-         1,         0,  edx,      19,    clflush                , CLFLUSH instruction
-         1,         0,  edx,      21,    dts                    , Debug Store
-         1,         0,  edx,      22,    acpi                   , Thermal monitor and clock control
-         1,         0,  edx,      23,    mmx                    , MMX instructions
-         1,         0,  edx,      24,    fxsr                   , FXSAVE and FXRSTOR instructions
-         1,         0,  edx,      25,    sse                    , SSE instructions
-         1,         0,  edx,      26,    sse2                   , SSE2 instructions
-         1,         0,  edx,      27,    ss                     , Self Snoop
-         1,         0,  edx,      28,    ht                     , Hyper-threading
-         1,         0,  edx,      29,    tm                     , Thermal Monitor
-         1,         0,  edx,      30,    ia64                   , Legacy IA-64 (Itanium) support bit, now resreved
-         1,         0,  edx,      31,    pbe                    , Pending Break Enable
+       0x1,         0,  eax,     3:0,    stepping               , Stepping ID
+       0x1,         0,  eax,     7:4,    base_model             , Base CPU model ID
+       0x1,         0,  eax,    11:8,    base_family_id         , Base CPU family ID
+       0x1,         0,  eax,   13:12,    cpu_type               , CPU type
+       0x1,         0,  eax,   19:16,    ext_model              , Extended CPU model ID
+       0x1,         0,  eax,   27:20,    ext_family             , Extended CPU family ID
+       0x1,         0,  ebx,     7:0,    brand_id               , Brand index
+       0x1,         0,  ebx,    15:8,    clflush_size           , CLFLUSH instruction cache line size
+       0x1,         0,  ebx,   23:16,    n_logical_cpu          , Logical CPU (HW threads) count
+       0x1,         0,  ebx,   31:24,    local_apic_id          , Initial local APIC physical ID
+       0x1,         0,  ecx,       0,    pni                    , Streaming SIMD Extensions 3 (SSE3)
+       0x1,         0,  ecx,       1,    pclmulqdq              , PCLMULQDQ instruction support
+       0x1,         0,  ecx,       2,    dtes64                 , 64-bit DS save area
+       0x1,         0,  ecx,       3,    monitor                , MONITOR/MWAIT support
+       0x1,         0,  ecx,       4,    ds_cpl                 , CPL Qualified Debug Store
+       0x1,         0,  ecx,       5,    vmx                    , Virtual Machine Extensions
+       0x1,         0,  ecx,       6,    smx                    , Safer Mode Extensions
+       0x1,         0,  ecx,       7,    est                    , Enhanced Intel SpeedStep
+       0x1,         0,  ecx,       8,    tm2                    , Thermal Monitor 2
+       0x1,         0,  ecx,       9,    ssse3                  , Supplemental SSE3
+       0x1,         0,  ecx,      10,    cid                    , L1 Context ID
+       0x1,         0,  ecx,      11,    sdbg                   , Sillicon Debug
+       0x1,         0,  ecx,      12,    fma                    , FMA extensions using YMM state
+       0x1,         0,  ecx,      13,    cx16                   , CMPXCHG16B instruction support
+       0x1,         0,  ecx,      14,    xtpr                   , xTPR Update Control
+       0x1,         0,  ecx,      15,    pdcm                   , Perfmon and Debug Capability
+       0x1,         0,  ecx,      17,    pcid                   , Process-context identifiers
+       0x1,         0,  ecx,      18,    dca                    , Direct Cache Access
+       0x1,         0,  ecx,      19,    sse4_1                 , SSE4.1
+       0x1,         0,  ecx,      20,    sse4_2                 , SSE4.2
+       0x1,         0,  ecx,      21,    x2apic                 , X2APIC support
+       0x1,         0,  ecx,      22,    movbe                  , MOVBE instruction support
+       0x1,         0,  ecx,      23,    popcnt                 , POPCNT instruction support
+       0x1,         0,  ecx,      24,    tsc_deadline_timer     , APIC timer one-shot operation
+       0x1,         0,  ecx,      25,    aes                    , AES instructions
+       0x1,         0,  ecx,      26,    xsave                  , XSAVE (and related instructions) support
+       0x1,         0,  ecx,      27,    osxsave                , XSAVE (and related instructions) are enabled by OS
+       0x1,         0,  ecx,      28,    avx                    , AVX instructions support
+       0x1,         0,  ecx,      29,    f16c                   , Half-precision floating-point conversion support
+       0x1,         0,  ecx,      30,    rdrand                 , RDRAND instruction support
+       0x1,         0,  ecx,      31,    guest_status           , System is running as guest; (para-)virtualized system
+       0x1,         0,  edx,       0,    fpu                    , Floating-Point Unit on-chip (x87)
+       0x1,         0,  edx,       1,    vme                    , Virtual-8086 Mode Extensions
+       0x1,         0,  edx,       2,    de                     , Debugging Extensions
+       0x1,         0,  edx,       3,    pse                    , Page Size Extension
+       0x1,         0,  edx,       4,    tsc                    , Time Stamp Counter
+       0x1,         0,  edx,       5,    msr                    , Model-Specific Registers (RDMSR and WRMSR support)
+       0x1,         0,  edx,       6,    pae                    , Physical Address Extensions
+       0x1,         0,  edx,       7,    mce                    , Machine Check Exception
+       0x1,         0,  edx,       8,    cx8                    , CMPXCHG8B instruction
+       0x1,         0,  edx,       9,    apic                   , APIC on-chip
+       0x1,         0,  edx,      11,    sep                    , SYSENTER, SYSEXIT, and associated MSRs
+       0x1,         0,  edx,      12,    mtrr                   , Memory Type Range Registers
+       0x1,         0,  edx,      13,    pge                    , Page Global Extensions
+       0x1,         0,  edx,      14,    mca                    , Machine Check Architecture
+       0x1,         0,  edx,      15,    cmov                   , Conditional Move Instruction
+       0x1,         0,  edx,      16,    pat                    , Page Attribute Table
+       0x1,         0,  edx,      17,    pse36                  , Page Size Extension (36-bit)
+       0x1,         0,  edx,      18,    pn                     , Processor Serial Number
+       0x1,         0,  edx,      19,    clflush                , CLFLUSH instruction
+       0x1,         0,  edx,      21,    dts                    , Debug Store
+       0x1,         0,  edx,      22,    acpi                   , Thermal monitor and clock control
+       0x1,         0,  edx,      23,    mmx                    , MMX instructions
+       0x1,         0,  edx,      24,    fxsr                   , FXSAVE and FXRSTOR instructions
+       0x1,         0,  edx,      25,    sse                    , SSE instructions
+       0x1,         0,  edx,      26,    sse2                   , SSE2 instructions
+       0x1,         0,  edx,      27,    ss                     , Self Snoop
+       0x1,         0,  edx,      28,    ht                     , Hyper-threading
+       0x1,         0,  edx,      29,    tm                     , Thermal Monitor
+       0x1,         0,  edx,      30,    ia64                   , Legacy IA-64 (Itanium) support bit, now resreved
+       0x1,         0,  edx,      31,    pbe                    , Pending Break Enable
 
 # Leaf 2H
 # Intel cache and TLB information one-byte descriptors
 
-         2,         0,  eax,     7:0,    iteration_count        , Number of times this CPUD leaf must be queried
-         2,         0,  eax,    15:8,    desc1                  , Descriptor #1
-         2,         0,  eax,   23:16,    desc2                  , Descriptor #2
-         2,         0,  eax,   30:24,    desc3                  , Descriptor #3
-         2,         0,  eax,      31,    eax_invalid            , Descriptors 1-3 are invalid if set
-         2,         0,  ebx,     7:0,    desc4                  , Descriptor #4
-         2,         0,  ebx,    15:8,    desc5                  , Descriptor #5
-         2,         0,  ebx,   23:16,    desc6                  , Descriptor #6
-         2,         0,  ebx,   30:24,    desc7                  , Descriptor #7
-         2,         0,  ebx,      31,    ebx_invalid            , Descriptors 4-7 are invalid if set
-         2,         0,  ecx,     7:0,    desc8                  , Descriptor #8
-         2,         0,  ecx,    15:8,    desc9                  , Descriptor #9
-         2,         0,  ecx,   23:16,    desc10                 , Descriptor #10
-         2,         0,  ecx,   30:24,    desc11                 , Descriptor #11
-         2,         0,  ecx,      31,    ecx_invalid            , Descriptors 8-11 are invalid if set
-         2,         0,  edx,     7:0,    desc12                 , Descriptor #12
-         2,         0,  edx,    15:8,    desc13                 , Descriptor #13
-         2,         0,  edx,   23:16,    desc14                 , Descriptor #14
-         2,         0,  edx,   30:24,    desc15                 , Descriptor #15
-         2,         0,  edx,      31,    edx_invalid            , Descriptors 12-15 are invalid if set
+       0x2,         0,  eax,     7:0,    iteration_count        , Number of times this CPUD leaf must be queried
+       0x2,         0,  eax,    15:8,    desc1                  , Descriptor #1
+       0x2,         0,  eax,   23:16,    desc2                  , Descriptor #2
+       0x2,         0,  eax,   30:24,    desc3                  , Descriptor #3
+       0x2,         0,  eax,      31,    eax_invalid            , Descriptors 1-3 are invalid if set
+       0x2,         0,  ebx,     7:0,    desc4                  , Descriptor #4
+       0x2,         0,  ebx,    15:8,    desc5                  , Descriptor #5
+       0x2,         0,  ebx,   23:16,    desc6                  , Descriptor #6
+       0x2,         0,  ebx,   30:24,    desc7                  , Descriptor #7
+       0x2,         0,  ebx,      31,    ebx_invalid            , Descriptors 4-7 are invalid if set
+       0x2,         0,  ecx,     7:0,    desc8                  , Descriptor #8
+       0x2,         0,  ecx,    15:8,    desc9                  , Descriptor #9
+       0x2,         0,  ecx,   23:16,    desc10                 , Descriptor #10
+       0x2,         0,  ecx,   30:24,    desc11                 , Descriptor #11
+       0x2,         0,  ecx,      31,    ecx_invalid            , Descriptors 8-11 are invalid if set
+       0x2,         0,  edx,     7:0,    desc12                 , Descriptor #12
+       0x2,         0,  edx,    15:8,    desc13                 , Descriptor #13
+       0x2,         0,  edx,   23:16,    desc14                 , Descriptor #14
+       0x2,         0,  edx,   30:24,    desc15                 , Descriptor #15
+       0x2,         0,  edx,      31,    edx_invalid            , Descriptors 12-15 are invalid if set
+
+# Leaf 3H
+# Transmeta Processor Serial Number (PSN)
+
+       0x3,         0,  eax,    31:0,    cpu_psn_0              , Processor Serial Number bytes 0 - 3
+       0x3,         0,  ebx,    31:0,    cpu_psn_1              , Processor Serial Number bytes 4 - 7
+       0x3,         0,  ecx,    31:0,    cpu_psn_2              , Processor Serial Number bytes 8 - 11
+       0x3,         0,  edx,    31:0,    cpu_psn_3              , Processor Serial Number bytes 12 - 15
 
 # Leaf 4H
 # Intel deterministic cache parameters
 
-         4,      31:0,  eax,     4:0,    cache_type             , Cache type field
-         4,      31:0,  eax,     7:5,    cache_level            , Cache level (1-based)
-         4,      31:0,  eax,       8,    cache_self_init        , Self-initialializing cache level
-         4,      31:0,  eax,       9,    fully_associative      , Fully-associative cache
-         4,      31:0,  eax,   25:14,    num_threads_sharing    , Number logical CPUs sharing this cache
-         4,      31:0,  eax,   31:26,    num_cores_on_die       , Number of cores in the physical package
-         4,      31:0,  ebx,    11:0,    cache_linesize         , System coherency line size (0-based)
-         4,      31:0,  ebx,   21:12,    cache_npartitions      , Physical line partitions (0-based)
-         4,      31:0,  ebx,   31:22,    cache_nways            , Ways of associativity (0-based)
-         4,      31:0,  ecx,    30:0,    cache_nsets            , Cache number of sets (0-based)
-         4,      31:0,  edx,       0,    wbinvd_rll_no_guarantee, WBINVD/INVD not guaranteed for Remote Lower-Level caches
-         4,      31:0,  edx,       1,    ll_inclusive           , Cache is inclusive of Lower-Level caches
-         4,      31:0,  edx,       2,    complex_indexing       , Not a direct-mapped cache (complex function)
+       0x4,      31:0,  eax,     4:0,    cache_type             , Cache type field
+       0x4,      31:0,  eax,     7:5,    cache_level            , Cache level (1-based)
+       0x4,      31:0,  eax,       8,    cache_self_init        , Self-initialializing cache level
+       0x4,      31:0,  eax,       9,    fully_associative      , Fully-associative cache
+       0x4,      31:0,  eax,   25:14,    num_threads_sharing    , Number logical CPUs sharing this cache
+       0x4,      31:0,  eax,   31:26,    num_cores_on_die       , Number of cores in the physical package
+       0x4,      31:0,  ebx,    11:0,    cache_linesize         , System coherency line size (0-based)
+       0x4,      31:0,  ebx,   21:12,    cache_npartitions      , Physical line partitions (0-based)
+       0x4,      31:0,  ebx,   31:22,    cache_nways            , Ways of associativity (0-based)
+       0x4,      31:0,  ecx,    30:0,    cache_nsets            , Cache number of sets (0-based)
+       0x4,      31:0,  edx,       0,    wbinvd_rll_no_guarantee, WBINVD/INVD not guaranteed for Remote Lower-Level caches
+       0x4,      31:0,  edx,       1,    ll_inclusive           , Cache is inclusive of Lower-Level caches
+       0x4,      31:0,  edx,       2,    complex_indexing       , Not a direct-mapped cache (complex function)
 
 # Leaf 5H
 # MONITOR/MWAIT instructions enumeration
 
-         5,         0,  eax,    15:0,    min_mon_size           , Smallest monitor-line size, in bytes
-         5,         0,  ebx,    15:0,    max_mon_size           , Largest monitor-line size, in bytes
-         5,         0,  ecx,       0,    mwait_ext              , Enumeration of MONITOR/MWAIT extensions is supported
-         5,         0,  ecx,       1,    mwait_irq_break        , Interrupts as a break-event for MWAIT is supported
-         5,         0,  edx,     3:0,    n_c0_substates         , Number of C0 sub C-states supported using MWAIT
-         5,         0,  edx,     7:4,    n_c1_substates         , Number of C1 sub C-states supported using MWAIT
-         5,         0,  edx,    11:8,    n_c2_substates         , Number of C2 sub C-states supported using MWAIT
-         5,         0,  edx,   15:12,    n_c3_substates         , Number of C3 sub C-states supported using MWAIT
-         5,         0,  edx,   19:16,    n_c4_substates         , Number of C4 sub C-states supported using MWAIT
-         5,         0,  edx,   23:20,    n_c5_substates         , Number of C5 sub C-states supported using MWAIT
-         5,         0,  edx,   27:24,    n_c6_substates         , Number of C6 sub C-states supported using MWAIT
-         5,         0,  edx,   31:28,    n_c7_substates         , Number of C7 sub C-states supported using MWAIT
+       0x5,         0,  eax,    15:0,    min_mon_size           , Smallest monitor-line size, in bytes
+       0x5,         0,  ebx,    15:0,    max_mon_size           , Largest monitor-line size, in bytes
+       0x5,         0,  ecx,       0,    mwait_ext              , Enumeration of MONITOR/MWAIT extensions is supported
+       0x5,         0,  ecx,       1,    mwait_irq_break        , Interrupts as a break-event for MWAIT is supported
+       0x5,         0,  edx,     3:0,    n_c0_substates         , Number of C0 sub C-states supported using MWAIT
+       0x5,         0,  edx,     7:4,    n_c1_substates         , Number of C1 sub C-states supported using MWAIT
+       0x5,         0,  edx,    11:8,    n_c2_substates         , Number of C2 sub C-states supported using MWAIT
+       0x5,         0,  edx,   15:12,    n_c3_substates         , Number of C3 sub C-states supported using MWAIT
+       0x5,         0,  edx,   19:16,    n_c4_substates         , Number of C4 sub C-states supported using MWAIT
+       0x5,         0,  edx,   23:20,    n_c5_substates         , Number of C5 sub C-states supported using MWAIT
+       0x5,         0,  edx,   27:24,    n_c6_substates         , Number of C6 sub C-states supported using MWAIT
+       0x5,         0,  edx,   31:28,    n_c7_substates         , Number of C7 sub C-states supported using MWAIT
 
 # Leaf 6H
 # Thermal and Power Management enumeration
 
-         6,         0,  eax,       0,    dtherm                 , Digital temprature sensor
-         6,         0,  eax,       1,    turbo_boost            , Intel Turbo Boost
-         6,         0,  eax,       2,    arat                   , Always-Running APIC Timer (not affected by p-state)
-         6,         0,  eax,       4,    pln                    , Power Limit Notification (PLN) event
-         6,         0,  eax,       5,    ecmd                   , Clock modulation duty cycle extension
-         6,         0,  eax,       6,    pts                    , Package thermal management
-         6,         0,  eax,       7,    hwp                    , HWP (Hardware P-states) base registers are supported
-         6,         0,  eax,       8,    hwp_notify             , HWP notification (IA32_HWP_INTERRUPT MSR)
-         6,         0,  eax,       9,    hwp_act_window         , HWP activity window (IA32_HWP_REQUEST[bits 41:32]) supported
-         6,         0,  eax,      10,    hwp_epp                , HWP Energy Performance Preference
-         6,         0,  eax,      11,    hwp_pkg_req            , HWP Package Level Request
-         6,         0,  eax,      13,    hdc_base_regs          , HDC base registers are supported
-         6,         0,  eax,      14,    turbo_boost_3_0        , Intel Turbo Boost Max 3.0
-         6,         0,  eax,      15,    hwp_capabilities       , HWP Highest Performance change
-         6,         0,  eax,      16,    hwp_peci_override      , HWP PECI override
-         6,         0,  eax,      17,    hwp_flexible           , Flexible HWP
-         6,         0,  eax,      18,    hwp_fast               , IA32_HWP_REQUEST MSR fast access mode
-         6,         0,  eax,      19,    hfi                    , HW_FEEDBACK MSRs supported
-         6,         0,  eax,      20,    hwp_ignore_idle        , Ignoring idle logical CPU HWP req is supported
-         6,         0,  eax,      23,    thread_director        , Intel thread director support
-         6,         0,  eax,      24,    therm_interrupt_bit25  , IA32_THERM_INTERRUPT MSR bit 25 is supported
-         6,         0,  ebx,     3:0,    n_therm_thresholds     , Digital thermometer thresholds
-         6,         0,  ecx,       0,    aperfmperf             , MPERF/APERF MSRs (effective frequency interface)
-         6,         0,  ecx,       3,    epb                    , IA32_ENERGY_PERF_BIAS MSR support
-         6,         0,  ecx,    15:8,    thrd_director_nclasses , Number of classes, Intel thread director
-         6,         0,  edx,       0,    perfcap_reporting      , Performance capability reporting
-         6,         0,  edx,       1,    encap_reporting        , Energy efficiency capability reporting
-         6,         0,  edx,    11:8,    feedback_sz            , HW feedback interface struct size, in 4K pages
-         6,         0,  edx,   31:16,    this_lcpu_hwfdbk_idx   , This logical CPU index @ HW feedback struct, 0-based
+       0x6,         0,  eax,       0,    dtherm                 , Digital temprature sensor
+       0x6,         0,  eax,       1,    turbo_boost            , Intel Turbo Boost
+       0x6,         0,  eax,       2,    arat                   , Always-Running APIC Timer (not affected by p-state)
+       0x6,         0,  eax,       4,    pln                    , Power Limit Notification (PLN) event
+       0x6,         0,  eax,       5,    ecmd                   , Clock modulation duty cycle extension
+       0x6,         0,  eax,       6,    pts                    , Package thermal management
+       0x6,         0,  eax,       7,    hwp                    , HWP (Hardware P-states) base registers are supported
+       0x6,         0,  eax,       8,    hwp_notify             , HWP notification (IA32_HWP_INTERRUPT MSR)
+       0x6,         0,  eax,       9,    hwp_act_window         , HWP activity window (IA32_HWP_REQUEST[bits 41:32]) supported
+       0x6,         0,  eax,      10,    hwp_epp                , HWP Energy Performance Preference
+       0x6,         0,  eax,      11,    hwp_pkg_req            , HWP Package Level Request
+       0x6,         0,  eax,      13,    hdc_base_regs          , HDC base registers are supported
+       0x6,         0,  eax,      14,    turbo_boost_3_0        , Intel Turbo Boost Max 3.0
+       0x6,         0,  eax,      15,    hwp_capabilities       , HWP Highest Performance change
+       0x6,         0,  eax,      16,    hwp_peci_override      , HWP PECI override
+       0x6,         0,  eax,      17,    hwp_flexible           , Flexible HWP
+       0x6,         0,  eax,      18,    hwp_fast               , IA32_HWP_REQUEST MSR fast access mode
+       0x6,         0,  eax,      19,    hfi                    , HW_FEEDBACK MSRs supported
+       0x6,         0,  eax,      20,    hwp_ignore_idle        , Ignoring idle logical CPU HWP req is supported
+       0x6,         0,  eax,      23,    thread_director        , Intel thread director support
+       0x6,         0,  eax,      24,    therm_interrupt_bit25  , IA32_THERM_INTERRUPT MSR bit 25 is supported
+       0x6,         0,  ebx,     3:0,    n_therm_thresholds     , Digital thermometer thresholds
+       0x6,         0,  ecx,       0,    aperfmperf             , MPERF/APERF MSRs (effective frequency interface)
+       0x6,         0,  ecx,       3,    epb                    , IA32_ENERGY_PERF_BIAS MSR support
+       0x6,         0,  ecx,    15:8,    thrd_director_nclasses , Number of classes, Intel thread director
+       0x6,         0,  edx,       0,    perfcap_reporting      , Performance capability reporting
+       0x6,         0,  edx,       1,    encap_reporting        , Energy efficiency capability reporting
+       0x6,         0,  edx,    11:8,    feedback_sz            , HW feedback interface struct size, in 4K pages
+       0x6,         0,  edx,   31:16,    this_lcpu_hwfdbk_idx   , This logical CPU index @ HW feedback struct, 0-based
 
 # Leaf 7H
 # Extended CPU features enumeration
 
-         7,         0,  eax,    31:0,    leaf7_n_subleaves      , Number of cpuid 0x7 subleaves
-         7,         0,  ebx,       0,    fsgsbase               , FSBASE/GSBASE read/write support
-         7,         0,  ebx,       1,    tsc_adjust             , IA32_TSC_ADJUST MSR supported
-         7,         0,  ebx,       2,    sgx                    , Intel SGX (Software Guard Extensions)
-         7,         0,  ebx,       3,    bmi1                   , Bit manipulation extensions group 1
-         7,         0,  ebx,       4,    hle                    , Hardware Lock Elision
-         7,         0,  ebx,       5,    avx2                   , AVX2 instruction set
-         7,         0,  ebx,       6,    fdp_excptn_only        , FPU Data Pointer updated only on x87 exceptions
-         7,         0,  ebx,       7,    smep                   , Supervisor Mode Execution Protection
-         7,         0,  ebx,       8,    bmi2                   , Bit manipulation extensions group 2
-         7,         0,  ebx,       9,    erms                   , Enhanced REP MOVSB/STOSB
-         7,         0,  ebx,      10,    invpcid                , INVPCID instruction (Invalidate Processor Context ID)
-         7,         0,  ebx,      11,    rtm                    , Intel restricted transactional memory
-         7,         0,  ebx,      12,    cqm                    , Intel RDT-CMT / AMD Platform-QoS cache monitoring
-         7,         0,  ebx,      13,    zero_fcs_fds           , Deprecated FPU CS/DS (stored as zero)
-         7,         0,  ebx,      14,    mpx                    , Intel memory protection extensions
-         7,         0,  ebx,      15,    rdt_a                  , Intel RDT / AMD Platform-QoS Enforcemeent
-         7,         0,  ebx,      16,    avx512f                , AVX-512 foundation instructions
-         7,         0,  ebx,      17,    avx512dq               , AVX-512 double/quadword instructions
-         7,         0,  ebx,      18,    rdseed                 , RDSEED instruction
-         7,         0,  ebx,      19,    adx                    , ADCX/ADOX instructions
-         7,         0,  ebx,      20,    smap                   , Supervisor mode access prevention
-         7,         0,  ebx,      21,    avx512ifma             , AVX-512 integer fused multiply add
-         7,         0,  ebx,      23,    clflushopt             , CLFLUSHOPT instruction
-         7,         0,  ebx,      24,    clwb                   , CLWB instruction
-         7,         0,  ebx,      25,    intel_pt               , Intel processor trace
-         7,         0,  ebx,      26,    avx512pf               , AVX-512 prefetch instructions
-         7,         0,  ebx,      27,    avx512er               , AVX-512 exponent/reciprocal instrs
-         7,         0,  ebx,      28,    avx512cd               , AVX-512 conflict detection instrs
-         7,         0,  ebx,      29,    sha_ni                 , SHA/SHA256 instructions
-         7,         0,  ebx,      30,    avx512bw               , AVX-512 BW (byte/word granular) instructions
-         7,         0,  ebx,      31,    avx512vl               , AVX-512 VL (128/256 vector length) extensions
-         7,         0,  ecx,       0,    prefetchwt1            , PREFETCHWT1 (Intel Xeon Phi only)
-         7,         0,  ecx,       1,    avx512vbmi             , AVX-512 Vector byte manipulation instrs
-         7,         0,  ecx,       2,    umip                   , User mode instruction protection
-         7,         0,  ecx,       3,    pku                    , Protection keys for user-space
-         7,         0,  ecx,       4,    ospke                  , OS protection keys enable
-         7,         0,  ecx,       5,    waitpkg                , WAITPKG instructions
-         7,         0,  ecx,       6,    avx512_vbmi2           , AVX-512 vector byte manipulation instrs group 2
-         7,         0,  ecx,       7,    cet_ss                 , CET shadow stack features
-         7,         0,  ecx,       8,    gfni                   , Galois field new instructions
-         7,         0,  ecx,       9,    vaes                   , Vector AES instrs
-         7,         0,  ecx,      10,    vpclmulqdq             , VPCLMULQDQ 256-bit instruction support
-         7,         0,  ecx,      11,    avx512_vnni            , Vector neural network instructions
-         7,         0,  ecx,      12,    avx512_bitalg          , AVX-512 bit count/shiffle
-         7,         0,  ecx,      13,    tme                    , Intel total memory encryption
-         7,         0,  ecx,      14,    avx512_vpopcntdq       , AVX-512: POPCNT for vectors of DW/QW
-         7,         0,  ecx,      16,    la57                   , 57-bit linear addreses (five-level paging)
-         7,         0,  ecx,   21:17,    mawau_val_lm           , BNDLDX/BNDSTX MAWAU value in 64-bit mode
-         7,         0,  ecx,      22,    rdpid                  , RDPID instruction
-         7,         0,  ecx,      23,    key_locker             , Intel key locker support
-         7,         0,  ecx,      24,    bus_lock_detect        , OS bus-lock detection
-         7,         0,  ecx,      25,    cldemote               , CLDEMOTE instruction
-         7,         0,  ecx,      27,    movdiri                , MOVDIRI instruction
-         7,         0,  ecx,      28,    movdir64b              , MOVDIR64B instruction
-         7,         0,  ecx,      29,    enqcmd                 , Enqueue stores supported (ENQCMD{,S})
-         7,         0,  ecx,      30,    sgx_lc                 , Intel SGX launch configuration
-         7,         0,  ecx,      31,    pks                    , Protection keys for supervisor-mode pages
-         7,         0,  edx,       1,    sgx_keys               , Intel SGX attestation services
-         7,         0,  edx,       2,    avx512_4vnniw          , AVX-512 neural network instructions
-         7,         0,  edx,       3,    avx512_4fmaps          , AVX-512 multiply accumulation single precision
-         7,         0,  edx,       4,    fsrm                   , Fast short REP MOV
-         7,         0,  edx,       5,    uintr                  , CPU supports user interrupts
-         7,         0,  edx,       8,    avx512_vp2intersect    , VP2INTERSECT{D,Q} instructions
-         7,         0,  edx,       9,    srdbs_ctrl             , SRBDS mitigation MSR available
-         7,         0,  edx,      10,    md_clear               , VERW MD_CLEAR microcode support
-         7,         0,  edx,      11,    rtm_always_abort       , XBEGIN (RTM transaction) always aborts
-         7,         0,  edx,      13,    tsx_force_abort        , MSR TSX_FORCE_ABORT, RTM_ABORT bit, supported
-         7,         0,  edx,      14,    serialize              , SERIALIZE instruction
-         7,         0,  edx,      15,    hybrid_cpu             , The CPU is identified as a 'hybrid part'
-         7,         0,  edx,      16,    tsxldtrk               , TSX suspend/resume load address tracking
-         7,         0,  edx,      18,    pconfig                , PCONFIG instruction
-         7,         0,  edx,      19,    arch_lbr               , Intel architectural LBRs
-         7,         0,  edx,      20,    ibt                    , CET indirect branch tracking
-         7,         0,  edx,      22,    amx_bf16               , AMX-BF16: tile bfloat16 support
-         7,         0,  edx,      23,    avx512_fp16            , AVX-512 FP16 instructions
-         7,         0,  edx,      24,    amx_tile               , AMX-TILE: tile architecture support
-         7,         0,  edx,      25,    amx_int8               , AMX-INT8: tile 8-bit integer support
-         7,         0,  edx,      26,    spec_ctrl              , Speculation Control (IBRS/IBPB: indirect branch restrictions)
-         7,         0,  edx,      27,    intel_stibp            , Single thread indirect branch predictors
-         7,         0,  edx,      28,    flush_l1d              , FLUSH L1D cache: IA32_FLUSH_CMD MSR
-         7,         0,  edx,      29,    arch_capabilities      , Intel IA32_ARCH_CAPABILITIES MSR
-         7,         0,  edx,      30,    core_capabilities      , IA32_CORE_CAPABILITIES MSR
-         7,         0,  edx,      31,    spec_ctrl_ssbd         , Speculative store bypass disable
-         7,         1,  eax,       4,    avx_vnni               , AVX-VNNI instructions
-         7,         1,  eax,       5,    avx512_bf16            , AVX-512 bFloat16 instructions
-         7,         1,  eax,       6,    lass                   , Linear address space separation
-         7,         1,  eax,       7,    cmpccxadd              , CMPccXADD instructions
-         7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmonExt: CPUID leaf 0x23 is supported
-         7,         1,  eax,      10,    fzrm                   , Fast zero-length REP MOVSB
-         7,         1,  eax,      11,    fsrs                   , Fast short REP STOSB
-         7,         1,  eax,      12,    fsrc                   , Fast Short REP CMPSB/SCASB
-         7,         1,  eax,      17,    fred                   , FRED: Flexible return and event delivery transitions
-         7,         1,  eax,      18,    lkgs                   , LKGS: Load 'kernel' (userspace) GS
-         7,         1,  eax,      19,    wrmsrns                , WRMSRNS instr (WRMSR-non-serializing)
-         7,         1,  eax,      21,    amx_fp16               , AMX-FP16: FP16 tile operations
-         7,         1,  eax,      22,    hreset                 , History reset support
-         7,         1,  eax,      23,    avx_ifma               , Integer fused multiply add
-         7,         1,  eax,      26,    lam                    , Linear address masking
-         7,         1,  eax,      27,    rd_wr_msrlist          , RDMSRLIST/WRMSRLIST instructions
-         7,         1,  ebx,       0,    intel_ppin             , Protected processor inventory number (PPIN{,_CTL} MSRs)
-         7,         1,  edx,       4,    avx_vnni_int8          , AVX-VNNI-INT8 instructions
-         7,         1,  edx,       5,    avx_ne_convert         , AVX-NE-CONVERT instructions
-         7,         1,  edx,       8,    amx_complex            , AMX-COMPLEX instructions (starting from Granite Rapids)
-         7,         1,  edx,      14,    prefetchit_0_1         , PREFETCHIT0/1 instructions
-         7,         1,  edx,      18,    cet_sss                , CET supervisor shadow stacks safe to use
-         7,         2,  edx,       0,    intel_psfd             , Intel predictive store forward disable
-         7,         2,  edx,       1,    ipred_ctrl             , MSR bits IA32_SPEC_CTRL.IPRED_DIS_{U,S}
-         7,         2,  edx,       2,    rrsba_ctrl             , MSR bits IA32_SPEC_CTRL.RRSBA_DIS_{U,S}
-         7,         2,  edx,       3,    ddp_ctrl               , MSR bit  IA32_SPEC_CTRL.DDPD_U
-         7,         2,  edx,       4,    bhi_ctrl               , MSR bit  IA32_SPEC_CTRL.BHI_DIS_S
-         7,         2,  edx,       5,    mcdt_no                , MCDT mitigation not needed
-         7,         2,  edx,       6,    uclock_disable         , UC-lock disable is supported
+       0x7,         0,  eax,    31:0,    leaf7_n_subleaves      , Number of cpuid 0x7 subleaves
+       0x7,         0,  ebx,       0,    fsgsbase               , FSBASE/GSBASE read/write support
+       0x7,         0,  ebx,       1,    tsc_adjust             , IA32_TSC_ADJUST MSR supported
+       0x7,         0,  ebx,       2,    sgx                    , Intel SGX (Software Guard Extensions)
+       0x7,         0,  ebx,       3,    bmi1                   , Bit manipulation extensions group 1
+       0x7,         0,  ebx,       4,    hle                    , Hardware Lock Elision
+       0x7,         0,  ebx,       5,    avx2                   , AVX2 instruction set
+       0x7,         0,  ebx,       6,    fdp_excptn_only        , FPU Data Pointer updated only on x87 exceptions
+       0x7,         0,  ebx,       7,    smep                   , Supervisor Mode Execution Protection
+       0x7,         0,  ebx,       8,    bmi2                   , Bit manipulation extensions group 2
+       0x7,         0,  ebx,       9,    erms                   , Enhanced REP MOVSB/STOSB
+       0x7,         0,  ebx,      10,    invpcid                , INVPCID instruction (Invalidate Processor Context ID)
+       0x7,         0,  ebx,      11,    rtm                    , Intel restricted transactional memory
+       0x7,         0,  ebx,      12,    cqm                    , Intel RDT-CMT / AMD Platform-QoS cache monitoring
+       0x7,         0,  ebx,      13,    zero_fcs_fds           , Deprecated FPU CS/DS (stored as zero)
+       0x7,         0,  ebx,      14,    mpx                    , Intel memory protection extensions
+       0x7,         0,  ebx,      15,    rdt_a                  , Intel RDT / AMD Platform-QoS Enforcemeent
+       0x7,         0,  ebx,      16,    avx512f                , AVX-512 foundation instructions
+       0x7,         0,  ebx,      17,    avx512dq               , AVX-512 double/quadword instructions
+       0x7,         0,  ebx,      18,    rdseed                 , RDSEED instruction
+       0x7,         0,  ebx,      19,    adx                    , ADCX/ADOX instructions
+       0x7,         0,  ebx,      20,    smap                   , Supervisor mode access prevention
+       0x7,         0,  ebx,      21,    avx512ifma             , AVX-512 integer fused multiply add
+       0x7,         0,  ebx,      23,    clflushopt             , CLFLUSHOPT instruction
+       0x7,         0,  ebx,      24,    clwb                   , CLWB instruction
+       0x7,         0,  ebx,      25,    intel_pt               , Intel processor trace
+       0x7,         0,  ebx,      26,    avx512pf               , AVX-512 prefetch instructions
+       0x7,         0,  ebx,      27,    avx512er               , AVX-512 exponent/reciprocal instrs
+       0x7,         0,  ebx,      28,    avx512cd               , AVX-512 conflict detection instrs
+       0x7,         0,  ebx,      29,    sha_ni                 , SHA/SHA256 instructions
+       0x7,         0,  ebx,      30,    avx512bw               , AVX-512 BW (byte/word granular) instructions
+       0x7,         0,  ebx,      31,    avx512vl               , AVX-512 VL (128/256 vector length) extensions
+       0x7,         0,  ecx,       0,    prefetchwt1            , PREFETCHWT1 (Intel Xeon Phi only)
+       0x7,         0,  ecx,       1,    avx512vbmi             , AVX-512 Vector byte manipulation instrs
+       0x7,         0,  ecx,       2,    umip                   , User mode instruction protection
+       0x7,         0,  ecx,       3,    pku                    , Protection keys for user-space
+       0x7,         0,  ecx,       4,    ospke                  , OS protection keys enable
+       0x7,         0,  ecx,       5,    waitpkg                , WAITPKG instructions
+       0x7,         0,  ecx,       6,    avx512_vbmi2           , AVX-512 vector byte manipulation instrs group 2
+       0x7,         0,  ecx,       7,    cet_ss                 , CET shadow stack features
+       0x7,         0,  ecx,       8,    gfni                   , Galois field new instructions
+       0x7,         0,  ecx,       9,    vaes                   , Vector AES instrs
+       0x7,         0,  ecx,      10,    vpclmulqdq             , VPCLMULQDQ 256-bit instruction support
+       0x7,         0,  ecx,      11,    avx512_vnni            , Vector neural network instructions
+       0x7,         0,  ecx,      12,    avx512_bitalg          , AVX-512 bit count/shiffle
+       0x7,         0,  ecx,      13,    tme                    , Intel total memory encryption
+       0x7,         0,  ecx,      14,    avx512_vpopcntdq       , AVX-512: POPCNT for vectors of DW/QW
+       0x7,         0,  ecx,      16,    la57                   , 57-bit linear addreses (five-level paging)
+       0x7,         0,  ecx,   21:17,    mawau_val_lm           , BNDLDX/BNDSTX MAWAU value in 64-bit mode
+       0x7,         0,  ecx,      22,    rdpid                  , RDPID instruction
+       0x7,         0,  ecx,      23,    key_locker             , Intel key locker support
+       0x7,         0,  ecx,      24,    bus_lock_detect        , OS bus-lock detection
+       0x7,         0,  ecx,      25,    cldemote               , CLDEMOTE instruction
+       0x7,         0,  ecx,      27,    movdiri                , MOVDIRI instruction
+       0x7,         0,  ecx,      28,    movdir64b              , MOVDIR64B instruction
+       0x7,         0,  ecx,      29,    enqcmd                 , Enqueue stores supported (ENQCMD{,S})
+       0x7,         0,  ecx,      30,    sgx_lc                 , Intel SGX launch configuration
+       0x7,         0,  ecx,      31,    pks                    , Protection keys for supervisor-mode pages
+       0x7,         0,  edx,       1,    sgx_keys               , Intel SGX attestation services
+       0x7,         0,  edx,       2,    avx512_4vnniw          , AVX-512 neural network instructions
+       0x7,         0,  edx,       3,    avx512_4fmaps          , AVX-512 multiply accumulation single precision
+       0x7,         0,  edx,       4,    fsrm                   , Fast short REP MOV
+       0x7,         0,  edx,       5,    uintr                  , CPU supports user interrupts
+       0x7,         0,  edx,       8,    avx512_vp2intersect    , VP2INTERSECT{D,Q} instructions
+       0x7,         0,  edx,       9,    srdbs_ctrl             , SRBDS mitigation MSR available
+       0x7,         0,  edx,      10,    md_clear               , VERW MD_CLEAR microcode support
+       0x7,         0,  edx,      11,    rtm_always_abort       , XBEGIN (RTM transaction) always aborts
+       0x7,         0,  edx,      13,    tsx_force_abort        , MSR TSX_FORCE_ABORT, RTM_ABORT bit, supported
+       0x7,         0,  edx,      14,    serialize              , SERIALIZE instruction
+       0x7,         0,  edx,      15,    hybrid_cpu             , The CPU is identified as a 'hybrid part'
+       0x7,         0,  edx,      16,    tsxldtrk               , TSX suspend/resume load address tracking
+       0x7,         0,  edx,      18,    pconfig                , PCONFIG instruction
+       0x7,         0,  edx,      19,    arch_lbr               , Intel architectural LBRs
+       0x7,         0,  edx,      20,    ibt                    , CET indirect branch tracking
+       0x7,         0,  edx,      22,    amx_bf16               , AMX-BF16: tile bfloat16 support
+       0x7,         0,  edx,      23,    avx512_fp16            , AVX-512 FP16 instructions
+       0x7,         0,  edx,      24,    amx_tile               , AMX-TILE: tile architecture support
+       0x7,         0,  edx,      25,    amx_int8               , AMX-INT8: tile 8-bit integer support
+       0x7,         0,  edx,      26,    spec_ctrl              , Speculation Control (IBRS/IBPB: indirect branch restrictions)
+       0x7,         0,  edx,      27,    intel_stibp            , Single thread indirect branch predictors
+       0x7,         0,  edx,      28,    flush_l1d              , FLUSH L1D cache: IA32_FLUSH_CMD MSR
+       0x7,         0,  edx,      29,    arch_capabilities      , Intel IA32_ARCH_CAPABILITIES MSR
+       0x7,         0,  edx,      30,    core_capabilities      , IA32_CORE_CAPABILITIES MSR
+       0x7,         0,  edx,      31,    spec_ctrl_ssbd         , Speculative store bypass disable
+       0x7,         1,  eax,       4,    avx_vnni               , AVX-VNNI instructions
+       0x7,         1,  eax,       5,    avx512_bf16            , AVX-512 bFloat16 instructions
+       0x7,         1,  eax,       6,    lass                   , Linear address space separation
+       0x7,         1,  eax,       7,    cmpccxadd              , CMPccXADD instructions
+       0x7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmonExt: CPUID leaf 0x23 is supported
+       0x7,         1,  eax,      10,    fzrm                   , Fast zero-length REP MOVSB
+       0x7,         1,  eax,      11,    fsrs                   , Fast short REP STOSB
+       0x7,         1,  eax,      12,    fsrc                   , Fast Short REP CMPSB/SCASB
+       0x7,         1,  eax,      17,    fred                   , FRED: Flexible return and event delivery transitions
+       0x7,         1,  eax,      18,    lkgs                   , LKGS: Load 'kernel' (userspace) GS
+       0x7,         1,  eax,      19,    wrmsrns                , WRMSRNS instr (WRMSR-non-serializing)
+       0x7,         1,  eax,      20,    nmi_src                , NMI-source reporting with FRED event data
+       0x7,         1,  eax,      21,    amx_fp16               , AMX-FP16: FP16 tile operations
+       0x7,         1,  eax,      22,    hreset                 , History reset support
+       0x7,         1,  eax,      23,    avx_ifma               , Integer fused multiply add
+       0x7,         1,  eax,      26,    lam                    , Linear address masking
+       0x7,         1,  eax,      27,    rd_wr_msrlist          , RDMSRLIST/WRMSRLIST instructions
+       0x7,         1,  ebx,       0,    intel_ppin             , Protected processor inventory number (PPIN{,_CTL} MSRs)
+       0x7,         1,  edx,       4,    avx_vnni_int8          , AVX-VNNI-INT8 instructions
+       0x7,         1,  edx,       5,    avx_ne_convert         , AVX-NE-CONVERT instructions
+       0x7,         1,  edx,       8,    amx_complex            , AMX-COMPLEX instructions (starting from Granite Rapids)
+       0x7,         1,  edx,      14,    prefetchit_0_1         , PREFETCHIT0/1 instructions
+       0x7,         1,  edx,      18,    cet_sss                , CET supervisor shadow stacks safe to use
+       0x7,         2,  edx,       0,    intel_psfd             , Intel predictive store forward disable
+       0x7,         2,  edx,       1,    ipred_ctrl             , MSR bits IA32_SPEC_CTRL.IPRED_DIS_{U,S}
+       0x7,         2,  edx,       2,    rrsba_ctrl             , MSR bits IA32_SPEC_CTRL.RRSBA_DIS_{U,S}
+       0x7,         2,  edx,       3,    ddp_ctrl               , MSR bit  IA32_SPEC_CTRL.DDPD_U
+       0x7,         2,  edx,       4,    bhi_ctrl               , MSR bit  IA32_SPEC_CTRL.BHI_DIS_S
+       0x7,         2,  edx,       5,    mcdt_no                , MCDT mitigation not needed
+       0x7,         2,  edx,       6,    uclock_disable         , UC-lock disable is supported
 
 # Leaf 9H
 # Intel DCA (Direct Cache Access) enumeration
 
-         9,         0,  eax,       0,    dca_enabled_in_bios    , DCA is enabled in BIOS
+       0x9,         0,  eax,       0,    dca_enabled_in_bios    , DCA is enabled in BIOS
 
 # Leaf AH
 # Intel PMU (Performance Monitoring Unit) enumeration
@@ -623,7 +632,7 @@
 0x40000000,         0,  edx,    31:0,    hypervisor_id_2        , Hypervisor ID string bytes 8 - 11
 
 # Leaf 80000000H
-# Maximum extended leaf number + CPU vendor string (AMD)
+# Maximum extended leaf number + AMD/Transmeta CPU vendor string
 
 0x80000000,         0,  eax,    31:0,    max_ext_leaf           , Maximum extended cpuid leaf supported
 0x80000000,         0,  ebx,    31:0,    cpu_vendorid_0         , Vendor ID string bytes 0 - 3
@@ -636,6 +645,7 @@
 0x80000001,         0,  eax,     3:0,    e_stepping_id          , Stepping ID
 0x80000001,         0,  eax,     7:4,    e_base_model           , Base processor model
 0x80000001,         0,  eax,    11:8,    e_base_family          , Base processor family
+0x80000001,         0,  eax,   13:12,    e_base_type            , Base processor type (Transmeta)
 0x80000001,         0,  eax,   19:16,    e_ext_model            , Extended processor model
 0x80000001,         0,  eax,   27:20,    e_ext_family           , Extended processor family
 0x80000001,         0,  ebx,    15:0,    brand_id               , Brand ID
@@ -687,6 +697,7 @@
 0x80000001,         0,  edx,      19,    mp                     , Out-of-spec AMD Multiprocessing bit
 0x80000001,         0,  edx,      20,    nx                     , No-execute page protection
 0x80000001,         0,  edx,      22,    mmxext                 , AMD MMX extensions
+0x80000001,         0,  edx,      23,    e_mmx                  , MMX instructions (Transmeta)
 0x80000001,         0,  edx,      24,    e_fxsr                 , FXSAVE and FXRSTOR instructions
 0x80000001,         0,  edx,      25,    fxsr_opt               , FXSAVE and FXRSTOR optimizations
 0x80000001,         0,  edx,      26,    pdpe1gb                , 1-GB large page support
@@ -720,7 +731,7 @@
 0x80000004,         0,  edx,    31:0,    cpu_brandid_11         , CPU brand ID string, bytes 44 - 47
 
 # Leaf 80000005H
-# AMD L1 cache and L1 TLB enumeration
+# AMD/Transmeta L1 cache and L1 TLB enumeration
 
 0x80000005,         0,  eax,     7:0,    l1_itlb_2m_4m_nentries , L1 ITLB #entires, 2M and 4M pages
 0x80000005,         0,  eax,    15:8,    l1_itlb_2m_4m_assoc    , L1 ITLB associativity, 2M and 4M pages
@@ -1051,3 +1062,108 @@
 0x80000026,       3:0,  ecx,     7:0,    domain_level           , This domain level (subleaf ID)
 0x80000026,       3:0,  ecx,    15:8,    domain_type            , This domain type
 0x80000026,       3:0,  edx,    31:0,    x2apic_id              , x2APIC ID of current logical CPU
+
+# Leaf 80860000H
+# Maximum Transmeta leaf number + CPU vendor ID string
+
+0x80860000,         0,  eax,    31:0,    max_tra_leaf           , Maximum supported Transmeta leaf number
+0x80860000,         0,  ebx,    31:0,    cpu_vendorid_0         , Transmeta Vendor ID string bytes 0 - 3
+0x80860000,         0,  ecx,    31:0,    cpu_vendorid_2         , Transmeta Vendor ID string bytes 8 - 11
+0x80860000,         0,  edx,    31:0,    cpu_vendorid_1         , Transmeta Vendor ID string bytes 4 - 7
+
+# Leaf 80860001H
+# Transmeta extended CPU information
+
+0x80860001,         0,  eax,     3:0,    stepping               , Stepping ID
+0x80860001,         0,  eax,     7:4,    base_model             , Base CPU model ID
+0x80860001,         0,  eax,    11:8,    base_family_id         , Base CPU family ID
+0x80860001,         0,  eax,   13:12,    cpu_type               , CPU type
+0x80860001,         0,  ebx,     7:0,    cpu_rev_mask_minor     , CPU revision ID, mask minor
+0x80860001,         0,  ebx,    15:8,    cpu_rev_mask_major     , CPU revision ID, mask major
+0x80860001,         0,  ebx,   23:16,    cpu_rev_minor          , CPU revision ID, minor
+0x80860001,         0,  ebx,   31:24,    cpu_rev_major          , CPU revision ID, major
+0x80860001,         0,  ecx,    31:0,    cpu_base_mhz           , CPU nominal frequency, in MHz
+0x80860001,         0,  edx,       0,    recovery               , Recovery CMS is active (after bad flush)
+0x80860001,         0,  edx,       1,    longrun                , LongRun power management capabilities
+0x80860001,         0,  edx,       3,    lrti                   , LongRun Table Interface
+
+# Leaf 80860002H
+# Transmeta Code Morphing Software (CMS) enumeration
+
+0x80860002,         0,  eax,    31:0,    cpu_rev_id             , CPU revision ID
+0x80860002,         0,  ebx,     7:0,    cms_rev_mask_2         , CMS revision ID, mask component 2
+0x80860002,         0,  ebx,    15:8,    cms_rev_mask_1         , CMS revision ID, mask component 1
+0x80860002,         0,  ebx,   23:16,    cms_rev_minor          , CMS revision ID, minor
+0x80860002,         0,  ebx,   31:24,    cms_rev_major          , CMS revision ID, major
+0x80860002,         0,  ecx,    31:0,    cms_rev_mask_3         , CMS revision ID, mask component 3
+
+# Leaf 80860003H
+# Transmeta CPU information string, bytes 0 - 15
+
+0x80860003,         0,  eax,    31:0,    cpu_info_0             , CPU info string bytes 0 - 3
+0x80860003,         0,  ebx,    31:0,    cpu_info_1             , CPU info string bytes 4 - 7
+0x80860003,         0,  ecx,    31:0,    cpu_info_2             , CPU info string bytes 8 - 11
+0x80860003,         0,  edx,    31:0,    cpu_info_3             , CPU info string bytes 12 - 15
+
+# Leaf 80860004H
+# Transmeta CPU information string, bytes 16 - 31
+
+0x80860004,         0,  eax,    31:0,    cpu_info_4             , CPU info string bytes 16 - 19
+0x80860004,         0,  ebx,    31:0,    cpu_info_5             , CPU info string bytes 20 - 23
+0x80860004,         0,  ecx,    31:0,    cpu_info_6             , CPU info string bytes 24 - 27
+0x80860004,         0,  edx,    31:0,    cpu_info_7             , CPU info string bytes 28 - 31
+
+# Leaf 80860005H
+# Transmeta CPU information string, bytes 32 - 47
+
+0x80860005,         0,  eax,    31:0,    cpu_info_8             , CPU info string bytes 32 - 35
+0x80860005,         0,  ebx,    31:0,    cpu_info_9             , CPU info string bytes 36 - 39
+0x80860005,         0,  ecx,    31:0,    cpu_info_10            , CPU info string bytes 40 - 43
+0x80860005,         0,  edx,    31:0,    cpu_info_11            , CPU info string bytes 44 - 47
+
+# Leaf 80860006H
+# Transmeta CPU information string, bytes 48 - 63
+
+0x80860006,         0,  eax,    31:0,    cpu_info_12            , CPU info string bytes 48 - 51
+0x80860006,         0,  ebx,    31:0,    cpu_info_13            , CPU info string bytes 52 - 55
+0x80860006,         0,  ecx,    31:0,    cpu_info_14            , CPU info string bytes 56 - 59
+0x80860006,         0,  edx,    31:0,    cpu_info_15            , CPU info string bytes 60 - 63
+
+# Leaf 80860007H
+# Transmeta live CPU information
+
+0x80860007,         0,  eax,    31:0,    cpu_cur_mhz            , Current CPU frequency, in MHz
+0x80860007,         0,  ebx,    31:0,    cpu_cur_voltage        , Current CPU voltage, in millivolts
+0x80860007,         0,  ecx,    31:0,    cpu_cur_perf_pctg      , Current CPU performance percentage, 0 - 100d
+0x80860007,         0,  edx,    31:0,    cpu_cur_gate_delay     , Current CPU gate delay, in femtoseconds
+
+# Leaf C0000000H
+# Maximum Centaur/Zhaoxin leaf number
+
+0xc0000000,         0,  eax,    31:0,    max_cntr_leaf          , Maximum Centaur/Zhaoxin leaf number
+
+# Leaf C0000001H
+# Centaur/Zhaoxin extended CPU features
+
+0xc0000001,         0,  edx,       0,    ccs_sm2                , CCS SM2 instructions
+0xc0000001,         0,  edx,       1,    ccs_sm2_en             , CCS SM2 enabled
+0xc0000001,         0,  edx,       2,    xstore                 , Random Number Generator
+0xc0000001,         0,  edx,       3,    xstore_en              , RNG enabled
+0xc0000001,         0,  edx,       4,    ccs_sm3_sm4            , CCS SM3 and SM4 instructions
+0xc0000001,         0,  edx,       5,    ccs_sm3_sm4_en         , CCS SM3/SM4 enabled
+0xc0000001,         0,  edx,       6,    ace                    , Advanced Cryptography Engine
+0xc0000001,         0,  edx,       7,    ace_en                 , ACE enabled
+0xc0000001,         0,  edx,       8,    ace2                   , Advanced Cryptography Engine v2
+0xc0000001,         0,  edx,       9,    ace2_en                , ACE v2 enabled
+0xc0000001,         0,  edx,      10,    phe                    , PadLock Hash Engine
+0xc0000001,         0,  edx,      11,    phe_en                 , PHE enabled
+0xc0000001,         0,  edx,      12,    pmm                    , PadLock Montgomery Multiplier
+0xc0000001,         0,  edx,      13,    pmm_en                 , PMM enabled
+0xc0000001,         0,  edx,      16,    parallax               , Parallax auto adjust processor voltage
+0xc0000001,         0,  edx,      17,    parallax_en            , Parallax enabled
+0xc0000001,         0,  edx,      20,    tm3                    , Thermal Monitor v3
+0xc0000001,         0,  edx,      21,    tm3_en                 , TM v3 enabled
+0xc0000001,         0,  edx,      25,    phe2                   , PadLock Hash Engine v2 (SHA384/SHA512)
+0xc0000001,         0,  edx,      26,    phe2_en                , PHE v2 enabled
+0xc0000001,         0,  edx,      27,    rsa                    , RSA instructions (XMODEXP/MONTMUL2)
+0xc0000001,         0,  edx,      28,    rsa_en                 , RSA instructions enabled

