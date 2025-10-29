Return-Path: <linux-tip-commits+bounces-7094-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5090C19CD0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4864719C0477
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE6354AD6;
	Wed, 29 Oct 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtSTYQAt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmxWuL1L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EB354AC7;
	Wed, 29 Oct 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733465; cv=none; b=XLMKZLznr2p/nxJA/iGw9YRcv52eo9iDCcsqZKWMiksPUVpF9vpRG00dzgX3WRsVHacKtJF9zidKEeJtYvWqCtF+SOsal0HrG0kZNNjl3OQ7L05PK5UezwPfABydrue/r/pbf8ksrH/INYbUyIzMgIBL2gQOUxZF1Cr/c8AJH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733465; c=relaxed/simple;
	bh=wx4suW/GgCulz0IFfWNCgEw1w+RMUkh7utDBEam2ZNQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kcr15GTnQBs+NScd97/THIaTKQi1c1IkzYsxW04gpbKWtJEu4Kmd5FBg02bgpzdkUDuhBep9m+YwhjtfzBD4CF4w3w2uRW2b86SUve2prAh8d/FsT19c7sQLPsQhoPwo6eNI/yy9zppmEXK0yhbEm6aLGqLjE5nKbAAPEp+9DnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtSTYQAt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmxWuL1L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsiQ/YmQyC/8GrKQw2GoFI87W2hA38STYNZ2CnniX0s=;
	b=XtSTYQAt1Dubl+uQP0A0+UPkfJPaUUY7ZJ39ZdwF0BkUUX8BLU2Hl28n0GEfP30LjRg/Wf
	phCt94UQYkwSbxNQm6ajxm3TtLxmOu7MScwriEnMThVE4bfASZB372/uXK4o6rFaNQ8FK9
	E8upVk4WSXhRTxGK3chJQ1CHsYO978bfnoOTlBGSbeGQSG3+w7aoDVODKeFw6BI0EWkj7q
	N815A1dbAJMzBNCpWpNz58ufc6Jm7x4rEub8CJXhzW4yY/jQBwwyO6/Stzx4pxjB4Iyg84
	eUwb3onlZECnYNfjdiRpwA13dbkgSbrv2AXJzMGAyejv8dsGt9ongN5Sit/r6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsiQ/YmQyC/8GrKQw2GoFI87W2hA38STYNZ2CnniX0s=;
	b=KmxWuL1L855i38WDQ+CBk/gMTc1J7VQ7avynyQxF/9CV9IVk8yliSem5Gq2J1jinRUR3ED
	PWP5h/ZNkVR6D/AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/rseq] ARM: uaccess: Implement missing __get_user_asm_dword()
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.168468637@linutronix.de>
References: <20251027083745.168468637@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173345626.2601451.9394372373920437956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     a4354629e7bef36e39ed46139d1f9486fdecf7c9
Gitweb:        https://git.kernel.org/tip/a4354629e7bef36e39ed46139d1f9486fde=
cf7c9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:07 +01:00

ARM: uaccess: Implement missing __get_user_asm_dword()

When CONFIG_CPU_SPECTRE=3Dn then get_user() is missing the 8 byte ASM variant
for no real good reason. This prevents using get_user(u64) in generic code.

Implement it as a sequence of two 4-byte reads with LE/BE awareness and
make the unsigned long (or long long) type for the intermediate variable to
read into dependend on the the target type.

The __long_type() macro and idea was lifted from PowerPC. Thanks to
Christophe for pointing it out.

Closes: https://lore.kernel.org/oe-kbuild-all/202509120155.pFgwfeUD-lkp@intel=
.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027083745.168468637@linutronix.de
---
 arch/arm/include/asm/uaccess.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index f90be31..d6ae80b 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -283,10 +283,17 @@ extern int __put_user_8(void *, unsigned long long);
 	__gu_err;							\
 })
=20
+/*
+ * This is a type: either unsigned long, if the argument fits into
+ * that type, or otherwise unsigned long long.
+ */
+#define __long_type(x) \
+	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
+
 #define __get_user_err(x, ptr, err, __t)				\
 do {									\
 	unsigned long __gu_addr =3D (unsigned long)(ptr);			\
-	unsigned long __gu_val;						\
+	__long_type(x) __gu_val;					\
 	unsigned int __ua_flags;					\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\
@@ -295,6 +302,7 @@ do {									\
 	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err, __t); break;	\
 	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err, __t); break;	\
 	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err, __t); break;	\
+	case 8:	__get_user_asm_dword(__gu_val, __gu_addr, err, __t); break;	\
 	default: (__gu_val) =3D __get_user_bad();				\
 	}								\
 	uaccess_restore(__ua_flags);					\
@@ -353,6 +361,22 @@ do {									\
 #define __get_user_asm_word(x, addr, err, __t)			\
 	__get_user_asm(x, addr, err, "ldr" __t)
=20
+#ifdef __ARMEB__
+#define __WORD0_OFFS	4
+#define __WORD1_OFFS	0
+#else
+#define __WORD0_OFFS	0
+#define __WORD1_OFFS	4
+#endif
+
+#define __get_user_asm_dword(x, addr, err, __t)				\
+	({								\
+	unsigned long __w0, __w1;					\
+	__get_user_asm(__w0, addr + __WORD0_OFFS, err, "ldr" __t);	\
+	__get_user_asm(__w1, addr + __WORD1_OFFS, err, "ldr" __t);	\
+	(x) =3D ((u64)__w1 << 32) | (u64) __w0;				\
+})
+
 #define __put_user_switch(x, ptr, __err, __fn)				\
 	do {								\
 		const __typeof__(*(ptr)) __user *__pu_ptr =3D (ptr);	\

