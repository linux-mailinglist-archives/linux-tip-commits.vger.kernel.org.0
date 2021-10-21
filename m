Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B862C436564
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhJUPOy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhJUPOs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CEC061348;
        Thu, 21 Oct 2021 08:12:32 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJMw53f+phiMRL6URP59CAjuawKMUXWtEKTAGr1dtRc=;
        b=x3L0mXsFnY9wBopTqjmTTYsN7EkTMlbvUx6u0diI1tNPK7KhypwJ8fy53meruP3BRy5zJd
        2cVaIXOOf4fkHIjwP4kRW7uW/AmVLNqylLiSA1p03EXaxUXYVOMa+5ZSSqyibTEMsET3SY
        YvGIg1a0+LznaJJnVMaOvaOWZnBdOEYWY+5+JH/cbT+y4ZBQ19dl5IoAraPgKPyiaflSdV
        +kkBsDwIR+/lMtwZdr2wa57cH5+TFPGxRmPJ3a0OXbWr1fWMLspFqIe8kS8HqbUeNNg7VB
        1bqwJVzCDagJ9X9EU016ehknpD/qtpRmq5vXYTivkGU8vH5Qjufjtxx8PV2skQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJMw53f+phiMRL6URP59CAjuawKMUXWtEKTAGr1dtRc=;
        b=iO3Rn8JyZpZ5F2y3ejQ9S55z5xgGjvaLsas9mFCgHdNpQy+uD0PbMBf3DvyrSUoZ241Vct
        r0ihWiTWNM16NDAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove fpu::state
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.765063318@linutronix.de>
References: <20211013145322.765063318@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915071.25758.11992072412602139420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2f27b5034244c4ebd70c90066defa771a99a5320
Gitweb:        https://git.kernel.org/tip/2f27b5034244c4ebd70c90066defa771a99a5320
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:42 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 23:58:29 +02:00

x86/fpu: Remove fpu::state

All users converted. Remove it along with the sanity checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.765063318@linutronix.de
---
 arch/x86/include/asm/fpu/types.h | 18 +++++++-----------
 arch/x86/kernel/fpu/init.c       |  4 ----
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 3bb6277..297e3b4 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -352,20 +352,16 @@ struct fpu {
 	struct fpstate			*fpstate;
 
 	/*
-	 * @state:
+	 * @__fpstate:
 	 *
-	 * In-memory copy of all FPU registers that we save/restore
-	 * over context switches. If the task is using the FPU then
-	 * the registers in the FPU are more recent than this state
-	 * copy. If the task context-switches away then they get
-	 * saved here and represent the FPU state.
+	 * Initial in-memory storage for FPU registers which are saved in
+	 * context switch and when the kernel uses the FPU. The registers
+	 * are restored from this storage on return to user space if they
+	 * are not longer containing the tasks FPU register state.
 	 */
-	union {
-		struct fpstate			__fpstate;
-		union fpregs_state		state;
-	};
+	struct fpstate			__fpstate;
 	/*
-	 * WARNING: 'state' is dynamically-sized.  Do not put
+	 * WARNING: '__fpstate' is dynamically-sized.  Do not put
 	 * anything after it here.
 	 */
 };
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index b524cd0..cffbaf4 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -184,10 +184,6 @@ static void __init fpu__init_task_struct_size(void)
 	CHECK_MEMBER_AT_END_OF(struct thread_struct, fpu);
 	CHECK_MEMBER_AT_END_OF(struct task_struct, thread);
 
-	BUILD_BUG_ON(sizeof(struct fpstate) != sizeof(union fpregs_state));
-	BUILD_BUG_ON(offsetof(struct thread_struct, fpu.state) !=
-		     offsetof(struct thread_struct, fpu.__fpstate));
-
 	arch_task_struct_size = task_size;
 }
 
