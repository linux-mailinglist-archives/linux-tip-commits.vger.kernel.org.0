Return-Path: <linux-tip-commits+bounces-1914-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EF59458C9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5201C239D1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA91C231E;
	Fri,  2 Aug 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJ28N6/Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EATeTn6S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F85481AA;
	Fri,  2 Aug 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583731; cv=none; b=L4pGr8UKhC/mWGTTboO/ky8ijCfRjTuDT9e6zF5x6ks79cqii8aiBj92LOh+yqcrimwix/rImsZfyHnkW8Q9tab1FrVly7AJV2fDyZ0shAK25ESpcdWpZ8zjfyyllAQmPa8qAt4C37WZ55RvGnW+1DamiAqIe478g+KaLsUNLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583731; c=relaxed/simple;
	bh=Nr/CX2Pi+Esz70qISlMY7ezUjj6M/56JZtZsThpkrzs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RtA/PKOM+ZLNWirzRWOdP89nA0GS+QnKbehjccRgy7VdOfqu55ozVwXPoudanubeBnSEKkpYB9+SS5kEBQJFJusgWfiBHdbttIPrKg0/JjS01W/9hx74byzHvW2CmdLEbzxSgTG3UVeGNIQfpT7F623+/YK3DoQenny6Q9arxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJ28N6/Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EATeTn6S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2Cal6j6ppV+OT9jw+jvk5Y4Jo9XOnn+ElTt83pdZUo=;
	b=JJ28N6/YL/0FkBIToWxccC21rQVWmkRR7/Rb4RzRwsnDdAuYLVa3Dnb+ZPJa4CIgcvQGAe
	j8r3No1zUr8FArBHCtMsZU9oP1CzxR9uOsbhIiGOugQ8pcTK4dSCnoEGeNMUEG534pzMAC
	n/WGBymRgb5BlI02UYNQka/Kv6nZ2xH4huzWSxzCOqb5x/8K8pSRtFsbbF8FmklOfonrLQ
	klNRxczJd5OFBquuUHDcgXQ9Kep/1dWW0SAe1eR6th5xR/p0qf+dmB7BCm+XsbBCV77L4b
	yUDuxdKOmPPK3MJKa/AJoTAAdlingv4cy4g76bEvMFnEswGCgRvz5gT6PZ5HXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2Cal6j6ppV+OT9jw+jvk5Y4Jo9XOnn+ElTt83pdZUo=;
	b=EATeTn6SrUikut5tBGRzKSF6Ogtdyuytr3Fl59WaQuAuBwJ3Gm0YyekNaA3UQnQKnCtGsv
	DULp5hL0MqIrK5CQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Introduce a complete cpuid
 bitfields CSV file
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-9-darwi@linutronix.de>
References: <20240718134755.378115-9-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372439.2215.9683760156253591275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     cbbd847d107fb750e62670d0f205a7f58b36f893
Gitweb:        https://git.kernel.org/tip/cbbd847d107fb750e62670d0f205a7f58b3=
6f893
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:19 +02:00

tools/x86/kcpuid: Introduce a complete cpuid bitfields CSV file

For parsing the cpuid bitfields, kcpuid uses an incomplete CSV file with
300+ bitfields.

Use an auto-generated CSV file from the x86-cpuid.org project instead.
It provides complete bitfields coverage: 830+ bitfields, all with proper
descriptions.

The auto-generated file has the following blurb automatically added:

   # SPDX-License-Identifier: CC0-1.0
   # Generator: x86-cpuid-db v1.0

The generator tag includes the project's workspace "git describe"
version string.  It is intended for projects like KernelCI, to aid in
verifying that the auto-generated files have not been tampered with.

The file also has the blurb:

   # Auto-generated file.
   # Please submit all updates and bugfixes to https://x86-cpuid.org

It's thus kindly requested that the Linux kernel's x86 tree maintainers
enforce sending all updates to x86-cpuid.org's upstream database first,
thus benefiting the whole ecosystem.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v1.0/LICENSE.rst
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db
Link: https://lore.kernel.org/all/20240718134755.378115-9-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/cpuid.csv | 1430 +++++++++++++++++++++---------
 1 file changed, 1016 insertions(+), 414 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index e0c25b7..d751eb8 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,451 +1,1053 @@
-# The basic row format is:
-# LEAF, SUBLEAF, register_name, bits, short_name, long_description
-
-# Leaf 00H
-         0,    0,  EAX,   31:0, max_basic_leafs, Max input value for support=
ed subleafs
-
-# Leaf 01H
-         1,    0,  EAX,    3:0, stepping, Stepping ID
-         1,    0,  EAX,    7:4, model, Model
-         1,    0,  EAX,   11:8, family, Family ID
-         1,    0,  EAX,  13:12, processor, Processor Type
-         1,    0,  EAX,  19:16, model_ext, Extended Model ID
-         1,    0,  EAX,  27:20, family_ext, Extended Family ID
-
-         1,    0,  EBX,    7:0, brand, Brand Index
-         1,    0,  EBX,   15:8, clflush_size, CLFLUSH line size (value * 8) =
in bytes
-         1,    0,  EBX,  23:16, max_cpu_id, Maxim number of addressable logi=
c cpu in this package
-         1,    0,  EBX,  31:24, apic_id, Initial APIC ID
-
-         1,    0,  ECX,      0, sse3, Streaming SIMD Extensions 3(SSE3)
-         1,    0,  ECX,      1, pclmulqdq, PCLMULQDQ instruction supported
-         1,    0,  ECX,      2, dtes64, DS area uses 64-bit layout
-         1,    0,  ECX,      3, mwait, MONITOR/MWAIT supported
-         1,    0,  ECX,      4, ds_cpl, CPL Qualified Debug Store which allo=
ws for branch message storage qualified by CPL
-         1,    0,  ECX,      5, vmx, Virtual Machine Extensions supported
-         1,    0,  ECX,      6, smx, Safer Mode Extension supported
-         1,    0,  ECX,      7, eist, Enhanced Intel SpeedStep Technology
-         1,    0,  ECX,      8, tm2, Thermal Monitor 2
-         1,    0,  ECX,      9, ssse3, Supplemental Streaming SIMD Extension=
s 3 (SSSE3)
-         1,    0,  ECX,     10, l1_ctx_id, L1 data cache could be set to eit=
her adaptive mode or shared mode (check IA32_MISC_ENABLE bit 24 definition)
-         1,    0,  ECX,     11, sdbg, IA32_DEBUG_INTERFACE MSR for silicon d=
ebug supported
-         1,    0,  ECX,     12, fma, FMA extensions using YMM state supported
-         1,    0,  ECX,     13, cmpxchg16b, 'CMPXCHG16B - Compare and Exchan=
ge Bytes' supported
-         1,    0,  ECX,     14, xtpr_update, xTPR Update Control supported
-         1,    0,  ECX,     15, pdcm, Perfmon and Debug Capability present
-         1,    0,  ECX,     17, pcid, Process-Context Identifiers feature pr=
esent
-         1,    0,  ECX,     18, dca, Prefetching data from a memory mapped d=
evice supported
-         1,    0,  ECX,     19, sse4_1, SSE4.1 feature present
-         1,    0,  ECX,     20, sse4_2, SSE4.2 feature present
-         1,    0,  ECX,     21, x2apic, x2APIC supported
-         1,    0,  ECX,     22, movbe, MOVBE instruction supported
-         1,    0,  ECX,     23, popcnt, POPCNT instruction supported
-         1,    0,  ECX,     24, tsc_deadline_timer, LAPIC supports one-shot =
operation using a TSC deadline value
-         1,    0,  ECX,     25, aesni, AESNI instruction supported
-         1,    0,  ECX,     26, xsave, XSAVE/XRSTOR processor extended state=
s (XSETBV/XGETBV/XCR0)
-         1,    0,  ECX,     27, osxsave, OS has set CR4.OSXSAVE bit to enabl=
e XSETBV/XGETBV/XCR0
-         1,    0,  ECX,     28, avx, AVX instruction supported
-         1,    0,  ECX,     29, f16c, 16-bit floating-point conversion instr=
uction supported
-         1,    0,  ECX,     30, rdrand, RDRAND instruction supported
-
-         1,    0,  EDX,      0, fpu, x87 FPU on chip
-         1,    0,  EDX,      1, vme, Virtual-8086 Mode Enhancement
-         1,    0,  EDX,      2, de, Debugging Extensions
-         1,    0,  EDX,      3, pse, Page Size Extensions
-         1,    0,  EDX,      4, tsc, Time Stamp Counter
-         1,    0,  EDX,      5, msr, RDMSR and WRMSR Support
-         1,    0,  EDX,      6, pae, Physical Address Extensions
-         1,    0,  EDX,      7, mce, Machine Check Exception
-         1,    0,  EDX,      8, cx8, CMPXCHG8B instr
-         1,    0,  EDX,      9, apic, APIC on Chip
-         1,    0,  EDX,     11, sep, SYSENTER and SYSEXIT instrs
-         1,    0,  EDX,     12, mtrr, Memory Type Range Registers
-         1,    0,  EDX,     13, pge, Page Global Bit
-         1,    0,  EDX,     14, mca, Machine Check Architecture
-         1,    0,  EDX,     15, cmov, Conditional Move Instrs
-         1,    0,  EDX,     16, pat, Page Attribute Table
-         1,    0,  EDX,     17, pse36, 36-Bit Page Size Extension
-         1,    0,  EDX,     18, psn, Processor Serial Number
-         1,    0,  EDX,     19, clflush, CLFLUSH instr
-#         1,    0,  EDX,     20,
-         1,    0,  EDX,     21, ds, Debug Store
-         1,    0,  EDX,     22, acpi, Thermal Monitor and Software Controlle=
d Clock Facilities
-         1,    0,  EDX,     23, mmx, Intel MMX Technology
-         1,    0,  EDX,     24, fxsr, XSAVE and FXRSTOR Instrs
-         1,    0,  EDX,     25, sse, SSE
-         1,    0,  EDX,     26, sse2, SSE2
-         1,    0,  EDX,     27, ss, Self Snoop
-         1,    0,  EDX,     28, hit, Max APIC IDs
-         1,    0,  EDX,     29, tm, Thermal Monitor
-#         1,    0,  EDX,     30,
-         1,    0,  EDX,     31, pbe, Pending Break Enable
-
-# Leaf 02H
-# cache and TLB descriptor info
-
-# Leaf 03H
-# Precessor Serial Number, introduced on Pentium III, not valid for
-# latest models
-
-# Leaf 04H
-# thread/core and cache topology
-         4,    0,  EAX,    4:0, cache_type, Cache type like instr/data or un=
ified
-         4,    0,  EAX,    7:5, cache_level, Cache Level (starts at 1)
-         4,    0,  EAX,      8, cache_self_init, Cache Self Initialization
-         4,    0,  EAX,      9, fully_associate, Fully Associative cache
-#         4,    0,  EAX,  13:10, resvd, resvd
-         4,    0,  EAX,  25:14, max_logical_id, Max number of addressable ID=
s for logical processors sharing the cache
-         4,    0,  EAX,  31:26, max_phy_id, Max number of addressable IDs fo=
r processors in phy package
-
-         4,    0,  EBX,   11:0, cache_linesize, Size of a cache line in bytes
-         4,    0,  EBX,  21:12, cache_partition, Physical Line partitions
-         4,    0,  EBX,  31:22, cache_ways, Ways of associativity
-         4,    0,  ECX,   31:0, cache_sets, Number of Sets - 1
-         4,    0,  EDX,      0, c_wbinvd, 1 means WBINVD/INVD is not ganrant=
eed to act upon lower level caches of non-originating threads sharing this ca=
che
-         4,    0,  EDX,      1, c_incl, Whether cache is inclusive of lower =
cache level
-         4,    0,  EDX,      2, c_comp_index, Complex Cache Indexing
-
-# Leaf 05H
-# MONITOR/MWAIT
-	 5,    0,  EAX,   15:0, min_mon_size, Smallest monitor line size in bytes
-	 5,    0,  EBX,   15:0, max_mon_size, Largest monitor line size in bytes
-	 5,    0,  ECX,      0, mwait_ext, Enum of Monitor-Mwait extensions support=
ed
-	 5,    0,  ECX,      1, mwait_irq_break, Largest monitor line size in bytes
-	 5,    0,  EDX,    3:0, c0_sub_stats, Number of C0* sub C-states supported =
using MWAIT
-	 5,    0,  EDX,    7:4, c1_sub_stats, Number of C1* sub C-states supported =
using MWAIT
-	 5,    0,  EDX,   11:8, c2_sub_stats, Number of C2* sub C-states supported =
using MWAIT
-	 5,    0,  EDX,  15:12, c3_sub_stats, Number of C3* sub C-states supported =
using MWAIT
-	 5,    0,  EDX,  19:16, c4_sub_stats, Number of C4* sub C-states supported =
using MWAIT
-	 5,    0,  EDX,  23:20, c5_sub_stats, Number of C5* sub C-states supported =
using MWAIT
-	 5,    0,  EDX,  27:24, c6_sub_stats, Number of C6* sub C-states supported =
using MWAIT
-	 5,    0,  EDX,  31:28, c7_sub_stats, Number of C7* sub C-states supported =
using MWAIT
-
-# Leaf 06H
-# Thermal & Power Management
-
-	 6,    0,  EAX,      0, dig_temp, Digital temperature sensor supported
-	 6,    0,  EAX,      1, turbo, Intel Turbo Boost
-	 6,    0,  EAX,      2, arat, Always running APIC timer
-#	 6,    0,  EAX,      3, resv, Reserved
-	 6,    0,  EAX,      4, pln, Power limit notifications supported
-	 6,    0,  EAX,      5, ecmd, Clock modulation duty cycle extension support=
ed
-	 6,    0,  EAX,      6, ptm, Package thermal management supported
-	 6,    0,  EAX,      7, hwp, HWP base register
-	 6,    0,  EAX,      8, hwp_notify, HWP notification
-	 6,    0,  EAX,      9, hwp_act_window, HWP activity window
-	 6,    0,  EAX,     10, hwp_energy, HWP energy performance preference
-	 6,    0,  EAX,     11, hwp_pkg_req, HWP package level request
-#	 6,    0,  EAX,     12, resv, Reserved
-	 6,    0,  EAX,     13, hdc, HDC base registers supported
-	 6,    0,  EAX,     14, turbo3, Turbo Boost Max 3.0
-	 6,    0,  EAX,     15, hwp_cap, Highest Performance change supported
-	 6,    0,  EAX,     16, hwp_peci, HWP PECI override is supported
-	 6,    0,  EAX,     17, hwp_flex, Flexible HWP is supported
-	 6,    0,  EAX,     18, hwp_fast, Fast access mode for the IA32_HWP_REQUEST=
 MSR is supported
-#	 6,    0,  EAX,     19, resv, Reserved
-	 6,    0,  EAX,     20, hwp_ignr, Ignoring Idle Logical Processor HWP reque=
st is supported
-
-	 6,    0,  EBX,    3:0, therm_irq_thresh, Number of Interrupt Thresholds in=
 Digital Thermal Sensor
-	 6,    0,  ECX,      0, aperfmperf, Presence of IA32_MPERF and IA32_APERF
-	 6,    0,  ECX,      3, energ_bias, Performance-energy bias preference supp=
orted
-
-# Leaf 07H
-#	ECX =3D=3D 0
-# AVX512 refers to https://en.wikipedia.org/wiki/AVX-512
-# XXX: Do we really need to enumerate each and every AVX512 sub features
-
-	 7,    0,  EBX,      0, fsgsbase, RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE suppo=
rted
-	 7,    0,  EBX,      1, tsc_adjust, TSC_ADJUST MSR supported
-	 7,    0,  EBX,      2, sgx, Software Guard Extensions
-	 7,    0,  EBX,      3, bmi1, BMI1
-	 7,    0,  EBX,      4, hle, Hardware Lock Elision
-	 7,    0,  EBX,      5, avx2, AVX2
-#	 7,    0,  EBX,      6, fdp_excp_only, x87 FPU Data Pointer updated only o=
n x87 exceptions
-	 7,    0,  EBX,      7, smep, Supervisor-Mode Execution Prevention
-	 7,    0,  EBX,      8, bmi2, BMI2
-	 7,    0,  EBX,      9, rep_movsb, Enhanced REP MOVSB/STOSB
-	 7,    0,  EBX,     10, invpcid, INVPCID instruction
-	 7,    0,  EBX,     11, rtm, Restricted Transactional Memory
-	 7,    0,  EBX,     12, rdt_m, Intel RDT Monitoring capability
-	 7,    0,  EBX,     13, depc_fpu_cs_ds, Deprecates FPU CS and FPU DS
-	 7,    0,  EBX,     14, mpx, Memory Protection Extensions
-	 7,    0,  EBX,     15, rdt_a, Intel RDT Allocation capability
-	 7,    0,  EBX,     16, avx512f, AVX512 Foundation instr
-	 7,    0,  EBX,     17, avx512dq, AVX512 Double and Quadword AVX512 instr
-	 7,    0,  EBX,     18, rdseed, RDSEED instr
-	 7,    0,  EBX,     19, adx, ADX instr
-	 7,    0,  EBX,     20, smap, Supervisor Mode Access Prevention
-	 7,    0,  EBX,     21, avx512ifma, AVX512 Integer Fused Multiply Add
-#	 7,    0,  EBX,     22, resvd, resvd
-	 7,    0,  EBX,     23, clflushopt, CLFLUSHOPT instr
-	 7,    0,  EBX,     24, clwb, CLWB instr
-	 7,    0,  EBX,     25, intel_pt, Intel Processor Trace instr
-	 7,    0,  EBX,     26, avx512pf, Prefetch
-	 7,    0,  EBX,     27, avx512er, AVX512 Exponent Reciproca instr
-	 7,    0,  EBX,     28, avx512cd, AVX512 Conflict Detection instr
-	 7,    0,  EBX,     29, sha, Intel Secure Hash Algorithm Extensions instr
-	 7,    0,  EBX,     30, avx512bw, AVX512 Byte & Word instr
-	 7,    0,  EBX,     31, avx512vl, AVX512 Vector Length Extentions (VL)
-	 7,    0,  ECX,      0, prefetchwt1, X
-	 7,    0,  ECX,      1, avx512vbmi, AVX512 Vector Byte Manipulation Instruc=
tions
-	 7,    0,  ECX,      2, umip, User-mode Instruction Prevention
-
-	 7,    0,  ECX,      3, pku, Protection Keys for User-mode pages
-	 7,    0,  ECX,      4, ospke, CR4 PKE set to enable protection keys
-#	 7,    0,  ECX,   16:5, resvd, resvd
-	 7,    0,  ECX,  21:17, mawau, The value of MAWAU used by the BNDLDX and BN=
DSTX instructions in 64-bit mode
-	 7,    0,  ECX,     22, rdpid, RDPID and IA32_TSC_AUX
-#	 7,    0,  ECX,  29:23, resvd, resvd
-	 7,    0,  ECX,     30, sgx_lc, SGX Launch Configuration
-#	 7,    0,  ECX,     31, resvd, resvd
-
-# Leaf 08H
-#
-
-
-# Leaf 09H
-# Direct Cache Access (DCA) information
-	 9,    0,  ECX,   31:0, dca_cap, The value of IA32_PLATFORM_DCA_CAP
+# SPDX-License-Identifier: CC0-1.0
+# Generator: x86-cpuid-db v1.0
=20
-# Leaf 0AH
-# Architectural Performance Monitoring
 #
-# Do we really need to print out the PMU related stuff?
-# Does normal user really care about it?
+# Auto-generated file.
+# Please submit all updates and bugfixes to https://x86-cpuid.org
 #
-       0xA,    0,  EAX,    7:0, pmu_ver, Performance Monitoring Unit version
-       0xA,    0,  EAX,   15:8, pmu_gp_cnt_num, Numer of general-purose PMU =
counters per logical CPU
-       0xA,    0,  EAX,  23:16, pmu_cnt_bits, Bit wideth of PMU counter
-       0xA,    0,  EAX,  31:24, pmu_ebx_bits, Length of EBX bit vector to en=
umerate PMU events
-
-       0xA,    0,  EBX,      0, pmu_no_core_cycle_evt, Core cycle event not =
available
-       0xA,    0,  EBX,      1, pmu_no_instr_ret_evt, Instruction retired ev=
ent not available
-       0xA,    0,  EBX,      2, pmu_no_ref_cycle_evt, Reference cycles event=
 not available
-       0xA,    0,  EBX,      3, pmu_no_llc_ref_evt, Last-level cache referen=
ce event not available
-       0xA,    0,  EBX,      4, pmu_no_llc_mis_evt, Last-level cache misses =
event not available
-       0xA,    0,  EBX,      5, pmu_no_br_instr_ret_evt, Branch instruction =
retired event not available
-       0xA,    0,  EBX,      6, pmu_no_br_mispredict_evt, Branch mispredict =
retired event not available
-
-       0xA,    0,  ECX,    4:0, pmu_fixed_cnt_num, Performance Monitoring Un=
it version
-       0xA,    0,  ECX,   12:5, pmu_fixed_cnt_bits, Numer of PMU counters pe=
r logical CPU
-
-# Leaf 0BH
-# Extended Topology Enumeration Leaf
-#
-
-       0xB,    0,  EAX,    4:0, id_shift, Number of bits to shift right on x=
2APIC ID to get a unique topology ID of the next level type
-       0xB,    0,  EBX,   15:0, cpu_nr, Number of logical processors at this=
 level type
-       0xB,    0,  ECX,   15:8, lvl_type, 0-Invalid 1-SMT 2-Core
-       0xB,    0,  EDX,   31:0, x2apic_id, x2APIC ID the current logical pro=
cessor
-
-
-# Leaf 0DH
-# Processor Extended State
=20
-       0xD,    0,  EAX,      0, x87, X87 state
-       0xD,    0,  EAX,      1, sse, SSE state
-       0xD,    0,  EAX,      2, avx, AVX state
-       0xD,    0,  EAX,    4:3, mpx, MPX state
-       0xD,    0,  EAX,    7:5, avx512, AVX-512 state
-       0xD,    0,  EAX,      9, pkru, PKRU state
-
-       0xD,    0,  EBX,   31:0, max_sz_xcr0, Maximum size (bytes) required b=
y enabled features in XCR0
-       0xD,    0,  ECX,   31:0, max_sz_xsave, Maximum size (bytes) of the XS=
AVE/XRSTOR save area
-
-       0xD,    1,  EAX,      0, xsaveopt, XSAVEOPT available
-       0xD,    1,  EAX,      1, xsavec, XSAVEC and compacted form supported
-       0xD,    1,  EAX,      2, xgetbv, XGETBV supported
-       0xD,    1,  EAX,      3, xsaves, XSAVES/XRSTORS and IA32_XSS supported
-
-       0xD,    1,  EBX,   31:0, max_sz_xcr0, Maximum size (bytes) required b=
y enabled features in XCR0
-       0xD,    1,  ECX,      8, pt, PT state
-       0xD,    1,  ECX,      11, cet_usr, CET user state
-       0xD,    1,  ECX,      12, cet_supv, CET supervisor state
-       0xD,    1,  ECX,      13, hdc, HDC state
-       0xD,    1,  ECX,      16, hwp, HWP state
-
-# Leaf 0FH
-# Intel RDT Monitoring
-
-       0xF,    0,  EBX,   31:0, rmid_range, Maximum range (zero-based) of RM=
ID within this physical processor of all types
-       0xF,    0,  EDX,      1, l3c_rdt_mon, L3 Cache RDT Monitoring support=
ed
-
-       0xF,    1,  ECX,   31:0, rmid_range, Maximum range (zero-based) of RM=
ID of this types
-       0xF,    1,  EDX,      0, l3c_ocp_mon, L3 Cache occupancy Monitoring s=
upported
-       0xF,    1,  EDX,      1, l3c_tbw_mon, L3 Cache Total Bandwidth Monito=
ring supported
-       0xF,    1,  EDX,      2, l3c_lbw_mon, L3 Cache Local Bandwidth Monito=
ring supported
+# The basic row format is:
+#     LEAF, SUBLEAVES,  reg,    bits,    short_name             , long_descr=
iption
+
+# Leaf 0H
+# Maximum standard leaf number + CPU vendor string
+
+         0,         0,  eax,    31:0,    max_std_leaf           , Highest cp=
uid standard leaf supported
+         0,         0,  ebx,    31:0,    cpu_vendorid_0         , CPU vendor=
 ID string bytes 0 - 3
+         0,         0,  ecx,    31:0,    cpu_vendorid_2         , CPU vendor=
 ID string bytes 8 - 11
+         0,         0,  edx,    31:0,    cpu_vendorid_1         , CPU vendor=
 ID string bytes 4 - 7
+
+# Leaf 1H
+# CPU FMS (Family/Model/Stepping) + standard feature flags
+
+         1,         0,  eax,     3:0,    stepping               , Stepping ID
+         1,         0,  eax,     7:4,    base_model             , Base CPU m=
odel ID
+         1,         0,  eax,    11:8,    base_family_id         , Base CPU f=
amily ID
+         1,         0,  eax,   13:12,    cpu_type               , CPU type
+         1,         0,  eax,   19:16,    ext_model              , Extended C=
PU model ID
+         1,         0,  eax,   27:20,    ext_family             , Extended C=
PU family ID
+         1,         0,  ebx,     7:0,    brand_id               , Brand index
+         1,         0,  ebx,    15:8,    clflush_size           , CLFLUSH in=
struction cache line size
+         1,         0,  ebx,   23:16,    n_logical_cpu          , Logical CP=
U (HW threads) count
+         1,         0,  ebx,   31:24,    local_apic_id          , Initial lo=
cal APIC physical ID
+         1,         0,  ecx,       0,    pni                    , Streaming =
SIMD Extensions 3 (SSE3)
+         1,         0,  ecx,       1,    pclmulqdq              , PCLMULQDQ =
instruction support
+         1,         0,  ecx,       2,    dtes64                 , 64-bit DS =
save area
+         1,         0,  ecx,       3,    monitor                , MONITOR/MW=
AIT support
+         1,         0,  ecx,       4,    ds_cpl                 , CPL Qualif=
ied Debug Store
+         1,         0,  ecx,       5,    vmx                    , Virtual Ma=
chine Extensions
+         1,         0,  ecx,       6,    smx                    , Safer Mode=
 Extensions
+         1,         0,  ecx,       7,    est                    , Enhanced I=
ntel SpeedStep
+         1,         0,  ecx,       8,    tm2                    , Thermal Mo=
nitor 2
+         1,         0,  ecx,       9,    ssse3                  , Supplement=
al SSE3
+         1,         0,  ecx,      10,    cid                    , L1 Context=
 ID
+         1,         0,  ecx,      11,    sdbg                   , Sillicon D=
ebug
+         1,         0,  ecx,      12,    fma                    , FMA extens=
ions using YMM state
+         1,         0,  ecx,      13,    cx16                   , CMPXCHG16B=
 instruction support
+         1,         0,  ecx,      14,    xtpr                   , xTPR Updat=
e Control
+         1,         0,  ecx,      15,    pdcm                   , Perfmon an=
d Debug Capability
+         1,         0,  ecx,      17,    pcid                   , Process-co=
ntext identifiers
+         1,         0,  ecx,      18,    dca                    , Direct Cac=
he Access
+         1,         0,  ecx,      19,    sse4_1                 , SSE4.1
+         1,         0,  ecx,      20,    sse4_2                 , SSE4.2
+         1,         0,  ecx,      21,    x2apic                 , X2APIC sup=
port
+         1,         0,  ecx,      22,    movbe                  , MOVBE inst=
ruction support
+         1,         0,  ecx,      23,    popcnt                 , POPCNT ins=
truction support
+         1,         0,  ecx,      24,    tsc_deadline_timer     , APIC timer=
 one-shot operation
+         1,         0,  ecx,      25,    aes                    , AES instru=
ctions
+         1,         0,  ecx,      26,    xsave                  , XSAVE (and=
 related instructions) support
+         1,         0,  ecx,      27,    osxsave                , XSAVE (and=
 related instructions) are enabled by OS
+         1,         0,  ecx,      28,    avx                    , AVX instru=
ctions support
+         1,         0,  ecx,      29,    f16c                   , Half-preci=
sion floating-point conversion support
+         1,         0,  ecx,      30,    rdrand                 , RDRAND ins=
truction support
+         1,         0,  ecx,      31,    guest_status           , System is =
running as guest; (para-)virtualized system
+         1,         0,  edx,       0,    fpu                    , Floating-P=
oint Unit on-chip (x87)
+         1,         0,  edx,       1,    vme                    , Virtual-80=
86 Mode Extensions
+         1,         0,  edx,       2,    de                     , Debugging =
Extensions
+         1,         0,  edx,       3,    pse                    , Page Size =
Extension
+         1,         0,  edx,       4,    tsc                    , Time Stamp=
 Counter
+         1,         0,  edx,       5,    msr                    , Model-Spec=
ific Registers (RDMSR and WRMSR support)
+         1,         0,  edx,       6,    pae                    , Physical A=
ddress Extensions
+         1,         0,  edx,       7,    mce                    , Machine Ch=
eck Exception
+         1,         0,  edx,       8,    cx8                    , CMPXCHG8B =
instruction
+         1,         0,  edx,       9,    apic                   , APIC on-ch=
ip
+         1,         0,  edx,      11,    sep                    , SYSENTER, =
SYSEXIT, and associated MSRs
+         1,         0,  edx,      12,    mtrr                   , Memory Typ=
e Range Registers
+         1,         0,  edx,      13,    pge                    , Page Globa=
l Extensions
+         1,         0,  edx,      14,    mca                    , Machine Ch=
eck Architecture
+         1,         0,  edx,      15,    cmov                   , Conditiona=
l Move Instruction
+         1,         0,  edx,      16,    pat                    , Page Attri=
bute Table
+         1,         0,  edx,      17,    pse36                  , Page Size =
Extension (36-bit)
+         1,         0,  edx,      18,    pn                     , Processor =
Serial Number
+         1,         0,  edx,      19,    clflush                , CLFLUSH in=
struction
+         1,         0,  edx,      21,    dts                    , Debug Store
+         1,         0,  edx,      22,    acpi                   , Thermal mo=
nitor and clock control
+         1,         0,  edx,      23,    mmx                    , MMX instru=
ctions
+         1,         0,  edx,      24,    fxsr                   , FXSAVE and=
 FXRSTOR instructions
+         1,         0,  edx,      25,    sse                    , SSE instru=
ctions
+         1,         0,  edx,      26,    sse2                   , SSE2 instr=
uctions
+         1,         0,  edx,      27,    ss                     , Self Snoop
+         1,         0,  edx,      28,    ht                     , Hyper-thre=
ading
+         1,         0,  edx,      29,    tm                     , Thermal Mo=
nitor
+         1,         0,  edx,      30,    ia64                   , Legacy IA-=
64 (Itanium) support bit, now resreved
+         1,         0,  edx,      31,    pbe                    , Pending Br=
eak Enable
+
+# Leaf 2H
+# Intel cache and TLB information one-byte descriptors
+
+         2,         0,  eax,     7:0,    iteration_count        , Number of =
times this CPUD leaf must be queried
+         2,         0,  eax,    15:8,    desc1                  , Descriptor=
 #1
+         2,         0,  eax,   23:16,    desc2                  , Descriptor=
 #2
+         2,         0,  eax,   30:24,    desc3                  , Descriptor=
 #3
+         2,         0,  eax,      31,    eax_invalid            , Descriptor=
s 1-3 are invalid if set
+         2,         0,  ebx,     7:0,    desc4                  , Descriptor=
 #4
+         2,         0,  ebx,    15:8,    desc5                  , Descriptor=
 #5
+         2,         0,  ebx,   23:16,    desc6                  , Descriptor=
 #6
+         2,         0,  ebx,   30:24,    desc7                  , Descriptor=
 #7
+         2,         0,  ebx,      31,    ebx_invalid            , Descriptor=
s 4-7 are invalid if set
+         2,         0,  ecx,     7:0,    desc8                  , Descriptor=
 #8
+         2,         0,  ecx,    15:8,    desc9                  , Descriptor=
 #9
+         2,         0,  ecx,   23:16,    desc10                 , Descriptor=
 #10
+         2,         0,  ecx,   30:24,    desc11                 , Descriptor=
 #11
+         2,         0,  ecx,      31,    ecx_invalid            , Descriptor=
s 8-11 are invalid if set
+         2,         0,  edx,     7:0,    desc12                 , Descriptor=
 #12
+         2,         0,  edx,    15:8,    desc13                 , Descriptor=
 #13
+         2,         0,  edx,   23:16,    desc14                 , Descriptor=
 #14
+         2,         0,  edx,   30:24,    desc15                 , Descriptor=
 #15
+         2,         0,  edx,      31,    edx_invalid            , Descriptor=
s 12-15 are invalid if set
+
+# Leaf 4H
+# Intel deterministic cache parameters
+
+         4,      31:0,  eax,     4:0,    cache_type             , Cache type=
 field
+         4,      31:0,  eax,     7:5,    cache_level            , Cache leve=
l (1-based)
+         4,      31:0,  eax,       8,    cache_self_init        , Self-initi=
alializing cache level
+         4,      31:0,  eax,       9,    fully_associative      , Fully-asso=
ciative cache
+         4,      31:0,  eax,   25:14,    num_threads_sharing    , Number log=
ical CPUs sharing this cache
+         4,      31:0,  eax,   31:26,    num_cores_on_die       , Number of =
cores in the physical package
+         4,      31:0,  ebx,    11:0,    cache_linesize         , System coh=
erency line size (0-based)
+         4,      31:0,  ebx,   21:12,    cache_npartitions      , Physical l=
ine partitions (0-based)
+         4,      31:0,  ebx,   31:22,    cache_nways            , Ways of as=
sociativity (0-based)
+         4,      31:0,  ecx,    30:0,    cache_nsets            , Cache numb=
er of sets (0-based)
+         4,      31:0,  edx,       0,    wbinvd_rll_no_guarantee, WBINVD/INV=
D not guaranteed for Remote Lower-Level caches
+         4,      31:0,  edx,       1,    ll_inclusive           , Cache is i=
nclusive of Lower-Level caches
+         4,      31:0,  edx,       2,    complex_indexing       , Not a dire=
ct-mapped cache (complex function)
+
+# Leaf 5H
+# MONITOR/MWAIT instructions enumeration
+
+         5,         0,  eax,    15:0,    min_mon_size           , Smallest m=
onitor-line size, in bytes
+         5,         0,  ebx,    15:0,    max_mon_size           , Largest mo=
nitor-line size, in bytes
+         5,         0,  ecx,       0,    mwait_ext              , Enumeratio=
n of MONITOR/MWAIT extensions is supported
+         5,         0,  ecx,       1,    mwait_irq_break        , Interrupts=
 as a break-event for MWAIT is supported
+         5,         0,  edx,     3:0,    n_c0_substates         , Number of =
C0 sub C-states supported using MWAIT
+         5,         0,  edx,     7:4,    n_c1_substates         , Number of =
C1 sub C-states supported using MWAIT
+         5,         0,  edx,    11:8,    n_c2_substates         , Number of =
C2 sub C-states supported using MWAIT
+         5,         0,  edx,   15:12,    n_c3_substates         , Number of =
C3 sub C-states supported using MWAIT
+         5,         0,  edx,   19:16,    n_c4_substates         , Number of =
C4 sub C-states supported using MWAIT
+         5,         0,  edx,   23:20,    n_c5_substates         , Number of =
C5 sub C-states supported using MWAIT
+         5,         0,  edx,   27:24,    n_c6_substates         , Number of =
C6 sub C-states supported using MWAIT
+         5,         0,  edx,   31:28,    n_c7_substates         , Number of =
C7 sub C-states supported using MWAIT
+
+# Leaf 6H
+# Thermal and Power Management enumeration
+
+         6,         0,  eax,       0,    dtherm                 , Digital te=
mprature sensor
+         6,         0,  eax,       1,    turbo_boost            , Intel Turb=
o Boost
+         6,         0,  eax,       2,    arat                   , Always-Run=
ning APIC Timer (not affected by p-state)
+         6,         0,  eax,       4,    pln                    , Power Limi=
t Notification (PLN) event
+         6,         0,  eax,       5,    ecmd                   , Clock modu=
lation duty cycle extension
+         6,         0,  eax,       6,    pts                    , Package th=
ermal management
+         6,         0,  eax,       7,    hwp                    , HWP (Hardw=
are P-states) base registers are supported
+         6,         0,  eax,       8,    hwp_notify             , HWP notifi=
cation (IA32_HWP_INTERRUPT MSR)
+         6,         0,  eax,       9,    hwp_act_window         , HWP activi=
ty window (IA32_HWP_REQUEST[bits 41:32]) supported
+         6,         0,  eax,      10,    hwp_epp                , HWP Energy=
 Performance Preference
+         6,         0,  eax,      11,    hwp_pkg_req            , HWP Packag=
e Level Request
+         6,         0,  eax,      13,    hdc_base_regs          , HDC base r=
egisters are supported
+         6,         0,  eax,      14,    turbo_boost_3_0        , Intel Turb=
o Boost Max 3.0
+         6,         0,  eax,      15,    hwp_capabilities       , HWP Highes=
t Performance change
+         6,         0,  eax,      16,    hwp_peci_override      , HWP PECI o=
verride
+         6,         0,  eax,      17,    hwp_flexible           , Flexible H=
WP
+         6,         0,  eax,      18,    hwp_fast               , IA32_HWP_R=
EQUEST MSR fast access mode
+         6,         0,  eax,      19,    hfi                    , HW_FEEDBAC=
K MSRs supported
+         6,         0,  eax,      20,    hwp_ignore_idle        , Ignoring i=
dle logical CPU HWP req is supported
+         6,         0,  eax,      23,    thread_director        , Intel thre=
ad director support
+         6,         0,  eax,      24,    therm_interrupt_bit25  , IA32_THERM=
_INTERRUPT MSR bit 25 is supported
+         6,         0,  ebx,     3:0,    n_therm_thresholds     , Digital th=
ermometer thresholds
+         6,         0,  ecx,       0,    aperfmperf             , MPERF/APER=
F MSRs (effective frequency interface)
+         6,         0,  ecx,       3,    epb                    , IA32_ENERG=
Y_PERF_BIAS MSR support
+         6,         0,  ecx,    15:8,    thrd_director_nclasses , Number of =
classes, Intel thread director
+         6,         0,  edx,       0,    perfcap_reporting      , Performanc=
e capability reporting
+         6,         0,  edx,       1,    encap_reporting        , Energy eff=
iciency capability reporting
+         6,         0,  edx,    11:8,    feedback_sz            , HW feedbac=
k interface struct size, in 4K pages
+         6,         0,  edx,   31:16,    this_lcpu_hwfdbk_idx   , This logic=
al CPU index @ HW feedback struct, 0-based
+
+# Leaf 7H
+# Extended CPU features enumeration
+
+         7,         0,  eax,    31:0,    leaf7_n_subleaves      , Number of =
cpuid 0x7 subleaves
+         7,         0,  ebx,       0,    fsgsbase               , FSBASE/GSB=
ASE read/write support
+         7,         0,  ebx,       1,    tsc_adjust             , IA32_TSC_A=
DJUST MSR supported
+         7,         0,  ebx,       2,    sgx                    , Intel SGX =
(Software Guard Extensions)
+         7,         0,  ebx,       3,    bmi1                   , Bit manipu=
lation extensions group 1
+         7,         0,  ebx,       4,    hle                    , Hardware L=
ock Elision
+         7,         0,  ebx,       5,    avx2                   , AVX2 instr=
uction set
+         7,         0,  ebx,       6,    fdp_excptn_only        , FPU Data P=
ointer updated only on x87 exceptions
+         7,         0,  ebx,       7,    smep                   , Supervisor=
 Mode Execution Protection
+         7,         0,  ebx,       8,    bmi2                   , Bit manipu=
lation extensions group 2
+         7,         0,  ebx,       9,    erms                   , Enhanced R=
EP MOVSB/STOSB
+         7,         0,  ebx,      10,    invpcid                , INVPCID in=
struction (Invalidate Processor Context ID)
+         7,         0,  ebx,      11,    rtm                    , Intel rest=
ricted transactional memory
+         7,         0,  ebx,      12,    cqm                    , Intel RDT-=
CMT / AMD Platform-QoS cache monitoring
+         7,         0,  ebx,      13,    zero_fcs_fds           , Deprecated=
 FPU CS/DS (stored as zero)
+         7,         0,  ebx,      14,    mpx                    , Intel memo=
ry protection extensions
+         7,         0,  ebx,      15,    rdt_a                  , Intel RDT =
/ AMD Platform-QoS Enforcemeent
+         7,         0,  ebx,      16,    avx512f                , AVX-512 fo=
undation instructions
+         7,         0,  ebx,      17,    avx512dq               , AVX-512 do=
uble/quadword instructions
+         7,         0,  ebx,      18,    rdseed                 , RDSEED ins=
truction
+         7,         0,  ebx,      19,    adx                    , ADCX/ADOX =
instructions
+         7,         0,  ebx,      20,    smap                   , Supervisor=
 mode access prevention
+         7,         0,  ebx,      21,    avx512ifma             , AVX-512 in=
teger fused multiply add
+         7,         0,  ebx,      23,    clflushopt             , CLFLUSHOPT=
 instruction
+         7,         0,  ebx,      24,    clwb                   , CLWB instr=
uction
+         7,         0,  ebx,      25,    intel_pt               , Intel proc=
essor trace
+         7,         0,  ebx,      26,    avx512pf               , AVX-512 pr=
efetch instructions
+         7,         0,  ebx,      27,    avx512er               , AVX-512 ex=
ponent/reciprocal instrs
+         7,         0,  ebx,      28,    avx512cd               , AVX-512 co=
nflict detection instrs
+         7,         0,  ebx,      29,    sha_ni                 , SHA/SHA256=
 instructions
+         7,         0,  ebx,      30,    avx512bw               , AVX-512 BW=
 (byte/word granular) instructions
+         7,         0,  ebx,      31,    avx512vl               , AVX-512 VL=
 (128/256 vector length) extensions
+         7,         0,  ecx,       0,    prefetchwt1            , PREFETCHWT=
1 (Intel Xeon Phi only)
+         7,         0,  ecx,       1,    avx512vbmi             , AVX-512 Ve=
ctor byte manipulation instrs
+         7,         0,  ecx,       2,    umip                   , User mode =
instruction protection
+         7,         0,  ecx,       3,    pku                    , Protection=
 keys for user-space
+         7,         0,  ecx,       4,    ospke                  , OS protect=
ion keys enable
+         7,         0,  ecx,       5,    waitpkg                , WAITPKG in=
structions
+         7,         0,  ecx,       6,    avx512_vbmi2           , AVX-512 ve=
ctor byte manipulation instrs group 2
+         7,         0,  ecx,       7,    cet_ss                 , CET shadow=
 stack features
+         7,         0,  ecx,       8,    gfni                   , Galois fie=
ld new instructions
+         7,         0,  ecx,       9,    vaes                   , Vector AES=
 instrs
+         7,         0,  ecx,      10,    vpclmulqdq             , VPCLMULQDQ=
 256-bit instruction support
+         7,         0,  ecx,      11,    avx512_vnni            , Vector neu=
ral network instructions
+         7,         0,  ecx,      12,    avx512_bitalg          , AVX-512 bi=
t count/shiffle
+         7,         0,  ecx,      13,    tme                    , Intel tota=
l memory encryption
+         7,         0,  ecx,      14,    avx512_vpopcntdq       , AVX-512: P=
OPCNT for vectors of DW/QW
+         7,         0,  ecx,      16,    la57                   , 57-bit lin=
ear addreses (five-level paging)
+         7,         0,  ecx,   21:17,    mawau_val_lm           , BNDLDX/BND=
STX MAWAU value in 64-bit mode
+         7,         0,  ecx,      22,    rdpid                  , RDPID inst=
ruction
+         7,         0,  ecx,      23,    key_locker             , Intel key =
locker support
+         7,         0,  ecx,      24,    bus_lock_detect        , OS bus-loc=
k detection
+         7,         0,  ecx,      25,    cldemote               , CLDEMOTE i=
nstruction
+         7,         0,  ecx,      27,    movdiri                , MOVDIRI in=
struction
+         7,         0,  ecx,      28,    movdir64b              , MOVDIR64B =
instruction
+         7,         0,  ecx,      29,    enqcmd                 , Enqueue st=
ores supported (ENQCMD{,S})
+         7,         0,  ecx,      30,    sgx_lc                 , Intel SGX =
launch configuration
+         7,         0,  ecx,      31,    pks                    , Protection=
 keys for supervisor-mode pages
+         7,         0,  edx,       1,    sgx_keys               , Intel SGX =
attestation services
+         7,         0,  edx,       2,    avx512_4vnniw          , AVX-512 ne=
ural network instructions
+         7,         0,  edx,       3,    avx512_4fmaps          , AVX-512 mu=
ltiply accumulation single precision
+         7,         0,  edx,       4,    fsrm                   , Fast short=
 REP MOV
+         7,         0,  edx,       5,    uintr                  , CPU suppor=
ts user interrupts
+         7,         0,  edx,       8,    avx512_vp2intersect    , VP2INTERSE=
CT{D,Q} instructions
+         7,         0,  edx,       9,    srdbs_ctrl             , SRBDS miti=
gation MSR available
+         7,         0,  edx,      10,    md_clear               , VERW MD_CL=
EAR microcode support
+         7,         0,  edx,      11,    rtm_always_abort       , XBEGIN (RT=
M transaction) always aborts
+         7,         0,  edx,      13,    tsx_force_abort        , MSR TSX_FO=
RCE_ABORT, RTM_ABORT bit, supported
+         7,         0,  edx,      14,    serialize              , SERIALIZE =
instruction
+         7,         0,  edx,      15,    hybrid_cpu             , The CPU is=
 identified as a 'hybrid part'
+         7,         0,  edx,      16,    tsxldtrk               , TSX suspen=
d/resume load address tracking
+         7,         0,  edx,      18,    pconfig                , PCONFIG in=
struction
+         7,         0,  edx,      19,    arch_lbr               , Intel arch=
itectural LBRs
+         7,         0,  edx,      20,    ibt                    , CET indire=
ct branch tracking
+         7,         0,  edx,      22,    amx_bf16               , AMX-BF16: =
tile bfloat16 support
+         7,         0,  edx,      23,    avx512_fp16            , AVX-512 FP=
16 instructions
+         7,         0,  edx,      24,    amx_tile               , AMX-TILE: =
tile architecture support
+         7,         0,  edx,      25,    amx_int8               , AMX-INT8: =
tile 8-bit integer support
+         7,         0,  edx,      26,    spec_ctrl              , Speculatio=
n Control (IBRS/IBPB: indirect branch restrictions)
+         7,         0,  edx,      27,    intel_stibp            , Single thr=
ead indirect branch predictors
+         7,         0,  edx,      28,    flush_l1d              , FLUSH L1D =
cache: IA32_FLUSH_CMD MSR
+         7,         0,  edx,      29,    arch_capabilities      , Intel IA32=
_ARCH_CAPABILITIES MSR
+         7,         0,  edx,      30,    core_capabilities      , IA32_CORE_=
CAPABILITIES MSR
+         7,         0,  edx,      31,    spec_ctrl_ssbd         , Speculativ=
e store bypass disable
+         7,         1,  eax,       4,    avx_vnni               , AVX-VNNI i=
nstructions
+         7,         1,  eax,       5,    avx512_bf16            , AVX-512 bF=
loat16 instructions
+         7,         1,  eax,       6,    lass                   , Linear add=
ress space separation
+         7,         1,  eax,       7,    cmpccxadd              , CMPccXADD =
instructions
+         7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmo=
nExt: CPUID leaf 0x23 is supported
+         7,         1,  eax,      10,    fzrm                   , Fast zero-=
length REP MOVSB
+         7,         1,  eax,      11,    fsrs                   , Fast short=
 REP STOSB
+         7,         1,  eax,      12,    fsrc                   , Fast Short=
 REP CMPSB/SCASB
+         7,         1,  eax,      17,    fred                   , FRED: Flex=
ible return and event delivery transitions
+         7,         1,  eax,      18,    lkgs                   , LKGS: Load=
 'kernel' (userspace) GS
+         7,         1,  eax,      19,    wrmsrns                , WRMSRNS in=
str (WRMSR-non-serializing)
+         7,         1,  eax,      21,    amx_fp16               , AMX-FP16: =
FP16 tile operations
+         7,         1,  eax,      22,    hreset                 , History re=
set support
+         7,         1,  eax,      23,    avx_ifma               , Integer fu=
sed multiply add
+         7,         1,  eax,      26,    lam                    , Linear add=
ress masking
+         7,         1,  eax,      27,    rd_wr_msrlist          , RDMSRLIST/=
WRMSRLIST instructions
+         7,         1,  ebx,       0,    intel_ppin             , Protected =
processor inventory number (PPIN{,_CTL} MSRs)
+         7,         1,  edx,       4,    avx_vnni_int8          , AVX-VNNI-I=
NT8 instructions
+         7,         1,  edx,       5,    avx_ne_convert         , AVX-NE-CON=
VERT instructions
+         7,         1,  edx,       8,    amx_complex            , AMX-COMPLE=
X instructions (starting from Granite Rapids)
+         7,         1,  edx,      14,    prefetchit_0_1         , PREFETCHIT=
0/1 instructions
+         7,         1,  edx,      18,    cet_sss                , CET superv=
isor shadow stacks safe to use
+         7,         2,  edx,       0,    intel_psfd             , Intel pred=
ictive store forward disable
+         7,         2,  edx,       1,    ipred_ctrl             , MSR bits I=
A32_SPEC_CTRL.IPRED_DIS_{U,S}
+         7,         2,  edx,       2,    rrsba_ctrl             , MSR bits I=
A32_SPEC_CTRL.RRSBA_DIS_{U,S}
+         7,         2,  edx,       3,    ddp_ctrl               , MSR bit  I=
A32_SPEC_CTRL.DDPD_U
+         7,         2,  edx,       4,    bhi_ctrl               , MSR bit  I=
A32_SPEC_CTRL.BHI_DIS_S
+         7,         2,  edx,       5,    mcdt_no                , MCDT mitig=
ation not needed
+         7,         2,  edx,       6,    uclock_disable         , UC-lock di=
sable is supported
+
+# Leaf 9H
+# Intel DCA (Direct Cache Access) enumeration
+
+         9,         0,  eax,       0,    dca_enabled_in_bios    , DCA is ena=
bled in BIOS
+
+# Leaf AH
+# Intel PMU (Performance Monitoring Unit) enumeration
+
+       0xa,         0,  eax,     7:0,    pmu_version            , Performanc=
e monitoring unit version ID
+       0xa,         0,  eax,    15:8,    pmu_n_gcounters        , Number of =
general PMU counters per logical CPU
+       0xa,         0,  eax,   23:16,    pmu_gcounters_nbits    , Bitwidth o=
f PMU general counters
+       0xa,         0,  eax,   31:24,    pmu_cpuid_ebx_bits     , Length of =
cpuid leaf 0xa EBX bit vector
+       0xa,         0,  ebx,       0,    no_core_cycle_evt      , Core cycle=
 event not available
+       0xa,         0,  ebx,       1,    no_insn_retired_evt    , Instructio=
n retired event not available
+       0xa,         0,  ebx,       2,    no_refcycle_evt        , Reference =
cycles event not available
+       0xa,         0,  ebx,       3,    no_llc_ref_evt         , LLC-refere=
nce event not available
+       0xa,         0,  ebx,       4,    no_llc_miss_evt        , LLC-misses=
 event not available
+       0xa,         0,  ebx,       5,    no_br_insn_ret_evt     , Branch ins=
truction retired event not available
+       0xa,         0,  ebx,       6,    no_br_mispredict_evt   , Branch mis=
predict retired event not available
+       0xa,         0,  ebx,       7,    no_td_slots_evt        , Topdown sl=
ots event not available
+       0xa,         0,  ecx,    31:0,    pmu_fcounters_bitmap   , Fixed-func=
tion PMU counters support bitmap
+       0xa,         0,  edx,     4:0,    pmu_n_fcounters        , Number of =
fixed PMU counters
+       0xa,         0,  edx,    12:5,    pmu_fcounters_nbits    , Bitwidth o=
f PMU fixed counters
+       0xa,         0,  edx,      15,    anythread_depr         , AnyThread =
deprecation
+
+# Leaf BH
+# CPUs v1 extended topology enumeration
+
+       0xb,       1:0,  eax,     4:0,    x2apic_id_shift        , Bit width =
of this level (previous levels inclusive)
+       0xb,       1:0,  ebx,    15:0,    domain_lcpus_count     , Logical CP=
Us count across all instances of this domain
+       0xb,       1:0,  ecx,     7:0,    domain_nr              , This domai=
n level (subleaf ID)
+       0xb,       1:0,  ecx,    15:8,    domain_type            , This domai=
n type
+       0xb,       1:0,  edx,    31:0,    x2apic_id              , x2APIC ID =
of current logical CPU
+
+# Leaf DH
+# Processor extended state enumeration
+
+       0xd,         0,  eax,       0,    xcr0_x87               , XCR0.X87 (=
bit 0) supported
+       0xd,         0,  eax,       1,    xcr0_sse               , XCR0.SEE (=
bit 1) supported
+       0xd,         0,  eax,       2,    xcr0_avx               , XCR0.AVX (=
bit 2) supported
+       0xd,         0,  eax,       3,    xcr0_mpx_bndregs       , XCR0.BNDRE=
GS (bit 3) supported (MPX BND0-BND3 regs)
+       0xd,         0,  eax,       4,    xcr0_mpx_bndcsr        , XCR0.BNDCS=
R (bit 4) supported (MPX BNDCFGU/BNDSTATUS regs)
+       0xd,         0,  eax,       5,    xcr0_avx512_opmask     , XCR0.OPMAS=
K (bit 5) supported (AVX-512 k0-k7 regs)
+       0xd,         0,  eax,       6,    xcr0_avx512_zmm_hi256  , XCR0.ZMM_H=
i256 (bit 6) supported (AVX-512 ZMM0->ZMM7/15 regs)
+       0xd,         0,  eax,       7,    xcr0_avx512_hi16_zmm   , XCR0.HI16_=
ZMM (bit 7) supported (AVX-512 ZMM16->ZMM31 regs)
+       0xd,         0,  eax,       9,    xcr0_pkru              , XCR0.PKRU =
(bit 9) supported (XSAVE PKRU reg)
+       0xd,         0,  eax,      11,    xcr0_cet_u             , AMD XCR0.C=
ET_U (bit 11) supported (CET supervisor state)
+       0xd,         0,  eax,      12,    xcr0_cet_s             , AMD XCR0.C=
ET_S (bit 12) support (CET user state)
+       0xd,         0,  eax,      17,    xcr0_tileconfig        , XCR0.TILEC=
ONFIG (bit 17) supported (AMX can manage TILECONFIG)
+       0xd,         0,  eax,      18,    xcr0_tiledata          , XCR0.TILED=
ATA (bit 18) supported (AMX can manage TILEDATA)
+       0xd,         0,  ebx,    31:0,    xsave_sz_xcr0_enabled  , XSAVE/XRST=
R area byte size, for XCR0 enabled features
+       0xd,         0,  ecx,    31:0,    xsave_sz_max           , XSAVE/XRST=
R area max byte size, all CPU features
+       0xd,         0,  edx,      30,    xcr0_lwp               , AMD XCR0.L=
WP (bit 62) supported (Light-weight Profiling)
+       0xd,         1,  eax,       0,    xsaveopt               , XSAVEOPT i=
nstruction
+       0xd,         1,  eax,       1,    xsavec                 , XSAVEC ins=
truction
+       0xd,         1,  eax,       2,    xgetbv1                , XGETBV ins=
truction with ECX =3D 1
+       0xd,         1,  eax,       3,    xsaves                 , XSAVES/XRS=
TORS instructions (and XSS MSR)
+       0xd,         1,  eax,       4,    xfd                    , Extended f=
eature disable support
+       0xd,         1,  ebx,    31:0,    xsave_sz_xcr0_xmms_enabled, XSAVE a=
rea size, all XCR0 and XMMS features enabled
+       0xd,         1,  ecx,       8,    xss_pt                 , PT state, =
supported
+       0xd,         1,  ecx,      10,    xss_pasid              , PASID stat=
e, supported
+       0xd,         1,  ecx,      11,    xss_cet_u              , CET user s=
tate, supported
+       0xd,         1,  ecx,      12,    xss_cet_p              , CET superv=
isor state, supported
+       0xd,         1,  ecx,      13,    xss_hdc                , HDC state,=
 supported
+       0xd,         1,  ecx,      14,    xss_uintr              , UINTR stat=
e, supported
+       0xd,         1,  ecx,      15,    xss_lbr                , LBR state,=
 supported
+       0xd,         1,  ecx,      16,    xss_hwp                , HWP state,=
 supported
+       0xd,      63:2,  eax,    31:0,    xsave_sz               , Size of sa=
ve area for subleaf-N feature, in bytes
+       0xd,      63:2,  ebx,    31:0,    xsave_offset           , Offset of =
save area for subleaf-N feature, in bytes
+       0xd,      63:2,  ecx,       0,    is_xss_bit             , Subleaf N =
describes an XSS bit, otherwise XCR0 bit
+       0xd,      63:2,  ecx,       1,    compacted_xsave_64byte_aligned, Whe=
n compacted, subleaf-N feature xsave area is 64-byte aligned
+
+# Leaf FH
+# Intel RDT / AMD PQoS resource monitoring
+
+       0xf,         0,  ebx,    31:0,    core_rmid_max          , RMID max, =
within this core, all types (0-based)
+       0xf,         0,  edx,       1,    cqm_llc                , LLC QoS-mo=
nitoring supported
+       0xf,         1,  eax,     7:0,    l3c_qm_bitwidth        , L3 QoS-mon=
itoring counter bitwidth (24-based)
+       0xf,         1,  eax,       8,    l3c_qm_overflow_bit    , QM_CTR MSR=
 bit 61 is an overflow bit
+       0xf,         1,  ebx,    31:0,    l3c_qm_conver_factor   , QM_CTR MSR=
 conversion factor to bytes
+       0xf,         1,  ecx,    31:0,    l3c_qm_rmid_max        , L3 QoS-mon=
itoring max RMID
+       0xf,         1,  edx,       0,    cqm_occup_llc          , L3 QoS occ=
upancy monitoring supported
+       0xf,         1,  edx,       1,    cqm_mbm_total          , L3 QoS tot=
al bandwidth monitoring supported
+       0xf,         1,  edx,       2,    cqm_mbm_local          , L3 QoS loc=
al bandwidth monitoring supported
=20
 # Leaf 10H
-# Intel RDT Allocation
-
-      0x10,    0,  EBX,      1, l3c_rdt_alloc, L3 Cache Allocation supported
-      0x10,    0,  EBX,      2, l2c_rdt_alloc, L2 Cache Allocation supported
-      0x10,    0,  EBX,      3, mem_bw_alloc, Memory Bandwidth Allocation su=
pported
-
+# Intel RDT / AMD PQoS allocation enumeration
+
+      0x10,         0,  ebx,       1,    cat_l3                 , L3 Cache A=
llocation Technology supported
+      0x10,         0,  ebx,       2,    cat_l2                 , L2 Cache A=
llocation Technology supported
+      0x10,         0,  ebx,       3,    mba                    , Memory Ban=
dwidth Allocation supported
+      0x10,       2:1,  eax,     4:0,    cat_cbm_len            , L3/L2_CAT =
capacity bitmask length, minus-one notation
+      0x10,       2:1,  ebx,    31:0,    cat_units_bitmap       , L3/L2_CAT =
bitmap of allocation units
+      0x10,       2:1,  ecx,       1,    l3_cat_cos_infreq_updates, L3_CAT C=
OS updates should be infrequent
+      0x10,       2:1,  ecx,       2,    cdp_l3                 , L3/L2_CAT =
CDP (Code and Data Prioritization)
+      0x10,       2:1,  ecx,       3,    cat_sparse_1s          , L3/L2_CAT =
non-contiguous 1s value supported
+      0x10,       2:1,  edx,    15:0,    cat_cos_max            , L3/L2_CAT =
max COS (Class of Service) supported
+      0x10,         3,  eax,    11:0,    mba_max_delay          , Max MBA th=
rottling value; minus-one notation
+      0x10,         3,  ecx,       0,    per_thread_mba         , Per-thread=
 MBA controls are supported
+      0x10,         3,  ecx,       2,    mba_delay_linear       , Delay valu=
es are linear
+      0x10,         3,  edx,    15:0,    mba_cos_max            , MBA max Cl=
ass of Service supported
=20
 # Leaf 12H
-# SGX Capability
-#
-# Some detailed SGX features not added yet
-
-      0x12,    0,  EAX,      0, sgx1, L3 Cache Allocation supported
-      0x12,    1,  EAX,      0, sgx2, L3 Cache Allocation supported
-
+# Intel Software Guard Extensions (SGX) enumeration
+
+      0x12,         0,  eax,       0,    sgx1                   , SGX1 leaf =
functions supported
+      0x12,         0,  eax,       1,    sgx2                   , SGX2 leaf =
functions supported
+      0x12,         0,  eax,       5,    enclv_leaves           , ENCLV leav=
es (E{INC,DEC}VIRTCHILD, ESETCONTEXT) supported
+      0x12,         0,  eax,       6,    encls_leaves           , ENCLS leav=
es (ENCLS ETRACKC, ERDINFO, ELDBC, ELDUC) supported
+      0x12,         0,  eax,       7,    enclu_everifyreport2   , ENCLU leaf=
 EVERIFYREPORT2 supported
+      0x12,         0,  eax,      10,    encls_eupdatesvn       , ENCLS leaf=
 EUPDATESVN supported
+      0x12,         0,  eax,      11,    sgx_edeccssa           , ENCLU leaf=
 EDECCSSA supported
+      0x12,         0,  ebx,       0,    miscselect_exinfo      , SSA.MISC f=
rame: reporting #PF and #GP exceptions inside enclave supported
+      0x12,         0,  ebx,       1,    miscselect_cpinfo      , SSA.MISC f=
rame: reporting #CP exceptions inside enclave supported
+      0x12,         0,  edx,     7:0,    max_enclave_sz_not64   , Maximum en=
clave size in non-64-bit mode (log2)
+      0x12,         0,  edx,    15:8,    max_enclave_sz_64      , Maximum en=
clave size in 64-bit mode (log2)
+      0x12,         1,  eax,       0,    secs_attr_init         , ATTRIBUTES=
.INIT supported (enclave initialized by EINIT)
+      0x12,         1,  eax,       1,    secs_attr_debug        , ATTRIBUTES=
.DEBUG supported (enclave permits debugger read/write)
+      0x12,         1,  eax,       2,    secs_attr_mode64bit    , ATTRIBUTES=
.MODE64BIT supported (enclave runs in 64-bit mode)
+      0x12,         1,  eax,       4,    secs_attr_provisionkey , ATTRIBUTES=
.PROVISIONKEY supported (provisioning key available)
+      0x12,         1,  eax,       5,    secs_attr_einittoken_key, ATTRIBUTE=
S.EINITTOKEN_KEY supported (EINIT token key available)
+      0x12,         1,  eax,       6,    secs_attr_cet          , ATTRIBUTES=
.CET supported (enable CET attributes)
+      0x12,         1,  eax,       7,    secs_attr_kss          , ATTRIBUTES=
.KSS supported (Key Separation and Sharing enabled)
+      0x12,         1,  eax,      10,    secs_attr_aexnotify    , ATTRIBUTES=
.AEXNOTIFY supported (enclave threads may get AEX notifications
+      0x12,         1,  ecx,       0,    xfrm_x87               , Enclave XF=
RM.X87 (bit 0) supported
+      0x12,         1,  ecx,       1,    xfrm_sse               , Enclave XF=
RM.SEE (bit 1) supported
+      0x12,         1,  ecx,       2,    xfrm_avx               , Enclave XF=
RM.AVX (bit 2) supported
+      0x12,         1,  ecx,       3,    xfrm_mpx_bndregs       , Enclave XF=
RM.BNDREGS (bit 3) supported (MPX BND0-BND3 regs)
+      0x12,         1,  ecx,       4,    xfrm_mpx_bndcsr        , Enclave XF=
RM.BNDCSR (bit 4) supported (MPX BNDCFGU/BNDSTATUS regs)
+      0x12,         1,  ecx,       5,    xfrm_avx512_opmask     , Enclave XF=
RM.OPMASK (bit 5) supported (AVX-512 k0-k7 regs)
+      0x12,         1,  ecx,       6,    xfrm_avx512_zmm_hi256  , Enclave XF=
RM.ZMM_Hi256 (bit 6) supported (AVX-512 ZMM0->ZMM7/15 regs)
+      0x12,         1,  ecx,       7,    xfrm_avx512_hi16_zmm   , Enclave XF=
RM.HI16_ZMM (bit 7) supported (AVX-512 ZMM16->ZMM31 regs)
+      0x12,         1,  ecx,       9,    xfrm_pkru              , Enclave XF=
RM.PKRU (bit 9) supported (XSAVE PKRU reg)
+      0x12,         1,  ecx,      17,    xfrm_tileconfig        , Enclave XF=
RM.TILECONFIG (bit 17) supported (AMX can manage TILECONFIG)
+      0x12,         1,  ecx,      18,    xfrm_tiledata          , Enclave XF=
RM.TILEDATA (bit 18) supported (AMX can manage TILEDATA)
+      0x12,      31:2,  eax,     3:0,    subleaf_type           , Subleaf ty=
pe (dictates output layout)
+      0x12,      31:2,  eax,   31:12,    epc_sec_base_addr_0    , EPC sectio=
n base addr, bits[12:31]
+      0x12,      31:2,  ebx,    19:0,    epc_sec_base_addr_1    , EPC sectio=
n base addr, bits[32:51]
+      0x12,      31:2,  ecx,     3:0,    epc_sec_type           , EPC sectio=
n type / property encoding
+      0x12,      31:2,  ecx,   31:12,    epc_sec_size_0         , EPC sectio=
n size, bits[12:31]
+      0x12,      31:2,  edx,    19:0,    epc_sec_size_1         , EPC sectio=
n size, bits[32:51]
=20
 # Leaf 14H
-# Intel Processor Tracer
-#
+# Intel Processor Trace enumeration
+
+      0x14,         0,  eax,    31:0,    pt_max_subleaf         , Max cpuid =
0x14 subleaf
+      0x14,         0,  ebx,       0,    cr3_filtering          , IA32_RTIT_=
CR3_MATCH is accessible
+      0x14,         0,  ebx,       1,    psb_cyc                , Configurab=
le PSB and cycle-accurate mode
+      0x14,         0,  ebx,       2,    ip_filtering           , IP/TraceSt=
op filtering; Warm-reset PT MSRs preservation
+      0x14,         0,  ebx,       3,    mtc_timing             , MTC timing=
 packet; COFI-based packets suppression
+      0x14,         0,  ebx,       4,    ptwrite                , PTWRITE su=
pport
+      0x14,         0,  ebx,       5,    power_event_trace      , Power Even=
t Trace support
+      0x14,         0,  ebx,       6,    psb_pmi_preserve       , PSB and PM=
I preservation support
+      0x14,         0,  ebx,       7,    event_trace            , Event Trac=
e packet generation through IA32_RTIT_CTL.EventEn
+      0x14,         0,  ebx,       8,    tnt_disable            , TNT packet=
 generation disable through IA32_RTIT_CTL.DisTNT
+      0x14,         0,  ecx,       0,    topa_output            , ToPA outpu=
t scheme support
+      0x14,         0,  ecx,       1,    topa_multiple_entries  , ToPA table=
s can hold multiple entries
+      0x14,         0,  ecx,       2,    single_range_output    , Single-ran=
ge output scheme supported
+      0x14,         0,  ecx,       3,    trance_transport_output, Trace Tran=
sport subsystem output support
+      0x14,         0,  ecx,      31,    ip_payloads_lip        , IP payload=
s have LIP values (CS base included)
+      0x14,         1,  eax,     2:0,    num_address_ranges     , Filtering =
number of configurable Address Ranges
+      0x14,         1,  eax,   31:16,    mtc_periods_bmp        , Bitmap of =
supported MTC period encodings
+      0x14,         1,  ebx,    15:0,    cycle_thresholds_bmp   , Bitmap of =
supported Cycle Threshold encodings
+      0x14,         1,  ebx,   31:16,    psb_periods_bmp        , Bitmap of =
supported Configurable PSB frequency encodings
=20
 # Leaf 15H
-# Time Stamp Counter and Nominal Core Crystal Clock Information
+# Intel TSC (Time Stamp Counter) enumeration
=20
-      0x15,    0,  EAX,   31:0, tsc_denominator, The denominator of the TSC/=
=E2=80=9Dcore crystal clock=E2=80=9D ratio
-      0x15,    0,  EBX,   31:0, tsc_numerator, The numerator of the TSC/=E2=
=80=9Dcore crystal clock=E2=80=9D ratio
-      0x15,    0,  ECX,   31:0, nom_freq, Nominal frequency of the core crys=
tal clock in Hz
+      0x15,         0,  eax,    31:0,    tsc_denominator        , Denominato=
r of the TSC/'core crystal clock' ratio
+      0x15,         0,  ebx,    31:0,    tsc_numerator          , Numerator =
of the TSC/'core crystal clock' ratio
+      0x15,         0,  ecx,    31:0,    cpu_crystal_hz         , Core cryst=
al clock nominal frequency, in Hz
=20
 # Leaf 16H
-# Processor Frequency Information
+# Intel processor fequency enumeration
=20
-      0x16,    0,  EAX,   15:0, cpu_base_freq, Processor Base Frequency in M=
Hz
-      0x16,    0,  EBX,   15:0, cpu_max_freq, Maximum Frequency in MHz
-      0x16,    0,  ECX,   15:0, bus_freq, Bus (Reference) Frequency in MHz
+      0x16,         0,  eax,    15:0,    cpu_base_mhz           , Processor =
base frequency, in MHz
+      0x16,         0,  ebx,    15:0,    cpu_max_mhz            , Processor =
max frequency, in MHz
+      0x16,         0,  ecx,    15:0,    bus_mhz                , Bus refere=
nce frequency, in MHz
=20
 # Leaf 17H
-# System-On-Chip Vendor Attribute
-
-      0x17,    0,  EAX,   31:0, max_socid, Maximum input value of supported =
sub-leaf
-      0x17,    0,  EBX,   15:0, soc_vid, SOC Vendor ID
-      0x17,    0,  EBX,     16, std_vid, SOC Vendor ID is assigned via an in=
dustry standard scheme
-      0x17,    0,  ECX,   31:0, soc_pid, SOC Project ID assigned by vendor
-      0x17,    0,  EDX,   31:0, soc_sid, SOC Stepping ID
+# Intel SoC vendor attributes enumeration
+
+      0x17,         0,  eax,    31:0,    soc_max_subleaf        , Max cpuid =
leaf 0x17 subleaf
+      0x17,         0,  ebx,    15:0,    soc_vendor_id          , SoC vendor=
 ID
+      0x17,         0,  ebx,      16,    is_vendor_scheme       , Assigned b=
y industry enumaeratoion scheme (not Intel)
+      0x17,         0,  ecx,    31:0,    soc_proj_id            , SoC projec=
t ID, assigned by vendor
+      0x17,         0,  edx,    31:0,    soc_stepping_id        , Soc projec=
t stepping ID, assigned by vendor
+      0x17,       3:1,  eax,    31:0,    vendor_brand_a         , Vendor Bra=
nd ID string, bytes subleaf_nr * (0 -> 3)
+      0x17,       3:1,  ebx,    31:0,    vendor_brand_b         , Vendor Bra=
nd ID string, bytes subleaf_nr * (4 -> 7)
+      0x17,       3:1,  ecx,    31:0,    vendor_brand_c         , Vendor Bra=
nd ID string, bytes subleaf_nr * (8 -> 11)
+      0x17,       3:1,  edx,    31:0,    vendor_brand_d         , Vendor Bra=
nd ID string, bytes subleaf_nr * (12 -> 15)
=20
 # Leaf 18H
-# Deterministic Address Translation Parameters
-
+# Intel determenestic address translation (TLB) parameters
+
+      0x18,      31:0,  eax,    31:0,    tlb_max_subleaf        , Max cpuid =
0x18 subleaf
+      0x18,      31:0,  ebx,       0,    tlb_4k_page            , TLB 4KB-pa=
ge entries supported
+      0x18,      31:0,  ebx,       1,    tlb_2m_page            , TLB 2MB-pa=
ge entries supported
+      0x18,      31:0,  ebx,       2,    tlb_4m_page            , TLB 4MB-pa=
ge entries supported
+      0x18,      31:0,  ebx,       3,    tlb_1g_page            , TLB 1GB-pa=
ge entries supported
+      0x18,      31:0,  ebx,    10:8,    hard_partitioning      , (Hard/Soft=
) partitioning between logical CPUs sharing this struct
+      0x18,      31:0,  ebx,   31:16,    n_way_associative      , Ways of as=
sociativity
+      0x18,      31:0,  ecx,    31:0,    n_sets                 , Number of =
sets
+      0x18,      31:0,  edx,     4:0,    tlb_type               , Translatio=
n cache type (TLB type)
+      0x18,      31:0,  edx,     7:5,    tlb_cache_level        , Translatio=
n cache level (1-based)
+      0x18,      31:0,  edx,       8,    is_fully_associative   , Fully-asso=
ciative structure
+      0x18,      31:0,  edx,   25:14,    tlb_max_addressible_ids, Max num of=
 addressible IDs for logical CPUs sharing this TLB - 1
=20
 # Leaf 19H
-# Key Locker Leaf
+# Intel Key Locker enumeration
=20
+      0x19,         0,  eax,       0,    kl_cpl0_only           , CPL0-only =
key Locker restriction supported
+      0x19,         0,  eax,       1,    kl_no_encrypt          , No-encrypt=
 key locker restriction supported
+      0x19,         0,  eax,       2,    kl_no_decrypt          , No-decrypt=
 key locker restriction supported
+      0x19,         0,  ebx,       0,    aes_keylocker          , AES key lo=
cker instructions supported
+      0x19,         0,  ebx,       2,    aes_keylocker_wide     , AES wide k=
ey locker instructions supported
+      0x19,         0,  ebx,       4,    kl_msr_iwkey           , Key locker=
 MSRs and IWKEY backups supported
+      0x19,         0,  ecx,       0,    loadiwkey_no_backup    , LOADIWKEY =
NoBackup parameter supported
+      0x19,         0,  ecx,       1,    iwkey_rand             , IWKEY rand=
omization (KeySource encoding 1) supported
=20
 # Leaf 1AH
-# Hybrid Information
-
-      0x1A,    0,  EAX,  31:24, core_type, 20H-Intel_Atom 40H-Intel_Core
-
+# Intel hybrid CPUs identification (e.g. Atom, Core)
+
+      0x1a,         0,  eax,    23:0,    core_native_model      , This core'=
s native model ID
+      0x1a,         0,  eax,   31:24,    core_type              , This core'=
s type
+
+# Leaf 1BH
+# Intel PCONFIG (Platform configuration) enumeration
+
+      0x1b,      31:0,  eax,    11:0,    pconfig_subleaf_type   , CPUID 0x1b=
 subleaf type
+      0x1b,      31:0,  ebx,    31:0,    pconfig_target_id_x    , A supporte=
d PCONFIG target ID
+      0x1b,      31:0,  ecx,    31:0,    pconfig_target_id_y    , A supporte=
d PCONFIG target ID
+      0x1b,      31:0,  edx,    31:0,    pconfig_target_id_z    , A supporte=
d PCONFIG target ID
+
+# Leaf 1CH
+# Intel LBR (Last Branch Record) enumeration
+
+      0x1c,         0,  eax,       0,    lbr_depth_8            , Max stack =
depth (number of LBR entries) =3D 8
+      0x1c,         0,  eax,       1,    lbr_depth_16           , Max stack =
depth (number of LBR entries) =3D 16
+      0x1c,         0,  eax,       2,    lbr_depth_24           , Max stack =
depth (number of LBR entries) =3D 24
+      0x1c,         0,  eax,       3,    lbr_depth_32           , Max stack =
depth (number of LBR entries) =3D 32
+      0x1c,         0,  eax,       4,    lbr_depth_40           , Max stack =
depth (number of LBR entries) =3D 40
+      0x1c,         0,  eax,       5,    lbr_depth_48           , Max stack =
depth (number of LBR entries) =3D 48
+      0x1c,         0,  eax,       6,    lbr_depth_56           , Max stack =
depth (number of LBR entries) =3D 56
+      0x1c,         0,  eax,       7,    lbr_depth_64           , Max stack =
depth (number of LBR entries) =3D 64
+      0x1c,         0,  eax,      30,    lbr_deep_c_reset       , LBRs maybe=
 cleared on MWAIT C-state > C1
+      0x1c,         0,  eax,      31,    lbr_ip_is_lip          , LBR IP con=
tain Last IP, otherwise effective IP
+      0x1c,         0,  ebx,       0,    lbr_cpl                , CPL filter=
ing (non-zero IA32_LBR_CTL[2:1]) supported
+      0x1c,         0,  ebx,       1,    lbr_branch_filter      , Branch fil=
tering (non-zero IA32_LBR_CTL[22:16]) supported
+      0x1c,         0,  ebx,       2,    lbr_call_stack         , Call-stack=
 mode (IA32_LBR_CTL[3] =3D 1) supported
+      0x1c,         0,  ecx,       0,    lbr_mispredict         , Branch mis=
prediction bit supported (IA32_LBR_x_INFO[63])
+      0x1c,         0,  ecx,       1,    lbr_timed_lbr          , Timed LBRs=
 (CPU cycles since last LBR entry) supported
+      0x1c,         0,  ecx,       2,    lbr_branch_type        , Branch typ=
e field (IA32_LBR_INFO_x[59:56]) supported
+      0x1c,         0,  ecx,   19:16,    lbr_events_gpc_bmp     , LBR PMU-ev=
ents logging support; bitmap for first 4 GP (general-purpose) Counters
+
+# Leaf 1DH
+# Intel AMX (Advanced Matrix Extensions) tile information
+
+      0x1d,         0,  eax,    31:0,    amx_max_palette        , Highest pa=
lette ID / subleaf ID
+      0x1d,         1,  eax,    15:0,    amx_palette_size       , AMX palett=
e total tiles size, in bytes
+      0x1d,         1,  eax,   31:16,    amx_tile_size          , AMX single=
 tile's size, in bytes
+      0x1d,         1,  ebx,    15:0,    amx_tile_row_size      , AMX tile s=
ingle row's size, in bytes
+      0x1d,         1,  ebx,   31:16,    amx_palette_nr_tiles   , AMX palett=
e number of tiles
+      0x1d,         1,  ecx,    15:0,    amx_tile_nr_rows       , AMX tile m=
ax number of rows
+
+# Leaf 1EH
+# Intel AMX, TMUL (Tile-matrix MULtiply) accelerator unit enumeration
+
+      0x1e,         0,  ebx,     7:0,    tmul_maxk              , TMUL unit =
maximum height, K (rows or columns)
+      0x1e,         0,  ebx,    23:8,    tmul_maxn              , TMUL unit =
maxiumum SIMD dimension, N (column bytes)
=20
 # Leaf 1FH
-# V2 Extended Topology - A preferred superset to leaf 0BH
-
-
-# According to SDM
-# 40000000H - 4FFFFFFFH is invalid range
+# Intel extended topology enumeration v2
+
+      0x1f,       5:0,  eax,     4:0,    x2apic_id_shift        , Bit width =
of this level (previous levels inclusive)
+      0x1f,       5:0,  ebx,    15:0,    domain_lcpus_count     , Logical CP=
Us count across all instances of this domain
+      0x1f,       5:0,  ecx,     7:0,    domain_level           , This domai=
n level (subleaf ID)
+      0x1f,       5:0,  ecx,    15:8,    domain_type            , This domai=
n type
+      0x1f,       5:0,  edx,    31:0,    x2apic_id              , x2APIC ID =
of current logical CPU
+
+# Leaf 20H
+# Intel HRESET (History Reset) enumeration
+
+      0x20,         0,  eax,    31:0,    hreset_nr_subleaves    , CPUID 0x20=
 max subleaf + 1
+      0x20,         0,  ebx,       0,    hreset_thread_director , HRESET of =
Intel thread director is supported
+
+# Leaf 21H
+# Intel TD (Trust Domain) guest execution environment enumeration
+
+      0x21,         0,  ebx,    31:0,    tdx_vendorid_0         , TDX vendor=
 ID string bytes 0 - 3
+      0x21,         0,  ecx,    31:0,    tdx_vendorid_2         , CPU vendor=
 ID string bytes 8 - 11
+      0x21,         0,  edx,    31:0,    tdx_vendorid_1         , CPU vendor=
 ID string bytes 4 - 7
+
+# Leaf 23H
+# Intel Architectural Performance Monitoring Extended (ArchPerfmonExt)
+
+      0x23,         0,  eax,       1,    subleaf_1_counters     , Subleaf 1,=
 PMU counters bitmaps, is valid
+      0x23,         0,  eax,       3,    subleaf_3_events       , Subleaf 3,=
 PMU events bitmaps, is valid
+      0x23,         0,  ebx,       0,    unitmask2              , IA32_PERFE=
VTSELx MSRs UnitMask2 is supported
+      0x23,         0,  ebx,       1,    zbit                   , IA32_PERFE=
VTSELx MSRs Z-bit is supported
+      0x23,         1,  eax,    31:0,    pmu_gp_counters_bitmap , General-pu=
rpose PMU counters bitmap
+      0x23,         1,  ebx,    31:0,    pmu_f_counters_bitmap  , Fixed PMU =
counters bitmap
+      0x23,         3,  eax,       0,    core_cycles_evt        , Core cycle=
s event supported
+      0x23,         3,  eax,       1,    insn_retired_evt       , Instructio=
ns retired event supported
+      0x23,         3,  eax,       2,    ref_cycles_evt         , Reference =
cycles event supported
+      0x23,         3,  eax,       3,    llc_refs_evt           , Last-level=
 cache references event supported
+      0x23,         3,  eax,       4,    llc_misses_evt         , Last-level=
 cache misses event supported
+      0x23,         3,  eax,       5,    br_insn_ret_evt        , Branch ins=
truction retired event supported
+      0x23,         3,  eax,       6,    br_mispr_evt           , Branch mis=
predict retired event supported
+      0x23,         3,  eax,       7,    td_slots_evt           , Topdown sl=
ots event supported
+      0x23,         3,  eax,       8,    td_backend_bound_evt   , Topdown ba=
ckend bound event supported
+      0x23,         3,  eax,       9,    td_bad_spec_evt        , Topdown ba=
d speculation event supported
+      0x23,         3,  eax,      10,    td_frontend_bound_evt  , Topdown fr=
ontend bound event supported
+      0x23,         3,  eax,      11,    td_retiring_evt        , Topdown re=
tiring event support
+
+# Leaf 40000000H
+# Maximum hypervisor standard leaf + hypervisor vendor string
+
+0x40000000,         0,  eax,    31:0,    max_hyp_leaf           , Maximum hy=
pervisor standard leaf number
+0x40000000,         0,  ebx,    31:0,    hypervisor_id_0        , Hypervisor=
 ID string bytes 0 - 3
+0x40000000,         0,  ecx,    31:0,    hypervisor_id_1        , Hypervisor=
 ID string bytes 4 - 7
+0x40000000,         0,  edx,    31:0,    hypervisor_id_2        , Hypervisor=
 ID string bytes 8 - 11
+
+# Leaf 80000000H
+# Maximum extended leaf number + CPU vendor string (AMD)
+
+0x80000000,         0,  eax,    31:0,    max_ext_leaf           , Maximum ex=
tended cpuid leaf supported
+0x80000000,         0,  ebx,    31:0,    cpu_vendorid_0         , Vendor ID =
string bytes 0 - 3
+0x80000000,         0,  ecx,    31:0,    cpu_vendorid_2         , Vendor ID =
string bytes 8 - 11
+0x80000000,         0,  edx,    31:0,    cpu_vendorid_1         , Vendor ID =
string bytes 4 - 7
=20
 # Leaf 80000001H
-# Extended Processor Signature and Feature Bits
-
-0x80000001,    0,  EAX,  27:20, extfamily, Extended family
-0x80000001,    0,  EAX,  19:16, extmodel, Extended model
-0x80000001,    0,  EAX,   11:8, basefamily, Description of Family
-0x80000001,    0,  EAX,   11:8, basemodel, Model numbers vary with product
-0x80000001,    0,  EAX,    3:0, stepping, Processor stepping (revision) for =
a specific model
-
-0x80000001,    0,  EBX,  31:28, pkgtype, Specifies the package type
-
-0x80000001,    0,  ECX,      0, lahf_lm, LAHF/SAHF available in 64-bit mode
-0x80000001,    0,  ECX,      1, cmplegacy, Core multi-processing legacy mode
-0x80000001,    0,  ECX,      2, svm, Indicates support for: VMRUN, VMLOAD, V=
MSAVE, CLGI, VMMCALL, and INVLPGA
-0x80000001,    0,  ECX,      3, extapicspace, Extended APIC register space
-0x80000001,    0,  ECX,      4, altmovecr8, Indicates support for LOCK MOV C=
R0 means MOV CR8
-0x80000001,    0,  ECX,      5, lzcnt, LZCNT
-0x80000001,    0,  ECX,      6, sse4a, EXTRQ, INSERTQ, MOVNTSS, and MOVNTSD =
instruction support
-0x80000001,    0,  ECX,      7, misalignsse, Misaligned SSE Mode
-0x80000001,    0,  ECX,      8, prefetchw, PREFETCHW
-0x80000001,    0,  ECX,      9, osvw, OS Visible Work-around support
-0x80000001,    0,  ECX,     10, ibs, Instruction Based Sampling
-0x80000001,    0,  ECX,     11, xop, Extended operation support
-0x80000001,    0,  ECX,     12, skinit, SKINIT and STGI support
-0x80000001,    0,  ECX,     13, wdt, Watchdog timer support
-0x80000001,    0,  ECX,     15, lwp, Lightweight profiling support
-0x80000001,    0,  ECX,     16, fma4, Four-operand FMA instruction support
-0x80000001,    0,  ECX,     17, tce, Translation cache extension
-0x80000001,    0,  ECX,     22, TopologyExtensions, Indicates support for Co=
re::X86::Cpuid::CachePropEax0 and Core::X86::Cpuid::ExtApicId
-0x80000001,    0,  ECX,     23, perfctrextcore, Indicates support for Core::=
X86::Msr::PERF_CTL0 - 5 and Core::X86::Msr::PERF_CTR
-0x80000001,    0,  ECX,     24, perfctrextdf, Indicates support for Core::X8=
6::Msr::DF_PERF_CTL and Core::X86::Msr::DF_PERF_CTR
-0x80000001,    0,  ECX,     26, databreakpointextension, Indicates data brea=
kpoint support for Core::X86::Msr::DR0_ADDR_MASK, Core::X86::Msr::DR1_ADDR_MA=
SK, Core::X86::Msr::DR2_ADDR_MASK and Core::X86::Msr::DR3_ADDR_MASK
-0x80000001,    0,  ECX,     27, perftsc, Performance time-stamp counter supp=
orted
-0x80000001,    0,  ECX,     28, perfctrextllc, Indicates support for L3 perf=
ormance counter extensions
-0x80000001,    0,  ECX,     29, mwaitextended, MWAITX and MONITORX capabilit=
y is supported
-0x80000001,    0,  ECX,     30, admskextn, Indicates support for address mas=
k extension (to 32 bits and to all 4 DRs) for instruction breakpoints
-
-0x80000001,    0,  EDX,      0, fpu, x87 floating point unit on-chip
-0x80000001,    0,  EDX,      1, vme, Virtual-mode enhancements
-0x80000001,    0,  EDX,      2, de, Debugging extensions, IO breakpoints, CR=
4.DE
-0x80000001,    0,  EDX,      3, pse, Page-size extensions (4 MB pages)
-0x80000001,    0,  EDX,      4, tsc, Time stamp counter, RDTSC/RDTSCP instru=
ctions, CR4.TSD
-0x80000001,    0,  EDX,      5, msr, Model-specific registers (MSRs), with R=
DMSR and WRMSR instructions
-0x80000001,    0,  EDX,      6, pae, Physical-address extensions (PAE)
-0x80000001,    0,  EDX,      7, mce, Machine Check Exception, CR4.MCE
-0x80000001,    0,  EDX,      8, cmpxchg8b, CMPXCHG8B instruction
-0x80000001,    0,  EDX,      9, apic, advanced programmable interrupt contro=
ller (APIC) exists and is enabled
-0x80000001,    0,  EDX,     11, sysret, SYSCALL/SYSRET supported
-0x80000001,    0,  EDX,     12, mtrr, Memory-type range registers
-0x80000001,    0,  EDX,     13, pge, Page global extension, CR4.PGE
-0x80000001,    0,  EDX,     14, mca, Machine check architecture, MCG_CAP
-0x80000001,    0,  EDX,     15, cmov, Conditional move instructions, CMOV, F=
COMI, FCMOV
-0x80000001,    0,  EDX,     16, pat, Page attribute table
-0x80000001,    0,  EDX,     17, pse36, Page-size extensions
-0x80000001,    0,  EDX,     20, exec_dis, Execute Disable Bit available
-0x80000001,    0,  EDX,     22, mmxext, AMD extensions to MMX instructions
-0x80000001,    0,  EDX,     23, mmx, MMX instructions
-0x80000001,    0,  EDX,     24, fxsr, FXSAVE and FXRSTOR instructions
-0x80000001,    0,  EDX,     25, ffxsr, FXSAVE and FXRSTOR instruction optimi=
zations
-0x80000001,    0,  EDX,     26, 1gb_page, 1GB page supported
-0x80000001,    0,  EDX,     27, rdtscp, RDTSCP and IA32_TSC_AUX are available
-0x80000001,    0,  EDX,     29, lm, 64b Architecture supported
-0x80000001,    0,  EDX,     30, threednowext, AMD extensions to 3DNow! instr=
uctions
-0x80000001,    0,  EDX,     31, threednow, 3DNow! instructions
-
-# Leaf 80000002H/80000003H/80000004H
-# Processor Brand String
+# Extended CPU feature identifiers
+
+0x80000001,         0,  eax,     3:0,    e_stepping_id          , Stepping ID
+0x80000001,         0,  eax,     7:4,    e_base_model           , Base proce=
ssor model
+0x80000001,         0,  eax,    11:8,    e_base_family          , Base proce=
ssor family
+0x80000001,         0,  eax,   19:16,    e_ext_model            , Extended p=
rocessor model
+0x80000001,         0,  eax,   27:20,    e_ext_family           , Extended p=
rocessor family
+0x80000001,         0,  ebx,    15:0,    brand_id               , Brand ID
+0x80000001,         0,  ebx,   31:28,    pkg_type               , Package ty=
pe
+0x80000001,         0,  ecx,       0,    lahf_lm                , LAHF and S=
AHF in 64-bit mode
+0x80000001,         0,  ecx,       1,    cmp_legacy             , Multi-proc=
essing legacy mode (No HT)
+0x80000001,         0,  ecx,       2,    svm                    , Secure Vir=
tual Machine
+0x80000001,         0,  ecx,       3,    extapic                , Extended A=
PIC space
+0x80000001,         0,  ecx,       4,    cr8_legacy             , LOCK MOV C=
R0 means MOV CR8
+0x80000001,         0,  ecx,       5,    abm                    , LZCNT adva=
nced bit manipulation
+0x80000001,         0,  ecx,       6,    sse4a                  , SSE4A supp=
ort
+0x80000001,         0,  ecx,       7,    misalignsse            , Misaligned=
 SSE mode
+0x80000001,         0,  ecx,       8,    3dnowprefetch          , 3DNow PREF=
ETCH/PREFETCHW support
+0x80000001,         0,  ecx,       9,    osvw                   , OS visible=
 workaround
+0x80000001,         0,  ecx,      10,    ibs                    , Instructio=
n based sampling
+0x80000001,         0,  ecx,      11,    xop                    , XOP: exten=
ded operation (AVX instructions)
+0x80000001,         0,  ecx,      12,    skinit                 , SKINIT/STG=
I support
+0x80000001,         0,  ecx,      13,    wdt                    , Watchdog t=
imer support
+0x80000001,         0,  ecx,      15,    lwp                    , Lightweigh=
t profiling
+0x80000001,         0,  ecx,      16,    fma4                   , 4-operand =
FMA instruction
+0x80000001,         0,  ecx,      17,    tce                    , Translatio=
n cache extension
+0x80000001,         0,  ecx,      19,    nodeid_msr             , NodeId MSR=
 (0xc001100c)
+0x80000001,         0,  ecx,      21,    tbm                    , Trailing b=
it manipulations
+0x80000001,         0,  ecx,      22,    topoext                , Topology E=
xtensions (cpuid leaf 0x8000001d)
+0x80000001,         0,  ecx,      23,    perfctr_core           , Core perfo=
rmance counter extensions
+0x80000001,         0,  ecx,      24,    perfctr_nb             , NB/DF perf=
ormance counter extensions
+0x80000001,         0,  ecx,      26,    bpext                  , Data acces=
s breakpoint extension
+0x80000001,         0,  ecx,      27,    ptsc                   , Performanc=
e time-stamp counter
+0x80000001,         0,  ecx,      28,    perfctr_llc            , LLC (L3) p=
erformance counter extensions
+0x80000001,         0,  ecx,      29,    mwaitx                 , MWAITX/MON=
ITORX support
+0x80000001,         0,  ecx,      30,    addr_mask_ext          , Breakpoint=
 address mask extension (to bit 31)
+0x80000001,         0,  edx,       0,    e_fpu                  , Floating-P=
oint Unit on-chip (x87)
+0x80000001,         0,  edx,       1,    e_vme                  , Virtual-80=
86 Mode Extensions
+0x80000001,         0,  edx,       2,    e_de                   , Debugging =
Extensions
+0x80000001,         0,  edx,       3,    e_pse                  , Page Size =
Extension
+0x80000001,         0,  edx,       4,    e_tsc                  , Time Stamp=
 Counter
+0x80000001,         0,  edx,       5,    e_msr                  , Model-Spec=
ific Registers (RDMSR and WRMSR support)
+0x80000001,         0,  edx,       6,    pae                    , Physical A=
ddress Extensions
+0x80000001,         0,  edx,       7,    mce                    , Machine Ch=
eck Exception
+0x80000001,         0,  edx,       8,    cx8                    , CMPXCHG8B =
instruction
+0x80000001,         0,  edx,       9,    apic                   , APIC on-ch=
ip
+0x80000001,         0,  edx,      11,    syscall                , SYSCALL an=
d SYSRET instructions
+0x80000001,         0,  edx,      12,    mtrr                   , Memory Typ=
e Range Registers
+0x80000001,         0,  edx,      13,    pge                    , Page Globa=
l Extensions
+0x80000001,         0,  edx,      14,    mca                    , Machine Ch=
eck Architecture
+0x80000001,         0,  edx,      15,    cmov                   , Conditiona=
l Move Instruction
+0x80000001,         0,  edx,      16,    pat                    , Page Attri=
bute Table
+0x80000001,         0,  edx,      17,    pse36                  , Page Size =
Extension (36-bit)
+0x80000001,         0,  edx,      19,    mp                     , Out-of-spe=
c AMD Multiprocessing bit
+0x80000001,         0,  edx,      20,    nx                     , No-execute=
 page protection
+0x80000001,         0,  edx,      22,    mmxext                 , AMD MMX ex=
tensions
+0x80000001,         0,  edx,      24,    e_fxsr                 , FXSAVE and=
 FXRSTOR instructions
+0x80000001,         0,  edx,      25,    fxsr_opt               , FXSAVE and=
 FXRSTOR optimizations
+0x80000001,         0,  edx,      26,    pdpe1gb                , 1-GB large=
 page support
+0x80000001,         0,  edx,      27,    rdtscp                 , RDTSCP ins=
truction
+0x80000001,         0,  edx,      29,    lm                     , Long mode =
(x86-64, 64-bit support)
+0x80000001,         0,  edx,      30,    3dnowext               , AMD 3DNow =
extensions
+0x80000001,         0,  edx,      31,    3dnow                  , 3DNow inst=
ructions
+
+# Leaf 80000002H
+# CPU brand ID string, bytes 0 - 15
+
+0x80000002,         0,  eax,    31:0,    cpu_brandid_0          , CPU brand =
ID string, bytes 0 - 3
+0x80000002,         0,  ebx,    31:0,    cpu_brandid_1          , CPU brand =
ID string, bytes 4 - 7
+0x80000002,         0,  ecx,    31:0,    cpu_brandid_2          , CPU brand =
ID string, bytes 8 - 11
+0x80000002,         0,  edx,    31:0,    cpu_brandid_3          , CPU brand =
ID string, bytes 12 - 15
+
+# Leaf 80000003H
+# CPU brand ID string, bytes 16 - 31
+
+0x80000003,         0,  eax,    31:0,    cpu_brandid_4          , CPU brand =
ID string bytes, 16 - 19
+0x80000003,         0,  ebx,    31:0,    cpu_brandid_5          , CPU brand =
ID string bytes, 20 - 23
+0x80000003,         0,  ecx,    31:0,    cpu_brandid_6          , CPU brand =
ID string bytes, 24 - 27
+0x80000003,         0,  edx,    31:0,    cpu_brandid_7          , CPU brand =
ID string bytes, 28 - 31
+
+# Leaf 80000004H
+# CPU brand ID string, bytes 32 - 47
+
+0x80000004,         0,  eax,    31:0,    cpu_brandid_8          , CPU brand =
ID string, bytes 32 - 35
+0x80000004,         0,  ebx,    31:0,    cpu_brandid_9          , CPU brand =
ID string, bytes 36 - 39
+0x80000004,         0,  ecx,    31:0,    cpu_brandid_10         , CPU brand =
ID string, bytes 40 - 43
+0x80000004,         0,  edx,    31:0,    cpu_brandid_11         , CPU brand =
ID string, bytes 44 - 47
=20
 # Leaf 80000005H
-# Reserved
+# AMD L1 cache and L1 TLB enumeration
+
+0x80000005,         0,  eax,     7:0,    l1_itlb_2m_4m_nentries , L1 ITLB #e=
ntires, 2M and 4M pages
+0x80000005,         0,  eax,    15:8,    l1_itlb_2m_4m_assoc    , L1 ITLB as=
sociativity, 2M and 4M pages
+0x80000005,         0,  eax,   23:16,    l1_dtlb_2m_4m_nentries , L1 DTLB #e=
ntires, 2M and 4M pages
+0x80000005,         0,  eax,   31:24,    l1_dtlb_2m_4m_assoc    , L1 DTLB as=
sociativity, 2M and 4M pages
+0x80000005,         0,  ebx,     7:0,    l1_itlb_4k_nentries    , L1 ITLB #e=
ntries, 4K pages
+0x80000005,         0,  ebx,    15:8,    l1_itlb_4k_assoc       , L1 ITLB as=
sociativity, 4K pages
+0x80000005,         0,  ebx,   23:16,    l1_dtlb_4k_nentries    , L1 DTLB #e=
ntries, 4K pages
+0x80000005,         0,  ebx,   31:24,    l1_dtlb_4k_assoc       , L1 DTLB as=
sociativity, 4K pages
+0x80000005,         0,  ecx,     7:0,    l1_dcache_line_size    , L1 dcache =
line size, in bytes
+0x80000005,         0,  ecx,    15:8,    l1_dcache_nlines       , L1 dcache =
lines per tag
+0x80000005,         0,  ecx,   23:16,    l1_dcache_assoc        , L1 dcache =
associativity
+0x80000005,         0,  ecx,   31:24,    l1_dcache_size_kb      , L1 dcache =
size, in KB
+0x80000005,         0,  edx,     7:0,    l1_icache_line_size    , L1 icache =
line size, in bytes
+0x80000005,         0,  edx,    15:8,    l1_icache_nlines       , L1 icache =
lines per tag
+0x80000005,         0,  edx,   23:16,    l1_icache_assoc        , L1 icache =
associativity
+0x80000005,         0,  edx,   31:24,    l1_icache_size_kb      , L1 icache =
size, in KB
=20
 # Leaf 80000006H
-# Extended L2 Cache Features
-
-0x80000006,    0,  ECX,    7:0, clsize, Cache Line size in bytes
-0x80000006,    0,  ECX,  15:12, l2c_assoc, L2 Associativity
-0x80000006,    0,  ECX,  31:16, csize, Cache size in 1K units
-
+# (Mostly AMD) L2 TLB, L2 cache, and L3 cache enumeration
+
+0x80000006,         0,  eax,    11:0,    l2_itlb_2m_4m_nentries , L2 iTLB #e=
ntries, 2M and 4M pages
+0x80000006,         0,  eax,   15:12,    l2_itlb_2m_4m_assoc    , L2 iTLB as=
sociativity, 2M and 4M pages
+0x80000006,         0,  eax,   27:16,    l2_dtlb_2m_4m_nentries , L2 dTLB #e=
ntries, 2M and 4M pages
+0x80000006,         0,  eax,   31:28,    l2_dtlb_2m_4m_assoc    , L2 dTLB as=
sociativity, 2M and 4M pages
+0x80000006,         0,  ebx,    11:0,    l2_itlb_4k_nentries    , L2 iTLB #e=
ntries, 4K pages
+0x80000006,         0,  ebx,   15:12,    l2_itlb_4k_assoc       , L2 iTLB as=
sociativity, 4K pages
+0x80000006,         0,  ebx,   27:16,    l2_dtlb_4k_nentries    , L2 dTLB #e=
ntries, 4K pages
+0x80000006,         0,  ebx,   31:28,    l2_dtlb_4k_assoc       , L2 dTLB as=
sociativity, 4K pages
+0x80000006,         0,  ecx,     7:0,    l2_line_size           , L2 cache l=
ine size, in bytes
+0x80000006,         0,  ecx,    11:8,    l2_nlines              , L2 cache n=
umber of lines per tag
+0x80000006,         0,  ecx,   15:12,    l2_assoc               , L2 cache a=
ssociativity
+0x80000006,         0,  ecx,   31:16,    l2_size_kb             , L2 cache s=
ize, in KB
+0x80000006,         0,  edx,     7:0,    l3_line_size           , L3 cache l=
ine size, in bytes
+0x80000006,         0,  edx,    11:8,    l3_nlines              , L3 cache n=
umber of lines per tag
+0x80000006,         0,  edx,   15:12,    l3_assoc               , L3 cache a=
ssociativity
+0x80000006,         0,  edx,   31:18,    l3_size_range          , L3 cache s=
ize range
=20
 # Leaf 80000007H
-
-0x80000007,    0,  EDX,      8, nonstop_tsc, Invariant TSC available
-
+# CPU power management (mostly AMD) and AMD RAS enumeration
+
+0x80000007,         0,  ebx,       0,    overflow_recov         , MCA overfl=
ow conditions not fatal
+0x80000007,         0,  ebx,       1,    succor                 , Software c=
ontainment of UnCORRectable errors
+0x80000007,         0,  ebx,       2,    hw_assert              , Hardware a=
ssert MSRs
+0x80000007,         0,  ebx,       3,    smca                   , Scalable M=
CA (MCAX MSRs)
+0x80000007,         0,  ecx,    31:0,    cpu_pwr_sample_ratio   , CPU power =
sample time ratio
+0x80000007,         0,  edx,       0,    digital_temp           , Digital te=
mprature sensor
+0x80000007,         0,  edx,       1,    powernow_freq_id       , PowerNOW! =
frequency scaling
+0x80000007,         0,  edx,       2,    powernow_volt_id       , PowerNOW! =
voltage scaling
+0x80000007,         0,  edx,       3,    thermal_trip           , THERMTRIP =
(Thermal Trip)
+0x80000007,         0,  edx,       4,    hw_thermal_control     , Hardware t=
hermal control
+0x80000007,         0,  edx,       5,    sw_thermal_control     , Software t=
hermal control
+0x80000007,         0,  edx,       6,    100mhz_steps           , 100 MHz mu=
ltiplier control
+0x80000007,         0,  edx,       7,    hw_pstate              , Hardware P=
-state control
+0x80000007,         0,  edx,       8,    constant_tsc           , TSC ticks =
at constant rate across all P and C states
+0x80000007,         0,  edx,       9,    cpb                    , Core perfo=
rmance boost
+0x80000007,         0,  edx,      10,    eff_freq_ro            , Read-only =
effective frequency interface
+0x80000007,         0,  edx,      11,    proc_feedback          , Processor =
feedback interface (deprecated)
+0x80000007,         0,  edx,      12,    acc_power              , Processor =
power reporting interface
+0x80000007,         0,  edx,      13,    connected_standby      , CPU Connec=
ted Standby support
+0x80000007,         0,  edx,      14,    rapl                   , Runtime Av=
erage Power Limit interface
=20
 # Leaf 80000008H
-
-0x80000008,    0,  EAX,    7:0, phy_adr_bits, Physical Address Bits
-0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
-0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
-
-# 0x8000001E
-# EAX: Extended APIC ID
-0x8000001E,	0, EAX,   31:0, extended_apic_id, Extended APIC ID
-# EBX: Core Identifiers
-0x8000001E,	0, EBX,    7:0, core_id, Identifies the logical core ID
-0x8000001E,	0, EBX,   15:8, threads_per_core, The number of threads per core=
 is threads_per_core + 1
-# ECX: Node Identifiers
-0x8000001E,	0, ECX,    7:0, node_id, Node ID
-0x8000001E,	0, ECX,   10:8, nodes_per_processor, Nodes per processor { 0: 1 =
node, else reserved }
-
-# 8000001F: AMD Secure Encryption
-0x8000001F,	0, EAX,	     0, sme,	Secure Memory Encryption
-0x8000001F,	0, EAX,      1, sev,	Secure Encrypted Virtualization
-0x8000001F,	0, EAX,      2, vmpgflush, VM Page Flush MSR
-0x8000001F,	0, EAX,      3, seves, SEV Encrypted State
-0x8000001F,	0, EBX,    5:0, c-bit, Page table bit number used to enable memo=
ry encryption
-0x8000001F,	0, EBX,   11:6, mem_encrypt_physaddr_width, Reduction of physica=
l address space in bits with SME enabled
-0x8000001F,	0, ECX,   31:0, num_encrypted_guests, Maximum ASID value that ma=
y be used for an SEV-enabled guest
-0x8000001F,	0, EDX,   31:0, minimum_sev_asid, Minimum ASID value that must b=
e used for an SEV-enabled, SEV-ES-disabled guest
+# CPU capacity parameters and extended feature flags (mostly AMD)
+
+0x80000008,         0,  eax,     7:0,    phys_addr_bits         , Max physic=
al address bits
+0x80000008,         0,  eax,    15:8,    virt_addr_bits         , Max virtua=
l address bits
+0x80000008,         0,  eax,   23:16,    guest_phys_addr_bits   , Max nested=
-paging guest physical address bits
+0x80000008,         0,  ebx,       0,    clzero                 , CLZERO sup=
ported
+0x80000008,         0,  ebx,       1,    irperf                 , Instructio=
n retired counter MSR
+0x80000008,         0,  ebx,       2,    xsaveerptr             , XSAVE/XRST=
OR always saves/restores FPU error pointers
+0x80000008,         0,  ebx,       3,    invlpgb                , INVLPGB br=
oadcasts a TLB invalidate to all threads
+0x80000008,         0,  ebx,       4,    rdpru                  , RDPRU (Rea=
d Processor Register at User level) supported
+0x80000008,         0,  ebx,       6,    mba                    , Memory Ban=
dwidth Allocation (AMD bit)
+0x80000008,         0,  ebx,       8,    mcommit                , MCOMMIT (M=
emory commit) supported
+0x80000008,         0,  ebx,       9,    wbnoinvd               , WBNOINVD s=
upported
+0x80000008,         0,  ebx,      12,    amd_ibpb               , Indirect B=
ranch Prediction Barrier
+0x80000008,         0,  ebx,      13,    wbinvd_int             , Interrupti=
ble WBINVD/WBNOINVD
+0x80000008,         0,  ebx,      14,    amd_ibrs               , Indirect B=
ranch Restricted Speculation
+0x80000008,         0,  ebx,      15,    amd_stibp              , Single Thr=
ead Indirect Branch Prediction mode
+0x80000008,         0,  ebx,      16,    ibrs_always_on         , IBRS alway=
s-on preferred
+0x80000008,         0,  ebx,      17,    amd_stibp_always_on    , STIBP alwa=
ys-on preferred
+0x80000008,         0,  ebx,      18,    ibrs_fast              , IBRS is pr=
eferred over software solution
+0x80000008,         0,  ebx,      19,    ibrs_same_mode         , IBRS provi=
des same mode protection
+0x80000008,         0,  ebx,      20,    no_efer_lmsle          , EFER[LMSLE=
] bit (Long-Mode Segment Limit Enable) unsupported
+0x80000008,         0,  ebx,      21,    tlb_flush_nested       , INVLPGB RA=
X[5] bit can be set (nested translations)
+0x80000008,         0,  ebx,      23,    amd_ppin               , Protected =
Processor Inventory Number
+0x80000008,         0,  ebx,      24,    amd_ssbd               , Speculativ=
e Store Bypass Disable
+0x80000008,         0,  ebx,      25,    virt_ssbd              , virtualize=
d SSBD (Speculative Store Bypass Disable)
+0x80000008,         0,  ebx,      26,    amd_ssb_no             , SSBD not n=
eeded (fixed in HW)
+0x80000008,         0,  ebx,      27,    cppc                   , Collaborat=
ive Processor Performance Control
+0x80000008,         0,  ebx,      28,    amd_psfd               , Predictive=
 Store Forward Disable
+0x80000008,         0,  ebx,      29,    btc_no                 , CPU not af=
fected by Branch Type Confusion
+0x80000008,         0,  ebx,      30,    ibpb_ret               , IBPB clear=
s RSB/RAS too
+0x80000008,         0,  ebx,      31,    brs                    , Branch Sam=
pling supported
+0x80000008,         0,  ecx,     7:0,    cpu_nthreads           , Number of =
physical threads - 1
+0x80000008,         0,  ecx,   15:12,    apicid_coreid_len      , Number of =
thread core ID bits (shift) in APIC ID
+0x80000008,         0,  ecx,   17:16,    perf_tsc_len           , Performanc=
e time-stamp counter size
+0x80000008,         0,  edx,    15:0,    invlpgb_max_pages      , INVLPGB ma=
ximum page count
+0x80000008,         0,  edx,   31:16,    rdpru_max_reg_id       , RDPRU max =
register ID (ECX input)
+
+# Leaf 8000000AH
+# AMD SVM (Secure Virtual Machine) enumeration
+
+0x8000000a,         0,  eax,     7:0,    svm_version            , SVM revisi=
on number
+0x8000000a,         0,  ebx,    31:0,    svm_nasid              , Number of =
address space identifiers (ASID)
+0x8000000a,         0,  edx,       0,    npt                    , Nested pag=
ing
+0x8000000a,         0,  edx,       1,    lbrv                   , LBR virtua=
lization
+0x8000000a,         0,  edx,       2,    svm_lock               , SVM lock
+0x8000000a,         0,  edx,       3,    nrip_save              , NRIP save =
support on #VMEXIT
+0x8000000a,         0,  edx,       4,    tsc_scale              , MSR based =
TSC rate control
+0x8000000a,         0,  edx,       5,    vmcb_clean             , VMCB clean=
 bits support
+0x8000000a,         0,  edx,       6,    flushbyasid            , Flush by A=
SID + Extended VMCB TLB_Control
+0x8000000a,         0,  edx,       7,    decodeassists          , Decode Ass=
ists support
+0x8000000a,         0,  edx,      10,    pausefilter            , Pause inte=
rcept filter
+0x8000000a,         0,  edx,      12,    pfthreshold            , Pause filt=
er threshold
+0x8000000a,         0,  edx,      13,    avic                   , Advanced v=
irtual interrupt controller
+0x8000000a,         0,  edx,      15,    v_vmsave_vmload        , Virtual VM=
SAVE/VMLOAD (nested virt)
+0x8000000a,         0,  edx,      16,    vgif                   , Virtualize=
 the Global Interrupt Flag
+0x8000000a,         0,  edx,      17,    gmet                   , Guest mode=
 execution trap
+0x8000000a,         0,  edx,      18,    x2avic                 , Virtual x2=
APIC
+0x8000000a,         0,  edx,      19,    sss_check              , Supervisor=
 Shadow Stack restrictions
+0x8000000a,         0,  edx,      20,    v_spec_ctrl            , Virtual SP=
EC_CTRL
+0x8000000a,         0,  edx,      21,    ro_gpt                 , Read-Only =
guest page table support
+0x8000000a,         0,  edx,      23,    h_mce_override         , Host MCE o=
verride
+0x8000000a,         0,  edx,      24,    tlbsync_int            , TLBSYNC in=
tercept + INVLPGB/TLBSYNC in VMCB
+0x8000000a,         0,  edx,      25,    vnmi                   , NMI virtua=
lization
+0x8000000a,         0,  edx,      26,    ibs_virt               , IBS Virtua=
lization
+0x8000000a,         0,  edx,      27,    ext_lvt_off_chg        , Extended L=
VT offset fault change
+0x8000000a,         0,  edx,      28,    svme_addr_chk          , Guest SVME=
 addr check
+
+# Leaf 80000019H
+# AMD TLB 1G-pages enumeration
+
+0x80000019,         0,  eax,    11:0,    l1_itlb_1g_nentries    , L1 iTLB #e=
ntries, 1G pages
+0x80000019,         0,  eax,   15:12,    l1_itlb_1g_assoc       , L1 iTLB as=
sociativity, 1G pages
+0x80000019,         0,  eax,   27:16,    l1_dtlb_1g_nentries    , L1 dTLB #e=
ntries, 1G pages
+0x80000019,         0,  eax,   31:28,    l1_dtlb_1g_assoc       , L1 dTLB as=
sociativity, 1G pages
+0x80000019,         0,  ebx,    11:0,    l2_itlb_1g_nentries    , L2 iTLB #e=
ntries, 1G pages
+0x80000019,         0,  ebx,   15:12,    l2_itlb_1g_assoc       , L2 iTLB as=
sociativity, 1G pages
+0x80000019,         0,  ebx,   27:16,    l2_dtlb_1g_nentries    , L2 dTLB #e=
ntries, 1G pages
+0x80000019,         0,  ebx,   31:28,    l2_dtlb_1g_assoc       , L2 dTLB as=
sociativity, 1G pages
+
+# Leaf 8000001AH
+# AMD instruction optimizations enumeration
+
+0x8000001a,         0,  eax,       0,    fp_128                 , Internal F=
P/SIMD exec data path is 128-bits wide
+0x8000001a,         0,  eax,       1,    movu_preferred         , SSE: MOVU*=
 better than MOVL*/MOVH*
+0x8000001a,         0,  eax,       2,    fp_256                 , internal F=
P/SSE exec data path is 256-bits wide
+
+# Leaf 8000001BH
+# AMD IBS (Instruction-Based Sampling) enumeration
+
+0x8000001b,         0,  eax,       0,    ibs_flags_valid        , IBS featur=
e flags valid
+0x8000001b,         0,  eax,       1,    ibs_fetch_sampling     , IBS fetch =
sampling supported
+0x8000001b,         0,  eax,       2,    ibs_op_sampling        , IBS execut=
ion sampling supported
+0x8000001b,         0,  eax,       3,    ibs_rdwr_op_counter    , IBS read/w=
rite of op counter supported
+0x8000001b,         0,  eax,       4,    ibs_op_count           , IBS OP cou=
nting mode supported
+0x8000001b,         0,  eax,       5,    ibs_branch_target      , IBS branch=
 target address reporting supported
+0x8000001b,         0,  eax,       6,    ibs_op_counters_ext    , IBS IbsOpC=
urCnt/IbsOpMaxCnt extend by 7 bits
+0x8000001b,         0,  eax,       7,    ibs_rip_invalid_chk    , IBS invali=
d RIP indication supported
+0x8000001b,         0,  eax,       8,    ibs_op_branch_fuse     , IBS fused =
branch micro-op indication supported
+0x8000001b,         0,  eax,       9,    ibs_fetch_ctl_ext      , IBS Fetch =
Control Extended MSR (0xc001103c) supported
+0x8000001b,         0,  eax,      10,    ibs_op_data_4          , IBS op dat=
a 4 MSR supported
+0x8000001b,         0,  eax,      11,    ibs_l3_miss_filter     , IBS L3-mis=
s filtering supported (Zen4+)
+
+# Leaf 8000001CH
+# AMD LWP (Lightweight Profiling)
+
+0x8000001c,         0,  eax,       0,    os_lwp_avail           , LWP is ava=
ilable to application programs (supported by OS)
+0x8000001c,         0,  eax,       1,    os_lpwval              , LWPVAL ins=
truction (EventId=3D1) is supported by OS
+0x8000001c,         0,  eax,       2,    os_lwp_ire             , Instructio=
ns Retired Event (EventId=3D2) is supported by OS
+0x8000001c,         0,  eax,       3,    os_lwp_bre             , Branch Ret=
ired Event (EventId=3D3) is supported by OS
+0x8000001c,         0,  eax,       4,    os_lwp_dme             , DCache Mis=
s Event (EventId=3D4) is supported by OS
+0x8000001c,         0,  eax,       5,    os_lwp_cnh             , CPU Clocks=
 Not Halted event (EventId=3D5) is supported by OS
+0x8000001c,         0,  eax,       6,    os_lwp_rnh             , CPU Refere=
nce clocks Not Halted event (EventId=3D6) is supported by OS
+0x8000001c,         0,  eax,      29,    os_lwp_cont            , LWP sampli=
ng in continuous mode is supported by OS
+0x8000001c,         0,  eax,      30,    os_lwp_ptsc            , Performanc=
e Time Stamp Counter in event records is supported by OS
+0x8000001c,         0,  eax,      31,    os_lwp_int             , Interrupt =
on threshold overflow is supported by OS
+0x8000001c,         0,  ebx,     7:0,    lwp_lwpcb_sz           , LWP Contro=
l Block size, in quadwords
+0x8000001c,         0,  ebx,    15:8,    lwp_event_sz           , LWP event =
record size, in bytes
+0x8000001c,         0,  ebx,   23:16,    lwp_max_events         , LWP max su=
pported EventId value (EventID 255 not included)
+0x8000001c,         0,  ebx,   31:24,    lwp_event_offset       , LWP events=
 area offset in the LWP Control Block
+0x8000001c,         0,  ecx,     4:0,    lwp_latency_max        , Num of bit=
s in cache latency counters (10 to 31)
+0x8000001c,         0,  ecx,       5,    lwp_data_adddr         , Cache miss=
 events report the data address of the reference
+0x8000001c,         0,  ecx,     8:6,    lwp_latency_rnd        , Amount by =
which cache latency is rounded
+0x8000001c,         0,  ecx,    15:9,    lwp_version            , LWP implem=
entation version
+0x8000001c,         0,  ecx,   23:16,    lwp_buf_min_sz         , LWP event =
ring buffer min size, in units of 32 event records
+0x8000001c,         0,  ecx,      28,    lwp_branch_predict     , Branches R=
etired events can be filtered
+0x8000001c,         0,  ecx,      29,    lwp_ip_filtering       , IP filteri=
ng (IPI, IPF, BaseIP, and LimitIP @ LWPCP) supported
+0x8000001c,         0,  ecx,      30,    lwp_cache_levels       , Cache-rela=
ted events can be filtered by cache level
+0x8000001c,         0,  ecx,      31,    lwp_cache_latency      , Cache-rela=
ted events can be filtered by latency
+0x8000001c,         0,  edx,       0,    hw_lwp_avail           , LWP is ava=
ilable in Hardware
+0x8000001c,         0,  edx,       1,    hw_lpwval              , LWPVAL ins=
truction (EventId=3D1) is available in HW
+0x8000001c,         0,  edx,       2,    hw_lwp_ire             , Instructio=
ns Retired Event (EventId=3D2) is available in HW
+0x8000001c,         0,  edx,       3,    hw_lwp_bre             , Branch Ret=
ired Event (EventId=3D3) is available in HW
+0x8000001c,         0,  edx,       4,    hw_lwp_dme             , DCache Mis=
s Event (EventId=3D4) is available in HW
+0x8000001c,         0,  edx,       5,    hw_lwp_cnh             , CPU Clocks=
 Not Halted event (EventId=3D5) is available in HW
+0x8000001c,         0,  edx,       6,    hw_lwp_rnh             , CPU Refere=
nce clocks Not Halted event (EventId=3D6) is available in HW
+0x8000001c,         0,  edx,      29,    hw_lwp_cont            , LWP sampli=
ng in continuous mode is available in HW
+0x8000001c,         0,  edx,      30,    hw_lwp_ptsc            , Performanc=
e Time Stamp Counter in event records is available in HW
+0x8000001c,         0,  edx,      31,    hw_lwp_int             , Interrupt =
on threshold overflow is available in HW
+
+# Leaf 8000001DH
+# AMD deterministic cache parameters
+
+0x8000001d,      31:0,  eax,     4:0,    cache_type             , Cache type=
 field
+0x8000001d,      31:0,  eax,     7:5,    cache_level            , Cache leve=
l (1-based)
+0x8000001d,      31:0,  eax,       8,    cache_self_init        , Self-initi=
alizing cache level
+0x8000001d,      31:0,  eax,       9,    fully_associative      , Fully-asso=
ciative cache
+0x8000001d,      31:0,  eax,   25:14,    num_threads_sharing    , Number of =
logical CPUs sharing cache
+0x8000001d,      31:0,  ebx,    11:0,    cache_linesize         , System coh=
erency line size (0-based)
+0x8000001d,      31:0,  ebx,   21:12,    cache_npartitions      , Physical l=
ine partitions (0-based)
+0x8000001d,      31:0,  ebx,   31:22,    cache_nways            , Ways of as=
sociativity (0-based)
+0x8000001d,      31:0,  ecx,    30:0,    cache_nsets            , Cache numb=
er of sets (0-based)
+0x8000001d,      31:0,  edx,       0,    wbinvd_rll_no_guarantee, WBINVD/INV=
D not guaranteed for Remote Lower-Level caches
+0x8000001d,      31:0,  edx,       1,    ll_inclusive           , Cache is i=
nclusive of Lower-Level caches
+
+# Leaf 8000001EH
+# AMD CPU topology enumeration
+
+0x8000001e,         0,  eax,    31:0,    ext_apic_id            , Extended A=
PIC ID
+0x8000001e,         0,  ebx,     7:0,    core_id                , Unique per=
-socket logical core unit ID
+0x8000001e,         0,  ebx,    15:8,    core_nthreas           , #Threads p=
er core (zero-based)
+0x8000001e,         0,  ecx,     7:0,    node_id                , Node (die)=
 ID of invoking logical CPU
+0x8000001e,         0,  ecx,    10:8,    nnodes_per_socket      , #nodes in =
invoking logical CPU's package/socket
+
+# Leaf 8000001FH
+# AMD encrypted memory capabilities enumeration (SME/SEV)
+
+0x8000001f,         0,  eax,       0,    sme                    , Secure Mem=
ory Encryption supported
+0x8000001f,         0,  eax,       1,    sev                    , Secure Enc=
rypted Virtualization supported
+0x8000001f,         0,  eax,       2,    vm_page_flush          , VM Page Fl=
ush MSR (0xc001011e) available
+0x8000001f,         0,  eax,       3,    sev_es                 , SEV Encryp=
ted State supported
+0x8000001f,         0,  eax,       4,    sev_nested_paging      , SEV secure=
 nested paging supported
+0x8000001f,         0,  eax,       5,    vm_permission_levels   , VMPL suppo=
rted
+0x8000001f,         0,  eax,       6,    rpmquery               , RPMQUERY i=
nstruction supported
+0x8000001f,         0,  eax,       7,    vmpl_sss               , VMPL super=
visor shadwo stack supported
+0x8000001f,         0,  eax,       8,    secure_tsc             , Secure TSC=
 supported
+0x8000001f,         0,  eax,       9,    v_tsc_aux              , Hardware v=
irtualizes TSC_AUX
+0x8000001f,         0,  eax,      10,    sme_coherent           , HW enforce=
s cache coherency across encryption domains
+0x8000001f,         0,  eax,      11,    req_64bit_hypervisor   , SEV guest =
mandates 64-bit hypervisor
+0x8000001f,         0,  eax,      12,    restricted_injection   , Restricted=
 Injection supported
+0x8000001f,         0,  eax,      13,    alternate_injection    , Alternate =
Injection supported
+0x8000001f,         0,  eax,      14,    debug_swap             , SEV-ES: fu=
ll debug state swap is supported
+0x8000001f,         0,  eax,      15,    disallow_host_ibs      , SEV-ES: Di=
sallowing IBS use by the host is supported
+0x8000001f,         0,  eax,      16,    virt_transparent_enc   , Virtual Tr=
ansparent Encryption
+0x8000001f,         0,  eax,      17,    vmgexit_paremeter      , VmgexitPar=
ameter is supported in SEV_FEATURES
+0x8000001f,         0,  eax,      18,    virt_tom_msr           , Virtual TO=
M MSR is supported
+0x8000001f,         0,  eax,      19,    virt_ibs               , IBS state =
virtualization is supported for SEV-ES guests
+0x8000001f,         0,  eax,      24,    vmsa_reg_protection    , VMSA regis=
ter protection is supported
+0x8000001f,         0,  eax,      25,    smt_protection         , SMT protec=
tion is supported
+0x8000001f,         0,  eax,      28,    svsm_page_msr          , SVSM commu=
nication page MSR (0xc001f000h) is supported
+0x8000001f,         0,  eax,      29,    nested_virt_snp_msr    , VIRT_RMPUP=
DATE/VIRT_PSMASH MSRs are supported
+0x8000001f,         0,  ebx,     5:0,    pte_cbit_pos           , PTE bit nu=
mber used to enable memory encryption
+0x8000001f,         0,  ebx,    11:6,    phys_addr_reduction_nbits, Reductio=
n of phys address space when encryption is enabled, in bits
+0x8000001f,         0,  ebx,   15:12,    vmpl_count             , Number of =
VM permission levels (VMPL) supported
+0x8000001f,         0,  ecx,    31:0,    enc_guests_max         , Max suppor=
ted number of simultaneous encrypted guests
+0x8000001f,         0,  edx,    31:0,    min_sev_asid_no_sev_es , Mininum AS=
ID for SEV-enabled SEV-ES-disabled guest
+
+# Leaf 80000020H
+# AMD Platform QoS extended feature IDs
+
+0x80000020,         0,  ebx,       1,    mba                    , Memory Ban=
dwidth Allocation support
+0x80000020,         0,  ebx,       2,    smba                   , Slow Memor=
y Bandwidth Allocation support
+0x80000020,         0,  ebx,       3,    bmec                   , Bandwidth =
Monitoring Event Configuration support
+0x80000020,         0,  ebx,       4,    l3rr                   , L3 Range R=
eservation support
+0x80000020,         1,  eax,    31:0,    mba_limit_len          , MBA enforc=
ement limit size
+0x80000020,         1,  edx,    31:0,    mba_cos_max            , MBA max Cl=
ass of Service number (zero-based)
+0x80000020,         2,  eax,    31:0,    smba_limit_len         , SMBA enfor=
cement limit size
+0x80000020,         2,  edx,    31:0,    smba_cos_max           , SMBA max C=
lass of Service number (zero-based)
+0x80000020,         3,  ebx,     7:0,    bmec_num_events        , BMEC numbe=
r of bandwidth events available
+0x80000020,         3,  ecx,       0,    bmec_local_reads       , Local NUMA=
 reads can be tracked
+0x80000020,         3,  ecx,       1,    bmec_remote_reads      , Remote NUM=
A reads can be tracked
+0x80000020,         3,  ecx,       2,    bmec_local_nontemp_wr  , Local NUMA=
 non-temporal writes can be tracked
+0x80000020,         3,  ecx,       3,    bmec_remote_nontemp_wr , Remote NUM=
A non-temporal writes can be tracked
+0x80000020,         3,  ecx,       4,    bmec_local_slow_mem_rd , Local NUMA=
 slow-memory reads can be tracked
+0x80000020,         3,  ecx,       5,    bmec_remote_slow_mem_rd, Remote NUM=
A slow-memory reads can be tracked
+0x80000020,         3,  ecx,       6,    bmec_all_dirty_victims , Dirty QoS =
victims to all types of memory can be tracked
+
+# Leaf 80000021H
+# AMD extended features enumeration 2
+
+0x80000021,         0,  eax,       0,    no_nested_data_bp      , No nested =
data breakpoints
+0x80000021,         0,  eax,       1,    fsgs_non_serializing   , WRMSR to {=
FS,GS,KERNEL_GS}_BASE is non-serializing
+0x80000021,         0,  eax,       2,    lfence_rdtsc           , LFENCE alw=
ays serializing / synchronizes RDTSC
+0x80000021,         0,  eax,       3,    smm_page_cfg_lock      , SMM paging=
 configuration lock is supported
+0x80000021,         0,  eax,       6,    null_sel_clr_base      , Null selec=
tor clears base
+0x80000021,         0,  eax,       7,    upper_addr_ignore      , EFER MSR U=
pper Address Ignore Enable bit supported
+0x80000021,         0,  eax,       8,    autoibrs               , EFER MSR A=
utomatic IBRS enable bit supported
+0x80000021,         0,  eax,       9,    no_smm_ctl_msr         , SMM_CTL MS=
R (0xc0010116) is not present
+0x80000021,         0,  eax,      10,    fsrs_supported         , Fast Short=
 Rep Stosb (FSRS) is supported
+0x80000021,         0,  eax,      11,    fsrc_supported         , Fast Short=
 Repe Cmpsb (FSRC) is supported
+0x80000021,         0,  eax,      13,    prefetch_ctl_msr       , Prefetch c=
ontrol MSR is supported
+0x80000021,         0,  eax,      17,    user_cpuid_disable     , #GP when e=
xecuting CPUID at CPL > 0 is supported
+0x80000021,         0,  eax,      18,    epsf_supported         , Enhanced P=
redictive Store Forwarding (EPSF) is supported
+0x80000021,         0,  ebx,    11:0,    microcode_patch_size   , Size of mi=
crocode patch, in 16-byte units
+
+# Leaf 80000022H
+# AMD Performance Monitoring v2 enumeration
+
+0x80000022,         0,  eax,       0,    perfmon_v2             , Performanc=
e monitoring v2 supported
+0x80000022,         0,  eax,       1,    lbr_v2                 , Last Branc=
h Record v2 extensions (LBR Stack)
+0x80000022,         0,  eax,       2,    lbr_pmc_freeze         , Freezing c=
ore performance counters / LBR Stack supported
+0x80000022,         0,  ebx,     3:0,    n_pmc_core             , Number of =
core perfomance counters
+0x80000022,         0,  ebx,     9:4,    lbr_v2_stack_size      , Number of =
available LBR stack entries
+0x80000022,         0,  ebx,   15:10,    n_pmc_northbridge      , Number of =
available northbridge (data fabric) performance counters
+0x80000022,         0,  ebx,   21:16,    n_pmc_umc              , Number of =
available UMC performance counters
+0x80000022,         0,  ecx,    31:0,    active_umc_bitmask     , Active UMC=
s bitmask
+
+# Leaf 80000023H
+# AMD Secure Multi-key Encryption enumeration
+
+0x80000023,         0,  eax,       0,    mem_hmk_mode           , MEM-HMK en=
cryption mode is supported
+0x80000023,         0,  ebx,    15:0,    mem_hmk_avail_keys     , MEM-HMK mo=
de: total num of available encryption keys
+
+# Leaf 80000026H
+# AMD extended topology enumeration v2
+
+0x80000026,       3:0,  eax,     4:0,    x2apic_id_shift        , Bit width =
of this level (previous levels inclusive)
+0x80000026,       3:0,  eax,      29,    core_has_pwreff_ranking, This core =
has a power efficiency ranking
+0x80000026,       3:0,  eax,      30,    domain_has_hybrid_cores, This domai=
n level has hybrid (E, P) cores
+0x80000026,       3:0,  eax,      31,    domain_core_count_asymm, The 'Core'=
 domain has asymmetric cores count
+0x80000026,       3:0,  ebx,    15:0,    domain_lcpus_count     , Number of =
logical CPUs at this domain instance
+0x80000026,       3:0,  ebx,   23:16,    core_pwreff_ranking    , This core'=
s static power efficiency ranking
+0x80000026,       3:0,  ebx,   27:24,    core_native_model_id   , This core'=
s native model ID
+0x80000026,       3:0,  ebx,   31:28,    core_type              , This core'=
s type
+0x80000026,       3:0,  ecx,     7:0,    domain_level           , This domai=
n level (subleaf ID)
+0x80000026,       3:0,  ecx,    15:8,    domain_type            , This domai=
n type
+0x80000026,       3:0,  edx,    31:0,    x2apic_id              , x2APIC ID =
of current logical CPU

