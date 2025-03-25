Return-Path: <linux-tip-commits+bounces-4480-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A0A6EC32
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171D51896EA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450622561DF;
	Tue, 25 Mar 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qc/K+1m6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UgDNeygu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7494255252;
	Tue, 25 Mar 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893547; cv=none; b=jRvHQFa+tU2c6EcgxUKQ7BDiusHwtSPnPR3uRh93eUuLV70yoA7PM2krF8Bla0YJOX8iLQCUJYMVe5HsBGq6IUyvDuRTbKsIVO0/abq39aEReR0dOFFmC1AgBaoMAzDXctgqlQh4jdAmnwUpterGvGpBTkc+NSFjPIZlKtPd7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893547; c=relaxed/simple;
	bh=q5Yrvu4POrN7xFo27iP4UrzSqMh45skr+MXffiNfW3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AmgLB4PbKuNTZLs6q2Ql28x/4dHk8Ze5dBET6urUO4olmr05dF9Qb+vUpHEPam6YCzSh0/PwqxTLVA9FeilbhuEmlwuKJUTFB8jqbkRtAOavbz3vc/3QpjGV+gDVsX1P6Jb+7Emuzm2ljP3l7mR16DGeFGuiaRXg9Ww/WKokltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qc/K+1m6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UgDNeygu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wp7J1TATaR4+mNWhc4+Yazig/WENgnK4sFlaFBLxSBo=;
	b=qc/K+1m6dnFmxdfUjnrepEgH8oykQFumgfm9akEB1fo8wFTpkqQzUYo3DjGVOUccCIliua
	SA793rkb/WnrUUhWqI4c/6qOWmoFgaIze4m9+4ZiHoQ73xVdDPQsvHBEkf0fMuvm4exa/u
	qsNDrAhMfV2Gs2WOXOU32q00vAUTXIuyUL5w6cyutUTnWSLdeRLZ95BH4gL3OREeocv12h
	21ScuNKnPqE1+RhKOZ7q07smrzfq1hliFB+VZd0R+onEZHh2Lh0Xh2BodSFnBhHt1DMr8L
	V+O1gErsK0HQbQboLydrPXOkaxoK1FcG3pw2m1pZOFNv7XwJMkorXfC+cj4e6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wp7J1TATaR4+mNWhc4+Yazig/WENgnK4sFlaFBLxSBo=;
	b=UgDNeygu1KXLaCdmWD74vNYx+/bOrxsv8Ms+X2PfHNbH11l0uRGzIWtwIA90SCePBgC7Ge
	5i7QLuHImci2gVDw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Use <cpuid.h> intrinsics
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-11-darwi@linutronix.de>
References: <20250324142042.29010-11-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354186.14745.673118297329233119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c479a84488d10b3d4259186d80839f99e26b1706
Gitweb:        https://git.kernel.org/tip/c479a84488d10b3d4259186d80839f99e26b1706
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:45 +01:00

tools/x86/kcpuid: Use <cpuid.h> intrinsics

Use the __cpuid_count() intrinsic, provided by GCC and LLVM, instead of
rolling a manual version.  Both of the kernel's minimum required GCC
version (5.1) and LLVM version (13.0.1) supports it, and it is heavily
used across standard Linux user-space tooling.

This also makes the CPUID call sites more readable.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-11-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 37 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 413e5da..25388a5 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 
+#include <cpuid.h>
 #include <err.h>
 #include <getopt.h>
 #include <stdbool.h>
@@ -86,16 +87,16 @@ static u32 user_index = 0xFFFFFFFF;
 static u32 user_sub = 0xFFFFFFFF;
 static int flines;
 
-static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile("cpuid"
-	    : "=a" (*eax),
-	      "=b" (*ebx),
-	      "=c" (*ecx),
-	      "=d" (*edx)
-	    : "0" (*eax), "2" (*ecx));
-}
+/*
+ * Force using <cpuid.h> __cpuid_count() instead of __cpuid(). The
+ * latter leaves ECX uninitialized, which can break CPUID queries.
+ */
+
+#define cpuid(leaf, a, b, c, d)				\
+	__cpuid_count(leaf, 0, a, b, c, d)
+
+#define cpuid_count(leaf, subleaf, a, b, c, d)		\
+	__cpuid_count(leaf, subleaf, a, b, c, d)
 
 static inline bool has_subleafs(u32 f)
 {
@@ -195,12 +196,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	u32 max_func, idx_func;
 	u32 eax, ebx, ecx, edx;
 
-	eax = input_eax;
-	ebx = ecx = edx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
-
-	max_func = eax;
-	idx_func = (max_func & 0xffff) + 1;
+	cpuid(input_eax, max_func, ebx, ecx, edx);
 
 	range = malloc(sizeof(struct cpuid_range));
 	if (!range)
@@ -211,6 +207,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	else
 		range->is_ext = false;
 
+	idx_func = (max_func & 0xffff) + 1;
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
@@ -222,9 +219,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		u32 max_subleaf = MAX_SUBLEAF_NUM;
 		bool allzero;
 
-		eax = f;
-		ecx = 0;
-		cpuid(&eax, &ebx, &ecx, &edx);
+		cpuid(f, eax, ebx, ecx, edx);
 
 		allzero = cpuid_store(range, f, 0, eax, ebx, ecx, edx);
 		if (allzero)
@@ -251,9 +246,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 			max_subleaf = 5;
 
 		for (u32 subleaf = 1; subleaf < max_subleaf; subleaf++) {
-			eax = f;
-			ecx = subleaf;
-			cpuid(&eax, &ebx, &ecx, &edx);
+			cpuid_count(f, subleaf, eax, ebx, ecx, edx);
 
 			allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
 			if (allzero)

