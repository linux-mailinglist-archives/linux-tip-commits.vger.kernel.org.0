Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E489321F86
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Feb 2021 20:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhBVTBr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Feb 2021 14:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBVTB2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Feb 2021 14:01:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CD7C061574;
        Mon, 22 Feb 2021 11:00:45 -0800 (PST)
Date:   Mon, 22 Feb 2021 19:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614020443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lWVThWWW120b40py9SEfpfJ6+LZ0pQpx9X9WzPghyRU=;
        b=JC0xplThiFyXbJAtDB6dxBnCenqKEBTZwX2VGOZNxsEXXJzi1TX2w/2KEKce8hU4zTKC4t
        JQgSsKXVATCiD3AnWnCL54UJ2OruFxRtwLRdqrUtVctphBsRSAtuum0Dhn2DJSrmNRdcxR
        JP9OEWvrtwT6ej/vVG68fbaKTb3M+T4/Y6YMMMSeN8afpfeand3Xd4SZviHTAt3ln/N4Ad
        lMTge75FFBE1nQhjcsBeB7N23ck1Of+w7p1O+/iRr4LK1d2TP0usbVFKtKMln1ZEt8HyOH
        BeZA4Qb3Xi2ibixo1K5aZedZlffvRO9ZH/mKJe7gAxPwMfqUJC77BhJP2ddH3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614020443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lWVThWWW120b40py9SEfpfJ6+LZ0pQpx9X9WzPghyRU=;
        b=WHzP11fddJXXl5dU1unsMMk9Asn6MVaoij6YfSewDUE5N4lKg4AuvxyAasq7F7DeY11NwR
        jzB0CP5HpvfW3uBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] objtool: Fix stack-swizzle for FRAME_POINTER=y
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net>
References: <YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161402044196.20312.1227982664394404231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     724c8a23d589d8a002d2e39633c2f9a5a429616f
Gitweb:        https://git.kernel.org/tip/724c8a23d589d8a002d2e39633c2f9a5a429616f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Feb 2021 17:14:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Feb 2021 19:54:09 +01:00

objtool: Fix stack-swizzle for FRAME_POINTER=y

When objtool encounters the stack-swizzle:

	mov %rsp, (%[tos])
	mov %[tos], %rsp
	...
	pop %rsp

Inside a FRAME_POINTER=y build, things go a little screwy because
clearly we're not adjusting the cfa->base. This then results in the
pop %rsp not being detected as a restore of cfa->base so it will turn
into a regular POP and offset the stack, resulting in:

  kernel/softirq.o: warning: objtool: do_softirq()+0xdb: return with modified stack frame

Therefore, have "mov %[tos], %rsp" act like a PUSH (it sorta is
anyway) to balance the things out. We're not too concerned with the
actual stack_size for frame-pointer builds, since we don't generate
ORC data for them anyway.

Fixes: aafeb14e9da2 ("objtool: Support stack-swizzle")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net
---
 tools/objtool/check.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8e74210..2087974 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1983,6 +1983,20 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				}
 			}
 
+			else if (op->dest.reg == CFI_SP &&
+				 cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+				 cfi->vals[op->src.reg].offset == cfa->offset) {
+
+				/*
+				 * The same stack swizzle case 2) as above. But
+				 * because we can't change cfa->base, case 3)
+				 * will become a regular POP. Pretend we're a
+				 * PUSH so things don't go unbalanced.
+				 */
+				cfi->stack_size += 8;
+			}
+
+
 			break;
 
 		case OP_SRC_ADD:
