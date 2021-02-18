Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5830C31EE5F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Feb 2021 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBRSdg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Feb 2021 13:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhBRQWF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Feb 2021 11:22:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BFFC061756;
        Thu, 18 Feb 2021 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdVzFVF2k1v6i9MjTgFGOmbcK/KECuqu0NlCYtFlsQQ=; b=NVGZK3NZOwb+NmR1Yt9f7RWtyz
        nyAaI/x/mOJxQBg462DNMvZSWoUEWgIa5MS+yLDxTKA+yj6N7EALOQdXJAHBmVSTiOIFeFiKt1gMh
        3fekHqJPl7qxVj7ZbG+1+ueDUJTBRcgRYiw+r9op4NWFHgP8OAEy0zgQYX9dY8XCPevQDZ4WUNvV5
        FMGWE1T7Vjm9DraYM5x9xRB4lvBGRCxziXjjruYumSl1Ti1O2h+mXrtF2sdwJuWTJUAotIyGDtlt+
        SL7BupLwJExQzVyXaxpA/a1NlnZTSnJIY59EMGioOKgSqJQkAor+z8rx3VSw05OVf8gxCuBmOEBqc
        /3JVY5dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lCm3b-0000zL-LY; Thu, 18 Feb 2021 16:21:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75E53300238;
        Thu, 18 Feb 2021 17:21:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A444202A3F7E; Thu, 18 Feb 2021 17:21:31 +0100 (CET)
Date:   Thu, 18 Feb 2021 17:21:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: [PATCH] objtool: Fix stack-swizzle for FRAME_POINTER=y
Message-ID: <YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net>
References: <161298728344.23325.15458416903870844675.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161298728344.23325.15458416903870844675.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Feb 10, 2021 at 08:01:23PM -0000, tip-bot2 for Peter Zijlstra wrote:
> objtool: Support stack-swizzle

---
Subject: objtool: Fix stack-swizzle for FRAME_POINTER=y
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Feb 18 17:14:10 CET 2021

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
---
 tools/objtool/check.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1996,6 +1996,20 @@ static int update_cfi_state(struct instr
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
