Return-Path: <linux-tip-commits+bounces-3151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E017C9FE951
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058CF161437
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E841AE877;
	Mon, 30 Dec 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVtPPmVF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZCvhUMVl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7B7DA6D;
	Mon, 30 Dec 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735578172; cv=none; b=JjzeR9/u0wi90FhPDUXN49YPTqQBnd+TSbImzkMCf6gF8LihGCF8IHjd8swToHe7zSdYVM0dOBVJdP7I8DxMqqCaAN9eSZrQlJL3ml49tLNS8+BDcFhSqDEsSGZ97Y3cuUmz7Ymx2S+16N1Zc0H1jQi3R9Zpm0bwmSvKmtMkF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735578172; c=relaxed/simple;
	bh=lkPQfjY+5ssNm+aEgJs6ygpCM8evtHaOcHlFFHgmaSE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TqfSUSWo1M+NUzrdhcjW/v7v54KTdvYHzkABuLfEQqGOA2R8r08q5XpVPlwuTdtILiBRuT7PKoh7MXKmgp1/gpGsjb/WvXlb4bbHlcGMdxyJYPIwWIVji0F6UX0KmUlKPI/b9pxNE1iEgAjNBMtRxzkUOiu78KTlSvvaKDgHwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVtPPmVF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZCvhUMVl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Dec 2024 17:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735578167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYlGub5D7c7to8ck0409+4DwKhTBneGnUG5YlkJ3dok=;
	b=qVtPPmVFFVnKOjcO5mRqxrNa2cm5FIf4dl1QYJc0WQTdqOYPw1GRLFdpxXOqaiWgomfEcr
	YVg/AE48l2pmwQyHSBPBsLnHtwGoyAytrDPHYmX47aNA8UC1lhihInVLgebn5gGIwg70XQ
	xk4LTfW+POeFP1+yrRbwtwNnF8caNSwbDgtWs8yCvDDGmyIncJPZrG5+DnuG9MHnn/xjyJ
	AkA9M2a54VtO2kXqfyxHT4huPmu8ZurEWvDS9kWTw95ZAU/rGf2H7lzEtuyex+Bd1h27bN
	FH3J6HiuUbn7PN6lj6Ybssrsz8i352DoAi2LMdus6ofFn05v3r4fFaPpDpidIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735578167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYlGub5D7c7to8ck0409+4DwKhTBneGnUG5YlkJ3dok=;
	b=ZCvhUMVlFL9B5r2MeF0osL1kgEY0LOKULHmMsKEcVTBopcrm0aHdmPMAUxqGBrSl6VQjfT
	Do1/dz+mNdN8AaCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add SRSO_USER_KERNEL_NO support
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202120416.6054-2-bp@kernel.org>
References: <20241202120416.6054-2-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173557816681.399.1494410468590686640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     877818802c3e970f67ccb53012facc78bef5f97a
Gitweb:        https://git.kernel.org/tip/877818802c3e970f67ccb53012facc78bef5f97a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 11 Nov 2024 17:22:08 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Dec 2024 17:48:33 +01:00

x86/bugs: Add SRSO_USER_KERNEL_NO support

If the machine has:

  CPUID Fn8000_0021_EAX[30] (SRSO_USER_KERNEL_NO) -- If this bit is 1,
  it indicates the CPU is not subject to the SRSO vulnerability across
  user/kernel boundaries.

have it fall back to IBPB on VMEXIT only, in the case it is going to run
VMs:

  Speculative Return Stack Overflow: Mitigation: IBPB on VMEXIT only

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20241202120416.6054-2-bp@kernel.org
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/bugs.c         | 4 ++++
 arch/x86/kernel/cpu/common.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 645aa36..0e2d817 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -465,6 +465,7 @@
 #define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* CPU is not affected by SRSO */
+#define X86_FEATURE_SRSO_USER_KERNEL_NO	(20*32+30) /* CPU is not affected by SRSO across user/kernel boundaries */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 47a01d4..5a505aa 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2615,6 +2615,9 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_SAFE_RET:
+		if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))
+			goto ibpb_on_vmexit;
+
 		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
 			/*
 			 * Enable the return thunk for generated code
@@ -2658,6 +2661,7 @@ static void __init srso_select_mitigation(void)
 		}
 		break;
 
+ibpb_on_vmexit:
 	case SRSO_CMD_IBPB_ON_VMEXIT:
 		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
 			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e90376..7e8d811 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1270,6 +1270,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_AMD(0x19, SRSO),
+	VULNBL_AMD(0x1a, SRSO),
 	{}
 };
 

