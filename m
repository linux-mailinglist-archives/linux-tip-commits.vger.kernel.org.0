Return-Path: <linux-tip-commits+bounces-3641-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454ADA45C44
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5D23A8E4A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A83270EBB;
	Wed, 26 Feb 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4GdHqU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9uz7+w0r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FC26F47F;
	Wed, 26 Feb 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567266; cv=none; b=g2qWe82FSTKDMuaT2Kvy1Aaa7QyuwwDYIhbfqANtt10OStlo0OgmDdkL2yQtmbtCKvv9uzcszX/JzZqYuejVKzkfn3+JZpNeJU4KGTWq9Kj1RulxqLcB09+9YiDLacsZB/lkSvZujSQqdv/XXxveV+IaVUpjUXq68lmrqJahFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567266; c=relaxed/simple;
	bh=nhtxBP/6tVIma1rJWq6lKa9z0q6XsubpsADUpz5bRMY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VCf3qUDD3L6YInoQGCgL7CT6D7Vk+kVEn4Rup62FIdqkGCJhCCDBtdh8umkaW/AcGt7eEypqGqTu7PD+xYKxyd6El4/b0xvwBUPfnh1Xua0TzOsv4ttWlsvBkNkFSLatdTHEH7tJ0SEUjU0ep/H7sKUpNayk6xPtF8UoDk5y4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4GdHqU2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9uz7+w0r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PemXpk7B4/Hyqgud74VTc2J3Z0W0sCuHVhMvsWqvwzM=;
	b=t4GdHqU2/yWmUwQ+kexLL5lKSFqN0TE5Au5d6J5WDoPhH35rjpUfgTrZgsjJXL3ZKHrylP
	YbQpr7sBKHjiuxQ82P21zGvuFnFw4yTizLJb5UvpINaL9+AB0K6qJet9URZFCKks2qsOuy
	teexrWjIP/BhvFachqKGGzd8IxPd4Zb+XT5IkAkT3ugSMBNc/fpFR8OHNt9reWZo3x0RdK
	gbQHLFm6Qe4mBJeKZFTqS312YKZgltJeEUwNeMvJo84lMIn3tXTBNdW73amkWFtUvaCnAG
	Ftes6bIzrKCb+D6ZH5cGmh0+bnh3UW6dUYrN/qg7/68uWxZuxWa8fSLFR/xnEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PemXpk7B4/Hyqgud74VTc2J3Z0W0sCuHVhMvsWqvwzM=;
	b=9uz7+w0rE4JGCQHOT7I130GEOmpC1ExF5ht8yHVXIVWUIcbUsDulkuIeqMjblyPwdxLohu
	WljQlyl6J5et26BQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Allow custom fixups in handle_bug()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.275223080@infradead.org>
References: <20250224124200.275223080@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056726168.10177.9438836200421162490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5d28fddb66e672e3183716a156cae04597599d3b
Gitweb:        https://git.kernel.org/tip/5d28fddb66e672e3183716a156cae04597599d3b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Feb 2025 11:41:54 +01:00

x86/traps: Allow custom fixups in handle_bug()

The normal fixup in handle_bug() is simply continuing at the next
instruction. However upcomming patches make this the wrong thing, so
allow handlers (specifically handle_cfi_failure()) to over-ride
regs->ip.

The callchain is such that the fixup needs to be done before it is
determined if the exception is fatal, as such, revert any changes in
that case.

Additionally, have handle_cfi_failure() remember the regs->ip value it
starts with for reporting.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.275223080@infradead.org
---
 arch/x86/kernel/cfi.c   |  8 ++++----
 arch/x86/kernel/traps.c | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index f6905be..77086cf 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -67,16 +67,16 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
  */
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
-	unsigned long target;
+	unsigned long target, addr = regs->ip;
 	u32 type;
 
 	switch (cfi_mode) {
 	case CFI_KCFI:
-		if (!is_cfi_trap(regs->ip))
+		if (!is_cfi_trap(addr))
 			return BUG_TRAP_TYPE_NONE;
 
 		if (!decode_cfi_insn(regs, &target, &type))
-			return report_cfi_failure_noaddr(regs, regs->ip);
+			return report_cfi_failure_noaddr(regs, addr);
 
 		break;
 
@@ -90,7 +90,7 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 		return BUG_TRAP_TYPE_NONE;
 	}
 
-	return report_cfi_failure(regs, regs->ip, &target, type);
+	return report_cfi_failure(regs, addr, &target, type);
 }
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a02a51b..c169f3b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -287,11 +287,12 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
+	unsigned long addr = regs->ip;
 	bool handled = false;
 	int ud_type, ud_len;
 	s32 ud_imm;
 
-	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
+	ud_type = decode_bug(addr, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -339,8 +340,17 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		break;
 	}
 
-	if (handled)
-		regs->ip += ud_len;
+	/*
+	 * When continuing, and regs->ip hasn't changed, move it to the next
+	 * instruction. When not continuing execution, restore the instruction
+	 * pointer.
+	 */
+	if (handled) {
+		if (regs->ip == addr)
+			regs->ip += ud_len;
+	} else {
+		regs->ip = addr;
+	}
 
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();

