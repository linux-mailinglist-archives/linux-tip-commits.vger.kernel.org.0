Return-Path: <linux-tip-commits+bounces-4330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C704A68A94
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370BE882572
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3E254876;
	Wed, 19 Mar 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EezZc5i4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0vrTlVm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA3253B48;
	Wed, 19 Mar 2025 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382209; cv=none; b=D9FJC67yOH/FnXOuuOcOdhXAy9vHeTz42vyap8up/zmP6Qv+dtBtItxyTraOzRMrtKb9iLFIlik/fpqOgY/LJdH6ibb2GiFdPUbRLNigHlNLZCmruhRGLa+2ib8gnCYVBE/cmuXXth80yQDSRfsLL3E0ruRIXMv06F/q3gzc0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382209; c=relaxed/simple;
	bh=gZrDL/UpLRPJKMZF5B5ULCUhcAToCu7ioSZMZ1uf1nw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Oo7rcYvUpXNokGgGUY2IEKyASr5wut6RN0+Hxbt0u57ZJdDNxZuHYOyc/38UHtOEj1LvHIOxtDBI59AxZJ26FDjpDOEVKPM2vbLfW1JR+QOXSbB5nH6Pt7lpDOGH2hfmPWBs5mtEfLznCusoLFL0s7OuchH0flZMbwJgvf78mz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EezZc5i4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0vrTlVm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUK42VfNTLlzA4g1XFmq+G70Q2HCPMJ6c0AQGNReRzg=;
	b=EezZc5i4nlW0JDW1L0NI+b86RzmtGQNbztQThdGwPVLMPhWtMk7BD0Gl5wMMO1yZrEuL4a
	F+J0vRajjYpjOWRhajTvjI8iWCtQnBZRAWYLIeaCG+Ct8MtDWizCkaRQj2zJwKx4qJfZ5z
	70ApVrzq2mpXwATuyCeD1XCzF5N7g7w26PaUFDKGOb0UWhYjYJqa9D3G5OQMhjEbaSUJTP
	Kdl1r9JXONmKCgt8tc2kfCOuV+nZoqbxfX38uKH/UzOUf5Qps8wjn5vkTbRv63AsvLl+hL
	APQjBsqJF8yWpjU4tXxE6XNGZR1J74ysWhvoKfNjaM+SMY9em/otBAubegAUqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUK42VfNTLlzA4g1XFmq+G70Q2HCPMJ6c0AQGNReRzg=;
	b=s0vrTlVmnFws2d6sgDLq+UyULOcLnrC13XFTFdfYxpzATfm00KiNHrUvDgkWrxmdsNVQO2
	BM68wN2l+Z78fDDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/locking/atomic: Improve performance by using
 asm_inline() for atomic locking instructions
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250309170955.48919-1-ubizjak@gmail.com>
References: <20250309170955.48919-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238220525.14745.15328347496869930063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     faa6f77b0dfae95b7270084bb2cc7fe30d687761
Gitweb:        https://git.kernel.org/tip/faa6f77b0dfae95b7270084bb2cc7fe30d687761
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 09 Mar 2025 18:09:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:58 +01:00

x86/locking/atomic: Improve performance by using asm_inline() for atomic locking instructions

According to:

  https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html

the usage of asm pseudo directives in the asm template can confuse
the compiler to wrongly estimate the size of the generated
code.

The LOCK_PREFIX macro expands to several asm pseudo directives, so
its usage in atomic locking insns causes instruction length estimates
to fail significantly (the specially instrumented compiler reports
the estimated length of these asm templates to be 6 instructions long).

This incorrect estimate further causes unoptimal inlining decisions,
un-optimal instruction scheduling and un-optimal code block alignments
for functions that use these locking primitives.

Use asm_inline instead:

  https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html

which is a feature that makes GCC pretend some inline assembler code
is tiny (while it would think it is huge), instead of just asm.

For code size estimation, the size of the asm is then taken as
the minimum size of one instruction, ignoring how many instructions
compiler thinks it is.

bloat-o-meter reports the following code size increase
(x86_64 defconfig, gcc-14.2.1):

  add/remove: 82/283 grow/shrink: 870/372 up/down: 76272/-43618 (32654)
  Total: Before=22770320, After=22802974, chg +0.14%

with top grows (>500 bytes):

	Function                                     old     new   delta
	----------------------------------------------------------------
	copy_process                                6465   10191   +3726
	balance_dirty_pages_ratelimited_flags        237    2949   +2712
	icl_plane_update_noarm                      5800    7969   +2169
	samsung_input_mapping                       3375    5170   +1795
	ext4_do_update_inode.isra                      -    1526   +1526
	__schedule                                  2416    3472   +1056
	__i915_vma_resource_unhold                     -     946    +946
	sched_mm_cid_after_execve                    175    1097    +922
	__do_sys_membarrier                            -     862    +862
	filemap_fault                               2666    3462    +796
	nl80211_send_wiphy                         11185   11874    +689
	samsung_input_mapping.cold                   900    1500    +600
	virtio_gpu_queue_fenced_ctrl_buffer          839    1410    +571
	ilk_update_pipe_csc                         1201    1735    +534
	enable_step                                    -     525    +525
	icl_color_commit_noarm                      1334    1847    +513
	tg3_read_bc_ver                                -     501    +501

and top shrinks (>500 bytes):

	Function                                     old     new   delta
	----------------------------------------------------------------
	nl80211_send_iftype_data                     580       -    -580
	samsung_gamepad_input_mapping.isra.cold      604       -    -604
	virtio_gpu_queue_ctrl_sgs                    724       -    -724
	tg3_get_invariants                          9218    8376    -842
	__i915_vma_resource_unhold.part              899       -    -899
	ext4_mark_iloc_dirty                        1735     106   -1629
	samsung_gamepad_input_mapping.isra          2046       -   -2046
	icl_program_input_csc                       2203       -   -2203
	copy_mm                                     2242       -   -2242
	balance_dirty_pages                         2657       -   -2657

These code size changes can be grouped into 4 groups:

a) some functions now include once-called functions in full or
in part. These are:

	Function                                     old     new   delta
	----------------------------------------------------------------
	copy_process                                6465   10191   +3726
	balance_dirty_pages_ratelimited_flags        237    2949   +2712
	icl_plane_update_noarm                      5800    7969   +2169
	samsung_input_mapping                       3375    5170   +1795
	ext4_do_update_inode.isra                      -    1526   +1526

that now include:

	Function                                     old     new   delta
	----------------------------------------------------------------
	copy_mm                                     2242       -   -2242
	balance_dirty_pages                         2657       -   -2657
	icl_program_input_csc                       2203       -   -2203
	samsung_gamepad_input_mapping.isra          2046       -   -2046
	ext4_mark_iloc_dirty                        1735     106   -1629

b) ISRA [interprocedural scalar replacement of aggregates,
interprocedural pass that removes unused function return values
(turning functions returning a value which is never used into void
functions) and removes unused function parameters.  It can also
replace an aggregate parameter by a set of other parameters
representing part of the original, turning those passed by reference
into new ones which pass the value directly.]

Top grows and shrinks of this group are listed below:

	Function                                     old     new   delta
	----------------------------------------------------------------
	ext4_do_update_inode.isra                      -    1526   +1526
	nfs4_begin_drain_session.isra                  -     249    +249
	nfs4_end_drain_session.isra                    -     168    +168
	__guc_action_register_multi_lrc_v70.isra     335     500    +165
	__i915_gem_free_objects.isra                   -     144    +144
	...
	membarrier_register_private_expedited.isra     108       -    -108
	syncobj_eventfd_entry_func.isra              445     314    -131
	__ext4_sb_bread_gfp.isra                     140       -    -140
	class_preempt_notrace_destructor.isra        145       -    -145
	p9_fid_put.isra                              151       -    -151
	__mm_cid_try_get.isra                        238       -    -238
	membarrier_global_expedited.isra             294       -    -294
	mm_cid_get.isra                              295       -    -295
	samsung_gamepad_input_mapping.isra.cold      604       -    -604
	samsung_gamepad_input_mapping.isra          2046       -   -2046

c) different split points of hot/cold split that just move code around:

Top grows and shrinks of this group are listed below:

	Function                                     old     new   delta
	----------------------------------------------------------------
	samsung_input_mapping.cold                   900    1500    +600
	__i915_request_reset.cold                    311     389     +78
	nfs_update_inode.cold                         77     153     +76
	__do_sys_swapon.cold                         404     455     +51
	copy_process.cold                              -      45     +45
	tg3_get_invariants.cold                       73     115     +42
	...
	hibernate.cold                               671     643     -28
	copy_mm.cold                                  31       -     -31
	software_resume.cold                         249     207     -42
	io_poll_wake.cold                            106      54     -52
	samsung_gamepad_input_mapping.isra.cold      604       -    -604

c) full inline of small functions with locking insn (~150 cases).
These bring in most of the code size increase because the removed
function code is now inlined in multiple places. E.g.:

	0000000000a50e10 <release_devnum>:
	  a50e10:    48 63 07                 movslq (%rdi),%rax
	  a50e13:    85 c0                    test   %eax,%eax
	  a50e15:    7e 10                    jle    a50e27 <release_devnum+0x17>
	  a50e17:    48 8b 4f 50              mov    0x50(%rdi),%rcx
	  a50e1b:    f0 48 0f b3 41 50        lock btr %rax,0x50(%rcx)
	  a50e21:    c7 07 ff ff ff ff        movl   $0xffffffff,(%rdi)
	  a50e27:    e9 00 00 00 00           jmp    a50e2c <release_devnum+0x1c>
		    a50e28: R_X86_64_PLT32    __x86_return_thunk-0x4
	  a50e2c:    0f 1f 40 00              nopl   0x0(%rax)

is now fully inlined into the caller function. This is desirable due
to the per function overhead of CPU bug mitigations like retpolines.

FTR a) with -Os (where generated code size really matters) x86_64
defconfig object file decreases by 24.388 kbytes, representing 0.1%
code size decrease:

	    text           data     bss      dec            hex filename
	23883860        4617284  814212 29315356        1bf511c vmlinux-old.o
	23859472        4615404  814212 29289088        1beea80 vmlinux-new.o

FTR b) clang recognizes "asm inline", but there was no difference in
code sizes:

	    text           data     bss      dec            hex filename
	27577163        4503078  807732 32887973        1f5d4a5 vmlinux-clang-patched.o
	27577181        4503078  807732 32887991        1f5d4b7 vmlinux-clang-unpatched.o

The performance impact of the patch was assessed by recompiling
fedora-41 6.13.5 kernel and running lmbench with old and new kernel.
The most noticeable improvements were:

	Process fork+exit: 270.0952 microseconds
	Process fork+execve: 2620.3333 microseconds
	Process fork+/bin/sh -c: 6781.0000 microseconds
	File /usr/tmp/XXX write bandwidth: 1780350 KB/sec
	Pagefaults on /usr/tmp/XXX: 0.3875 microseconds

to:

	Process fork+exit: 298.6842 microseconds
	Process fork+execve: 1662.7500 microseconds
	Process fork+/bin/sh -c: 2127.6667 microseconds
	File /usr/tmp/XXX write bandwidth: 1950077 KB/sec
	Pagefaults on /usr/tmp/XXX: 0.1958 microseconds

and from:

	Socket bandwidth using localhost
	0.000001 2.52 MB/sec
	0.000064 163.02 MB/sec
	0.000128 321.70 MB/sec
	0.000256 630.06 MB/sec
	0.000512 1207.07 MB/sec
	0.001024 2004.06 MB/sec
	0.001437 2475.43 MB/sec
	10.000000 5817.34 MB/sec

	Avg xfer: 3.2KB, 41.8KB in 1.2230 millisecs, 34.15 MB/sec
	AF_UNIX sock stream bandwidth: 9850.01 MB/sec
	Pipe bandwidth: 4631.28 MB/sec

to:

	Socket bandwidth using localhost
	0.000001 3.13 MB/sec
	0.000064 187.08 MB/sec
	0.000128 324.12 MB/sec
	0.000256 618.51 MB/sec
	0.000512 1137.13 MB/sec
	0.001024 1962.95 MB/sec
	0.001437 2458.27 MB/sec
	10.000000 6168.08 MB/sec

	Avg xfer: 3.2KB, 41.8KB in 1.0060 millisecs, 41.52 MB/sec
	AF_UNIX sock stream bandwidth: 9921.68 MB/sec
	Pipe bandwidth: 4649.96 MB/sec

[ mingo: Prettified the changelog a bit. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20250309170955.48919-1-ubizjak@gmail.com
---
 arch/x86/include/asm/atomic.h      | 14 +++++++-------
 arch/x86/include/asm/atomic64_64.h | 14 +++++++-------
 arch/x86/include/asm/bitops.h      | 14 +++++++-------
 arch/x86/include/asm/cmpxchg.h     | 24 ++++++++++++------------
 arch/x86/include/asm/cmpxchg_32.h  |  4 ++--
 arch/x86/include/asm/cmpxchg_64.h  |  4 ++--
 arch/x86/include/asm/rmwcc.h       |  2 +-
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55b4d24..75743f1 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -30,14 +30,14 @@ static __always_inline void arch_atomic_set(atomic_t *v, int i)
 
 static __always_inline void arch_atomic_add(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "addl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "addl %1, %0"
 		     : "+m" (v->counter)
 		     : "ir" (i) : "memory");
 }
 
 static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "subl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "subl %1, %0"
 		     : "+m" (v->counter)
 		     : "ir" (i) : "memory");
 }
@@ -50,14 +50,14 @@ static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "incl %0"
+	asm_inline volatile(LOCK_PREFIX "incl %0"
 		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_inc arch_atomic_inc
 
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "decl %0"
+	asm_inline volatile(LOCK_PREFIX "decl %0"
 		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_dec arch_atomic_dec
@@ -116,7 +116,7 @@ static __always_inline int arch_atomic_xchg(atomic_t *v, int new)
 
 static __always_inline void arch_atomic_and(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "andl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "andl %1, %0"
 			: "+m" (v->counter)
 			: "ir" (i)
 			: "memory");
@@ -134,7 +134,7 @@ static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
 
 static __always_inline void arch_atomic_or(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "orl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "orl %1, %0"
 			: "+m" (v->counter)
 			: "ir" (i)
 			: "memory");
@@ -152,7 +152,7 @@ static __always_inline int arch_atomic_fetch_or(int i, atomic_t *v)
 
 static __always_inline void arch_atomic_xor(int i, atomic_t *v)
 {
-	asm volatile(LOCK_PREFIX "xorl %1,%0"
+	asm_inline volatile(LOCK_PREFIX "xorl %1, %0"
 			: "+m" (v->counter)
 			: "ir" (i)
 			: "memory");
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index ae12aca..87b4963 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -22,14 +22,14 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 
 static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "addq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "addq %1, %0"
 		     : "=m" (v->counter)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
 
 static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "subq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "subq %1, %0"
 		     : "=m" (v->counter)
 		     : "er" (i), "m" (v->counter) : "memory");
 }
@@ -42,7 +42,7 @@ static __always_inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "incq %0"
+	asm_inline volatile(LOCK_PREFIX "incq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter) : "memory");
 }
@@ -50,7 +50,7 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
 
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "decq %0"
+	asm_inline volatile(LOCK_PREFIX "decq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter) : "memory");
 }
@@ -110,7 +110,7 @@ static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
 
 static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "andq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "andq %1, %0"
 			: "+m" (v->counter)
 			: "er" (i)
 			: "memory");
@@ -128,7 +128,7 @@ static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 
 static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "orq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "orq %1, %0"
 			: "+m" (v->counter)
 			: "er" (i)
 			: "memory");
@@ -146,7 +146,7 @@ static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 
 static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
-	asm volatile(LOCK_PREFIX "xorq %1,%0"
+	asm_inline volatile(LOCK_PREFIX "xorq %1, %0"
 			: "+m" (v->counter)
 			: "er" (i)
 			: "memory");
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b96d459..100413a 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -52,12 +52,12 @@ static __always_inline void
 arch_set_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "orb %b1,%0"
+		asm_inline volatile(LOCK_PREFIX "orb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" (CONST_MASK(nr))
 			: "memory");
 	} else {
-		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
+		asm_inline volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
@@ -72,11 +72,11 @@ static __always_inline void
 arch_clear_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "andb %b1,%0"
+		asm_inline volatile(LOCK_PREFIX "andb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" (~CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
+		asm_inline volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
@@ -98,7 +98,7 @@ static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 		volatile unsigned long *addr)
 {
 	bool negative;
-	asm volatile(LOCK_PREFIX "xorb %2,%1"
+	asm_inline volatile(LOCK_PREFIX "xorb %2,%1"
 		CC_SET(s)
 		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
 		: "iq" ((char)mask) : "memory");
@@ -122,11 +122,11 @@ static __always_inline void
 arch_change_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "xorb %b1,%0"
+		asm_inline volatile(LOCK_PREFIX "xorb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" (CONST_MASK(nr)));
 	} else {
-		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
+		asm_inline volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 5612648..5a9acaa 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -44,22 +44,22 @@ extern void __add_wrong_size(void)
 	        __typeof__ (*(ptr)) __ret = (arg);			\
 		switch (sizeof(*(ptr))) {				\
 		case __X86_CASE_B:					\
-			asm volatile (lock #op "b %b0, %1\n"		\
+			asm_inline volatile (lock #op "b %b0, %1"	\
 				      : "+q" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_W:					\
-			asm volatile (lock #op "w %w0, %1\n"		\
+			asm_inline volatile (lock #op "w %w0, %1"	\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_L:					\
-			asm volatile (lock #op "l %0, %1\n"		\
+			asm_inline volatile (lock #op "l %0, %1"	\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_Q:					\
-			asm volatile (lock #op "q %q0, %1\n"		\
+			asm_inline volatile (lock #op "q %q0, %1"	\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
@@ -91,7 +91,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_B:						\
 	{								\
 		volatile u8 *__ptr = (volatile u8 *)(ptr);		\
-		asm volatile(lock "cmpxchgb %2,%1"			\
+		asm_inline volatile(lock "cmpxchgb %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "q" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -100,7 +100,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_W:						\
 	{								\
 		volatile u16 *__ptr = (volatile u16 *)(ptr);		\
-		asm volatile(lock "cmpxchgw %2,%1"			\
+		asm_inline volatile(lock "cmpxchgw %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "r" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -109,7 +109,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_L:						\
 	{								\
 		volatile u32 *__ptr = (volatile u32 *)(ptr);		\
-		asm volatile(lock "cmpxchgl %2,%1"			\
+		asm_inline volatile(lock "cmpxchgl %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "r" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -118,7 +118,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_Q:						\
 	{								\
 		volatile u64 *__ptr = (volatile u64 *)(ptr);		\
-		asm volatile(lock "cmpxchgq %2,%1"			\
+		asm_inline volatile(lock "cmpxchgq %2, %1"		\
 			     : "=a" (__ret), "+m" (*__ptr)		\
 			     : "r" (__new), "0" (__old)			\
 			     : "memory");				\
@@ -165,7 +165,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_B:						\
 	{								\
 		volatile u8 *__ptr = (volatile u8 *)(_ptr);		\
-		asm volatile(lock "cmpxchgb %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgb %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
@@ -177,7 +177,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_W:						\
 	{								\
 		volatile u16 *__ptr = (volatile u16 *)(_ptr);		\
-		asm volatile(lock "cmpxchgw %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgw %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
@@ -189,7 +189,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_L:						\
 	{								\
 		volatile u32 *__ptr = (volatile u32 *)(_ptr);		\
-		asm volatile(lock "cmpxchgl %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgl %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
@@ -201,7 +201,7 @@ extern void __add_wrong_size(void)
 	case __X86_CASE_Q:						\
 	{								\
 		volatile u64 *__ptr = (volatile u64 *)(_ptr);		\
-		asm volatile(lock "cmpxchgq %[new], %[ptr]"		\
+		asm_inline volatile(lock "cmpxchgq %[new], %[ptr]"	\
 			     CC_SET(z)					\
 			     : CC_OUT(z) (success),			\
 			       [ptr] "+m" (*__ptr),			\
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index ee89fbc..3c0c6d2 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -19,7 +19,7 @@ union __u64_halves {
 	union __u64_halves o = { .full = (_old), },			\
 			   n = { .full = (_new), };			\
 									\
-	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg8b %[ptr]"			\
 		     : [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
@@ -45,7 +45,7 @@ static __always_inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new
 			   n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg8b %[ptr]"			\
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 5e24130..71d1e72 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -38,7 +38,7 @@ union __u128_halves {
 	union __u128_halves o = { .full = (_old), },			\
 			    n = { .full = (_new), };			\
 									\
-	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg16b %[ptr]"			\
 		     : [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
@@ -65,7 +65,7 @@ static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, 
 			    n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+	asm_inline volatile(_lock "cmpxchg16b %[ptr]"			\
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 363266c..3821ee3 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -29,7 +29,7 @@ cc_label:	c = true;						\
 #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
 ({									\
 	bool c;								\
-	asm volatile (fullop CC_SET(cc)					\
+	asm_inline volatile (fullop CC_SET(cc)				\
 			: [var] "+m" (_var), CC_OUT(cc) (c)		\
 			: __VA_ARGS__ : clobbers);			\
 	c;								\

