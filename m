Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E838909F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 16:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbhESOU4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 10:20:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242277AbhESOUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 10:20:55 -0400
Date:   Wed, 19 May 2021 14:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621433973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6djV3Zce+Ts+Ezz/IoL+M5ZSLpSUnc29wDr3CbJHe5I=;
        b=Wyy82PWR/bi4fdULjAE6Niha20aFO3vdeE+hsMAwzJWMl0xpCJWEZRn01vOrM1Ob8TZqxz
        FTHf/PcuaJIov3hGvsmCWsz47leT64Vp+LF8T6zDPH4yVhNnAMq9Lm0SX3iK7vyyC6RYV5
        /+XJiDWkdcs0+19rTfcqjxe9jMvumGUOuIMnFsiJUVW7y4hiWZ9Jpas6JSdMLy5DoNX94v
        FkMb1rbvATXyIZIAmmbfNqwXBY7kUlIpNNwdu4VVXZEA3/7hdEsobQrC5ykEg1T966Yybu
        PalusJG8PcjWzHIoKF3G7xCKNOP2F9sFeUigGGJu7GeBblEi1ttCGcI9uOswgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621433973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6djV3Zce+Ts+Ezz/IoL+M5ZSLpSUnc29wDr3CbJHe5I=;
        b=PLzEVDfvUTYH9IU0Ze9xywxp6e/9c1vtebSTtuk4p8fwpjGpykhdY5a0LMBHvHwF6U+mvm
        cgVYIMdrfrxDHFBQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux
 vector if available
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518200320.17239-5-chang.seok.bae@intel.com>
References: <20210518200320.17239-5-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <162143397250.29796.6163085333055861251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     bdf6c8b84a4fa726c382ef6d3518f3ae123a7ebd
Gitweb:        https://git.kernel.org/tip/bdf6c8b84a4fa726c382ef6d3518f3ae123a7ebd
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 18 May 2021 13:03:18 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 May 2021 12:38:17 +02:00

selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available

The SIGSTKSZ constant may not represent enough stack size in some
architectures as the hardware state size grows.

Use getauxval(AT_MINSIGSTKSZ) to increase the stack size.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20210518200320.17239-5-chang.seok.bae@intel.com
---
 tools/testing/selftests/sigaltstack/sas.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 8934a37..c53b070 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <assert.h>
 #include <errno.h>
+#include <sys/auxv.h>
 
 #include "../kselftest.h"
 
@@ -24,6 +25,11 @@
 #define SS_AUTODISARM  (1U << 31)
 #endif
 
+#ifndef AT_MINSIGSTKSZ
+#define AT_MINSIGSTKSZ	51
+#endif
+
+static unsigned int stack_size;
 static void *sstack, *ustack;
 static ucontext_t uc, sc;
 static const char *msg = "[OK]\tStack preserved";
@@ -47,7 +53,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 #endif
 
 	if (sp < (unsigned long)sstack ||
-			sp >= (unsigned long)sstack + SIGSTKSZ) {
+			sp >= (unsigned long)sstack + stack_size) {
 		ksft_exit_fail_msg("SP is not on sigaltstack\n");
 	}
 	/* put some data on stack. other sighandler will try to overwrite it */
@@ -108,6 +114,10 @@ int main(void)
 	stack_t stk;
 	int err;
 
+	/* Make sure more than the required minimum. */
+	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
+
 	ksft_print_header();
 	ksft_set_plan(3);
 
@@ -117,7 +127,7 @@ int main(void)
 	sigaction(SIGUSR1, &act, NULL);
 	act.sa_sigaction = my_usr2;
 	sigaction(SIGUSR2, &act, NULL);
-	sstack = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+	sstack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (sstack == MAP_FAILED) {
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
@@ -139,7 +149,7 @@ int main(void)
 	}
 
 	stk.ss_sp = sstack;
-	stk.ss_size = SIGSTKSZ;
+	stk.ss_size = stack_size;
 	stk.ss_flags = SS_ONSTACK | SS_AUTODISARM;
 	err = sigaltstack(&stk, NULL);
 	if (err) {
@@ -161,7 +171,7 @@ int main(void)
 		}
 	}
 
-	ustack = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+	ustack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (ustack == MAP_FAILED) {
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
@@ -170,7 +180,7 @@ int main(void)
 	getcontext(&uc);
 	uc.uc_link = NULL;
 	uc.uc_stack.ss_sp = ustack;
-	uc.uc_stack.ss_size = SIGSTKSZ;
+	uc.uc_stack.ss_size = stack_size;
 	makecontext(&uc, switch_fn, 0);
 	raise(SIGUSR1);
 
