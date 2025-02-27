Return-Path: <linux-tip-commits+bounces-3711-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAB1A47E4B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 13:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2DA1692B5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD6E22D7B2;
	Thu, 27 Feb 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzzNUpz6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouK+RFJI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC99270043;
	Thu, 27 Feb 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660922; cv=none; b=lk3kT0B4SJ5vUJsR24rWxfKESyB1RZgd5DNwwA33pk+Y/9TbSE1dmQI1b4mo+5Rv60GgXZKW8kzmyD++NsTZhnLhYviip5qql43qCct42amdiTTn89UdRdxsVl5RmaXoSvOh7SXlPvY1rayy7zYJnZ6J0Fd4DrXbOSksaltKzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660922; c=relaxed/simple;
	bh=6WA9Y2u0JkbMjOhXCplng2cIcES7LxUMIDD5XdtYSXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eOYBlQlvB9pOaasOxLql1plMr5Am6PF+9ZQhCa9tEpI0gGAnMlyUsanj22FgHQMw2mEE9ZzIySMY2BqGNj+sn+P7N5uu9MoouRihGXYS9S83RUZOY5xJtNQyaSpuPJx2qAm5QNaPHIRSol167Bc58I/ONrtZD+QISM3KSBrd3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzzNUpz6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ouK+RFJI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 12:55:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740660918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSQsHVXWWB0RKHpg+AkwK8Wn1EuGrecV/OqBwOp2lLY=;
	b=jzzNUpz6C1xYV1LeaKeh0ZTslx82lMp+YO4DMuGrujiY7sruQm/2HujaUdfjTeBh1kkR0Z
	HEvIGU5ww/zNCo7EA9Z6p9BeeQSIW12i0uDIubzoj4wSQRiOgruMPn4E0n+VNerv+BFmwv
	rMZ2JChLQlhUumgKj21k0vdSaTBMruM/NsimPvN/GOCnHm8Kt+jGlRXo6M1JGhGkSSNtip
	Sk1DVvvYGFOFaRhBbsn+JskeyZRKS8UolHBY41K1K8p2o6QCuJXAsejlXUc1ZEhUsvO8Yx
	5gF5jh1K5tVmwU2O3ecKCWHLIIU8xYzy0R8DWqU711OfJ3P0WhuhETQK7LgCiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740660918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSQsHVXWWB0RKHpg+AkwK8Wn1EuGrecV/OqBwOp2lLY=;
	b=ouK+RFJICyRL4uOZr2Jmja/ccxfPYwrdaJXXIawZbel5wjQv7sM73eiLgbPSGR6mLsSGQQ
	6krd7jwFVKFTinAA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove get_this_hybrid_cpu_*()
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211-add-cpu-type-v5-4-2ae010f50370@linux.intel.com>
References: <20241211-add-cpu-type-v5-4-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174066091677.10177.7289400408971955716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     db5157df149709c02e6a08c0b3498553bdd2a76c
Gitweb:        https://git.kernel.org/tip/db5157df149709c02e6a08c0b3498553bdd2a76c
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Dec 2024 22:57:41 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 13:34:52 +01:00

x86/cpu: Remove get_this_hybrid_cpu_*()

Because calls to get_this_hybrid_cpu_type() and
get_this_hybrid_cpu_native_id() are not required now. cpu-type and
native-model-id are cached at boot in per-cpu struct cpuinfo_topology.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241211-add-cpu-type-v5-4-2ae010f50370@linux.intel.com
---
 arch/x86/include/asm/cpu.h  | 14 --------------
 arch/x86/kernel/cpu/intel.c | 31 -------------------------------
 2 files changed, 45 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 98eced5..0c8ec62 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -50,20 +50,6 @@ static inline void split_lock_init(void) {}
 static inline void bus_lock_init(void) {}
 #endif
 
-#ifdef CONFIG_CPU_SUP_INTEL
-u8 get_this_hybrid_cpu_type(void);
-u32 get_this_hybrid_cpu_native_id(void);
-#else
-static inline u8 get_this_hybrid_cpu_type(void)
-{
-	return 0;
-}
-
-static inline u32 get_this_hybrid_cpu_native_id(void)
-{
-	return 0;
-}
-#endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
 #else
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3dce22f..045b439 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -873,34 +873,3 @@ static const struct cpu_dev intel_cpu_dev = {
 };
 
 cpu_dev_register(intel_cpu_dev);
-
-#define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
-
-/**
- * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
- *
- * Returns the CPU type [31:24] (i.e., Atom or Core) of a CPU in
- * a hybrid processor. If the processor is not hybrid, returns 0.
- */
-u8 get_this_hybrid_cpu_type(void)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return 0;
-
-	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
-}
-
-/**
- * get_this_hybrid_cpu_native_id() - Get the native id of this hybrid CPU
- *
- * Returns the uarch native ID [23:0] of a CPU in a hybrid processor.
- * If the processor is not hybrid, returns 0.
- */
-u32 get_this_hybrid_cpu_native_id(void)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return 0;
-
-	return cpuid_eax(0x0000001a) &
-	       (BIT_ULL(X86_HYBRID_CPU_TYPE_ID_SHIFT) - 1);
-}

