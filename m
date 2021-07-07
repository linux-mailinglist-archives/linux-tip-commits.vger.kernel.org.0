Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557D73BE4C3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 10:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGGI4K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 04:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhGGI4J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 04:56:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC7C061574;
        Wed,  7 Jul 2021 01:53:29 -0700 (PDT)
Date:   Wed, 07 Jul 2021 08:53:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625648003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCHCWp8ndiR6lOv98SSA62tiZhc4JfuP0/2leH5eEtw=;
        b=rAaisTgJhJqgj2qjA0O6nWzA4nVGtiM/u7YN3G/68GpBzC+TOAssTTEjmYg98Mgmevhb6B
        6tRiLvHjuccnZdg4UPqpuXeK3zeVRiN6gppWyNhkQdpuRX1mQcUV+WA1JDuKMPM/IVWU8K
        pwkmoaPMITzV7qK1xHZti2K+4vYM24TNyargaAoCb+ngk8CqShFEATcFqdbHTWvWPYvwlI
        MgfKm/xCeNSJ/hSEbVzMwq6OkJvf1p2Vw+pVdSv1PQSNCti8DlHIX5oNBRKY1vdXpCXEoa
        7BHu0H1+3md0ufj1M06bXwYRPaZX/aahjM+bBXHWH7bxKJAwYJSK3NBv0E77xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625648003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCHCWp8ndiR6lOv98SSA62tiZhc4JfuP0/2leH5eEtw=;
        b=o0dghBrpePW7Sbd3aTpBjENR64n5Zb2aeyx16FanTV4dTEou3YjLPa900M2iItuyTYq+hC
        pw1VOd0DY/6R1HDQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/atomic: sparc: Fix arch_cmpxchg64_local()
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210707083032.567-1-mark.rutland@arm.com>
References: <20210707083032.567-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162564800212.395.6261331440225066736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     7e1088760cfe0bb1fdb1f0bd155bfd52f080683a
Gitweb:        https://git.kernel.org/tip/7e1088760cfe0bb1fdb1f0bd155bfd52f080683a
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 07 Jul 2021 09:30:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 07 Jul 2021 10:47:21 +02:00

locking/atomic: sparc: Fix arch_cmpxchg64_local()

Anatoly reports that since commit:

  ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")

... it's possible to reliably trigger an oops by running:

  stress-ng -v --mmap 1 -t 30s

... which results in a NULL pointer dereference in
__split_huge_pmd_locked().

The underlying problem is that commit ff5b4f1ed580c59d left
arch_cmpxchg64_local() defined in terms of cmpxchg_local() rather than
arch_cmpxchg_local(). In <asm-generic/atomic-instrumented.h> we wrap
these with macros which use identically-named variables. When
cmpxchg_local() nests inside cmpxchg64_local(), this casues it to use an
unitialized variable as the pointer, which can be NULL.

This can also be seen in pmdp_establish(), where the compiler can
generate the pointer with a `clr` instruction:

0000000000000360 <pmdp_establish>:
 360:   9d e3 bf 50     save  %sp, -176, %sp
 364:   fa 5e 80 00     ldx  [ %i2 ], %i5
 368:   82 10 00 1b     mov  %i3, %g1
 36c:   84 10 20 00     clr  %g2
 370:   c3 f0 90 1d     casx  [ %g2 ], %i5, %g1
 374:   80 a7 40 01     cmp  %i5, %g1
 378:   32 6f ff fc     bne,a   %xcc, 368 <pmdp_establish+0x8>
 37c:   fa 5e 80 00     ldx  [ %i2 ], %i5
 380:   d0 5e 20 40     ldx  [ %i0 + 0x40 ], %o0
 384:   96 10 00 1b     mov  %i3, %o3
 388:   94 10 00 1d     mov  %i5, %o2
 38c:   92 10 00 19     mov  %i1, %o1
 390:   7f ff ff 84     call  1a0 <__set_pmd_acct>
 394:   b0 10 00 1d     mov  %i5, %i0
 398:   81 cf e0 08     return  %i7 + 8
 39c:   01 00 00 00     nop

This patch fixes the problem by defining arch_cmpxchg64_local() in terms
of arch_cmpxchg_local(), avoiding potential shadowing, and resulting in
working cmpxchg64_local() and variants, e.g.

0000000000000360 <pmdp_establish>:
 360:   9d e3 bf 50     save  %sp, -176, %sp
 364:   fa 5e 80 00     ldx  [ %i2 ], %i5
 368:   82 10 00 1b     mov  %i3, %g1
 36c:   c3 f6 90 1d     casx  [ %i2 ], %i5, %g1
 370:   80 a7 40 01     cmp  %i5, %g1
 374:   32 6f ff fd     bne,a   %xcc, 368 <pmdp_establish+0x8>
 378:   fa 5e 80 00     ldx  [ %i2 ], %i5
 37c:   d0 5e 20 40     ldx  [ %i0 + 0x40 ], %o0
 380:   96 10 00 1b     mov  %i3, %o3
 384:   94 10 00 1d     mov  %i5, %o2
 388:   92 10 00 19     mov  %i1, %o1
 38c:   7f ff ff 85     call  1a0 <__set_pmd_acct>
 390:   b0 10 00 1d     mov  %i5, %i0
 394:   81 cf e0 08     return  %i7 + 8
 398:   01 00 00 00     nop
 39c:   01 00 00 00     nop

Fixes: ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Anatoly Pugachev <matorola@gmail.com>
Link: https://lore.kernel.org/r/20210707083032.567-1-mark.rutland@arm.com
---
 arch/sparc/include/asm/cmpxchg_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 8c39a99..12d00a4 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -201,7 +201,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 #define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));					\
   })
 #define arch_cmpxchg64(ptr, o, n)	arch_cmpxchg64_local((ptr), (o), (n))
 
