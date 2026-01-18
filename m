Return-Path: <linux-tip-commits+bounces-8044-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41241D39387
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17B64300C169
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82663280332;
	Sun, 18 Jan 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTmSDUiq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PN8WI8mj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3114246797;
	Sun, 18 Jan 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768729130; cv=none; b=cq0NbUF8eJjaRqMCn2CkLwe7TSpz06W25Cv3zh9J7XvG9OeT/ljoRk8E65ZP4qPUC8S+xAOiuIiQPE0P90JJVCh/0Lk2fXg8pF8EXIoE38jN7vQsJTGOHpD0MwgaO3Y91w3+uzll2w6JP9/qOSuIr+s998GLb9fuec5x7mmbHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768729130; c=relaxed/simple;
	bh=iBYaD5QYYMZ/NYgPc0PZOH3ctySMYy1f4x3KSyLoSW8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jypBoi5TZdnDGdK6/fcyeZLa283FDRNh0ZuzLM/7g1FLNIQxtQYgwDS1YWhdYSdI4/WA9McCvFOzI0KLD3nuPqWgRoNSYRJ5XJNmpntS94uB+gA+qabQrDMj5rjaJ9D+lBz7xKaJIgbWguddJh4RLi1ZjKk533ZnQO0WUb7dmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTmSDUiq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PN8WI8mj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 09:38:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768729127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEdB9bPRQkh8QU0xoMpie0tPIr1ck8jORO7chKkuvuo=;
	b=MTmSDUiqa9cs/IW9341T3Fv5pZacPQDSbuE38nFjXJuEJXDIUzsuyfJvtgAJBpB1yvlq47
	UsWrdiukxl/QZai58QHX6xovveCx8TiE4KE5eIs/RqU5izJVF7AznSVO6RC60VlYMc0mty
	7/3iB+OWVzh5QDfXTjGTvxMxe7tQZ4jVwQGHo0yZoFGKSBdRDHOPNzRK49U7awJ5eaeiiV
	I0UsZcYPOaAkmQSY5ovDLqCumbyoRUjolwKAXf3EWNmsDAJ4/PhJwYVQQCMpPRLHxjZnx8
	DP61QJNjfnD98zC8KpckHyHtm57mPvxvFc5LPAOxSXVUz8PbFUkC5ppYmq35zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768729127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEdB9bPRQkh8QU0xoMpie0tPIr1ck8jORO7chKkuvuo=;
	b=PN8WI8mjXY/OwTKDFKzikrcae+tr7kFGTvkq2UaLbnLh2pKTu12T7QPOirZRpg/kJpZ60w
	dgDwBovucKFoHsDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] compiler: Use __typeof_unqual__() for
 __unqual_scalar_typeof()
Cc: kernel test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87ecnp2zh3.ffs@tglx>
References: <87ecnp2zh3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176872912167.510.13694419473186865047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     fd69b2f7d5f4e1d89cea4cdfa6f15e7fa53d8358
Gitweb:        https://git.kernel.org/tip/fd69b2f7d5f4e1d89cea4cdfa6f15e7fa53=
d8358
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 16 Jan 2026 19:18:16 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 10:32:03 +01:00

compiler: Use __typeof_unqual__() for __unqual_scalar_typeof()

The recent changes to get_unaligned() resulted in a new sparse warning:

   net/rds/ib_cm.c:96:35: sparse: sparse: incorrect type in argument 1 (diffe=
rent modifiers) @@     expected void * @@     got restricted __be64 const * @@
   net/rds/ib_cm.c:96:35: sparse:     expected void *
   net/rds/ib_cm.c:96:35: sparse:     got restricted __be64 const *

The updated get_unaligned_t() uses __unqual_scalar_typeof() to get an
unqualified type. This works correctly for the compilers, but fails for
sparse when the data type is __be64 (or any other __beNN variant).

On sparse runs (C=3D[12]) __beNN types are annotated with
__attribute__((bitwise)).

That annotation allows sparse to detect incompatible operations on __beNN
variables, but it also prevents sparse from evaluating the _Generic() in
__unqual_scalar_typeof() and map __beNN to a unqualified scalar type, so it
ends up with the default, i.e. the original qualified type of a 'const
__beNN' pointer. That then ends up as the first pointer argument to
builtin_memcpy(), which obviously causes the above sparse warnings.

The sparse git tree supports typeof_unqual() now, which allows to use it
instead of the _Generic() based __unqual_scalar_typeof(). With that sparse
correctly evaluates the unqualified type and keeps the __beNN logic intact.

The downside is that this requires a top of tree sparse build and an old
sparse version will emit a metric ton of incomprehensible error messages
before it dies with a segfault.

Therefore implement a sanity check which validates that the checker is
available and capable of handling typeof_unqual(). Emit a warning if not so
the user can take informed action.

[ tglx: Move the evaluation of USE_TYPEOF_UNQUAL to compiler_types.h so it is
  	set before use and implement the sanity checker ]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://patch.msgid.link/87ecnp2zh3.ffs@tglx
Closes: https://lore.kernel.org/oe-kbuild-all/202601150001.sKSN644a-lkp@intel=
.com/
---
 Makefile                       |  8 ++++++++
 include/linux/compiler.h       | 10 ----------
 include/linux/compiler_types.h | 13 +++++++++++++
 scripts/checker-valid.sh       | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+), 10 deletions(-)
 create mode 100755 scripts/checker-valid.sh

diff --git a/Makefile b/Makefile
index 9d38125..179c9d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1187,6 +1187,14 @@ CHECKFLAGS +=3D $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig-en=
dian,-mlittle-endian)
 # the checker needs the correct machine size
 CHECKFLAGS +=3D $(if $(CONFIG_64BIT),-m64,-m32)
=20
+# Validate the checker is available and functional
+ifneq ($(KBUILD_CHECKSRC), 0)
+  ifneq ($(shell $(srctree)/scripts/checker-valid.sh $(CHECK) $(CHECKFLAGS))=
, 1)
+    $(warning C=3D$(KBUILD_CHECKSRC) specified, but $(CHECK) is not availabl=
e or not up to date)
+    KBUILD_CHECKSRC =3D 0
+  endif
+endif
+
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the command line or
 # set in the environment
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 04487c9..c601222 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -231,16 +231,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, =
int val,
 				"must be non-C-string (not NUL-terminated)")
=20
 /*
- * Use __typeof_unqual__() when available.
- *
- * XXX: Remove test for __CHECKER__ once
- * sparse learns about __typeof_unqual__().
- */
-#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
-# define USE_TYPEOF_UNQUAL 1
-#endif
-
-/*
  * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
  * operator when available, to return an unqualified type of the exp.
  */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d3318a3..377df1e 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -562,6 +562,14 @@ struct ftrace_likely_data {
 #define asm_inline asm
 #endif
=20
+#ifndef __ASSEMBLY__
+/*
+ * Use __typeof_unqual__() when available.
+ */
+#if CC_HAS_TYPEOF_UNQUAL || defined(__CHECKER__)
+# define USE_TYPEOF_UNQUAL 1
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
=20
@@ -569,6 +577,7 @@ struct ftrace_likely_data {
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
+#ifndef USE_TYPEOF_UNQUAL
 /*
  * Prefer C11 _Generic for better compile-times and simpler code. Note: 'cha=
r'
  * is not type-compatible with 'signed char', and we define a separate case.
@@ -586,6 +595,10 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(long),		\
 			 __scalar_type_to_expr_cases(long long),	\
 			 default: (x)))
+#else
+#define __unqual_scalar_typeof(x) __typeof_unqual__(x)
+#endif
+#endif /* !__ASSEMBLY__ */
=20
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
diff --git a/scripts/checker-valid.sh b/scripts/checker-valid.sh
new file mode 100755
index 0000000..625a789
--- /dev/null
+++ b/scripts/checker-valid.sh
@@ -0,0 +1,19 @@
+#!/bin/sh -eu
+# SPDX-License-Identifier: GPL-2.0
+
+[ ! -x "$(command -v "$1")" ] && exit 1
+
+tmp_file=3D$(mktemp)
+trap "rm -f $tmp_file" EXIT
+
+cat << EOF >$tmp_file
+static inline int u(const int *q)
+{
+	__typeof_unqual__(*q) v =3D *q;
+	return v;
+}
+EOF
+
+# sparse happily exits with 0 on error so validate
+# there is none on stderr. Use awk as grep is a pain with sh -e
+$@ $tmp_file 2>&1 | awk -v c=3D1 '/error/{c=3D0}END{print c}'

