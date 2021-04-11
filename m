Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1287935B4C5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhDKNoL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhDKNoE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:04 -0400
Date:   Sun, 11 Apr 2021 13:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zowUR/tH9gSg0TpQY5WRPyToWkZNYqRbZzYRYDd19xw=;
        b=WWNwU/hskx0nayJVacTv9C2yDevo6SHq9Dfx1KRtO4d3SE0WEyCLNWBrLSwUDozRGOftgo
        vAwHWLWvTlkXOshywk0F0pQmh8y2Wj9NguwLalwPNlN4t+sO9pAeh+7cS3Y7UG/6mwnXBM
        jlheyVTsMMkjS1b7pF1O+hI5uEoE0lLb9+hFqcwyRLTgD+wqt1Vj6y9NNRVr2X1adBg6gn
        BSe5lHdrO6Q5vVvKT2EZqDKMBCymyL2htxRkuIua8oH4rYPnP2u6KPDMzXxFUxG0xBBmZO
        UwrbdaFWimwiChisgsN0Ezjuf8FdA4ZX2R2HNr3ELsUx8ZbW1GOJRhshI+nxdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zowUR/tH9gSg0TpQY5WRPyToWkZNYqRbZzYRYDd19xw=;
        b=vcLMS9pacZns/FLOO2kaWfnr0sUhzJi2X4SrH5G0Gge9fwkd/ng/rHQlUKmjTi9VyexZ1M
        vA2pESp7Az6EJABQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Remove stale comment above rcu_segcblist_offload()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860574.29796.16925539344031874684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0efdf14a9f83618335a0849df3586808bff36cfb
Gitweb:        https://git.kernel.org/tip/0efdf14a9f83618335a0849df3586808bff36cfb
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:01 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:54:54 -07:00

rcu/nocb: Remove stale comment above rcu_segcblist_offload()

This commit removes a stale comment claiming that the cblist must be
empty before changing the offloading state.  This claim was correct back
when the offloaded state was defined exclusively at boot.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 7f181c9..aaa1112 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -261,8 +261,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 }
 
 /*
- * Mark the specified rcu_segcblist structure as offloaded.  This
- * structure must be empty.
+ * Mark the specified rcu_segcblist structure as offloaded.
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
