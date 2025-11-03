Return-Path: <linux-tip-commits+bounces-7215-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C09C2C973
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3332A422556
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9532721F;
	Mon,  3 Nov 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4quj0gvO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3vEXVDst"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE753271F9;
	Mon,  3 Nov 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181296; cv=none; b=l4EoZkB0DOGwUU+GaHkUx8Sj0NFBeOQTNlAOn950GPDq0/A7/64+g/pTW8In6X70JewR27RaKrtnGE3/hvfsilOKYITF9wFMu8n3fA/fBJ0Ygjmhz8T46FBR7MnCrjw5b9c6k3ggtEKmZR/QBMP0ToO2FdFzTCLPsuo5i1UyqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181296; c=relaxed/simple;
	bh=Cx4RkgIqfsndhl55IeXkUsMUn1nDxthzmnwzC5ykhWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bQGEbdPHKVvJZEOgwqpaLwp+8fZSF2vnXiJmcH7kPY4NJxTDKgx5xLoJMeuALKyJ6kHuaE0OemOmoOJcYIdu8ZcawawUZ6yv9GZkmoUS2pE2Xj9w68NXoQOqNEyvKGi7LrjD76FVxx7bpxy+1BZOSOXTFNEw3v/7ak68bSl2d4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4quj0gvO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3vEXVDst; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:48:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVmDJBj+xVUpRSD+TenoFedMVFtTK9DtIeq3qfa+So8=;
	b=4quj0gvONNfo9yLe6OChDX4dnDdxvn9IXjRhMpJsWE9BUpHkaeje/dSQmE5hmk6de8YYb3
	UNFnWlVVq9c9LVBVvsw9abhG8AmmC2g9SdDj3NoTTOPz2KTPToQufz+bqMKVGwITxNdpoo
	TTb7OhlH5v2DgJIEDSZV76/SqPnfIMTPJWRWjzjiG5qlPj0Wy0ggEnCuEWdvq7SAcfFYYO
	CUch8TcJehKAGvfAB1auvyASK1Aey/y15GICKoRWwxGV0k4eiKUa1w2DLX9C1jbZyiwJ99
	g8YyayCEbdE0Xs+Bbb3SZXVcvmvNNa1vNGNkZp8jSqsp21YMWrCuzRI/7jtIxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVmDJBj+xVUpRSD+TenoFedMVFtTK9DtIeq3qfa+So8=;
	b=3vEXVDst+cNfNmfj2dJC/0intgWnvGf+h/m4CEa/efFnKA8qaeJOFisKve3nIucr1YmsNG
	aLBfmVTQt3mUQpAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] x86/uaccess: Use unsafe wrappers for ASM GOTO
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.294359925@linutronix.de>
References: <20251027083745.294359925@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218129063.2601451.7388017519024655784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     14219398e3e1ce774d47b2dd55852d9b693cc6e1
Gitweb:        https://git.kernel.org/tip/14219398e3e1ce774d47b2dd55852d9b693=
cc6e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:09 +01:00

x86/uaccess: Use unsafe wrappers for ASM GOTO

ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:

bool foo(u32 __user *p, u32 val)
{
	scoped_guard(pagefault)
		unsafe_put_user(val, p, efault);
	return true;
efault:
	return false;
}

It ends up leaking the pagefault disable counter in the fault path. clang
at least fails the build.

Rename unsafe_*_user() to arch_unsafe_*_user() which makes the generic
uaccess header wrap it with a local label that makes both compilers emit
correct code. Same for the kernel_nofault() variants.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027083745.294359925@linutronix.de
---
 arch/x86/include/asm/uaccess.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 91a3fb8..367297b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -528,18 +528,18 @@ static __must_check __always_inline bool user_access_be=
gin(const void __user *pt
 #define user_access_save()	smap_save()
 #define user_access_restore(x)	smap_restore(x)
=20
-#define unsafe_put_user(x, ptr, label)	\
+#define arch_unsafe_put_user(x, ptr, label)	\
 	__put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
=20
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define unsafe_get_user(x, ptr, err_label)					\
+#define arch_unsafe_get_user(x, ptr, err_label)					\
 do {										\
 	__inttype(*(ptr)) __gu_val;						\
 	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), err_label);		\
 	(x) =3D (__force __typeof__(*(ptr)))__gu_val;				\
 } while (0)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define unsafe_get_user(x, ptr, err_label)					\
+#define arch_unsafe_get_user(x, ptr, err_label)					\
 do {										\
 	int __gu_err;								\
 	__inttype(*(ptr)) __gu_val;						\
@@ -618,11 +618,11 @@ do {									\
 } while (0)
=20
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)		\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
 			sizeof(type), err_label)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	int __kr_err;							\
 									\
@@ -633,7 +633,7 @@ do {									\
 } while (0)
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
=20
-#define __put_kernel_nofault(dst, src, type, err_label)			\
+#define arch_put_kernel_nofault(dst, src, type, err_label)		\
 	__put_user_size(*((type *)(src)), (__force type __user *)(dst),	\
 			sizeof(type), err_label)
=20

