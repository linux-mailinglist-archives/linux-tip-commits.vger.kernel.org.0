Return-Path: <linux-tip-commits+bounces-4872-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C35A858FA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560D47AF04A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E032E339B;
	Fri, 11 Apr 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZojKGBHB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="93oLAF63"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730423422C;
	Fri, 11 Apr 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365737; cv=none; b=X3LtUl0hU6mf2xQpGg9Y2O5Ed1SHni4D4GkvH88Sj70AVf99xtk0IZmyLz2kQPLt3QeswIr9g6pAZsNWHFc7RYISffJd09tMCFGOtzCjF7TMTwvCjVvnv9Ji8sq0crPJPYWY/nADM1iBWifS+W58N3ltRhCX5FfVfFuxb73+rNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365737; c=relaxed/simple;
	bh=0eaQoZ/L9ntbo1iuoYszYaYF3d/ZCoQs3OGmnjf2G2A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=glfC3j+LHJFbeEltCTkW/YaNmY7K4x84zfGwo4OcbiZqQ57hnr16r7XPamEi9d4yURutzcrl5V4zQRYqKqcpFNgiYcQhdSMKXdVGCMMrvqD9PHRqtY34TOoR2WWp3FNKIptOBipfxKyS18vS1/cL+Gt1v8KVQGnNGru7kK7jXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZojKGBHB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=93oLAF63; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvMPDeMb0f45+srL6GuYm3QampIzxhmVFWfjfprl6/U=;
	b=ZojKGBHBkmaICrb66OnsbVIYkUGxovzQ3LixzSg6qqph2YJqCLPZhpbpTekfEgyD8F0zfC
	okyVXdhuuft9t5FUVfBBe+zWwpDEB+FueLBb+rSTvGcDiOuFMyit13TKbrfBzkG+ig8pb2
	FCayGuzgSuWwcsXzsF0UNq6Tr6G09MqmPjVpqKuDnB5I0GlSe4x5wG+myRxi/+YkSWjosQ
	F6UYl1bEDQRKSSqsyeNFkaGheCRj4MIxZgm5P9zl2mCPMGDJzs1/sw3JOaC+6AwySsw+vT
	qGsBwx8GhM5nsHQCwXwTOdT5hAqPyEcftPETpIXKbjMbb9BI+YbKMLj9c8IK4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvMPDeMb0f45+srL6GuYm3QampIzxhmVFWfjfprl6/U=;
	b=93oLAF63GOiLZpdvWNrzDvfEZL/3YOhEkl1/VblfbVQyXGYPUDCQAOvkxUB1kF+msLhbbW
	VuMhxpvANYHl9fDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'text_poke_finish()'
 to 'smp_text_poke_batch_finish()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-16-mingo@kernel.org>
References: <20250411054105.2341982-16-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573236.31282.12831275782524253754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     e8d7b8c2bbcd5e50c93902af4ba53029fc0497fc
Gitweb:        https://git.kernel.org/tip/e8d7b8c2bbcd5e50c93902af4ba53029fc0497fc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'text_poke_finish()' to 'smp_text_poke_batch_finish()'

This name is actively confusing as well, because the simple text_poke*()
APIs use MM-switching based code patching, while text_poke_finish()
is part of the INT3 based text_poke_int3_*() machinery that is an
additional layer of functionality on top of regular text_poke*() functionality.

Rename it to smp_text_poke_batch_finish() to make it clear which layer
it belongs to.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-16-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 2 +-
 arch/x86/kernel/ftrace.c             | 4 ++--
 arch/x86/kernel/jump_label.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 7e35273..f27d290 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -42,7 +42,7 @@ extern int smp_text_poke_int3_handler(struct pt_regs *regs);
 extern void smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate);
 
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
-extern void text_poke_finish(void);
+extern void smp_text_poke_batch_finish(void);
 
 #define INT3_INSN_SIZE		1
 #define INT3_INSN_OPCODE	0xCC
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6c8bf2f..0589c05 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2866,7 +2866,7 @@ static void smp_text_poke_batch_flush(void *addr)
 	}
 }
 
-void text_poke_finish(void)
+void smp_text_poke_batch_finish(void)
 {
 	smp_text_poke_batch_flush(NULL);
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7175a04..c35a928 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -58,7 +58,7 @@ void ftrace_arch_code_modify_post_process(void)
 	 * module load, and we need to finish the text_poke_queue()
 	 * that they do, here.
 	 */
-	text_poke_finish();
+	smp_text_poke_batch_finish();
 	ftrace_poke_late = 0;
 	mutex_unlock(&text_mutex);
 }
@@ -250,7 +250,7 @@ void ftrace_replace_code(int enable)
 		text_poke_queue((void *)rec->ip, new, MCOUNT_INSN_SIZE, NULL);
 		ftrace_update_record(rec, enable);
 	}
-	text_poke_finish();
+	smp_text_poke_batch_finish();
 }
 
 void arch_ftrace_update_code(int command)
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 166e120..28be6eb 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -143,6 +143,6 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 void arch_jump_label_transform_apply(void)
 {
 	mutex_lock(&text_mutex);
-	text_poke_finish();
+	smp_text_poke_batch_finish();
 	mutex_unlock(&text_mutex);
 }

