Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5923915F7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhEZL0g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhEZL0N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:13 -0400
Date:   Wed, 26 May 2021 11:24:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xt5Go3Q0R+yJP8RlzmTY90RqFsaB7/2Mm4457cjm1Cc=;
        b=JJHO3rVjn1565wBKzIyC//6if+BbS2Vc8MpNaSXQtHipVvLdqtuOn8URXOVlKY6QPYwp5i
        Dm+vOdwFekXLizBNwSkaOhmuwpUbyoUPRtZDbJouW7GxqSN3DbkXKH7pFT3alCF2SQbqfI
        2QJAfJeEYXRT2oP+nEPS1Xyt7VH3sbHZGDIc6UkFGfjynKrAXTR/a2XPhen5j8w/bjRdop
        +We28Mq84z2f8D3BjCu06QJ6QUj0wr7GjWpNfzfdFjzzG7+vNm/72Np0r+dCQA8nIm460o
        m7uo/EGz8wRw/H+16np9euBLjmI4nVLOpHmb5TWbBlBWhd+gCN+Z4QUz88ZY1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xt5Go3Q0R+yJP8RlzmTY90RqFsaB7/2Mm4457cjm1Cc=;
        b=KOCQpNrmAH/Y4ibAjHy+N2ZdIujy8CM9CcXC2fuRpKyoSGA0KOvivpdf3oSJh5QWysgmNh
        4DPw4uraL92t5pDQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: atomic: simplify ifdeffery
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-9-mark.rutland@arm.com>
References: <20210525140232.53872-9-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827997.29796.12484539820351813813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d0e03218ca3be48c6f7109e4810d58e7b7dd4135
Gitweb:        https://git.kernel.org/tip/d0e03218ca3be48c6f7109e4810d58e7b7dd4135
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: atomic: simplify ifdeffery

Now that asm-generic/atomic.h is only used by architectures without any
architecture-specific atomic definitions, we know that there will be no
architecture-specific implementations to override, and can remove the
ifdeffery this has previously required, bringing it into line with
asm-generic/atomic64.h.

At the same time, we can implement atomic_add() and atomic_sub()
directly using ATOMIC_OP(), since we know architectures won't provide
atomic_add_return() or atomic_sub_return().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-9-mark.rutland@arm.com
---
 include/asm-generic/atomic.h | 46 +++--------------------------------
 1 file changed, 4 insertions(+), 42 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index d4bf803..316c82a 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -93,65 +93,27 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 
 #endif /* CONFIG_SMP */
 
-#ifndef atomic_add_return
 ATOMIC_OP_RETURN(add, +)
-#endif
-
-#ifndef atomic_sub_return
 ATOMIC_OP_RETURN(sub, -)
-#endif
 
-#ifndef atomic_fetch_add
 ATOMIC_FETCH_OP(add, +)
-#endif
-
-#ifndef atomic_fetch_sub
 ATOMIC_FETCH_OP(sub, -)
-#endif
-
-#ifndef atomic_fetch_and
 ATOMIC_FETCH_OP(and, &)
-#endif
-
-#ifndef atomic_fetch_or
 ATOMIC_FETCH_OP(or, |)
-#endif
-
-#ifndef atomic_fetch_xor
 ATOMIC_FETCH_OP(xor, ^)
-#endif
 
-#ifndef atomic_and
+ATOMIC_OP(add, +)
+ATOMIC_OP(sub, -)
 ATOMIC_OP(and, &)
-#endif
-
-#ifndef atomic_or
 ATOMIC_OP(or, |)
-#endif
-
-#ifndef atomic_xor
 ATOMIC_OP(xor, ^)
-#endif
 
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#ifndef atomic_read
-#define atomic_read(v)	READ_ONCE((v)->counter)
-#endif
-
-#define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
-
-static inline void atomic_add(int i, atomic_t *v)
-{
-	atomic_add_return(i, v);
-}
-
-static inline void atomic_sub(int i, atomic_t *v)
-{
-	atomic_sub_return(i, v);
-}
+#define atomic_read(v)			READ_ONCE((v)->counter)
+#define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
 
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
