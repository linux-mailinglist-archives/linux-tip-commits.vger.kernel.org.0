Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA4340E51
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhCRTet (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhCRTeg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:36 -0400
Date:   Thu, 18 Mar 2021 19:34:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2IzBJjmWHV3WuydMfw0o5qlagPlON9mKBZHXHGti+I=;
        b=K3XTAK5muGN1i+771db+t8FpzwabXeKWApiRP++x3OTs2B718BxxoT5McXTyfJJo2caTlk
        SGSVkanj4rYXtJl0pHGdZUHa6CxEEq2pu2N20PPqb8iVR9WwxmIvLvmfD+wP//z+QUeIdo
        wj+TPskXJKoWl/ctHqMyEdI6GDuTSTjZNNwoVrjpgXlX+OQRfGw0zvLXryNGqNUtdvjGv3
        zuzdEwGLqsXN8FqBQIwwer+pQRi8Evk4jfvWB5vFir6jR0Qnil9dzRb+lAc14YESL9rxHD
        nHUCSgEH34mCvG1rcvURcyW0vEiVRec/sWUcOFjNW1GEyIcS/X3rDTC6HGT6NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2IzBJjmWHV3WuydMfw0o5qlagPlON9mKBZHXHGti+I=;
        b=DMhrC/PMOZREWQ9SnU2lQnfJ0ktxPUOm7DjE+V806gX5yWbzcGkWY3Gi7w/1nxwjsq678N
        85Cg8ffXQQH5d+BA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Setup IDT in startup_32 boot path
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-5-joro@8bytes.org>
References: <20210312123824.306-5-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161609607458.398.15440346169034701337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     79419e13e8082cc15d174df979a363528e31f2e7
Gitweb:        https://git.kernel.org/tip/79419e13e8082cc15d174df979a363528e31f2e7
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 10 Mar 2021 09:43:21 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:46 +01:00

x86/boot/compressed/64: Setup IDT in startup_32 boot path

This boot path needs exception handling when it is used with SEV-ES.
Setup an IDT and provide a helper function to write IDT entries for
use in 32-bit protected mode.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-5-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S | 72 +++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c59c80c..2001c3b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -116,6 +116,9 @@ SYM_FUNC_START(startup_32)
 	lretl
 1:
 
+	/* Setup Exception handling for SEV-ES */
+	call	startup32_load_idt
+
 	/* Make sure cpu supports long mode. */
 	call	verify_cpu
 	testl	%eax, %eax
@@ -701,6 +704,19 @@ SYM_DATA_START(boot_idt)
 	.endr
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+SYM_DATA_START(boot32_idt_desc)
+	.word   boot32_idt_end - boot32_idt - 1
+	.long   0
+SYM_DATA_END(boot32_idt_desc)
+	.balign 8
+SYM_DATA_START(boot32_idt)
+	.rept 32
+	.quad 0
+	.endr
+SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
+#endif
+
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
 #endif
@@ -793,6 +809,62 @@ SYM_DATA_START_LOCAL(loaded_image_proto)
 SYM_DATA_END(loaded_image_proto)
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	__HEAD
+	.code32
+/*
+ * Write an IDT entry into boot32_idt
+ *
+ * Parameters:
+ *
+ * %eax:	Handler address
+ * %edx:	Vector number
+ *
+ * Physical offset is expected in %ebp
+ */
+SYM_FUNC_START(startup32_set_idt_entry)
+	push    %ebx
+	push    %ecx
+
+	/* IDT entry address to %ebx */
+	leal    rva(boot32_idt)(%ebp), %ebx
+	shl	$3, %edx
+	addl    %edx, %ebx
+
+	/* Build IDT entry, lower 4 bytes */
+	movl    %eax, %edx
+	andl    $0x0000ffff, %edx	# Target code segment offset [15:0]
+	movl    $__KERNEL32_CS, %ecx	# Target code segment selector
+	shl     $16, %ecx
+	orl     %ecx, %edx
+
+	/* Store lower 4 bytes to IDT */
+	movl    %edx, (%ebx)
+
+	/* Build IDT entry, upper 4 bytes */
+	movl    %eax, %edx
+	andl    $0xffff0000, %edx	# Target code segment offset [31:16]
+	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
+
+	/* Store upper 4 bytes to IDT */
+	movl    %edx, 4(%ebx)
+
+	pop     %ecx
+	pop     %ebx
+	ret
+SYM_FUNC_END(startup32_set_idt_entry)
+#endif
+
+SYM_FUNC_START(startup32_load_idt)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* Load IDT */
+	leal	rva(boot32_idt)(%ebp), %eax
+	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
+	lidt    rva(boot32_idt_desc)(%ebp)
+#endif
+	ret
+SYM_FUNC_END(startup32_load_idt)
+
 /*
  * Stack and heap for uncompression
  */
