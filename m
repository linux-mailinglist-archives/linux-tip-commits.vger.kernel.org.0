Return-Path: <linux-tip-commits+bounces-7978-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 544AED1CFAC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 329933035CF7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8EB36D516;
	Wed, 14 Jan 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PWkwUKz3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DyhlRXES"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B88356A39;
	Wed, 14 Jan 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377692; cv=none; b=arkNVwDIN7tZSvEbakZSfIsyyMGiEFtWrEDc3DORX1i77UAAOuYtFBLPTlpJqNmRWnvpwKSEbUNv4pGzaU+wxNgMVjuT0bGFaFhO32vQEbBPl9K3tWLv3RL6+3icL/Vnf5M6fh+/JWypLhUgbKdnr7vQ4ticAS8FPnoex+HCASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377692; c=relaxed/simple;
	bh=Bs8DHHVhXSX8zWZ079t1ZnT+Fyglyt9fmB2E5BiL4Us=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gvp0y/N6i9U6MlzF2z9KeK6RGKb7rqleBK0XQAaAbdp0uwkEAxY+KljRJQV/ZG2Ry0LCBNL67r/8dcI9aq8r01jL9pLl5uBJ2DScoLiugISUtgmc6Xxr5NGZvGkGcOOTtrCVwkwXD78IUXPdBPV6SOUsQaCT/nxSt39acpjHQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PWkwUKz3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DyhlRXES; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 08:01:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768377681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saQl4p3USgAV348Q1FrTGl1TUP1+ov1U5Lyx8VJO4iE=;
	b=PWkwUKz3r0Y6QuRKeVjVysMg8zrRGpF3g1kU8GZQqwTALfWQViUbNWmmRhASCqpbIpgH3s
	/JCO3OuP9K36bJMpVIj9NSa61EzaiRTwbif6hKh9q4smPe+t5XKUQs0mAWJX1UBHl4oa2M
	tFzEwSP5CX/KWApZ+Gv6ncPqNBC7IpEJkdNi8IEbU/7UKOnNd1F7bLEolyNY3OHGIwoMZJ
	aGTlLBZ2tt2jgGlFSZxUIy1ItxXkUk4tL9twbLJ/UrH1VvcbADl74niEBUkXRMp+rVLoHG
	fsPpm2hZN/dDJkOHfl4pwU2gel5K/9BToMyM+2ffGiH5X4no6L/NtUB85ERg/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768377681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saQl4p3USgAV348Q1FrTGl1TUP1+ov1U5Lyx8VJO4iE=;
	b=DyhlRXES7fnI4fLlZRoJYN5RHEtupYIipUklOR0wbuVyaHfDGeOS5n9hRvYpHhNtG/ooL5
	Hcp3ZQ3lkyI1jjBw==
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
Message-ID: <176837767996.510.320124134350626992.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     a339671db64b12bb02492557d2b0658811286277
Gitweb:        https://git.kernel.org/tip/a339671db64b12bb02492557d2b06588112=
86277
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 16 Oct 2025 13:51:24 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 14 Jan 2026 08:56:41 +01:00

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

