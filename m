Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73DB330CC3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Mar 2021 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhCHLx1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Mar 2021 06:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhCHLxJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Mar 2021 06:53:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35253C06174A;
        Mon,  8 Mar 2021 03:53:09 -0800 (PST)
Date:   Mon, 08 Mar 2021 11:53:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615204387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYRJlM0NSxaSAglnu/M8Dnra4iMN3N7aNOES835kfPg=;
        b=FUSS7bPL1R2yu3B6JLzitxmHgNOs2eu9J+Mo8LXGycaQXoPI5fi1BdHFN/4VBLp3y1vI90
        Mw2ll/logI/T1prIsAOaSzKlF7TmRwlVhR4Ud1MQ/d71cMxjCsjTyZB9F60QxVatEzJOy7
        RqVmTdGf1cwVeaWTI/ViNY9c8hj4qQFRbi836dfhMlJfCP5kTo65qwBIzc7g3NMLvnKduy
        OW60PKh+WkPYPH2Xz+//JHYddzuELHZpBoJyafw4XCQDi3UYaMZuiXnsrg9hwyU1k4wXPO
        nET/COF0OjfC1e2No8YY2w5fhx4rM37mEa+EQ7rY4LTL996pi1HF5kp1uYRscQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615204387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYRJlM0NSxaSAglnu/M8Dnra4iMN3N7aNOES835kfPg=;
        b=l/Dewab/kGkk8LNGRDs6Xh3m5ecyYYkkhQGu2nckGOF6Va4RmeknpTWNsmGkOADjjOOUJ4
        dT76Z2m8XpbtMJAw==
From:   "tip-bot2 for Feng Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86: Add a kcpuid tool to show raw CPU features
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Feng Tang <feng.tang@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1614928878-86075-1-git-send-email-feng.tang@intel.com>
References: <1614928878-86075-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Message-ID: <161520438696.398.7056992855228842312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     c6b2f240bf8d5604e6507aff15d5c441944c2f89
Gitweb:        https://git.kernel.org/tip/c6b2f240bf8d5604e6507aff15d5c441944=
c2f89
Author:        Feng Tang <feng.tang@intel.com>
AuthorDate:    Fri, 05 Mar 2021 15:21:18 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Mar 2021 12:50:19 +01:00

tools/x86: Add a kcpuid tool to show raw CPU features

End users frequently want to know what features their processor
supports, independent of what the kernel supports.

/proc/cpuinfo is great. It is omnipresent and since it is provided by
the kernel it is always as up to date as the kernel. But, it could be
ambiguous about processor features which can be disabled by the kernel
at boot-time or compile-time.

There are some user space tools showing more raw features, but they are
not bound with kernel, and go with distros. Many end users are still
using old distros with new kernels (upgraded by themselves), and may
not upgrade the distros only to get a newer tool.

So here arise the need for a new tool, which
  * shows raw CPU features read from the CPUID instruction
  * will be easier to update compared to existing userspace
    tooling (perhaps distributed like perf)
  * inherits "modern" kernel development process, in contrast to some
    of the existing userspace CPUID tools which are still being developed
    without git and distributed in tarballs from non-https sites.
  * Can produce output consistent with /proc/cpuinfo to make comparison
    easier.

The CPUID leaf definitions are kept in an .csv file which allows for
updating only that file to add support for new feature leafs.

This is based on prototype code from Borislav Petkov
(http://sr71.net/~dave/intel/stupid-cpuid.c).

 [ bp:
   - Massage, add #define _GNU_SOURCE to fix implicit declaration of
     function =E2=80=98strcasestr' warning
   - remove superfluous newlines
   - fallback to cpuid.csv in the current dir if none found
   - fix typos
   - move comments over the lines instead of sideways. ]

Originally-from: Borislav Petkov <bp@alien8.de>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1614928878-86075-1-git-send-email-feng.tang@i=
ntel.com
---
 tools/arch/x86/kcpuid/Makefile  |  24 +-
 tools/arch/x86/kcpuid/cpuid.csv | 380 ++++++++++++++++++-
 tools/arch/x86/kcpuid/kcpuid.c  | 655 +++++++++++++++++++++++++++++++-
 3 files changed, 1059 insertions(+)
 create mode 100644 tools/arch/x86/kcpuid/Makefile
 create mode 100644 tools/arch/x86/kcpuid/cpuid.csv
 create mode 100644 tools/arch/x86/kcpuid/kcpuid.c

diff --git a/tools/arch/x86/kcpuid/Makefile b/tools/arch/x86/kcpuid/Makefile
new file mode 100644
index 0000000..87b554f
--- /dev/null
+++ b/tools/arch/x86/kcpuid/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for x86/kcpuid tool
+
+kcpuid : kcpuid.c
+
+CFLAGS =3D -Wextra
+
+BINDIR ?=3D /usr/sbin
+
+HWDATADIR ?=3D /usr/share/misc/
+
+override CFLAGS +=3D -O2 -Wall -I../../../include
+
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+
+.PHONY : clean
+clean :
+	@rm -f kcpuid
+
+install : kcpuid
+	install -d  $(DESTDIR)$(BINDIR)
+	install -m 755 -p kcpuid $(DESTDIR)$(BINDIR)/kcpuid
+	install -m 444 -p cpuid.csv $(HWDATADIR)/cpuid.csv
diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
new file mode 100644
index 0000000..f4a5b85
--- /dev/null
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -0,0 +1,380 @@
+# The basic row format is:
+# LEAF, SUBLEAF, register_name, bits, short_name, long_description
+
+# Leaf 00H
+         0,    0,  EAX,   31:0, max_basic_leafs, Max input value for support=
ed subleafs
+
+# Leaf 01H
+         1,    0,  EAX,    3:0, stepping, Stepping ID
+         1,    0,  EAX,    7:4, model, Model
+         1,    0,  EAX,   11:8, family, Family ID
+         1,    0,  EAX,  13:12, processor, Processor Type
+         1,    0,  EAX,  19:16, model_ext, Extended Model ID
+         1,    0,  EAX,  27:20, family_ext, Extended Family ID
+
+         1,    0,  EBX,    7:0, brand, Brand Index
+         1,    0,  EBX,   15:8, clflush_size, CLFLUSH line size (value * 8) =
in bytes
+         1,    0,  EBX,  23:16, max_cpu_id, Maxim number of addressable logi=
c cpu in this package
+         1,    0,  EBX,  31:24, apic_id, Initial APIC ID
+
+         1,    0,  ECX,      0, sse3, Streaming SIMD Extensions 3(SSE3)
+         1,    0,  ECX,      1, pclmulqdq, PCLMULQDQ instruction supported
+         1,    0,  ECX,      2, dtes64, DS area uses 64-bit layout
+         1,    0,  ECX,      3, mwait, MONITOR/MWAIT supported
+         1,    0,  ECX,      4, ds_cpl, CPL Qualified Debug Store which allo=
ws for branch message storage qualified by CPL
+         1,    0,  ECX,      5, vmx, Virtual Machine Extensions supported
+         1,    0,  ECX,      6, smx, Safer Mode Extension supported
+         1,    0,  ECX,      7, eist, Enhanced Intel SpeedStep Technology
+         1,    0,  ECX,      8, tm2, Thermal Monitor 2
+         1,    0,  ECX,      9, ssse3, Supplemental Streaming SIMD Extension=
s 3 (SSSE3)
+         1,    0,  ECX,     10, l1_ctx_id, L1 data cache could be set to eit=
her adaptive mode or shared mode (check IA32_MISC_ENABLE bit 24 definition)
+         1,    0,  ECX,     11, sdbg, IA32_DEBUG_INTERFACE MSR for silicon d=
ebug supported
+         1,    0,  ECX,     12, fma, FMA extensions using YMM state supported
+         1,    0,  ECX,     13, cmpxchg16b, 'CMPXCHG16B - Compare and Exchan=
ge Bytes' supported
+         1,    0,  ECX,     14, xtpr_update, xTPR Update Control supported
+         1,    0,  ECX,     15, pdcm, Perfmon and Debug Capability present
+         1,    0,  ECX,     17, pcid, Process-Context Identifiers feature pr=
esent
+         1,    0,  ECX,     18, dca, Prefetching data from a memory mapped d=
evice supported
+         1,    0,  ECX,     19, sse4_1, SSE4.1 feature present
+         1,    0,  ECX,     20, sse4_2, SSE4.2 feature present
+         1,    0,  ECX,     21, x2apic, x2APIC supported
+         1,    0,  ECX,     22, movbe, MOVBE instruction supported
+         1,    0,  ECX,     23, popcnt, POPCNT instruction supported
+         1,    0,  ECX,     24, tsc_deadline_timer, LAPIC supports one-shot =
operation using a TSC deadline value
+         1,    0,  ECX,     25, aesni, AESNI instruction supported
+         1,    0,  ECX,     26, xsave, XSAVE/XRSTOR processor extended state=
s (XSETBV/XGETBV/XCR0)
+         1,    0,  ECX,     27, osxsave, OS has set CR4.OSXSAVE bit to enabl=
e XSETBV/XGETBV/XCR0
+         1,    0,  ECX,     28, avx, AVX instruction supported
+         1,    0,  ECX,     29, f16c, 16-bit floating-point conversion instr=
uction supported
+         1,    0,  ECX,     30, rdrand, RDRAND instruction supported
+
+         1,    0,  EDX,      0, fpu, x87 FPU on chip
+         1,    0,  EDX,      1, vme, Virtual-8086 Mode Enhancement
+         1,    0,  EDX,      2, de, Debugging Extensions
+         1,    0,  EDX,      3, pse, Page Size Extensions
+         1,    0,  EDX,      4, tsc, Time Stamp Counter
+         1,    0,  EDX,      5, msr, RDMSR and WRMSR Support
+         1,    0,  EDX,      6, pae, Physical Address Extensions
+         1,    0,  EDX,      7, mce, Machine Check Exception
+         1,    0,  EDX,      8, cx8, CMPXCHG8B instr
+         1,    0,  EDX,      9, apic, APIC on Chip
+         1,    0,  EDX,     11, sep, SYSENTER and SYSEXIT instrs
+         1,    0,  EDX,     12, mtrr, Memory Type Range Registers
+         1,    0,  EDX,     13, pge, Page Global Bit
+         1,    0,  EDX,     14, mca, Machine Check Architecture
+         1,    0,  EDX,     15, cmov, Conditional Move Instrs
+         1,    0,  EDX,     16, pat, Page Attribute Table
+         1,    0,  EDX,     17, pse36, 36-Bit Page Size Extension
+         1,    0,  EDX,     18, psn, Processor Serial Number
+         1,    0,  EDX,     19, clflush, CLFLUSH instr
+#         1,    0,  EDX,     20,
+         1,    0,  EDX,     21, ds, Debug Store
+         1,    0,  EDX,     22, acpi, Thermal Monitor and Software Controlle=
d Clock Facilities
+         1,    0,  EDX,     23, mmx, Intel MMX Technology
+         1,    0,  EDX,     24, fxsr, XSAVE and FXRSTOR Instrs
+         1,    0,  EDX,     25, sse, SSE
+         1,    0,  EDX,     26, sse2, SSE2
+         1,    0,  EDX,     27, ss, Self Snoop
+         1,    0,  EDX,     28, hit, Max APIC IDs
+         1,    0,  EDX,     29, tm, Thermal Monitor
+#         1,    0,  EDX,     30,
+         1,    0,  EDX,     31, pbe, Pending Break Enable
+
+# Leaf 02H
+# cache and TLB descriptor info
+
+# Leaf 03H
+# Precessor Serial Number, introduced on Pentium III, not valid for
+# latest models
+
+# Leaf 04H
+# thread/core and cache topology
+         4,    0,  EAX,    4:0, cache_type, Cache type like instr/data or un=
ified
+         4,    0,  EAX,    7:5, cache_level, Cache Level (starts at 1)
+         4,    0,  EAX,      8, cache_self_init, Cache Self Initialization
+         4,    0,  EAX,      9, fully_associate, Fully Associative cache
+#         4,    0,  EAX,  13:10, resvd, resvd
+         4,    0,  EAX,  25:14, max_logical_id, Max number of addressable ID=
s for logical processors sharing the cache
+         4,    0,  EAX,  31:26, max_phy_id, Max number of addressable IDs fo=
r processors in phy package
+
+         4,    0,  EBX,   11:0, cache_linesize, Size of a cache line in bytes
+         4,    0,  EBX,  21:12, cache_partition, Physical Line partitions
+         4,    0,  EBX,  31:22, cache_ways, Ways of associativity
+         4,    0,  ECX,   31:0, cache_sets, Number of Sets - 1
+         4,    0,  EDX,      0, c_wbinvd, 1 means WBINVD/INVD is not ganrant=
eed to act upon lower level caches of non-originating threads sharing this ca=
che
+         4,    0,  EDX,      1, c_incl, Whether cache is inclusive of lower =
cache level
+         4,    0,  EDX,      2, c_comp_index, Complex Cache Indexing
+
+# Leaf 05H
+# MONITOR/MWAIT
+	 5,    0,  EAX,   15:0, min_mon_size, Smallest monitor line size in bytes
+	 5,    0,  EBX,   15:0, max_mon_size, Largest monitor line size in bytes
+	 5,    0,  ECX,      0, mwait_ext, Enum of Monitor-Mwait extensions support=
ed
+	 5,    0,  ECX,      1, mwait_irq_break, Largest monitor line size in bytes
+	 5,    0,  EDX,    3:0, c0_sub_stats, Number of C0* sub C-states supported =
using MWAIT
+	 5,    0,  EDX,    7:4, c1_sub_stats, Number of C1* sub C-states supported =
using MWAIT
+	 5,    0,  EDX,   11:8, c2_sub_stats, Number of C2* sub C-states supported =
using MWAIT
+	 5,    0,  EDX,  15:12, c3_sub_stats, Number of C3* sub C-states supported =
using MWAIT
+	 5,    0,  EDX,  19:16, c4_sub_stats, Number of C4* sub C-states supported =
using MWAIT
+	 5,    0,  EDX,  23:20, c5_sub_stats, Number of C5* sub C-states supported =
using MWAIT
+	 5,    0,  EDX,  27:24, c6_sub_stats, Number of C6* sub C-states supported =
using MWAIT
+	 5,    0,  EDX,  31:28, c7_sub_stats, Number of C7* sub C-states supported =
using MWAIT
+
+# Leaf 06H
+# Thermal & Power Management
+
+	 6,    0,  EAX,      0, dig_temp, Digital temperature sensor supported
+	 6,    0,  EAX,      1, turbo, Intel Turbo Boost
+	 6,    0,  EAX,      2, arat, Always running APIC timer
+#	 6,    0,  EAX,      3, resv, Reserved
+	 6,    0,  EAX,      4, pln, Power limit notifications supported
+	 6,    0,  EAX,      5, ecmd, Clock modulation duty cycle extension support=
ed
+	 6,    0,  EAX,      6, ptm, Package thermal management supported
+	 6,    0,  EAX,      7, hwp, HWP base register
+	 6,    0,  EAX,      8, hwp_notify, HWP notification
+	 6,    0,  EAX,      9, hwp_act_window, HWP activity window
+	 6,    0,  EAX,     10, hwp_energy, HWP energy performance preference
+	 6,    0,  EAX,     11, hwp_pkg_req, HWP package level request
+#	 6,    0,  EAX,     12, resv, Reserved
+	 6,    0,  EAX,     13, hdc, HDC base registers supported
+	 6,    0,  EAX,     14, turbo3, Turbo Boost Max 3.0
+	 6,    0,  EAX,     15, hwp_cap, Highest Performance change supported
+	 6,    0,  EAX,     16, hwp_peci, HWP PECI override is supported
+	 6,    0,  EAX,     17, hwp_flex, Flexible HWP is supported
+	 6,    0,  EAX,     18, hwp_fast, Fast access mode for the IA32_HWP_REQUEST=
 MSR is supported
+#	 6,    0,  EAX,     19, resv, Reserved
+	 6,    0,  EAX,     20, hwp_ignr, Ignoring Idle Logical Processor HWP reque=
st is supported
+
+	 6,    0,  EBX,    3:0, therm_irq_thresh, Number of Interrupt Thresholds in=
 Digital Thermal Sensor
+	 6,    0,  ECX,      0, aperfmperf, Presence of IA32_MPERF and IA32_APERF
+	 6,    0,  ECX,      3, energ_bias, Performance-energy bias preference supp=
orted
+
+# Leaf 07H
+#	ECX =3D=3D 0
+# AVX512 refers to https://en.wikipedia.org/wiki/AVX-512
+# XXX: Do we really need to enumerate each and every AVX512 sub features
+
+	 7,    0,  EBX,      0, fsgsbase, RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE suppo=
rted
+	 7,    0,  EBX,      1, tsc_adjust, TSC_ADJUST MSR supported
+	 7,    0,  EBX,      2, sgx, Software Guard Extensions
+	 7,    0,  EBX,      3, bmi1, BMI1
+	 7,    0,  EBX,      4, hle, Hardware Lock Elision
+	 7,    0,  EBX,      5, avx2, AVX2
+#	 7,    0,  EBX,      6, fdp_excp_only, x87 FPU Data Pointer updated only o=
n x87 exceptions
+	 7,    0,  EBX,      7, smep, Supervisor-Mode Execution Prevention
+	 7,    0,  EBX,      8, bmi2, BMI2
+	 7,    0,  EBX,      9, rep_movsb, Enhanced REP MOVSB/STOSB
+	 7,    0,  EBX,     10, invpcid, INVPCID instruction
+	 7,    0,  EBX,     11, rtm, Restricted Transactional Memory
+	 7,    0,  EBX,     12, rdt_m, Intel RDT Monitoring capability
+	 7,    0,  EBX,     13, depc_fpu_cs_ds, Deprecates FPU CS and FPU DS
+	 7,    0,  EBX,     14, mpx, Memory Protection Extensions
+	 7,    0,  EBX,     15, rdt_a, Intel RDT Allocation capability
+	 7,    0,  EBX,     16, avx512f, AVX512 Foundation instr
+	 7,    0,  EBX,     17, avx512dq, AVX512 Double and Quadword AVX512 instr
+	 7,    0,  EBX,     18, rdseed, RDSEED instr
+	 7,    0,  EBX,     19, adx, ADX instr
+	 7,    0,  EBX,     20, smap, Supervisor Mode Access Prevention
+	 7,    0,  EBX,     21, avx512ifma, AVX512 Integer Fused Multiply Add
+#	 7,    0,  EBX,     22, resvd, resvd
+	 7,    0,  EBX,     23, clflushopt, CLFLUSHOPT instr
+	 7,    0,  EBX,     24, clwb, CLWB instr
+	 7,    0,  EBX,     25, intel_pt, Intel Processor Trace instr
+	 7,    0,  EBX,     26, avx512pf, Prefetch
+	 7,    0,  EBX,     27, avx512er, AVX512 Exponent Reciproca instr
+	 7,    0,  EBX,     28, avx512cd, AVX512 Conflict Detection instr
+	 7,    0,  EBX,     29, sha, Intel Secure Hash Algorithm Extensions instr
+	 7,    0,  EBX,     26, avx512bw, AVX512 Byte & Word instr
+	 7,    0,  EBX,     28, avx512vl, AVX512 Vector Length Extentions (VL)
+	 7,    0,  ECX,      0, prefetchwt1, X
+	 7,    0,  ECX,      1, avx512vbmi, AVX512 Vector Byte Manipulation Instruc=
tions
+	 7,    0,  ECX,      2, umip, User-mode Instruction Prevention
+
+	 7,    0,  ECX,      3, pku, Protection Keys for User-mode pages
+	 7,    0,  ECX,      4, ospke, CR4 PKE set to enable protection keys
+#	 7,    0,  ECX,   16:5, resvd, resvd
+	 7,    0,  ECX,  21:17, mawau, The value of MAWAU used by the BNDLDX and BN=
DSTX instructions in 64-bit mode
+	 7,    0,  ECX,     22, rdpid, RDPID and IA32_TSC_AUX
+#	 7,    0,  ECX,  29:23, resvd, resvd
+	 7,    0,  ECX,     30, sgx_lc, SGX Launch Configuration
+#	 7,    0,  ECX,     31, resvd, resvd
+
+# Leaf 08H
+#
+
+
+# Leaf 09H
+# Direct Cache Access (DCA) information
+	 9,    0,  ECX,   31:0, dca_cap, The value of IA32_PLATFORM_DCA_CAP
+
+# Leaf 0AH
+# Architectural Performance Monitoring
+#
+# Do we really need to print out the PMU related stuff?
+# Does normal user really care about it?
+#
+       0xA,    0,  EAX,    7:0, pmu_ver, Performance Monitoring Unit version
+       0xA,    0,  EAX,   15:8, pmu_gp_cnt_num, Numer of general-purose PMU =
counters per logical CPU
+       0xA,    0,  EAX,  23:16, pmu_cnt_bits, Bit wideth of PMU counter
+       0xA,    0,  EAX,  31:24, pmu_ebx_bits, Length of EBX bit vector to en=
umerate PMU events
+
+       0xA,    0,  EBX,      0, pmu_no_core_cycle_evt, Core cycle event not =
available
+       0xA,    0,  EBX,      1, pmu_no_instr_ret_evt, Instruction retired ev=
ent not available
+       0xA,    0,  EBX,      2, pmu_no_ref_cycle_evt, Reference cycles event=
 not available
+       0xA,    0,  EBX,      3, pmu_no_llc_ref_evt, Last-level cache referen=
ce event not available
+       0xA,    0,  EBX,      4, pmu_no_llc_mis_evt, Last-level cache misses =
event not available
+       0xA,    0,  EBX,      5, pmu_no_br_instr_ret_evt, Branch instruction =
retired event not available
+       0xA,    0,  EBX,      6, pmu_no_br_mispredict_evt, Branch mispredict =
retired event not available
+
+       0xA,    0,  ECX,    4:0, pmu_fixed_cnt_num, Performance Monitoring Un=
it version
+       0xA,    0,  ECX,   12:5, pmu_fixed_cnt_bits, Numer of PMU counters pe=
r logical CPU
+
+# Leaf 0BH
+# Extended Topology Enumeration Leaf
+#
+
+       0xB,    0,  EAX,    4:0, id_shift, Number of bits to shift right on x=
2APIC ID to get a unique topology ID of the next level type
+       0xB,    0,  EBX,   15:0, cpu_nr, Number of logical processors at this=
 level type
+       0xB,    0,  ECX,   15:8, lvl_type, 0-Invalid 1-SMT 2-Core
+       0xB,    0,  EDX,   31:0, x2apic_id, x2APIC ID the current logical pro=
cessor
+
+
+# Leaf 0DH
+# Processor Extended State
+
+       0xD,    0,  EAX,      0, x87, X87 state
+       0xD,    0,  EAX,      1, sse, SSE state
+       0xD,    0,  EAX,      2, avx, AVX state
+       0xD,    0,  EAX,    4:3, mpx, MPX state
+       0xD,    0,  EAX,    7:5, avx512, AVX-512 state
+       0xD,    0,  EAX,      9, pkru, PKRU state
+
+       0xD,    0,  EBX,   31:0, max_sz_xcr0, Maximum size (bytes) required b=
y enabled features in XCR0
+       0xD,    0,  ECX,   31:0, max_sz_xsave, Maximum size (bytes) of the XS=
AVE/XRSTOR save area
+
+       0xD,    1,  EAX,      0, xsaveopt, XSAVEOPT available
+       0xD,    1,  EAX,      1, xsavec, XSAVEC and compacted form supported
+       0xD,    1,  EAX,      2, xgetbv, XGETBV supported
+       0xD,    1,  EAX,      3, xsaves, XSAVES/XRSTORS and IA32_XSS supported
+
+       0xD,    1,  EBX,   31:0, max_sz_xcr0, Maximum size (bytes) required b=
y enabled features in XCR0
+       0xD,    1,  ECX,      8, pt, PT state
+       0xD,    1,  ECX,      11, cet_usr, CET user state
+       0xD,    1,  ECX,      12, cet_supv, CET supervisor state
+       0xD,    1,  ECX,      13, hdc, HDC state
+       0xD,    1,  ECX,      16, hwp, HWP state
+
+# Leaf 0FH
+# Intel RDT Monitoring
+
+       0xF,    0,  EBX,   31:0, rmid_range, Maximum range (zero-based) of RM=
ID within this physical processor of all types
+       0xF,    0,  EDX,      1, l3c_rdt_mon, L3 Cache RDT Monitoring support=
ed
+
+       0xF,    1,  ECX,   31:0, rmid_range, Maximum range (zero-based) of RM=
ID of this types
+       0xF,    1,  EDX,      0, l3c_ocp_mon, L3 Cache occupancy Monitoring s=
upported
+       0xF,    1,  EDX,      1, l3c_tbw_mon, L3 Cache Total Bandwidth Monito=
ring supported
+       0xF,    1,  EDX,      2, l3c_lbw_mon, L3 Cache Local Bandwidth Monito=
ring supported
+
+# Leaf 10H
+# Intel RDT Allocation
+
+      0x10,    0,  EBX,      1, l3c_rdt_alloc, L3 Cache Allocation supported
+      0x10,    0,  EBX,      2, l2c_rdt_alloc, L2 Cache Allocation supported
+      0x10,    0,  EBX,      3, mem_bw_alloc, Memory Bandwidth Allocation su=
pported
+
+
+# Leaf 12H
+# SGX Capability
+#
+# Some detailed SGX features not added yet
+
+      0x12,    0,  EAX,      0, sgx1, L3 Cache Allocation supported
+      0x12,    1,  EAX,      0, sgx2, L3 Cache Allocation supported
+
+
+# Leaf 14H
+# Intel Processor Tracer
+#
+
+# Leaf 15H
+# Time Stamp Counter and Nominal Core Crystal Clock Information
+
+      0x15,    0,  EAX,   31:0, tsc_denominator, The denominator of the TSC/=
=E2=80=9Dcore crystal clock=E2=80=9D ratio
+      0x15,    0,  EBX,   31:0, tsc_numerator, The numerator of the TSC/=E2=
=80=9Dcore crystal clock=E2=80=9D ratio
+      0x15,    0,  ECX,   31:0, nom_freq, Nominal frequency of the core crys=
tal clock in Hz
+
+# Leaf 16H
+# Processor Frequency Information
+
+      0x16,    0,  EAX,   15:0, cpu_base_freq, Processor Base Frequency in M=
Hz
+      0x16,    0,  EBX,   15:0, cpu_max_freq, Maximum Frequency in MHz
+      0x16,    0,  ECX,   15:0, bus_freq, Bus (Reference) Frequency in MHz
+
+# Leaf 17H
+# System-On-Chip Vendor Attribute
+
+      0x17,    0,  EAX,   31:0, max_socid, Maximum input value of supported =
sub-leaf
+      0x17,    0,  EBX,   15:0, soc_vid, SOC Vendor ID
+      0x17,    0,  EBX,     16, std_vid, SOC Vendor ID is assigned via an in=
dustry standard scheme
+      0x17,    0,  ECX,   31:0, soc_pid, SOC Project ID assigned by vendor
+      0x17,    0,  EDX,   31:0, soc_sid, SOC Stepping ID
+
+# Leaf 18H
+# Deterministic Address Translation Parameters
+
+
+# Leaf 19H
+# Key Locker Leaf
+
+
+# Leaf 1AH
+# Hybrid Information
+
+      0x1A,    0,  EAX,  31:24, core_type, 20H-Intel_Atom 40H-Intel_Core
+
+
+# Leaf 1FH
+# V2 Extended Topology - A preferred superset to leaf 0BH
+
+
+# According to SDM
+# 40000000H - 4FFFFFFFH is invalid range
+
+
+# Leaf 80000001H
+# Extended Processor Signature and Feature Bits
+
+0x80000001,    0,  ECX,      0, lahf_lm, LAHF/SAHF available in 64-bit mode
+0x80000001,    0,  ECX,      5, lzcnt, LZCNT
+0x80000001,    0,  ECX,      8, prefetchw, PREFETCHW
+
+0x80000001,    0,  EDX,     11, sysret, SYSCALL/SYSRET supported
+0x80000001,    0,  EDX,     20, exec_dis, Execute Disable Bit available
+0x80000001,    0,  EDX,     26, 1gb_page, 1GB page supported
+0x80000001,    0,  EDX,     27, rdtscp, RDTSCP and IA32_TSC_AUX are available
+#0x80000001,    0,  EDX,     29, 64b, 64b Architecture supported
+
+# Leaf 80000002H/80000003H/80000004H
+# Processor Brand String
+
+# Leaf 80000005H
+# Reserved
+
+# Leaf 80000006H
+# Extended L2 Cache Features
+
+0x80000006,    0,  ECX,    7:0, clsize, Cache Line size in bytes
+0x80000006,    0,  ECX,  15:12, l2c_assoc, L2 Associativity
+0x80000006,    0,  ECX,  31:16, csize, Cache size in 1K units
+
+
+# Leaf 80000007H
+
+0x80000007,    0,  EDX,      8, nonstop_tsc, Invariant TSC available
+
+
+# Leaf 80000008H
+
+0x80000008,    0,  EAX,    7:0, phy_adr_bits, Physical Address Bits
+0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
+0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
new file mode 100644
index 0000000..6048da3
--- /dev/null
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef unsigned int u32;
+typedef unsigned long long u64;
+
+char *def_csv =3D "/usr/share/misc/cpuid.csv";
+char *user_csv;
+
+
+/* Cover both single-bit flag and multiple-bits fields */
+struct bits_desc {
+	/* start and end bits */
+	int start, end;
+	/* 0 or 1 for 1-bit flag */
+	int value;
+	char simp[32];
+	char detail[256];
+};
+
+/* descriptor info for eax/ebx/ecx/edx */
+struct reg_desc {
+	/* number of valid entries */
+	int nr;
+	struct bits_desc descs[32];
+};
+
+enum {
+	R_EAX =3D 0,
+	R_EBX,
+	R_ECX,
+	R_EDX,
+	NR_REGS
+};
+
+struct subleaf {
+	u32 index;
+	u32 sub;
+	u32 eax, ebx, ecx, edx;
+	struct reg_desc info[NR_REGS];
+};
+
+/* Represent one leaf (basic or extended) */
+struct cpuid_func {
+	/*
+	 * Array of subleafs for this func, if there is no subleafs
+	 * then the leafs[0] is the main leaf
+	 */
+	struct subleaf *leafs;
+	int nr;
+};
+
+struct cpuid_range {
+	/* array of main leafs */
+	struct cpuid_func *funcs;
+	/* number of valid leafs */
+	int nr;
+	bool is_ext;
+};
+
+/*
+ * basic:  basic functions range: [0... ]
+ * ext:    extended functions range: [0x80000000... ]
+ */
+struct cpuid_range *leafs_basic, *leafs_ext;
+
+static int num_leafs;
+static bool is_amd;
+static bool show_details;
+static bool show_raw;
+static bool show_flags_only =3D true;
+static u32 user_index =3D 0xFFFFFFFF;
+static u32 user_sub =3D 0xFFFFFFFF;
+static int flines;
+
+static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=3Da" (*eax),
+	      "=3Db" (*ebx),
+	      "=3Dc" (*ecx),
+	      "=3Dd" (*edx)
+	    : "0" (*eax), "2" (*ecx));
+}
+
+static inline bool has_subleafs(u32 f)
+{
+	if (f =3D=3D 0x7 || f =3D=3D 0xd)
+		return true;
+
+	if (is_amd) {
+		if (f =3D=3D 0x8000001d)
+			return true;
+		return false;
+	}
+
+	switch (f) {
+	case 0x4:
+	case 0xb:
+	case 0xf:
+	case 0x10:
+	case 0x14:
+	case 0x18:
+	case 0x1f:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void leaf_print_raw(struct subleaf *leaf)
+{
+	if (has_subleafs(leaf->index)) {
+		if (leaf->sub =3D=3D 0)
+			printf("0x%08x: subleafs:\n", leaf->index);
+
+		printf(" %2d: EAX=3D0x%08x, EBX=3D0x%08x, ECX=3D0x%08x, EDX=3D0x%08x\n",
+			leaf->sub, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+	} else {
+		printf("0x%08x: EAX=3D0x%08x, EBX=3D0x%08x, ECX=3D0x%08x, EDX=3D0x%08x\n",
+			leaf->index, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+	}
+}
+
+/* Return true is the input eax/ebx/ecx/edx are all zero */
+static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
+			u32 a, u32 b, u32 c, u32 d)
+{
+	struct cpuid_func *func;
+	struct subleaf *leaf;
+	int s =3D 0;
+
+	if (a =3D=3D 0 && b =3D=3D 0 && c =3D=3D 0 && d =3D=3D 0)
+		return true;
+
+	/*
+	 * Cut off vendor-prefix from CPUID function as we're using it as an
+	 * index into ->funcs.
+	 */
+	func =3D &range->funcs[f & 0xffff];
+
+	if (!func->leafs) {
+		func->leafs =3D malloc(sizeof(struct subleaf));
+		if (!func->leafs)
+			perror("malloc func leaf");
+
+		func->nr =3D 1;
+	} else {
+		s =3D func->nr;
+		func->leafs =3D realloc(func->leafs, (s + 1) * sizeof(*leaf));
+		if (!func->leafs)
+			perror("realloc f->leafs");
+
+		func->nr++;
+	}
+
+	leaf =3D &func->leafs[s];
+
+	leaf->index =3D f;
+	leaf->sub =3D subleaf;
+	leaf->eax =3D a;
+	leaf->ebx =3D b;
+	leaf->ecx =3D c;
+	leaf->edx =3D d;
+
+	return false;
+}
+
+static void raw_dump_range(struct cpuid_range *range)
+{
+	u32 f;
+	int i;
+
+	printf("%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
+	printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+
+	for (f =3D 0; (int)f < range->nr; f++) {
+		struct cpuid_func *func =3D &range->funcs[f];
+		u32 index =3D f;
+
+		if (range->is_ext)
+			index +=3D 0x80000000;
+
+		/* Skip leaf without valid items */
+		if (!func->nr)
+			continue;
+
+		/* First item is the main leaf, followed by all subleafs */
+		for (i =3D 0; i < func->nr; i++)
+			leaf_print_raw(&func->leafs[i]);
+	}
+}
+
+#define MAX_SUBLEAF_NUM		32
+struct cpuid_range *setup_cpuid_range(u32 input_eax)
+{
+	u32 max_func, idx_func;
+	int subleaf;
+	struct cpuid_range *range;
+	u32 eax, ebx, ecx, edx;
+	u32 f =3D input_eax;
+	int max_subleaf;
+	bool allzero;
+
+	eax =3D input_eax;
+	ebx =3D ecx =3D edx =3D 0;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	max_func =3D eax;
+	idx_func =3D (max_func & 0xffff) + 1;
+
+	range =3D malloc(sizeof(struct cpuid_range));
+	if (!range)
+		perror("malloc range");
+
+	if (input_eax & 0x80000000)
+		range->is_ext =3D true;
+	else
+		range->is_ext =3D false;
+
+	range->funcs =3D malloc(sizeof(struct cpuid_func) * idx_func);
+	if (!range->funcs)
+		perror("malloc range->funcs");
+
+	range->nr =3D idx_func;
+	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
+
+	for (; f <=3D max_func; f++) {
+		eax =3D f;
+		subleaf =3D ecx =3D 0;
+
+		cpuid(&eax, &ebx, &ecx, &edx);
+		allzero =3D cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
+		if (allzero)
+			continue;
+		num_leafs++;
+
+		if (!has_subleafs(f))
+			continue;
+
+		max_subleaf =3D MAX_SUBLEAF_NUM;
+
+		/*
+		 * Some can provide the exact number of subleafs,
+		 * others have to be tried (0xf)
+		 */
+		if (f =3D=3D 0x7 || f =3D=3D 0x14 || f =3D=3D 0x17 || f =3D=3D 0x18)
+			max_subleaf =3D (eax & 0xff) + 1;
+
+		if (f =3D=3D 0xb)
+			max_subleaf =3D 2;
+
+		for (subleaf =3D 1; subleaf < max_subleaf; subleaf++) {
+			eax =3D f;
+			ecx =3D subleaf;
+
+			cpuid(&eax, &ebx, &ecx, &edx);
+			allzero =3D cpuid_store(range, f, subleaf,
+						eax, ebx, ecx, edx);
+			if (allzero)
+				continue;
+			num_leafs++;
+		}
+
+	}
+
+	return range;
+}
+
+/*
+ * The basic row format for cpuid.csv  is
+ *	LEAF,SUBLEAF,register_name,bits,short name,long description
+ *
+ * like:
+ *	0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported su=
bleafs
+ *	1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
+ */
+static int parse_line(char *line)
+{
+	char *str;
+	int i;
+	struct cpuid_range *range;
+	struct cpuid_func *func;
+	struct subleaf *leaf;
+	u32 index;
+	u32 sub;
+	char buffer[512];
+	char *buf;
+	/*
+	 * Tokens:
+	 *  1. leaf
+	 *  2. subleaf
+	 *  3. register
+	 *  4. bits
+	 *  5. short name
+	 *  6. long detail
+	 */
+	char *tokens[6];
+	struct reg_desc *reg;
+	struct bits_desc *bdesc;
+	int reg_index;
+	char *start, *end;
+
+	/* Skip comments and NULL line */
+	if (line[0] =3D=3D '#' || line[0] =3D=3D '\n')
+		return 0;
+
+	strncpy(buffer, line, 511);
+	buffer[511] =3D 0;
+	str =3D buffer;
+	for (i =3D 0; i < 5; i++) {
+		tokens[i] =3D strtok(str, ",");
+		if (!tokens[i])
+			goto err_exit;
+		str =3D NULL;
+	}
+	tokens[5] =3D strtok(str, "\n");
+
+	/* index/main-leaf */
+	index =3D strtoull(tokens[0], NULL, 0);
+
+	if (index & 0x80000000)
+		range =3D leafs_ext;
+	else
+		range =3D leafs_basic;
+
+	index &=3D 0x7FFFFFFF;
+	/* Skip line parsing for non-existing indexes */
+	if ((int)index >=3D range->nr)
+		return -1;
+
+	func =3D &range->funcs[index];
+
+	/* Return if the index has no valid item on this platform */
+	if (!func->nr)
+		return 0;
+
+	/* subleaf */
+	sub =3D strtoul(tokens[1], NULL, 0);
+	if ((int)sub > func->nr)
+		return -1;
+
+	leaf =3D &func->leafs[sub];
+	buf =3D tokens[2];
+
+	if (strcasestr(buf, "EAX"))
+		reg_index =3D R_EAX;
+	else if (strcasestr(buf, "EBX"))
+		reg_index =3D R_EBX;
+	else if (strcasestr(buf, "ECX"))
+		reg_index =3D R_ECX;
+	else if (strcasestr(buf, "EDX"))
+		reg_index =3D R_EDX;
+	else
+		goto err_exit;
+
+	reg =3D &leaf->info[reg_index];
+	bdesc =3D &reg->descs[reg->nr++];
+
+	/* bit flag or bits field */
+	buf =3D tokens[3];
+
+	end =3D strtok(buf, ":");
+	bdesc->end =3D strtoul(end, NULL, 0);
+	bdesc->start =3D bdesc->end;
+
+	/* start !=3D NULL means it is bit fields */
+	start =3D strtok(NULL, ":");
+	if (start)
+		bdesc->start =3D strtoul(start, NULL, 0);
+
+	strcpy(bdesc->simp, tokens[4]);
+	strcpy(bdesc->detail, tokens[5]);
+	return 0;
+
+err_exit:
+	printf("Warning: wrong line format:\n");
+	printf("\tline[%d]: %s\n", flines, line);
+	return -1;
+}
+
+/* Parse csv file, and construct the array of all leafs and subleafs */
+static void parse_text(void)
+{
+	FILE *file;
+	char *filename, *line =3D NULL;
+	size_t len =3D 0;
+	int ret;
+
+	if (show_raw)
+		return;
+
+	filename =3D user_csv ? user_csv : def_csv;
+	file =3D fopen(filename, "r");
+	if (!file) {
+		/* Fallback to a csv in the same dir */
+		file =3D fopen("./cpuid.csv", "r");
+	}
+
+	if (!file) {
+		printf("Fail to open '%s'\n", filename);
+		return;
+	}
+
+	while (1) {
+		ret =3D getline(&line, &len, file);
+		flines++;
+		if (ret > 0)
+			parse_line(line);
+
+		if (feof(file))
+			break;
+	}
+
+	fclose(file);
+}
+
+
+/* Decode every eax/ebx/ecx/edx */
+static void decode_bits(u32 value, struct reg_desc *rdesc)
+{
+	struct bits_desc *bdesc;
+	int start, end, i;
+	u32 mask;
+
+	for (i =3D 0; i < rdesc->nr; i++) {
+		bdesc =3D &rdesc->descs[i];
+
+		start =3D bdesc->start;
+		end =3D bdesc->end;
+		if (start =3D=3D end) {
+			/* single bit flag */
+			if (value & (1 << start))
+				printf("\t%-20s %s%s\n",
+					bdesc->simp,
+					show_details ? "-" : "",
+					show_details ? bdesc->detail : ""
+					);
+		} else {
+			/* bit fields */
+			if (show_flags_only)
+				continue;
+
+			mask =3D ((u64)1 << (end - start + 1)) - 1;
+			printf("\t%-20s\t: 0x%-8x\t%s%s\n",
+					bdesc->simp,
+					(value >> start) & mask,
+					show_details ? "-" : "",
+					show_details ? bdesc->detail : ""
+					);
+		}
+	}
+}
+
+static void show_leaf(struct subleaf *leaf)
+{
+	if (!leaf)
+		return;
+
+	if (show_raw)
+		leaf_print_raw(leaf);
+
+	decode_bits(leaf->eax, &leaf->info[R_EAX]);
+	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
+	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
+	decode_bits(leaf->edx, &leaf->info[R_EDX]);
+}
+
+static void show_func(struct cpuid_func *func)
+{
+	int i;
+
+	if (!func)
+		return;
+
+	for (i =3D 0; i < func->nr; i++)
+		show_leaf(&func->leafs[i]);
+}
+
+static void show_range(struct cpuid_range *range)
+{
+	int i;
+
+	for (i =3D 0; i < range->nr; i++)
+		show_func(&range->funcs[i]);
+}
+
+static inline struct cpuid_func *index_to_func(u32 index)
+{
+	struct cpuid_range *range;
+
+	range =3D (index & 0x80000000) ? leafs_ext : leafs_basic;
+	index &=3D 0x7FFFFFFF;
+
+	if (((index & 0xFFFF) + 1) > (u32)range->nr) {
+		printf("ERR: invalid input index (0x%x)\n", index);
+		return NULL;
+	}
+	return &range->funcs[index];
+}
+
+static void show_info(void)
+{
+	struct cpuid_func *func;
+
+	if (show_raw) {
+		/* Show all of the raw output of 'cpuid' instr */
+		raw_dump_range(leafs_basic);
+		raw_dump_range(leafs_ext);
+		return;
+	}
+
+	if (user_index !=3D 0xFFFFFFFF) {
+		/* Only show specific leaf/subleaf info */
+		func =3D index_to_func(user_index);
+		if (!func)
+			return;
+
+		/* Dump the raw data also */
+		show_raw =3D true;
+
+		if (user_sub !=3D 0xFFFFFFFF) {
+			if (user_sub + 1 <=3D (u32)func->nr) {
+				show_leaf(&func->leafs[user_sub]);
+				return;
+			}
+
+			printf("ERR: invalid input subleaf (0x%x)\n", user_sub);
+		}
+
+		show_func(func);
+		return;
+	}
+
+	printf("CPU features:\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n\n");
+	show_range(leafs_basic);
+	show_range(leafs_ext);
+}
+
+static void setup_platform_cpuid(void)
+{
+	 u32 eax, ebx, ecx, edx;
+
+	/* Check vendor */
+	eax =3D ebx =3D ecx =3D edx =3D 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* "htuA" */
+	if (ebx =3D=3D 0x68747541)
+		is_amd =3D true;
+
+	/* Setup leafs for the basic and extended range */
+	leafs_basic =3D setup_cpuid_range(0x0);
+	leafs_ext =3D setup_cpuid_range(0x80000000);
+}
+
+static void usage(void)
+{
+	printf("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+		"\t-a|--all             Show both bit flags and complex bit fields info\n"
+		"\t-b|--bitflags        Show boolean flags only\n"
+		"\t-d|--detail          Show details of the flag/fields (default)\n"
+		"\t-f|--flags           Specify the cpuid csv file\n"
+		"\t-h|--help            Show usage info\n"
+		"\t-l|--leaf=3Dindex      Specify the leaf you want to check\n"
+		"\t-r|--raw             Show raw cpuid data\n"
+		"\t-s|--subleaf=3Dsub     Specify the subleaf you want to check\n"
+	);
+}
+
+static struct option opts[] =3D {
+	{ "all", no_argument, NULL, 'a' },		/* show both bit flags and fields */
+	{ "bitflags", no_argument, NULL, 'b' },		/* only show bit flags, default on=
 */
+	{ "detail", no_argument, NULL, 'd' },		/* show detail descriptions */
+	{ "file", required_argument, NULL, 'f' },	/* use user's cpuid file */
+	{ "help", no_argument, NULL, 'h'},		/* show usage */
+	{ "leaf", required_argument, NULL, 'l'},	/* only check a specific leaf */
+	{ "raw", no_argument, NULL, 'r'},		/* show raw CPUID leaf data */
+	{ "subleaf", required_argument, NULL, 's'},	/* check a specific subleaf */
+	{ NULL, 0, NULL, 0 }
+};
+
+static int parse_options(int argc, char *argv[])
+{
+	int c;
+
+	while ((c =3D getopt_long(argc, argv, "abdf:hl:rs:",
+					opts, NULL)) !=3D -1)
+		switch (c) {
+		case 'a':
+			show_flags_only =3D false;
+			break;
+		case 'b':
+			show_flags_only =3D true;
+			break;
+		case 'd':
+			show_details =3D true;
+			break;
+		case 'f':
+			user_csv =3D optarg;
+			break;
+		case 'h':
+			usage();
+			exit(1);
+			break;
+		case 'l':
+			/* main leaf */
+			user_index =3D strtoul(optarg, NULL, 0);
+			break;
+		case 'r':
+			show_raw =3D true;
+			break;
+		case 's':
+			/* subleaf */
+			user_sub =3D strtoul(optarg, NULL, 0);
+			break;
+		default:
+			printf("%s: Invalid option '%c'\n", argv[0], optopt);
+			return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Do 4 things in turn:
+ * 1. Parse user options
+ * 2. Parse and store all the CPUID leaf data supported on this platform
+ * 2. Parse the csv file, while skipping leafs which are not available
+ *    on this platform
+ * 3. Print leafs info based on user options
+ */
+int main(int argc, char *argv[])
+{
+	if (parse_options(argc, argv))
+		return -1;
+
+	/* Setup the cpuid leafs of current platform */
+	setup_platform_cpuid();
+
+	/* Read and parse the 'cpuid.csv' */
+	parse_text();
+
+	show_info();
+	return 0;
+}
