Return-Path: <linux-tip-commits+bounces-4871-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD07A858F7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DA27AB19C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536723424A;
	Fri, 11 Apr 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysBCtiNd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlC68f+A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCF234238;
	Fri, 11 Apr 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365736; cv=none; b=kOP1bSfGIn4/d9ZXqX+ifwOZjmp+ifcOMyR9ZQuG6LvUOGg4uOl+bZtFZ0k/aqosPKoDi08x2HbP8zNxjuBWO+DCCXxmvYTLwfD7pDS0Mb81MHLHP+Z33NL9gC0ZU4f2j726ZCAmQyyWb0j4iMuAZFNqIMlz/BMFTJacGEEkpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365736; c=relaxed/simple;
	bh=OklVtc6mC0hnHA5yOcIJTtSoMG0Ki5G42nR6YBMu6fg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LrvPeO+gqq9PVg8ylv+ACvENlRP73iIZERJGzIcOoOduvBq86lWYNHMZ5LqSCpWjG80E+W8j4jb+xhtcRHitXETbqwVm4ifIoWC9194Py2eky/aefxNhtSmWUGK6yblsiP/Zfd2m81aH4XIhVpxrB3Ub6CIgSPEAvGtyoZkP6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysBCtiNd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlC68f+A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQtmQC5YgOcWsuYz2RZ3vn+PAnkr4jtEXQhUMF/EKY4=;
	b=ysBCtiNdw7NTMdyvWsRtOPor4RA81rqEh/bM/uMV4dmmwj9oLXiY/TXwC11Mfn1xEh2ZWG
	upihTOrNgUwZt/8bFGrTNpU9fqfZ4xDRrBhzCn0DNFxUu5RTtUMvVDJkuxROvbqoxJSA3+
	EGuRN0mDiHVxnaoMsFBGzdjuC6SySAOAYGCkhcDCAPOrd5x3AF45/ybmrOQpLf946H93rB
	7KdJw1+gbbleIDkauuYblgdZMTdU+F+8M4H1TDdmzWcnz8mitVAI8neXn3vrQ+N4+8dODP
	p2tA+PE0n0nt5bPVgFsGbNo8ZDoZyNbWhD40DXYCIRfkC2u6UValFlOfE+WFEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQtmQC5YgOcWsuYz2RZ3vn+PAnkr4jtEXQhUMF/EKY4=;
	b=NlC68f+A/H+bXLIMVr2HE07mZAbEVI8tInamx2X3VnV33pdickDD8ObnHqAPOgJeZpHmAq
	XzkDDRQbwVrGgNDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'text_poke_queue()'
 to 'smp_text_poke_batch_add()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-17-mingo@kernel.org>
References: <20250411054105.2341982-17-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573167.31282.657530117691882550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     732c7c33a0c17f68393497766445cbd2878ee95e
Gitweb:        https://git.kernel.org/tip/732c7c33a0c17f68393497766445cbd2878ee95e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'text_poke_queue()' to 'smp_text_poke_batch_add()'

This name is actively confusing as well, because the simple text_poke*()
APIs use MM-switching based code patching, while text_poke_queue()
is part of the INT3 based text_poke_int3_*() machinery that is an
additional layer of functionality on top of regular text_poke*() functionality.

Rename it to smp_text_poke_batch_add() to make it clear which layer
it belongs to.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-17-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 2 +-
 arch/x86/kernel/ftrace.c             | 6 +++---
 arch/x86/kernel/jump_label.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index f27d290..f3c9b70 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -41,7 +41,7 @@ extern void *text_poke_set(void *addr, int c, size_t len);
 extern int smp_text_poke_int3_handler(struct pt_regs *regs);
 extern void smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate);
 
-extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
+extern void smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void smp_text_poke_batch_finish(void);
 
 #define INT3_INSN_SIZE		1
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0589c05..6865296 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2871,7 +2871,7 @@ void smp_text_poke_batch_finish(void)
 	smp_text_poke_batch_flush(NULL);
 }
 
-void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct text_poke_loc *tp;
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index c35a928..0853ba3 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -55,7 +55,7 @@ void ftrace_arch_code_modify_post_process(void)
 {
 	/*
 	 * ftrace_make_{call,nop}() may be called during
-	 * module load, and we need to finish the text_poke_queue()
+	 * module load, and we need to finish the smp_text_poke_batch_add()
 	 * that they do, here.
 	 */
 	smp_text_poke_batch_finish();
@@ -119,7 +119,7 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 
 	/* replace the text with the new text */
 	if (ftrace_poke_late)
-		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
+		smp_text_poke_batch_add((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
 	else
 		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	return 0;
@@ -247,7 +247,7 @@ void ftrace_replace_code(int enable)
 			break;
 		}
 
-		text_poke_queue((void *)rec->ip, new, MCOUNT_INSN_SIZE, NULL);
+		smp_text_poke_batch_add((void *)rec->ip, new, MCOUNT_INSN_SIZE, NULL);
 		ftrace_update_record(rec, enable);
 	}
 	smp_text_poke_batch_finish();
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 28be6eb..a7949a5 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -135,7 +135,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 
 	mutex_lock(&text_mutex);
 	jlp = __jump_label_patch(entry, type);
-	text_poke_queue((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
+	smp_text_poke_batch_add((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 	mutex_unlock(&text_mutex);
 	return true;
 }

