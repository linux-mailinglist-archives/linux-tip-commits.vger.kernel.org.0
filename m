Return-Path: <linux-tip-commits+bounces-7816-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7528CF4EC0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D80E3011B21
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87234A3D6;
	Mon,  5 Jan 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCdSJOC7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPX86pw1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB43491F3;
	Mon,  5 Jan 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628487; cv=none; b=AI3CXkMYAhfT7bnXqL4/76vHuMJwT+1YxRl4ARDq+L4y3aYMzgkgGq+yoBkI0i0T3ZgAUhsplrvm+bg++V6B4MGoc+8ZHWNgHg31U9uNAjOF/4oBLnh3ph5fwzaXM5L3uhJuEHbgEKzjQuF+K66v9pbM/krMTeyUB3O2FFxVKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628487; c=relaxed/simple;
	bh=GrunBRjZysY3Kjx7PO4D5N05XqvavvVusFjj0PH6IRE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EJpfAA21pZ64Qzot8JsmC2nNMbBRU4v2f0qX2lFuD1C6gWzmWvVg9U+m/MMLEOOI3opDcOAxwyI9omc6DEQ7KzmbXjOwsKVdzzX8MWuM4XamcuDh63Q6qs3YB9stsyhzqXU+aKJ01QOjjJdyk1CTJXEg4xyi2aIHRtQyiAKye6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCdSJOC7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPX86pw1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejzLfDYviWbvL65tchScYWQXA34S2dx6IX23GBV5TY0=;
	b=DCdSJOC7LDFgVYxWhW5YIAGW62sV/i5assAj8KCQ4QtxKv8Rvq5IKQ8bLZpWw2TKI/UXk5
	mImXWQCK5fsURuPZInbB1KY3xaH0kbs1TU0L95IrwINWYAIbrMyc3ZwdxF/ViC9FZp4QjT
	UGgQfpfjZKDBtL11/tieNR8qSoKSTkLuMnHuih/Ar3Q7hhZnuseWTnZ5LmCn+g8Qb0dq9x
	cy+aUWsaBLrF0TKxoBP79TQb1XID1PoR7Px9Nc2TM0IRvmvx6nuPpLhobrU3n6IeY9tdJ4
	NEsDwe8Z317RnGUn3bLyZN3lMld1Fj2poDPfW4f7kHsLO1daXUCJ/e5bQ7R6IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejzLfDYviWbvL65tchScYWQXA34S2dx6IX23GBV5TY0=;
	b=CPX86pw1XtKtvcLyDB5PBUFk64C7XLesdXnUKstoOSUiSKnpyL2qxv8NsOXg5Bvwvh/Mxv
	fznER0ESRygwh0Dw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] cleanup: Basic compatibility with context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-7-elver@google.com>
References: <20251219154418.3592607-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762848191.510.10553727703623467980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3931d4b980398012b66c8ff203bfa2ab3df71a71
Gitweb:        https://git.kernel.org/tip/3931d4b980398012b66c8ff203bfa2ab3df=
71a71
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:28 +01:00

cleanup: Basic compatibility with context analysis

Introduce basic compatibility with cleanup.h infrastructure.

We need to allow the compiler to see the acquisition and release of the
context lock at the start and end of a scope. However, the current
"cleanup" helpers wrap the lock in a struct passed through separate
helper functions, which hides the lock alias from the compiler (no
inter-procedural analysis).

While Clang supports scoped guards in C++, it's not possible to apply in
C code: https://clang.llvm.org/docs/ThreadSafetyAnalysis.html#scoped-context

However, together with recent improvements to Clang's alias analysis
abilities, idioms such as this work correctly now:

        void spin_unlock_cleanup(spinlock_t **l) __releases(*l) { .. }
        ...
        {
            spinlock_t *lock_scope __cleanup(spin_unlock_cleanup) =3D &lock;
            spin_lock(&lock);  // lock through &lock
            ... critical section ...
        }  // unlock through lock_scope -[alias]-> &lock (no warnings)

To generalize this pattern and make it work with existing lock guards,
introduce DECLARE_LOCK_GUARD_1_ATTRS() and WITH_LOCK_GUARD_1_ATTRS().

These allow creating an explicit alias to the context lock instance that
is "cleaned" up with a separate cleanup helper. This helper is a dummy
function that does nothing at runtime, but has the release attributes to
tell the compiler what happens at the end of the scope.

Example usage:

  DECLARE_LOCK_GUARD_1_ATTRS(mutex, __acquires(_T), __releases(*(struct mutex=
 **)_T))
  #define class_mutex_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex, _T)

Note: To support the for-loop based scoped helpers, the auxiliary
variable must be a pointer to the "class" type because it is defined in
the same statement as the guard variable. However, we initialize it with
the lock pointer (despite the type mismatch, the compiler's alias
analysis still works as expected). The "_unlock" attribute receives a
pointer to the auxiliary variable (a double pointer to the class type),
and must be cast and dereferenced appropriately.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-7-elver@google.com
---
 include/linux/cleanup.h | 50 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 8d41b91..ee6df68 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -278,16 +278,21 @@ const volatile void * __must_check_fn(const volatile vo=
id *val)
=20
 #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
 typedef _type class_##_name##_t;					\
+typedef _type lock_##_name##_t;						\
 static __always_inline void class_##_name##_destructor(_type *p)	\
+	__no_context_analysis						\
 { _type _T =3D *p; _exit; }						\
 static __always_inline _type class_##_name##_constructor(_init_args)	\
+	__no_context_analysis						\
 { _type t =3D _init; return t; }
=20
 #define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
+typedef lock_##_name##_t lock_##_name##ext##_t;			\
 typedef class_##_name##_t class_##_name##ext##_t;			\
 static __always_inline void class_##_name##ext##_destructor(class_##_name##_=
t *p) \
 { class_##_name##_destructor(p); }					\
 static __always_inline class_##_name##_t class_##_name##ext##_constructor(_i=
nit_args) \
+	__no_context_analysis \
 { class_##_name##_t t =3D _init; return t; }
=20
 #define CLASS(_name, var)						\
@@ -474,12 +479,14 @@ _label:									\
  */
=20
 #define __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
+typedef _type lock_##_name##_t;						\
 typedef struct {							\
 	_type *lock;							\
 	__VA_ARGS__;							\
 } class_##_name##_t;							\
 									\
 static __always_inline void class_##_name##_destructor(class_##_name##_t *_T=
) \
+	__no_context_analysis						\
 {									\
 	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
@@ -488,6 +495,7 @@ __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
=20
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static __always_inline class_##_name##_t class_##_name##_constructor(_type *=
l) \
+	__no_context_analysis						\
 {									\
 	class_##_name##_t _t =3D { .lock =3D l }, *_T =3D &_t;		\
 	_lock;								\
@@ -496,6 +504,7 @@ static __always_inline class_##_name##_t class_##_name##_=
constructor(_type *l) \
=20
 #define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
 static __always_inline class_##_name##_t class_##_name##_constructor(void) \
+	__no_context_analysis						\
 {									\
 	class_##_name##_t _t =3D { .lock =3D (void*)1 },			\
 			 *_T __maybe_unused =3D &_t;			\
@@ -503,6 +512,47 @@ static __always_inline class_##_name##_t class_##_name##=
_constructor(void) \
 	return _t;							\
 }
=20
+#define DECLARE_LOCK_GUARD_0_ATTRS(_name, _lock, _unlock)		\
+static inline class_##_name##_t class_##_name##_constructor(void) _lock;\
+static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
+
+/*
+ * To support Context Analysis, we need to allow the compiler to see the
+ * acquisition and release of the context lock. However, the "cleanup" helpe=
rs
+ * wrap the lock in a struct passed through separate helper functions, which
+ * hides the lock alias from the compiler (no inter-procedural analysis).
+ *
+ * To make it work, we introduce an explicit alias to the context lock insta=
nce
+ * that is "cleaned" up with a separate cleanup helper. This helper is a dum=
my
+ * function that does nothing at runtime, but has the "_unlock" attribute to
+ * tell the compiler what happens at the end of the scope.
+ *
+ * To generalize the pattern, the WITH_LOCK_GUARD_1_ATTRS() macro should be =
used
+ * to redefine the constructor, which then also creates the alias variable w=
ith
+ * the right "cleanup" attribute, *after* DECLARE_LOCK_GUARD_1_ATTRS() has b=
een
+ * used.
+ *
+ * Example usage:
+ *
+ *   DECLARE_LOCK_GUARD_1_ATTRS(mutex, __acquires(_T), __releases(*(struct m=
utex **)_T))
+ *   #define class_mutex_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
+ *
+ * Note: To support the for-loop based scoped helpers, the auxiliary variable
+ * must be a pointer to the "class" type because it is defined in the same
+ * statement as the guard variable. However, we initialize it with the lock
+ * pointer (despite the type mismatch, the compiler's alias analysis still w=
orks
+ * as expected). The "_unlock" attribute receives a pointer to the auxiliary
+ * variable (a double pointer to the class type), and must be cast and
+ * dereferenced appropriately.
+ */
+#define DECLARE_LOCK_GUARD_1_ATTRS(_name, _lock, _unlock)		\
+static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t=
 *_T) _lock;\
+static __always_inline void __class_##_name##_cleanup_ctx(class_##_name##_t =
**_T) \
+	__no_context_analysis _unlock { }
+#define WITH_LOCK_GUARD_1_ATTRS(_name, _T)				\
+	class_##_name##_constructor(_T),				\
+	*__UNIQUE_ID(unlock) __cleanup(__class_##_name##_cleanup_ctx) =3D (void *)(=
unsigned long)(_T)
+
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
 __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\

