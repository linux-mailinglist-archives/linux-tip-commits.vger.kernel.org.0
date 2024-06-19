Return-Path: <linux-tip-commits+bounces-1465-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9690E615
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 10:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC358B2131B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F479952;
	Wed, 19 Jun 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZRQWK3PB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vopo60QR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43547A705;
	Wed, 19 Jun 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786397; cv=none; b=UCHRxXoj/8rHe7hgFlpV0RytBHVAmN9ri6bOM7FdS1Z4+Jy5ikWYvAJNl885+1M8n8odrbgeLU5qOueX4blkOAxgzL753xdLerzud0V+pd6MNFDfj0bsUyuV1ciX87dvJlOZWs83zWCo3irS3pCFUjW2ahh59x2tMFSlnmPPpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786397; c=relaxed/simple;
	bh=WxBPYdBf20vZqluKTXoy6qT/m6UvyG0nZz/rmrkwg64=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DXbAav9A5O/K1YC41fO6YD9Zpe0bew4AbFgI/tJUmFVkZzrHZL9zgJ6B0Qd9K02XXv5y+YaDxkIXJ8gofMGfjVKGqric6k0LZ285cQABTXWSZMFcw1Wg5aRWeS3pC8ToOwIb1gBWzNP1LGwh1AUf1PYPbWZddhlIvJP1OAC8+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZRQWK3PB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vopo60QR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Jun 2024 08:39:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718786393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8xOxzk9AkeIlOg1aSe9X63Xn1GV0GlJ22pyCLrFM9gI=;
	b=ZRQWK3PBGNNIPTHMn5NeT21JRceWggKvsX0mvqN4s8iapgIsFIO3x7wTrLHUJigrUcBQkd
	EgWPtiR+MATxqH3UFEOiCHtOy/ovaAX+tRHjecPe9L+4CocpxfaMyIwAzCBaDgNYp6TwtI
	FCVnGCvxHJNBejE3fGM95AFDmjdoHii2EjLxjtKQjIAwPiGQHr7fAFg47NQX6KQH4LlIBs
	J5P9WX3abJUySqqHpkIRJTtQFGXs5K6K6SD/RXByhdq55tG3hRKlJdZQvvkQZyFA2kgnR1
	gXYXhbPZQ8h/q5mgXa6WCQPKSOfQ7HTFeUJQweO9U8lnXQcZE7b95mj9bUUESA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718786393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8xOxzk9AkeIlOg1aSe9X63Xn1GV0GlJ22pyCLrFM9gI=;
	b=vopo60QR+CU8CrcfX8Sz3VTqc1HmCMDZyQETmPQnvzPHkfzKu+Ltr/dYnS6Ij58XtFxl6T
	iaI903heiYVwtUCA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives, kvm: Fix a couple of CALLs
 without a frame pointer
Cc: kernel test robot <lkp@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171878639288.10875.12927337921927674667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     93f78dadee5e56ae48aff567583d503868aa3bf2
Gitweb:        https://git.kernel.org/tip/93f78dadee5e56ae48aff567583d503868aa3bf2
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 18 Jun 2024 21:57:27 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 19 Jun 2024 10:33:25 +02:00

x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer

objtool complains:

  arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
  vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without frame pointer save/setup

Make sure rSP is an output operand to the respective asm() statements.

The test_cc() hunk courtesy of peterz. Also from him add some helpful
debugging info to the documentation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel.com/
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/alternative.h      |  2 +-
 arch/x86/kernel/alternative.c           |  2 +-
 arch/x86/kvm/emulate.c                  |  2 +-
 tools/objtool/Documentation/objtool.txt | 19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 89fa50d..8cff462 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -248,7 +248,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 37596a4..333b161 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1657,7 +1657,7 @@ static noinline void __init alt_reloc_selftest(void)
 	 */
 	asm_inline volatile (
 		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftest;", X86_FEATURE_ALWAYS)
-		: /* output */
+		: ASM_CALL_CONSTRAINT
 		: [mem] "m" (__alt_reloc_selftest_addr)
 		: _ASM_ARG1
 	);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5d4c861..c8cc578 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1069,7 +1069,7 @@ static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
+	    : "=a"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
 
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index fe39c2a..7c3ee95 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -284,6 +284,25 @@ the objtool maintainers.
 
    Otherwise the stack frame may not get created before the call.
 
+   objtool can help with pinpointing the exact function where it happens:
+
+   $ OBJTOOL_ARGS="--verbose" make arch/x86/kvm/
+
+   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x29: (alt)
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x0: <=== (sym)
+    LD [M]  arch/x86/kvm/kvm-intel.o
+   0000 0000000000028220 <em_loop.part.0>:
+   0000    28220:  0f b6 47 61             movzbl 0x61(%rdi),%eax
+   0004    28224:  3c e2                   cmp    $0xe2,%al
+   0006    28226:  74 2c                   je     28254 <em_loop.part.0+0x34>
+   0008    28228:  48 8b 57 10             mov    0x10(%rdi),%rdx
+   000c    2822c:  83 f0 05                xor    $0x5,%eax
+   000f    2822f:  48 c1 e0 04             shl    $0x4,%rax
+   0013    28233:  25 f0 00 00 00          and    $0xf0,%eax
+   0018    28238:  81 e2 d5 08 00 00       and    $0x8d5,%edx
+   001e    2823e:  80 ce 02                or     $0x2,%dh
+   ...
 
 2. file.o: warning: objtool: .text+0x53: unreachable instruction
 

