Return-Path: <linux-tip-commits+bounces-4629-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B22FA796E6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 22:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112F01711A2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 20:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836F51F150B;
	Wed,  2 Apr 2025 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LlbeVR6b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5cJDJXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC01F130E;
	Wed,  2 Apr 2025 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627308; cv=none; b=tB+qBNEFf9+52kY3zWbCBTfcebYlky9PhT8jrOfiuY2XSxN+6et9OP5GDkVFlnvbQMwGUrbDGjzdOqvRkWr4eUsIRXAWF1VNMa4QTpjtRpGuU5xjG6DLOvTzNtPEk7hZDPP0p6yjCmrxZVVbf39wHLv+yhUGK7dBbFtBFPREdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627308; c=relaxed/simple;
	bh=IJMfFJB5RAS82t5AJGmvYpFASEz2xELVAZxfFrjkjTc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uZhRKZDyXNP6+WWiNn4l9rZmLhKJaeMvxeP07VomhfRmmBBr5n/zoay29k/RX1RFZWFzOEUucWV+dqSgGLDh9Talo6Iu69szuKERRHmMxJlMqBNeq9RqVDsYswQo+j97CfmSGMA4YuZp68p6xnfqP9K3U25Crs4nd2QvVIOMyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LlbeVR6b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o5cJDJXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Apr 2025 20:55:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743627304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaVdHQfjeIL0gLeNZTp4EYIGMIrAipefe4bfBQLFK0c=;
	b=LlbeVR6bp+3JCCb+nQAsPbGI02WnoamiK+l54B0DZtTcJtS7X2dW89TXndhLDDWH2zDcsN
	T3BVqOhYpgwNCAwhYKj01o0qnS/W/atC92N7PEQPvld+ADmgVoh1CZIp/PAFij1a3LZiEy
	bbnoQnqyfSqFDO7Ai8gL9YWNBG7uNSa9WKkdqQhd5crJ1WXHuSUmjdPvNoPeTfQ95BcMmk
	jL5pHngrT3o4Yc3Oy/tQOPozFtf3O/pjGeqoURXiAVcb9ZfGZVkvrjDho4tKDN58pPzL8j
	TtOGQjHh9V9GBHz+W0Gojjr2LO1hhCG6VtwJKr+kg55Q5xktr88zbDo8xRL4+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743627304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaVdHQfjeIL0gLeNZTp4EYIGMIrAipefe4bfBQLFK0c=;
	b=o5cJDJXpUvFma4SLHB1jqq5eGI7bwtw9GRD+wpdvb2Ai39aDLJKVhOK7H1mMkeGq5fsYc4
	2KBY+kUjy50+rsDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/idle: Remove CONFIG_AS_TPAUSE
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402180827.3762-4-ubizjak@gmail.com>
References: <20250402180827.3762-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174362730161.14745.794215138372098584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6c921984e75c78e1c509d99b8cde04f1eadd46fb
Gitweb:        https://git.kernel.org/tip/6c921984e75c78e1c509d99b8cde04f1eadd46fb
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 02 Apr 2025 20:08:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 02 Apr 2025 22:44:55 +02:00

x86/idle: Remove CONFIG_AS_TPAUSE

There is not much point in CONFIG_AS_TPAUSE at all when the emitted
assembly is always the same - it only obfuscates the __tpause() code
in essence.

Remove the TPAUSE insn mnemonic from __tpause() and leave only
the equivalent byte-wise definition. This can then be changed
back to insn mnemonic once binutils 2.31.1 is the minimum version
to build the kernel. (Right now it's 2.25.)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402180827.3762-4-ubizjak@gmail.com
---
 arch/x86/Kconfig.assembler   |  4 ----
 arch/x86/include/asm/mwait.h | 11 ++---------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 6d20a6c..fa88585 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -15,10 +15,6 @@ config AS_SHA256_NI
 	def_bool $(as-instr,sha256msg1 %xmm0$(comma)%xmm1)
 	help
 	  Supported by binutils >= 2.24 and LLVM integrated assembler
-config AS_TPAUSE
-	def_bool $(as-instr,tpause %ecx)
-	help
-	  Supported by binutils >= 2.31.1 and LLVM integrated assembler >= V7
 
 config AS_GFNI
 	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 6522886..5141d2a 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -133,16 +133,9 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
  */
 static inline void __tpause(u32 ecx, u32 edx, u32 eax)
 {
-	/* "tpause %ecx, %edx, %eax" */
-	#ifdef CONFIG_AS_TPAUSE
-	asm volatile("tpause %%ecx"
-		     :
-		     : "c"(ecx), "d"(edx), "a"(eax));
-	#else
+	/* "tpause %ecx" */
 	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1"
-		     :
-		     : "c"(ecx), "d"(edx), "a"(eax));
-	#endif
+		     :: "c" (ecx), "d" (edx), "a" (eax));
 }
 
 #endif /* _ASM_X86_MWAIT_H */

