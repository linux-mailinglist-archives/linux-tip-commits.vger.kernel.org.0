Return-Path: <linux-tip-commits+bounces-7091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC031C19C9B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940161C827F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7F34FF71;
	Wed, 29 Oct 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVgxHtR9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWpSfxHn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15E34F465;
	Wed, 29 Oct 2025 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733457; cv=none; b=GQZMU1Wayq/FtYou7987bngxi1KYDPtAwmH0k1wET0IlexVlAVdK7YxLJDq/EvI6kwd0pTBFlwCfLFpAZASd1Rj8Hho1QF+4KWCqjmPRc0/jf2BmSQnvIrU//ijFywEmLLetPZUn/Z4RalXUT8l2Lq4ihq8Jvsqgw1+9BOF5hQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733457; c=relaxed/simple;
	bh=GKAZVzQq//FUKDKz3mm7fKif7avYBU2pZ96gl/fOkpk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eMdKihKoQufMLYU6KSjJtwM492dWGUnx7dMqKWP5uwDAnPjnkqHeiLAaRiKuSqVz+k2dAVO8/gYCgfZ+ufvxbZB7b9wYPglNMVqWgHww4bKZJ6PdBj3CoS4Gop54OTbnqrhFigGU1sdI9Cg0BCxwEQu/hLRe27Fj+ioiRdyX7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVgxHtR9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yWpSfxHn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8Q/3Cglq8kb6gnc01X6/atVhuMRKI+PiGKdoUgWwFs=;
	b=lVgxHtR9479A3QrJPbdwMpYrhLndym1hj5EAKGfrBl6I9r6fCyT17J2PqC2uA1Aou0+9Ms
	cRCe5wMl93NQeUS4PB+jj5hA6zIDr2afJ7i2NGgalV/g163A2LMckO3Bj7jITTPxXzx/fX
	LFFDYpHMPHAINpcK4I4PKdf4uhuTdhZMo8851jDsyl70rmDbgrgdHm7VteOoDBNCbtgK3b
	urqUvTgMtgfw7HNfUeChqLpkJ1KtzEcYPWxTL8Vn1OmjzzYxU2aFGbyYyA0awYu2exZvwf
	ncHpv16BViFhP1FHukbIrhdDfirtDJpOjvINxoUSPzNS3hk8/evujT6UgcWqgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8Q/3Cglq8kb6gnc01X6/atVhuMRKI+PiGKdoUgWwFs=;
	b=yWpSfxHnQZ5t2v6q3WC9I8fzFAHTFP09ICi7yXn4YjpbcLvjlOIUzgmQqoxCNkfuawPtGm
	xTJdUTGqCitQClAw==
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
Message-ID: <176173345265.2601451.7918862756893080866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     ea832a74a28cd09137c07f206557f7002e32b1f1
Gitweb:        https://git.kernel.org/tip/ea832a74a28cd09137c07f206557f7002e3=
2b1f1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:08 +01:00

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

