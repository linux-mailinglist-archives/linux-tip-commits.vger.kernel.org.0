Return-Path: <linux-tip-commits+bounces-3809-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F4A4CB59
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3023AF165
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB0235347;
	Mon,  3 Mar 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4mt9KltS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eP+jn56T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32D230BD0;
	Mon,  3 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027928; cv=none; b=BAsmXI+lqkoAQWqUdH98x79dRsNPQ3HpDsDETJ0jqgAQDJtW3vHHk9eV5w9+5ReUsyMIL9vlHrYNNexAm5TtvYLO2kywnSsiIZEW8bBQMzZjSXoG4MrPNhx7OuimWY9WiFbudzkRMmmhpgK+oG/frA93mQ/v2Or/rT5IAAVd+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027928; c=relaxed/simple;
	bh=1N0zkKFPNaEmyjCtKPW1c9AjXBS3Vn0n0yz0QlSM4D0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=InS65dLW0BHWI6tel0u693YjuVbG8ocQEnZj8Bsl+zivfz4KvwErq8wfwbl4jXbCzBfcc3pwnveJ2DjQlG0T9N90tGv7EgsaZPOxqH8KNQczyI1u1x1iwpkuoRQP3iSClFBQTnvG5pmWGLkVBkIaElKfa4M9KSG65l7WiTiZ7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4mt9KltS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eP+jn56T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyoK3OULAh6wsqPKzsuiNpgc5nRlLHhwvIfB7o33ir4=;
	b=4mt9KltS8/dVeo2KBYetq0vzEw8m4eeO+1XCcLsBzn+OtxaKqnJOz/ZQcqh+iYfuuzNaan
	yJ7uCis8BsRTIoc1R2E6pbBAI3jmCQ8tJkuXDX0p1iFW4150anxrIWYucVm1e+w6BzARim
	JBQUDSjJhCVCxINw+nXV9MCVjct0mwbbKKnt74OJlAkqsxGI3XrhB4nhZFZpuX9e1zpOdj
	P7aJmTQ8ZQHNwnOsbufuL4mKm+RgYhE4NQP5k92fCMvZnYusTJnXnfbzdwQo+LED3F7vk/
	GrJKEYIGAOFrU+FAUMXr0dvUWadvxKvanzfMJNcMYWJfzGfruGDFoD8MKMVlBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyoK3OULAh6wsqPKzsuiNpgc5nRlLHhwvIfB7o33ir4=;
	b=eP+jn56TG+xfSFmbHEduDDxhD0ReyhxPkowpysodlSY26ZHcdDyd7/JIx9BJnUT+cBKEZw
	Y98Z3eL8W0EIGWBQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Disable KASAN instrumentation of
 lockdep.c
Cc: Waiman Long <longman@redhat.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213200228.1993588-4-longman@redhat.com>
References: <20250213200228.1993588-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791709.14745.172460542953869950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     59e2312d95f97738dad5c7cbbe3e54c176f24fc7
Gitweb:        https://git.kernel.org/tip/59e2312d95f97738dad5c7cbbe3e54c176f24fc7
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 13 Feb 2025 15:02:27 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

locking/lockdep: Disable KASAN instrumentation of lockdep.c

Both KASAN and LOCKDEP are commonly enabled in building a debug kernel.
Each of them can significantly slow down the speed of a debug kernel.
Enabling KASAN instrumentation of the LOCKDEP code will further slow
thing down.

Since LOCKDEP is a high overhead debugging tool, it will never get
enabled in a production kernel. The LOCKDEP code is also pretty mature
and is unlikely to get major changes. There is also a possibility of
recursion similar to KCSAN.

To evaluate the performance impact of disabling KASAN instrumentation
of lockdep.c, the time to do a parallel build of the Linux defconfig
kernel was used as the benchmark. Two x86-64 systems (Skylake & Zen 2)
and an arm64 system were used as test beds. Two sets of non-RT and RT
kernels with similar configurations except mainly CONFIG_PREEMPT_RT
were used for evaulation.

For the Skylake system:

  Kernel			Run time	    Sys time
  ------			--------	    --------
  Non-debug kernel (baseline)	0m47.642s	      4m19.811s

  [CONFIG_KASAN_INLINE=y]
  Debug kernel			2m11.108s (x2.8)     38m20.467s (x8.9)
  Debug kernel (patched)	1m49.602s (x2.3)     31m28.501s (x7.3)
  Debug kernel
  (patched + mitigations=off) 	1m30.988s (x1.9)     26m41.993s (x6.2)

  RT kernel (baseline)		0m54.871s	      7m15.340s

  [CONFIG_KASAN_INLINE=n]
  RT debug kernel		6m07.151s (x6.7)    135m47.428s (x18.7)
  RT debug kernel (patched)	3m42.434s (x4.1)     74m51.636s (x10.3)
  RT debug kernel
  (patched + mitigations=off) 	2m40.383s (x2.9)     57m54.369s (x8.0)

  [CONFIG_KASAN_INLINE=y]
  RT debug kernel		3m22.155s (x3.7)     77m53.018s (x10.7)
  RT debug kernel (patched)	2m36.700s (x2.9)     54m31.195s (x7.5)
  RT debug kernel
  (patched + mitigations=off) 	2m06.110s (x2.3)     45m49.493s (x6.3)

For the Zen 2 system:

  Kernel			Run time	    Sys time
  ------			--------	    --------
  Non-debug kernel (baseline)	1m42.806s	     39m48.714s

  [CONFIG_KASAN_INLINE=y]
  Debug kernel			4m04.524s (x2.4)    125m35.904s (x3.2)
  Debug kernel (patched)	3m56.241s (x2.3)    127m22.378s (x3.2)
  Debug kernel
  (patched + mitigations=off) 	2m38.157s (x1.5)     92m35.680s (x2.3)

  RT kernel (baseline)		 1m51.500s	     14m56.322s

  [CONFIG_KASAN_INLINE=n]
  RT debug kernel		16m04.962s (x8.7)   244m36.463s (x16.4)
  RT debug kernel (patched)	 9m09.073s (x4.9)   129m28.439s (x8.7)
  RT debug kernel
  (patched + mitigations=off) 	 3m31.662s (x1.9)    51m01.391s (x3.4)

For the arm64 system:

  Kernel			Run time	    Sys time
  ------			--------	    --------
  Non-debug kernel (baseline)	1m56.844s	      8m47.150s
  Debug kernel			3m54.774s (x2.0)     92m30.098s (x10.5)
  Debug kernel (patched)	3m32.429s (x1.8)     77m40.779s (x8.8)

  RT kernel (baseline)		 4m01.641s	     18m16.777s

  [CONFIG_KASAN_INLINE=n]
  RT debug kernel		19m32.977s (x4.9)   304m23.965s (x16.7)
  RT debug kernel (patched)	16m28.354s (x4.1)   234m18.149s (x12.8)

Turning the mitigations off doesn't seems to have any noticeable impact
on the performance of the arm64 system. So the mitigation=off entries
aren't included.

For the x86 CPUs, cpu mitigations has a much bigger
impact on performance, especially the RT debug kernel with
CONFIG_KASAN_INLINE=n. The SRSO mitigation in Zen 2 has an especially
big impact on the debug kernel. It is also the majority of the slowdown
with mitigations on. It is because the patched ret instruction slows
down function returns. A lot of helper functions that are normally
compiled out or inlined may become real function calls in the debug
kernel.

With CONFIG_KASAN_INLINE=n, the KASAN instrumentation inserts a
lot of __asan_loadX*() and __kasan_check_read() function calls to memory
access portion of the code. The lockdep's __lock_acquire() function,
for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
added with KASAN instrumentation. Of course, the actual numbers may vary
depending on the compiler used and the exact version of the lockdep code.

With the Skylake test system, the parallel kernel build times reduction
of the RT debug kernel with this patch are:

 CONFIG_KASAN_INLINE=n: -37%
 CONFIG_KASAN_INLINE=y: -22%

The time reduction is less with CONFIG_KASAN_INLINE=y, but it is still
significant.

Setting CONFIG_KASAN_INLINE=y can result in a significant performance
improvement. The major drawback is a significant increase in the size
of kernel text. In the case of vmlinux, its text size increases from
45997948 to 67606807. That is a 47% size increase (about 21 Mbytes). The
size increase of other kernel modules should be similar.

With the newly added rtmutex and lockdep lock events, the relevant
event counts for the test runs with the Skylake system were:

  Event type		Debug kernel	RT debug kernel
  ----------		------------	---------------
  lockdep_acquire	1,968,663,277	5,425,313,953
  rtlock_slowlock	     -		  401,701,156
  rtmutex_slowlock	     -		      139,672

The __lock_acquire() calls in the RT debug kernel are x2.8 times of the
non-RT debug kernel with the same workload. Since the __lock_acquire()
function is a big hitter in term of performance slowdown, this makes
the RT debug kernel much slower than the non-RT one. The average lock
nesting depth is likely to be higher in the RT debug kernel too leading
to longer execution time in the __lock_acquire() function.

As the small advantage of enabling KASAN instrumentation to catch
potential memory access error in the lockdep debugging tool is probably
not worth the drawback of further slowing down a debug kernel, disable
KASAN instrumentation in the lockdep code to allow the debug kernels
to regain some performance back, especially for the RT debug kernels.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250213200228.1993588-4-longman@redhat.com
---
 kernel/locking/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093..a114949 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -5,7 +5,8 @@ KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
-# Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
+# Avoid recursion lockdep -> sanitizer -> ... -> lockdep & improve performance.
+KASAN_SANITIZE_lockdep.o := n
 KCSAN_SANITIZE_lockdep.o := n
 
 ifdef CONFIG_FUNCTION_TRACER

