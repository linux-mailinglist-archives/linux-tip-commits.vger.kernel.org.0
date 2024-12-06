Return-Path: <linux-tip-commits+bounces-3001-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2A9E6BCD
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F7D288B5F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6963201111;
	Fri,  6 Dec 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BmwZdP5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cruCxBYU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AD200B84;
	Fri,  6 Dec 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480212; cv=none; b=b+uvV5yXDkNz7Kj+2owpMOOIC0ZtlMkSSoP0elF87RJHWz9mKCbMEGfk4MmdRrLK/w1POkF7i1LBYVz/g3VuwU92Pyi/otx1FP5C4ugP+/r5lboIE/KGsuejL0vxMDxu1qgxTrvidOCDMyGp9URDLQ2ijoTxL7EIlMjgOkt6oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480212; c=relaxed/simple;
	bh=09Tc8HFR7sVWKNtBgoQzw5iJaZrLRLGqToA0zacDph4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tvCOTBP9lsl0vN1QqVeGLijOh/1/c7lRTLkRt54BuTO/8SZQDMbOQXK1+eINZH5GQf6Z5tN3P9pk9TPnRwCw0qOyn5mdoyubcnQpD56GKMD9LwjpESrxR8erhZhHTP/oVSZ7AkXFdDUrpF3HGhGFx5pjOUE+EC/JSJMB+p0l9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0BmwZdP5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cruCxBYU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zah0M/xYPqngKbwywTAqMBsjpQHS5kRy1YlwYT4oa6Q=;
	b=0BmwZdP5egY2Sb+cHOSMi6qbv0LSfLlHrp3KlgX5edCXcn1gXlNQW97s2JhStsUBH+FcZc
	jlDYeI/ATm1N3Z4BLKoVf85TVgmBujbEVPyRZ+YIW+Y3Wx/y8lIqb4fkRyDzDT+Q/j7tbd
	HnmSbCKXNEw+4hykgGX5xe7Qv4V7XE0TX2OQwOtzGyV4VlRUP036e58e/3OhYKB2UrwqvC
	EkX/xCnyiVxcwJrhvQkyVvguD3tyNA0LtoiF6MdF3bhrupCT7SVybIvj0HuGU/LEXl9Hp5
	JyTTrjlOdI0Ez0jWxIIQp+RnAqY6sZI8ssO7mIpKPgpyHW68kOMZv/S37ksOmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zah0M/xYPqngKbwywTAqMBsjpQHS5kRy1YlwYT4oa6Q=;
	b=cruCxBYUyp3hCjYVmj9jHq7Gu9l+4jxAyhQ500y9F7RHTBiMTaohxBRPyngMteMzsxo/KD
	CSNVYjOEDPtmCjDA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/kexec: Move relocate_kernel to kernel .data section
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-9-dwmw2@infradead.org>
References: <20241205153343.3275139-9-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020665.412.8869298191554042252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     cb33ff9e063c1230d557d97ff6e87d097821d517
Gitweb:        https://git.kernel.org/tip/cb33ff9e063c1230d557d97ff6e87d097821d517
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:14 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:41:59 +01:00

x86/kexec: Move relocate_kernel to kernel .data section

Now that the copy is executed instead of the original, the relocate_kernel
page can live in the kernel's .text section. This will allow subsequent
commits to actually add real data to it and clean up the code somewhat as
well as making the control page ROX.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-9-dwmw2@infradead.org
---
 arch/x86/include/asm/sections.h      |  1 +
 arch/x86/kernel/callthunks.c         |  6 ++++++
 arch/x86/kernel/machine_kexec_64.c   |  4 +++-
 arch/x86/kernel/relocate_kernel_64.S |  7 +------
 arch/x86/kernel/vmlinux.lds.S        | 15 ++++++++++++++-
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 3fa87e5..30e8ee7 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -5,6 +5,7 @@
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
+extern char __relocate_kernel_start[], __relocate_kernel_end[];
 extern char __brk_base[], __brk_limit[];
 extern char __end_rodata_aligned[];
 
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 4656474..51c3e00 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -139,9 +139,15 @@ static bool skip_addr(void *dest)
 		return true;
 #endif
 #ifdef CONFIG_KEXEC_CORE
+# ifdef CONFIG_X86_64
+	if (dest >= (void *)__relocate_kernel_start &&
+	    dest < (void *)__relocate_kernel_end)
+		return true;
+# else
 	if (dest >= (void *)relocate_kernel &&
 	    dest < (void*)relocate_kernel + KEXEC_CONTROL_CODE_MAX_SIZE)
 		return true;
+# endif
 #endif
 #ifdef CONFIG_XEN
 	if (dest >= (void *)hypercall_page &&
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9567347..23dffdc 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -307,6 +307,8 @@ static void load_segments(void)
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page);
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	int result;
 
 	/* Setup the identity mapped 64bit page table */
@@ -314,7 +316,7 @@ int machine_kexec_prepare(struct kimage *image)
 	if (result)
 		return result;
 
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	set_memory_x((unsigned long)control_page, 1);
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index d0a87b3..2670044 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -41,10 +41,8 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
 #define CP_VA_CONTROL_PAGE	DATA(0x38)
 
-	.text
-	.align PAGE_SIZE
+	.section .text.relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_range)
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -341,6 +339,3 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 	int3
 SYM_CODE_END(swap_pages)
-
-	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
-SYM_CODE_END(relocate_range);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 56cdf13..78ce1a0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -28,6 +28,7 @@
 #include <asm/orc_lookup.h>
 #include <asm/cache.h>
 #include <asm/boot.h>
+#include <asm/kexec.h>
 
 #undef i386     /* in case the preprocessor is a 32bit one */
 
@@ -95,7 +96,18 @@ const_pcpu_hot = pcpu_hot;
 #define BSS_DECRYPTED
 
 #endif
-
+#if defined(CONFIG_X86_64) && defined(CONFIG_KEXEC_CORE)
+#define KEXEC_RELOCATE_KERNEL					\
+	. = ALIGN(0x100);					\
+	__relocate_kernel_start = .;				\
+	*(.text.relocate_kernel);				\
+	__relocate_kernel_end = .;
+
+ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,
+	"relocate_kernel code too large!")
+#else
+#define KEXEC_RELOCATE_KERNEL
+#endif
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
@@ -184,6 +196,7 @@ SECTIONS
 
 		DATA_DATA
 		CONSTRUCTORS
+		KEXEC_RELOCATE_KERNEL
 
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)

