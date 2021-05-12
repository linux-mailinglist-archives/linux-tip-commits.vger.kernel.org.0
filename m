Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8C37BE00
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhELNVA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhELNU7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:20:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6DFC061574;
        Wed, 12 May 2021 06:19:51 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPmPm0uu7GanpH/Ns3/IQxIGNwyPA/MUcYaqjFRWR0E=;
        b=XcFtmwOll+fybpR0fPt8nrZR+cgC6cw/7jk+WVRgSLanBPJNC+LmgrtWWA/H7otuDOQZHq
        MgQ211OlQFiCcivG3rt/b6Jdfq3LAsRnTKKXDE4E+wtc2IlDd7FFsI6nEJepiF5/rWENWj
        7lGsFm+weIvvK0ym/r2df0eC94fKqOnHGcTrQDgN4mRIeEhcEoAeywnV1SBnYyjERPXv8v
        ZhQbB4aWU81OqhyVT6v6GnwY8TJz1muNR3BRo/EwG35L8k1rMMYvUl1MMTO6rARK5yvZlK
        KIAt9F1GzXBrGKods5tugPUNDBGbyff9JaLprlbs4u6tFtA44YHMusH4kIQ4PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPmPm0uu7GanpH/Ns3/IQxIGNwyPA/MUcYaqjFRWR0E=;
        b=pq4qCzXWurPPe1Q0ykQCBvuK3dHSf4497IlZc5x3cT4eOFs332E7OWHvAGKHI+z+iNajRI
        PhZvcevuFdVk6BDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label, x86: Emit short JMP
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.967034497@infradead.org>
References: <20210506194157.967034497@infradead.org>
MIME-Version: 1.0
Message-ID: <162082558920.29796.12496045257263987111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e7bf1ba97afdde75b0ef43e4bdb718bf843613f1
Gitweb:        https://git.kernel.org/tip/e7bf1ba97afdde75b0ef43e4bdb718bf843613f1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:34:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

jump_label, x86: Emit short JMP

Now that we can patch short JMP/NOP, allow the compiler/assembler to
emit short JMP instructions.

There is no way to have the assembler emit short NOPs based on the
potential displacement, so leave those long for now.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.967034497@infradead.org
---
 arch/x86/include/asm/jump_label.h | 3 +--
 arch/x86/kernel/jump_label.c      | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index d85802a..ef819e3 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -35,8 +35,7 @@ l_yes:
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9 \n\t"
-		".long %l[l_yes] - (. + 4) \n\t"
+		"jmp %l[l_yes]\n\t"
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 190d810..a762dc1 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -15,12 +15,18 @@
 #include <asm/kprobes.h>
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
+#include <asm/insn.h>
 
 #define JUMP_LABEL_NOP_SIZE	JMP32_INSN_SIZE
 
 int arch_jump_entry_size(struct jump_entry *entry)
 {
-	return JMP32_INSN_SIZE;
+	struct insn insn = {};
+
+	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
+	BUG_ON(insn.length != 2 && insn.length != 5);
+
+	return insn.length;
 }
 
 struct jump_label_patch {
