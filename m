Return-Path: <linux-tip-commits+bounces-6454-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8687DB43782
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418F4545024
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F52F90CE;
	Thu,  4 Sep 2025 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/Nd9Awn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="veaDcSpN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232782F7471;
	Thu,  4 Sep 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979328; cv=none; b=soLRVB5P81hqVq127Yo9Akr/8HM1eP8tbgkv/uARSAMxp7SPi6v2Y2/6sd029WkIleyfRylNfCRhxefwJ7clhP7mEiVPftLoZNI9SZcfBBhV7zGgt0Agk01Md6SnSfOv6ErrFybM0HUbUe2uypMa+dxW6+6EDeqCN9hJGyKPy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979328; c=relaxed/simple;
	bh=bxg9a2FheRlVqGZpcDJ/J4sGMZbDBX0ZnbROqtl196Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iJTezk5YFdrZMnkRGyQILFbG9OdrG9/9jrG766iRsYyCnPn1TKsgufTPzWM+MR4JWKVzwxIwJrWiOaBe2dt1tRFqciCmsRVvvF0BXk+VZcHl3HMoKb8n5191X19u8jJezQ6CwIVccWVZOnqcHhyt5axwFNYDzqx2oluuuLSbEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/Nd9Awn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=veaDcSpN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:48:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756979325;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVAgRECgby/shc59th13qFZb9S2hleRaHJWv3Q3oVWU=;
	b=c/Nd9AwnSxdCisiJJlIp4oIqwHq0jFXScWHnM9R1WbEqxyFjrcIPcl45W0Xj3ET7Wyf5zm
	KRVVzBa4Sss5Gl+X+XrMzc9TTcqNpSKSWNDYL9SDlZhtCfrZt1L9d4ZJW3LzzobsX1Mxxr
	UzOSKXDdTdRGN6t9csEq8w+y1ikfCoWkra78OWBk6PTOXhD7rupmzBI1jLo59sI/7cjBah
	gCO6BJNQXis/3LnigcBG8mW0WEAgamaopgw+q1dfENz/ew0BvrEylPOxfdGAtzEI9qeGgM
	+5ti2CR99DasHU8PG1ShLXYM28W7QlDdERRyCf/aZfztDAY6JO8zOfAPv84Vzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756979325;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVAgRECgby/shc59th13qFZb9S2hleRaHJWv3Q3oVWU=;
	b=veaDcSpNR5O/Aj3Td89cHjkA77CFRcdGiL5wCdv4oj9+Rf+FXpUoLpAgtcxd/DUzsiSctd
	D84+piInFae0msCQ==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] tools headers: Update the linux/unaligned.h copy
 with the kernel sources
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250722215754.672330-3-irogers@google.com>
References: <20250722215754.672330-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697932410.1920.3491676432905368096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     15f25184464199470bc355ea85f3813fa6156cac
Gitweb:        https://git.kernel.org/tip/15f25184464199470bc355ea85f3813fa61=
56cac
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 22 Jul 2025 14:57:53 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:43:03 +02:00

tools headers: Update the linux/unaligned.h copy with the kernel sources

To pick up the changes in:

   vdso: Switch get/put_unaligned() from packed struct to memcpy()

As the code is dependent on __unqual_scalar_typeof(), update also the tools
version of compiler_types.h to include this.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250722215754.672330-3-irogers@google.com

---
 tools/include/linux/compiler_types.h | 22 ++++++++++++++-
 tools/include/vdso/unaligned.h       | 41 +++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compi=
ler_types.h
index d09f9dc..8909822 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -40,4 +40,26 @@
 #define asm_goto_output(x...) asm goto(x)
 #endif
=20
+/*
+ * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+/*
+ * Prefer C11 _Generic for better compile-times and simpler code. Note: 'cha=
r'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ */
+#define __scalar_type_to_expr_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(signed type)0
+
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(char)0,				\
+			 __scalar_type_to_expr_cases(char),		\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+
 #endif /* __LINUX_COMPILER_TYPES_H */
diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
index ff0c06b..9076483 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
@@ -2,14 +2,43 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
=20
-#define __get_unaligned_t(type, ptr) ({							\
-	const struct { type x; } __packed * __get_pptr =3D (typeof(__get_pptr))(ptr=
);	\
-	__get_pptr->x;									\
+#include <linux/compiler_types.h>
+
+/**
+ * __get_unaligned_t - read an unaligned value from memory.
+ * @type:	the type to load from the pointer.
+ * @ptr:	the pointer to load from.
+ *
+ * Use memcpy to affect an unaligned type sized load avoiding undefined beha=
vior
+ * from approaches like type punning that require -fno-strict-aliasing in or=
der
+ * to be correct. As type may be const, use __unqual_scalar_typeof to map to=
 a
+ * non-const type - you can't memcpy into a const type. The
+ * __get_unaligned_ctrl_type gives __unqual_scalar_typeof its required
+ * expression rather than type, a pointer is used to avoid warnings about mi=
xing
+ * the use of 0 and NULL. The void* cast silences ubsan warnings.
+ */
+#define __get_unaligned_t(type, ptr) ({					\
+	type *__get_unaligned_ctrl_type __always_unused =3D NULL;		\
+	__unqual_scalar_typeof(*__get_unaligned_ctrl_type) __get_unaligned_val; \
+	__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),		\
+			 sizeof(__get_unaligned_val));			\
+	__get_unaligned_val;						\
 })
=20
-#define __put_unaligned_t(type, val, ptr) do {						\
-	struct { type x; } __packed * __put_pptr =3D (typeof(__put_pptr))(ptr);		\
-	__put_pptr->x =3D (val);								\
+/**
+ * __put_unaligned_t - write an unaligned value to memory.
+ * @type:	the type of the value to store.
+ * @val:	the value to store.
+ * @ptr:	the pointer to store to.
+ *
+ * Use memcpy to affect an unaligned type sized store avoiding undefined
+ * behavior from approaches like type punning that require -fno-strict-alias=
ing
+ * in order to be correct. The void* cast silences ubsan warnings.
+ */
+#define __put_unaligned_t(type, val, ptr) do {				\
+	type __put_unaligned_val =3D (val);				\
+	__builtin_memcpy((void *)(ptr), &__put_unaligned_val,		\
+			 sizeof(__put_unaligned_val));			\
 } while (0)
=20
 #endif /* __VDSO_UNALIGNED_H */

