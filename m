Return-Path: <linux-tip-commits+bounces-2610-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4AF9B168B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAB9B21C9D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94351D270B;
	Sat, 26 Oct 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwHWHwRu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQ2wIWB1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178A13B294;
	Sat, 26 Oct 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935172; cv=none; b=SCp0RVuFtZlvxRO0Xi9Jqqf603S1RKdHbVq6xaVFIJ887EmKs5593YGCnOaLLSuonaoMU2/Twtrvy0P9KFB8CqvNL7a5KPoORqM4GAx+pvsuxPyVAmKt8DpYwXLdQu7Qyyayp0bb8s6ydsCZYN0xxRv4+MOK9ft3jUJpSQYdaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935172; c=relaxed/simple;
	bh=MmiI5cfd3sD6eLjS0tSnbM4YjX0YTz8fKqlJu6ELyvI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ftpGE3yPxNvLqeKRDeqLyRe2fZrT0l5hL9/9keYnmk+W770MYZouhjIX9+sYEqxs6Vardb2lcvccOQdwiqaXE3x8pOj+iCd89RG4UcoPbZAY7LrqabHEdP5f59+SGTYthb36T7GUPd28MyGAJaph0jUcgZ6ZlieT+hu1cKsbfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwHWHwRu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQ2wIWB1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 09:32:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729935168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZftpjFa3Mf4AF5gv1GuSjSIWDkwWPDE8CcbFf0fJAg=;
	b=uwHWHwRuuUUHxh6NYqN7N65CreMf9g2aAo54lpHNibzjrnS37dkPf/2IqBu+nlqesxb2xu
	ytUrJaDsFZUS6NqJsEpHioBVZ1ppXOpgWpVB9FRuHdC/vwXu6bUGJFkuuzWe8t7Hrttscz
	WiQz2jvbMXE8pck16o2OQxf4a/30W3FyrQuQ8E/vopTt4nKqRR6Z+w9JZIuFqjqNKUoGjn
	WfTTUIYB+zHA1AXQDU22OWhc6/oKcEyuU6VSqpaFBNmq3hKOkHvb0Y4avpNHuUuCY2JIp5
	fou3+ibkpbOufiq/4Z1ai7iOH3gI76wUvUWix/ORmwrLGkQDGheWFqQj5BTTVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729935168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZftpjFa3Mf4AF5gv1GuSjSIWDkwWPDE8CcbFf0fJAg=;
	b=cQ2wIWB1GA3jO0xa79UWLnDtknpUvjFnUnqIaorNxbdIVRckHZgnD+xM5NxQ2Q8Zspl4hc
	+FP4pf3UJjbnssBA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have
 AMD prefix
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025171459.1093-2-mario.limonciello@amd.com>
References: <20241025171459.1093-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172993516812.1442.7064947682469431542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     104edc6efca628389295392ceb87623fe10c41f6
Gitweb:        https://git.kernel.org/tip/104edc6efca628389295392ceb87623fe10c41f6
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Fri, 25 Oct 2024 12:14:55 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 25 Oct 2024 20:09:16 +02:00

x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix

This feature is an AMD unique feature of some processors, so put
AMD into the name.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241025171459.1093-2-mario.limonciello@amd.com
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/kernel/cpu/scattered.c          | 2 +-
 drivers/cpufreq/amd-pstate.c             | 2 +-
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd46828..a71a403 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -472,7 +472,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c84c301..1db2bb8 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -45,7 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
-	{ X86_FEATURE_FAST_CPPC, 	CPUID_EDX, 15, 0x80000007, 0 },
+	{ X86_FEATURE_AMD_FAST_CPPC,	CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 15e201d..32ddbf3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -842,7 +842,7 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 
 	transition_delay_ns = cppc_get_transition_latency(cpu);
 	if (transition_delay_ns == CPUFREQ_ETERNAL) {
-		if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
+		if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
 			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
 		else
 			return AMD_PSTATE_TRANSITION_DELAY;
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index dd46828..23698d0 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -472,7 +472,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_AMD_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
 
 /*
  * BUG word(s)

