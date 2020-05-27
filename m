Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E451E46E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 May 2020 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbgE0PEj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 May 2020 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbgE0PEd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 May 2020 11:04:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D12C03E97D;
        Wed, 27 May 2020 08:04:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdxbX-0006Lv-FE; Wed, 27 May 2020 17:04:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 22F2C1C00ED;
        Wed, 27 May 2020 17:04:27 +0200 (CEST)
Date:   Wed, 27 May 2020 15:04:27 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] samples/ftrace: Fix asm function ELF annotations
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159059186703.17951.17698663929899663001.tip-bot2@tip-bot2>
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

Commit-ID:     9d907f1ae80b8a67d5397e26912b9d56d0b70a02
Gitweb:        https://git.kernel.org/tip/9d907f1ae80b8a67d5397e26912b9d56d0b70a02
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 24 Apr 2020 15:40:43 -05:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 20 May 2020 08:30:43 -05:00

samples/ftrace: Fix asm function ELF annotations

Enable objtool coverage for the sample ftrace modules by adding ELF
annotations to the asm trampoline functions.

  samples/ftrace/ftrace-direct.o: warning: objtool: .text+0x0: unreachable instruction
  samples/ftrace/ftrace-direct-modify.o: warning: objtool: .text+0x0: unreachable instruction
  samples/ftrace/ftrace-direct-too.o: warning: objtool: .text+0x0: unreachable instruction

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 samples/ftrace/ftrace-direct-modify.c | 4 ++++
 samples/ftrace/ftrace-direct-too.c    | 2 ++
 samples/ftrace/ftrace-direct.c        | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index e04229d..c13a5bc 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -20,18 +20,22 @@ static unsigned long my_ip = (unsigned long)schedule;
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
 "   my_tramp1:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func1\n"
 "	leave\n"
+"	.size		my_tramp1, .-my_tramp1\n"
 "	ret\n"
+"	.type		my_tramp2, @function\n"
 "   my_tramp2:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func2\n"
 "	leave\n"
 "	ret\n"
+"	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
 );
 
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 27efa5f..d5c5022 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -15,6 +15,7 @@ extern void my_tramp(void *);
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
@@ -27,6 +28,7 @@ asm (
 "	popq %rdi\n"
 "	leave\n"
 "	ret\n"
+"	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
 
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index a2e3063..63ca06d 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -13,6 +13,7 @@ extern void my_tramp(void *);
 
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
@@ -21,6 +22,7 @@ asm (
 "	popq %rdi\n"
 "	leave\n"
 "	ret\n"
+"	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
 
