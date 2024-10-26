Return-Path: <linux-tip-commits+bounces-2609-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DE9B1687
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE45D28304F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB861D0F44;
	Sat, 26 Oct 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0i2hUVt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpVmaQ5+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E1A18B499;
	Sat, 26 Oct 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935171; cv=none; b=C2TRONgoHPhpCueCegK1gmTr5LY5kkL9Eo5v1YZPanc7t9GPPD2kBurzKFnl19JKdu7MSj8KP4wLeFbrVQGSgE08HUrcT7oCwOFvBx6jaFvTDC37RKgFfq8xwZyI65CmCOX1KHC6EqR8HHaMCPyZ4qEnZsG0wkZE15oALKTxTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935171; c=relaxed/simple;
	bh=JLHoK5z1nhI6c6ME76h5CjQUFJGY5O7aZ3ct+NteM+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dc/EPTu+KiM4oeNYGM+ktYJ4MvawSIk03kMVuBuazmy924BHfowkdlX70xQm2nnn3zKXq29DEIZgBDmPgmTMwlgA9Wae+CTouzUAk2RTiIjy47FZT8M3BOgahQJVgRexEvtqkKO6qd7RB84Viwiky8kNUHVf/DheSPum5VIPFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0i2hUVt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpVmaQ5+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 09:32:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729935168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VOutbLXI7Vs+FKLv/Eafu9lf2Hogn9/Ps2xGOGGrPs=;
	b=g0i2hUVtpttQloeUNZRTOcrbZUVhyy7IFqZFuaUwQw3Xodm7Sn0i4Q4FbkeY3JMsiLwV5v
	rG6jjD4000/IyVlCco2Crv6hMW83ToLlEoXZwvLmuTsEyrp+gdw1eacmgMvuAgDEnlwEKJ
	1pCTji+bTiqgk7ftV4ej6PHyhgKgsgHrgG7Jp00LrjwJrYX0/JQ8QRJAhd8rFAenehKNxn
	SOXZdaUxk7YIb1R1vByW6PpwDxJ+uTL2ftSiqkzIAeTNg/ZZJYJlQsP3nLcYvLvA6ldO7j
	mOomXBSQMTsHyFn9ds7rgBtM2EmTCAGM61AjYtiIsL4k/XPejcowlLyt3qyPlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729935168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VOutbLXI7Vs+FKLv/Eafu9lf2Hogn9/Ps2xGOGGrPs=;
	b=lpVmaQ5+IVT5BiFkSR5477ToJ/5DQ8sFeNpSy9edM8NC1n4rZeqRkphkgB4EZsXtebt0dz
	Kjyh2jWRzyPoQuDw==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpufeatures: Add X86_FEATURE_AMD_HETEROGENEOUS_CORES
Cc: Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025171459.1093-3-mario.limonciello@amd.com>
References: <20241025171459.1093-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172993516748.1442.17782562564581072875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1ad466706671436994ec7e71305f44692fed989a
Gitweb:        https://git.kernel.org/tip/1ad466706671436994ec7e71305f44692fed989a
Author:        Perry Yuan <perry.yuan@amd.com>
AuthorDate:    Fri, 25 Oct 2024 12:14:56 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 25 Oct 2024 20:31:16 +02:00

x86/cpufeatures: Add X86_FEATURE_AMD_HETEROGENEOUS_CORES

CPUID leaf 0x80000026 advertises core types with different efficiency
rankings.

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

This is described in the AMD64 Architecture Programmers Manual Volume
2 and 3, doc ID #25493 and #25494.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241025171459.1093-3-mario.limonciello@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a71a403..1216a05 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,6 +473,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 1db2bb8..307a917 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 

