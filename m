Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248AB3803D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 May 2021 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhENG4y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 May 2021 02:56:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34704 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhENG4y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 May 2021 02:56:54 -0400
Date:   Fri, 14 May 2021 06:55:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620975342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QBKGT4MxKiFHjpSVQ3RwqKQEq3MKk/Q+Vgf6AUlogtg=;
        b=kBwwVo9p/SBCQjXZ5VEGNlQrlH7+kIXbWEnoyVByyn/imFMs+ZB0Ubt18JaqB2iclLtzHi
        o+zeTE4Ewo4inc2IV3HcoDs55N4YyBBVNwf+TiMpVOFiByMnQleHx9s1aghsoJ1qQB3tz/
        jMHx729f/mdgRTsI1JRQDaRmk7RJ3cYQ+zu7igtJRNsQm9eJRhJ0dsXWNEIOteAYFaUSPb
        W1gNZq1GsRMS2Z/UM542Hwxe5PovQ6kTiffT9Obq5XIdk4bIBdsRfbpV1TVsTKxiXSzQX7
        5VriCTGpTILRpQxg9yN6GDwTru7HFna6IxYqMNo7fILMVOg0epBlJDd3r5oDVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620975342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QBKGT4MxKiFHjpSVQ3RwqKQEq3MKk/Q+Vgf6AUlogtg=;
        b=njNvGawT75Ar1fRb11IOyDFXrNR+dFLhYUaaoijFUlpaEBuxyT0M8YFzTFuK5pVV4mVEQl
        uc4YHhfGzNEFaTBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Make <asm/asm.h> valid on cross-builds as well
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162097534183.29796.426541546552051038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     41f45fb045bcc20e71eb705b361356e715682162
Gitweb:        https://git.kernel.org/tip/41f45fb045bcc20e71eb705b361356e715682162
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 13 May 2021 13:41:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 May 2021 08:50:28 +02:00

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
Reviewed-by: H. Peter Anvin <hpa@zytor.com>
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
