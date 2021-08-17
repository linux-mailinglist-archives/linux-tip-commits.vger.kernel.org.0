Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB713EF334
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhHQUOi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhHQUOg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:36 -0400
Date:   Tue, 17 Aug 2021 20:14:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dao5T16kInzYwpt2yv7oIhQKw6C2zbPKM5v5aQx8sQ=;
        b=okTDBHajuht0fZU2iJ0LgwKRWIIqMhGRNJRWupRWZ+XpI8FZIpZL7CKCArt3bvFSX3vNz+
        wZJt6kzI4hQsd7Da6SpWnLuwqsJWJxsiF8q/NhyaBe8AMPmI/QQ0q4b40ffe0FABnuwqqT
        /rrTHzGgtrXLoVXlge3/kz2QuRSkFwTTsrsyvU1ysL9lbhxzKFO3JiOSXeNiY+Bvr6qh+1
        caO94XM4MLEOd46YX0B/cuHdNP21esyW9R1wdAqjP6CDtaiOhg+LHznVncJE6zvsZmzEqV
        v5p62nFn++PUUieOaU1u/oLfOXPqt5IfxMODrM0pzxhw4oJTe4W3xHoG7OMYjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dao5T16kInzYwpt2yv7oIhQKw6C2zbPKM5v5aQx8sQ=;
        b=U1Lm3BlywAXsOf4X9FVyPrtiGUQVUAi99fOAyBEsZWOK/JiwoF3oi0dlbmbKFh7oDT0x3R
        bH2Zkt2KAkKQpECg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Reorder sanity checks in futex_requeue()
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.581789253@linutronix.de>
References: <20210815211305.581789253@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124113.25758.13783258095447636244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d69cba5c719b0c551f6380ec5da4ed8c20a3815a
Gitweb:        https://git.kernel.org/tip/d69cba5c719b0c551f6380ec5da4ed8c20a3815a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:54 +02:00

futex: Reorder sanity checks in futex_requeue()

No point in allocating memory when the input parameters are bogus.
Validate all parameters before proceeding.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.581789253@linutronix.de
---
 kernel/futex.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 8d8bad5..a5232f6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1934,13 +1934,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			return -EINVAL;
 
 		/*
-		 * requeue_pi requires a pi_state, try to allocate it now
-		 * without any locks in case it fails.
-		 */
-		if (refill_pi_state_cache())
-			return -ENOMEM;
-
-		/*
 		 * futex_requeue() allows the caller to define the number
 		 * of waiters to wake up via the @nr_wake argument. With
 		 * REQUEUE_PI, waking up more than one waiter is creating
@@ -1963,6 +1956,13 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		 */
 		if (nr_wake != 1)
 			return -EINVAL;
+
+		/*
+		 * requeue_pi requires a pi_state, try to allocate it now
+		 * without any locks in case it fails.
+		 */
+		if (refill_pi_state_cache())
+			return -ENOMEM;
 	}
 
 retry:
