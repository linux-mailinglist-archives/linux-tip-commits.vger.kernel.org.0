Return-Path: <linux-tip-commits+bounces-2617-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F599B313B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 14:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951EF282921
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16201D90C9;
	Mon, 28 Oct 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZLiAz8SP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="porGqDi0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECD155C97;
	Mon, 28 Oct 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120475; cv=none; b=B37yMLAfrhnJJSzLq6JjLT2Ij9dO534YQ5oNyl3iazs/RR8KlOuacf1fVqbNoGyO2flA7RHUhammIFZMUdzSNIXI3JGRhBj6XhIWztSLEClc8Snbo9JnaL5Dn5YUDrNZSQgkklla65ySN0Z899dWbFZkFD2i4VUGvjE+NfgX3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120475; c=relaxed/simple;
	bh=mHRsDQej5Wi9cNg/358TR5cmyS/sWYQQepAEqCdyTPQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qk9xIXyII524l2OZw7BDRJcKFAWJ7c9riotBVXhBZ5V7wbjF5cfk50ClD4LiZBVrQfp3UxrJhGgS2zHqlYLMWN3G+mgEuEYcKCvZuQza9wKd3S37ZPenx6N8urRYPtdrn9zaxmea3u6+FeioYQybmpewq077BrHBTTIXMC5e3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZLiAz8SP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=porGqDi0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 13:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730120471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VCMxuxeWdDkFSc2MPH0CPBLFNaGhpxknRhhvINPEAc=;
	b=ZLiAz8SPh2Z1Ts24sD4VeU0LxYf6O3IA/hSz6swOnGkF/6xVDXtutlPdPozJSxayWH/CRc
	FvpHtOQNYHUa8WZD98Ylu4KaZPoeBXMHcVrxdhf1E9UaynFVMNJga2v87myL79W3sCqJy6
	zZ/FCyA8hrsTI5sEKLc35lC9yqIec8sx6xcNqg2rcw6EuWXOY2bpT1+9C1UDf9NtzcmRf7
	45IF1CqWpDo0DeZ8PsE1eLyRJ94xF30aruWLrhOpXIFxLjWVzf0OhTYV2ciQwO3NI4GeSc
	UXQlSUejNTUffj0hmHXo9MtqGa/ltaiTUqJ0GIprqRQjxu1ofXk0neiRmpMtfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730120471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VCMxuxeWdDkFSc2MPH0CPBLFNaGhpxknRhhvINPEAc=;
	b=porGqDi06jwYiTMDtEh8jc8kz+8+WK9PjTLpXtVY8Ylxo/7W91cQLKfIbqbyivP+X8eyYD
	G/V/UmfCBP1MNCAg==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Add X86_FEATURE_AMD_WORKLOAD_CLASS
 feature bit
Cc: Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241028020251.8085-4-mario.limonciello@amd.com>
References: <20241028020251.8085-4-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173012047096.1442.13866797476752847698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0c487010cb4f79e451ac9e7cc47494cb21ac3566
Gitweb:        https://git.kernel.org/tip/0c487010cb4f79e451ac9e7cc47494cb21ac3566
Author:        Perry Yuan <perry.yuan@amd.com>
AuthorDate:    Sun, 27 Oct 2024 21:02:41 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Oct 2024 13:44:44 +01:00

x86/cpufeatures: Add X86_FEATURE_AMD_WORKLOAD_CLASS feature bit

Add a new feature bit that indicates support for workload-based heuristic
feedback to OS for scheduling decisions.

When the bit set, threads are classified during runtime into enumerated
classes. The classes represent thread performance/power characteristics
that may benefit from special scheduling behaviors.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20241028020251.8085-4-mario.limonciello@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1216a05..05e985c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -474,6 +474,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 307a917..1e54332 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX,  22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },

