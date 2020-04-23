Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF81B5697
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 09:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgDWHur (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Apr 2020 03:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgDWHtu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7EC03C1AB;
        Thu, 23 Apr 2020 00:49:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcB-0008OZ-Kj; Thu, 23 Apr 2020 09:49:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 46F861C047B;
        Thu, 23 Apr 2020 09:49:40 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:39 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86,ftrace: Shrink ftrace_regs_caller() by one byte
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115118.867411350@infradead.org>
References: <20200416115118.867411350@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817989.28353.12633424393537109680.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9f2dfd61dd022d4559d42a832fb03e76aad36c5f
Gitweb:        https://git.kernel.org/tip/9f2dfd61dd022d4559d42a832fb03e76aad36c5f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Apr 2020 16:51:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:50 +02:00

x86,ftrace: Shrink ftrace_regs_caller() by one byte

'Optimize' ftrace_regs_caller. Instead of comparing against an
immediate, the more natural way to test for zero on x86 is: 'test
%r,%r'.

  48 83 f8 00             cmp    $0x0,%rax
  74 49                   je     226 <ftrace_regs_call+0xa3>

  48 85 c0                test   %rax,%rax
  74 49                   je     225 <ftrace_regs_call+0xa2>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115118.867411350@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index be9aff2..9738ed2 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -240,8 +240,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 * See arch_ftrace_set_direct_caller().
 	 */
 	movq ORIG_RAX(%rsp), %rax
-	cmpq	$0, %rax
-	je	1f
+	testq	%rax, %rax
+	jz	1f
 
 	/* Swap the flags with orig_rax */
 	movq MCOUNT_REG_SIZE(%rsp), %rdi
