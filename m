Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3862133F46E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhCQPtb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhCQPs7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:59 -0400
Date:   Wed, 17 Mar 2021 15:48:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wQphV5fMgswqIZUY4jNpyzIHOk6ZBQpWVxUNlY/8A8=;
        b=KlSyR1lHISHFN+4SKU2kkYM3k0ds0Zlat5Is7xoonYwj99/D8KEZCIOa2qz8tGBOWjCsNv
        Umo6GdxO8BvfeGcJ7H1VNMZfpt8O1I2Hd1lzAuFGf3i76ou7HvTPuyKvlQaOglj5RdxsjU
        S+dtPJ1i1k8V0E0q9KxohK+Vl0TbeD189msZ6qHHsmMWfdPs1C7LyxmVPyt9mi5nHZJuk7
        TE/HLVoOnHS1xAcNffnBlVxHSG4oPlpjQKj4oRXYyk8DB6bsCmLOg8JUQMmqkIlwFFZPWi
        7oxxe5dqPUwmSq5RMScYxA47C6lT72JWdiu+ztxU/6SWkPgh8wktQz4VjHYzqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wQphV5fMgswqIZUY4jNpyzIHOk6ZBQpWVxUNlY/8A8=;
        b=sOheMBVPqrrRt+t7iSm6tzgoixnAWb7wEzmrXHoL3zjkgyvDoUSJ7LbiINk1m+4qDUfTr1
        fAe2anfHK+DBEKBQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net: jme: Replace link-change tasklet with work
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084242.106288922@linutronix.de>
References: <20210309084242.106288922@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613752.398.15060273706431400877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c62c38e349c73cad90f59f00fe8070b3648b6d08
Gitweb:        https://git.kernel.org/tip/c62c38e349c73cad90f59f00fe8070b3648b6d08
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:58 +01:00

net: jme: Replace link-change tasklet with work

The link change tasklet disables the tasklets for tx/rx processing while
upating hw parameters and then enables the tasklets again.

This update can also be pushed into a workqueue where it can be performed
in preemptible context. This allows tasklet_disable() to become sleeping.

Replace the linkch_task tasklet with a work.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084242.106288922@linutronix.de

---
 drivers/net/ethernet/jme.c | 10 +++++-----
 drivers/net/ethernet/jme.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index e9efe07..f1b9284 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1265,9 +1265,9 @@ jme_stop_shutdown_timer(struct jme_adapter *jme)
 	jwrite32f(jme, JME_APMC, apmc);
 }
 
-static void jme_link_change_tasklet(struct tasklet_struct *t)
+static void jme_link_change_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, linkch_task);
+	struct jme_adapter *jme = container_of(work, struct jme_adapter, linkch_task);
 	struct net_device *netdev = jme->dev;
 	int rc;
 
@@ -1510,7 +1510,7 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
 		 * all other events are ignored
 		 */
 		jwrite32(jme, JME_IEVE, intrstat);
-		tasklet_schedule(&jme->linkch_task);
+		schedule_work(&jme->linkch_task);
 		goto out_reenable;
 	}
 
@@ -1832,7 +1832,6 @@ jme_open(struct net_device *netdev)
 	jme_clear_pm_disable_wol(jme);
 	JME_NAPI_ENABLE(jme);
 
-	tasklet_setup(&jme->linkch_task, jme_link_change_tasklet);
 	tasklet_setup(&jme->txclean_task, jme_tx_clean_tasklet);
 	tasklet_setup(&jme->rxclean_task, jme_rx_clean_tasklet);
 	tasklet_setup(&jme->rxempty_task, jme_rx_empty_tasklet);
@@ -1920,7 +1919,7 @@ jme_close(struct net_device *netdev)
 
 	JME_NAPI_DISABLE(jme);
 
-	tasklet_kill(&jme->linkch_task);
+	cancel_work_sync(&jme->linkch_task);
 	tasklet_kill(&jme->txclean_task);
 	tasklet_kill(&jme->rxclean_task);
 	tasklet_kill(&jme->rxempty_task);
@@ -3035,6 +3034,7 @@ jme_init_one(struct pci_dev *pdev,
 	atomic_set(&jme->rx_empty, 1);
 
 	tasklet_setup(&jme->pcc_task, jme_pcc_tasklet);
+	INIT_WORK(&jme->linkch_task, jme_link_change_work);
 	jme->dpi.cur = PCC_P1;
 
 	jme->reg_ghc = 0;
diff --git a/drivers/net/ethernet/jme.h b/drivers/net/ethernet/jme.h
index a2c3b00..2af7632 100644
--- a/drivers/net/ethernet/jme.h
+++ b/drivers/net/ethernet/jme.h
@@ -411,7 +411,7 @@ struct jme_adapter {
 	struct tasklet_struct	rxempty_task;
 	struct tasklet_struct	rxclean_task;
 	struct tasklet_struct	txclean_task;
-	struct tasklet_struct	linkch_task;
+	struct work_struct	linkch_task;
 	struct tasklet_struct	pcc_task;
 	unsigned long		flags;
 	u32			reg_txcs;
