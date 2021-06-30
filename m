Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4278B3B8387
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhF3Nt7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:49:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbhF3Nty (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:54 -0400
Date:   Wed, 30 Jun 2021 13:47:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XpMU1pTuy0lXTtVmTnzOFnF9+LwKoHdjvLjwIMCqpB0=;
        b=sEJB0Xj5u6MS5IbtUeG8m/eUdrGAsAryle2PrE4x0XDB2Fr/ne7BaK1y07NPHykDRl32W8
        2+8lMff0AxEBIngpilx2Kn/8zh9RV2EmCslUaSnKivZrX2DYbzm0QnNKqnvqegTsoBCUKU
        /VIrJtb28nm4VLh1YR6RZO1JKiqTsxs672Y6AXCr2yugMaGMllQTf1nvoFU1k26CeHbchr
        y+402ETZJTFZnnoiLdYMVh35uRCgJd72jGp/AbfTwouv/zkUWwbI9Y0557syDadgFfaOCo
        PDIB7XdvI2FFBtFYc81ovM64nsN/MrA/wUHR7X56Fp5kcqDfChs5pzmPWe3PYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XpMU1pTuy0lXTtVmTnzOFnF9+LwKoHdjvLjwIMCqpB0=;
        b=oqH4TAfHvsphuPVa0zPMAm1ONpbpEBG9MTiSQ1sOpEcGWZPxqrwQewg0aQxZ4Vx85k1ViR
        0lDUX7dYKnQztlAw==
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add missing __releases() annotation
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084434.395.2967728545680261167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c70360c3343f975bd066b6b98159d93f1bd4219f
Gitweb:        https://git.kernel.org/tip/c70360c3343f975bd066b6b98159d93f1bd4219f
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Thu, 29 Apr 2021 00:12:19 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 13 May 2021 09:13:23 -07:00

rcu: Add missing __releases() annotation

Sparse reports a warning at rcu_print_task_stall():

"warning: context imbalance in rcu_print_task_stall - unexpected unlock"

The root cause is a missing annotation on rcu_print_task_stall().

This commit therefore adds the missing __releases(rnp->lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e6bd518..ffb8cf6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -314,6 +314,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * tasks blocked within RCU read-side critical sections.
  */
 static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
+	__releases(rnp->lock)
 {
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return 0;
