Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B527328825F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbgJIGgj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732041AbgJIGfm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:42 -0400
Date:   Fri, 09 Oct 2020 06:35:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mBju6gFrhxXhpVA6q7eC9oaHF6C6RPKeemP8tXdHcks=;
        b=OlhAC6axKg0BqZ0m8bwzU4cIIwTKouiQFSAOuMFne7GofUj4TCmO6lOGuRpgxYyvrQHYLx
        MsNxhS0J07RoalXad3etQg6e/i0QlTbMzXzWl657NJocPx50oILju89KrChOXMsuQrgl84
        t00aoDFxsc+ytuuf0h6QSspryFzasOxGKTGyNgR4nH7n/SdKFYrCYTsqIZ9Lx5XvioxIDt
        5a/nAP2nbfhIN9dAIKCbMG1nJZl9VoisepbgaPpQc8EgH4f/gp428TWB/2rHQbEZXResIm
        /QgpHG7c5Gm3x01ys98uJP2mAr8+Gl6ZIkFztkO4QZ3sB5xCmC0wIS0QCtBA0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mBju6gFrhxXhpVA6q7eC9oaHF6C6RPKeemP8tXdHcks=;
        b=/5P0aLk2JIeIm1Nsf3tFUomFZp332E+jY3peQAEktRIZ0Asr7gWi8cSfCdiYnVOv3Flqin
        aA1/r+gQt8vW5hBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE() to rcu_do_batch() access to
 rcu_resched_ns
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533918.7002.6310608201915925750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a2b354b9950bb859d8d959f951dda26725b041fb
Gitweb:        https://git.kernel.org/tip/a2b354b9950bb859d8d959f951dda26725b041fb
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Jun 2020 17:49:40 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:07 -07:00

rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_resched_ns

Given that sysfs can change the value of rcu_resched_ns at any time,
this commit adds a READ_ONCE() to the sole access to that variable.
While in the area, this commit also adds bounds checking, clamping the
value to at least a millisecond, but no longer than a second.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1dca14c..da05afc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2394,8 +2394,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-	if (unlikely(bl > 100))
-		tlimit = local_clock() + rcu_resched_ns;
+	if (unlikely(bl > 100)) {
+		long rrn = READ_ONCE(rcu_resched_ns);
+
+		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
+		tlimit = local_clock() + rrn;
+	}
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
