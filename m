Return-Path: <linux-tip-commits+bounces-4472-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2A5A6EC22
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F533ADB40
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794D254846;
	Tue, 25 Mar 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qk4HRfBH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mh7DOXcu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CA1EA7D3;
	Tue, 25 Mar 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893541; cv=none; b=UZBMT3E4T1SC/EBLBQRVsib7QMOhiXNLi+tU1ZBM84/j269tpV8SHKQ1v500BIPCb9LT6iyB2mciCI0ZYaBQjYLEoOvWzZEWRBShz0MwwA4WSDoz3k3S99opdP7LnMSBO7bQX8PX+RIYnIcX9IQ9GfBpWddsrHZ8nI3TR7sxABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893541; c=relaxed/simple;
	bh=RQjQ8aUOFtY/KY04FORP0O6QP28BlGmraneY2TalLp8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uNeu5u2U8XRwYacTI1Yfq/7wgKRrMbLn5+6nYzljDFBDVkGOpL1NjTw0lMUibI2xvnM8iyQoEMzWkJxgRbrniGEFjQ7H70BgahH5nagHlyNAFXNLrTN8dfp3qxnMqYgtwS5Jd9sgUKiD9El4jiD63hA7tUJGIXHsU3Zt4rBjoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qk4HRfBH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mh7DOXcu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT3JFBZJpQtAkpS06ATgiTquiXUO7uJj+tb9k5TQgi8=;
	b=qk4HRfBHAW6KflD2RmoBRg6wH7XLsHYLY4TUGGtJi046JwNG1IK5u01gTEHYyK8mgVKZuS
	aVJF/HIuhEPRys/ZIpNKOTb5UDggC1CUjlItNA+xU6EUn+z2jCeiiZVjtZcCwd3wM3OmCR
	itcgMfsZQ2hMqZ/xEyK9I43lFGerg/rraOBlu5DH6EvaIZR3P1Sx/VspIdOlWe/ue4uwl4
	FVNKb3lMyrxlONvCVHmQ6oNvo5/OzbBiOVDfVNawMR81I0ZEWiYk5m/YPG9kY7/QwzFDYc
	j3WL0Y98ngAb89AYYAO4wlUo+iTDkl7oPvN+C/ztu58n3DA1Rk8NBRih0Ug8xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT3JFBZJpQtAkpS06ATgiTquiXUO7uJj+tb9k5TQgi8=;
	b=Mh7DOXcuEa1Uj1WAqn6w9f3vubVoWX6rrq6Su7CN4HBcBgZqHQN/yPdu+V7QWs+Q6maGL5
	ITMQRLpfgICaafAg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.2
Cc: Ingo Molnar <mingo@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-19-darwi@linutronix.de>
References: <20250324142042.29010-19-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353695.14745.10612895286678737485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5e0c3c5e95f09236e5f7a73615bfa2666c58f182
Gitweb:        https://git.kernel.org/tip/5e0c3c5e95f09236e5f7a73615bfa2666c58f182
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:47 +01:00

tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.2

Update kcpuid's CSV file to version 2.2, as generated by x86-cpuid-db.

Per Ingo Molnar's feedback, it is desired to always use CPUID in its
capitalized form.  The v2.2 release fixed all instances of small case
"cpuid" at the project's XML database, and thus all of its generated
files.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.2/CHANGELOG.rst
Link: https://lore.kernel.org/r/20250324142042.29010-19-darwi@linutronix.de

Closes: https://lkml.kernel.org/r/Z8bHK391zKE4gUEW@gmail.com
---
 tools/arch/x86/kcpuid/cpuid.csv | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 0f9c112..9613e09 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: CC0-1.0
-# Generator: x86-cpuid-db v2.1
+# Generator: x86-cpuid-db v2.2
 
 #
 # Auto-generated file.
@@ -12,7 +12,7 @@
 # Leaf 0H
 # Maximum standard leaf number + CPU vendor string
 
-       0x0,         0,  eax,    31:0,    max_std_leaf           , Highest cpuid standard leaf supported
+       0x0,         0,  eax,    31:0,    max_std_leaf           , Highest standard CPUID leaf supported
        0x0,         0,  ebx,    31:0,    cpu_vendorid_0         , CPU vendor ID string bytes 0 - 3
        0x0,         0,  ecx,    31:0,    cpu_vendorid_2         , CPU vendor ID string bytes 8 - 11
        0x0,         0,  edx,    31:0,    cpu_vendorid_1         , CPU vendor ID string bytes 4 - 7
@@ -193,7 +193,7 @@
 # Leaf 7H
 # Extended CPU features enumeration
 
-       0x7,         0,  eax,    31:0,    leaf7_n_subleaves      , Number of cpuid 0x7 subleaves
+       0x7,         0,  eax,    31:0,    leaf7_n_subleaves      , Number of leaf 0x7 subleaves
        0x7,         0,  ebx,       0,    fsgsbase               , FSBASE/GSBASE read/write support
        0x7,         0,  ebx,       1,    tsc_adjust             , IA32_TSC_ADJUST MSR supported
        0x7,         0,  ebx,       2,    sgx                    , Intel SGX (Software Guard Extensions)
@@ -281,7 +281,7 @@
        0x7,         1,  eax,       5,    avx512_bf16            , AVX-512 bfloat16 instructions
        0x7,         1,  eax,       6,    lass                   , Linear address space separation
        0x7,         1,  eax,       7,    cmpccxadd              , CMPccXADD instructions
-       0x7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmonExt: CPUID leaf 0x23 is supported
+       0x7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmonExt: leaf 0x23 is supported
        0x7,         1,  eax,      10,    fzrm                   , Fast zero-length REP MOVSB
        0x7,         1,  eax,      11,    fsrs                   , Fast short REP STOSB
        0x7,         1,  eax,      12,    fsrc                   , Fast Short REP CMPSB/SCASB
@@ -319,7 +319,7 @@
        0xa,         0,  eax,     7:0,    pmu_version            , Performance monitoring unit version ID
        0xa,         0,  eax,    15:8,    pmu_n_gcounters        , Number of general PMU counters per logical CPU
        0xa,         0,  eax,   23:16,    pmu_gcounters_nbits    , Bitwidth of PMU general counters
-       0xa,         0,  eax,   31:24,    pmu_cpuid_ebx_bits     , Length of cpuid leaf 0xa EBX bit vector
+       0xa,         0,  eax,   31:24,    pmu_cpuid_ebx_bits     , Length of leaf 0xa EBX bit vector
        0xa,         0,  ebx,       0,    no_core_cycle_evt      , Core cycle event not available
        0xa,         0,  ebx,       1,    no_insn_retired_evt    , Instruction retired event not available
        0xa,         0,  ebx,       2,    no_refcycle_evt        , Reference cycles event not available
@@ -453,7 +453,7 @@
 # Leaf 14H
 # Intel Processor Trace enumeration
 
-      0x14,         0,  eax,    31:0,    pt_max_subleaf         , Max cpuid 0x14 subleaf
+      0x14,         0,  eax,    31:0,    pt_max_subleaf         , Maximum leaf 0x14 subleaf
       0x14,         0,  ebx,       0,    cr3_filtering          , IA32_RTIT_CR3_MATCH is accessible
       0x14,         0,  ebx,       1,    psb_cyc                , Configurable PSB and cycle-accurate mode
       0x14,         0,  ebx,       2,    ip_filtering           , IP/TraceStop filtering; Warm-reset PT MSRs preservation
@@ -490,7 +490,7 @@
 # Leaf 17H
 # Intel SoC vendor attributes enumeration
 
-      0x17,         0,  eax,    31:0,    soc_max_subleaf        , Max cpuid leaf 0x17 subleaf
+      0x17,         0,  eax,    31:0,    soc_max_subleaf        , Maximum leaf 0x17 subleaf
       0x17,         0,  ebx,    15:0,    soc_vendor_id          , SoC vendor ID
       0x17,         0,  ebx,      16,    is_vendor_scheme       , Assigned by industry enumeration scheme (not Intel)
       0x17,         0,  ecx,    31:0,    soc_proj_id            , SoC project ID, assigned by vendor
@@ -503,7 +503,7 @@
 # Leaf 18H
 # Intel determenestic address translation (TLB) parameters
 
-      0x18,      31:0,  eax,    31:0,    tlb_max_subleaf        , Max cpuid 0x18 subleaf
+      0x18,      31:0,  eax,    31:0,    tlb_max_subleaf        , Maximum leaf 0x18 subleaf
       0x18,      31:0,  ebx,       0,    tlb_4k_page            , TLB 4KB-page entries supported
       0x18,      31:0,  ebx,       1,    tlb_2m_page            , TLB 2MB-page entries supported
       0x18,      31:0,  ebx,       2,    tlb_4m_page            , TLB 4MB-page entries supported
@@ -634,7 +634,7 @@
 # Leaf 80000000H
 # Maximum extended leaf number + AMD/Transmeta CPU vendor string
 
-0x80000000,         0,  eax,    31:0,    max_ext_leaf           , Maximum extended cpuid leaf supported
+0x80000000,         0,  eax,    31:0,    max_ext_leaf           , Maximum extended CPUID leaf supported
 0x80000000,         0,  ebx,    31:0,    cpu_vendorid_0         , Vendor ID string bytes 0 - 3
 0x80000000,         0,  ecx,    31:0,    cpu_vendorid_2         , Vendor ID string bytes 8 - 11
 0x80000000,         0,  edx,    31:0,    cpu_vendorid_1         , Vendor ID string bytes 4 - 7
@@ -669,7 +669,7 @@
 0x80000001,         0,  ecx,      17,    tce                    , Translation cache extension
 0x80000001,         0,  ecx,      19,    nodeid_msr             , NodeId MSR (0xc001100c)
 0x80000001,         0,  ecx,      21,    tbm                    , Trailing bit manipulations
-0x80000001,         0,  ecx,      22,    topoext                , Topology Extensions (cpuid leaf 0x8000001d)
+0x80000001,         0,  ecx,      22,    topoext                , Topology Extensions (leaf 0x8000001d)
 0x80000001,         0,  ecx,      23,    perfctr_core           , Core performance counter extensions
 0x80000001,         0,  ecx,      24,    perfctr_nb             , NB/DF performance counter extensions
 0x80000001,         0,  ecx,      26,    bpext                  , Data access breakpoint extension

