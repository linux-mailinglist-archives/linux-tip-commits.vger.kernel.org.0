Return-Path: <linux-tip-commits+bounces-3794-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7764A4BE19
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0406B1644B9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1BC1F416F;
	Mon,  3 Mar 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QqXe/56Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q8e/8Kaa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399E1F0E44;
	Mon,  3 Mar 2025 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000369; cv=none; b=IYcjCqpD+leI7Dg4pPle2nHFZT+sAvn9Ikz223gX4nHbeBk9FdA6BrnmKzzaZgHyNtyC8AZ3lGi2jJjaCte+c5aRurpvOvXEUhE59JxlyVydlPfU7caVv3Bm4MkQzW/cmczZW0EjdivpJXyjqX1I5z+M/Cl/O7nDDPvF+/vZHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000369; c=relaxed/simple;
	bh=HevcPsj4EZ7nxgMxzg8R9isQbAjytCJM6F1deVP4mDA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JjCKjfs6ArBL/9+W0zfVoz5KhG31U4ZvMocRvkJ+7188fiHrh60cIM3Hobe30Iwn+6/JZmN8RbbttwyebwaUhotqrIA5BLgqhuHFLt6eAVGPVxrDC03QwiMcuBZn0xYSg0BUxb0ssEJKghXTY/hOFy0xnLdMxDcddL0mxo2ksAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QqXe/56Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q8e/8Kaa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 11:12:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhJJ1mM+GO5lJuov/6T7wXeZ69UGJG3531Q7Ta+mCvc=;
	b=QqXe/56Y2ilLGg8RW8ChsWXoix87fob4RDHroRbYd0yLVk5n76pqVmCMXuwav0N+n8fThw
	wAPwJRLpe5b6hv+OYP94dMAxP4/uWVZgYAzULEVGPLTwOoiE5n0oEUcfUQUCMROQDk23hG
	Sf3JC4TvyHZ7kIy35smQB0KHvqHtP5jOiyL7t6CJ2fs63o5Bl2iNthtHmu8VX/QDLJKiNd
	rAemEXtWPVGtgAZXXoGlRbQtpu6y7xGmgohOP/DTuq9b3zvGOLYdJ0Rawypr4K09i8xSlo
	i19uiGnp0/L/GlSqKpIPtfJfN78jg33Sgh+vprckYG0iHx5IYz9ennifUQBvTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhJJ1mM+GO5lJuov/6T7wXeZ69UGJG3531Q7Ta+mCvc=;
	b=q8e/8KaaodVEEGwXQQqkWEeHW8Dnfr0AiJ+11i+2ygxmAeLS1uCByPZIpzh3JxJiKCBg3l
	0fXXS5T8I9ln8lBQ==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
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
Message-ID: <174100036508.10177.3023736633034298554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9af9ad85ac44cb754e526d468c3006b48db5dfd8
Gitweb:        https://git.kernel.org/tip/9af9ad85ac44cb754e526d468c3006b48db5dfd8
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Fri, 28 Feb 2025 18:35:58 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 12:04:43 +01:00

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

