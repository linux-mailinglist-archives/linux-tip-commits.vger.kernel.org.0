Return-Path: <linux-tip-commits+bounces-2997-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B389E6BC9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC218836F5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF411FF7DF;
	Fri,  6 Dec 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCPY7A84";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UkAIcmZZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11281FF7BC;
	Fri,  6 Dec 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480207; cv=none; b=pRrngkYy77qipz8sSg3nRNlMGmiXci+DjiVIAKmJZAo+oOIebG9yACsPnUgBV8xwgVN8WAy0axEGEoS+9BDeoYVwpPlMYK3mEeSCvThNSPsBIF+J7pWyHhYI5+RG0GybrEWuxgFQTCPU8Klie1dujWIx8w1C33D6bhxW3cKPmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480207; c=relaxed/simple;
	bh=ag2r1zViK4bI71gF2wxlR3aufg09XyLR3Reue7cGLBM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cgdIi43dDOQFCV9P0ZyAr1VyH2lXpcP2Bw3MklkT+8G+Z3OvlitXcvbBRFxHPhJW04ejM77UzaYwYXZnwSXXxDVAAw5VyJ3RPIWjFGBcke4NrW49HtmfZVZNdwSaE8K6MfU07+29YbkSNvdESXedTTUXJAUW32vJoJk5CVYfDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCPY7A84; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UkAIcmZZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzeUa5cLskqzOkv8c+oqKZVZypHWzxeKq6pIxeE6k7c=;
	b=XCPY7A84HRZC1xAExlOTMTbwPGwD20EpjCwxWm/qMmywkac5lhEsaDAOWzkpqBUvUH98lX
	eSKJCmAooHOKsAuH+T7Ukpu8d6XfzM5mLFGbPUnK7EP6J63LVfGOzakFuhwj534/Zv4q/m
	GN9hCgQmoSstwVE0Z4Br89vA86ejyHN2LZwAVTrnxaFEkBYJuRrcx0SgVBUQtS3hSyjJ1Z
	qK2isg3nhOeqUJMj/+A9FKGLF7tkwrbLOdaLmOrZ2NS8sieB61SS7SrSxuFdCr5U2sjvxh
	XJAo3Rs9iK1IH1NhtKh9IQnylLygS0q1ztmgmf0HgQZHxTUP1hu6KBm6id9xaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzeUa5cLskqzOkv8c+oqKZVZypHWzxeKq6pIxeE6k7c=;
	b=UkAIcmZZzIm/pMMKQG8WWOWtFYIAPIWHzVqObk2d+8Wj9rc5EzojHvptLexBdV4HPvcbF9
	aEW9jvHr9eUh/eBQ==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/kexec: Clean up register usage in relocate_kernel()
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-13-dwmw2@infradead.org>
References: <20241205153343.3275139-13-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020350.412.5858875021410956509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     93e489ad7a4694bb2fe8110f5012f85bd3eee65a
Gitweb:        https://git.kernel.org/tip/93e489ad7a4694bb2fe8110f5012f85bd3eee65a
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:18 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:42:00 +01:00

x86/kexec: Clean up register usage in relocate_kernel()

The memory encryption flag is passed in %r8 because that's where the
calling convention puts it. Instead of moving it to %r12 and then using
%r8 for other things, just leave it in %r8 and use other registers
instead.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-13-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 739041c..8bc86a1 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -79,24 +79,18 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%cr4, %r13
 	movq	%r13, saved_cr4(%rip)
 
-	/* Save SME active flag */
-	movq	%r8, %r12
-
 	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
-	/* Physical address of control page */
-	movq    %rsi, %r8
-
 	/* setup a new stack at the end of the physical control page */
-	lea	PAGE_SIZE(%r8), %rsp
+	lea	PAGE_SIZE(%rsi), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %r8
-	pushq	%r8
+	addq	$(identity_mapped - relocate_kernel), %rsi
+	pushq	%rsi
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -107,8 +101,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/*
 	 * %rdi	indirection page
 	 * %rdx start address
+	 * %r8 host_mem_enc_active
+	 * %r9 page table page
 	 * %r11 preserve_context
-	 * %r12 host_mem_enc_active
 	 * %r13 original CR4 when relocate_kernel() was invoked
 	 */
 
@@ -161,7 +156,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * entries that will conflict with the now unencrypted memory
 	 * used by kexec. Flush the caches before copying the kernel.
 	 */
-	testq	%r12, %r12
+	testq	%r8, %r8
 	jz .Lsme_off
 	wbinvd
 .Lsme_off:

