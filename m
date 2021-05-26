Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F5391601
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhEZL1A (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbhEZL0R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9284C061756;
        Wed, 26 May 2021 04:24:43 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRqnz9A7+pQnsag16SAT2TNy2VNdTePpecGWzat4ljo=;
        b=StOHIj89HeLGca4Qvc0YZo+25YFHkGTfj6VCExjNhoFUL6a2ks5IfNaMOIKKUoY8KEmAjS
        4dKNM/oSrkDX9bF+88khQRRU/1MwPf3Kcn7ZRlWhnJxv/dumX86hI+NVJLRe6cM7OgVUhI
        vGqNTZ7++/ynPJfMr4tZcBrhboSiyJ7A2c4z0tUCo5nFEfpwlObU8MKNe0WIOPk9ywXomX
        iHoov5I4ky4FeNHcWewS37LdkBQEMWPiX8PtSt+QvHFtwifX5RqGejslJJnTIjgAwPASVO
        pN2h96mczz8gCR3jYHCoP/AopyFqk619IdYcWCfTLV1GmFIeeYKoMfrbDzJB0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRqnz9A7+pQnsag16SAT2TNy2VNdTePpecGWzat4ljo=;
        b=ftYebBzKPvVF3biusiRzRQc07eMa2AcZLXDEAdcsTV6Sd2r/Y6QGMn05QIK1pvlyrzbGfy
        GH2Hiko6zUM+doDg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: microblaze: use asm-generic exclusively
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-5-mark.rutland@arm.com>
References: <20210525140232.53872-5-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202828176.29796.9071444268768311520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b68622a86c8f30423c0a09204b1db2b74a06b5f0
Gitweb:        https://git.kernel.org/tip/b68622a86c8f30423c0a09204b1db2b74a06b5f0
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:49 +02:00

locking/atomic: microblaze: use asm-generic exclusively

Microblaze provides its own implementation of atomic_dec_if_positive(),
but nothing else. For a while now, the conditional inc/dec ops have been
optional, and the core code will provide generic implementations using
the code templates in scripts/atomic/fallbacks/.

For simplicity, and for consistency with the other conditional atomic
ops, let's drop the microblaze implementation of
atomic_dec_if_positive(), and use the generic implementation.

With that, we can also drop the local asm/atomic.h and asm/cmpxchg.h
headers, as asm-generic/atomic.h is mandatory-y, and we can pull in
asm-generic/cmpxchg.h via generic-y. This matches what nios2 and nds32
do today.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-5-mark.rutland@arm.com
---
 arch/microblaze/include/asm/Kbuild    |  1 +-
 arch/microblaze/include/asm/atomic.h  | 28 +--------------------------
 arch/microblaze/include/asm/cmpxchg.h |  9 +--------
 3 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/atomic.h
 delete mode 100644 arch/microblaze/include/asm/cmpxchg.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 29b0e55..a055f5d 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
+generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/microblaze/include/asm/atomic.h b/arch/microblaze/include/asm/atomic.h
deleted file mode 100644
index 41e9aff..0000000
--- a/arch/microblaze/include/asm/atomic.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_MICROBLAZE_ATOMIC_H
-#define _ASM_MICROBLAZE_ATOMIC_H
-
-#include <asm/cmpxchg.h>
-#include <asm-generic/atomic.h>
-#include <asm-generic/atomic64.h>
-
-/*
- * Atomically test *v and decrement if it is greater than 0.
- * The function returns the old value of *v minus 1.
- */
-static inline int atomic_dec_if_positive(atomic_t *v)
-{
-	unsigned long flags;
-	int res;
-
-	local_irq_save(flags);
-	res = v->counter - 1;
-	if (res >= 0)
-		v->counter = res;
-	local_irq_restore(flags);
-
-	return res;
-}
-#define atomic_dec_if_positive atomic_dec_if_positive
-
-#endif /* _ASM_MICROBLAZE_ATOMIC_H */
diff --git a/arch/microblaze/include/asm/cmpxchg.h b/arch/microblaze/include/asm/cmpxchg.h
deleted file mode 100644
index 3523b51..0000000
--- a/arch/microblaze/include/asm/cmpxchg.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_MICROBLAZE_CMPXCHG_H
-#define _ASM_MICROBLAZE_CMPXCHG_H
-
-#ifndef CONFIG_SMP
-# include <asm-generic/cmpxchg.h>
-#endif
-
-#endif /* _ASM_MICROBLAZE_CMPXCHG_H */
