Return-Path: <linux-tip-commits+bounces-4471-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85444A6EC21
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47DB7A378C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A1253F2A;
	Tue, 25 Mar 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kjn1+oNE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjHXTgjC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7406253B66;
	Tue, 25 Mar 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893540; cv=none; b=HbzkCrpTsjrg19XSqr6oObNMxlO79KpM8kjnWw5RadyHFzW3tTV4bL2uAI2MNh0KLmISomfJ988FnF6FrFZ55rLomhJZkpRoFyVAIliHp4I3Y1Adx0H+jh84tsA2xr/9Gl0JMEX6EKO4suGgIdJ7TPNKsrKY2KtwB9U13+Rp+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893540; c=relaxed/simple;
	bh=dKE/Yz2Kx9+34ZetwfIVerw+OKZW1W0DldNjfHcbGBo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ab+jAAfAryOJpYTKTz+eqP1kxF1J1WYAmMthxf6o3c14DdI1cGAOcARbr/mK6Uunsot3LQds4wOWTrcL8O9dI1J5uAFEd+42FTjMax5QKO/rZzZwPa61eLxSdeRZbYzlD83IkK1pghmxdexblh/LFabtuWKhDQGu5Ofafg7EwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kjn1+oNE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjHXTgjC; arc=none smtp.client-ip=193.142.43.55
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
	bh=xSvpSRHdA89XpKYovwkTb6M5lCH826uRI2P/90snchQ=;
	b=Kjn1+oNEkACYm6quji78rJcgRDbmO9E+u1vLUcFxoJVn1qofls9KtPpG8DaB6BT2LbLgIB
	GMoETiqow8Jh9C5KqXPNfS/9HYv5+j8tQ6jbz4LmC0ovXB9AaESzSLEa9J3M3mMffRG4JL
	L/NaGp4pS/JVXUXOK1qqJk4K6oyzNRNE2GNBQK2BHnomhW5JurY+1iEw4Xfff/MJV47AW+
	nxqAJ0+r0TEHpz+8k1uc6qyJ9XvMUbLWOjN/KxFlCGNVUrHOhN1oBO8cMNLT5xC7cj1/6P
	h0uHNizvK2sGgWI6A9WRBQO0gIk88YqFEJFUJyCe4X9s9xEEOlcZzhrtLQycJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSvpSRHdA89XpKYovwkTb6M5lCH826uRI2P/90snchQ=;
	b=YjHXTgjCrhgDN1Ha936WQY+eJkEJAoG4O8Xlz7aL4QwbaVr+/vhAnz8ggQJGKetpdVZSU1
	GDzquOQ9naAXRjAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.3
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-20-darwi@linutronix.de>
References: <20250324142042.29010-20-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353639.14745.1944124145277246474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     300ba891418ae72df8d16fc26886f1d049c70907
Gitweb:        https://git.kernel.org/tip/300ba891418ae72df8d16fc26886f1d049c70907
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:47 +01:00

tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.3

Update kcpuid's CSV file to version 2.3, as generated by x86-cpuid-db.

Summary of the v2.3 changes:

* Per H. Peter Anvin's feedback, leaf 0x3 is not unique to Transmeta as
  the CSV file earlier claimed.  Since leaf 0x3's format differs between
  Intel and Transmeta, and the project does not yet support having the
  same CPUID bitfield with varying interpretations across vendors, leaf
  0x3 is removed for now.  Given that Intel discontinued support for PSN
  from Pentium 4 onward, and Linux force disables it on early boot for
  privacy concerns, this should have minimal impact.

* Leaf 0x80000021: Make bitfield IDs and descriptions coherent with each
  other.  Remove "_support" from bitfield IDs, as no other leaf has such
  convention.

Reported-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.3/CHANGELOG.rst
Link: https://lore.kernel.org/r/20250324142042.29010-20-darwi@linutronix.de

Closes: https://lkml.kernel.org/r/C7684E03-36E0-4D58-B6F0-78F4DB82D737@zytor.com
---
 tools/arch/x86/kcpuid/cpuid.csv | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 9613e09..8d25b0b 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: CC0-1.0
-# Generator: x86-cpuid-db v2.2
+# Generator: x86-cpuid-db v2.3
 
 #
 # Auto-generated file.
@@ -116,14 +116,6 @@
        0x2,         0,  edx,   30:24,    desc15                 , Descriptor #15
        0x2,         0,  edx,      31,    edx_invalid            , Descriptors 12-15 are invalid if set
 
-# Leaf 3H
-# Transmeta Processor Serial Number (PSN)
-
-       0x3,         0,  eax,    31:0,    cpu_psn_0              , Processor Serial Number bytes 0 - 3
-       0x3,         0,  ebx,    31:0,    cpu_psn_1              , Processor Serial Number bytes 4 - 7
-       0x3,         0,  ecx,    31:0,    cpu_psn_2              , Processor Serial Number bytes 8 - 11
-       0x3,         0,  edx,    31:0,    cpu_psn_3              , Processor Serial Number bytes 12 - 15
-
 # Leaf 4H
 # Intel deterministic cache parameters
 
@@ -1020,20 +1012,20 @@
 0x80000021,         0,  eax,       0,    no_nested_data_bp      , No nested data breakpoints
 0x80000021,         0,  eax,       1,    fsgs_non_serializing   , WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing
 0x80000021,         0,  eax,       2,    lfence_rdtsc           , LFENCE always serializing / synchronizes RDTSC
-0x80000021,         0,  eax,       3,    smm_page_cfg_lock      , SMM paging configuration lock is supported
+0x80000021,         0,  eax,       3,    smm_page_cfg_lock      , SMM paging configuration lock
 0x80000021,         0,  eax,       6,    null_sel_clr_base      , Null selector clears base
-0x80000021,         0,  eax,       7,    upper_addr_ignore      , EFER MSR Upper Address Ignore Enable bit supported
-0x80000021,         0,  eax,       8,    autoibrs               , EFER MSR Automatic IBRS enable bit supported
-0x80000021,         0,  eax,       9,    no_smm_ctl_msr         , SMM_CTL MSR (0xc0010116) is not present
-0x80000021,         0,  eax,      10,    fsrs_supported         , Fast Short Rep STOSB (FSRS) is supported
-0x80000021,         0,  eax,      11,    fsrc_supported         , Fast Short Rep CMPSB (FSRC) is supported
-0x80000021,         0,  eax,      13,    prefetch_ctl_msr       , Prefetch control MSR is supported
+0x80000021,         0,  eax,       7,    upper_addr_ignore      , EFER MSR Upper Address Ignore
+0x80000021,         0,  eax,       8,    autoibrs               , EFER MSR Automatic IBRS
+0x80000021,         0,  eax,       9,    no_smm_ctl_msr         , SMM_CTL MSR (0xc0010116) is not available
+0x80000021,         0,  eax,      10,    fsrs                   , Fast Short Rep STOSB
+0x80000021,         0,  eax,      11,    fsrc                   , Fast Short Rep CMPSB
+0x80000021,         0,  eax,      13,    prefetch_ctl_msr       , Prefetch control MSR is available
 0x80000021,         0,  eax,      16,    opcode_reclaim         , Reserves opcode space
 0x80000021,         0,  eax,      17,    user_cpuid_disable     , #GP when executing CPUID at CPL > 0 is supported
-0x80000021,         0,  eax,      18,    epsf_supported         , Enhanced Predictive Store Forwarding (EPSF) is supported
+0x80000021,         0,  eax,      18,    epsf                   , Enhanced Predictive Store Forwarding
 0x80000021,         0,  eax,      22,    wl_feedback            , Workload-based heuristic feedback to OS
-0x80000021,         0,  eax,      24,    eraps_support          , Enhanced Return Address Predictor Security
-0x80000021,         0,  eax,      27,    sbpb                   , Support for the Selective Branch Predictor Barrier
+0x80000021,         0,  eax,      24,    eraps                  , Enhanced Return Address Predictor Security
+0x80000021,         0,  eax,      27,    sbpb                   , Selective Branch Predictor Barrier
 0x80000021,         0,  eax,      28,    ibpb_brtype            , Branch predictions flushed from CPU branch predictor
 0x80000021,         0,  eax,      29,    srso_no                , CPU is not subject to the SRSO vulnerability
 0x80000021,         0,  eax,      30,    srso_uk_no             , CPU is not vulnerable to SRSO at user-kernel boundary

