Return-Path: <linux-tip-commits+bounces-3694-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194CA479D6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8F53A786A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB94228CBC;
	Thu, 27 Feb 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1HFrP0QP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QWrA4GJu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682321B9EE;
	Thu, 27 Feb 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651126; cv=none; b=ruT2R+H8Q8jhEbxaQxRXI+1o0MDZ6L+SMPnl1i3TBcX/p2MnS6KgoGZZNlcJpc72X/uDD5rnRjI3b2fWTkDD3fpy8D4bg6wPlsb7pbnRYA4cjteBUSYiy47pv7xO9coKbGESZ4yKi/PvHyYQo5pCIeKAQBUKa+92Qcy/kxs/gUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651126; c=relaxed/simple;
	bh=TDaHHD3znPKw0gDl+1AxqWAsn0c2xyArdl1AM8a0KgY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XhjXH/tPTPPskpLQ5Dpjbp6unL/CsnmITioGIuuz6JRYmb0d605zljvyuy06jM+JOGD/nyIJo0icz21GW16dWZc67P845trDH4G9dZChJ3Bxp31bwoIaoTTBukxTYbq7H3/daDLT178fIf3Wqzi7seX3dweouTeijiJZDYpsS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1HFrP0QP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QWrA4GJu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740651122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5kOSPXRtGCZUMNRy6y6gR7OQJiDKyWBsfL7ICDhqh4=;
	b=1HFrP0QPDE6WmfvlyB7Rnirdy8Z3FG6+p0HB/r7v5hOv0oKavAFNoPCOp4bh7EGpRUEk5b
	ZFrxZDtlCGA48pRW5RFBmEayqViyFCtWOEFmRKIukJgUOf5BmCnB1DQX+1LrWry3gHHU6T
	vDGnSciOqtvM1ImFAO7EXZ3sV09fN3eAmYcpyzSU82QaXYQSp9u9KeH+AoDHiPGEi/4zNA
	h0uB5Dp7Mtk8x5kkfX8+4ld+CXS7sAhLXyQk2xHsBAmddVW5UYIfg6UFKW+vPuelEZVBRJ
	oQD9nLBzkI5I3+NUCt/3efUZ5GCzWQrGmzcM8TeDmrXK6uDaSSvzA08vOyw6fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740651122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5kOSPXRtGCZUMNRy6y6gR7OQJiDKyWBsfL7ICDhqh4=;
	b=QWrA4GJuvRZhCf4kPAbF4ycosOvGXg1+vpkmW3NZVOBcXIb1OOGJylhtyWVCslw55gki4J
	5x5bj6b6UixvDIBw==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove X86_FEATURE_USE_IBPB
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250227012712.3193063-7-yosry.ahmed@linux.dev>
References: <20250227012712.3193063-7-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065112088.10177.3693883070893160991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     8f64eee70cdd3bb8c3ec7d30f0d1f52922aaef7c
Gitweb:        https://git.kernel.org/tip/8f64eee70cdd3bb8c3ec7d30f0d1f52922aaef7c
Author:        Yosry Ahmed <yosry.ahmed@linux.dev>
AuthorDate:    Thu, 27 Feb 2025 01:27:12 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:57:21 +01:00

x86/bugs: Remove X86_FEATURE_USE_IBPB

X86_FEATURE_USE_IBPB was introduced in:

  2961298efe1e ("x86/cpufeatures: Clean up Spectre v2 related CPUID flags")

to have separate flags for when the CPU supports IBPB (i.e. X86_FEATURE_IBPB)
and when an IBPB is actually used to mitigate Spectre v2.

Ever since then, the uses of IBPB expanded. The name became confusing
because it does not control all IBPB executions in the kernel.
Furthermore, because its name is generic and it's buried within
indirect_branch_prediction_barrier(), it's easy to use it not knowing
that it is specific to Spectre v2.

X86_FEATURE_USE_IBPB is no longer needed because all the IBPB executions
it used to control are now controlled through other means (e.g.
switch_mm_*_ibpb static branches).

Remove the unused feature bit.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20250227012712.3193063-7-yosry.ahmed@linux.dev
---
 arch/x86/include/asm/cpufeatures.h       | 1 -
 arch/x86/kernel/cpu/bugs.c               | 1 -
 tools/arch/x86/include/asm/cpufeatures.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 43653f2..c8701ab 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -210,7 +210,6 @@
 #define X86_FEATURE_MBA			( 7*32+18) /* "mba" Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
 #define X86_FEATURE_PERFMON_V2		( 7*32+20) /* "perfmon_v2" AMD Performance Monitoring Version 2 */
-#define X86_FEATURE_USE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* Disable Speculative Store Bypass. */
 #define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* AMD SSBD implementation via LS_CFG MSR */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7f904d0..5397d0a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1368,7 +1368,6 @@ spectre_v2_user_select_mitigation(void)
 
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		static_branch_enable(&switch_vcpu_ibpb);
 
 		spectre_v2_user_ibpb = mode;
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 17b6590..ec99113 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -210,7 +210,6 @@
 #define X86_FEATURE_MBA			( 7*32+18) /* "mba" Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
 #define X86_FEATURE_PERFMON_V2		( 7*32+20) /* "perfmon_v2" AMD Performance Monitoring Version 2 */
-#define X86_FEATURE_USE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* Disable Speculative Store Bypass. */
 #define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* AMD SSBD implementation via LS_CFG MSR */

