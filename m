Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210439041F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 16:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhEYOjW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 10:39:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhEYOiv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 10:38:51 -0400
Date:   Tue, 25 May 2021 14:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621953439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpRt3K/PyklULPFcXKegeUs/qCi0kTmqaMugOnux9Nw=;
        b=0gWylSQBpTB3hOXtWq2sqKTHeOXvpykhfKIrUCg/7CrtyVSDFtn6YF2GnZC8wvwTjOZ+GG
        hx5wKv6shaf+7vKPzb/xzFMXoRznaTfEwI2J6Bm5c8G/Z6/ftnN98tiYN4eo8I7VC97A4o
        a58ktxq8o7Sq8vfOPeN0fk4a8rqObsWQY1P2TTjo0hsxLCTyXX5DOA/Ft0lQnNgMu96va1
        bxp3mQe2bTL5HQMiTAjMf6SXIXO/hafb/yTKl8dP5O37VPwK404O9tcXnEFx7GmPZoqB7P
        5ZfmOlKRByIbMOZCvNLQOQeOkkkPAkSDXn6e7vJDhEJe16iBoD9Hom1OqNv//A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621953439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpRt3K/PyklULPFcXKegeUs/qCi0kTmqaMugOnux9Nw=;
        b=t0JoOq8Qcs6NA+TxySy9Hk39/vElEOtoISWXxl9VfQHC3PFwZYxbFZJr6dd0/DVorSxv3Y
        9A9HvmY4kiYREoAg==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] instrumentation.h: Avoid using inline asm operand
 modifiers
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
In-Reply-To: =?utf-8?q?=3Cpatch-2=2Ethread-1a26be=2Egit-1a26be80cb18=2Eyou?=
 =?utf-8?q?r-ad-here=2Ecall-01621428935-ext-2104=40work=2Ehours=3E?=
References: =?utf-8?q?=3Cpatch-2=2Ethread-1a26be=2Egit-1a26be80cb18=2Eyour?=
 =?utf-8?q?-ad-here=2Ecall-01621428935-ext-2104=40work=2Ehours=3E?=
MIME-Version: 1.0
Message-ID: <162195343878.29796.1653549604931830243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c199f64ff93c48a45add92eee4456ffcabfc838e
Gitweb:        https://git.kernel.org/tip/c199f64ff93c48a45add92eee4456ffcabfc838e
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Wed, 19 May 2021 15:03:13 +02:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 19 May 2021 15:30:59 -05:00

instrumentation.h: Avoid using inline asm operand modifiers

The expansion of instrumentation_begin/instrumentation_end on s390 will
result in a compiler error if the __COUNTER__ value is high enough.
For example with "i" (154) the "%c0" operand of annotate_reachable
will be expanded to -102:

        -102:
        .pushsection .discard.instr_begin
        .long -102b - .
        .popsection

This is a quirk of the gcc backend for s390, it interprets the %c0
as a signed byte value. Avoid using operand modifiers in this case
by simply converting __COUNTER__ to string, with the same result,
but in an arch assembler independent way.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/patch-2.thread-1a26be.git-1a26be80cb18.your-ad-here.call-01621428935-ext-2104@work.hours
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/instrumentation.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 93e2ad6..fa2cd8c 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -4,13 +4,16 @@
 
 #if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
 
+#include <linux/stringify.h>
+
 /* Begin/end of an instrumentation safe region */
-#define instrumentation_begin() ({					\
-	asm volatile("%c0: nop\n\t"						\
+#define __instrumentation_begin(c) ({					\
+	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
+#define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
 /*
  * Because instrumentation_{begin,end}() can nest, objtool validation considers
@@ -43,12 +46,13 @@
  * To avoid this, have _end() be a NOP instruction, this ensures it will be
  * part of the condition block and does not escape.
  */
-#define instrumentation_end() ({					\
-	asm volatile("%c0: nop\n\t"					\
+#define __instrumentation_end(c) ({					\
+	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
+#define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else
 # define instrumentation_begin()	do { } while(0)
 # define instrumentation_end()		do { } while(0)
