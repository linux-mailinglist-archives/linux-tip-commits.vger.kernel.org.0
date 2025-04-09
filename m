Return-Path: <linux-tip-commits+bounces-4789-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B8A823DD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13E68C2D09
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592E2620D3;
	Wed,  9 Apr 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tQRLwBvw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EctZ/B97"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D125EF98;
	Wed,  9 Apr 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199071; cv=none; b=HTcD5cZZMN/h4WPBbmLHIzwfsUbSeEKEPPtkKc5Ojs3bN4xy+ly58IwwbRoOsXWem6cWNt/7YU79TE5Oen/IbUxrdJ9pmnRDyt8L+wjQ131Evrw/V1n1z2N79L1MLb7f0Cp7tyXUitHMsGmIKU/mvfc00ad4eG2tR0hOrQZqgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199071; c=relaxed/simple;
	bh=epgxlbLD8qUFZTQE9AyQZvJRFExfEy+x+P4plQAc96E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PTygrLLh6wmIsh9psjHlNYX1l2Qs3qMIzZ7z3qa4gPIuau25OCrPk3Y6iS+hlBTowKgpQixFBPKHz4URimMYupG8VvNoYtnIqIsK88RvD/KrE77I7fotkQgZxabHqfNRTurmwOjOcAEmauBI41fsIvBaGytMG+Sf7IDv1Uu3V9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tQRLwBvw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EctZ/B97; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:44:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744199066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTjRy2hSvkjyaPLheBt3YYPm2Qyi4D+CqXp6+Z2L63Y=;
	b=tQRLwBvwfz6q/b7d5BZgOngSLiNsyKL/pKuHFoZa3e3Ik5Cp5VNwnIREV8LXk1lqPDP9kV
	keQtIzaqDfP81BQrd/ou6d9c9FGZYP7Vx2CMZlfn04HMvRqgc7KKWgJUIb8Kf63mt5djq4
	CT0UrQypo6Lofkf0RIRMULJLaZ+bhDnYRzUKTyvu2k+WBNzVK9EwtStY8ZlCvp7IRpwwmC
	L9HugaPa4C77iLnf92oiFSwNqvE+ho2Wb/RrtpaSuAubgiKO4azqiOl8cr5xacpPoPTs3R
	PAUTRksinPgrLnoPnBTo6JUcv2N1VDW7KocjGX7ctiUbJdBGWiuVWXgFkZWYrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744199066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTjRy2hSvkjyaPLheBt3YYPm2Qyi4D+CqXp6+Z2L63Y=;
	b=EctZ/B971XYn7p7TZYFD2NxnngTdX5UjAhb78+4YAonTEuu1uNoCrfxUo+r1+wa+h3dP0K
	lKuckGg5FY6ygbBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Rename entry_ibpb() to write_ibpb()
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <1e54ace131e79b760de3fe828264e26d0896e3ac.1744148254.git.jpoimboe@kernel.org>
References:
 <1e54ace131e79b760de3fe828264e26d0896e3ac.1744148254.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419906590.31282.17111759426239648474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     13235d6d50bba99931c4392c0f813cfae0de3eac
Gitweb:        https://git.kernel.org/tip/13235d6d50bba99931c4392c0f813cfae0de3eac
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 14:47:30 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:41:29 +02:00

x86/bugs: Rename entry_ibpb() to write_ibpb()

There's nothing entry-specific about entry_ibpb().  In preparation for
calling it from elsewhere, rename it to write_ibpb().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1e54ace131e79b760de3fe828264e26d0896e3ac.1744148254.git.jpoimboe@kernel.org
---
 arch/x86/entry/entry.S               | 7 ++++---
 arch/x86/include/asm/nospec-branch.h | 6 +++---
 arch/x86/kernel/cpu/bugs.c           | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index d3caa31..cabe65a 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -17,7 +17,8 @@
 
 .pushsection .noinstr.text, "ax"
 
-SYM_FUNC_START(entry_ibpb)
+/* Clobbers AX, CX, DX */
+SYM_FUNC_START(write_ibpb)
 	ANNOTATE_NOENDBR
 	movl	$MSR_IA32_PRED_CMD, %ecx
 	movl	$PRED_CMD_IBPB, %eax
@@ -27,9 +28,9 @@ SYM_FUNC_START(entry_ibpb)
 	/* Make sure IBPB clears return stack preductions too. */
 	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_BUG_IBPB_NO_RET
 	RET
-SYM_FUNC_END(entry_ibpb)
+SYM_FUNC_END(write_ibpb)
 /* For KVM */
-EXPORT_SYMBOL_GPL(entry_ibpb);
+EXPORT_SYMBOL_GPL(write_ibpb);
 
 .popsection
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 8a5cc8e..591d1db 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -269,7 +269,7 @@
  * typically has NO_MELTDOWN).
  *
  * While retbleed_untrain_ret() doesn't clobber anything but requires stack,
- * entry_ibpb() will clobber AX, CX, DX.
+ * write_ibpb() will clobber AX, CX, DX.
  *
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
  * where we have a stack but before any RET instruction.
@@ -279,7 +279,7 @@
 	VALIDATE_UNRET_END
 	CALL_UNTRAIN_RET
 	ALTERNATIVE_2 "",						\
-		      "call entry_ibpb", \ibpb_feature,			\
+		      "call write_ibpb", \ibpb_feature,			\
 		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
@@ -368,7 +368,7 @@ extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 
 extern void entry_untrain_ret(void);
-extern void entry_ibpb(void);
+extern void write_ibpb(void);
 
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4386aa6..608bbe6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1142,7 +1142,7 @@ do_cmd_auto:
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
 		/*
-		 * There is no need for RSB filling: entry_ibpb() ensures
+		 * There is no need for RSB filling: write_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
 		 * regardless of IBPB implementation.
 		 */
@@ -2676,7 +2676,7 @@ static void __init srso_select_mitigation(void)
 				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
 				/*
-				 * There is no need for RSB filling: entry_ibpb() ensures
+				 * There is no need for RSB filling: write_ibpb() ensures
 				 * all predictions, including the RSB, are invalidated,
 				 * regardless of IBPB implementation.
 				 */
@@ -2701,7 +2701,7 @@ ibpb_on_vmexit:
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
 				/*
-				 * There is no need for RSB filling: entry_ibpb() ensures
+				 * There is no need for RSB filling: write_ibpb() ensures
 				 * all predictions, including the RSB, are invalidated,
 				 * regardless of IBPB implementation.
 				 */

