Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596704278C5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbhJIKJ3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49538 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbhJIKJR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:17 -0400
Date:   Sat, 09 Oct 2021 10:07:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3pCBjl2e8Da4p/V5bnaKUuPbwpFUMahEuvVM8sY/DQ=;
        b=JWvu76gdJK4gakbpZXUsiXssoLjGVFF68PWDzVDaz+bvWmiIjCu8+/rZIQiwFuIwxSelYH
        QDxsfEHwOs2HAi+0A9k+V5KlX5dcRjSH5G5JIsrwAkvxh6NninVQOg7LYqa93yNUanmfoq
        +hOqUxrngflxDDozIV7TvyCLiyVI5ue+cp76hkXI/on+bQlFuKxc9D5BnDIz/LhNlnKMz4
        zko9ZhKNpTH2fgwuQrqGUsIGBifR9YyDmlxJwivZWL9JvOR7wUFlo7QovKd0EvpAQniUEm
        hiHaXYstA3G7yJ2gJVL2npE+acokJ1HOb3x/AbEHsjUPoWJ0yynPNBnidC5T3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3pCBjl2e8Da4p/V5bnaKUuPbwpFUMahEuvVM8sY/DQ=;
        b=oUt1K8HkA3xxfbv3X0XycH3RojsFD3JBVyND763c59RhE1NYAR9spqB0kdyWQlzdgV23D1
        XoaxaLLdS5tarWCQ==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwbase: Optimize rwbase_read_trylock
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210920052031.54220-2-dave@stgolabs.net>
References: <20210920052031.54220-2-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <163377403924.25758.18240935726439029694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c78416d122243c92992a1d1063f17ddd0bc80e6c
Gitweb:        https://git.kernel.org/tip/c78416d122243c92992a1d1063f17ddd0bc80e6c
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Sun, 19 Sep 2021 22:20:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:07 +02:00

locking/rwbase: Optimize rwbase_read_trylock

Instead of a full barrier around the Rmw insn, micro-optimize
for weakly ordered archs such that we only provide the required
ACQUIRE semantics when taking the read lock.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20210920052031.54220-2-dave@stgolabs.net
---
 kernel/locking/rwbase_rt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 15c8110..6fd3162 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -59,8 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	 * set.
 	 */
 	for (r = atomic_read(&rwb->readers); r < 0;) {
-		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
-		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
+		if (likely(atomic_try_cmpxchg_acquire(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
 	return 0;
@@ -187,7 +186,7 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
 
 	/*
 	 * _release() is needed in case that reader is in fast path, pairing
-	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
+	 * with atomic_try_cmpxchg_acquire() in rwbase_read_trylock().
 	 */
 	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
