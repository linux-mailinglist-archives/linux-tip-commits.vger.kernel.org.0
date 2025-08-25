Return-Path: <linux-tip-commits+bounces-6356-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D0B33CAF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822D8166C1E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA12DE6E9;
	Mon, 25 Aug 2025 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xXB+O9uE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Awddt+Za"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8D2E3AF1;
	Mon, 25 Aug 2025 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117495; cv=none; b=Z4QLsmGyW5MorWDnp5GVKaMufegbshuGFwDnMOPVOoKiS2AUM487y7XE3FCbAF02GAwZq2bmpj8qPpgCXb+OIxDxT3C00sJHKmwDcJH6EaCTEtTXywY87yufUf5f1NTUr6fUEIXQdOn4mGjJqbk/WMgnSUEvdW2TuUw8rDS0Mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117495; c=relaxed/simple;
	bh=r43u7wN5MpNJ3rPww0lyOb3H1aE2vOXzGEXNztJftGU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M37244ZTJL86hInE1/kA/cDhQnylMcks+P2vMRCMwNOkbrcprk1BHMg7z9vGBXw7fCIK6iXZOKTgNbYK4iS+rIyDJycTTQRg8AcxyCGsOr/CuMtVtufKKe+1chmeGUwSRgUSEXgW0qJlnEqYLXaqUh5cn4sSPb2j2E416bmUcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xXB+O9uE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Awddt+Za; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS5W/Vay/FGBowlf+SFMVkNKIk5D0H6vfIID+JZFpsU=;
	b=xXB+O9uEJg5mhmlHCOW7pEJgtBDBSUTqYLBEFeMTYlQsbhsKVy6hqChoAVA1n19/2ByyDu
	Cyi1gcTvT8K+mrzCHdvkqTnjHKIxuSUxKRo3vDfOi3SKmqZNRB5KeqGZ+1+rUBbNa9RdUA
	DCTALGYtNkkV9lDfxsoegAXgsb1rHM/FjNP4pWBXIrOZvGPIp6a0vf86PT8L+0mPCXJVRP
	4QqX/2FeiJnOXxcPgM6axq+if/SE6zneMZuM0dR+OTBoxzw6WHfb7VbXqZh9Vtv0K1kJe6
	py2MA17MqC1X/Xd206/2FHKRBIdJBIQi2SoNA4i0GIWh9EGirMnFAKa1jHkHrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS5W/Vay/FGBowlf+SFMVkNKIk5D0H6vfIID+JZFpsU=;
	b=Awddt+Za6AVboJ8PVkhK8RkVe3rG5kL+ysP1ezVoEqX5GfMMdwBxBLrx7Ctt4uXWJYEPkQ
	W93Cwp2cZMaWb/Bw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] selftests/bpf: Import usdt.h from libbpf/usdt project
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-12-jolsa@kernel.org>
References: <20250720112133.244369-12-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749016.1420.2692253292363271564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     17c3b001576452fda8fd19d664a93a988b309780
Gitweb:        https://git.kernel.org/tip/17c3b001576452fda8fd19d664a93a988b3=
09780
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:23 +02:00

selftests/bpf: Import usdt.h from libbpf/usdt project

Importing usdt.h from libbpf/usdt project.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-12-jolsa@kernel.org
---
 tools/testing/selftests/bpf/usdt.h | 545 ++++++++++++++++++++++++++++-
 1 file changed, 545 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/usdt.h

diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf=
/usdt.h
new file mode 100644
index 0000000..549d1f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: BSD-2-Clause
+/*
+ *  This single-header library defines a collection of variadic macros for
+ *  defining and triggering USDTs (User Statically-Defined Tracepoints):
+ *
+ *      - For USDTs without associated semaphore:
+ *          USDT(group, name, args...)
+ *
+ *      - For USDTs with implicit (transparent to the user) semaphore:
+ *          USDT_WITH_SEMA(group, name, args...)
+ *          USDT_IS_ACTIVE(group, name)
+ *
+ *      - For USDTs with explicit (user-defined and provided) semaphore:
+ *          USDT_WITH_EXPLICIT_SEMA(sema, group, name, args...)
+ *          USDT_SEMA_IS_ACTIVE(sema)
+ *
+ *  all of which emit a NOP instruction into the instruction stream, and so
+ *  have *zero* overhead for the surrounding code. USDTs are identified by
+ *  a combination of `group` and `name` identifiers, which is used by extern=
al
+ *  tracing tooling (tracers) for identifying exact USDTs of interest.
+ *
+ *  USDTs can have an associated (2-byte) activity counter (USDT semaphore),
+ *  automatically maintained by Linux kernel whenever any correctly written
+ *  BPF-based tracer is attached to the USDT. This USDT semaphore can be used
+ *  to check whether there is a need to do any extra data collection and
+ *  processing for a given USDT (if necessary), and otherwise avoid extra wo=
rk
+ *  for a common case of USDT not being traced ("active").
+ *
+ *  See documentation for USDT_WITH_SEMA()/USDT_IS_ACTIVE() or
+ *  USDT_WITH_EXPLICIT_SEMA()/USDT_SEMA_IS_ACTIVE() APIs below for details on
+ *  working with USDTs with implicitly or explicitly associated
+ *  USDT semaphores, respectively.
+ *
+ *  There is also some additional data recorded into an auxiliary note
+ *  section. The data in the note section describes the operands, in terms of
+ *  size and location, used by tracing tooling to know where to find USDT
+ *  arguments. Each location is encoded as an assembler operand string.
+ *  Tracing tools (bpftrace and BPF-based tracers, systemtap, etc) insert
+ *  breakpoints on top of the nop, and decode the location operand-strings,
+ *  like an assembler, to find the values being passed.
+ *
+ *  The operand strings are selected by the compiler for each operand.
+ *  They are constrained by inline-assembler codes.The default is:
+ *
+ *  #define USDT_ARG_CONSTRAINT nor
+ *
+ *  This is a good default if the operands tend to be integral and
+ *  moderate in number (smaller than number of registers). In other
+ *  cases, the compiler may report "'asm' requires impossible reload" or
+ *  similar. In this case, consider simplifying the macro call (fewer
+ *  and simpler operands), reduce optimization, or override the default
+ *  constraints string via:
+ *
+ *  #define USDT_ARG_CONSTRAINT g
+ *  #include <usdt.h>
+ *
+ * For some historical description of USDT v3 format (the one used by this
+ * library and generally recognized and assumed by BPF-based tracing tools)
+ * see [0]. The more formal specification can be found at [1]. Additional
+ * argument constraints information can be found at [2].
+ *
+ * Original SystemTap's sys/sdt.h implementation ([3]) was used as a base for
+ * this USDT library implementation. Current implementation differs *a lot* =
in
+ * terms of exposed user API and general usability, which was the main goal
+ * and focus of the reimplementation work. Nevertheless, underlying recorded
+ * USDT definitions are fully binary compatible and any USDT-based tooling
+ * should work equally well with USDTs defined by either SystemTap's or this
+ * library's USDT implementation.
+ *
+ *   [0] https://ecos.sourceware.org/ml/systemtap/2010-q3/msg00145.html
+ *   [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
+ *   [2] https://gcc.gnu.org/onlinedocs/gcc/Constraints.html
+ *   [3] https://sourceware.org/git/?p=3Dsystemtap.git;a=3Dblob;f=3Dincludes=
/sys/sdt.h
+ */
+#ifndef __USDT_H
+#define __USDT_H
+
+/*
+ * Changelog:
+ *
+ * 0.1.0
+ * -----
+ * - Initial release
+ */
+#define USDT_MAJOR_VERSION 0
+#define USDT_MINOR_VERSION 1
+#define USDT_PATCH_VERSION 0
+
+/* C++20 and C23 added __VA_OPT__ as a standard replacement for non-standard=
 `##__VA_ARGS__` extension */
+#if (defined(__STDC_VERSION__) && __STDC_VERSION__ > 201710L) || (defined(__=
cplusplus) && __cplusplus > 201703L)
+#define __usdt_va_opt 1
+#define __usdt_va_args(...) __VA_OPT__(,) __VA_ARGS__
+#else
+#define __usdt_va_args(...) , ##__VA_ARGS__
+#endif
+
+/*
+ * Trigger USDT with `group`:`name` identifier and pass through `args` as its
+ * arguments. Zero arguments are acceptable as well. No USDT semaphore is
+ * associated with this USDT.
+ *
+ * Such "semaphoreless" USDTs are commonly used when there is no extra data
+ * collection or processing needed to collect and prepare USDT arguments and
+ * they are just available in the surrounding code. USDT() macro will just
+ * record their locations in CPU registers or in memory for tracing tooling =
to
+ * be able to access them, if necessary.
+ */
+#ifdef __usdt_va_opt
+#define USDT(group, name, ...)							\
+	__usdt_probe(group, name, __usdt_sema_none, 0 __VA_OPT__(,) __VA_ARGS__)
+#else
+#define USDT(group, name, ...)							\
+	__usdt_probe(group, name, __usdt_sema_none, 0, ##__VA_ARGS__)
+#endif
+
+/*
+ * Trigger USDT with `group`:`name` identifier and pass through `args` as its
+ * arguments. Zero arguments are acceptable as well. USDT also get an
+ * implicitly-defined associated USDT semaphore, which will be "activated" by
+ * tracing tooling and can be used to check whether USDT is being actively
+ * observed.
+ *
+ * USDTs with semaphore are commonly used when there is a need to perform
+ * additional data collection and processing to prepare USDT arguments, which
+ * otherwise might not be necessary for the rest of application logic. In su=
ch
+ * case, USDT semaphore can be used to avoid unnecessary extra work. If USDT
+ * is not traced (which is presumed to be a common situation), the associated
+ * USDT semaphore is "inactive", and so there is no need to waste resources =
to
+ * prepare USDT arguments. Use USDT_IS_ACTIVE(group, name) to check whether
+ * USDT is "active".
+ *
+ * N.B. There is an inherent (albeit short) gap between checking whether USDT
+ * is active and triggering corresponding USDT, in which external tracer can
+ * be attached to an USDT and activate USDT semaphore after the activity che=
ck.
+ * If such a race occurs, tracers might miss one USDT execution. Tracers are
+ * expected to accommodate such possibility and this is expected to not be
+ * a problem for applications and tracers.
+ *
+ * N.B. Implicit USDT semaphore defined by USDT_WITH_SEMA() is contained
+ * within a single executable or shared library and is not shared outside
+ * them. I.e., if you use USDT_WITH_SEMA() with the same USDT group and name
+ * identifier across executable and shared library, it will work and won't
+ * conflict, per se, but will define independent USDT semaphores, one for ea=
ch
+ * shared library/executable in which USDT_WITH_SEMA(group, name) is used.
+ * That is, if you attach to this USDT in one shared library (or executable),
+ * then only USDT semaphore within that shared library (or executable) will =
be
+ * updated by the kernel, while other libraries (or executable) will not see
+ * activated USDT semaphore. In short, it's best to use unique USDT group:na=
me
+ * identifiers across different shared libraries (and, equivalently, between
+ * executable and shared library). This is advanced consideration and is
+ * rarely (if ever) seen in practice, but just to avoid surprises this is
+ * called out here. (Static libraries become a part of final executable, once
+ * linked by linker, so the above considerations don't apply to them.)
+ */
+#ifdef __usdt_va_opt
+#define USDT_WITH_SEMA(group, name, ...)					\
+	__usdt_probe(group, name,						\
+		     __usdt_sema_implicit, __usdt_sema_name(group, name)	\
+		     __VA_OPT__(,) __VA_ARGS__)
+#else
+#define USDT_WITH_SEMA(group, name, ...)					\
+	__usdt_probe(group, name,						\
+		     __usdt_sema_implicit, __usdt_sema_name(group, name),	\
+		     ##__VA_ARGS__)
+#endif
+
+struct usdt_sema { volatile unsigned short active; };
+
+/*
+ * Check if USDT with `group`:`name` identifier is "active" (i.e., whether it
+ * is attached to by external tracing tooling and is actively observed).
+ *
+ * This macro can be used to decide whether any additional and potentially
+ * expensive data collection or processing should be done to pass extra
+ * information into the given USDT. It is assumed that USDT is triggered with
+ * USDT_WITH_SEMA() macro which will implicitly define associated USDT
+ * semaphore. (If one needs more control over USDT semaphore, see
+ * USDT_DEFINE_SEMA() and USDT_WITH_EXPLICIT_SEMA() macros below.)
+ *
+ * N.B. Such checks are necessarily racy and speculative. Between checking
+ * whether USDT is active and triggering the USDT itself, tracer can be
+ * detached with no notification. This race should be extremely rare and wor=
st
+ * case should result in one-time wasted extra data collection and processin=
g.
+ */
+#define USDT_IS_ACTIVE(group, name) ({						\
+	extern struct usdt_sema __usdt_sema_name(group, name)			\
+		__usdt_asm_name(__usdt_sema_name(group, name));			\
+	__usdt_sema_implicit(__usdt_sema_name(group, name));			\
+	__usdt_sema_name(group, name).active > 0;				\
+})
+
+/*
+ * APIs for working with user-defined explicit USDT semaphores.
+ *
+ * This is a less commonly used advanced API for use cases in which user nee=
ds
+ * an explicit control over (potentially shared across multiple USDTs) USDT
+ * semaphore instance. This can be used when there is a group of logically
+ * related USDTs that all need extra data collection and processing whenever
+ * any of a family of related USDTs are "activated" (i.e., traced). In such
+ * a case, all such related USDTs will be associated with the same shared US=
DT
+ * semaphore defined with USDT_DEFINE_SEMA() and the USDTs themselves will be
+ * triggered with USDT_WITH_EXPLICIT_SEMA() macros, taking an explicit extra
+ * USDT semaphore identifier as an extra parameter.
+ */
+
+/**
+ * Underlying C global variable name for user-defined USDT semaphore with
+ * `sema` identifier. Could be useful for debugging, but normally shouldn't =
be
+ * used explicitly.
+ */
+#define USDT_SEMA(sema) __usdt_sema_##sema
+
+/*
+ * Define storage for user-defined USDT semaphore `sema`.
+ *
+ * Should be used only once in non-header source file to let compiler alloca=
te
+ * space for the semaphore variable. Just like with any other global variabl=
e.
+ *
+ * This macro can be used anywhere where global variable declaration is
+ * allowed. Just like with global variable definitions, there should be only
+ * one definition of user-defined USDT semaphore with given `sema` identifie=
r,
+ * otherwise compiler or linker will complain about duplicate variable
+ * definition.
+ *
+ * For C++, it is allowed to use USDT_DEFINE_SEMA() both in global namespace
+ * and inside namespaces (including nested namespaces). Just make sure that
+ * USDT_DECLARE_SEMA() is placed within the namespace where this semaphore is
+ * referenced, or any of its parent namespaces, so the C++ language-level
+ * identifier is visible to the code that needs to reference the semaphore.
+ * At the lowest layer, USDT semaphores have global naming and visibility
+ * (they have a corresponding `__usdt_sema_<name>` symbol, which can be link=
ed
+ * against from C or C++ code, if necessary). To keep it simple, putting
+ * USDT_DECLARE_SEMA() declarations into global namespaces is the simplest
+ * no-brainer solution. All these aspects are irrelevant for plain C, because
+ * C doesn't have namespaces and everything is always in the global namespac=
e.
+ *
+ * N.B. Due to USDT metadata being recorded in non-allocatable ELF note
+ * section, it has limitations when it comes to relocations, which, in
+ * practice, means that it's not possible to correctly share USDT semaphores
+ * between main executable and shared libraries, or even between multiple
+ * shared libraries. USDT semaphore has to be contained to individual shared
+ * library or executable to avoid unpleasant surprises with half-working USDT
+ * semaphores. We enforce this by marking semaphore ELF symbols as having
+ * a hidden visibility. This is quite an advanced use case and consideration
+ * and for most users this should have no consequences whatsoever.
+ */
+#define USDT_DEFINE_SEMA(sema)							\
+	struct usdt_sema __usdt_sema_sec USDT_SEMA(sema)			\
+		__usdt_asm_name(USDT_SEMA(sema))				\
+		__attribute__((visibility("hidden"))) =3D { 0 }
+
+/*
+ * Declare extern reference to user-defined USDT semaphore `sema`.
+ *
+ * Refers to a variable defined in another compilation unit by
+ * USDT_DEFINE_SEMA() and allows to use the same USDT semaphore across
+ * multiple compilation units (i.e., .c and .cpp files).
+ *
+ * See USDT_DEFINE_SEMA() notes above for C++ language usage peculiarities.
+ */
+#define USDT_DECLARE_SEMA(sema)							\
+	extern struct usdt_sema USDT_SEMA(sema) __usdt_asm_name(USDT_SEMA(sema))
+
+/*
+ * Check if user-defined USDT semaphore `sema` is "active" (i.e., whether it
+ * is attached to by external tracing tooling and is actively observed).
+ *
+ * This macro can be used to decide whether any additional and potentially
+ * expensive data collection or processing should be done to pass extra
+ * information into USDT(s) associated with USDT semaphore `sema`.
+ *
+ * N.B. Such checks are necessarily racy. Between checking the state of USDT
+ * semaphore and triggering associated USDT(s), the active tracer might atta=
ch
+ * or detach. This race should be extremely rare and worst case should result
+ * in one-time missed USDT event or wasted extra data collection and
+ * processing. USDT-using tracers should be written with this in mind and is
+ * not a concern of the application defining USDTs with associated semaphore.
+ */
+#define USDT_SEMA_IS_ACTIVE(sema) (USDT_SEMA(sema).active > 0)
+
+/*
+ * Invoke USDT specified by `group` and `name` identifiers and associate
+ * explicitly user-defined semaphore `sema` with it. Pass through `args` as
+ * USDT arguments. `args` are optional and zero arguments are acceptable.
+ *
+ * Semaphore is defined with the help of USDT_DEFINE_SEMA() macro and can be
+ * checked whether active with USDT_SEMA_IS_ACTIVE().
+ */
+#ifdef __usdt_va_opt
+#define USDT_WITH_EXPLICIT_SEMA(sema, group, name, ...)				\
+	__usdt_probe(group, name, __usdt_sema_explicit, USDT_SEMA(sema), ##__VA_ARG=
S__)
+#else
+#define USDT_WITH_EXPLICIT_SEMA(sema, group, name, ...)				\
+	__usdt_probe(group, name, __usdt_sema_explicit, USDT_SEMA(sema) __VA_OPT__(=
,) __VA_ARGS__)
+#endif
+
+/*
+ * Adjustable implementation aspects
+ */
+#ifndef USDT_ARG_CONSTRAINT
+#if defined __powerpc__
+#define USDT_ARG_CONSTRAINT		nZr
+#elif defined __arm__
+#define USDT_ARG_CONSTRAINT		g
+#elif defined __loongarch__
+#define USDT_ARG_CONSTRAINT		nmr
+#else
+#define USDT_ARG_CONSTRAINT		nor
+#endif
+#endif /* USDT_ARG_CONSTRAINT */
+
+#ifndef USDT_NOP
+#if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
+#define USDT_NOP			nop 0
+#else
+#define USDT_NOP			nop
+#endif
+#endif /* USDT_NOP */
+
+/*
+ * Implementation details
+ */
+/* USDT name for implicitly-defined USDT semaphore, derived from group:name =
*/
+#define __usdt_sema_name(group, name)	__usdt_sema_##group##__##name
+/* ELF section into which USDT semaphores are put */
+#define __usdt_sema_sec			__attribute__((section(".probes")))
+
+#define __usdt_concat(a, b)		a ## b
+#define __usdt_apply(fn, n)		__usdt_concat(fn, n)
+
+#ifndef __usdt_nth
+#define __usdt_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, N, =
...) N
+#endif
+
+#ifndef __usdt_narg
+#ifdef __usdt_va_opt
+#define __usdt_narg(...) __usdt_nth(_ __VA_OPT__(,) __VA_ARGS__, 12, 11, 10,=
 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+#else
+#define __usdt_narg(...) __usdt_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6=
, 5, 4, 3, 2, 1, 0)
+#endif
+#endif /* __usdt_narg */
+
+#define __usdt_hash			#
+#define __usdt_str_(x)			#x
+#define __usdt_str(x)			__usdt_str_(x)
+
+#ifndef __usdt_asm_name
+#define __usdt_asm_name(name)		__asm__(__usdt_str(name))
+#endif
+
+#define __usdt_asm0()		"\n"
+#define __usdt_asm1(x)		__usdt_str(x) "\n"
+#define __usdt_asm2(x, ...)	__usdt_str(x) "," __usdt_asm1(__VA_ARGS__)
+#define __usdt_asm3(x, ...)	__usdt_str(x) "," __usdt_asm2(__VA_ARGS__)
+#define __usdt_asm4(x, ...)	__usdt_str(x) "," __usdt_asm3(__VA_ARGS__)
+#define __usdt_asm5(x, ...)	__usdt_str(x) "," __usdt_asm4(__VA_ARGS__)
+#define __usdt_asm6(x, ...)	__usdt_str(x) "," __usdt_asm5(__VA_ARGS__)
+#define __usdt_asm7(x, ...)	__usdt_str(x) "," __usdt_asm6(__VA_ARGS__)
+#define __usdt_asm8(x, ...)	__usdt_str(x) "," __usdt_asm7(__VA_ARGS__)
+#define __usdt_asm9(x, ...)	__usdt_str(x) "," __usdt_asm8(__VA_ARGS__)
+#define __usdt_asm10(x, ...)	__usdt_str(x) "," __usdt_asm9(__VA_ARGS__)
+#define __usdt_asm11(x, ...)	__usdt_str(x) "," __usdt_asm10(__VA_ARGS__)
+#define __usdt_asm12(x, ...)	__usdt_str(x) "," __usdt_asm11(__VA_ARGS__)
+#define __usdt_asm(...)		__usdt_apply(__usdt_asm, __usdt_narg(__VA_ARGS__))(=
__VA_ARGS__)
+
+#ifdef __LP64__
+#define __usdt_asm_addr		.8byte
+#else
+#define __usdt_asm_addr		.4byte
+#endif
+
+#define __usdt_asm_strz_(x)	__usdt_asm1(.asciz #x)
+#define __usdt_asm_strz(x)	__usdt_asm_strz_(x)
+#define __usdt_asm_str_(x)	__usdt_asm1(.ascii #x)
+#define __usdt_asm_str(x)	__usdt_asm_str_(x)
+
+/* "semaphoreless" USDT case */
+#ifndef __usdt_sema_none
+#define __usdt_sema_none(sema)
+#endif
+
+/* implicitly defined __usdt_sema__group__name semaphore (using weak symbols=
) */
+#ifndef __usdt_sema_implicit
+#define __usdt_sema_implicit(sema)								\
+	__asm__ __volatile__ (									\
+	__usdt_asm1(.ifndef sema)								\
+	__usdt_asm3(		.pushsection .probes, "aw", "progbits")				\
+	__usdt_asm1(		.weak sema)							\
+	__usdt_asm1(		.hidden sema)							\
+	__usdt_asm1(		.align 2)							\
+	__usdt_asm1(sema:)									\
+	__usdt_asm1(		.zero 2)							\
+	__usdt_asm2(		.type sema, @object)						\
+	__usdt_asm2(		.size sema, 2)							\
+	__usdt_asm1(		.popsection)							\
+	__usdt_asm1(.endif)									\
+	);
+#endif
+
+/* externally defined semaphore using USDT_DEFINE_SEMA() and passed explicit=
ly by user */
+#ifndef __usdt_sema_explicit
+#define __usdt_sema_explicit(sema)								\
+	__asm__ __volatile__ ("" :: "m" (sema));
+#endif
+
+/* main USDT definition (nop and .note.stapsdt metadata) */
+#define __usdt_probe(group, name, sema_def, sema, ...) do {					\
+	sema_def(sema)										\
+	__asm__ __volatile__ (									\
+	__usdt_asm( 990:	USDT_NOP)							\
+	__usdt_asm3(		.pushsection .note.stapsdt, "", "note")				\
+	__usdt_asm1(		.balign 4)							\
+	__usdt_asm3(		.4byte 992f-991f,994f-993f,3)					\
+	__usdt_asm1(991:	.asciz "stapsdt")						\
+	__usdt_asm1(992:	.balign 4)							\
+	__usdt_asm1(993:	__usdt_asm_addr 990b)						\
+	__usdt_asm1(		__usdt_asm_addr _.stapsdt.base)					\
+	__usdt_asm1(		__usdt_asm_addr sema)						\
+	__usdt_asm_strz(group)									\
+	__usdt_asm_strz(name)									\
+	__usdt_asm_args(__VA_ARGS__)								\
+	__usdt_asm1(		.ascii "\0")							\
+	__usdt_asm1(994:	.balign 4)							\
+	__usdt_asm1(		.popsection)							\
+	__usdt_asm1(.ifndef _.stapsdt.base)							\
+	__usdt_asm5(		.pushsection .stapsdt.base,"aG","progbits",.stapsdt.base,comd=
at)\
+	__usdt_asm1(		.weak _.stapsdt.base)						\
+	__usdt_asm1(		.hidden _.stapsdt.base)						\
+	__usdt_asm1(_.stapsdt.base:)								\
+	__usdt_asm1(		.space 1)							\
+	__usdt_asm2(		.size _.stapsdt.base, 1)					\
+	__usdt_asm1(		.popsection)							\
+	__usdt_asm1(.endif)									\
+	:: __usdt_asm_ops(__VA_ARGS__)								\
+	);											\
+} while (0)
+
+/*
+ * NB: gdb PR24541 highlighted an unspecified corner of the sdt.h
+ * operand note format.
+ *
+ * The named register may be a longer or shorter (!) alias for the
+ * storage where the value in question is found. For example, on
+ * i386, 64-bit value may be put in register pairs, and a register
+ * name stored would identify just one of them. Previously, gcc was
+ * asked to emit the %w[id] (16-bit alias of some registers holding
+ * operands), even when a wider 32-bit value was used.
+ *
+ * Bottom line: the byte-width given before the @ sign governs. If
+ * there is a mismatch between that width and that of the named
+ * register, then a sys/sdt.h note consumer may need to employ
+ * architecture-specific heuristics to figure out where the compiler
+ * has actually put the complete value.
+ */
+#if defined(__powerpc__) || defined(__powerpc64__)
+#define __usdt_argref(id)	%I[id]%[id]
+#elif defined(__i386__)
+#define __usdt_argref(id)	%k[id]		/* gcc.gnu.org/PR80115 sourceware.org/PR24=
541 */
+#else
+#define __usdt_argref(id)	%[id]
+#endif
+
+#define __usdt_asm_arg(n)	__usdt_asm_str(%c[__usdt_asz##n])				\
+				__usdt_asm1(.ascii "@")						\
+				__usdt_asm_str(__usdt_argref(__usdt_aval##n))
+
+#define __usdt_asm_args0	/* no arguments */
+#define __usdt_asm_args1	__usdt_asm_arg(1)
+#define __usdt_asm_args2	__usdt_asm_args1 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(2)
+#define __usdt_asm_args3	__usdt_asm_args2 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(3)
+#define __usdt_asm_args4	__usdt_asm_args3 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(4)
+#define __usdt_asm_args5	__usdt_asm_args4 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(5)
+#define __usdt_asm_args6	__usdt_asm_args5 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(6)
+#define __usdt_asm_args7	__usdt_asm_args6 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(7)
+#define __usdt_asm_args8	__usdt_asm_args7 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(8)
+#define __usdt_asm_args9	__usdt_asm_args8 __usdt_asm1(.ascii " ") __usdt_asm=
_arg(9)
+#define __usdt_asm_args10	__usdt_asm_args9 __usdt_asm1(.ascii " ") __usdt_as=
m_arg(10)
+#define __usdt_asm_args11	__usdt_asm_args10 __usdt_asm1(.ascii " ") __usdt_a=
sm_arg(11)
+#define __usdt_asm_args12	__usdt_asm_args11 __usdt_asm1(.ascii " ") __usdt_a=
sm_arg(12)
+#define __usdt_asm_args(...)	__usdt_apply(__usdt_asm_args, __usdt_narg(__VA_=
ARGS__))
+
+#define __usdt_is_arr(x)	(__builtin_classify_type(x) =3D=3D 14 || __builtin_=
classify_type(x) =3D=3D 5)
+#define __usdt_arg_size(x)	(__usdt_is_arr(x) ? sizeof(void *) : sizeof(x))
+
+/*
+ * We can't use __builtin_choose_expr() in C++, so fall back to table-based
+ * signedness determination for known types, utilizing templates magic.
+ */
+#ifdef __cplusplus
+
+#define __usdt_is_signed(x)	(!__usdt_is_arr(x) && __usdt_t<__typeof(x)>::is_=
signed)
+
+#include <cstddef>
+
+template<typename T> struct __usdt_t { static const bool is_signed =3D false=
; };
+template<typename A> struct __usdt_t<A[]> : public __usdt_t<A *> {};
+template<typename A, size_t N> struct __usdt_t<A[N]> : public __usdt_t<A *> =
{};
+
+#define __usdt_def_signed(T)									\
+template<> struct __usdt_t<T>		     { static const bool is_signed =3D true; =
};		\
+template<> struct __usdt_t<const T>	     { static const bool is_signed =3D t=
rue; };		\
+template<> struct __usdt_t<volatile T>	     { static const bool is_signed =
=3D true; };		\
+template<> struct __usdt_t<const volatile T> { static const bool is_signed =
=3D true; }
+#define __usdt_maybe_signed(T)									\
+template<> struct __usdt_t<T>		     { static const bool is_signed =3D (T)-1 =
< (T)1; };	\
+template<> struct __usdt_t<const T>	     { static const bool is_signed =3D (=
T)-1 < (T)1; };	\
+template<> struct __usdt_t<volatile T>	     { static const bool is_signed =
=3D (T)-1 < (T)1; };	\
+template<> struct __usdt_t<const volatile T> { static const bool is_signed =
=3D (T)-1 < (T)1; }
+
+__usdt_def_signed(signed char);
+__usdt_def_signed(short);
+__usdt_def_signed(int);
+__usdt_def_signed(long);
+__usdt_def_signed(long long);
+__usdt_maybe_signed(char);
+__usdt_maybe_signed(wchar_t);
+
+#else /* !__cplusplus */
+
+#define __usdt_is_inttype(x)	(__builtin_classify_type(x) >=3D 1 && __builtin=
_classify_type(x) <=3D 4)
+#define __usdt_inttype(x)	__typeof(__builtin_choose_expr(__usdt_is_inttype(x=
), (x), 0U))
+#define __usdt_is_signed(x)	((__usdt_inttype(x))-1 < (__usdt_inttype(x))1)
+
+#endif /* __cplusplus */
+
+#define __usdt_asm_op(n, x)									\
+	[__usdt_asz##n] "n" ((__usdt_is_signed(x) ? (int)-1 : 1) * (int)__usdt_arg_=
size(x)),	\
+	[__usdt_aval##n] __usdt_str(USDT_ARG_CONSTRAINT)(x)
+
+#define __usdt_asm_ops0()				[__usdt_dummy] "g" (0)
+#define __usdt_asm_ops1(x)				__usdt_asm_op(1, x)
+#define __usdt_asm_ops2(a,x)				__usdt_asm_ops1(a), __usdt_asm_op(2, x)
+#define __usdt_asm_ops3(a,b,x)				__usdt_asm_ops2(a,b), __usdt_asm_op(3, x)
+#define __usdt_asm_ops4(a,b,c,x)			__usdt_asm_ops3(a,b,c), __usdt_asm_op(4, =
x)
+#define __usdt_asm_ops5(a,b,c,d,x)			__usdt_asm_ops4(a,b,c,d), __usdt_asm_op=
(5, x)
+#define __usdt_asm_ops6(a,b,c,d,e,x)			__usdt_asm_ops5(a,b,c,d,e), __usdt_as=
m_op(6, x)
+#define __usdt_asm_ops7(a,b,c,d,e,f,x)			__usdt_asm_ops6(a,b,c,d,e,f), __usd=
t_asm_op(7, x)
+#define __usdt_asm_ops8(a,b,c,d,e,f,g,x)		__usdt_asm_ops7(a,b,c,d,e,f,g), __=
usdt_asm_op(8, x)
+#define __usdt_asm_ops9(a,b,c,d,e,f,g,h,x)		__usdt_asm_ops8(a,b,c,d,e,f,g,h)=
, __usdt_asm_op(9, x)
+#define __usdt_asm_ops10(a,b,c,d,e,f,g,h,i,x)		__usdt_asm_ops9(a,b,c,d,e,f,g=
,h,i), __usdt_asm_op(10, x)
+#define __usdt_asm_ops11(a,b,c,d,e,f,g,h,i,j,x)		__usdt_asm_ops10(a,b,c,d,e,=
f,g,h,i,j), __usdt_asm_op(11, x)
+#define __usdt_asm_ops12(a,b,c,d,e,f,g,h,i,j,k,x)	__usdt_asm_ops11(a,b,c,d,e=
,f,g,h,i,j,k), __usdt_asm_op(12, x)
+#define __usdt_asm_ops(...)				__usdt_apply(__usdt_asm_ops, __usdt_narg(__VA=
_ARGS__))(__VA_ARGS__)
+
+#endif /* __USDT_H */

