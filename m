Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4060737BE06
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhELNVD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhELNVB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:21:01 -0400
Date:   Wed, 12 May 2021 13:19:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjbvvSr8CaoahGauRnWrOwNEQwrbCO1xrzJ9zShrrYo=;
        b=h//mLFWv5DJfCrrlfU4LiI3VeeA67Xxg9X1okZmjcYWcem9QRLhJZf7KFzZkeNNLQbH0/l
        utOQ5SQwAy6IEY7T0nuaRpuNCVUWKt/yNvvlNMKDnpY8jm73NndHTwZ2mAsNX4REjIDUXc
        p12aSQK+7ubbCyQ6I+TTljdEpeqoUOGZMwZGA5LdhrjpyoQPwPXiWl2r74xYEbk/VQ/0FP
        qrK8+tMlWj4MDTpKdbb/UwxcbnH2Nj1Q7Sdbzmi1vhS5R5+QU/eGZR7ZxgdTLbjr0uqhA8
        A2yi4K5iFYut5ohHQrfQNzXPcn6oJlB4LbJ9ldoVIpNT9kKg56by7ApBxEF+DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjbvvSr8CaoahGauRnWrOwNEQwrbCO1xrzJ9zShrrYo=;
        b=ny4E3AMa9J72rkNyFv39fIEr6lvVdfTzn4giwbD9iofugDER8OeSAgRDPLfryP68JynnLO
        P1ardhNOngk0x0DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label, x86: Strip ASM jump_label support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.599716762@infradead.org>
References: <20210506194157.599716762@infradead.org>
MIME-Version: 1.0
Message-ID: <162082559216.29796.14178984509279859389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8bfafcdccb52e770695b12530b1f800fe98b16b1
Gitweb:        https://git.kernel.org/tip/8bfafcdccb52e770695b12530b1f800fe98b16b1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:33:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

jump_label, x86: Strip ASM jump_label support

In prepration for variable size jump_label support; remove all ASM
bits, which are currently unused.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.599716762@infradead.org
---
 arch/x86/include/asm/jump_label.h | 36 +------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 610a053..01de21e 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -47,42 +47,6 @@ l_yes:
 	return true;
 }
 
-#else	/* __ASSEMBLY__ */
-
-.macro STATIC_JUMP_IF_TRUE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		BYTES_NOP5
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key - .
-	.popsection
-.endm
-
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		BYTES_NOP5
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key + 1 - .
-	.popsection
-.endm
-
 #endif	/* __ASSEMBLY__ */
 
 #endif
