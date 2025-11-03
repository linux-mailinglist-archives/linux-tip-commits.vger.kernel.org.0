Return-Path: <linux-tip-commits+bounces-7213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7DC2C93D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9EE420940
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A44326D46;
	Mon,  3 Nov 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CckwEXJ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tjvtH2z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300383254BC;
	Mon,  3 Nov 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181292; cv=none; b=mgrDzirmOsZx2c3Uyobv7GSRsgZ2/kySO7wfYIWPDg3GqeHqX2iekt+rqc4EUIrnHbuE2hKTSy30jHzkujawqfBpvO163rZ3u1797CI9Myp2IIgjsNNIXHdnYQXvse1RuGBoQZ4RZUYOIDJKO9vZKiRgEflVnTiIp1kJ/yASSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181292; c=relaxed/simple;
	bh=KDs5pWtyeprVbLGDsKDmcUpnsj8782vhnzO98XWvej4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vB82QwExGwgdbGaCxZwIBRv9kFeUb8ys9Ew2BYnkW+jDNUt95dxjfNLAQclY7tB1GF7seotD0fT3lYuI8+Dsx/U80yxuUsT5o1eBNEjl+DEitCNRocjYMTHW0Q2403FW3iHZAzHRiwil58AJgtfXIPcMD13VBfn+KMfvHc3ikC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CckwEXJ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tjvtH2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:48:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVEsPkORpL2BfX/8W0/HmeXFkVbKvTVz+vhDDvv3rsQ=;
	b=CckwEXJ8lZvML11m3kFJxfZL2A/ZohFOqXRikp5p/VYl0osJg4faogPu8OLy51GFwOA92n
	Sh9oFIrR/x2SOoBuCDQCW4scRdl8j1SGgBVlvNBmZ1OXzbqOXmq890Qg9LsYEnRRLg+wSO
	Ulv2zM2D2gDnCqb75Xj9ocTALV3+8rGniwn4cf2JQvTiOlqWr+ibiH4bYX9RXux7vyM34z
	MxGv0bpPWzWqPL1KTzvARFSOooxOwBs9d8Ww3liBkstQojE5QY0LyaeimnP6Lbw1Pmabp9
	JkBbKB0VIZ1JSuUXVhkjgBd9ruzkDtqaEvctsQAxGxPZjWkQwf5TcyjDBxI3Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVEsPkORpL2BfX/8W0/HmeXFkVbKvTVz+vhDDvv3rsQ=;
	b=2tjvtH2zlZPh9LMBMlBuUFBxSFK2dATQ7W9kAyJS1ZbekK+ypXYVSJKlZPyyPHmawiRgqD
	xqQMn+6625RaTICQ==
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
Message-ID: <176218128815.2601451.4683812589349804305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     0988ea18c6244da3dc35cfc0ad621531d0e1508a
Gitweb:        https://git.kernel.org/tip/0988ea18c6244da3dc35cfc0ad621531d0e=
1508a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:10 +01:00

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

