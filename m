Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C13B8406
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhF3NwE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbhF3Nuq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:46 -0400
Date:   Wed, 30 Jun 2021 13:47:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GGFVx2YCv4sLGebt4TlpibzhsN+WWWD180aYZP3ecyU=;
        b=KTKERSC2ST4h8e8voF8UZFzM8IzzZFiVR4tHSdm4iIY0CkPptb6+ElkBDUxdhNdBAZw45s
        DUev09uhML7bAjfFf9apzGMyCplIARw4sHssoH3CnTSOuui2gN/KbIVZQrO6eSzy8piNsJ
        P84xIan96R8hztHUNhHInrpvJD6bkCJX+FTf+LXXFr67VGCG9of5wWFfbjgz0QIDEaYiwy
        l+ARgETIrEbiKxOLUneTqtV0AclWE4eNvSw+Yee3lDPVbOyW+tJXZQ4ZlLAH+Lhe7zo/E3
        SaR3QoWptv5MJ0vrPJ31cZzMZcwFHhxaAD+UeB10+Qvh0BU22v6yZjg5OLVzvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GGFVx2YCv4sLGebt4TlpibzhsN+WWWD180aYZP3ecyU=;
        b=pm4+FZZZPuttx3Qqsz/pKttHzopCcHkerpLOHNL1agQbuZzcnRfOTVoDSsxEhYUDH3ghoZ
        5lrGHAJ+9X9eGPCg==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Update "monitor_todo" once a batch is started
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087856.395.6128756282766848434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dd28c9f057ad099f6221829053e48f331e6f0b7f
Gitweb:        https://git.kernel.org/tip/dd28c9f057ad099f6221829053e48f331e6f0b7f
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Thu, 15 Apr 2021 19:19:59 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:00:48 -07:00

kvfree_rcu: Update "monitor_todo" once a batch is started

Before attempting to start a new batch the "monitor_todo" variable is
set to "false" and set back to "true" when a previous RCU batch is still
in progress.  This is at best confusing.

Thus change this variable to "false" only when a new batch has been
successfully queued, otherwise, just leave it be.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e86f32d..1ae5f88 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3442,15 +3442,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
 	// Attempt to start a new batch.
-	krcp->monitor_todo = false;
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
+		krcp->monitor_todo = false;
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 		return;
 	}
 
 	// Previous RCU batch still in progress, try again later.
-	krcp->monitor_todo = true;
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
