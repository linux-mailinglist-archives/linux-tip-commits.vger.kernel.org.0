Return-Path: <linux-tip-commits+bounces-4338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E47A68A9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D37C884E9F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE72561BB;
	Wed, 19 Mar 2025 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrFBmN5D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHHwBMzA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A89254873;
	Wed, 19 Mar 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382219; cv=none; b=XoofYV0+zTHfCYSD8dM2x5NznoCPQftTvit8V+86KJLgTcf/C2F0EG4RkMNgLbXqE3xZzD27NCUgHKFypnhUQtxYW3yknx/lHoujUOMbd6r7/RSKqHJgkwRc3E0NsbfAbH/+fj6v5+L3BVchci/NvKZGxISJl1dONESMiBXzvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382219; c=relaxed/simple;
	bh=flmW5XsVR3YGm8bG9muV1HgwtBs2C+RmqImGUOpOrGk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j7xJWFv9HLyl5HVwIOxZH6tJglDBFszciT0pH1XizYB+7ok7Kg2/BwESWNbPp+cex/cluFQNMzP+MBiFCBl3+Ncqja1C8WitZg9woLC5/aw1j7CfMC2K1hkK/eOi6x4GV8nNy3UaOFV0WjStBz9ZMJhFv7xSyAQBc0l0p7zYOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrFBmN5D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHHwBMzA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSCRt6d0Q3y7mqBTzkcA4hhuXeVvlt+3p5h9FQOSDjI=;
	b=LrFBmN5Dbg/Y8Yhg4Slml0b+pGWzgSVGEdFosr6iKriCY3qsOGKAt6luSUrqodn2RkzKZl
	USGK2XyRNJP/VKPlxnPvfR26vrrkNH/M19ZJ8XWpwIaxv/RembP9o0W4AveCrM8MjzjNHM
	LQ8QHF/mOyb0qgMEht/VlJz/9XjyiW44Z2TVFErd2PMI5a/55jgTtQzKsYDPpVqXwC7Q9x
	IxZqPCvepWwdfUgABVGlailHOyqjtdtOpyKtyJZ/8Uo8SkzroNLP8z7oweh46NLtIQuRym
	uEJj9VsAHAYiwL3Jw216aG70qc0TX+8XQsgiyvZgcxoyIMXFse1RI1WXYg80xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSCRt6d0Q3y7mqBTzkcA4hhuXeVvlt+3p5h9FQOSDjI=;
	b=CHHwBMzA0C0PFtVE29jDdyLf+rai7yf36euqJ20Uqhe6YjhVJDaQ6nheXDh1L+0pSKni3y
	aWrWA416qwmuhfCw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/head/64: Avoid Clang < 17 stack protector in startup code
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250312102740.602870-2-ardb+git@google.com>
References: <20250312102740.602870-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221553.14745.12737202385235724304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3f5dbafc2d4651020f45309ca85120b6a8162fd9
Gitweb:        https://git.kernel.org/tip/3f5dbafc2d4651020f45309ca85120b6a8162fd9
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 12 Mar 2025 11:27:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:49 +01:00

x86/head/64: Avoid Clang < 17 stack protector in startup code

Clang versions before 17 will not honour -fdirect-access-external-data
for the load of the stack cookie emitted into each function's prologue
and epilogue, and will emit a GOT based reference instead, e.g.,

  4c 8b 2d 00 00 00 00    mov    0x0(%rip),%r13
          18a: R_X86_64_REX_GOTPCRELX     __ref_stack_chk_guard-0x4
  65 49 8b 45 00          mov    %gs:0x0(%r13),%rax

This is inefficient, but at least, the linker will usually follow the
rules of the x86 psABI, and relax the GOT load into a RIP-relative LEA
instruction.  This is still suboptimal, as the per-CPU load could use a
RIP-relative reference directly, but at least it gets rid of the first
load from memory.

However, Boris reports that in some cases, when using distro builds of
Clang/LLD 15, the first load gets relaxed into

  49 c7 c6 20 c0 55 86 	mov    $0xffffffff8655c020,%r14
  ffffffff8373bf0f: R_X86_64_32S	__ref_stack_chk_guard
  65 49 8b 06          	mov    %gs:(%r14),%rax

instead, which is fine in principle, as MOV may be cheaper than LEA on
some micro-architectures. However, such absolute references assume that
the variable in question can be accessed via the kernel virtual mapping,
and this is not guaranteed for the startup code residing in .head.text.

This is therefore a true positive, that was caught using the recently
introduced relocs check for absolute references in the startup code:

  Absolute reference to symbol '__ref_stack_chk_guard' not permitted in .head.text

Work around the issue by disabling the stack protector in the startup
code for Clang versions older than 17.

Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU variable")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250312102740.602870-2-ardb+git@google.com
---
 arch/x86/include/asm/init.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 0e82ebc..8b1b1ab 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,7 +2,11 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
+#define __head	__section(".head.text") __no_sanitize_undefined __no_stack_protector
+#else
 #define __head	__section(".head.text") __no_sanitize_undefined
+#endif
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */

