Return-Path: <linux-tip-commits+bounces-7174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AAAC2C7A4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 15:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3450A4F3C30
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6379030F52B;
	Mon,  3 Nov 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c8U+pp2v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovmwQv7S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987E2FD68D;
	Mon,  3 Nov 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181230; cv=none; b=kQr/yk4QKOhDO2XqhHclxwAI4R9n9o34gtogte9LDr/1HNM/PpmuHosjiFZ7Wr4UUhlYMcEUlmhptT9OHytctHHnt2JW7eYds3WwvOPYeaQ1vEZwj3707GY0GvR9SbT7pR4pXM19UNWr4ETQFbae2jT7VAOKiXvusHznRppb5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181230; c=relaxed/simple;
	bh=M2Ppni8i9Or8LKgEuAXExLFAoofQuLrtuxGlk80sHQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uhhr/YcxS61+vhnvCWdM8YJVKS/9KOzWQyPptlSlIgOo9Mn4KFLLV+6fdHs33dVlrDMwHKDoENU7RQ9e8MC7ClYlJR1MyycISQJZAbAiVdZgXiWl6ama4imFkOUbHijs3Pc6mBUmlEZzV3RWhgRJlfdb/26AGxTTKd80BjglUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c8U+pp2v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovmwQv7S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k34H0iMw5mt7tQdh/ZwRwYWtWMj/zapNmQr02dAvCPo=;
	b=c8U+pp2v6dbPVezQWx8Kifk4qLYRQ8wNF7Ug8oQBgl3zjmUEbSIS67DtAMW1r270GAwjmB
	lL7zqcpSWLcYagn8w4Xk9NVeihBRaeExe2jqGbdPIRL4atyjXN/ZdLwglNTUcHnw/PA3f5
	pbkKd1vRtsK1FB5uhMTCUvI6P2PDzDsQ+e0iPKUCFp0ZMWSc5DwocvBrkH9572REF7RL0c
	pHb+xOy5OGwlVir7J2uyPTxXG96YA6mEdTPxO9YWOPlSXQRYJa77deopGoMTghzH0qEtjd
	lFz4m+YIrxhYEkWzgRUN+O32FnKjR51+LtSW4CekoSPib3zccMTftKP3/pYPpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k34H0iMw5mt7tQdh/ZwRwYWtWMj/zapNmQr02dAvCPo=;
	b=ovmwQv7SY5a2XblDlauXI2Ar4x3VokuPAaS0ibselKKm8OWcGahzAlWLuescWayhQcTyXg
	+Met56rDms/q6vDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] cleanup: Always inline everything
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031105435.GU4068168@noisy.programming.kicks-ass.net>
References: <20251031105435.GU4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218122498.2601451.8523201903367394724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     cb1c1678a082df8c1ff50430439ddfd3e4ad87db
Gitweb:        https://git.kernel.org/tip/cb1c1678a082df8c1ff50430439ddfd3e4a=
d87db
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 31 Oct 2025 12:02:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:23 +01:00

cleanup: Always inline everything

KASAN bloat caused cleanup helper functions to not get inlined:

  vmlinux.o: error: objtool: irqentry_exit+0x323: call to class_user_rw_acces=
s_destructor() with UACCESS enabled

Force inline all the cleanup helpers like they already are on normal
builds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251031105435.GU4068168@noisy.programming.kic=
ks-ass.net
---
 include/linux/cleanup.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585..d1806ac 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -208,7 +208,7 @@
  */
=20
 #define DEFINE_FREE(_name, _type, _free) \
-	static inline void __free_##_name(void *p) { _type _T =3D *(_type *)p; _fre=
e; }
+	static __always_inline void __free_##_name(void *p) { _type _T =3D *(_type =
*)p; _free; }
=20
 #define __free(_name)	__cleanup(__free_##_name)
=20
@@ -220,7 +220,7 @@
 		__val;                      \
 	})
=20
-static inline __must_check
+static __always_inline __must_check
 const volatile void * __must_check_fn(const volatile void *val)
 { return val; }
=20
@@ -274,16 +274,16 @@ const volatile void * __must_check_fn(const volatile vo=
id *val)
=20
 #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
 typedef _type class_##_name##_t;					\
-static inline void class_##_name##_destructor(_type *p)			\
+static __always_inline void class_##_name##_destructor(_type *p)	\
 { _type _T =3D *p; _exit; }						\
-static inline _type class_##_name##_constructor(_init_args)		\
+static __always_inline _type class_##_name##_constructor(_init_args)	\
 { _type t =3D _init; return t; }
=20
 #define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
 typedef class_##_name##_t class_##_name##ext##_t;			\
-static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
+static __always_inline void class_##_name##ext##_destructor(class_##_name##_=
t *p) \
 { class_##_name##_destructor(p); }					\
-static inline class_##_name##_t class_##_name##ext##_constructor(_init_args)=
 \
+static __always_inline class_##_name##_t class_##_name##ext##_constructor(_i=
nit_args) \
 { class_##_name##_t t =3D _init; return t; }
=20
 #define CLASS(_name, var)						\
@@ -347,7 +347,7 @@ static __maybe_unused const bool class_##_name##_is_condi=
tional =3D _is_cond
 	})
=20
 #define __DEFINE_GUARD_LOCK_PTR(_name, _exp)                                \
-	static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	static __always_inline void *class_##_name##_lock_ptr(class_##_name##_t *_T=
) \
 	{                                                                   \
 		void *_ptr =3D (void *)(__force unsigned long)*(_exp);        \
 		if (IS_ERR(_ptr)) {                                         \
@@ -355,7 +355,7 @@ static __maybe_unused const bool class_##_name##_is_condi=
tional =3D _is_cond
 		}                                                           \
 		return _ptr;                                                \
 	}                                                                   \
-	static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
+	static __always_inline int class_##_name##_lock_err(class_##_name##_t *_T) \
 	{                                                                   \
 		long _rc =3D (__force unsigned long)*(_exp);                  \
 		if (!_rc) {                                                 \
@@ -384,9 +384,9 @@ static __maybe_unused const bool class_##_name##_is_condi=
tional =3D _is_cond
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t =3D _T; int _RET =3D (_lock); if (_T && !(_cond)) _t =3D =
ERR_PTR(_RET); _t; }), \
 		     class_##_name##_t _T) \
-	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	static __always_inline void * class_##_name##_ext##_lock_ptr(class_##_name#=
#_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); } \
-	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	static __always_inline int class_##_name##_ext##_lock_err(class_##_name##_t=
 *_T) \
 	{ return class_##_name##_lock_err(_T); }
=20
 /*
@@ -466,7 +466,7 @@ typedef struct {							\
 	__VA_ARGS__;							\
 } class_##_name##_t;							\
 									\
-static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+static __always_inline void class_##_name##_destructor(class_##_name##_t *_T=
) \
 {									\
 	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
@@ -474,7 +474,7 @@ static inline void class_##_name##_destructor(class_##_na=
me##_t *_T)	\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
=20
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
-static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+static __always_inline class_##_name##_t class_##_name##_constructor(_type *=
l) \
 {									\
 	class_##_name##_t _t =3D { .lock =3D l }, *_T =3D &_t;		\
 	_lock;								\
@@ -482,7 +482,7 @@ static inline class_##_name##_t class_##_name##_construct=
or(_type *l)	\
 }
=20
 #define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
-static inline class_##_name##_t class_##_name##_constructor(void)	\
+static __always_inline class_##_name##_t class_##_name##_constructor(void) \
 {									\
 	class_##_name##_t _t =3D { .lock =3D (void*)1 },			\
 			 *_T __maybe_unused =3D &_t;			\
@@ -508,9 +508,9 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 		        if (_T->lock && !(_cond)) _T->lock =3D ERR_PTR(_RET);\
 			_t; }),						\
 		     typeof_member(class_##_name##_t, lock) l)		\
-	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	static __always_inline void * class_##_name##_ext##_lock_ptr(class_##_name#=
#_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); } \
-	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	static __always_inline int class_##_name##_ext##_lock_err(class_##_name##_t=
 *_T) \
 	{ return class_##_name##_lock_err(_T); }
=20
 #define DEFINE_LOCK_GUARD_1_COND_3(_name, _ext, _lock) \

