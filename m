Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBA037BE07
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhELNVB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhELNU7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:20:59 -0400
Date:   Wed, 12 May 2021 13:19:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql195vAwUQ9z7CudqS4Yjke4+g1c1VeO6x2S9B13d2s=;
        b=t+LexJJKZCKruay7J46uiUj3WTQXsBi/Q8OBpR+qh1MFTC41keCGloPDdDt7bLFM6+n0Fh
        uIL9dv02zKrjbSByMfYKNyRkMMNYwbLgo8qHAj0gw2g1m1EfB63oai73zEwJ0nKLIGGG0/
        egexdkFMXz2qtYqw4Ix6NrYyMppUiOw3j8/XGQ39oZNwYEDtqGJim+AcwnxYZ/wNgGia1x
        FI8mhVHEuPzVbDWEJKgs97Cm0vCobFPq0pxBoDIIuEGjhFD3+aoF0Mq2rc1dIltBnHWM0b
        vvt/IqRU4DcAfLdXGJlZ4FdwO7Hyi1vnmx7JKwqm5sUjgfG+2QecDvyerNvNIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql195vAwUQ9z7CudqS4Yjke4+g1c1VeO6x2S9B13d2s=;
        b=dlTeFYrqby3R64fabOqyaeto9nJF6BQ2ewLctYgMqpb6s/sH4yS1pCnHDxSc8UFii+HS7G
        d30poZd6mC7q28Dg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label, x86: Add variable length patching support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.846870383@infradead.org>
References: <20210506194157.846870383@infradead.org>
MIME-Version: 1.0
Message-ID: <162082559022.29796.1146262222389656359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     001951bea748d3f675e1778f42b17290a8c551bf
Gitweb:        https://git.kernel.org/tip/001951bea748d3f675e1778f42b17290a8c551bf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:33:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

jump_label, x86: Add variable length patching support

This allows the patching to to emit 2 byte JMP/NOP instruction in
addition to the 5 byte JMP/NOP we already did. This allows for more
compact code.

This code is not yet used, as we don't emit shorter code at compile
time yet.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.846870383@infradead.org
---
 arch/x86/kernel/jump_label.c | 53 +++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index a29eecc..190d810 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -23,44 +23,63 @@ int arch_jump_entry_size(struct jump_entry *entry)
 	return JMP32_INSN_SIZE;
 }
 
-static const void *
-__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
+struct jump_label_patch {
+	const void *code;
+	int size;
+};
+
+static struct jump_label_patch
+__jump_label_patch(struct jump_entry *entry, enum jump_label_type type)
 {
-	const void *expect, *code;
+	const void *expect, *code, *nop;
 	const void *addr, *dest;
+	int size;
 
 	addr = (void *)jump_entry_code(entry);
 	dest = (void *)jump_entry_target(entry);
 
-	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+	size = arch_jump_entry_size(entry);
+	switch (size) {
+	case JMP8_INSN_SIZE:
+		code = text_gen_insn(JMP8_INSN_OPCODE, addr, dest);
+		nop = x86_nops[size];
+		break;
+
+	case JMP32_INSN_SIZE:
+		code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+		nop = x86_nops[size];
+		break;
+
+	default: BUG();
+	}
 
 	if (type == JUMP_LABEL_JMP)
-		expect = x86_nops[5];
+		expect = nop;
 	else
 		expect = code;
 
-	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE)) {
+	if (memcmp(addr, expect, size)) {
 		/*
 		 * The location is not an op that we were expecting.
 		 * Something went wrong. Crash the box, as something could be
 		 * corrupting the kernel.
 		 */
-		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) type:%d\n",
-				addr, addr, addr, expect, type);
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) size:%d type:%d\n",
+				addr, addr, addr, expect, size, type);
 		BUG();
 	}
 
 	if (type == JUMP_LABEL_NOP)
-		code = x86_nops[5];
+		code = nop;
 
-	return code;
+	return (struct jump_label_patch){.code = code, .size = size};
 }
 
 static inline void __jump_label_transform(struct jump_entry *entry,
 					  enum jump_label_type type,
 					  int init)
 {
-	const void *opcode = __jump_label_set_jump_code(entry, type);
+	const struct jump_label_patch jlp = __jump_label_patch(entry, type);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -74,12 +93,11 @@ static inline void __jump_label_transform(struct jump_entry *entry,
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), opcode,
-				JUMP_LABEL_NOP_SIZE);
+		text_poke_early((void *)jump_entry_code(entry), jlp.code, jlp.size);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_bp((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 }
 
 static void __ref jump_label_transform(struct jump_entry *entry,
@@ -100,7 +118,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	const void *opcode;
+	struct jump_label_patch jlp;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -111,9 +129,8 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 	}
 
 	mutex_lock(&text_mutex);
-	opcode = __jump_label_set_jump_code(entry, type);
-	text_poke_queue((void *)jump_entry_code(entry),
-			opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	jlp = __jump_label_patch(entry, type);
+	text_poke_queue((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 	mutex_unlock(&text_mutex);
 	return true;
 }
