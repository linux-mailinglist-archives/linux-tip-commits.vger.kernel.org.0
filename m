Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB243F869
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJ2IFg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhJ2IFa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:30 -0400
Date:   Fri, 29 Oct 2021 08:03:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+We7BbFia016++ILQ/sj6Tmb0TrrdMWkMdb4cVvMdcY=;
        b=4cgbJq0X83msgFasJvolpe4i8bTHY/cPrQmAHk7guFcqOQb5WimyJapt/qioQ77D+0MULR
        Hl6QDCdZT08UaWM0Gkgwr9cQ9apIEFGTpnBps7pq343vI0NQ7qQGStUGTwU5rxkAwoUsb8
        +q1d134KtpLxfULp9fcMTLkUsSLIcTyM3G/BjCsksa28D4AWygSHFJLnG/oFu/unmQtmRf
        uUGBh5hzKQWChA6Lz2/B8zsHMPeQebePtjEFoSFiamrmCEeBhs4JGe8CJbZQZZn7jxlH20
        4APYzgEmYQ3WpaOUBsY9qTAmOWXmGk6EEABuA1vMYR3+S/I+zTmPp4AtQ0Mzyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+We7BbFia016++ILQ/sj6Tmb0TrrdMWkMdb4cVvMdcY=;
        b=77lQ1fP+jWCiyAYAL7yZqijMaTeYC9I5tP4cSTnh9KERxCLdtPtCkgc7bv8dmnakhx55Ne
        iI6055RtnsxvG5BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/retpoline: Create a retpoline thunk array
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120310.169659320@infradead.org>
References: <20211026120310.169659320@infradead.org>
MIME-Version: 1.0
Message-ID: <163549458053.626.14549304782977337531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1a6f74429c42a3854980359a758e222005712aee
Gitweb:        https://git.kernel.org/tip/1a6f74429c42a3854980359a758e222005712aee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:27 +02:00

x86/retpoline: Create a retpoline thunk array

Stick all the retpolines in a single symbol and have the individual
thunks as inner labels, this should guarantee thunk order and layout.

Previously there were 16 (or rather 15 without rsp) separate symbols and
a toolchain might reasonably expect it could displace them however it
liked, with disregard for their relative position.

However, now they're part of a larger symbol. Any change to their
relative position would disrupt this larger _array symbol and thus not
be sound.

This is the same reasoning used for data symbols. On their own there
is no guarantee about their relative position wrt to one aonther, but
we're still able to do arrays because an array as a whole is a single
larger symbol.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.169659320@infradead.org
---
 arch/x86/include/asm/nospec-branch.h |  8 +++++++-
 arch/x86/lib/retpoline.S             | 14 +++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 14053cd..e22aedb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -12,6 +12,8 @@
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
 
+#define RETPOLINE_THUNK_SIZE	32
+
 /*
  * Fill the CPU return stack buffer.
  *
@@ -120,11 +122,15 @@
 
 #ifdef CONFIG_RETPOLINE
 
+typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
+
 #define GEN(reg) \
-	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
+	extern retpoline_thunk_t __x86_indirect_thunk_ ## reg;
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+extern retpoline_thunk_t __x86_indirect_thunk_array[];
+
 #ifdef CONFIG_X86_64
 
 /*
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 4c910fa..cf0b39f 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -28,16 +28,14 @@
 
 .macro THUNK reg
 
-	.align 32
-
-SYM_FUNC_START(__x86_indirect_thunk_\reg)
+	.align RETPOLINE_THUNK_SIZE
+SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
 
-SYM_FUNC_END(__x86_indirect_thunk_\reg)
-
 .endm
 
 /*
@@ -55,10 +53,16 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_START(__x86_indirect_thunk_array)
+
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_END(__x86_indirect_thunk_array)
+
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
