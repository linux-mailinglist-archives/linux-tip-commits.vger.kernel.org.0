Return-Path: <linux-tip-commits+bounces-7818-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F399CF4A60
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CE5329118F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3233EAEC;
	Mon,  5 Jan 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtbAMGfs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mATIFzDO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDA329E5D;
	Mon,  5 Jan 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628491; cv=none; b=RlYvBQ72jxZWtILg4iJjoMr4ImYIgyWKoiMYIE4jBphdLxUzD4i1j04V08ZZhcQvQ1SAVtkZXdDJqqGNpUUpGQp5D2zLK8SyezQeowLfl2Q6slYrEE+Wwh+NHg83LJlK4zrGq+SbhEf19j1eoduAJb21B1ehm+Vy2ZVuVWBIXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628491; c=relaxed/simple;
	bh=ESFD/XQAZQ6VgWxVQ48vp3eFCJiSGpHEVCif5gt5X5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oPYrsYBQbXmS3cAcZiauEssm2DCtg4TZToUR2LGbVtDgj8LRRjqs3g4JchclvOuwNQ/7ElPq+Pg7GUbL1NCeENZYKOvsVw/XtsDTNffS/vefuwSu3+9JkiYS8mqkq5G3DTkeBSrzCFY/Pl7aoULpAJsxXd4MR2P/rauqXbtF4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtbAMGfs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mATIFzDO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tebMu6lBfvurwwDFyDmM7ijDaaTNqrtRV+RwxGlekkk=;
	b=qtbAMGfsky30qj5Y8/s22tnwCYDLhychmZCPNI0WD3TwXDrNyts04zA6C9eQjJMCV31Iev
	9nj7oPn6VWnxyOWcyqDSGK9bPP+Faym8zjMLCHslqmoZtE2E1xPcKtjqOHIEI3rvpG2i4s
	rXSXmC+s3rVD16N2wSJypF7+rDKRa/CflvF6wxumltA8Wj7nWAO+HOKImhnR0QL0/xFHTs
	JKuFEwiiCbSxBaWHUkb8qJCSR+4fec5ASsDFbh63dMY09MY0R33/RldA7NVmIkc+IVSjVt
	hEfcugQK/OWdOxY3WicL7CXWHLP+hycIje5N3+vLgbiGT0bLA3TaoZAgyLmB3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tebMu6lBfvurwwDFyDmM7ijDaaTNqrtRV+RwxGlekkk=;
	b=mATIFzDOcUt0GCKySnAtrubOBvTcHCCerfbCnBBVNeVvPwbddDbvy6Eikz2jpbsI7R6VPz
	Dz8Iyr9xwlElI8BA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Documentation: Add documentation for
 Compiler-Based Context Analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-5-elver@google.com>
References: <20251219154418.3592607-5-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762848405.510.5294819154113428119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8f32441d7a532804a8d9e2ae36f9b13c353934d7
Gitweb:        https://git.kernel.org/tip/8f32441d7a532804a8d9e2ae36f9b13c353=
934d7
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:27 +01:00

Documentation: Add documentation for Compiler-Based Context Analysis

Adds documentation in Documentation/dev-tools/context-analysis.rst, and
adds it to the index.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-5-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst | 144 ++++++++++++++++++-
 Documentation/dev-tools/index.rst            |   1 +-
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/dev-tools/context-analysis.rst

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
new file mode 100644
index 0000000..47eb547
--- /dev/null
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -0,0 +1,144 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2025, Google LLC.
+
+.. _context-analysis:
+
+Compiler-Based Context Analysis
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Context Analysis is a language extension, which enables statically checking
+that required contexts are active (or inactive) by acquiring and releasing
+user-definable "context locks". An obvious application is lock-safety checki=
ng
+for the kernel's various synchronization primitives (each of which represent=
s a
+"context lock"), and checking that locking rules are not violated.
+
+The Clang compiler currently supports the full set of context analysis
+features. To enable for Clang, configure the kernel with::
+
+    CONFIG_WARN_CONTEXT_ANALYSIS=3Dy
+
+The feature requires Clang 22 or later.
+
+The analysis is *opt-in by default*, and requires declaring which modules and
+subsystems should be analyzed in the respective `Makefile`::
+
+    CONTEXT_ANALYSIS_mymodule.o :=3D y
+
+Or for all translation units in the directory::
+
+    CONTEXT_ANALYSIS :=3D y
+
+It is possible to enable the analysis tree-wide, however, which will result =
in
+numerous false positive warnings currently and is *not* generally recommende=
d::
+
+    CONFIG_WARN_CONTEXT_ANALYSIS_ALL=3Dy
+
+Programming Model
+-----------------
+
+The below describes the programming model around using context lock types.
+
+.. note::
+   Enabling context analysis can be seen as enabling a dialect of Linux C wi=
th
+   a Context System. Some valid patterns involving complex control-flow are
+   constrained (such as conditional acquisition and later conditional release
+   in the same function).
+
+Context analysis is a way to specify permissibility of operations to depend =
on
+context locks being held (or not held). Typically we are interested in
+protecting data and code in a critical section by requiring a specific conte=
xt
+to be active, for example by holding a specific lock. The analysis ensures t=
hat
+callers cannot perform an operation without the required context being activ=
e.
+
+Context locks are associated with named structs, along with functions that
+operate on struct instances to acquire and release the associated context lo=
ck.
+
+Context locks can be held either exclusively or shared. This mechanism allows
+assigning more precise privileges when a context is active, typically to
+distinguish where a thread may only read (shared) or also write (exclusive) =
to
+data guarded within a context.
+
+The set of contexts that are actually active in a given thread at a given po=
int
+in program execution is a run-time concept. The static analysis works by
+calculating an approximation of that set, called the context environment. The
+context environment is calculated for every program point, and describes the
+set of contexts that are statically known to be active, or inactive, at that
+particular point. This environment is a conservative approximation of the fu=
ll
+set of contexts that will actually be active in a thread at run-time.
+
+More details are also documented `here
+<https://clang.llvm.org/docs/ThreadSafetyAnalysis.html>`_.
+
+.. note::
+   Clang's analysis explicitly does not infer context locks acquired or
+   released by inline functions. It requires explicit annotations to (a) ass=
ert
+   that it's not a bug if a context lock is released or acquired, and (b) to
+   retain consistency between inline and non-inline function declarations.
+
+Supported Kernel Primitives
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. Currently the following synchronization primitives are supported:
+
+For context locks with an initialization function (e.g., `spin_lock_init()`),
+calling this function before initializing any guarded members or globals
+prevents the compiler from issuing warnings about unguarded initialization.
+
+Lockdep assertions, such as `lockdep_assert_held()`, inform the compiler's
+context analysis that the associated synchronization primitive is held after
+the assertion. This avoids false positives in complex control-flow scenarios
+and encourages the use of Lockdep where static analysis is limited. For
+example, this is useful when a function doesn't *always* require a lock, mak=
ing
+`__must_hold()` inappropriate.
+
+Keywords
+~~~~~~~~
+
+.. kernel-doc:: include/linux/compiler-context-analysis.h
+   :identifiers: context_lock_struct
+                 token_context_lock token_context_lock_instance
+                 __guarded_by __pt_guarded_by
+                 __must_hold
+                 __must_not_hold
+                 __acquires
+                 __cond_acquires
+                 __releases
+                 __must_hold_shared
+                 __acquires_shared
+                 __cond_acquires_shared
+                 __releases_shared
+                 __acquire
+                 __release
+                 __cond_lock
+                 __acquire_shared
+                 __release_shared
+                 __cond_lock_shared
+                 __acquire_ret
+                 __acquire_shared_ret
+                 context_unsafe
+                 __context_unsafe
+                 disable_context_analysis enable_context_analysis
+
+.. note::
+   The function attribute `__no_context_analysis` is reserved for internal
+   implementation of context lock types, and should be avoided in normal cod=
e.
+
+Background
+----------
+
+Clang originally called the feature `Thread Safety Analysis
+<https://clang.llvm.org/docs/ThreadSafetyAnalysis.html>`_, with some keywords
+and documentation still using the thread-safety-analysis-only terminology. T=
his
+was later changed and the feature became more flexible, gaining the ability =
to
+define custom "capabilities". Its foundations can be found in `Capability
+Systems <https://www.cs.cornell.edu/talc/papers/capabilities.pdf>`_, used to
+specify the permissibility of operations to depend on some "capability" being
+held (or not held).
+
+Because the feature is not just able to express capabilities related to
+synchronization primitives, and "capability" is already overloaded in the
+kernel, the naming chosen for the kernel departs from Clang's initial "Thread
+Safety" and "capability" nomenclature; we refer to the feature as "Context
+Analysis" to avoid confusion. The internal implementation still makes
+references to Clang's terminology in a few places, such as `-Wthread-safety`
+being the warning option that also still appears in diagnostic messages.
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/inde=
x.rst
index 4b8425e..d864b3d 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -21,6 +21,7 @@ Documentation/process/debugging/index.rst
    checkpatch
    clang-format
    coccinelle
+   context-analysis
    sparse
    kcov
    gcov

