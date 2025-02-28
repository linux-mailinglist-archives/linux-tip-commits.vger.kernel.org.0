Return-Path: <linux-tip-commits+bounces-3739-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D5A49898
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 12:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B4B1717BC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D52620F9;
	Fri, 28 Feb 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmm1Wifu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Djx1kyEW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0F25F790;
	Fri, 28 Feb 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743629; cv=none; b=oCgoyGToGr7eFklcO11WL2zIYmaJFocILiaeBCDVTfOq8+7Hg0nCLjb/1ICmorP+DCZh+LqX9ED67dIx7QjHWETRfBTrVnfZEG1DoRGgSpsAi0RhMGlw9krj4i+8Nl8Yb2dK+REB2Mot+m0zYbGr6LAShobLEiLGn9UfzG/yU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743629; c=relaxed/simple;
	bh=Xx+4DZJBedoY68hJkMV5msyJ11vfL3QGPNi6lrxFSOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l8vgkip+TV/ssMAoqDQ4ihrNvRPH4+RrLU8vL3YwUtfZnsWXZVJzClsGCqBDi/Sx7iU6lboXSAq5VCjlRkaeQWi3LVrThyr1jPjegmcC1O6JFaIpxAaa48ntkBLv0spXB32v9gJNO2K1XitezXBrrSeJlqBREEQ6zYG+sUElcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmm1Wifu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Djx1kyEW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 11:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740743625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAPqhRamjcVJxO68ILjzT32M+umBIEEXQgY+krUtrIA=;
	b=pmm1Wifu4ex4ML80wjiL5vonEhZGuCVysNDcegibtqKxnAU42Gny02u4YVQGBeiqVcC0jZ
	XUHK7pjwE9C9M4mc2l2WaQ1DWtgLaxS4W5KHurByIESXpbGHd68c4HczqriyG08LQFbB1u
	2X+dquY/pqKb4WDa2TLLUHuEZARSVpsFscSbPlxDQ3P7HgUUM7hl5jITEuGco4SbxNg3Ul
	j0Zbk/C9ohN06QMUkeDP2KKFmQEwEZ5VFvAUbKY4OAU1Hp2mA5oy7f7iXN5ocfKN9Ju/mD
	afB+IO2Zmb0+yAjGmQ96HBoFUU5bXLTtBuAOO8OIWKK6qwzF3zvwdmVEmtfTOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740743625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAPqhRamjcVJxO68ILjzT32M+umBIEEXQgY+krUtrIA=;
	b=Djx1kyEWNiaTe6L780mVquGUIK8rVBcfD1jxxohnXE8XtJq9uDw6P5otKoa5bIXi3IHPmB
	mrWlOJeI7ZMQC1Dw==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add X86_BUG_SPECTRE_V2_USER
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250108202515.385902-2-david.kaplan@amd.com>
References: <20250108202515.385902-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174074362446.10177.6431632226859188999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     98c7a713db91c5a9a7ffc47cd85e7158e0963cb8
Gitweb:        https://git.kernel.org/tip/98c7a713db91c5a9a7ffc47cd85e7158e0963cb8
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 08 Jan 2025 14:24:41 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Feb 2025 12:34:30 +01:00

x86/bugs: Add X86_BUG_SPECTRE_V2_USER

All CPU vulnerabilities with command line options map to a single X86_BUG bit
except for Spectre V2 where both the spectre_v2 and spectre_v2_user command
line options are related to the same bug.

The spectre_v2 command line options mostly relate to user->kernel and
guest->host mitigations, while the spectre_v2_user command line options relate
to user->user or guest->guest protections.

Define a new X86_BUG bit for spectre_v2_user so each *_select_mitigation()
function in bugs.c is related to a unique X86_BUG bit.

No functional changes.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250108202515.385902-2-david.kaplan@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/common.c       | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index c8701ab..0bc4203 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -537,4 +537,5 @@
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b..1e80d76 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1331,8 +1331,10 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 
-	if (!cpu_matches(cpu_vuln_whitelist, NO_SPECTRE_V2))
+	if (!cpu_matches(cpu_vuln_whitelist, NO_SPECTRE_V2)) {
 		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2_USER);
+	}
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_SSB) &&
 	    !(x86_arch_cap_msr & ARCH_CAP_SSB_NO) &&

