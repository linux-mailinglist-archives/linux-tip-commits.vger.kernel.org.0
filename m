Return-Path: <linux-tip-commits+bounces-4849-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E06A858CF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212A21BC2229
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC22BE7BB;
	Fri, 11 Apr 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plug6y8L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ytd5xQpE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256C2BD5A7;
	Fri, 11 Apr 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365715; cv=none; b=F5PRM7f6y5ycfCSlimc0TzVTDoAR5vJfz5/g4Ciw2x9YP/cw8Hvily5ZqfK7+3nUNc9enOsO7GQDTTZgPpikYi/bR1cj/tGO+ZUpZHF3r2DJ5i7Y6AtPzidyNczoY9Yt+KhSC2NOJ8gsKCiNJnjWtbEgpR4F3Nb1WPCclIaGFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365715; c=relaxed/simple;
	bh=AE5oqfs6gQDw9hQ1h+A8HeQs/GCwbhIYX9vIH0b25CE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IAKjuzFPdW67OBnZVkoBgwaj5birQLLwGOdPClwkcUg4ZHfzElXdo9FWoNT0w7hFR6XmkMLGYYDzhjPaGAS3+QMedUgCwDrqSTBY4nG0gO8/kdAieuu2PSult9wdKRIU32GmqiS77DVcxNTVZLD82CbJhsF26dJ/gbATSQMQQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plug6y8L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ytd5xQpE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGiG2oa4kQoODsuBYJTeJxBvuHYdEaKNkbLXUoU1Bd8=;
	b=plug6y8LmS94T72EnWnFcE7IBMM4w62msTvmDBqC3mIE5ugmP/dnH77Ef9jS03DgtCqGbS
	Ppl20pwf2zAhJCFa0VwNkRj5bMflzHnAxVKSh6kB9p5ERBzQuU07IrDeqHeL2xZ7fm7fNZ
	erBVF9M42Ri89w4FvL75jVEzaWd7P0QNKFuhKIGTCYbMjLkLvEEolWpYxl3afKovF3q7Bb
	z0qXE1LkNBsi+RjtQ/44b+173rZHvNPtvyuhMixTt10c+wyM2ECWxDDCgVYxkmJ8xjO2DK
	IQkN9MRiz3ryYil35Cop1XKduWFjqjQK5rxep/++B+eOYWpN0sIS+CRp0al8lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGiG2oa4kQoODsuBYJTeJxBvuHYdEaKNkbLXUoU1Bd8=;
	b=Ytd5xQpERsXsbsR0yLKLvGw72c3b8wHvRTYV1bhXcTNzn7nvYUVJjPDqf6V0VxA2DznLyY
	yJUYVGw9AUKrZcBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'text_poke_sync()'
 to 'smp_text_poke_sync_each_cpu()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-41-mingo@kernel.org>
References: <20250411054105.2341982-41-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571019.31282.16039207648953705846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     6e4955a9d73ebdc8496e6bff7f6d2bf83c01959f
Gitweb:        https://git.kernel.org/tip/6e4955a9d73ebdc8496e6bff7f6d2bf83c01959f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Rename 'text_poke_sync()' to 'smp_text_poke_sync_each_cpu()'

Unlike sync_core(), text_poke_sync() is a very heavy operation, as
it sends an IPI to every online CPU in the system and waits for
completion.

Reflect this in the name.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-41-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h |  2 +-
 arch/x86/kernel/alternative.c        | 12 ++++++------
 arch/x86/kernel/kprobes/core.c       |  4 ++--
 arch/x86/kernel/kprobes/opt.c        |  4 ++--
 arch/x86/kernel/module.c             |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index f3c9b70..d9dbbe9 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -32,7 +32,7 @@ extern void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u
  * an inconsistent instruction while you patch.
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
-extern void text_poke_sync(void);
+extern void smp_text_poke_sync_each_cpu(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
 #define text_poke_copy text_poke_copy
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 556a82f..e4c51d8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2445,7 +2445,7 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
-void text_poke_sync(void)
+void smp_text_poke_sync_each_cpu(void)
 {
 	on_each_cpu(do_sync_core, NULL, 1);
 }
@@ -2469,8 +2469,8 @@ struct smp_text_poke_loc {
 #define TP_ARRAY_NR_ENTRIES_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
 
 static struct smp_text_poke_array {
-	int nr_entries;
 	struct smp_text_poke_loc vec[TP_ARRAY_NR_ENTRIES_MAX];
+	int nr_entries;
 } text_poke_array;
 
 static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
@@ -2649,7 +2649,7 @@ static void smp_text_poke_batch_process(void)
 		text_poke(text_poke_addr(&text_poke_array.vec[i]), &int3, INT3_INSN_SIZE);
 	}
 
-	text_poke_sync();
+	smp_text_poke_sync_each_cpu();
 
 	/*
 	 * Second step: update all but the first byte of the patched range.
@@ -2711,7 +2711,7 @@ static void smp_text_poke_batch_process(void)
 		 * not necessary and we'd be safe even without it. But
 		 * better safe than sorry (plus there's not only Intel).
 		 */
-		text_poke_sync();
+		smp_text_poke_sync_each_cpu();
 	}
 
 	/*
@@ -2732,13 +2732,13 @@ static void smp_text_poke_batch_process(void)
 	}
 
 	if (do_sync)
-		text_poke_sync();
+		smp_text_poke_sync_each_cpu();
 
 	/*
 	 * Remove and wait for refs to be zero.
 	 *
 	 * Notably, if after step-3 above the INT3 got removed, then the
-	 * text_poke_sync() will have serialized against any running INT3
+	 * smp_text_poke_sync_each_cpu() will have serialized against any running INT3
 	 * handlers and the below spin-wait will not happen.
 	 *
 	 * IOW. unless the replacement instruction is INT3, this case goes
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 09608fd..47cb8eb 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -808,7 +808,7 @@ void arch_arm_kprobe(struct kprobe *p)
 	u8 int3 = INT3_INSN_OPCODE;
 
 	text_poke(p->addr, &int3, 1);
-	text_poke_sync();
+	smp_text_poke_sync_each_cpu();
 	perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
 }
 
@@ -818,7 +818,7 @@ void arch_disarm_kprobe(struct kprobe *p)
 
 	perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
 	text_poke(p->addr, &p->opcode, 1);
-	text_poke_sync();
+	smp_text_poke_sync_each_cpu();
 }
 
 void arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 9307a40..0aabd4c 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -513,11 +513,11 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 	       JMP32_INSN_SIZE - INT3_INSN_SIZE);
 
 	text_poke(addr, new, INT3_INSN_SIZE);
-	text_poke_sync();
+	smp_text_poke_sync_each_cpu();
 	text_poke(addr + INT3_INSN_SIZE,
 		  new + INT3_INSN_SIZE,
 		  JMP32_INSN_SIZE - INT3_INSN_SIZE);
-	text_poke_sync();
+	smp_text_poke_sync_each_cpu();
 
 	perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN_SIZE);
 }
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index a7998f3..231d632 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -206,7 +206,7 @@ static int write_relocate_add(Elf64_Shdr *sechdrs,
 				   write, apply);
 
 	if (!early) {
-		text_poke_sync();
+		smp_text_poke_sync_each_cpu();
 		mutex_unlock(&text_mutex);
 	}
 

