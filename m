Return-Path: <linux-tip-commits+bounces-5240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A03AA923E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 13:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1241895444
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB211FF60E;
	Mon,  5 May 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gk8ZF53a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUgyxaOo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9C1E5219;
	Mon,  5 May 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445418; cv=none; b=U9ECi3axbo8/4c1avlj8XM/OhTX2pDiAG1zvgLOX1EfMikkibecoRv9J0AnLymT8ViDUx8bCJd7pHb9CSyMVZQDzxl4+fPLC0yNLDNCuZz+7YBmC7k0dfmd2TfdrRvnE+52InWXm1wr8dU9GfUzmKz5QjhuikL46ZA+Go0n5SQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445418; c=relaxed/simple;
	bh=gUrhLh98uxjh0zegPMm+AoREjmn791EQcGfFdgz6q/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QcgcI7Y87jd93Qh1VFlpmgyHveaNmAeR03cV07Bq3jNNF1EyKHo0B7N7TigIYrXv22pqoQ9WrCQ2XaqoIcTUPebnKqJebzYAEJjlxggPL15AMrd2VrDTPVcPWKmEq6Qwdvw6XcUJRGVkJk1zXVM4rvi9xApLwARAvBBoT/C4cUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gk8ZF53a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kUgyxaOo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 11:43:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746445413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3qV84kubrP8h1aJ/Dasc0vKHhQrScDWYLE25IXJCHE=;
	b=Gk8ZF53aqyuiAoWnQaCjYe2HZYlX5QXIY9Irxk7ftC44JLgsDJ2lpQ7cEyWWs+hMA5s3wl
	wvw3FylzQnZig4p1QOpRIrOQ6jopbzMzawwqcq2ZwQRU8mrI3N7f4ygDiTePU5EkSEf2Wd
	Rn5U/QGVREaV7lay/Q2NarEmoGiDUOkfpPmPUtYEs7w2XDG/g0SxmU4bUwYJj1iJ91uk22
	1xGl72ekjm5001Vjdnifk9KcYl7fLtdhH01yD3B3OI7o1R8aDaj87NKd9rBMJfoCDibJMN
	qbXCD4OhFYPVdzvx3ll8hd+a0YhA9Iu5HXz/692biyh3F798+V+xbX/6ahHafA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746445413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3qV84kubrP8h1aJ/Dasc0vKHhQrScDWYLE25IXJCHE=;
	b=kUgyxaOo4hey+ETApz5phpIymhLBUNfr5cBIpOhJ0931axDji12pqW3BfuIpwhTlVXyM1D
	UdV77ePhZhlfihCw==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Restore fpu_thread_struct_whitelist() to fix
 CONFIG_HARDENED_USERCOPY=y crash
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Kees Cook <kees@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-hardening@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202505041418.F47130C4C8@keescook # Discussion #2>
References: <202505041418.F47130C4C8@keescook # Discussion #2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174644540908.22196.11861468097053965791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     960bc2bcba5987a82530b9756e1f602a894cffa4
Gitweb:        https://git.kernel.org/tip/960bc2bcba5987a82530b9756e1f602a894cffa4
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Sun, 04 May 2025 15:30:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 05 May 2025 13:24:32 +02:00

x86/fpu: Restore fpu_thread_struct_whitelist() to fix CONFIG_HARDENED_USERCOPY=y crash

Borislav Petkov reported the following boot crash on x86-32,
with CONFIG_HARDENED_USERCOPY=y:

  |  usercopy: Kernel memory overwrite attempt detected to SLUB object 'task_struct' (offset 2112, size 160)!
  |  ...
  |  kernel BUG at mm/usercopy.c:102!

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

Commit cb7ca40a3882 ("x86/fpu: Make task_struct::thread constant size")
removed the logic for the window, leaving:

	static inline void
	arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
	{
		*offset = 0;
		*size = 0;
	}

So now there is no window that usercopy hardening will allow to be copied
in/out of task_struct.

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

  | The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
  | now that the FPU structure is not embedded in the task struct anymore, which
  | reduces text footprint a bit.

Yes, FPU is no longer in task_struct, but it IS in the kmem cache named
"task_struct", since the fpstate is still being allocated there.

Partially revert the earlier mentioned commit, along with a
recalculation of the fpstate regs location.

Fixes: cb7ca40a3882 ("x86/fpu: Make task_struct::thread constant size")
Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/all/20250409211127.3544993-1-mingo@kernel.org/ # Discussion #1
Link: https://lore.kernel.org/r/202505041418.F47130C4C8@keescook             # Discussion #2
---
 arch/x86/include/asm/processor.h | 12 +++++-------
 arch/x86/kernel/fpu/core.c       | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index eaa7214..ad33903 100644
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
index fa13129..105b1b8 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -681,6 +681,20 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 }
 
 /*
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
+/*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
  * in the fpregs in the eager-FPU case.

