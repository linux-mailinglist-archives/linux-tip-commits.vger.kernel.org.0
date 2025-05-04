Return-Path: <linux-tip-commits+bounces-5230-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F481AA89B9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6860C7A66AF
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E316D9C2;
	Sun,  4 May 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stcnGy5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103A17BD9;
	Sun,  4 May 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746397842; cv=none; b=blSsHJA3uozlhFewvYxaHC4r7QxIYeY4XbtrncuVrSY8oFMXw2r9FaoQQF2F5bMPIgYUrzAUdxVMfyFoOPNQydSqM31MVE/oUTzSggHqGXxo5aeegzdq5fnxTL+Ms+4PkyFgDqF4Xbmk0zVCC6U/dy9XZNrfrqBdEDkw3iBoMSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746397842; c=relaxed/simple;
	bh=72R/lYceIJnJbBsVKju62bJw1eCFFK+MwoHbhFYYyi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7UxWk0vtJHqAC0U9hFHRhZqRzXGF/Vc1pEUAzZ4wizuZdRKYaQmtM5+/tMt7s+x2PVgixQkw4SWlSkhKlno00U+ErFEfvmt4rDgT0UhBhAVmAvTQgWLwk4X3UMsgStva2UdnUTRLfkoBovh1OGMIQcSAa0AUjJW6cqXrIUeoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stcnGy5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DEC4CEE7;
	Sun,  4 May 2025 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746397842;
	bh=72R/lYceIJnJbBsVKju62bJw1eCFFK+MwoHbhFYYyi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stcnGy5I5lz135i3sNLLlVi1A+ZZlC6hOyKMtlL9dbXIjUALRY6BjF+jShxaCoBBz
	 h4Hpn6O5AU3J/APvPcc2NUqAPlHf4eHJxW6V25U0fpGSLAI4OjruqTo4oRBiuxLbQe
	 X9vhpjmdiRitll/lpXYXyL0m9oCDTwaj6IjcTyQ0qG7kPh4BX6v1NVCuH1ugJukq3W
	 rZQ4MXCac4UQpXZyxT6Ap1tSPZ5FDeTbBbTs9ZgltbppJrzUW1PkWT+xyAZsByxByF
	 xfudzibDr9wP5AN3HlRuNPLfi7dGlWeOsykZpeb6DFX0eeP+vHnWMCy9OfTr7yP6TQ
	 ja5nmQ1A5E/1A==
Date: Sun, 4 May 2025 15:30:38 -0700
From: Kees Cook <kees@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: hardened_usercopy 32-bit (was: Re: [tip: x86/merge] x86/fpu:
 Make task_struct::thread constant size)
Message-ID: <202505041418.F47130C4C8@keescook>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>

On Sat, May 03, 2025 at 02:07:12PM +0200, Borislav Petkov wrote:
> On Mon, Apr 14, 2025 at 07:34:48AM -0000, tip-bot2 for Ingo Molnar wrote:
> > The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
> > now that the FPU structure is not embedded in the task struct anymore, which
> > reduces text footprint a bit.
> 
> Well, hardened usercopy still doesn't like it on 32-bit, see splat below:
> 
> I did some debugging printks and here's what I see:
> 
> That's the loop in copy_uabi_to_xstate(), copying the first FPU state
> - XFEATURE_FP - to the kernel buffer:
> 
> [    1.752756] copy_uabi_to_xstate: i: 0 dst: 0xcab11f40, offset: 0, size: 160, kbuf: 0x00000000, ubuf: 0xbfcbca80
> [    1.754600] copy_from_buffer: dst: 0xcab11f40, src: 0xbfcbca80, size: 160
> 
> hardened wants to check it:
> 
> [    1.755823] __check_heap_object: ptr: 0xcab11f40, slap_address: 0xcab10000, size: 2944
> [    1.757102] __check_heap_object: offset: 2112
> 
> and figures out it is in some weird offset 2112 from *task_struct* even
> though:
> 
> [    1.750149] copy_uabi_to_xstate: sizeof(task_struct): 1984
> 
> btw, the buffer is big enough too:
> 
> [    1.749077] copy_uabi_to_xstate: sizeof(&fpstate->regs.xsave): 576
> 
> but then it decides to BUG because an overwrite attempt is being done on
> task_struct which is bollocks now as struct fpu is not part of it anymore.
> 
> And this is where I'm all out of ideas so lemme CC folks.

I had to dig a bit to find the series -- this reply seems to have broken
threading with:
https://lore.kernel.org/all/20250409211127.3544993-1-mingo@kernel.org/

> 
> [    1.757898] __check_heap_object: will abort: offset: 2112, size: 160
> 
> [    1.758951] usercopy: Kernel memory overwrite attempt detected to SLUB object 'task_struct' (offset 2112, size 160)!

So the useroffset and usersize arguments are what control the allowed
window of copying in/out of the "task_struct" kmem cache:

        /* create a slab on which task_structs can be allocated */
        task_struct_whitelist(&useroffset, &usersize);
        task_struct_cachep = kmem_cache_create_usercopy("task_struct",
                        arch_task_struct_size, align,
                        SLAB_PANIC|SLAB_ACCOUNT,
                        useroffset, usersize, NULL);

task_struct_whitelist() positions this window based on the location of
the thread_struct within task_struct, and gets the arch-specific details
via arch_thread_struct_whitelist(offset, size):

static void __init task_struct_whitelist(unsigned long *offset, unsigned long *size)
{
        /* Fetch thread_struct whitelist for the architecture. */
        arch_thread_struct_whitelist(offset, size);

        /*
         * Handle zero-sized whitelist or empty thread_struct, otherwise
         * adjust offset to position of thread_struct in task_struct.
         */
        if (unlikely(*size == 0))
                *offset = 0;
        else
                *offset += offsetof(struct task_struct, thread);
}

Commit "x86/fpu: Make task_struct::thread constant size" removed the
logic for the window, leaving:

static inline void
arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
{
        *offset = 0;
        *size = 0;
}

So now there is no window that usercopy hardening will allow to be copied
in/out of task_struct.

> [    1.760651] ------------[ cut here ]------------
> [    1.761474] kernel BUG at mm/usercopy.c:102!
> [    1.762240] Oops: invalid opcode: 0000 [#1] SMP
> [    1.763063] CPU: 6 UID: 0 PID: 1182 Comm: rc Not tainted 6.15.0-rc2+ #35 PREEMPT(full) 
> [    1.764374] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    1.765952] EIP: usercopy_abort+0x79/0x88
> [    1.768411] Code: c1 89 44 24 0c 0f 45 cb 8b 5d 0c 89 74 24 10 89 4c 24 04 c7 04 24 98 f0 c5 c1 89 5c 24 20 8b 5d 08 89 5c 24 1c e8 d3 8b e7 ff <0f> 0b ba 89 8f ce c1 89 55 f0 89 d6 eb 97 90 3e 8d 74 26 00 85 d2
> [    1.771573] EAX: 00000068 EBX: 00000840 ECX: 00000000 EDX: 00000006
> [    1.772638] ESI: c1cdb354 EDI: c1ce0c9a EBP: cc751d40 ESP: cc751d0c
> [    1.773707] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010292
> [    1.774831] CR0: 80050033 CR2: 00511860 CR3: 0cde1000 CR4: 003506d0
> [    1.775921] Call Trace:
> [    1.776498]  __check_heap_object+0x117/0x14c
> [    1.777314]  __check_object_size+0x1af/0x250
> [    1.778129]  ? vprintk+0x13/0x1c
> [    1.778778]  copy_from_buffer+0xbc/0x114
> [    1.779498]  copy_uabi_to_xstate+0x1b7/0x31c
> [    1.780251]  copy_sigframe_from_user_to_xstate+0x27/0x34
> [    1.781171]  __fpu_restore_sig+0x4ae/0x4c4
> [    1.781954]  fpu__restore_sig+0x60/0xb0
> [    1.784487]  ia32_restore_sigcontext+0xe4/0x108
> [    1.785464]  __do_sys_sigreturn+0x66/0xac
> [    1.786191]  ia32_sys_call+0x226a/0x30e0
> [    1.786942]  do_int80_syscall_32+0x83/0x158
> [    1.787735]  entry_INT80_32+0x108/0x108

But as reported above, there *is* a copy in copy_uabi_to_xstate(). (It
seems there are several, actually.)

int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
                                      const void __user *ubuf)
{
        return copy_uabi_to_xstate(x86_task_fpu(tsk)->fpstate, NULL, ubuf, &tsk->thread.pkru);
}

This appears to be writing into x86_task_fpu(tsk)->fpstate. With or
without CONFIG_X86_DEBUG_FPU, this resolves to:

	((struct fpu *)((void *)(task) + sizeof(*(task))))

i.e. the memory "after task_struct" is cast to "struct fpu", and the
uses the "fpstate" pointer. How that pointer gets set looks to be
variable, but I think the one we care about here is:

        fpu->fpstate = &fpu->__fpstate;

And struct fpu::__fpstate says:

        struct fpstate                  __fpstate;
        /*
         * WARNING: '__fpstate' is dynamically-sized.  Do not put
         * anything after it here.
         */

So we're still dealing with a dynamically sized thing, even if it's not
within the literal struct task_struct -- it's still in the kmem cache,
though.

Looking at the kmem cache size, it has allocated "arch_task_struct_size"
bytes, which is calculated in fpu__init_task_struct_size():

        int task_size = sizeof(struct task_struct);

        task_size += sizeof(struct fpu);

        /*
         * Subtract off the static size of the register state.
         * It potentially has a bunch of padding.
         */
        task_size -= sizeof(union fpregs_state);

        /*
         * Add back the dynamically-calculated register state
         * size.
         */
        task_size += fpu_kernel_cfg.default_size;

        /*
         * We dynamically size 'struct fpu', so we require that
         * 'state' be at the end of 'it:
         */
        CHECK_MEMBER_AT_END_OF(struct fpu, __fpstate);

        arch_task_struct_size = task_size;

So, this is still copying out of the kmem cache for task_struct, and the
window seems unchanged (still fpu regs). This is what the window was
before:

void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
{
        *offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
        *size = fpu_kernel_cfg.default_size;
}

And the same commit I mentioned above removed it.

I think the misunderstanding is here:

>    The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
>    now that the FPU structure is not embedded in the task struct anymore, which
>    reduces text footprint a bit.

Yes, FPU is no longer in task_struct, but it IS in the kmem cache named
"task_struct", since the fpstate is still being allocated there.

This partial revert of the earlier mentioned commit, along with a
recalculation of the fpstate regs location, should fix it, and can get
squashed into the earlier mentioned commit:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index eaa7214d6953..ad33903dc92a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -522,14 +522,12 @@ extern struct fpu *x86_task_fpu(struct task_struct *task);
 # define x86_task_fpu(task)	((struct fpu *)((void *)(task) + sizeof(*(task))))
 #endif
 
-/*
- * X86 doesn't need any embedded-FPU-struct quirks:
- */
-static inline void
-arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
+extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
+
+static inline void arch_thread_struct_whitelist(unsigned long *offset,
+						unsigned long *size)
 {
-	*offset = 0;
-	*size = 0;
+	fpu_thread_struct_whitelist(offset, size);
 }
 
 static inline void
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3a19877a314e..e8188b0527cf 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -680,6 +680,20 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	return 0;
 }
 
+/*
+ * While struct fpu is no longer part of struct thread_struct, it is still
+ * allocated after struct task_struct in the "task_struct" kmem cache. But
+ * since FPU is expected to be part of struct thread_struct, we have to
+ * adjust for it here.
+ */
+void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
+{
+	/* The allocation follows struct task_struct. */
+	*offset = sizeof(struct task_struct) - offsetof(struct task_struct, thread);
+	*offset += offsetof(struct fpu, __fpstate.regs);
+	*size = fpu_kernel_cfg.default_size;
+}
+
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents


However, I can't test this patch -- I'm not able to reproduce the problem
either, even with your .config. What hardware are you using?

I assume that for me x86_task_fpu(tsk)->fpstate isn't pointing to struct
fpu::__fpstate. I'll keep digging...

-- 
Kees Cook

