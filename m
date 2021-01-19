Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E09C2FBA39
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Jan 2021 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbhASOr4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Jan 2021 09:47:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33716 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389674AbhASKOd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Jan 2021 05:14:33 -0500
Date:   Tue, 19 Jan 2021 10:12:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611051164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFacRMSOb7hOnhvpjeolZBzHLmtKYD7fT/MNfH3SARE=;
        b=lCvNUp8EfxWyf7a7O5pLl49dthf8urDB72BPmppRb40uVafg0BVKoTMvGp27MedtGVwohW
        +VI+xs7lRvmy18jojVofzfltweZ5AB/CjCRHd62FL1g6vGlI4wHDaI9im2jtw9M7sKvzLa
        nGlg7TXwhEqOlawyxv8DhLVrTWvrv5BvQf1O9P6r1vZA/ukmRwTK5STPnKrhgTh36bRBfw
        PxBUxanbl+RQdAY7MBvXKCUKfcYJwQoWNfCiggC09xPMpj3spSH0fgtYkM/ule9g8nwZOH
        dQsUxdLoNf57G662F+RBaI4NzkhYYEMwrVs8aSl1Y1ITYaj7Bid95Dr72nLNdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611051164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFacRMSOb7hOnhvpjeolZBzHLmtKYD7fT/MNfH3SARE=;
        b=q6iRzVtPaOw5J+HQy1NqlJfqvHmdxn4F+h2BlOsswp3md9QffMUi9TMU+YlOypPAomlkMs
        RrmacdLDb0rZSNCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YAAszZJ2GcIYZmB5@hirez.programming.kicks-ass.net>
References: <YAAszZJ2GcIYZmB5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161105116343.414.12774166706996994964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0bab9cb2d980d7c075cffb9216155f7835237f98
Gitweb:        https://git.kernel.org/tip/0bab9cb2d980d7c075cffb9216155f7835237f98
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 14 Jan 2021 14:25:35 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 Jan 2021 11:06:14 +01:00

x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument

That logic is unused since

  320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")

Remove it.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/YAAszZJ2GcIYZmB5@hirez.programming.kicks-ass.net
---
 arch/x86/entry/thunk_64.S | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index c9a9fbf..496b11e 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -10,7 +10,7 @@
 #include <asm/export.h>
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
-	.macro THUNK name, func, put_ret_addr_in_rdi=0
+	.macro THUNK name, func
 SYM_FUNC_START_NOALIGN(\name)
 	pushq %rbp
 	movq %rsp, %rbp
@@ -25,11 +25,6 @@ SYM_FUNC_START_NOALIGN(\name)
 	pushq %r10
 	pushq %r11
 
-	.if \put_ret_addr_in_rdi
-	/* 8(%rbp) is return addr on stack */
-	movq 8(%rbp), %rdi
-	.endif
-
 	call \func
 	jmp  __thunk_restore
 SYM_FUNC_END(\name)
