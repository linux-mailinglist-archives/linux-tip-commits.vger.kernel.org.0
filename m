Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12C7333B54
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Mar 2021 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhCJL0l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Mar 2021 06:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhCJL0W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Mar 2021 06:26:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88592C06174A;
        Wed, 10 Mar 2021 03:26:22 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615375581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvrjFJMYhdryqo7+gfIubxeOurLBJ8nG/pBVN7R1ETM=;
        b=Z+PzM1znCYLOrLZjpWz85EteG6HVzTK8f1AzjY77IUnNr3Y7JdwYJzTgIQ3tQ01DZeJzhm
        4YtDANaFJFr2AcBtNGJJ9TsPpg8vyIp1QInDxaEIn6gSoL4Mmtva2LMgu9HrEbFVfVJC7B
        wRlqQikkRLkBXaGtlG55ZDCwoeKHCbxqwBRPGgkXtCfK+UDBu3emwRW1NtjM/8SBzNO8jB
        s/tSlBEQN7+1w++7C/o8EmHJEkKcbbCJRcUbTxIroip6RB4HFDC5K0Kzy7UO3CTqQQ8E6r
        THAYkLTxRn7SKy7fWo5v70ElcVBGOM0elE8ebMaDTLjNRy6HSwgSr4UVjIVqPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615375581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvrjFJMYhdryqo7+gfIubxeOurLBJ8nG/pBVN7R1ETM=;
        b=Gw9QhcKFUfTQS8qFsbK1YmWe4Vpcu3L7dYxOfsiJZ6FZI+nkZy8Lj5OSBD2C7MP+N5b9LM
        /KN2gEyx1o/qVZAA==
From:   "tip-bot2 for Clement Courbet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Optimize __calc_delta()
Cc:     Clement Courbet <courbet@google.com>,
        Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210303224653.2579656-1-joshdon@google.com>
References: <20210303224653.2579656-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <161537558053.398.12604635982582934903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1e17fb8edc5ad6587e9303ccdebce853bc8cf30c
Gitweb:        https://git.kernel.org/tip/1e17fb8edc5ad6587e9303ccdebce853bc8=
cf30c
Author:        Clement Courbet <courbet@google.com>
AuthorDate:    Wed, 03 Mar 2021 14:46:53 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Mar 2021 09:51:49 +01:00

sched: Optimize __calc_delta()

A significant portion of __calc_delta() time is spent in the loop
shifting a u64 by 32 bits. Use `fls` instead of iterating.

This is ~7x faster on benchmarks.

The generic `fls` implementation (`generic_fls`) is still ~4x faster
than the loop.
Architectures that have a better implementation will make use of it. For
example, on x86 we get an additional factor 2 in speed without dedicated
implementation.

On GCC, the asm versions of `fls` are about the same speed as the
builtin. On Clang, the versions that use fls are more than twice as
slow as the builtin. This is because the way the `fls` function is
written, clang puts the value in memory:
https://godbolt.org/z/EfMbYe. This bug is filed at
https://bugs.llvm.org/show_bug.cgi?idI406.

```
name                                   cpu/op
BM_Calc<__calc_delta_loop>             9.57ms =C3=82=3DB112%
BM_Calc<__calc_delta_generic_fls>      2.36ms =C3=82=3DB113%
BM_Calc<__calc_delta_asm_fls>          2.45ms =C3=82=3DB113%
BM_Calc<__calc_delta_asm_fls_nomem>    1.66ms =C3=82=3DB112%
BM_Calc<__calc_delta_asm_fls64>        2.46ms =C3=82=3DB113%
BM_Calc<__calc_delta_asm_fls64_nomem>  1.34ms =C3=82=3DB115%
BM_Calc<__calc_delta_builtin>          1.32ms =C3=82=3DB111%
```

Signed-off-by: Clement Courbet <courbet@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210303224653.2579656-1-joshdon@google.com
---
 kernel/sched/fair.c  | 19 +++++++++++--------
 kernel/sched/sched.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5d6541..2e2ab1e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -229,22 +229,25 @@ static void __update_inv_weight(struct load_weight *lw)
 static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_we=
ight *lw)
 {
 	u64 fact =3D scale_load_down(weight);
+	u32 fact_hi =3D (u32)(fact >> 32);
 	int shift =3D WMULT_SHIFT;
+	int fs;
=20
 	__update_inv_weight(lw);
=20
-	if (unlikely(fact >> 32)) {
-		while (fact >> 32) {
-			fact >>=3D 1;
-			shift--;
-		}
+	if (unlikely(fact_hi)) {
+		fs =3D fls(fact_hi);
+		shift -=3D fs;
+		fact >>=3D fs;
 	}
=20
 	fact =3D mul_u32_u32(fact, lw->inv_weight);
=20
-	while (fact >> 32) {
-		fact >>=3D 1;
-		shift--;
+	fact_hi =3D (u32)(fact >> 32);
+	if (fact_hi) {
+		fs =3D fls(fact_hi);
+		shift -=3D fs;
+		fact >>=3D fs;
 	}
=20
 	return mul_u64_u32_shr(delta_exec, fact, shift);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bb8bb06..d2e09a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -36,6 +36,7 @@
 #include <uapi/linux/sched/types.h>
=20
 #include <linux/binfmts.h>
+#include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/compat.h>
 #include <linux/context_tracking.h>
