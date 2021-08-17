Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832623EF33D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhHQUOm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhHQUOk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:40 -0400
Date:   Tue, 17 Aug 2021 20:14:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+lVScTnnrXB2GG7EkiFy4P4iSsPPjFilSJNzGMdySQ=;
        b=0BVTTEvOfVZFl35hfWA5242b9g8Jlg0plTsb4n01CTWiWFxLn8bGSc7YtZs3LHQcUnmiWx
        OFVy1M5TpKSRXUfEe7M/JhaebxUiaUtbgCyM2dU39l60YcCemS2IxUM3xWsU98AqmeSWtF
        D5ZECH8kjG3orKxfB+iiEsc07/m7KHEwMJg/PkEoDlsXW61nKcj0XVXV11FPOnt/lzHzDS
        tE57+5Ts4UoAPYmRUmpyuV4MhP9fAf9Ep5VNKc6++LUz1SX4XoSsFt73Gi8Y/kay95sP2I
        IPruv0V2zgACzeb8zmp4oVBPqsNUFzfFbx3QjtpMUVbRJyLlZtx5BmzNCIYjQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+lVScTnnrXB2GG7EkiFy4P4iSsPPjFilSJNzGMdySQ=;
        b=GMCF5Apdmnnubauv80JELmMNfT9x9WlZ95Q5HCOSiGVIyXhs0CSNlDun2aUfrirOnWIRDh
        T7SmJv37Cg3Vd9Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Validate waiter correctly in
 futex_proxy_trylock_atomic()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.193767519@linutronix.de>
References: <20210815211305.193767519@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124518.25758.2240606742123516844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dc7109aaa233d83b573f75763a9f1ae207042a53
Gitweb:        https://git.kernel.org/tip/dc7109aaa233d83b573f75763a9f1ae207042a53
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:36 +02:00

futex: Validate waiter correctly in futex_proxy_trylock_atomic()

The loop in futex_requeue() has a sanity check for the waiter, which is
missing in futex_proxy_trylock_atomic(). In theory the key2 check is
sufficient, but futexes are cursed so add it for completeness and paranoia
sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.193767519@linutronix.de
---
 kernel/futex.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 21625cb..a1f27fd 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1879,6 +1879,13 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	if (!top_waiter)
 		return 0;
 
+	/*
+	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+	 * and waiting on the 'waitqueue' futex which is always !PI.
+	 */
+	if (!top_waiter->rt_waiter || top_waiter->pi_state)
+		ret = -EINVAL;
+
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;
