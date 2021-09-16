Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB240D928
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhIPMAo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbhIPMAn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:43 -0400
Date:   Thu, 16 Sep 2021 11:59:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9TkoY1vZqEQRNciAyZMAhxTom7V97AEUz3DFFDePiw=;
        b=YI+enDV7tsX4xfTrkhmVHbgcoMMUDEElvdzr71ZsCjQ1GdxrmeABD09Cp/LDz8MJsE8X2c
        33oCYQ/6mhSI93FG0ilmJS19D8i0z3zjxcBNa0sNizIHefNmmWtclckBLvTCjn899I60S5
        dCUq9J22z/X3WoRy/Nh38ijH3wyYcpy2DnFLtWsqHL55E1iKXsSE8imTGVu+n2doE63j+E
        w8vlvoJOANFrvqZytc2cIPFZ0rRHcY7SFwt9hNpPxZRi35LHBg13nEfFe1NqbCenQTB6BO
        diPeSX2a04P2SbZXKFHQFwQwM0gH7J28v913Orl6LeGCGdIVtR6Q+NUe3w1e7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9TkoY1vZqEQRNciAyZMAhxTom7V97AEUz3DFFDePiw=;
        b=0bAwRG4Gd8HdKLB1/YGLN6lzJNJkTNpeYayT1JBspsc+KPd92b4mXhTB672pDIwhZxm+ak
        nUTRuHaviM9LcrAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwbase: Properly match
 set_and_save_state() to restore_state()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210909110203.828203010@infradead.org>
References: <20210909110203.828203010@infradead.org>
MIME-Version: 1.0
Message-ID: <163179355945.25758.15254578422606163321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     7687201e37fabf2b7cf2b828f7ca46bf30e2948f
Gitweb:        https://git.kernel.org/tip/7687201e37fabf2b7cf2b828f7ca46bf30e2948f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 09 Sep 2021 12:59:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:15 +02:00

locking/rwbase: Properly match set_and_save_state() to restore_state()

Noticed while looking at the readers race.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20210909110203.828203010@infradead.org
---
 kernel/locking/rwbase_rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 4ba1508..542b017 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -220,7 +220,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	for (; atomic_read(&rwb->readers);) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
-			__set_current_state(TASK_RUNNING);
+			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
 			return -EINTR;
 		}
