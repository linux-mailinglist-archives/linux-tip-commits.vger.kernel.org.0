Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F043F86F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhJ2IFj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53222 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhJ2IFd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:33 -0400
Date:   Fri, 29 Oct 2021 08:03:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcRObp+WBIiG+PVHcNx2MtKa5GGJ0U8bnZ1jnId5fpM=;
        b=4PQRmgRnaRtcnbtCbZ6OA66+sDgN4HuH+rXJZQ7wV4aLd+P/6eYsxHOKXzgxeorod8gRHw
        LOu1w+YHvl9hEqoT7ovDbmy5ustiOh7qbKfHwsBwBtkt0MPgguHx5rmQnpDgGThOTwOyC4
        U+Zf0C15kyDVdYrLbTWQL6E4IIbcLCrTawMOcHvWIWFB5m0bVIyct7Xk4o3jSoFQrT7/Wf
        ym4TuteCIDjwuTnIjt/3vIv+xFyDMoW0YV3hVjzIK6IWMS8HjQIGtk3o0YhkkhS7oChhVT
        sEB8S3QLPaGM1DxUsPCMd6o2ggVlH7+p4EvfMN5KE4XF2kbI/JmARW2TWK2xbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcRObp+WBIiG+PVHcNx2MtKa5GGJ0U8bnZ1jnId5fpM=;
        b=NQGJQlbC70lDjK3gGsWEHRjJAw1S6j9Tpi6EyYFlo+QsErx+kv8qoPhmFeJimaZFbzXiVB
        QdafmSHLf2LBtCAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/retpoline: Remove unused replacement symbols
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120309.915051744@infradead.org>
References: <20211026120309.915051744@infradead.org>
MIME-Version: 1.0
Message-ID: <163549458345.626.16685036988150890180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4fe79e710d9574a14993f8b4e16b7252da72d5e8
Gitweb:        https://git.kernel.org/tip/4fe79e710d9574a14993f8b4e16b7252da72d5e8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:26 +02:00

x86/retpoline: Remove unused replacement symbols

Now that objtool no longer creates alternatives, these replacement
symbols are no longer needed, remove them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120309.915051744@infradead.org
---
 arch/x86/include/asm/asm-prototypes.h | 10 +------
 arch/x86/lib/retpoline.S              | 42 +--------------------------
 2 files changed, 52 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 4cb726c..a28c5ca 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -24,14 +24,4 @@ extern void cmpxchg8b_emu(void);
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
 
-#undef GEN
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_alt_call_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) \
-	extern asmlinkage void __x86_indirect_alt_jmp_ ## reg (void);
-#include <asm/GEN-for-each-reg.h>
-
 #endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ec9922c..a91e0dc 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -41,36 +41,6 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 .endm
 
 /*
- * This generates .altinstr_replacement symbols for use by objtool. They,
- * however, must not actually live in .altinstr_replacement since that will be
- * discarded after init, but module alternatives will also reference these
- * symbols.
- *
- * Their names matches the "__x86_indirect_" prefix to mark them as retpolines.
- */
-.macro ALT_THUNK reg
-
-	.align 1
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	call	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_call_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_call_\reg)
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	jmp	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
-
-.endm
-
-/*
  * Despite being an assembler file we can't just use .irp here
  * because __KSYM_DEPS__ only uses the C preprocessor and would
  * only see one instance of "__x86_indirect_thunk_\reg" rather
@@ -92,15 +62,3 @@ STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
 #undef GEN
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) ALT_THUNK reg
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_call_ ## reg)
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_jmp_ ## reg)
-#include <asm/GEN-for-each-reg.h>
