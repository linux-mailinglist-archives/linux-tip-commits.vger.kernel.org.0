Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF4C37F76C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhEMMHu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 08:07:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbhEMMHg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 08:07:36 -0400
Date:   Thu, 13 May 2021 12:06:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620907584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OfSgEs6K2vIwfb48s+CnOVp73nWZdkBQo4IhPqMOmNI=;
        b=RXVxAw9VTpxWmsNMFX408LEkYOr2N+Yir7yyhq6NQX4bY6YRU9BfsJXEh4+PdREEoH/pRd
        SIMNXJLQRD1MGmt+ZCfiaafQz4OCrwlCFuAEBQNdQ6BuJEd6kTx1Fsk1D2JK1S4UwKNhxw
        4/3M321SROxlvIwPRXOiVL3XlzcMD7hxEK+vfHHodwvgOHFUjzgZiL0Ag209nWDfd25BRK
        G87cYvp0ffGhAieNDdJjKOi6Vyj5Jl4QUfOoXDNyrYYIwGNaaZOcqWLiaxW3ygFhRMFh41
        uCxzT47/hQVdNYeThtSHaWXCIlAA0FnrIDmrbFrs1j+7w5wcvdxjGSBrwVA30g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620907584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OfSgEs6K2vIwfb48s+CnOVp73nWZdkBQo4IhPqMOmNI=;
        b=O0h21mANTfXP35Zg+tKUXjK2mHR10AsZp2P3RTJrvtA2MfIj//RgIDq47kqsyKNsRj8URS
        I5AMdaVrAZ5JVqBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Make <asm/asm.h> valid on cross-builds as well
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162090758316.29796.6557455559313150627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4173d63a75ce47de95ce5406d8adab9005826def
Gitweb:        https://git.kernel.org/tip/4173d63a75ce47de95ce5406d8adab9005826def
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 13 May 2021 13:41:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 13:45:04 +02:00

x86/asm: Make <asm/asm.h> valid on cross-builds as well

Stephen Rothwell reported that the objtool cross-build breaks on
non-x86 hosts:

  > tools/arch/x86/include/asm/asm.h:185:24: error: invalid register name for 'current_stack_pointer'
  >   185 | register unsigned long current_stack_pointer asm(_ASM_SP);
  >       |                        ^~~~~~~~~~~~~~~~~~~~~

The PowerPC host obviously doesn't know much about x86 register names.

Protect the kernel-specific bits of <asm/asm.h>, so that it can be
included by tooling and cross-built.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/asm.h       | 4 ++++
 tools/arch/x86/include/asm/asm.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 507a37a..3ad3da9 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -120,6 +120,8 @@
 # define CC_OUT(c) [_cc_ ## c] "=qm"
 #endif
 
+#ifdef __KERNEL__
+
 /* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
@@ -186,4 +188,6 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif /* __ASSEMBLY__ */
 
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_X86_ASM_H */
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
index 507a37a..3ad3da9 100644
--- a/tools/arch/x86/include/asm/asm.h
+++ b/tools/arch/x86/include/asm/asm.h
@@ -120,6 +120,8 @@
 # define CC_OUT(c) [_cc_ ## c] "=qm"
 #endif
 
+#ifdef __KERNEL__
+
 /* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
@@ -186,4 +188,6 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif /* __ASSEMBLY__ */
 
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_X86_ASM_H */
