Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38237BDFB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhELNU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhELNU6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:20:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C888C06174A;
        Wed, 12 May 2021 06:19:50 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXugBDZF/+fo3g/7REWMwsLvMZecGB0QKmJD6/mzD/c=;
        b=cQfRyeuyjqc7zf7uX4ZRg+mPgRgC0EIYDPkSpCO8sJOeO9efG2H7Rj5e+J3Np7HE8xNWAw
        Xz0AQb8jMk2ye5kHGqwLSxyXQn6BND8c5ep3wrBv9/XM3eVmTG57hXif0pryaq1e31mfun
        EPUCrjebJdzDM2/dJP8IRv8q3Jmw8hM3KYS3Vc+lemqb2H0yHWHZeLbZv2h38y56m+FKHh
        EyYgEXxHXe0WjJyGUwLtEKbgOg4CRaFfKqfT1Z3QaiHUxfDdv8c5uoHHBL3N0To6gDJCIn
        4LhKTCzq6CLrLP++Ad1+IX37+b6LuAKZCybUqjpLdQ6uv1NJIWlwncfAcpCsMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXugBDZF/+fo3g/7REWMwsLvMZecGB0QKmJD6/mzD/c=;
        b=5a+jnzspC0GKLUEzspqaS9tevxlAStcQmAkFtvdCElXxxFfnM9wJ7HDtLCG3CLaeILk8mT
        DpwwyPhGG6olEIBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label, x86: Allow short NOPs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194158.216763632@infradead.org>
References: <20210506194158.216763632@infradead.org>
MIME-Version: 1.0
Message-ID: <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ab3257042c26d0cd44793c741e2f89bf38b21fe8
Gitweb:        https://git.kernel.org/tip/ab3257042c26d0cd44793c741e2f89bf38b21fe8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:34:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:56 +02:00

jump_label, x86: Allow short NOPs

Now that objtool is able to rewrite jump_label instructions, have the
compiler emit a JMP, such that it can decide on the optimal encoding,
and set jump_entry::key bit1 to indicate that objtool should rewrite
the instruction to a matching NOP.

For x86_64-allyesconfig this gives:

  jl\     NOP     JMP
  short:  22997   124
  long:   30874   90

IOW, we save (22997+124) * 3 bytes of kernel text in hotpaths.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194158.216763632@infradead.org
---
 arch/x86/include/asm/jump_label.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index ef819e3..0449b12 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,6 +20,22 @@
 	_ASM_PTR "%c0 + %c1 - .\n\t"			\
 	".popsection \n\t"
 
+#ifdef CONFIG_STACK_VALIDATION
+
+static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+{
+	asm_volatile_goto("1:"
+		"jmp %l[l_yes] # objtool NOPs this \n\t"
+		JUMP_TABLE_ENTRY
+		: :  "i" (key), "i" (2 | branch) : : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+#else
+
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
@@ -32,6 +48,8 @@ l_yes:
 	return true;
 }
 
+#endif /* STACK_VALIDATION */
+
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
