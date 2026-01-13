Return-Path: <linux-tip-commits+bounces-7947-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4DD192B1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C39B3092236
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479793904F5;
	Tue, 13 Jan 2026 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/IpNSgh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xevI0Twi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF23904D6;
	Tue, 13 Jan 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312053; cv=none; b=WmCRBCg0IOTYdqls6ZelnND2aVyEoyxGa7abxn1qJCoZS/PxGSIkC30r0NlJyoBTepY+wLdKdI/BBJuCaKrRZ3iFKfn9WYxhRwX1LL5uxV+hV0rpg5NhL/+Wpa0IMoU6Zu18wSw7aOqiL+XcXwpKiLhHLk3wE0mOTX1dUZFBmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312053; c=relaxed/simple;
	bh=weiPnmfHFZ3ElBOLcjP1pFWkvfK+2CYE/K5CPRMhBJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bMS93EUckO0n4ScqYR7Get6Lm7Y4XFtGg7d6/REDv289Ox9XgC9OjNtGa6Uh9alNeih7KC8fImhR41V3/K5gAri76yX0wSg4MI81CfSNh184kOc/I8GNQqBtbuk34eGiS+ldZEfH3QBiVEOL6ZK2CB1ZSVMzkRTq2OtbBEAq1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/IpNSgh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xevI0Twi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIVDtZvr60lr512WnCflRnUDaq8FQeIL7Jsjil1txPY=;
	b=x/IpNSgh785SJeg3IMr6tsDCBSVgCWZyQywXJ1WBmrXtnnZGAg2HbIBau0wpp7lWULIy6e
	OrsS5HZzNOKqh5O0f7qcCvyN4YbtfyA+uN9uZbcWHxbbjt+V4fu6TQGMuV3vjlwpu4ksmG
	MI9YzHmhmpdp/HvsBGPlHdg294TPiXTdqqf28VJ6flrOywaesnuOqb7kf+CelKAP7q5RXL
	pd6OwLLsrv0ris/7qkkgQ+rLgOciFI3IzhmIa71D2zxw8efNH7fems3oTo6j+Jb/DWbg4r
	jzDhb0ISc1FAifrB8vcMnJwSSViHDj4YMDQriNGXLMKQzaDge6RS2Fa/XRshBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIVDtZvr60lr512WnCflRnUDaq8FQeIL7Jsjil1txPY=;
	b=xevI0TwiinL2Rv0ZrBj1WPzXvelGdcqwGx2iMTJMTzLRVt3Kha8wZuijfGtwnLwgamxBx/
	JNJDpnD2rjeXunAA==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Switch get/put_unaligned() from packed
 struct to memcpy()
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251016205126.2882625-3-irogers@google.com>
References: <20251016205126.2882625-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831204906.510.7821433428524791632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e04a494143bab7ea804fe1ebe286701ee8288e4a
Gitweb:        https://git.kernel.org/tip/e04a494143bab7ea804fe1ebe286701ee82=
88e4a
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 16 Oct 2025 13:51:24 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:46:00 +01:00

vdso: Switch get/put_unaligned() from packed struct to memcpy()

Type punning is necessary for get/put_unaligned() but the use of a packed
struct violates strict aliasing rules, requiring -fno-strict-aliasing to be
passed to the C compiler.

Switch to using memcpy() so that -fno-strict-aliasing isn't necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251016205126.2882625-3-irogers@google.com
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

