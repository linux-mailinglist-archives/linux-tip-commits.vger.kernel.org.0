Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE99C37BE08
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhELNVD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhELNVB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:21:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76AC061574;
        Wed, 12 May 2021 06:19:53 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyZwQtMj25e3Ip9dONERHqR/ercNYWc23EHEsAUxHbQ=;
        b=dTf+03kQ9cM/5uMorlkYxJhFOZeSJKSCygOkVe1FPX7Elp8N8Qk5HVr0coqDo2t7uTmQl0
        aKH7FkCzW6WRX2QzAvFMq6FiUGsBHyEBv7TrU2zR8MWGAB2E/Leu5dfBRtRRdsBfGJ9QP/
        hwjO7lApEE2OyZqIONB4fwi38FI1dgmAQNaLqBRe5TdCkCrYAtK7zN1u2rGEdEAKpfqaAh
        KZdc/PTMvTHtRuziIXCdnbeakeW1eNBciVzHa+nzAaoSHjEC9LCEPfVfR/q7a/xEMHfYc7
        5mLhgnwE/XuN27kS+jhtsi1lxI+mkOGDwoDlU4Bp37xVqIcpEb4pOa74c44K0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyZwQtMj25e3Ip9dONERHqR/ercNYWc23EHEsAUxHbQ=;
        b=pS2l9Flz8a1bDfVfwsPfKbMivXkVJ7Gs6mI8d7H3hfH1UuMUotJoXhh5+2Lzyo37wgVY7Z
        ZFawSxVFv8I77sDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label, x86: Factor out the __jump_table generation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.663132781@infradead.org>
References: <20210506194157.663132781@infradead.org>
MIME-Version: 1.0
Message-ID: <162082559169.29796.12072360818242979731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e1aa35c4c4bc71e44dabc9d7d167b807edd7b439
Gitweb:        https://git.kernel.org/tip/e1aa35c4c4bc71e44dabc9d7d167b807edd7b439
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:33:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

jump_label, x86: Factor out the __jump_table generation

Both arch_static_branch() and arch_static_branch_jump() have the same
blurb to generate the __jump_table entry, share it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.663132781@infradead.org
---
 arch/x86/include/asm/jump_label.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 01de21e..dfdc2b1 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -14,15 +14,19 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
+#define JUMP_TABLE_ENTRY				\
+	".pushsection __jump_table,  \"aw\" \n\t"	\
+	_ASM_ALIGN "\n\t"				\
+	".long 1b - . \n\t"				\
+	".long %l[l_yes] - . \n\t"			\
+	_ASM_PTR "%c0 + %c1 - .\n\t"			\
+	".popsection \n\t"
+
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(BYTES_NOP5) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -33,13 +37,9 @@ l_yes:
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		".byte 0xe9 \n\t"
+		".long %l[l_yes] - (. + 4) \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
