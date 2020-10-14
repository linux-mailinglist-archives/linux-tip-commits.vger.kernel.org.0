Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF628E4D7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbgJNQuy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388548AbgJNQuw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 12:50:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23056C061755;
        Wed, 14 Oct 2020 09:50:52 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:50:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602694250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+k77Cf7s7IV5cFwZWQ/Whap8Hip+n6bkaLrJX2k69o=;
        b=0NR/Z4M03xsqzMMtQCvGuqFY619X9M7hK1j+EOZgw92vEW8ebDh9GpelDNhW+Zm67lk40o
        2MyKD8ZtrsoUWiHRn9q1vUsyiYXHnwui4ylX8XfzJuWVsqXum+zT9JfvH7m9R8YIMjCs+Q
        1XO0hw7Wlm7a4X2wu1j9MjXkBnpSWfz54/Y1eNjIsb3j7fvrWc+JCxNeevnrtfIQ2owebR
        SQZb3uwFrL630ko1jK9DuQlPxyWhCyhCPKC+wFcKhefMNqkNYwFcgLo1eadeZrQ/2P9VDS
        zlxbcVBfIq/Q2cznH8g8IYtJJk3dL9yBQztIhsl4ZD+rsiG02T/UtYGBuyaxmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602694250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+k77Cf7s7IV5cFwZWQ/Whap8Hip+n6bkaLrJX2k69o=;
        b=Yb4nKO922GahxlSWB/c53pVIkwi8n+2Ne6HcKJjuIr9F2ywtNJ4qfdlq8XK/ckUYm0PcPd
        Wi5aSUay2WPJFPBg==
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Fix inactive tasks with stack
 pointer in %sp on GCC 10 compiled kernels
Cc:     Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201014053051.24199-1-jslaby@suse.cz>
References: <20201014053051.24199-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <160269424957.7002.1369957578041828082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f2ac57a4c49d40409c21c82d23b5706df9b438af
Gitweb:        https://git.kernel.org/tip/f2ac57a4c49d40409c21c82d23b5706df9b438af
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Wed, 14 Oct 2020 07:30:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 Oct 2020 18:01:51 +02:00

x86/unwind/orc: Fix inactive tasks with stack pointer in %sp on GCC 10 compiled kernels

GCC 10 optimizes the scheduler code differently than its predecessors.

When CONFIG_DEBUG_SECTION_MISMATCH=y, the Makefile forces GCC not
to inline some functions (-fno-inline-functions-called-once). Before GCC
10, "no-inlined" __schedule() starts with the usual prologue:

  push %bp
  mov %sp, %bp

So the ORC unwinder simply picks stack pointer from %bp and
unwinds from __schedule() just perfectly:

  $ cat /proc/1/stack
  [<0>] ep_poll+0x3e9/0x450
  [<0>] do_epoll_wait+0xaa/0xc0
  [<0>] __x64_sys_epoll_wait+0x1a/0x20
  [<0>] do_syscall_64+0x33/0x40
  [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

But now, with GCC 10, there is no %bp prologue in __schedule():

  $ cat /proc/1/stack
  <nothing>

The ORC entry of the point in __schedule() is:

  sp:sp+88 bp:last_sp-48 type:call end:0

In this case, nobody subtracts sizeof "struct inactive_task_frame" in
__unwind_start(). The struct is put on the stack by __switch_to_asm() and
only then __switch_to_asm() stores %sp to task->thread.sp. But we start
unwinding from a point in __schedule() (stored in frame->ret_addr by
'call') and not in __switch_to_asm().

So for these example values in __unwind_start():

  sp=ffff94b50001fdc8 bp=ffff8e1f41d29340 ip=__schedule+0x1f0

The stack is:

  ffff94b50001fdc8: ffff8e1f41578000 # struct inactive_task_frame
  ffff94b50001fdd0: 0000000000000000
  ffff94b50001fdd8: ffff8e1f41d29340
  ffff94b50001fde0: ffff8e1f41611d40 # ...
  ffff94b50001fde8: ffffffff93c41920 # bx
  ffff94b50001fdf0: ffff8e1f41d29340 # bp
  ffff94b50001fdf8: ffffffff9376cad0 # ret_addr (and end of the struct)

0xffffffff9376cad0 is __schedule+0x1f0 (after the call to
__switch_to_asm).  Now follow those 88 bytes from the ORC entry (sp+88).
The entry is correct, __schedule() really pushes 48 bytes (8*7) + 32 bytes
via subq to store some local values (like 4U below). So to unwind, look
at the offset 88-sizeof(long) = 0x50 from here:

  ffff94b50001fe00: ffff8e1f41578618
  ffff94b50001fe08: 00000cc000000255
  ffff94b50001fe10: 0000000500000004
  ffff94b50001fe18: 7793fab6956b2d00 # NOTE (see below)
  ffff94b50001fe20: ffff8e1f41578000
  ffff94b50001fe28: ffff8e1f41578000
  ffff94b50001fe30: ffff8e1f41578000
  ffff94b50001fe38: ffff8e1f41578000
  ffff94b50001fe40: ffff94b50001fed8
  ffff94b50001fe48: ffff8e1f41577ff0
  ffff94b50001fe50: ffffffff9376cf12

Here                ^^^^^^^^^^^^^^^^ is the correct ret addr from
__schedule(). It translates to schedule+0x42 (insn after a call to
__schedule()).

BUT, unwind_next_frame() tries to take the address starting from
0xffff94b50001fdc8. That is exactly from thread.sp+88-sizeof(long) =
0xffff94b50001fdc8+88-8 = 0xffff94b50001fe18, which is garbage marked as
NOTE above. So this quits the unwinding as 7793fab6956b2d00 is obviously
not a kernel address.

There was a fix to skip 'struct inactive_task_frame' in
unwind_get_return_address_ptr in the following commit:

  187b96db5ca7 ("x86/unwind/orc: Fix unwind_get_return_address_ptr() for inactive tasks")

But we need to skip the struct already in the unwinder proper. So
subtract the size (increase the stack pointer) of the structure in
__unwind_start() directly. This allows for removal of the code added by
commit 187b96db5ca7 completely, as the address is now at
'(unsigned long *)state->sp - 1', the same as in the generic case.

[ mingo: Cleaned up the changelog a bit, for better readability. ]

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Bug: https://bugzilla.suse.com/show_bug.cgi?id=1176907
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20201014053051.24199-1-jslaby@suse.cz
---
 arch/x86/kernel/unwind_orc.c |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index ec88bbe..4a96aa3 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -320,19 +320,12 @@ EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
 unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
 {
-	struct task_struct *task = state->task;
-
 	if (unwind_done(state))
 		return NULL;
 
 	if (state->regs)
 		return &state->regs->ip;
 
-	if (task != current && state->sp == task->thread.sp) {
-		struct inactive_task_frame *frame = (void *)task->thread.sp;
-		return &frame->ret_addr;
-	}
-
 	if (state->sp)
 		return (unsigned long *)state->sp - 1;
 
@@ -662,7 +655,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	} else {
 		struct inactive_task_frame *frame = (void *)task->thread.sp;
 
-		state->sp = task->thread.sp;
+		state->sp = task->thread.sp + sizeof(*frame);
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
 		state->signal = (void *)state->ip == ret_from_fork;
