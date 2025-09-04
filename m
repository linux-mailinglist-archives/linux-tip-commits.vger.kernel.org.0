Return-Path: <linux-tip-commits+bounces-6455-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFBFB43783
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295A33A9BCE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399D2F83CC;
	Thu,  4 Sep 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HY6bHnit";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqH13Mnr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA02F8BC8;
	Thu,  4 Sep 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979329; cv=none; b=I8Xuc7yc+/zQgQIOW2v5vHoL4T842dC0WttE9+uPVUN92i66QVcLr2qucQyD/fvtFMS/PVa0x4jYmlr4KVCZwTBt7JvBe4oIcgcJIER2nynUa+n0lkE23xauE1nbDlwkynIXe0Uf2VRRl/C61WyeVuMd+0wHZbxVl1JyG9mj46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979329; c=relaxed/simple;
	bh=ZeNaLWxP8JNXz3GdhKzYMHnGisn8rI+YmPK5TSL2nJc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RLtxCh3037TcVBwWgh77WrTV5O1VZ+yuqHDT2qA869YDPfKl7IkkAFNQPzvqu/+07GMey0WJ15fLt6a6poieAS7Tyo4o3B9jFEu+M9ZbrFeLziEf5mMFq0ov8L3uKTwCcekxNoRM4nn5ryoRX5aBB7Jlj+M+b/TfSlRDI0X2FCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HY6bHnit; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqH13Mnr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:48:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756979326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HH9pr09meki1kL4+vEU0jH9yzJNZwlSmXQumSt741k=;
	b=HY6bHnitMaHKcuMt/DdlWgS/b4+5MITSDzeFuS+2kco42d0y1fV5dMwB66Le1HStyf7OXz
	wPiE3AVzgKsFX77yVgssUwRuEILZCYlGC6s44PTbmBZpB7m4oaWyZttkV1c0RmQdMiY36j
	P8uhzidtKbEfxLagDxkWH5GQXyYYw7E2i20Mppxw/ULqhEntx7ExqbLzMeEozwUi9g094u
	O60VHrfh4T68c9uJsYLyu1s9TaiW7rOYrb64kjeDmkYbJDhaIPFUfFRhO0yHmaqBxhPfNv
	EnMu9Jv63zJVrzMBSl74e2vhRX9NLZJ0fGfLdDTFT4fxOl3kJFp5zf4u7eU9KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756979326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HH9pr09meki1kL4+vEU0jH9yzJNZwlSmXQumSt741k=;
	b=fqH13MnrcmMbfOJ0Mky6Ug8OLpzR+0Egh4O87rr4VDydSEJObKzRkk7KAQnlzZqOQ9xMyP
	aI1yFv2IP1IYs6Bw==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Switch get/put_unaligned() from packed
 struct to memcpy()
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250722215754.672330-2-irogers@google.com>
References: <20250722215754.672330-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697932523.1920.9579199289854234132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     34a1cbf21227f1327ead30dcf2a52aac79bf4f15
Gitweb:        https://git.kernel.org/tip/34a1cbf21227f1327ead30dcf2a52aac79b=
f4f15
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 22 Jul 2025 14:57:52 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:43:03 +02:00

vdso: Switch get/put_unaligned() from packed struct to memcpy()

Type punning is necessary for get/put_unaligned() but the use of a packed
struct violates strict aliasing rules, requiring -fno-strict-aliasing to be
passed to the C compiler.

Switch to using memcpy() so that -fno-strict-aliasing isn't necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250722215754.672330-2-irogers@google.com

---
 include/vdso/unaligned.h | 41 +++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index ff0c06b..9076483 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
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

