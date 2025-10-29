Return-Path: <linux-tip-commits+bounces-7090-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AA2C19C95
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E41F5084BF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DAA34F48E;
	Wed, 29 Oct 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLrBY7zo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pFE164W0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4634EEEE;
	Wed, 29 Oct 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733456; cv=none; b=A6gXTW0vLjdZC3MxseKx/kN9jkBOZznYxJeCyQGki3+iOw10OxJp+ziUkTw1AelfFyCmOefTg9q+OZAKa+uLjEI2/aW+2Q2Ute2X75WU5EMY7prXSALNxXhXfdiLPArZYDmDQzkecDrJmJDsR8+8siptOi29ER5lBr9BAjx4RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733456; c=relaxed/simple;
	bh=Y1ueJGr94bXBXKR9IgGIzR3DQs6A5hA+yUedfxXFsIc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EjaaN9hAwJGIFNZ/k8BsKALcOG6/komzSrTB89jn7ovkCkGtgoN72XMBTqnS9BjUYUKSsaQIIUAuH1AtVJ169ZulYdKkSlSkAJd1y4Xn1C8dLKhncX/V/CAFUNa8vbKBaAVFU1+rNkcI1TV1rlCm04vfVpMykJESCjCyXBF42mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLrBY7zo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pFE164W0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYPPmD17UCQG+JU1JjKuqneVoDkWPjeN0RCzVbTniu0=;
	b=sLrBY7zoEMatgzONAma//FyUaWPlrRQi6CiRqNy6tZ3XZM4G1hzxwshBci7AHSOSk+s42U
	AcCcttAjH0yE5KZi5dNP4EaMUTCRtfSIyvZFu//c65qSLiB+aO1MV+bktOjeeelIZlYADU
	kH9Jlodvmi9UMayFmORnQcxfbJT2gAEslCmrdwcSXuq7liiS+wv5MCB/RYptxziwEFjLvX
	bCJaTxXS94Qnklr0vjE3e9ZWONBnxj9YqQAhe+CemtUR212XkqKIevqAK5t7zlBB/dVOFH
	9d9bK8TrmkBE1bf6/hWcbxwAYtAIx2bYC3g5iD1QpJg6xeBPY1ayR8DkDvUT5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYPPmD17UCQG+JU1JjKuqneVoDkWPjeN0RCzVbTniu0=;
	b=pFE164W0VZtF3kk2UYMBSvIWAizKYgq20otV/pLOLyjMj4tyaUgWta71F8vTkSmK4xTEDZ
	mPDYcQH+ZNRY2MAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] riscv/uaccess: Use unsafe wrappers for ASM GOTO
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.419351819@linutronix.de>
References: <20251027083745.419351819@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173345142.2601451.2122580905143496385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     6de388be01ff9399789da58e5935ed9dac88bc4a
Gitweb:        https://git.kernel.org/tip/6de388be01ff9399789da58e5935ed9dac8=
8bc4a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:09 +01:00

riscv/uaccess: Use unsafe wrappers for ASM GOTO

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
Link: https://patch.msgid.link/20251027083745.419351819@linutronix.de
---
 arch/riscv/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uacces=
s.h
index f5f4f7f..36bba67 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -437,10 +437,10 @@ unsigned long __must_check clear_user(void __user *to, =
unsigned long n)
 		__clear_user(untagged_addr(to), n) : n;
 }
=20
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)			\
 	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_labe=
l)
=20
-#define __put_kernel_nofault(dst, src, type, err_label)			\
+#define arch_put_kernel_nofault(dst, src, type, err_label)			\
 	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_labe=
l)
=20
 static __must_check __always_inline bool user_access_begin(const void __user=
 *ptr, size_t len)
@@ -460,10 +460,10 @@ static inline void user_access_restore(unsigned long en=
abled) { }
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_put_user(x, ptr, label)					\
+#define arch_unsafe_put_user(x, ptr, label)				\
 	__put_user_nocheck(x, (ptr), label)
=20
-#define unsafe_get_user(x, ptr, label)	do {				\
+#define arch_unsafe_get_user(x, ptr, label)	do {			\
 	__inttype(*(ptr)) __gu_val;					\
 	__get_user_nocheck(__gu_val, (ptr), label);			\
 	(x) =3D (__force __typeof__(*(ptr)))__gu_val;			\

