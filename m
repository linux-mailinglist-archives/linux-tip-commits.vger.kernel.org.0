Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B4D25400E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Aug 2020 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgH0IAC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Aug 2020 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgH0HyU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D04C06121B;
        Thu, 27 Aug 2020 00:54:20 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89A6wazOLLjRmL9Mtpna+rpwili8jzcw6nYOIbvJbQk=;
        b=H5qILwpxdP9O74cWJm66r6HpDUvOqsBhlA89wHceXqybE0IeqGBCprdxs0nq2mwvbwtjLj
        dVVrisgXUEA7SNXi9W8h/mZM590ANkuulS/kFecVp0xyp4d8cPOy5KsAyq27xAoyoe2btb
        1mKE//d0aCqZQAykL9UmAyf64+zcEr1fUi08t9Tt4wlbKqlEEgHFg8aUSF3cIApUSOqeuf
        paNphScAWxFRkn3PFgIL/lRg2ZxtwsspOzB2z4wruJr2SajcA6UdRIxdVBxbC0I4EuRHwq
        xZ+l8P5EaTVFreTDxJ9BW13CwQkoVkqhQq6U3JcxJ1F4agLi7jlP1v9q5EDahw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89A6wazOLLjRmL9Mtpna+rpwili8jzcw6nYOIbvJbQk=;
        b=byC6v0vV0KLERfzy1ZvTxcfJ2ouXYhdfwhxu2iaxqK5dQ1hZsKBMig6fSKDvo4sIZol87/
        oHHJjmusIwIXJrCg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add recursive read locks into dependency graph
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-13-boqun.feng@gmail.com>
References: <20200807074238.1632519-13-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485754.20229.2400121022268138722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     621c9dac0eea7607cb9a57cc9ba47fbcd4e644c9
Gitweb:        https://git.kernel.org/tip/621c9dac0eea7607cb9a57cc9ba47fbcd4e644c9
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:31 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:06 +02:00

lockdep: Add recursive read locks into dependency graph

Since we have all the fundamental to handle recursive read locks, we now
add them into the dependency graph.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-13-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6644974..b87766e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2809,16 +2809,6 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return 0;
 
 	/*
-	 * For recursive read-locks we do all the dependency checks,
-	 * but we dont store read-triggered dependencies (only
-	 * write-triggered dependencies). This ensures that only the
-	 * write-side dependencies matter, and that if for example a
-	 * write-lock never takes any other locks, then the reads are
-	 * equivalent to a NOP.
-	 */
-	if (next->read == 2 || prev->read == 2)
-		return 1;
-	/*
 	 * Is the <prev> -> <next> dependency already present?
 	 *
 	 * (this may occur even though this is a new chain: consider
@@ -2935,13 +2925,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		u16 distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
-		/*
-		 * Only non-recursive-read entries get new dependencies
-		 * added:
-		 */
-		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance,
-						 &trace);
+		if (hlock->check) {
+			int ret = check_prev_add(curr, hlock, next, distance, &trace);
 			if (!ret)
 				return 0;
 
