Return-Path: <linux-tip-commits+bounces-1276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68AC8CA9DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465EBB21662
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3945548E0;
	Tue, 21 May 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uVsOUGuZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6np8L9z6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD804F897;
	Tue, 21 May 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279691; cv=none; b=KKG+0wysCtNMDIHSwchDrVrSlIuzWUMV9+LErRqd1m9XYAc9OdY0S9RDmSCTob/QzPPYQIll/SMc8lYNORNncJ5laKIxwg+aOzY0EaNNb9GM+5Pz5neuI/gaX10qBHbjOEbxFeStJtqP3e98ns9C0VNp1Z7bwdW7RbRLNx9f/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279691; c=relaxed/simple;
	bh=aT8FU7QbvDpL67F23TiPC3Za2Pyk/KGWw+mlpP74brU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=L5XygVAadanMYKjXyfNT5/0D+/Aby1AjOBFYT1YaOGsfibwZo/6EDd2mk6o5EOdUFF4GfrFo8InPleAhLceQm1VRweHsGQAzOPvE5tS46SBXW1VJN0IFTrsR+noBQ95jqH/WCfS5pNAt5dUzZyin1rLAee836lRvHQYgfnttCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uVsOUGuZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6np8L9z6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 08:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716279686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=b3RKnucmXFETg0/gt9pY9y7b749qiKfgCacChfIsQrQ=;
	b=uVsOUGuZzq33H0hUQj8i716UTvyPQ5kHr0Yv4Xq8f6atsqvYoJr55SrSoRZmq1bR8NLYN4
	7QZ3JQOUd/l2Q7nVS18XoG38IPB9qXSjFAh/DSEDltQVA5S5o0X6EXxnq7y4aW+TBMlIJT
	vCvU8e4YM8yAbIuk1KI78s8o53UkuERLa8o7mhg809y6RCe/fOSwi49VVSvb1EZ1sgNP1f
	OfAeOcf/4EaSzdudt6t7N+FO7r697hCOerLLPyVujQCVcwxcfUF+UXaKgjIzX1UTVj8Ib8
	pkNyAylyF/fX0hitKQYuKpqvQezcWOUJiCxEvtw9NhetWG/tOujGRJv9xpQFDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716279686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=b3RKnucmXFETg0/gt9pY9y7b749qiKfgCacChfIsQrQ=;
	b=6np8L9z666ywVBMJjfhhdzu9RFgSXBXovPcKjHKc66Xb7FHMM1XU4byhaKEl05glS/aQZU
	QFbdn42+xePaa4Cw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Clean up <asm/percpu.h> a bit
Cc: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171627968655.10875.15403339236062730279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     61d73e4f7d538f3907d954a531169e8164aef56b
Gitweb:        https://git.kernel.org/tip/61d73e4f7d538f3907d954a531169e8164aef56b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 20 May 2024 10:22:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 20 May 2024 10:56:23 +02:00

x86/percpu: Clean up <asm/percpu.h> a bit

 - Fix misc typos

 - There's 4 variants of the same spelling right now:

     'per-CPU', 'per CPU', 'percpu' and 'per-cpu'

   Standardize on 'per-CPU' only.

 - s/makes gcc load
    /makes the compiler load

 - Instead of:

     #ifdef CONFIG_XXXX
     #define YYYY FOO
     #else
     #define YYYY BAR
     #endif

   Use the slightly more readable form of:

     #ifdef CONFIG_XXXX
     # define YYYY FOO
     #else
     # define YYYY BAR
     #endif

 - Standardize & expand '#else' and '#endif' comments

 - Fix comment style

 - Capitalize x86 instruction names in comments

No change in code.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/percpu.h | 91 ++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0f0d897..b424cb1 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -3,30 +3,30 @@
 #define _ASM_X86_PERCPU_H
 
 #ifdef CONFIG_X86_64
-#define __percpu_seg		gs
-#define __percpu_rel		(%rip)
+# define __percpu_seg		gs
+# define __percpu_rel		(%rip)
 #else
-#define __percpu_seg		fs
-#define __percpu_rel
+# define __percpu_seg		fs
+# define __percpu_rel
 #endif
 
 #ifdef __ASSEMBLY__
 
 #ifdef CONFIG_SMP
-#define __percpu		%__percpu_seg:
+# define __percpu		%__percpu_seg:
 #else
-#define __percpu
+# define __percpu
 #endif
 
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
 #ifdef CONFIG_X86_64_SMP
-#define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
+# define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
 #else
-#define INIT_PER_CPU_VAR(var)  var
+# define INIT_PER_CPU_VAR(var)  var
 #endif
 
-#else /* ...!ASSEMBLY */
+#else /* !__ASSEMBLY__: */
 
 #include <linux/build_bug.h>
 #include <linux/stringify.h>
@@ -37,19 +37,19 @@
 #ifdef CONFIG_CC_HAS_NAMED_AS
 
 #ifdef __CHECKER__
-#define __seg_gs		__attribute__((address_space(__seg_gs)))
-#define __seg_fs		__attribute__((address_space(__seg_fs)))
+# define __seg_gs		__attribute__((address_space(__seg_gs)))
+# define __seg_fs		__attribute__((address_space(__seg_fs)))
 #endif
 
 #ifdef CONFIG_X86_64
-#define __percpu_seg_override	__seg_gs
+# define __percpu_seg_override	__seg_gs
 #else
-#define __percpu_seg_override	__seg_fs
+# define __percpu_seg_override	__seg_fs
 #endif
 
 #define __percpu_prefix		""
 
-#else /* CONFIG_CC_HAS_NAMED_AS */
+#else /* !CONFIG_CC_HAS_NAMED_AS: */
 
 #define __percpu_seg_override
 #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
@@ -80,7 +80,8 @@
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
 
-#else /* CONFIG_SMP */
+#else /* !CONFIG_SMP: */
+
 #define __percpu_seg_override
 #define __percpu_prefix		""
 #define __force_percpu_prefix	""
@@ -96,7 +97,7 @@
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
 /*
- * Initialized pointers to per-cpu variables needed for the boot
+ * Initialized pointers to per-CPU variables needed for the boot
  * processor need to use these macros to get the proper address
  * offset from __per_cpu_load on SMP.
  *
@@ -106,13 +107,15 @@
        extern typeof(var) init_per_cpu_var(var)
 
 #ifdef CONFIG_X86_64_SMP
-#define init_per_cpu_var(var)  init_per_cpu__##var
+# define init_per_cpu_var(var)  init_per_cpu__##var
 #else
-#define init_per_cpu_var(var)  var
+# define init_per_cpu_var(var)  var
 #endif
 
-/* For arch-specific code, we can use direct single-insn ops (they
- * don't give an lvalue though). */
+/*
+ * For arch-specific code, we can use direct single-insn ops (they
+ * don't give an lvalue though).
+ */
 
 #define __pcpu_type_1 u8
 #define __pcpu_type_2 u16
@@ -158,7 +161,7 @@ do {									\
 
 #define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
 
-#else /* CONFIG_USE_X86_SEG_SUPPORT */
+#else /* !CONFIG_USE_X86_SEG_SUPPORT: */
 
 #define __raw_cpu_read(size, qual, _var)				\
 ({									\
@@ -183,7 +186,7 @@ do {									\
 } while (0)
 
 /*
- * The generic per-cpu infrastrucutre is not suitable for
+ * The generic per-CPU infrastrucutre is not suitable for
  * reading const-qualified variables.
  */
 #define __raw_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
@@ -219,7 +222,7 @@ do {									\
 } while (0)
 
 /*
- * Generate a percpu add to memory instruction and optimize code
+ * Generate a per-CPU add to memory instruction and optimize code
  * if one is added or subtracted.
  */
 #define percpu_add_op(size, qual, var, val)				\
@@ -266,9 +269,9 @@ do {									\
 })
 
 /*
- * this_cpu_xchg() is implemented using cmpxchg without a lock prefix.
- * xchg is expensive due to the implied lock prefix. The processor
- * cannot prefetch cachelines if xchg is used.
+ * this_cpu_xchg() is implemented using CMPXCHG without a LOCK prefix.
+ * XCHG is expensive due to the implied LOCK prefix. The processor
+ * cannot prefetch cachelines if XCHG is used.
  */
 #define this_percpu_xchg_op(_var, _nval)				\
 ({									\
@@ -278,8 +281,8 @@ do {									\
 })
 
 /*
- * cmpxchg has no such implied lock semantics as a result it is much
- * more efficient for cpu local operations.
+ * CMPXCHG has no such implied lock semantics as a result it is much
+ * more efficient for CPU-local operations.
  */
 #define percpu_cmpxchg_op(size, qual, _var, _oval, _nval)		\
 ({									\
@@ -314,6 +317,7 @@ do {									\
 })
 
 #if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+
 #define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
 ({									\
 	union {								\
@@ -374,7 +378,8 @@ do {									\
 
 #define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg64_op(8,         , pcp, ovalp, nval)
 #define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg64_op(8, volatile, pcp, ovalp, nval)
-#endif
+
+#endif /* defined(CONFIG_X86_32) && !defined(CONFIG_UML) */
 
 #ifdef CONFIG_X86_64
 #define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
@@ -443,7 +448,8 @@ do {									\
 
 #define raw_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16,         , pcp, ovalp, nval)
 #define this_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16, volatile, pcp, ovalp, nval)
-#endif
+
+#endif /* CONFIG_X86_64 */
 
 #define raw_cpu_read_1(pcp)		__raw_cpu_read(1, , pcp)
 #define raw_cpu_read_2(pcp)		__raw_cpu_read(2, , pcp)
@@ -510,8 +516,8 @@ do {									\
 #define this_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, volatile, pcp, ovalp, nval)
 
 /*
- * Per cpu atomic 64 bit operations are only available under 64 bit.
- * 32 bit must fall back to generic operations.
+ * Per-CPU atomic 64-bit operations are only available under 64-bit kernels.
+ * 32-bit kernels must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
 #define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
@@ -539,20 +545,23 @@ do {									\
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
 
 #define raw_cpu_read_long(pcp)		raw_cpu_read_8(pcp)
-#else
-/* There is no generic 64 bit read stable operation for 32 bit targets. */
+
+#else /* !CONFIG_X86_64: */
+
+/* There is no generic 64-bit read stable operation for 32-bit targets. */
 #define this_cpu_read_stable_8(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
 
 #define raw_cpu_read_long(pcp)		raw_cpu_read_4(pcp)
-#endif
+
+#endif /* CONFIG_X86_64 */
 
 #define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
 
 /*
- * this_cpu_read() makes gcc load the percpu variable every time it is
- * accessed while this_cpu_read_stable() allows the value to be cached.
+ * this_cpu_read() makes the compiler load the per-CPU variable every time
+ * it is accessed while this_cpu_read_stable() allows the value to be cached.
  * this_cpu_read_stable() is more efficient and can be used if its value
- * is guaranteed to be valid across cpus.  The current users include
+ * is guaranteed to be valid across CPUs.  The current users include
  * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
@@ -626,12 +635,12 @@ DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 
 #define	early_per_cpu_ptr(_name) (_name##_early_ptr)
 #define	early_per_cpu_map(_name, _idx) (_name##_early_map[_idx])
-#define	early_per_cpu(_name, _cpu) 				\
+#define	early_per_cpu(_name, _cpu)				\
 	*(early_per_cpu_ptr(_name) ?				\
 		&early_per_cpu_ptr(_name)[_cpu] :		\
 		&per_cpu(_name, _cpu))
 
-#else	/* !CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 #define	DEFINE_EARLY_PER_CPU(_type, _name, _initvalue)		\
 	DEFINE_PER_CPU(_type, _name) = _initvalue
 
@@ -651,6 +660,6 @@ DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 #define	early_per_cpu_ptr(_name) NULL
 /* no early_per_cpu_map() */
 
-#endif	/* !CONFIG_SMP */
+#endif /* CONFIG_SMP */
 
 #endif /* _ASM_X86_PERCPU_H */

