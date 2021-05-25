Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49483390420
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhEYOjW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhEYOiy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 10:38:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0192C061756;
        Tue, 25 May 2021 07:37:22 -0700 (PDT)
Date:   Tue, 25 May 2021 14:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621953440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQ8D7JRD4WNdLcyNXJJAp1hpBrpb4wOPT4V/NbeIfFo=;
        b=SFNG2Eqp1oFXdiUFzDKg05DV8RAtI5e7pCDq3OknYq5v5RmhB2FQcGdmVS6AxgFVt9vKzv
        fIWL9NU3gL4OZMc367E5OjRNUaWIZVwIbtdbDkFphotKqB1q17eaSR9vJBI2Hd6d5VCms9
        9p/fu5ar132eBrXy8OSeXnYCIpFSxPJ9MncKixi4SCyes260K/rGFdeHNH67mqYexD0mhU
        Qec1AKFDQeGP4dtYD3GmeaZxCZ28u7qDnL2bqy5AkHF/l80tS3amF4G2HRV3UpJ6wczm6w
        e2aV6VtTcc6mv5efvWViFRJVyoJ0ZKWGGOzF4sY7L2J1SBy2CCUY9KtETKjHHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621953440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQ8D7JRD4WNdLcyNXJJAp1hpBrpb4wOPT4V/NbeIfFo=;
        b=oa6+TtEa0TkKtTkIOV/jQKKuBbwf3UZsBspTaE/TZL88+qFmSThuS40OrZPF3qbf3BCNFW
        tC1tAWWB9VikurCQ==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] compiler.h: Avoid using inline asm operand modifiers
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
In-Reply-To: =?utf-8?q?=3Cpatch-1=2Ethread-1a26be=2Egit-930d1b44844a=2Eyou?=
 =?utf-8?q?r-ad-here=2Ecall-01621428935-ext-2104=40work=2Ehours=3E?=
References: =?utf-8?q?=3Cpatch-1=2Ethread-1a26be=2Egit-930d1b44844a=2Eyour?=
 =?utf-8?q?-ad-here=2Ecall-01621428935-ext-2104=40work=2Ehours=3E?=
MIME-Version: 1.0
Message-ID: <162195343940.29796.16205009223037156239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f1069a8756b9e9f6c055e709740d2d66650f0fb0
Gitweb:        https://git.kernel.org/tip/f1069a8756b9e9f6c055e709740d2d66650f0fb0
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Wed, 19 May 2021 15:03:08 +02:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 19 May 2021 15:30:58 -05:00

compiler.h: Avoid using inline asm operand modifiers

The expansion of annotate_reachable/annotate_unreachable on s390 will
result in a compiler error if the __COUNTER__ value is high enough.
For example with "i" (154) the "%c0" operand of annotate_reachable
will be expanded to -102:

        -102:
        .pushsection .discard.reachable
        .long -102b - .
        .popsection

This is a quirk of the gcc backend for s390, it interprets the %c0
as a signed byte value. Avoid using operand modifiers in this case
by simply converting __COUNTER__ to string, with the same result,
but in an arch assembler independent way.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/patch-1.thread-1a26be.git-930d1b44844a.your-ad-here.call-01621428935-ext-2104@work.hours
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/compiler.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index df5b405..7704790 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -115,18 +115,24 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * The __COUNTER__ based labels are a hack to make each instance of the macros
  * unique, to convince GCC not to merge duplicate inline asm statements.
  */
-#define annotate_reachable() ({						\
-	asm volatile("%c0:\n\t"						\
+#define __stringify_label(n) #n
+
+#define __annotate_reachable(c) ({					\
+	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.reachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify_label(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
-#define annotate_unreachable() ({					\
-	asm volatile("%c0:\n\t"						\
+#define annotate_reachable() __annotate_reachable(__COUNTER__)
+
+#define __annotate_unreachable(c) ({					\
+	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify_label(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
+#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
+
 #define ASM_UNREACHABLE							\
 	"999:\n\t"							\
 	".pushsection .discard.unreachable\n\t"				\
