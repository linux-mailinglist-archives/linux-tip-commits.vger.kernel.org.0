Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646BD433AA0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhJSPhv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhJSPhu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:37:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB4BC061746;
        Tue, 19 Oct 2021 08:35:37 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:35:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJ2h9hd3Fu6v6Na8a7vKsei1q56OAd6Vc7H98oZ9jDg=;
        b=X7IfOLU26Mm1WuEGlFlH5jcSPpyEjx3HnHzcUdv63rc7AppIlL0xymp35hdI+9KDWpQ5pr
        eztAaheVAVUx5xpqQcavi++ecS74eGsJFhF1MNgLq+scxjuDmJz8y1S6EVcR59P6hJ1pra
        N4xZmi9qzzUGYy4ftrWOK+g0QETQOaRDvAKjOLLpaYt16o9W/hkKmgmdsJLNdWunqxRDYY
        ttz9Q1qXk25AizEs3TnsIkE1jLcuxju53zHidsF/N5AocMo1PVLLqu7BXnpTH1InxcUkvJ
        DeWsbnPn92Dl1X6f6Q9BIJ5Z5M4icjilT/TuCet/b7/atuUKUyIB1a9YQqZJJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJ2h9hd3Fu6v6Na8a7vKsei1q56OAd6Vc7H98oZ9jDg=;
        b=TDL3AWt3+n/NmMAyf/OwESAAW8HRtJs4+AYbd11XvlhaSP/oHsuS+jyI8bjCJUWqoGTom8
        VQVvNwp5yOy3rtBQ==
From:   "tip-bot2 for Yanfei Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Fix comments about reader
 optimistic lock stealing conditions
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211013134154.1085649-4-yanfei.xu@windriver.com>
References: <20211013134154.1085649-4-yanfei.xu@windriver.com>
MIME-Version: 1.0
Message-ID: <163465773536.25758.8800618521559459734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5197fcd09ab6dcc4df79edec7e8e27575276374c
Gitweb:        https://git.kernel.org/tip/5197fcd09ab6dcc4df79edec7e8e27575276374c
Author:        Yanfei Xu <yanfei.xu@windriver.com>
AuthorDate:    Wed, 13 Oct 2021 21:41:54 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:06 +02:00

locking/rwsem: Fix comments about reader optimistic lock stealing conditions

After the commit 617f3ef95177 ("locking/rwsem: Remove reader
optimistic spinning"), reader doesn't support optimistic spinning
anymore, there is no need meet the condition which OSQ is empty.

BTW, add an unlikely() for the max reader wakeup check in the loop.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20211013134154.1085649-4-yanfei.xu@windriver.com
---
 kernel/locking/rwsem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 884aa08..c51387a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -56,7 +56,6 @@
  *
  * A fast path reader optimistic lock stealing is supported when the rwsem
  * is previously owned by a writer and the following conditions are met:
- *  - OSQ is empty
  *  - rwsem is not currently writer owned
  *  - the handoff isn't set.
  */
@@ -485,7 +484,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		/*
 		 * Limit # of readers that can be woken up per wakeup call.
 		 */
-		if (woken >= MAX_READERS_WAKEUP)
+		if (unlikely(woken >= MAX_READERS_WAKEUP))
 			break;
 	}
 
