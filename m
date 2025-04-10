Return-Path: <linux-tip-commits+bounces-4821-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7955A83A36
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 09:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B95517AAF1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50C204C1C;
	Thu, 10 Apr 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="US7F0PhH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yMMfquHO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D54202C26;
	Thu, 10 Apr 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268732; cv=none; b=FnAV4oOw4eqvCt0IYBFacVB+Ghqu+5cWa7yMrJ6J23VAzbsJz9oGSLE/i6VKHnhmDjQlo0J25asAO0xuWGHGYlPSARJSbdIse7qfEB+3urLF5W6+o5QHY4kBkSXrdB8BuZgrfwsRqw0d/NXTagUXHdbpqghAtOsXKqHUFToi5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268732; c=relaxed/simple;
	bh=QJLmLJtRLDLbgdHLnpjmlHW2HiSNjA+XBSi5dv+F25Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fk95ppDP6PpyJ1PlnMYR1+OGX9xoiOi/gn3fcSjsZ8YexnyKCXTkDgmDSwZ8J5ndxqC2Qe9UnGLpw36ZnLMnwUld+AczeyTlUHrFqtVV4rdYRtL0j5Y21+ISmkEqa81bjVHcBPP6ZEGX6jpWEPETzeuE2MpXSzP7osJiirvV46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=US7F0PhH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yMMfquHO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 07:05:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744268728;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ax53kxwqMjFEtwiakcKVbHBR11PkxdEppVH9Bx1IDzk=;
	b=US7F0PhHbuFVbt7bACLzDt8X6QedNby3V+WWQd7QJE/97PA3Qmwlxu6q6GIFLWSOCN4WQM
	zO0uINhU7L/5D9kHZC6hgTgeVgFO0nc6glz1QAQhF0lA9kBlrrL0/7vZNIEp0b2Yengud6
	HHXX7PAp2/oPsJXXy5uG3y11mzCRkjYuxhStXWHxjs3oOkFpY6QXyDi3pqbxkNfeACSp3r
	3aaQ/pINefq9xIW/okQQvQZ/Vj2rZffeGKo9Ekf4YOdSXwIoKegGPpElXnwKvp4ZFaUv4i
	m/eU5RMu2DirXXr+WjxCe3rmX6vCyX7Vekh+aGCtKZxVmzRlzJWU59/KP0iumA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744268728;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ax53kxwqMjFEtwiakcKVbHBR11PkxdEppVH9Bx1IDzk=;
	b=yMMfquHO+eKcUb7YN7DxnYcxERbquNLrFh0YLQzg0j2ohLLNFH8wLNRBX117SB90Q+hOn4
	b+x27xVcEVr72EAw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86: Remove __FORCE_ORDER workaround
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250407112316.378347-1-ubizjak@gmail.com>
References: <20250407112316.378347-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174426872208.31282.12151608220831424422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     a23be6ccd8b966ae2483bfc873720b2868ad63c3
Gitweb:        https://git.kernel.org/tip/a23be6ccd8b966ae2483bfc873720b2868ad63c3
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 07 Apr 2025 13:23:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 08:42:26 +02:00

x86: Remove __FORCE_ORDER workaround

GCC PR82602 that caused invalid scheduling of volatile asms:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602

was fixed for gcc-8.1.0, the current minimum version of the
compiler required to compile the kernel.

Remove workaround that prevented invalid scheduling for
compilers, affected by PR82602.

There were no differences between old and new kernel object file
when compiled for x86_64 defconfig with gcc-8.1.0.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250407112316.378347-1-ubizjak@gmail.com
---
 arch/x86/include/asm/debugreg.h      | 12 ++++++------
 arch/x86/include/asm/special_insns.h | 21 +++++----------------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index fdbbbfe..719d95f 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -23,7 +23,7 @@ DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
 static __always_inline unsigned long native_get_debugreg(int regno)
 {
-	unsigned long val = 0;	/* Damn you, gcc! */
+	unsigned long val;
 
 	switch (regno) {
 	case 0:
@@ -43,7 +43,7 @@ static __always_inline unsigned long native_get_debugreg(int regno)
 		break;
 	case 7:
 		/*
-		 * Apply __FORCE_ORDER to DR7 reads to forbid re-ordering them
+		 * Use "asm volatile" for DR7 reads to forbid re-ordering them
 		 * with other code.
 		 *
 		 * This is needed because a DR7 access can cause a #VC exception
@@ -55,7 +55,7 @@ static __always_inline unsigned long native_get_debugreg(int regno)
 		 * re-ordered to happen before the call to sev_es_ist_enter(),
 		 * causing stack recursion.
 		 */
-		asm volatile("mov %%db7, %0" : "=r" (val) : __FORCE_ORDER);
+		asm volatile("mov %%db7, %0" : "=r" (val));
 		break;
 	default:
 		BUG();
@@ -83,15 +83,15 @@ static __always_inline void native_set_debugreg(int regno, unsigned long value)
 		break;
 	case 7:
 		/*
-		 * Apply __FORCE_ORDER to DR7 writes to forbid re-ordering them
+		 * Use "asm volatile" for DR7 writes to forbid re-ordering them
 		 * with other code.
 		 *
 		 * While is didn't happen with a DR7 write (see the DR7 read
 		 * comment above which explains where it happened), add the
-		 * __FORCE_ORDER here too to avoid similar problems in the
+		 * "asm volatile" here too to avoid similar problems in the
 		 * future.
 		 */
-		asm volatile("mov %0, %%db7"	::"r" (value), __FORCE_ORDER);
+		asm volatile("mov %0, %%db7"	::"r" (value));
 		break;
 	default:
 		BUG();
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 6266d6b..ecda17e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -10,30 +10,19 @@
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>
 
-/*
- * The compiler should not reorder volatile asm statements with respect to each
- * other: they should execute in program order. However GCC 4.9.x and 5.x have
- * a bug (which was fixed in 8.1, 7.3 and 6.5) where they might reorder
- * volatile asm. The write functions are not affected since they have memory
- * clobbers preventing reordering. To prevent reads from being reordered with
- * respect to writes, use a dummy memory operand.
- */
-
-#define __FORCE_ORDER "m"(*(unsigned int *)0x1000UL)
-
 void native_write_cr0(unsigned long val);
 
 static inline unsigned long native_read_cr0(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr0,%0\n\t" : "=r" (val) : __FORCE_ORDER);
+	asm volatile("mov %%cr0,%0" : "=r" (val));
 	return val;
 }
 
 static __always_inline unsigned long native_read_cr2(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr2,%0\n\t" : "=r" (val) : __FORCE_ORDER);
+	asm volatile("mov %%cr2,%0" : "=r" (val));
 	return val;
 }
 
@@ -45,7 +34,7 @@ static __always_inline void native_write_cr2(unsigned long val)
 static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
+	asm volatile("mov %%cr3,%0" : "=r" (val));
 	return val;
 }
 
@@ -66,10 +55,10 @@ static inline unsigned long native_read_cr4(void)
 	asm volatile("1: mov %%cr4, %0\n"
 		     "2:\n"
 		     _ASM_EXTABLE(1b, 2b)
-		     : "=r" (val) : "0" (0), __FORCE_ORDER);
+		     : "=r" (val) : "0" (0));
 #else
 	/* CR4 always exists on x86_64. */
-	asm volatile("mov %%cr4,%0\n\t" : "=r" (val) : __FORCE_ORDER);
+	asm volatile("mov %%cr4,%0" : "=r" (val));
 #endif
 	return val;
 }

