Return-Path: <linux-tip-commits+bounces-4473-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D31A6EC26
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F6B188CF76
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B6254AF9;
	Tue, 25 Mar 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YFHDe8SE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cTuQywBr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E56253F13;
	Tue, 25 Mar 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893543; cv=none; b=VRh+rNXdn4UsaCXUk4eElpkD4Gk317XXCCcw6aV0la9zHDTzl9v3A5VueLOGJ/4tX/Co5agSy/wNx14i2ksAnZFX8jmm8FJpWXorqlpeZ56qsP5iPBITAz3AXK0KTpfzekcoMHnymVe2DpEW3RAsayEYlSrmNVFR+eiExbfCe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893543; c=relaxed/simple;
	bh=Buuy6qmD0f08nIJKdZRhkp6SOvbJb/xmw6KXDaOtwUQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DZeVr+OnbI6/wTVwIHmfgzLXRCDplxZSXeT+udsc5H++hSPLoM7QZAsAhe+hNsThS2kK5HSl0q9D3GLb0OcD7PZ+muBHgFw4Q60v5l1DhgdcyvzWK/HaESXhxLVKFts1tnviSsk+p86iXZZdY+yGpDjnuO0QFLeBiefZmDgD9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YFHDe8SE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cTuQywBr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptjLpxkuY67/04sfsRh3WZT4K+SgWyGiBdwbOQq2aFY=;
	b=YFHDe8SEmlaB0GNi43D1tiT0r2/9O8o76O0nagc+VSkSzJY06T0xyCc9yNCufhs394e22F
	FKjGqxHG2t3I8bwp0ZlXGQPK8DQcUT9elDqvgtODfzvjVGFAnyxWIRK1CCLvvCXIrZIBvh
	APyaU4fU1lDke8uoR/a698wbP6qir5AYcnxefdjcApi1wOmbP5XAW7Jc9XXiLzXLyQ4BR4
	6x4HPpDzPLM9KF/7Faa34rdhCfBIjcTm3zjA7EqhHOtzFocb6yMNLrNw8qCbq6LEvnLNjX
	oOx8jt84OQ8lgHiZy99PXDFtOo68xyaiz2toCQgD9X/0KOKVGssL3qpROxjRPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptjLpxkuY67/04sfsRh3WZT4K+SgWyGiBdwbOQq2aFY=;
	b=cTuQywBrcjP0ZK/UGtzdmfmr+Sai8Sh36tAW4KKWvRz6XvXDXkv/Wh8KacLUKc3kTsDCKy
	0yq1azdFDC0fu+CQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.1
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-18-darwi@linutronix.de>
References: <20250324142042.29010-18-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353749.14745.5056012752445642823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f5e7fd6857963e697600d881242bbb39b0b9ac37
Gitweb:        https://git.kernel.org/tip/f5e7fd6857963e697600d881242bbb39b0b9ac37
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:47 +01:00

tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.1

Update kcpuid's CSV file to version 2.1, as generated by x86-cpuid-db.

Summary of the v2.1 changes:

* Use a standardized style for all x86 trademarks, registers, opcodes,
  byte units, hexadecimal digits, and x86 technical terms. This was
  enforced by a number of x86-specific hunspell(5) dictionary and affix
  files at the x86-cpuid-db project's CI pipeline.

* Expand abbreviated terms that might be OK in code but not in official
  listings (e.g., "addr", "instr", "reg", "virt", etc.)

* Add new Zen5 SoC bits to leaf 0x80000020 and leaf 0x80000021.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.1/CHANGELOG.rst
Link: https://lore.kernel.org/r/20250324142042.29010-18-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/cpuid.csv | 171 ++++++++++++++++---------------
 1 file changed, 91 insertions(+), 80 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index d0f7159..0f9c112 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: CC0-1.0
-# Generator: x86-cpuid-db v2.0
+# Generator: x86-cpuid-db v2.1
 
 #
 # Auto-generated file.
@@ -28,7 +28,7 @@
        0x1,         0,  eax,   27:20,    ext_family             , Extended CPU family ID
        0x1,         0,  ebx,     7:0,    brand_id               , Brand index
        0x1,         0,  ebx,    15:8,    clflush_size           , CLFLUSH instruction cache line size
-       0x1,         0,  ebx,   23:16,    n_logical_cpu          , Logical CPU (HW threads) count
+       0x1,         0,  ebx,   23:16,    n_logical_cpu          , Logical CPU count
        0x1,         0,  ebx,   31:24,    local_apic_id          , Initial local APIC physical ID
        0x1,         0,  ecx,       0,    pni                    , Streaming SIMD Extensions 3 (SSE3)
        0x1,         0,  ecx,       1,    pclmulqdq              , PCLMULQDQ instruction support
@@ -41,7 +41,7 @@
        0x1,         0,  ecx,       8,    tm2                    , Thermal Monitor 2
        0x1,         0,  ecx,       9,    ssse3                  , Supplemental SSE3
        0x1,         0,  ecx,      10,    cid                    , L1 Context ID
-       0x1,         0,  ecx,      11,    sdbg                   , Sillicon Debug
+       0x1,         0,  ecx,      11,    sdbg                   , Silicon Debug
        0x1,         0,  ecx,      12,    fma                    , FMA extensions using YMM state
        0x1,         0,  ecx,      13,    cx16                   , CMPXCHG16B instruction support
        0x1,         0,  ecx,      14,    xtpr                   , xTPR Update Control
@@ -89,13 +89,13 @@
        0x1,         0,  edx,      27,    ss                     , Self Snoop
        0x1,         0,  edx,      28,    ht                     , Hyper-threading
        0x1,         0,  edx,      29,    tm                     , Thermal Monitor
-       0x1,         0,  edx,      30,    ia64                   , Legacy IA-64 (Itanium) support bit, now resreved
+       0x1,         0,  edx,      30,    ia64                   , Legacy IA-64 (Itanium) support bit, now reserved
        0x1,         0,  edx,      31,    pbe                    , Pending Break Enable
 
 # Leaf 2H
 # Intel cache and TLB information one-byte descriptors
 
-       0x2,         0,  eax,     7:0,    iteration_count        , Number of times this CPUD leaf must be queried
+       0x2,         0,  eax,     7:0,    iteration_count        , Number of times this leaf must be queried
        0x2,         0,  eax,    15:8,    desc1                  , Descriptor #1
        0x2,         0,  eax,   23:16,    desc2                  , Descriptor #2
        0x2,         0,  eax,   30:24,    desc3                  , Descriptor #3
@@ -129,7 +129,7 @@
 
        0x4,      31:0,  eax,     4:0,    cache_type             , Cache type field
        0x4,      31:0,  eax,     7:5,    cache_level            , Cache level (1-based)
-       0x4,      31:0,  eax,       8,    cache_self_init        , Self-initialializing cache level
+       0x4,      31:0,  eax,       8,    cache_self_init        , Self-initializing cache level
        0x4,      31:0,  eax,       9,    fully_associative      , Fully-associative cache
        0x4,      31:0,  eax,   25:14,    num_threads_sharing    , Number logical CPUs sharing this cache
        0x4,      31:0,  eax,   31:26,    num_cores_on_die       , Number of cores in the physical package
@@ -160,7 +160,7 @@
 # Leaf 6H
 # Thermal and Power Management enumeration
 
-       0x6,         0,  eax,       0,    dtherm                 , Digital temprature sensor
+       0x6,         0,  eax,       0,    dtherm                 , Digital temperature sensor
        0x6,         0,  eax,       1,    turbo_boost            , Intel Turbo Boost
        0x6,         0,  eax,       2,    arat                   , Always-Running APIC Timer (not affected by p-state)
        0x6,         0,  eax,       4,    pln                    , Power Limit Notification (PLN) event
@@ -187,8 +187,8 @@
        0x6,         0,  ecx,    15:8,    thrd_director_nclasses , Number of classes, Intel thread director
        0x6,         0,  edx,       0,    perfcap_reporting      , Performance capability reporting
        0x6,         0,  edx,       1,    encap_reporting        , Energy efficiency capability reporting
-       0x6,         0,  edx,    11:8,    feedback_sz            , HW feedback interface struct size, in 4K pages
-       0x6,         0,  edx,   31:16,    this_lcpu_hwfdbk_idx   , This logical CPU index @ HW feedback struct, 0-based
+       0x6,         0,  edx,    11:8,    feedback_sz            , Feedback interface structure size, in 4K pages
+       0x6,         0,  edx,   31:16,    this_lcpu_hwfdbk_idx   , This logical CPU hardware feedback interface index
 
 # Leaf 7H
 # Extended CPU features enumeration
@@ -209,7 +209,7 @@
        0x7,         0,  ebx,      12,    cqm                    , Intel RDT-CMT / AMD Platform-QoS cache monitoring
        0x7,         0,  ebx,      13,    zero_fcs_fds           , Deprecated FPU CS/DS (stored as zero)
        0x7,         0,  ebx,      14,    mpx                    , Intel memory protection extensions
-       0x7,         0,  ebx,      15,    rdt_a                  , Intel RDT / AMD Platform-QoS Enforcemeent
+       0x7,         0,  ebx,      15,    rdt_a                  , Intel RDT / AMD Platform-QoS Enforcement
        0x7,         0,  ebx,      16,    avx512f                , AVX-512 foundation instructions
        0x7,         0,  ebx,      17,    avx512dq               , AVX-512 double/quadword instructions
        0x7,         0,  ebx,      18,    rdseed                 , RDSEED instruction
@@ -220,27 +220,27 @@
        0x7,         0,  ebx,      24,    clwb                   , CLWB instruction
        0x7,         0,  ebx,      25,    intel_pt               , Intel processor trace
        0x7,         0,  ebx,      26,    avx512pf               , AVX-512 prefetch instructions
-       0x7,         0,  ebx,      27,    avx512er               , AVX-512 exponent/reciprocal instrs
-       0x7,         0,  ebx,      28,    avx512cd               , AVX-512 conflict detection instrs
+       0x7,         0,  ebx,      27,    avx512er               , AVX-512 exponent/reciprocal instructions
+       0x7,         0,  ebx,      28,    avx512cd               , AVX-512 conflict detection instructions
        0x7,         0,  ebx,      29,    sha_ni                 , SHA/SHA256 instructions
-       0x7,         0,  ebx,      30,    avx512bw               , AVX-512 BW (byte/word granular) instructions
+       0x7,         0,  ebx,      30,    avx512bw               , AVX-512 byte/word instructions
        0x7,         0,  ebx,      31,    avx512vl               , AVX-512 VL (128/256 vector length) extensions
        0x7,         0,  ecx,       0,    prefetchwt1            , PREFETCHWT1 (Intel Xeon Phi only)
-       0x7,         0,  ecx,       1,    avx512vbmi             , AVX-512 Vector byte manipulation instrs
+       0x7,         0,  ecx,       1,    avx512vbmi             , AVX-512 Vector byte manipulation instructions
        0x7,         0,  ecx,       2,    umip                   , User mode instruction protection
        0x7,         0,  ecx,       3,    pku                    , Protection keys for user-space
        0x7,         0,  ecx,       4,    ospke                  , OS protection keys enable
        0x7,         0,  ecx,       5,    waitpkg                , WAITPKG instructions
-       0x7,         0,  ecx,       6,    avx512_vbmi2           , AVX-512 vector byte manipulation instrs group 2
+       0x7,         0,  ecx,       6,    avx512_vbmi2           , AVX-512 vector byte manipulation instructions group 2
        0x7,         0,  ecx,       7,    cet_ss                 , CET shadow stack features
        0x7,         0,  ecx,       8,    gfni                   , Galois field new instructions
-       0x7,         0,  ecx,       9,    vaes                   , Vector AES instrs
+       0x7,         0,  ecx,       9,    vaes                   , Vector AES instructions
        0x7,         0,  ecx,      10,    vpclmulqdq             , VPCLMULQDQ 256-bit instruction support
        0x7,         0,  ecx,      11,    avx512_vnni            , Vector neural network instructions
-       0x7,         0,  ecx,      12,    avx512_bitalg          , AVX-512 bit count/shiffle
+       0x7,         0,  ecx,      12,    avx512_bitalg          , AVX-512 bitwise algorithms
        0x7,         0,  ecx,      13,    tme                    , Intel total memory encryption
-       0x7,         0,  ecx,      14,    avx512_vpopcntdq       , AVX-512: POPCNT for vectors of DW/QW
-       0x7,         0,  ecx,      16,    la57                   , 57-bit linear addreses (five-level paging)
+       0x7,         0,  ecx,      14,    avx512_vpopcntdq       , AVX-512: POPCNT for vectors of DWORD/QWORD
+       0x7,         0,  ecx,      16,    la57                   , 57-bit linear addresses (five-level paging)
        0x7,         0,  ecx,   21:17,    mawau_val_lm           , BNDLDX/BNDSTX MAWAU value in 64-bit mode
        0x7,         0,  ecx,      22,    rdpid                  , RDPID instruction
        0x7,         0,  ecx,      23,    key_locker             , Intel key locker support
@@ -278,7 +278,7 @@
        0x7,         0,  edx,      30,    core_capabilities      , IA32_CORE_CAPABILITIES MSR
        0x7,         0,  edx,      31,    spec_ctrl_ssbd         , Speculative store bypass disable
        0x7,         1,  eax,       4,    avx_vnni               , AVX-VNNI instructions
-       0x7,         1,  eax,       5,    avx512_bf16            , AVX-512 bFloat16 instructions
+       0x7,         1,  eax,       5,    avx512_bf16            , AVX-512 bfloat16 instructions
        0x7,         1,  eax,       6,    lass                   , Linear address space separation
        0x7,         1,  eax,       7,    cmpccxadd              , CMPccXADD instructions
        0x7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmonExt: CPUID leaf 0x23 is supported
@@ -287,7 +287,7 @@
        0x7,         1,  eax,      12,    fsrc                   , Fast Short REP CMPSB/SCASB
        0x7,         1,  eax,      17,    fred                   , FRED: Flexible return and event delivery transitions
        0x7,         1,  eax,      18,    lkgs                   , LKGS: Load 'kernel' (userspace) GS
-       0x7,         1,  eax,      19,    wrmsrns                , WRMSRNS instr (WRMSR-non-serializing)
+       0x7,         1,  eax,      19,    wrmsrns                , WRMSRNS instruction (WRMSR-non-serializing)
        0x7,         1,  eax,      20,    nmi_src                , NMI-source reporting with FRED event data
        0x7,         1,  eax,      21,    amx_fp16               , AMX-FP16: FP16 tile operations
        0x7,         1,  eax,      22,    hreset                 , History reset support
@@ -348,18 +348,18 @@
        0xd,         0,  eax,       0,    xcr0_x87               , XCR0.X87 (bit 0) supported
        0xd,         0,  eax,       1,    xcr0_sse               , XCR0.SEE (bit 1) supported
        0xd,         0,  eax,       2,    xcr0_avx               , XCR0.AVX (bit 2) supported
-       0xd,         0,  eax,       3,    xcr0_mpx_bndregs       , XCR0.BNDREGS (bit 3) supported (MPX BND0-BND3 regs)
-       0xd,         0,  eax,       4,    xcr0_mpx_bndcsr        , XCR0.BNDCSR (bit 4) supported (MPX BNDCFGU/BNDSTATUS regs)
-       0xd,         0,  eax,       5,    xcr0_avx512_opmask     , XCR0.OPMASK (bit 5) supported (AVX-512 k0-k7 regs)
-       0xd,         0,  eax,       6,    xcr0_avx512_zmm_hi256  , XCR0.ZMM_Hi256 (bit 6) supported (AVX-512 ZMM0->ZMM7/15 regs)
-       0xd,         0,  eax,       7,    xcr0_avx512_hi16_zmm   , XCR0.HI16_ZMM (bit 7) supported (AVX-512 ZMM16->ZMM31 regs)
-       0xd,         0,  eax,       9,    xcr0_pkru              , XCR0.PKRU (bit 9) supported (XSAVE PKRU reg)
-       0xd,         0,  eax,      11,    xcr0_cet_u             , AMD XCR0.CET_U (bit 11) supported (CET supervisor state)
-       0xd,         0,  eax,      12,    xcr0_cet_s             , AMD XCR0.CET_S (bit 12) support (CET user state)
+       0xd,         0,  eax,       3,    xcr0_mpx_bndregs       , XCR0.BNDREGS (bit 3) supported (MPX BND0-BND3 registers)
+       0xd,         0,  eax,       4,    xcr0_mpx_bndcsr        , XCR0.BNDCSR (bit 4) supported (MPX BNDCFGU/BNDSTATUS registers)
+       0xd,         0,  eax,       5,    xcr0_avx512_opmask     , XCR0.OPMASK (bit 5) supported (AVX-512 k0-k7 registers)
+       0xd,         0,  eax,       6,    xcr0_avx512_zmm_hi256  , XCR0.ZMM_Hi256 (bit 6) supported (AVX-512 ZMM0->ZMM7/15 registers)
+       0xd,         0,  eax,       7,    xcr0_avx512_hi16_zmm   , XCR0.HI16_ZMM (bit 7) supported (AVX-512 ZMM16->ZMM31 registers)
+       0xd,         0,  eax,       9,    xcr0_pkru              , XCR0.PKRU (bit 9) supported (XSAVE PKRU registers)
+       0xd,         0,  eax,      11,    xcr0_cet_u             , XCR0.CET_U (bit 11) supported (CET user state)
+       0xd,         0,  eax,      12,    xcr0_cet_s             , XCR0.CET_S (bit 12) supported (CET supervisor state)
        0xd,         0,  eax,      17,    xcr0_tileconfig        , XCR0.TILECONFIG (bit 17) supported (AMX can manage TILECONFIG)
        0xd,         0,  eax,      18,    xcr0_tiledata          , XCR0.TILEDATA (bit 18) supported (AMX can manage TILEDATA)
-       0xd,         0,  ebx,    31:0,    xsave_sz_xcr0_enabled  , XSAVE/XRSTR area byte size, for XCR0 enabled features
-       0xd,         0,  ecx,    31:0,    xsave_sz_max           , XSAVE/XRSTR area max byte size, all CPU features
+       0xd,         0,  ebx,    31:0,    xsave_sz_xcr0_enabled  , XSAVE/XRSTOR area byte size, for XCR0 enabled features
+       0xd,         0,  ecx,    31:0,    xsave_sz_max           , XSAVE/XRSTOR area max byte size, all CPU features
        0xd,         0,  edx,      30,    xcr0_lwp               , AMD XCR0.LWP (bit 62) supported (Light-weight Profiling)
        0xd,         1,  eax,       0,    xsaveopt               , XSAVEOPT instruction
        0xd,         1,  eax,       1,    xsavec                 , XSAVEC instruction
@@ -378,7 +378,7 @@
        0xd,      63:2,  eax,    31:0,    xsave_sz               , Size of save area for subleaf-N feature, in bytes
        0xd,      63:2,  ebx,    31:0,    xsave_offset           , Offset of save area for subleaf-N feature, in bytes
        0xd,      63:2,  ecx,       0,    is_xss_bit             , Subleaf N describes an XSS bit, otherwise XCR0 bit
-       0xd,      63:2,  ecx,       1,    compacted_xsave_64byte_aligned, When compacted, subleaf-N feature xsave area is 64-byte aligned
+       0xd,      63:2,  ecx,       1,    compacted_xsave_64byte_aligned, When compacted, subleaf-N feature XSAVE area is 64-byte aligned
 
 # Leaf FH
 # Intel RDT / AMD PQoS resource monitoring
@@ -435,17 +435,17 @@
       0x12,         1,  ecx,       0,    xfrm_x87               , Enclave XFRM.X87 (bit 0) supported
       0x12,         1,  ecx,       1,    xfrm_sse               , Enclave XFRM.SEE (bit 1) supported
       0x12,         1,  ecx,       2,    xfrm_avx               , Enclave XFRM.AVX (bit 2) supported
-      0x12,         1,  ecx,       3,    xfrm_mpx_bndregs       , Enclave XFRM.BNDREGS (bit 3) supported (MPX BND0-BND3 regs)
-      0x12,         1,  ecx,       4,    xfrm_mpx_bndcsr        , Enclave XFRM.BNDCSR (bit 4) supported (MPX BNDCFGU/BNDSTATUS regs)
-      0x12,         1,  ecx,       5,    xfrm_avx512_opmask     , Enclave XFRM.OPMASK (bit 5) supported (AVX-512 k0-k7 regs)
-      0x12,         1,  ecx,       6,    xfrm_avx512_zmm_hi256  , Enclave XFRM.ZMM_Hi256 (bit 6) supported (AVX-512 ZMM0->ZMM7/15 regs)
-      0x12,         1,  ecx,       7,    xfrm_avx512_hi16_zmm   , Enclave XFRM.HI16_ZMM (bit 7) supported (AVX-512 ZMM16->ZMM31 regs)
-      0x12,         1,  ecx,       9,    xfrm_pkru              , Enclave XFRM.PKRU (bit 9) supported (XSAVE PKRU reg)
+      0x12,         1,  ecx,       3,    xfrm_mpx_bndregs       , Enclave XFRM.BNDREGS (bit 3) supported (MPX BND0-BND3 registers)
+      0x12,         1,  ecx,       4,    xfrm_mpx_bndcsr        , Enclave XFRM.BNDCSR (bit 4) supported (MPX BNDCFGU/BNDSTATUS registers)
+      0x12,         1,  ecx,       5,    xfrm_avx512_opmask     , Enclave XFRM.OPMASK (bit 5) supported (AVX-512 k0-k7 registers)
+      0x12,         1,  ecx,       6,    xfrm_avx512_zmm_hi256  , Enclave XFRM.ZMM_Hi256 (bit 6) supported (AVX-512 ZMM0->ZMM7/15 registers)
+      0x12,         1,  ecx,       7,    xfrm_avx512_hi16_zmm   , Enclave XFRM.HI16_ZMM (bit 7) supported (AVX-512 ZMM16->ZMM31 registers)
+      0x12,         1,  ecx,       9,    xfrm_pkru              , Enclave XFRM.PKRU (bit 9) supported (XSAVE PKRU registers)
       0x12,         1,  ecx,      17,    xfrm_tileconfig        , Enclave XFRM.TILECONFIG (bit 17) supported (AMX can manage TILECONFIG)
       0x12,         1,  ecx,      18,    xfrm_tiledata          , Enclave XFRM.TILEDATA (bit 18) supported (AMX can manage TILEDATA)
       0x12,      31:2,  eax,     3:0,    subleaf_type           , Subleaf type (dictates output layout)
-      0x12,      31:2,  eax,   31:12,    epc_sec_base_addr_0    , EPC section base addr, bits[12:31]
-      0x12,      31:2,  ebx,    19:0,    epc_sec_base_addr_1    , EPC section base addr, bits[32:51]
+      0x12,      31:2,  eax,   31:12,    epc_sec_base_addr_0    , EPC section base address, bits[12:31]
+      0x12,      31:2,  ebx,    19:0,    epc_sec_base_addr_1    , EPC section base address, bits[32:51]
       0x12,      31:2,  ecx,     3:0,    epc_sec_type           , EPC section type / property encoding
       0x12,      31:2,  ecx,   31:12,    epc_sec_size_0         , EPC section size, bits[12:31]
       0x12,      31:2,  edx,    19:0,    epc_sec_size_1         , EPC section size, bits[32:51]
@@ -481,7 +481,7 @@
       0x15,         0,  ecx,    31:0,    cpu_crystal_hz         , Core crystal clock nominal frequency, in Hz
 
 # Leaf 16H
-# Intel processor fequency enumeration
+# Intel processor frequency enumeration
 
       0x16,         0,  eax,    15:0,    cpu_base_mhz           , Processor base frequency, in MHz
       0x16,         0,  ebx,    15:0,    cpu_max_mhz            , Processor max frequency, in MHz
@@ -492,7 +492,7 @@
 
       0x17,         0,  eax,    31:0,    soc_max_subleaf        , Max cpuid leaf 0x17 subleaf
       0x17,         0,  ebx,    15:0,    soc_vendor_id          , SoC vendor ID
-      0x17,         0,  ebx,      16,    is_vendor_scheme       , Assigned by industry enumaeratoion scheme (not Intel)
+      0x17,         0,  ebx,      16,    is_vendor_scheme       , Assigned by industry enumeration scheme (not Intel)
       0x17,         0,  ecx,    31:0,    soc_proj_id            , SoC project ID, assigned by vendor
       0x17,         0,  edx,    31:0,    soc_stepping_id        , Soc project stepping ID, assigned by vendor
       0x17,       3:1,  eax,    31:0,    vendor_brand_a         , Vendor Brand ID string, bytes subleaf_nr * (0 -> 3)
@@ -508,13 +508,13 @@
       0x18,      31:0,  ebx,       1,    tlb_2m_page            , TLB 2MB-page entries supported
       0x18,      31:0,  ebx,       2,    tlb_4m_page            , TLB 4MB-page entries supported
       0x18,      31:0,  ebx,       3,    tlb_1g_page            , TLB 1GB-page entries supported
-      0x18,      31:0,  ebx,    10:8,    hard_partitioning      , (Hard/Soft) partitioning between logical CPUs sharing this struct
+      0x18,      31:0,  ebx,    10:8,    hard_partitioning      , (Hard/Soft) partitioning between logical CPUs sharing this structure
       0x18,      31:0,  ebx,   31:16,    n_way_associative      , Ways of associativity
       0x18,      31:0,  ecx,    31:0,    n_sets                 , Number of sets
       0x18,      31:0,  edx,     4:0,    tlb_type               , Translation cache type (TLB type)
       0x18,      31:0,  edx,     7:5,    tlb_cache_level        , Translation cache level (1-based)
       0x18,      31:0,  edx,       8,    is_fully_associative   , Fully-associative structure
-      0x18,      31:0,  edx,   25:14,    tlb_max_addressible_ids, Max num of addressible IDs for logical CPUs sharing this TLB - 1
+      0x18,      31:0,  edx,   25:14,    tlb_max_addressible_ids, Max number of addressable IDs for logical CPUs sharing this TLB - 1
 
 # Leaf 19H
 # Intel Key Locker enumeration
@@ -577,7 +577,7 @@
 # Intel AMX, TMUL (Tile-matrix MULtiply) accelerator unit enumeration
 
       0x1e,         0,  ebx,     7:0,    tmul_maxk              , TMUL unit maximum height, K (rows or columns)
-      0x1e,         0,  ebx,    23:8,    tmul_maxn              , TMUL unit maxiumum SIMD dimension, N (column bytes)
+      0x1e,         0,  ebx,    23:8,    tmul_maxn              , TMUL unit maximum SIMD dimension, N (column bytes)
 
 # Leaf 1FH
 # Intel extended topology enumeration v2
@@ -733,9 +733,9 @@
 # Leaf 80000005H
 # AMD/Transmeta L1 cache and L1 TLB enumeration
 
-0x80000005,         0,  eax,     7:0,    l1_itlb_2m_4m_nentries , L1 ITLB #entires, 2M and 4M pages
+0x80000005,         0,  eax,     7:0,    l1_itlb_2m_4m_nentries , L1 ITLB #entries, 2M and 4M pages
 0x80000005,         0,  eax,    15:8,    l1_itlb_2m_4m_assoc    , L1 ITLB associativity, 2M and 4M pages
-0x80000005,         0,  eax,   23:16,    l1_dtlb_2m_4m_nentries , L1 DTLB #entires, 2M and 4M pages
+0x80000005,         0,  eax,   23:16,    l1_dtlb_2m_4m_nentries , L1 DTLB #entries, 2M and 4M pages
 0x80000005,         0,  eax,   31:24,    l1_dtlb_2m_4m_assoc    , L1 DTLB associativity, 2M and 4M pages
 0x80000005,         0,  ebx,     7:0,    l1_itlb_4k_nentries    , L1 ITLB #entries, 4K pages
 0x80000005,         0,  ebx,    15:8,    l1_itlb_4k_assoc       , L1 ITLB associativity, 4K pages
@@ -774,11 +774,11 @@
 # CPU power management (mostly AMD) and AMD RAS enumeration
 
 0x80000007,         0,  ebx,       0,    overflow_recov         , MCA overflow conditions not fatal
-0x80000007,         0,  ebx,       1,    succor                 , Software containment of UnCORRectable errors
+0x80000007,         0,  ebx,       1,    succor                 , Software containment of uncorrectable errors
 0x80000007,         0,  ebx,       2,    hw_assert              , Hardware assert MSRs
 0x80000007,         0,  ebx,       3,    smca                   , Scalable MCA (MCAX MSRs)
 0x80000007,         0,  ecx,    31:0,    cpu_pwr_sample_ratio   , CPU power sample time ratio
-0x80000007,         0,  edx,       0,    digital_temp           , Digital temprature sensor
+0x80000007,         0,  edx,       0,    digital_temp           , Digital temperature sensor
 0x80000007,         0,  edx,       1,    powernow_freq_id       , PowerNOW! frequency scaling
 0x80000007,         0,  edx,       2,    powernow_volt_id       , PowerNOW! voltage scaling
 0x80000007,         0,  edx,       3,    thermal_trip           , THERMTRIP (Thermal Trip)
@@ -821,7 +821,7 @@
 0x80000008,         0,  ebx,      23,    amd_ppin               , Protected Processor Inventory Number
 0x80000008,         0,  ebx,      24,    amd_ssbd               , Speculative Store Bypass Disable
 0x80000008,         0,  ebx,      25,    virt_ssbd              , virtualized SSBD (Speculative Store Bypass Disable)
-0x80000008,         0,  ebx,      26,    amd_ssb_no             , SSBD not needed (fixed in HW)
+0x80000008,         0,  ebx,      26,    amd_ssb_no             , SSBD is not needed (fixed in hardware)
 0x80000008,         0,  ebx,      27,    cppc                   , Collaborative Processor Performance Control
 0x80000008,         0,  ebx,      28,    amd_psfd               , Predictive Store Forward Disable
 0x80000008,         0,  ebx,      29,    btc_no                 , CPU not affected by Branch Type Confusion
@@ -849,7 +849,7 @@
 0x8000000a,         0,  edx,      10,    pausefilter            , Pause intercept filter
 0x8000000a,         0,  edx,      12,    pfthreshold            , Pause filter threshold
 0x8000000a,         0,  edx,      13,    avic                   , Advanced virtual interrupt controller
-0x8000000a,         0,  edx,      15,    v_vmsave_vmload        , Virtual VMSAVE/VMLOAD (nested virt)
+0x8000000a,         0,  edx,      15,    v_vmsave_vmload        , Virtual VMSAVE/VMLOAD (nested virtualization)
 0x8000000a,         0,  edx,      16,    vgif                   , Virtualize the Global Interrupt Flag
 0x8000000a,         0,  edx,      17,    gmet                   , Guest mode execution trap
 0x8000000a,         0,  edx,      18,    x2avic                 , Virtual x2APIC
@@ -861,7 +861,7 @@
 0x8000000a,         0,  edx,      25,    vnmi                   , NMI virtualization
 0x8000000a,         0,  edx,      26,    ibs_virt               , IBS Virtualization
 0x8000000a,         0,  edx,      27,    ext_lvt_off_chg        , Extended LVT offset fault change
-0x8000000a,         0,  edx,      28,    svme_addr_chk          , Guest SVME addr check
+0x8000000a,         0,  edx,      28,    svme_addr_chk          , Guest SVME address check
 
 # Leaf 80000019H
 # AMD TLB 1G-pages enumeration
@@ -902,20 +902,20 @@
 # AMD LWP (Lightweight Profiling)
 
 0x8000001c,         0,  eax,       0,    os_lwp_avail           , LWP is available to application programs (supported by OS)
-0x8000001c,         0,  eax,       1,    os_lpwval              , LWPVAL instruction (EventId=1) is supported by OS
-0x8000001c,         0,  eax,       2,    os_lwp_ire             , Instructions Retired Event (EventId=2) is supported by OS
-0x8000001c,         0,  eax,       3,    os_lwp_bre             , Branch Retired Event (EventId=3) is supported by OS
-0x8000001c,         0,  eax,       4,    os_lwp_dme             , DCache Miss Event (EventId=4) is supported by OS
-0x8000001c,         0,  eax,       5,    os_lwp_cnh             , CPU Clocks Not Halted event (EventId=5) is supported by OS
-0x8000001c,         0,  eax,       6,    os_lwp_rnh             , CPU Reference clocks Not Halted event (EventId=6) is supported by OS
+0x8000001c,         0,  eax,       1,    os_lpwval              , LWPVAL instruction is supported by OS
+0x8000001c,         0,  eax,       2,    os_lwp_ire             , Instructions Retired Event is supported by OS
+0x8000001c,         0,  eax,       3,    os_lwp_bre             , Branch Retired Event is supported by OS
+0x8000001c,         0,  eax,       4,    os_lwp_dme             , Dcache Miss Event is supported by OS
+0x8000001c,         0,  eax,       5,    os_lwp_cnh             , CPU Clocks Not Halted event is supported by OS
+0x8000001c,         0,  eax,       6,    os_lwp_rnh             , CPU Reference clocks Not Halted event is supported by OS
 0x8000001c,         0,  eax,      29,    os_lwp_cont            , LWP sampling in continuous mode is supported by OS
 0x8000001c,         0,  eax,      30,    os_lwp_ptsc            , Performance Time Stamp Counter in event records is supported by OS
 0x8000001c,         0,  eax,      31,    os_lwp_int             , Interrupt on threshold overflow is supported by OS
 0x8000001c,         0,  ebx,     7:0,    lwp_lwpcb_sz           , LWP Control Block size, in quadwords
 0x8000001c,         0,  ebx,    15:8,    lwp_event_sz           , LWP event record size, in bytes
-0x8000001c,         0,  ebx,   23:16,    lwp_max_events         , LWP max supported EventId value (EventID 255 not included)
+0x8000001c,         0,  ebx,   23:16,    lwp_max_events         , LWP max supported EventID value (EventID 255 not included)
 0x8000001c,         0,  ebx,   31:24,    lwp_event_offset       , LWP events area offset in the LWP Control Block
-0x8000001c,         0,  ecx,     4:0,    lwp_latency_max        , Num of bits in cache latency counters (10 to 31)
+0x8000001c,         0,  ecx,     4:0,    lwp_latency_max        , Number of bits in cache latency counters (10 to 31)
 0x8000001c,         0,  ecx,       5,    lwp_data_adddr         , Cache miss events report the data address of the reference
 0x8000001c,         0,  ecx,     8:6,    lwp_latency_rnd        , Amount by which cache latency is rounded
 0x8000001c,         0,  ecx,    15:9,    lwp_version            , LWP implementation version
@@ -924,16 +924,16 @@
 0x8000001c,         0,  ecx,      29,    lwp_ip_filtering       , IP filtering (IPI, IPF, BaseIP, and LimitIP @ LWPCP) supported
 0x8000001c,         0,  ecx,      30,    lwp_cache_levels       , Cache-related events can be filtered by cache level
 0x8000001c,         0,  ecx,      31,    lwp_cache_latency      , Cache-related events can be filtered by latency
-0x8000001c,         0,  edx,       0,    hw_lwp_avail           , LWP is available in Hardware
-0x8000001c,         0,  edx,       1,    hw_lpwval              , LWPVAL instruction (EventId=1) is available in HW
-0x8000001c,         0,  edx,       2,    hw_lwp_ire             , Instructions Retired Event (EventId=2) is available in HW
-0x8000001c,         0,  edx,       3,    hw_lwp_bre             , Branch Retired Event (EventId=3) is available in HW
-0x8000001c,         0,  edx,       4,    hw_lwp_dme             , DCache Miss Event (EventId=4) is available in HW
-0x8000001c,         0,  edx,       5,    hw_lwp_cnh             , CPU Clocks Not Halted event (EventId=5) is available in HW
-0x8000001c,         0,  edx,       6,    hw_lwp_rnh             , CPU Reference clocks Not Halted event (EventId=6) is available in HW
-0x8000001c,         0,  edx,      29,    hw_lwp_cont            , LWP sampling in continuous mode is available in HW
-0x8000001c,         0,  edx,      30,    hw_lwp_ptsc            , Performance Time Stamp Counter in event records is available in HW
-0x8000001c,         0,  edx,      31,    hw_lwp_int             , Interrupt on threshold overflow is available in HW
+0x8000001c,         0,  edx,       0,    hw_lwp_avail           , LWP is available in hardware
+0x8000001c,         0,  edx,       1,    hw_lpwval              , LWPVAL instruction is available in hardware
+0x8000001c,         0,  edx,       2,    hw_lwp_ire             , Instructions Retired Event is available in hardware
+0x8000001c,         0,  edx,       3,    hw_lwp_bre             , Branch Retired Event is available in hardware
+0x8000001c,         0,  edx,       4,    hw_lwp_dme             , Dcache Miss Event is available in hardware
+0x8000001c,         0,  edx,       5,    hw_lwp_cnh             , Clocks Not Halted event is available in hardware
+0x8000001c,         0,  edx,       6,    hw_lwp_rnh             , Reference clocks Not Halted event is available in hardware
+0x8000001c,         0,  edx,      29,    hw_lwp_cont            , LWP sampling in continuous mode is available in hardware
+0x8000001c,         0,  edx,      30,    hw_lwp_ptsc            , Performance Time Stamp Counter in event records is available in hardware
+0x8000001c,         0,  edx,      31,    hw_lwp_int             , Interrupt on threshold overflow is available in hardware
 
 # Leaf 8000001DH
 # AMD deterministic cache parameters
@@ -969,10 +969,10 @@
 0x8000001f,         0,  eax,       4,    sev_nested_paging      , SEV secure nested paging supported
 0x8000001f,         0,  eax,       5,    vm_permission_levels   , VMPL supported
 0x8000001f,         0,  eax,       6,    rpmquery               , RPMQUERY instruction supported
-0x8000001f,         0,  eax,       7,    vmpl_sss               , VMPL supervisor shadwo stack supported
+0x8000001f,         0,  eax,       7,    vmpl_sss               , VMPL supervisor shadow stack supported
 0x8000001f,         0,  eax,       8,    secure_tsc             , Secure TSC supported
 0x8000001f,         0,  eax,       9,    v_tsc_aux              , Hardware virtualizes TSC_AUX
-0x8000001f,         0,  eax,      10,    sme_coherent           , HW enforces cache coherency across encryption domains
+0x8000001f,         0,  eax,      10,    sme_coherent           , Cache coherency is enforced across encryption domains
 0x8000001f,         0,  eax,      11,    req_64bit_hypervisor   , SEV guest mandates 64-bit hypervisor
 0x8000001f,         0,  eax,      12,    restricted_injection   , Restricted Injection supported
 0x8000001f,         0,  eax,      13,    alternate_injection    , Alternate Injection supported
@@ -984,13 +984,13 @@
 0x8000001f,         0,  eax,      19,    virt_ibs               , IBS state virtualization is supported for SEV-ES guests
 0x8000001f,         0,  eax,      24,    vmsa_reg_protection    , VMSA register protection is supported
 0x8000001f,         0,  eax,      25,    smt_protection         , SMT protection is supported
-0x8000001f,         0,  eax,      28,    svsm_page_msr          , SVSM communication page MSR (0xc001f000h) is supported
+0x8000001f,         0,  eax,      28,    svsm_page_msr          , SVSM communication page MSR (0xc001f000) is supported
 0x8000001f,         0,  eax,      29,    nested_virt_snp_msr    , VIRT_RMPUPDATE/VIRT_PSMASH MSRs are supported
 0x8000001f,         0,  ebx,     5:0,    pte_cbit_pos           , PTE bit number used to enable memory encryption
 0x8000001f,         0,  ebx,    11:6,    phys_addr_reduction_nbits, Reduction of phys address space when encryption is enabled, in bits
 0x8000001f,         0,  ebx,   15:12,    vmpl_count             , Number of VM permission levels (VMPL) supported
 0x8000001f,         0,  ecx,    31:0,    enc_guests_max         , Max supported number of simultaneous encrypted guests
-0x8000001f,         0,  edx,    31:0,    min_sev_asid_no_sev_es , Mininum ASID for SEV-enabled SEV-ES-disabled guest
+0x8000001f,         0,  edx,    31:0,    min_sev_asid_no_sev_es , Minimum ASID for SEV-enabled SEV-ES-disabled guest
 
 # Leaf 80000020H
 # AMD Platform QoS extended feature IDs
@@ -999,6 +999,8 @@
 0x80000020,         0,  ebx,       2,    smba                   , Slow Memory Bandwidth Allocation support
 0x80000020,         0,  ebx,       3,    bmec                   , Bandwidth Monitoring Event Configuration support
 0x80000020,         0,  ebx,       4,    l3rr                   , L3 Range Reservation support
+0x80000020,         0,  ebx,       5,    abmc                   , Assignable Bandwidth Monitoring Counters
+0x80000020,         0,  ebx,       6,    sdciae                 , Smart Data Cache Injection (SDCI) Allocation Enforcement
 0x80000020,         1,  eax,    31:0,    mba_limit_len          , MBA enforcement limit size
 0x80000020,         1,  edx,    31:0,    mba_cos_max            , MBA max Class of Service number (zero-based)
 0x80000020,         2,  eax,    31:0,    smba_limit_len         , SMBA enforcement limit size
@@ -1023,12 +1025,21 @@
 0x80000021,         0,  eax,       7,    upper_addr_ignore      , EFER MSR Upper Address Ignore Enable bit supported
 0x80000021,         0,  eax,       8,    autoibrs               , EFER MSR Automatic IBRS enable bit supported
 0x80000021,         0,  eax,       9,    no_smm_ctl_msr         , SMM_CTL MSR (0xc0010116) is not present
-0x80000021,         0,  eax,      10,    fsrs_supported         , Fast Short Rep Stosb (FSRS) is supported
-0x80000021,         0,  eax,      11,    fsrc_supported         , Fast Short Repe Cmpsb (FSRC) is supported
+0x80000021,         0,  eax,      10,    fsrs_supported         , Fast Short Rep STOSB (FSRS) is supported
+0x80000021,         0,  eax,      11,    fsrc_supported         , Fast Short Rep CMPSB (FSRC) is supported
 0x80000021,         0,  eax,      13,    prefetch_ctl_msr       , Prefetch control MSR is supported
+0x80000021,         0,  eax,      16,    opcode_reclaim         , Reserves opcode space
 0x80000021,         0,  eax,      17,    user_cpuid_disable     , #GP when executing CPUID at CPL > 0 is supported
 0x80000021,         0,  eax,      18,    epsf_supported         , Enhanced Predictive Store Forwarding (EPSF) is supported
-0x80000021,         0,  ebx,    11:0,    microcode_patch_size   , Size of microcode patch, in 16-byte units
+0x80000021,         0,  eax,      22,    wl_feedback            , Workload-based heuristic feedback to OS
+0x80000021,         0,  eax,      24,    eraps_support          , Enhanced Return Address Predictor Security
+0x80000021,         0,  eax,      27,    sbpb                   , Support for the Selective Branch Predictor Barrier
+0x80000021,         0,  eax,      28,    ibpb_brtype            , Branch predictions flushed from CPU branch predictor
+0x80000021,         0,  eax,      29,    srso_no                , CPU is not subject to the SRSO vulnerability
+0x80000021,         0,  eax,      30,    srso_uk_no             , CPU is not vulnerable to SRSO at user-kernel boundary
+0x80000021,         0,  eax,      31,    srso_msr_fix           , Software may use MSR BP_CFG[BpSpecReduce] to mitigate SRSO
+0x80000021,         0,  ebx,    15:0,    microcode_patch_size   , Size of microcode patch, in 16-byte units
+0x80000021,         0,  ebx,   23:16,    rap_size               , Return Address Predictor size
 
 # Leaf 80000022H
 # AMD Performance Monitoring v2 enumeration
@@ -1036,7 +1047,7 @@
 0x80000022,         0,  eax,       0,    perfmon_v2             , Performance monitoring v2 supported
 0x80000022,         0,  eax,       1,    lbr_v2                 , Last Branch Record v2 extensions (LBR Stack)
 0x80000022,         0,  eax,       2,    lbr_pmc_freeze         , Freezing core performance counters / LBR Stack supported
-0x80000022,         0,  ebx,     3:0,    n_pmc_core             , Number of core perfomance counters
+0x80000022,         0,  ebx,     3:0,    n_pmc_core             , Number of core performance counters
 0x80000022,         0,  ebx,     9:4,    lbr_v2_stack_size      , Number of available LBR stack entries
 0x80000022,         0,  ebx,   15:10,    n_pmc_northbridge      , Number of available northbridge (data fabric) performance counters
 0x80000022,         0,  ebx,   21:16,    n_pmc_umc              , Number of available UMC performance counters
@@ -1046,7 +1057,7 @@
 # AMD Secure Multi-key Encryption enumeration
 
 0x80000023,         0,  eax,       0,    mem_hmk_mode           , MEM-HMK encryption mode is supported
-0x80000023,         0,  ebx,    15:0,    mem_hmk_avail_keys     , MEM-HMK mode: total num of available encryption keys
+0x80000023,         0,  ebx,    15:0,    mem_hmk_avail_keys     , MEM-HMK mode: total number of available encryption keys
 
 # Leaf 80000026H
 # AMD extended topology enumeration v2
@@ -1134,7 +1145,7 @@
 
 0x80860007,         0,  eax,    31:0,    cpu_cur_mhz            , Current CPU frequency, in MHz
 0x80860007,         0,  ebx,    31:0,    cpu_cur_voltage        , Current CPU voltage, in millivolts
-0x80860007,         0,  ecx,    31:0,    cpu_cur_perf_pctg      , Current CPU performance percentage, 0 - 100d
+0x80860007,         0,  ecx,    31:0,    cpu_cur_perf_pctg      , Current CPU performance percentage, 0 - 100
 0x80860007,         0,  edx,    31:0,    cpu_cur_gate_delay     , Current CPU gate delay, in femtoseconds
 
 # Leaf C0000000H

