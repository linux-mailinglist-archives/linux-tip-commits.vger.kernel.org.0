Return-Path: <linux-tip-commits+bounces-4552-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC136A70D1C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BB417A293
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292B26A0BD;
	Tue, 25 Mar 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn1tBfEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BC26A0B0;
	Tue, 25 Mar 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942550; cv=none; b=r4mkKrmsDZQPII7hqKNpjWFwyk8o0Kn3Rpk/iIZaJEsNXwzTtzOm6zalo2wYs9b/ecxDeWBz9CP7YaOpLXTtzA7+DtBXMWC06GhUdLoBGYynm8pdfGLnlahpQOt/7HQ4Gi8NTkz2YmI1bCmkD0371vZXPGiRKQYhzE4qemvc67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942550; c=relaxed/simple;
	bh=dIiYVRww69FLxuWL+XWp6CiJSHXLv1b+ULQgwgNROZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbHKaI5RnByHT9YPubNHZeSod4yCWyEEhFiXjTMwQgLNwLi9Tfs4z3AncLjoJPFUd2Cxq5P5N+j2kC5JJDAMG3fKliuiDan+4e3jWJU6Zo//gp79sJ+mxeGCYwidgInt8G5WBwzImrEiQkOM9oLOJgAUuq1c394NGm+t1R7Gz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn1tBfEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A10C4CEE4;
	Tue, 25 Mar 2025 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942550;
	bh=dIiYVRww69FLxuWL+XWp6CiJSHXLv1b+ULQgwgNROZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jn1tBfElCH28LUvLWT2I5emWvxKfkds3g/NFZXgCaMPrT9tke0lBfd0EujpdIq8Ml
	 5UjuZpRNbf9zd5/rZJFYyZ+7mzqZVLEsvgEELUCe0M/dkBHGG5ZsZaaRAck1mltGhc
	 PtXmzF3nppkbkpwJ+DdUHOS9smgaUBXuJIjEweYM/iJ6IN8ZZleV8P/Gs/KhbU8k4K
	 muS+nfitN/DzuO0ecbB178vOcECk3UuoCt1VEeBGClPFEl+TL7lcZW7DxNBK4FL2ef
	 pI3lx7viqsKVywcst6S6bgJ8TJlIoV+XrTzy0MM+LvXMWnFviypibjBrwyNcnTVsRQ
	 2N81OmPeNn+yw==
Date: Tue, 25 Mar 2025 23:42:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
Subject: [PATCH] bug: Add the condition string to the
 CONFIG_DEBUG_BUGVERBOSE=y output
Message-ID: <Z-MxULQtc--KoKMW@gmail.com>
References: <20250317104257.3496611-2-mingo@kernel.org>
 <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net>
 <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com>
 <20250325123625.GM36322@noisy.programming.kicks-ass.net>
 <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> How about going a different route instead? Right now we have that 
> CONFIG_DEBUG_BUGVERBOSE thing which adds the file name and line 
> number information. That has been very good.
> 
> But maybe that should be extended to also always take the 
> compile-time '#condition' string?
> 
> So then all warnings would have the warning condition string 
> (assuming you end up enabling DEBUG_BUGVERBOSE, of course, which I 
> think everybody pretty much does). With no extra code.

So something like the patch below?

Testcase:

  @@ -8508,6 +8508,8 @@ void __init sched_init(void)
          unsigned long ptr = 0;
          int i;
 
  +       WARN_ON_ONCE(ptr == 0 && 1);
  +

Before:

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410

After:

  WARNING: CPU: 0 PID: 0 at [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410
                            ^^^^^^^^^^^^^^^

I concatenated the condition string with the file string, so didn't 
have to extend the 'struct bug_entry' backend, and could be shared with 
the regular WARN() and BUG*() code as well without modifying its 
output.

The .text impact is zero, as hoped for:

       text       data        bss         dec        hex    filename
   29523998    7926322    1389904    38840224    250a7a0    vmlinux.before
   29523998    8024626    1389904    38938528    25227a0    vmlinue.after

So this does have the debugging advantages of SCHED_WARN_ON() and the 
code generation benefits of WARN_ON_ONCE().

Note that the patch has still the maturity of a Labradoodle puppy: it 
won't build on the majority of non-x86 architectures, has only been 
built and booted once, etc. - so it's not signed off on.

Thanks,

	Ingo

===================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 25 Mar 2025 12:18:44 +0100
Subject: [PATCH] bug: Add the condition string to the CONFIG_DEBUG_BUGVERBOSE=y output

       text       data        bss         dec        hex    filename
   29523998    7926322    1389904    38840224    250a7a0    vmlinux.before
   29523998    8024626    1389904    38938528    25227a0    vmlinue.after

Before:

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410

After:

  WARNING: CPU: 0 PID: 0 at [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410
                            ^^^^^^^^^^^^^^^
Not-Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/Z-KRD3ODxT9f8Yjw@gmail.com
---
 arch/x86/include/asm/bug.h | 14 +++++++-------
 include/asm-generic/bug.h  |  7 ++++---
 kernel/sched/core.c        |  2 ++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f0e9acf72547..e966199c8ef7 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -39,7 +39,7 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags, extra)					\
+#define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
@@ -50,14 +50,14 @@ do {									\
 		     "\t.org 2b+%c3\n"					\
 		     ".popsection\n"					\
 		     extra						\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
+		     : : "i" (cond_str __FILE__), "i" (__LINE__),		\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
 #else /* !CONFIG_DEBUG_BUGVERBOSE */
 
-#define _BUG_FLAGS(ins, flags, extra)					\
+#define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
@@ -74,7 +74,7 @@ do {									\
 
 #else
 
-#define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)
+#define _BUG_FLAGS(cond_str, ins, flags, extra)  asm volatile(ins)
 
 #endif /* CONFIG_GENERIC_BUG */
 
@@ -82,7 +82,7 @@ do {									\
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, 0, "");				\
+	_BUG_FLAGS("", ASM_UD2, 0, "");				\
 	__builtin_unreachable();				\
 } while (0)
 
@@ -92,11 +92,11 @@ do {								\
  * were to trigger, we'd rather wreck the machine in an attempt to get the
  * message out than not know about it.
  */
-#define __WARN_FLAGS(flags)					\
+#define __WARN_FLAGS(cond_str, flags)				\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
+	_BUG_FLAGS(cond_str, ASM_UD2, __flags, ANNOTATE_REACHABLE(1b)); \
 	instrumentation_end();					\
 } while (0)
 
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 387720933973..c8e7126bc26e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -100,17 +100,18 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 		instrumentation_end();					\
 	} while (0)
 #else
-#define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
+#define __WARN()		__WARN_FLAGS("", BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
 		instrumentation_begin();				\
 		__warn_printk(arg);					\
-		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
+		__WARN_FLAGS("", BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
 		instrumentation_end();					\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS(BUGFLAG_ONCE |			\
+		__WARN_FLAGS("["#condition"] ",			\
+			     BUGFLAG_ONCE |			\
 			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
 })
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87540217fc09..71bf94bf68f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8508,6 +8508,8 @@ void __init sched_init(void)
 	unsigned long ptr = 0;
 	int i;
 
+	WARN_ON_ONCE(ptr == 0 && 1);
+
 	/* Make sure the linker didn't screw up */
 #ifdef CONFIG_SMP
 	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));

