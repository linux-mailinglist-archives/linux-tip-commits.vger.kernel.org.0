Return-Path: <linux-tip-commits+bounces-4528-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C871A6F1A5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB9116AEBE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650332E337C;
	Tue, 25 Mar 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kukHuGM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC279F5;
	Tue, 25 Mar 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901525; cv=none; b=Ji6QM2JYcjSyypCcN6ALRjz3Z2BOd95q2SVyx7QybAYFjb3i16ztWGc/fn0J+4kbHrauGBDsOx5/dxT6Xafp2ObgjCaUIAwsWAsYvPScNiUO36bMyBBsAqow6346mOxEDVnsAhXDXs+rCzpdrk8v31JM05U0fn5uJsel+gOqIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901525; c=relaxed/simple;
	bh=khDMRd3/8spXHUnQOPT5netn3r10aLnbqLNTmcWzJTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0GuTvo7mxkux+rsv5yoDuuqJI11H06mSac13ok9eLZutSpysOEO+7q8de6enhTDhLjgj6QuU5I3jJQGgetLKAW5kbi24AMAkqTiUKxlFon9Tnj4hC61GzVzjQ9V1JgVYT+/RItQlRXzt7BgJSOD66M3hay0PGbtjsmxmCOESCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kukHuGM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EBBC4CEE4;
	Tue, 25 Mar 2025 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742901524;
	bh=khDMRd3/8spXHUnQOPT5netn3r10aLnbqLNTmcWzJTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kukHuGM5kAqyY3WKu39GCJbJrhnZXwWq7xs4VeZzS55T3Nhv8Q64JBh0z2eUIZBgf
	 mOyWh70ATo8x21lTO1V9gSgn28Kh4cgsGgucpYeMJcnUQ/NBm6XOvIZI/4Ks3n8y+s
	 d0rhL4xRAZz3ct4S17EgQsC0j/hJolNZQCzZgShdAn6AuwTlSivv8SwAWRAlRADnJk
	 iNjHcLXZFTNKOVnI5SnzwMdSuE2yseFSBMTesaP45kaGDwLqCLadZOuUnsVSEgkzfd
	 2mVmiYiJPdpqp/fh1sWInQ26WZ701weh5+x6PMqFqKx+Kazk40TbjWmriOEOGlqEfJ
	 4y94wDltOc6kA==
Date: Tue, 25 Mar 2025 12:18:39 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: [PATCH] bug: Introduce CONFIG_DEBUG_BUGVERBOSE_EXTRA=y to also log
 warning conditions
Message-ID: <Z-KRD3ODxT9f8Yjw@gmail.com>
References: <20250317104257.3496611-2-mingo@kernel.org>
 <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net>
 <Z-J5UEFwM3gh6VXR@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-J5UEFwM3gh6VXR@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > >    #define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
> > > 
> > > Because SCHED_WARN_ON() would output the 'x' condition
> > > as well, while WARN_ONCE() will only show a backtrace.
> > > 
> > > Hopefully these are rare enough to not really matter.
> > > 
> > > If it does, we should probably introduce a new WARN_ON()
> > > variant that outputs the condition in stringified form,
> > > or improve WARN_ON() itself.
> > 
> > So those strings really were useful, trouble is WARN_ONCE() generates
> > utter crap code compared to WARN_ON_ONCE(), but since SCHED_DEBUG that
> > doesn't really matter.
> 
> Why wouldn't it matter? CONFIG_SCHED_DEBUG was turned on for 99.9999% 
> of Linux users, ie. we generated crap code for most of our users.
> 
> And as a side effect of using the standard WARN_ON_ONCE() primitive we 
> now generate better code, at the expense of harder to interpret debug 
> output, right?
> 
> Ie. CONFIG_SCHED_DEBUG has obfuscated crappy code generation under the 
> "it's only debugging code" pretense, right?

So, to argue this via code, we'd like to have something like the patch below?

When enabled it will warn in the following fashion:

  static void super_perfect_kernel_function(void *ptr)
  {
	...
	WARN_ON_ONCE(ptr == 0 && 1);
	...
  }


  ------------[ cut here ]------------
  FAIL: 'ptr == 0 && 1' is true
  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x44/0x430
  ...

But the real question is, how do we keep distros from enabling 
CONFIG_DEBUG_BUGVERBOSE_EXTRA=y?

It does bloat the defconfig by about +144k .text and ~64k data, so 
maybe that's deterrence enough.

The BSS shift is due to it not using the clever x86 U2D tricks, right?

Thanks,

	Ingo

=================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 25 Mar 2025 11:35:20 +0100
Subject: [PATCH] bug: Introduce CONFIG_DEBUG_BUGVERBOSE_EXTRA=y to also log warning conditions

      text         data	    bss	     dec	    hex	filename
  29522704	7926322	1389904	38838930	250a292	vmlinux.before
  29667392	8017958	1363024	39048374	253d4b6	vmlinux.after

Totally-Not-Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/bug.h |  7 +++++++
 kernel/sched/core.c       |  2 ++
 lib/Kconfig.debug         | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 387720933973..5475258a99dc 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -92,6 +92,11 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE_EXTRA
+#define WARN_ON_ONCE(condition)						\
+	DO_ONCE_LITE_IF(condition, WARN, 1, "FAIL: '%s' is true", #condition)
+#endif
+
 #ifndef __WARN_FLAGS
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
@@ -107,6 +112,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
 		instrumentation_end();					\
 	} while (0)
+#ifndef WARN_ON_ONCE
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
@@ -115,6 +121,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 	unlikely(__ret_warn_on);				\
 })
 #endif
+#endif
 
 /* used internally by panic.c */
 
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
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b1b92a9a8f24..88f215f712f8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -206,6 +206,18 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+config DEBUG_BUGVERBOSE_EXTRA
+	bool "Extra verbose WARN_ON() reporting" if DEBUG_BUGVERBOSE
+	default n
+	help
+	  Say Y here to make WARN_ON() warnings extra verbose, printing
+	  the condition they warn about.
+
+	  This aids debugging but uses up some memory and causes some
+	  runtime overhead due to worse code generation.
+
+	  If unsure, say N.
+
 endmenu # "printk and dmesg options"
 
 config DEBUG_KERNEL


