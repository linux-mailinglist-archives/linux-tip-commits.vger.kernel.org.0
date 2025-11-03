Return-Path: <linux-tip-commits+bounces-7214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A7C2C80A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 15:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E734937D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C583271E1;
	Mon,  3 Nov 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5RfwSuD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lx9zIHyu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F793314D01;
	Mon,  3 Nov 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181293; cv=none; b=NZ34VDY+uw1RLIS/7ANv9MKYTjbIhR+Q84itWml+sNGhu6mBZLUZrRXjp9IwpmPU6ySgTdKsn2v0KDGGfDD5Fwvy7e2l2VDxmUCfilsoKuagDMbcyvn6oTXpHXm/vEm9JXS83AqvAcQwVg5Yx/6lIaH1MXJm+0n0rCtVlgILhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181293; c=relaxed/simple;
	bh=ipCOl9kvSMN3YGQkQ0wZCXzAm+45Lmgc9qk7+/ijRSA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IlHibWgxXwYSWIhpJmT/B3aMJtyO/DQYZgszpoqhJRmkpM8Z/6rT5cVQ7/FK6h8mAyvCChwmlkf0TsukQP0ZYfI67dCBPBxlDi794WI55rkdSx3rifeDNsmkgPtPGbQWm6+ZOQK4ZfmTV/Dvj8SU1aUjZwkYMMh+YhQKaNAxA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5RfwSuD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lx9zIHyu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:48:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jikBLmACzYp34WS/NvnVEpzWvdF3Gsb0dWl8j8illGw=;
	b=G5RfwSuDb4DScttY31VBq2kJIX2yfseVlp5EobLO9pZczZl71jqO7xcsEgtvdAHycEMLKP
	SVDhOEE05NTEykMh77WGnyzpznjTY7yLTor/mKvm0U7+XQc6hNj1ntAICTUHT2JijhgFPK
	UKIzPN6intsDujyGJXX2WnOzrW1F/HdP7fR+xIzxzuMBT4mTnWbP0KS8kk4T3FfXd8Ry/F
	B6ZtXIwFTyXr095tdMlsi80SFyxqPd9uxo35sCX5w1pqdvYEB2LhiaAjn7NY+xRnxnWzOv
	lUI9snBLUxFu9VmYEaC2RMud4QI3Ifpt48noKkniagyQtykgDJLevytPzpkA6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jikBLmACzYp34WS/NvnVEpzWvdF3Gsb0dWl8j8illGw=;
	b=lx9zIHyukICBT9vozcWQE4fjHktNhtzPJzP26tmZNErQoDvBQ8L+p4MI0S/zy8gAmqtm+n
	WFTPmh0cFW5GYcDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] powerpc/uaccess: Use unsafe wrappers for ASM GOTO
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.356628509@linutronix.de>
References: <20251027083745.356628509@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218128939.2601451.12092501638522095997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     5002dd53144f82d43eba778c927adfa7d429c16a
Gitweb:        https://git.kernel.org/tip/5002dd53144f82d43eba778c927adfa7d42=
9c16a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:09 +01:00

powerpc/uaccess: Use unsafe wrappers for ASM GOTO

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
Link: https://patch.msgid.link/20251027083745.356628509@linutronix.de
---
 arch/powerpc/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/ua=
ccess.h
index 4f5a46a..784a00e 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -451,7 +451,7 @@ user_write_access_begin(const void __user *ptr, size_t le=
n)
 #define user_write_access_begin	user_write_access_begin
 #define user_write_access_end		prevent_current_write_to_user
=20
-#define unsafe_get_user(x, p, e) do {					\
+#define arch_unsafe_get_user(x, p, e) do {			\
 	__long_type(*(p)) __gu_val;				\
 	__typeof__(*(p)) __user *__gu_addr =3D (p);		\
 								\
@@ -459,7 +459,7 @@ user_write_access_begin(const void __user *ptr, size_t le=
n)
 	(x) =3D (__typeof__(*(p)))__gu_val;			\
 } while (0)
=20
-#define unsafe_put_user(x, p, e) \
+#define arch_unsafe_put_user(x, p, e)				\
 	__put_user_size_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
=20
 #define unsafe_copy_from_user(d, s, l, e) \
@@ -504,11 +504,11 @@ do {									\
 		unsafe_put_user(*(u8*)(_src + _i), (u8 __user *)(_dst + _i), e); \
 } while (0)
=20
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)		\
 	__get_user_size_goto(*((type *)(dst)),				\
 		(__force type __user *)(src), sizeof(type), err_label)
=20
-#define __put_kernel_nofault(dst, src, type, err_label)			\
+#define arch_put_kernel_nofault(dst, src, type, err_label)		\
 	__put_user_size_goto(*((type *)(src)),				\
 		(__force type __user *)(dst), sizeof(type), err_label)
=20

