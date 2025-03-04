Return-Path: <linux-tip-commits+bounces-3904-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD4CA4DA7C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E4B18946F4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E220371E;
	Tue,  4 Mar 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zk0sKXEj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2D+iOsy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C7202F64;
	Tue,  4 Mar 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083988; cv=none; b=DhauIFhKYPX6kURD2uh6wg6PQ+mkAhntmuWCEZ3rClcpvb7ZBPWkYvt3i2o09U3oisLGwq6R7yASqnDU8GpQyFAIZ/eq4tc6u6z5MDpPKjb7hNmARBVIY48SGIX3Rqf7Cx9ZP6wVRjbf2SrUIH9d7F/OtquGjTjFURwBEMdssRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083988; c=relaxed/simple;
	bh=wBex5Uiq8Bk23ijsvCbLXhcHDDlKIBE/ro+JA+OC6Y8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dI56NNp+/hDnlRA9CbYXRuVOaQ6N1mlqr/cUowesr7ee9TeEqrwwEIw3p8qreEWjmPwi+sOQ6qq+th5Qo331MXluePkiLE8/2WB3SjNfgoOhWdA/QFY9gEOM3VNk7vT8vsNTWevZRluxmmc6/cs4cXdVasShYIvOs+TxyMjPcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zk0sKXEj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2D+iOsy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHsk3DzzTsVY2dOKWB/ZLhxwcYe0/VmQts3avk17PG0=;
	b=zk0sKXEjVIyFcdZVwi80sIPol3ITNL9RfKIcbekap5hCJ/88Nu1U1Tgdf59mEX0BRj48FU
	+dNfX6h76d/rF/Cw834HPMf/g/JpSxzMJENKOj7g7Z18PXsD/nH21G6wEjxIA5yzScGeYh
	EWjvUrfnNRLuMPVchKXKqN6S5KiodMlAAiZMPkO9Uhj6R++s9oAUcldrmosAj486U5gumo
	+1MSalLsd2BEG3/EAnuwxE/fMLRFbXsHEuI38t7JVvl8DJFtvow/Y8z8mEfLCpojBXC1Nl
	+oI0M03BnnlQ9WObt3wNRrd7W5hS5i2kBVai50Sniw16n0EwIWIPSlAV8MiqAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHsk3DzzTsVY2dOKWB/ZLhxwcYe0/VmQts3avk17PG0=;
	b=R2D+iOsyUjw845WqErCBlyOG32nWzDJoFR+icPNjSlqraLMay1e95UpjbaN/JBfV90YMl5
	PtTKYOP5okxbKfBg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228-call-nospec-v3-2-96599fed0f33@linux.intel.com>
References: <20250228-call-nospec-v3-2-96599fed0f33@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108398437.14745.11035078945434348570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     052040e34c08428a5a388b85787e8531970c0c67
Gitweb:        https://git.kernel.org/tip/052040e34c08428a5a388b85787e8531970c0c67
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Fri, 28 Feb 2025 18:35:58 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:14:42 +01:00

x86/speculation: Add a conditional CS prefix to CALL_NOSPEC

Retpoline mitigation for spectre-v2 uses thunks for indirect branches. To
support this mitigation compilers add a CS prefix with
-mindirect-branch-cs-prefix. For an indirect branch in asm, this needs to
be added manually.

CS prefix is already being added to indirect branches in asm files, but not
in inline asm. Add CS prefix to CALL_NOSPEC for inline asm as well. There
is no JMP_NOSPEC for inline asm.

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228-call-nospec-v3-2-96599fed0f33@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 1e6b915..aee26bb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -198,9 +198,8 @@
 .endm
 
 /*
- * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
- * to the retpoline thunk with a CS prefix when the register requires
- * a RAX prefix byte to encode. Also see apply_retpolines().
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
  */
 .macro __CS_PREFIX reg:req
 	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
@@ -421,11 +420,23 @@ static inline void call_depth_return_thunk(void) {}
 #ifdef CONFIG_X86_64
 
 /*
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
+ */
+#define __CS_PREFIX(reg)				\
+	".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
+	".ifc \\rs," reg "\n"				\
+	".byte 0x2e\n"					\
+	".endif\n"					\
+	".endr\n"
+
+/*
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
 #ifdef CONFIG_MITIGATION_RETPOLINE
-#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
+			"call __x86_indirect_thunk_%V[thunk_target]\n"
 #else
 #define CALL_NOSPEC	"call *%[thunk_target]\n"
 #endif

