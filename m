Return-Path: <linux-tip-commits+bounces-1472-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE290F5CC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2C11C211DF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAE156673;
	Wed, 19 Jun 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Vyc9IGA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="agE/05sV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B11F934;
	Wed, 19 Jun 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820780; cv=none; b=rQ0YGjmqqqliXY5iplIBNd7m+ZopinlrPz8koQEong0Tb6EqWcPOMSWmebng32Ew5ZDFqibyTEZeEsdd4y4b4DBGTwt9JxjZigRuWGNQ1iyBTWSd+AWQ3aOb2vlBo1n1NN4Oq5Y6orn8Puj9o91p3JKSLiROnSnMi7YTP+zYghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820780; c=relaxed/simple;
	bh=Ti59x7dVXTGIFe5lijG+VrDMUzzPCQAA0R4IUvnBsVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iXajVGOWszHLhPmBk0GnIu2KT72nH8QAICElW8dzxCcqt2gxenQpXBYF/yM6itaHVvFdayZvf7sJtGd8Z38LIBCrNFw9RzD6P+DkrQJ4mVs2B/pt37zwAlKhOs7pnwIRUwus2t1FsnzRDjnaCYfEYUNveV9zQWtuQYjnNFdzDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Vyc9IGA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=agE/05sV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Jun 2024 18:12:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718820776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtkSAnjK1rX3debocNSWCmm15z0NoGEzl/7kFGO4zgI=;
	b=1Vyc9IGA2paUWOmPsH2JNIed0y4SHrVlseVB0snYEkhYOhtwSFsRh4LXJUqe1SMGfM1grQ
	TlOdr9SzHoE56vUXocgrbkEs3PBntHSiinITr3JlquRgBsKaN0OvI3jYUUFTRLkhkVVld4
	z8vKwOCGhPp5aV48sM7VcSNJpMWaTEjlDgk8ERFa5/xbPmHK2MWWA9DRDvS/NLQluIUMVF
	45kWQRMC9U8eCEUeOHXX8FceO1qZ9yDfEN9Uwy8gQZaJjrfISTY8p0FQQCJV+a2pQD0TpF
	CyeBilF5PqiI+SoiMdYQL/yfxFNXfg9ciA9NxSCyJgNt0GPECoJJMfR7Eccjxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718820776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtkSAnjK1rX3debocNSWCmm15z0NoGEzl/7kFGO4zgI=;
	b=agE/05sVD1B2jV+US7gtyZpTZmXGglRwsVXosDv+dpvSFgVFN9MLYTM+DIqQGG0DioDEy1
	GzxJFnr6fBkEQFDw==
From: "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/uaccess: Improve the 8-byte getuser() case
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com>
References:
 <CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171882077633.10875.6520020635933292895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     8a2462df154799129d8259079ec1fecf78703189
Gitweb:        https://git.kernel.org/tip/8a2462df154799129d8259079ec1fecf78703189
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Wed, 19 Jun 2024 14:54:23 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 19 Jun 2024 19:56:07 +02:00

x86/uaccess: Improve the 8-byte getuser() case

Streamline the 8-byte case and drop the special handling. Use a macro
which hides the exception handling.

No functional changes.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com
---
 arch/x86/lib/getuser.S | 69 +++++++++++------------------------------
 1 file changed, 20 insertions(+), 49 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index a1cb3a4..a314622 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -44,21 +44,23 @@
 	or %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
-.if \size != 8
 	jae .Lbad_get_user
-.else
-	jae .Lbad_get_user_8
-.endif
 	sbb %edx, %edx		/* array_index_mask_nospec() */
 	and %edx, %eax
 .endif
 .endm
 
+.macro UACCESS op src dst
+1:	\op \src,\dst
+	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
+.endm
+
+
 	.text
 SYM_FUNC_START(__get_user_1)
 	check_range size=1
 	ASM_STAC
-1:	movzbl (%_ASM_AX),%edx
+	UACCESS movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -68,7 +70,7 @@ EXPORT_SYMBOL(__get_user_1)
 SYM_FUNC_START(__get_user_2)
 	check_range size=2
 	ASM_STAC
-2:	movzwl (%_ASM_AX),%edx
+	UACCESS movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -78,7 +80,7 @@ EXPORT_SYMBOL(__get_user_2)
 SYM_FUNC_START(__get_user_4)
 	check_range size=4
 	ASM_STAC
-3:	movl (%_ASM_AX),%edx
+	UACCESS movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -89,10 +91,11 @@ SYM_FUNC_START(__get_user_8)
 	check_range size=8
 	ASM_STAC
 #ifdef CONFIG_X86_64
-4:	movq (%_ASM_AX),%rdx
+	UACCESS movq (%_ASM_AX),%rdx
 #else
-4:	movl (%_ASM_AX),%edx
-5:	movl 4(%_ASM_AX),%ecx
+	xor %ecx,%ecx
+	UACCESS movl (%_ASM_AX),%edx
+	UACCESS movl 4(%_ASM_AX),%ecx
 #endif
 	xor %eax,%eax
 	ASM_CLAC
@@ -104,7 +107,7 @@ EXPORT_SYMBOL(__get_user_8)
 SYM_FUNC_START(__get_user_nocheck_1)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
-6:	movzbl (%_ASM_AX),%edx
+	UACCESS movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -114,7 +117,7 @@ EXPORT_SYMBOL(__get_user_nocheck_1)
 SYM_FUNC_START(__get_user_nocheck_2)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
-7:	movzwl (%_ASM_AX),%edx
+	UACCESS movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -124,7 +127,7 @@ EXPORT_SYMBOL(__get_user_nocheck_2)
 SYM_FUNC_START(__get_user_nocheck_4)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
-8:	movl (%_ASM_AX),%edx
+	UACCESS movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
@@ -135,10 +138,11 @@ SYM_FUNC_START(__get_user_nocheck_8)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
 #ifdef CONFIG_X86_64
-9:	movq (%_ASM_AX),%rdx
+	UACCESS movq (%_ASM_AX),%rdx
 #else
-9:	movl (%_ASM_AX),%edx
-10:	movl 4(%_ASM_AX),%ecx
+	xor %ecx,%ecx
+	UACCESS movl (%_ASM_AX),%edx
+	UACCESS movl 4(%_ASM_AX),%ecx
 #endif
 	xor %eax,%eax
 	ASM_CLAC
@@ -154,36 +158,3 @@ SYM_CODE_START_LOCAL(__get_user_handle_exception)
 	mov $(-EFAULT),%_ASM_AX
 	RET
 SYM_CODE_END(__get_user_handle_exception)
-
-#ifdef CONFIG_X86_32
-SYM_CODE_START_LOCAL(__get_user_8_handle_exception)
-	ASM_CLAC
-.Lbad_get_user_8:
-	xor %edx,%edx
-	xor %ecx,%ecx
-	mov $(-EFAULT),%_ASM_AX
-	RET
-SYM_CODE_END(__get_user_8_handle_exception)
-#endif
-
-/* get_user */
-	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(2b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(3b, __get_user_handle_exception)
-#ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(4b, __get_user_handle_exception)
-#else
-	_ASM_EXTABLE_UA(4b, __get_user_8_handle_exception)
-	_ASM_EXTABLE_UA(5b, __get_user_8_handle_exception)
-#endif
-
-/* __get_user */
-	_ASM_EXTABLE_UA(6b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(7b, __get_user_handle_exception)
-	_ASM_EXTABLE_UA(8b, __get_user_handle_exception)
-#ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(9b, __get_user_handle_exception)
-#else
-	_ASM_EXTABLE_UA(9b, __get_user_8_handle_exception)
-	_ASM_EXTABLE_UA(10b, __get_user_8_handle_exception)
-#endif

