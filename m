Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3180222A1A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Jul 2020 23:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgGVVzq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbgGVVzj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 17:55:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7AC0619DC;
        Wed, 22 Jul 2020 14:55:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:55:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595454937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMB1u185xELWvtA2XnvmJscfBxUyPz4bqw9RjDthIVI=;
        b=3lMKpZG/UiGjsx6/N2dDssrsL3jVrUs5qDF+6q/Iq0Cm3o1RosA0QOaVUAlIcyF/pAwgAO
        jkezdH+vDeQjqCNHcvkdnctyhKq4Cs8H8goD4QGPWtGrq2Fa+126zRppfOfPOCmjZDpXCM
        ZOM5CCyShZJvxfdW+i73q9EQTUTEFBZP9KShreZWtYQ7AzLdyqICDNbfzjudiRdOuVd0zH
        IdAD0xuoimVXcgDz8aVzeYNyrpCfsF1u0dMUvss9FVr+6eDIXa4zFaXlAg6Km2oUTKnt6N
        eNCcq7Oo+YVRHzISOsU0zKMaJ0MA/rC2ZtlwXUKH/i5sfksjAePvh5mvuwrlpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595454937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMB1u185xELWvtA2XnvmJscfBxUyPz4bqw9RjDthIVI=;
        b=kjsOPflk0wpTa2tK3KGbDlupC+qxx5K7elor+2bG1p4fBKoX0NIC1D+KtjrC17/ldRPPs2
        yaoopoiR6+Gh6UAg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Fix ORC for newly forked tasks
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f91a8778dde8aae7f71884b5df2b16d552040441.1594994374.git.jpoimboe@redhat.com>
References: <f91a8778dde8aae7f71884b5df2b16d552040441.1594994374.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <159545493667.4006.9690401904155723707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     372a8eaa05998cd45b3417d0e0ffd3a70978211a
Gitweb:        https://git.kernel.org/tip/372a8eaa05998cd45b3417d0e0ffd3a70978211a
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 17 Jul 2020 09:04:25 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jul 2020 23:47:47 +02:00

x86/unwind/orc: Fix ORC for newly forked tasks

The ORC unwinder fails to unwind newly forked tasks which haven't yet
run on the CPU.  It correctly reads the 'ret_from_fork' instruction
pointer from the stack, but it incorrectly interprets that value as a
call stack address rather than a "signal" one, so the address gets
incorrectly decremented in the call to orc_find(), resulting in bad ORC
data.

Fix it by forcing 'ret_from_fork' frames to be signal frames.

Reported-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Link: https://lkml.kernel.org/r/f91a8778dde8aae7f71884b5df2b16d552040441.1594994374.git.jpoimboe@redhat.com

---
 arch/x86/kernel/unwind_orc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 7f969b2..ec88bbe 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -440,8 +440,11 @@ bool unwind_next_frame(struct unwind_state *state)
 	/*
 	 * Find the orc_entry associated with the text address.
 	 *
-	 * Decrement call return addresses by one so they work for sibling
-	 * calls and calls to noreturn functions.
+	 * For a call frame (as opposed to a signal frame), state->ip points to
+	 * the instruction after the call.  That instruction's stack layout
+	 * could be different from the call instruction's layout, for example
+	 * if the call was to a noreturn function.  So get the ORC data for the
+	 * call instruction itself.
 	 */
 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
 	if (!orc) {
@@ -662,6 +665,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp;
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
+		state->signal = (void *)state->ip == ret_from_fork;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,
