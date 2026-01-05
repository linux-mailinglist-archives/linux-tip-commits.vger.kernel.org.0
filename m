Return-Path: <linux-tip-commits+bounces-7821-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61024CF4A63
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7BB4329263F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980934B196;
	Mon,  5 Jan 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBquRqZ1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9TuU3CPm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BB3148DA;
	Mon,  5 Jan 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628496; cv=none; b=OpTJv9rCCc8rBtMO3TmIFVId2BLEMsjrFU8jf1+cFVZH+rgmILdiN3RR/6Hb96qPttG0QAdX0a7VoP6JoNwI13yzpK9h6kauwIIooMbo8zR7nr7tkwvt8U4XYlqfxvL9WKEDv6Orudk0A9rKafHe//oGtJY2mm6v1X4JhNoMFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628496; c=relaxed/simple;
	bh=pZ8wINW+c0j/LgYVzh+resHXz/ObIqD5bYcdHX7ZpT8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t+AXtr9oADfT2M8MVRdU+hyNAM3n1Qr5x2BQEMrzIENhMYi2qIh08Ibd5sWG5BD5onAXtQwg5totJcM8VYdaNZ1Rw35a5TXLjHdrS1ZqCx9oe58p0F8NhaZNZPGPpJN2Pc+0bNLk7MMb2pVPdvfxm0A24Ozd3Pqfxvauxoin7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBquRqZ1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9TuU3CPm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7H/FnB0F2Kl3j3J073gZ64NsIObtbfulKoCIFZ4DDQ=;
	b=HBquRqZ1i/s6/gWTpm3RhdZIIfLh25yb/uiV8WmfPSxCIAb4w2D+MqHWEIzM4RFPR40dOB
	ww24f+YKjCnYVyIOpLHsCCWIwSH8CJI6StEGnMbYfO+ksa7Qsp7FowJa5yRj5ba9ZG7QoH
	cSuP+uu8bXMUBeD1M+rKRPG4QPTqGGnfLr9pBvmpK9e9rELtX7/xEM9PwCXmjUo5ngPaJb
	Au8n5sRBtEK6UH+9A7Kmft1WqKnkdhsaqZN7dUtBq/4A39P9xnKw0tL2SpEAr8mx7luQoI
	4vDCJMy7MuD6sGbxvtBFWreZsTpTFO5hbMHdhQrelIoUizC9o6SBrMeS4tXpRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7H/FnB0F2Kl3j3J073gZ64NsIObtbfulKoCIFZ4DDQ=;
	b=9TuU3CPmBEY2oCdIIdLP9sseIfoc52lVDOVb1XCI3BcujiMXewcaVVrr9lDeqJhPZpFkKZ
	R613LEtpk6suCtBg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysis: Add infrastructure for
 Context Analysis with Clang
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-3-elver@google.com>
References: <20251219154418.3592607-3-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762848605.510.11476852084469810656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3269701cb25662ae8a9771a864201116626adb50
Gitweb:        https://git.kernel.org/tip/3269701cb25662ae8a9771a864201116626=
adb50
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:26 +01:00

compiler-context-analysis: Add infrastructure for Context Analysis with Clang

Context Analysis is a language extension, which enables statically
checking that required contexts are active (or inactive), by acquiring
and releasing user-definable "context locks". An obvious application is
lock-safety checking for the kernel's various synchronization primitives
(each of which represents a "context lock"), and checking that locking
rules are not violated.

Clang originally called the feature "Thread Safety Analysis" [1]. This
was later changed and the feature became more flexible, gaining the
ability to define custom "capabilities". Its foundations can be found in
"Capability Systems" [2], used to specify the permissibility of
operations to depend on some "capability" being held (or not held).

Because the feature is not just able to express "capabilities" related
to synchronization primitives, and "capability" is already overloaded in
the kernel, the naming chosen for the kernel departs from Clang's
"Thread Safety" and "capability" nomenclature; we refer to the feature
as "Context Analysis" to avoid confusion. The internal implementation
still makes references to Clang's terminology in a few places, such as
`-Wthread-safety` being the warning option that also still appears in
diagnostic messages.

 [1] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
 [2] https://www.cs.cornell.edu/talc/papers/capabilities.pdf

See more details in the kernel-doc documentation added in this and
subsequent changes.

Clang version 22+ is required.

[peterz: disable the thing for __CHECKER__ builds]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-3-elver@google.com
---
 Makefile                                  |   1 +-
 include/linux/compiler-context-analysis.h | 464 ++++++++++++++++++++-
 lib/Kconfig.debug                         |  30 +-
 scripts/Makefile.context-analysis         |   7 +-
 scripts/Makefile.lib                      |  10 +-
 5 files changed, 505 insertions(+), 7 deletions(-)
 create mode 100644 scripts/Makefile.context-analysis

diff --git a/Makefile b/Makefile
index e404e47..d4c2aa2 100644
--- a/Makefile
+++ b/Makefile
@@ -1118,6 +1118,7 @@ include-$(CONFIG_RANDSTRUCT)	+=3D scripts/Makefile.rand=
struct
 include-$(CONFIG_KSTACK_ERASE)	+=3D scripts/Makefile.kstack_erase
 include-$(CONFIG_AUTOFDO_CLANG)	+=3D scripts/Makefile.autofdo
 include-$(CONFIG_PROPELLER_CLANG)	+=3D scripts/Makefile.propeller
+include-$(CONFIG_WARN_CONTEXT_ANALYSIS) +=3D scripts/Makefile.context-analys=
is
 include-$(CONFIG_GCC_PLUGINS)	+=3D scripts/Makefile.gcc-plugins
=20
 include $(addprefix $(srctree)/, $(include-y))
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compil=
er-context-analysis.h
index f8af630..d0b3cf0 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -6,27 +6,477 @@
 #ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
 #define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
=20
+#if defined(WARN_CONTEXT_ANALYSIS) && !defined(__CHECKER__)
+
+/*
+ * These attributes define new context lock (Clang: capability) types.
+ * Internal only.
+ */
+# define __ctx_lock_type(name)			__attribute__((capability(#name)))
+# define __reentrant_ctx_lock			__attribute__((reentrant_capability))
+# define __acquires_ctx_lock(...)		__attribute__((acquire_capability(__VA_AR=
GS__)))
+# define __acquires_shared_ctx_lock(...)	__attribute__((acquire_shared_capab=
ility(__VA_ARGS__)))
+# define __try_acquires_ctx_lock(ret, var)	__attribute__((try_acquire_capabi=
lity(ret, var)))
+# define __try_acquires_shared_ctx_lock(ret, var) __attribute__((try_acquire=
_shared_capability(ret, var)))
+# define __releases_ctx_lock(...)		__attribute__((release_capability(__VA_AR=
GS__)))
+# define __releases_shared_ctx_lock(...)	__attribute__((release_shared_capab=
ility(__VA_ARGS__)))
+# define __returns_ctx_lock(var)		__attribute__((lock_returned(var)))
+
+/*
+ * The below are used to annotate code being checked. Internal only.
+ */
+# define __excludes_ctx_lock(...)		__attribute__((locks_excluded(__VA_ARGS__=
)))
+# define __requires_ctx_lock(...)		__attribute__((requires_capability(__VA_A=
RGS__)))
+# define __requires_shared_ctx_lock(...)	__attribute__((requires_shared_capa=
bility(__VA_ARGS__)))
+
+/*
+ * The "assert_capability" attribute is a bit confusingly named. It does not
+ * generate a check. Instead, it tells the analysis to *assume* the capabili=
ty
+ * is held. This is used for:
+ *
+ * 1. Augmenting runtime assertions, that can then help with patterns beyond=
 the
+ *    compiler's static reasoning abilities.
+ *
+ * 2. Initialization of context locks, so we can access guarded variables ri=
ght
+ *    after initialization (nothing else should access the same object yet).
+ */
+# define __assumes_ctx_lock(...)		__attribute__((assert_capability(__VA_ARGS=
__)))
+# define __assumes_shared_ctx_lock(...)	__attribute__((assert_shared_capabil=
ity(__VA_ARGS__)))
+
+/**
+ * __guarded_by - struct member and globals attribute, declares variable
+ *                only accessible within active context
+ *
+ * Declares that the struct member or global variable is only accessible wit=
hin
+ * the context entered by the given context lock. Read operations on the data
+ * require shared access, while write operations require exclusive access.
+ *
+ * .. code-block:: c
+ *
+ *	struct some_state {
+ *		spinlock_t lock;
+ *		long counter __guarded_by(&lock);
+ *	};
+ */
+# define __guarded_by(...)		__attribute__((guarded_by(__VA_ARGS__)))
+
+/**
+ * __pt_guarded_by - struct member and globals attribute, declares pointed-to
+ *                   data only accessible within active context
+ *
+ * Declares that the data pointed to by the struct member pointer or global
+ * pointer is only accessible within the context entered by the given context
+ * lock. Read operations on the data require shared access, while write
+ * operations require exclusive access.
+ *
+ * .. code-block:: c
+ *
+ *	struct some_state {
+ *		spinlock_t lock;
+ *		long *counter __pt_guarded_by(&lock);
+ *	};
+ */
+# define __pt_guarded_by(...)		__attribute__((pt_guarded_by(__VA_ARGS__)))
+
+/**
+ * context_lock_struct() - declare or define a context lock struct
+ * @name: struct name
+ *
+ * Helper to declare or define a struct type that is also a context lock.
+ *
+ * .. code-block:: c
+ *
+ *	context_lock_struct(my_handle) {
+ *		int foo;
+ *		long bar;
+ *	};
+ *
+ *	struct some_state {
+ *		...
+ *	};
+ *	// ... declared elsewhere ...
+ *	context_lock_struct(some_state);
+ *
+ * Note: The implementation defines several helper functions that can acquire
+ * and release the context lock.
+ */
+# define context_lock_struct(name, ...)									\
+	struct __ctx_lock_type(name) __VA_ARGS__ name;							\
+	static __always_inline void __acquire_ctx_lock(const struct name *var)				\
+		__attribute__((overloadable)) __no_context_analysis __acquires_ctx_lock(va=
r) { }	\
+	static __always_inline void __acquire_shared_ctx_lock(const struct name *va=
r)			\
+		__attribute__((overloadable)) __no_context_analysis __acquires_shared_ctx_=
lock(var) { } \
+	static __always_inline bool __try_acquire_ctx_lock(const struct name *var, =
bool ret)		\
+		__attribute__((overloadable)) __no_context_analysis __try_acquires_ctx_loc=
k(1, var)	\
+	{ return ret; }											\
+	static __always_inline bool __try_acquire_shared_ctx_lock(const struct name=
 *var, bool ret)	\
+		__attribute__((overloadable)) __no_context_analysis __try_acquires_shared_=
ctx_lock(1, var) \
+	{ return ret; }											\
+	static __always_inline void __release_ctx_lock(const struct name *var)				\
+		__attribute__((overloadable)) __no_context_analysis __releases_ctx_lock(va=
r) { }	\
+	static __always_inline void __release_shared_ctx_lock(const struct name *va=
r)			\
+		__attribute__((overloadable)) __no_context_analysis __releases_shared_ctx_=
lock(var) { } \
+	static __always_inline void __assume_ctx_lock(const struct name *var)				\
+		__attribute__((overloadable)) __assumes_ctx_lock(var) { }				\
+	static __always_inline void __assume_shared_ctx_lock(const struct name *var=
)			\
+		__attribute__((overloadable)) __assumes_shared_ctx_lock(var) { }			\
+	struct name
+
+/**
+ * disable_context_analysis() - disables context analysis
+ *
+ * Disables context analysis. Must be paired with a later
+ * enable_context_analysis().
+ */
+# define disable_context_analysis()				\
+	__diag_push();						\
+	__diag_ignore_all("-Wunknown-warning-option", "")	\
+	__diag_ignore_all("-Wthread-safety", "")		\
+	__diag_ignore_all("-Wthread-safety-pointer", "")
+
+/**
+ * enable_context_analysis() - re-enables context analysis
+ *
+ * Re-enables context analysis. Must be paired with a prior
+ * disable_context_analysis().
+ */
+# define enable_context_analysis() __diag_pop()
+
+/**
+ * __no_context_analysis - function attribute, disables context analysis
+ *
+ * Function attribute denoting that context analysis is disabled for the
+ * whole function. Prefer use of `context_unsafe()` where possible.
+ */
+# define __no_context_analysis	__attribute__((no_thread_safety_analysis))
+
+#else /* !WARN_CONTEXT_ANALYSIS */
+
+# define __ctx_lock_type(name)
+# define __reentrant_ctx_lock
+# define __acquires_ctx_lock(...)
+# define __acquires_shared_ctx_lock(...)
+# define __try_acquires_ctx_lock(ret, var)
+# define __try_acquires_shared_ctx_lock(ret, var)
+# define __releases_ctx_lock(...)
+# define __releases_shared_ctx_lock(...)
+# define __assumes_ctx_lock(...)
+# define __assumes_shared_ctx_lock(...)
+# define __returns_ctx_lock(var)
+# define __guarded_by(...)
+# define __pt_guarded_by(...)
+# define __excludes_ctx_lock(...)
+# define __requires_ctx_lock(...)
+# define __requires_shared_ctx_lock(...)
+# define __acquire_ctx_lock(var)			do { } while (0)
+# define __acquire_shared_ctx_lock(var)		do { } while (0)
+# define __try_acquire_ctx_lock(var, ret)		(ret)
+# define __try_acquire_shared_ctx_lock(var, ret)	(ret)
+# define __release_ctx_lock(var)			do { } while (0)
+# define __release_shared_ctx_lock(var)		do { } while (0)
+# define __assume_ctx_lock(var)			do { (void)(var); } while (0)
+# define __assume_shared_ctx_lock(var)			do { (void)(var); } while (0)
+# define context_lock_struct(name, ...)		struct __VA_ARGS__ name
+# define disable_context_analysis()
+# define enable_context_analysis()
+# define __no_context_analysis
+
+#endif /* WARN_CONTEXT_ANALYSIS */
+
+/**
+ * context_unsafe() - disable context checking for contained code
+ *
+ * Disables context checking for contained statements or expression.
+ *
+ * .. code-block:: c
+ *
+ *	struct some_data {
+ *		spinlock_t lock;
+ *		int counter __guarded_by(&lock);
+ *	};
+ *
+ *	int foo(struct some_data *d)
+ *	{
+ *		// ...
+ *		// other code that is still checked ...
+ *		// ...
+ *		return context_unsafe(d->counter);
+ *	}
+ */
+#define context_unsafe(...)		\
+({					\
+	disable_context_analysis();	\
+	__VA_ARGS__;			\
+	enable_context_analysis()	\
+})
+
+/**
+ * __context_unsafe() - function attribute, disable context checking
+ * @comment: comment explaining why opt-out is safe
+ *
+ * Function attribute denoting that context analysis is disabled for the
+ * whole function. Forces adding an inline comment as argument.
+ */
+#define __context_unsafe(comment) __no_context_analysis
+
+/**
+ * context_unsafe_alias() - helper to insert a context lock "alias barrier"
+ * @p: pointer aliasing a context lock or object containing context locks
+ *
+ * No-op function that acts as a "context lock alias barrier", where the
+ * analysis rightfully detects that we're switching aliases, but the switch =
is
+ * considered safe but beyond the analysis reasoning abilities.
+ *
+ * This should be inserted before the first use of such an alias.
+ *
+ * Implementation Note: The compiler ignores aliases that may be reassigned =
but
+ * their value cannot be determined (e.g. when passing a non-const pointer t=
o an
+ * alias as a function argument).
+ */
+#define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p))
+static inline void _context_unsafe_alias(void **p) { }
+
+/**
+ * token_context_lock() - declare an abstract global context lock instance
+ * @name: token context lock name
+ *
+ * Helper that declares an abstract global context lock instance @name, but =
not
+ * backed by a real data structure (linker error if accidentally referenced).
+ * The type name is `__ctx_lock_@name`.
+ */
+#define token_context_lock(name, ...)					\
+	context_lock_struct(__ctx_lock_##name, ##__VA_ARGS__) {};	\
+	extern const struct __ctx_lock_##name *name
+
+/**
+ * token_context_lock_instance() - declare another instance of a global cont=
ext lock
+ * @ctx: token context lock previously declared with token_context_lock()
+ * @name: name of additional global context lock instance
+ *
+ * Helper that declares an additional instance @name of the same token conte=
xt
+ * lock class @ctx. This is helpful where multiple related token contexts are
+ * declared, to allow using the same underlying type (`__ctx_lock_@ctx`) as
+ * function arguments.
+ */
+#define token_context_lock_instance(ctx, name)		\
+	extern const struct __ctx_lock_##ctx *name
+
+/*
+ * Common keywords for static context analysis. Both Clang's "capability
+ * analysis" and Sparse's "context tracking" are currently supported.
+ */
 #ifdef __CHECKER__
=20
 /* Sparse context/lock checking support. */
 # define __must_hold(x)		__attribute__((context(x,1,1)))
+# define __must_not_hold(x)
 # define __acquires(x)		__attribute__((context(x,0,1)))
 # define __cond_acquires(x)	__attribute__((context(x,0,-1)))
 # define __releases(x)		__attribute__((context(x,1,0)))
 # define __acquire(x)		__context__(x,1)
 # define __release(x)		__context__(x,-1)
 # define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
+/* For Sparse, there's no distinction between exclusive and shared locks. */
+# define __must_hold_shared	__must_hold
+# define __acquires_shared	__acquires
+# define __cond_acquires_shared __cond_acquires
+# define __releases_shared	__releases
+# define __acquire_shared	__acquire
+# define __release_shared	__release
+# define __cond_lock_shared	__cond_acquire
=20
 #else /* !__CHECKER__ */
=20
-# define __must_hold(x)
-# define __acquires(x)
-# define __cond_acquires(x)
-# define __releases(x)
-# define __acquire(x)		(void)0
-# define __release(x)		(void)0
-# define __cond_lock(x, c)	(c)
+/**
+ * __must_hold() - function attribute, caller must hold exclusive context lo=
ck
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the caller must hold the given context
+ * lock instance @x exclusively.
+ */
+# define __must_hold(x)		__requires_ctx_lock(x)
+
+/**
+ * __must_not_hold() - function attribute, caller must not hold context lock
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the caller must not hold the given cont=
ext
+ * lock instance @x.
+ */
+# define __must_not_hold(x)	__excludes_ctx_lock(x)
+
+/**
+ * __acquires() - function attribute, function acquires context lock exclusi=
vely
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the function acquires the given context
+ * lock instance @x exclusively, but does not release it.
+ */
+# define __acquires(x)		__acquires_ctx_lock(x)
+
+/**
+ * __cond_acquires() - function attribute, function conditionally
+ *                     acquires a context lock exclusively
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the function conditionally acquires the
+ * given context lock instance @x exclusively, but does not release it.
+ */
+# define __cond_acquires(x)	__try_acquires_ctx_lock(1, x)
+
+/**
+ * __releases() - function attribute, function releases a context lock exclu=
sively
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the function releases the given context
+ * lock instance @x exclusively. The associated context must be active on
+ * entry.
+ */
+# define __releases(x)		__releases_ctx_lock(x)
+
+/**
+ * __acquire() - function to acquire context lock exclusively
+ * @x: context lock instance pointer
+ *
+ * No-op function that acquires the given context lock instance @x exclusive=
ly.
+ */
+# define __acquire(x)		__acquire_ctx_lock(x)
+
+/**
+ * __release() - function to release context lock exclusively
+ * @x: context lock instance pointer
+ *
+ * No-op function that releases the given context lock instance @x.
+ */
+# define __release(x)		__release_ctx_lock(x)
+
+/**
+ * __cond_lock() - function that conditionally acquires a context lock
+ *                 exclusively
+ * @x: context lock instance pinter
+ * @c: boolean expression
+ *
+ * Return: result of @c
+ *
+ * No-op function that conditionally acquires context lock instance @x
+ * exclusively, if the boolean expression @c is true. The result of @c is the
+ * return value; for example:
+ *
+ * .. code-block:: c
+ *
+ *	#define spin_trylock(l) __cond_lock(&lock, _spin_trylock(&lock))
+ */
+# define __cond_lock(x, c)	__try_acquire_ctx_lock(x, c)
+
+/**
+ * __must_hold_shared() - function attribute, caller must hold shared contex=
t lock
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the caller must hold the given context
+ * lock instance @x with shared access.
+ */
+# define __must_hold_shared(x)	__requires_shared_ctx_lock(x)
+
+/**
+ * __acquires_shared() - function attribute, function acquires context lock =
shared
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the function acquires the given
+ * context lock instance @x with shared access, but does not release it.
+ */
+# define __acquires_shared(x)	__acquires_shared_ctx_lock(x)
+
+/**
+ * __cond_acquires_shared() - function attribute, function conditionally
+ *                            acquires a context lock shared
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the function conditionally acquires the
+ * given context lock instance @x with shared access, but does not release i=
t.
+ */
+# define __cond_acquires_shared(x) __try_acquires_shared_ctx_lock(1, x)
+
+/**
+ * __releases_shared() - function attribute, function releases a
+ *                       context lock shared
+ * @x: context lock instance pointer
+ *
+ * Function attribute declaring that the function releases the given context
+ * lock instance @x with shared access. The associated context must be active
+ * on entry.
+ */
+# define __releases_shared(x)	__releases_shared_ctx_lock(x)
+
+/**
+ * __acquire_shared() - function to acquire context lock shared
+ * @x: context lock instance pointer
+ *
+ * No-op function that acquires the given context lock instance @x with shar=
ed
+ * access.
+ */
+# define __acquire_shared(x)	__acquire_shared_ctx_lock(x)
+
+/**
+ * __release_shared() - function to release context lock shared
+ * @x: context lock instance pointer
+ *
+ * No-op function that releases the given context lock instance @x with shar=
ed
+ * access.
+ */
+# define __release_shared(x)	__release_shared_ctx_lock(x)
+
+/**
+ * __cond_lock_shared() - function that conditionally acquires a context loc=
k shared
+ * @x: context lock instance pinter
+ * @c: boolean expression
+ *
+ * Return: result of @c
+ *
+ * No-op function that conditionally acquires context lock instance @x with
+ * shared access, if the boolean expression @c is true. The result of @c is =
the
+ * return value.
+ */
+# define __cond_lock_shared(x, c) __try_acquire_shared_ctx_lock(x, c)
=20
 #endif /* __CHECKER__ */
=20
+/**
+ * __acquire_ret() - helper to acquire context lock of return value
+ * @call: call expression
+ * @ret_expr: acquire expression that uses __ret
+ */
+#define __acquire_ret(call, ret_expr)		\
+	({					\
+		__auto_type __ret =3D call;	\
+		__acquire(ret_expr);		\
+		__ret;				\
+	})
+
+/**
+ * __acquire_shared_ret() - helper to acquire context lock shared of return =
value
+ * @call: call expression
+ * @ret_expr: acquire shared expression that uses __ret
+ */
+#define __acquire_shared_ret(call, ret_expr)	\
+	({					\
+		__auto_type __ret =3D call;	\
+		__acquire_shared(ret_expr);	\
+		__ret;				\
+	})
+
+/*
+ * Attributes to mark functions returning acquired context locks.
+ *
+ * This is purely cosmetic to help readability, and should be used with the
+ * above macros as follows:
+ *
+ *   struct foo { spinlock_t lock; ... };
+ *   ...
+ *   #define myfunc(...) __acquire_ret(_myfunc(__VA_ARGS__), &__ret->lock)
+ *   struct foo *_myfunc(int bar) __acquires_ret;
+ *   ...
+ */
+#define __acquires_ret		__no_context_analysis
+#define __acquires_shared_ret	__no_context_analysis
+
 #endif /* _LINUX_COMPILER_CONTEXT_ANALYSIS_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939..cd557e7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -621,6 +621,36 @@ config DEBUG_FORCE_WEAK_PER_CPU
 	  To ensure that generic code follows the above rules, this
 	  option forces all percpu variables to be defined as weak.
=20
+config WARN_CONTEXT_ANALYSIS
+	bool "Compiler context-analysis warnings"
+	depends on CC_IS_CLANG && CLANG_VERSION >=3D 220000
+	# Branch profiling re-defines "if", which messes with the compiler's
+	# ability to analyze __cond_acquires(..), resulting in false positives.
+	depends on !TRACE_BRANCH_PROFILING
+	default y
+	help
+	  Context Analysis is a language extension, which enables statically
+	  checking that required contexts are active (or inactive) by acquiring
+	  and releasing user-definable "context locks".
+
+	  Clang's name of the feature is "Thread Safety Analysis". Requires
+	  Clang 22 or later.
+
+	  Produces warnings by default. Select CONFIG_WERROR if you wish to
+	  turn these warnings into errors.
+
+	  For more details, see Documentation/dev-tools/context-analysis.rst.
+
+config WARN_CONTEXT_ANALYSIS_ALL
+	bool "Enable context analysis for all source files"
+	depends on WARN_CONTEXT_ANALYSIS
+	depends on EXPERT && !COMPILE_TEST
+	help
+	  Enable tree-wide context analysis. This is likely to produce a
+	  large number of false positives - enable at your own risk.
+
+	  If unsure, say N.
+
 endmenu # "Compiler options"
=20
 menu "Generic Kernel Debugging Instruments"
diff --git a/scripts/Makefile.context-analysis b/scripts/Makefile.context-ana=
lysis
new file mode 100644
index 0000000..70549f7
--- /dev/null
+++ b/scripts/Makefile.context-analysis
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+context-analysis-cflags :=3D -DWARN_CONTEXT_ANALYSIS		\
+	-fexperimental-late-parse-attributes -Wthread-safety	\
+	-Wthread-safety-pointer -Wthread-safety-beta
+
+export CFLAGS_CONTEXT_ANALYSIS :=3D $(context-analysis-cflags)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 28a1c08..e429d68 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -106,6 +106,16 @@ _c_flags +=3D $(if $(patsubst n%,, \
 endif
=20
 #
+# Enable context analysis flags only where explicitly opted in.
+# (depends on variables CONTEXT_ANALYSIS_obj.o, CONTEXT_ANALYSIS)
+#
+ifeq ($(CONFIG_WARN_CONTEXT_ANALYSIS),y)
+_c_flags +=3D $(if $(patsubst n%,, \
+		$(CONTEXT_ANALYSIS_$(target-stem).o)$(CONTEXT_ANALYSIS)$(if $(is-kernel-ob=
ject),$(CONFIG_WARN_CONTEXT_ANALYSIS_ALL))), \
+		$(CFLAGS_CONTEXT_ANALYSIS))
+endif
+
+#
 # Enable AutoFDO build flags except some files or directories we don't want =
to
 # enable (depends on variables AUTOFDO_PROFILE_obj.o and AUTOFDO_PROFILE).
 #

