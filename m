Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C927033F469
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhCQPt1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhCQPs6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:58 -0400
Date:   Wed, 17 Mar 2021 15:48:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezUOcliBgcCKQfXmP7J+sP+I/c2KEqUZC9iM9kvVxho=;
        b=jeYKdslmCP+9EB9tTM2AdvDQQmwTNmnCZu47k54zfzlMSdr1oC9HUZVY8hZPgetyDZKhz9
        JZWFGeqNQMYvc6OHv4VFpBwAgcXnhG3xpsD6528b2gQZQFJz9ShxAilGJyEnQ4EGrJcDLX
        9mG7lbSXl6l0Q5Z5OP0mjTeobkXHeX5fu19G95BSRze68fvYf/183ag2f2jrOgVtal9ydf
        tLhmnq06j/Cm4W0TyE+tudOT6LG2zXPO4Tq7V/sQPVv3VNAmTRbhXZN9f1XSHYKZYAI1kh
        V2KdMtg8MrhDTfK/426vlzurWP+AAaSLqSaQyzPh6+eUkd45kfRcTETEgZGyTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezUOcliBgcCKQfXmP7J+sP+I/c2KEqUZC9iM9kvVxho=;
        b=fB3E5uFLnubIEuMVJ6fGo+eW3YHbCRQo9VCrJg84oEaES064MnFdMj+APnMGOqWKNKppmm
        ahV0eKnBxD1JpJAQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] atm: eni: Use tasklet_disable_in_atomic() in the
 send() callback
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084242.415583839@linutronix.de>
References: <20210309084242.415583839@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613646.398.4302510633173370000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     405698ca359a23b1ef1a502ef2bdc4597dc6da36
Gitweb:        https://git.kernel.org/tip/405698ca359a23b1ef1a502ef2bdc4597dc6da36
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:02 +01:00

atm: eni: Use tasklet_disable_in_atomic() in the send() callback

The atmdev_ops::send callback which calls tasklet_disable() is invoked with
bottom halfs disabled from net_device_ops::ndo_start_xmit(). All other
invocations of tasklet_disable() in this driver happen in preemptible
context.

Change the send() call to use tasklet_disable_in_atomic() which allows
tasklet_disable() to be made sleepable once the remaining atomic context
usage sites are cleaned up.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084242.415583839@linutronix.de

---
 drivers/atm/eni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 316a994..e96a4e8 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -2054,7 +2054,7 @@ static int eni_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	}
 	submitted++;
 	ATM_SKB(skb)->vcc = vcc;
-	tasklet_disable(&ENI_DEV(vcc->dev)->task);
+	tasklet_disable_in_atomic(&ENI_DEV(vcc->dev)->task);
 	res = do_tx(skb);
 	tasklet_enable(&ENI_DEV(vcc->dev)->task);
 	if (res == enq_ok) return 0;
