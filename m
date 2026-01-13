Return-Path: <linux-tip-commits+bounces-7946-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1667AD192A8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C87D30382BF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F693904F5;
	Tue, 13 Jan 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYN7NF9S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6gCCRO2r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538E255F5E;
	Tue, 13 Jan 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312051; cv=none; b=SQLw/bOhqZDZVUK18i4dcdnKcIyulGX/PgWMwzK7aoXKxbBzPK6pNB07Ri9ykD2fx1RgXqpCBu/dTV8iRIuFavHYuI3aU+x67I5Th/cbZCGg0l24IjUrHikGZtEMQA/UdSRGRA8oZ0mcCsOtJIgNc5RQUCc7SeY0yY4oiTRV5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312051; c=relaxed/simple;
	bh=lr7Ns1658ZFs4JsTdmGBwOOQ9WQm4oRA2MNR/cWqHPI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nH3sRrXS4G2ng61K7dCQLC+i63fSoIDcwQOlTHdRj3d3ouPOZIMlKvNu/gK2tVmtJs3jQATW0aBKw89Mx1BR1TwbnOwdfKQZmdriSHEnbFlDiztoC8cohyelCOsP1UZAOifEjvyW2s0Cz8Q3QUoRen7/PEcBduQypxtMYLRKVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYN7NF9S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6gCCRO2r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKld/9aHodlFQ1pIgyfPIuJ03+gQGnVbUXC047Q68vE=;
	b=MYN7NF9SnLA+FuQu/RvpQrzD4BcGlVv6hRWmFjwDtjpiMBEWyH9id05VC9Kde+GUdsEHX6
	JlGKDWRMTZ0Ad6/PhdtcR1JIsPdj9FVE4jXJqu6a+0EhZwY21F+pgEU1guE4eG/K1Fk9+I
	b/VK9I5NZr3Oysjz/0HsuYiI6v2ZqZI4zJiUfNM3Uia2YhF8rJeF1oIuDD+Q6qFQRmdlgj
	KzwjSoTp3dZRAHr5YA61hk8bIsCgughR4obzoCCkIR1cuTgwvCMac8fbSdMKg6q0NFPK+S
	wl0xsSk1C0XGE4h5r5PGyF55QAgAamEdMQkImCWQiWSn4h+fMmEprdLblGU0hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312049;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKld/9aHodlFQ1pIgyfPIuJ03+gQGnVbUXC047Q68vE=;
	b=6gCCRO2rMBckYSDqcmWws4TDR2egUEzxA/Qx4IC3dwzSNPN3YIFpljnFnzSIyhYijR0qu+
	+tyUoxZ14Mu1foCg==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] tools headers: Update the linux/unaligned.h copy
 with the kernel sources
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251016205126.2882625-4-irogers@google.com>
References: <20251016205126.2882625-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831204795.510.15897037954239487071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     029a9504d871ce72adf9a13e5f1ce66f1db48be3
Gitweb:        https://git.kernel.org/tip/029a9504d871ce72adf9a13e5f1ce66f1db=
48be3
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 16 Oct 2025 13:51:25 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:46:00 +01:00

tools headers: Update the linux/unaligned.h copy with the kernel sources

To pick up the changes in:

  vdso: Switch get/put_unaligned() from packed struct to memcpy

As the code is dependent on __unqual_scalar_typeof, update also the tools
version of compiler_types.h to include this.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251016205126.2882625-4-irogers@google.com
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

