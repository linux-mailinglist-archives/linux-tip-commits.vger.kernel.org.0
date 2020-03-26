Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C298C193CA3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Mar 2020 11:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZKJE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Mar 2020 06:09:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgCZKIp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRG-000492-QJ; Thu, 26 Mar 2020 11:08:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 57FED1C0440;
        Thu, 26 Mar 2020 11:08:38 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:37 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] x86/kexec: Use RIP relative addressing
Cc:     Brian Gerst <brgerst@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.143334345@infradead.org>
References: <20200324160924.143334345@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731790.28353.15688029952934891534.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/objtool branch of tip:

Commit-ID:     fc8bd77d6476d7733ace9e03093b4acaee6e0605
Gitweb:        https://git.kernel.org/tip/fc8bd77d6476d7733ace9e03093b4acaee6e0605
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Mar 2020 10:13:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:27 +01:00

x86/kexec: Use RIP relative addressing

Normally identity_mapped is not visible to objtool, due to:

  arch/x86/kernel/Makefile:OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o := y

However, when we want to run objtool on vmlinux.o there is no hiding
it:

  vmlinux.o: warning: objtool: .text+0x4c0f1: unsupported intra-function call

Replace the (i386 inspired) pattern:

	call 1f
  1:	popq %r8
	subq $(1b - relocate_kernel), %r8

With a x86_64 RIP-relative LEA:

	leaq relocate_kernel(%rip), %r8

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.143334345@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ef3ba99..cc5c8b9 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -196,10 +196,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
-	call	1f
-1:
-	popq	%r8
-	subq	$(1b - relocate_kernel), %r8
+	leaq	relocate_kernel(%rip), %r8
 	movq	CP_PA_SWAP_PAGE(%r8), %r10
 	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
 	movq	CP_PA_TABLE_PAGE(%r8), %rax
