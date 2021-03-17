Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08F33F467
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCQPt0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhCQPs6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:58 -0400
Date:   Wed, 17 Mar 2021 15:48:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uChDpxew2+79uMtMLPxMuDbUdvkettPqFvkGVNo2R+E=;
        b=UXu8LHqI2c23594lL0DjE7EXk6gZB7SOLS2BOqw0TN5RagSm/w3SKbEY4NAPt29dku3F7N
        lCLkrY5TskSeVhVnkFEa49bdFmBGS1BSLWbadD5MRnVoqvAaGyGpz6de6QEt9+Vw4n7VcK
        zfCdDRV2CyuMBv86xvl0Ja06aB4b29zFvWvA/KFyaAzsLB3D95dYkvPoCLH+/8ic7lahcy
        KNIyASJzKOylqpA736CU25T5O+lLtFFk8hf/zMviobdlv2DlcbZ2O6G160p2W9Vb9EQZAh
        fn9HKtStOd/X6QdWFN8B6ymgyLU9YmQqNWt+G5sdw9OIr1RC6BoPNJpBxqJGpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uChDpxew2+79uMtMLPxMuDbUdvkettPqFvkGVNo2R+E=;
        b=xKQ1tCUvXTLrBAvEXsAKW2VI6U2PXVghqk9t0ox7h7LMImrV7fN3AgtINp3jD7AhQu+7ho
        lvyc5/kcvwCX/QDg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI: hv: Use tasklet_disable_in_atomic()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Liu <wei.liu@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084242.516519290@linutronix.de>
References: <20210309084242.516519290@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613604.398.12732595162252073123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     be4017cea0aec6369275df7eafbb09682f810e7e
Gitweb:        https://git.kernel.org/tip/be4017cea0aec6369275df7eafbb09682f810e7e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:03 +01:00

PCI: hv: Use tasklet_disable_in_atomic()

The hv_compose_msi_msg() callback in irq_chip::irq_compose_msi_msg is
invoked via irq_chip_compose_msi_msg(), which itself is always invoked from
atomic contexts from the guts of the interrupt core code.

There is no way to change this w/o rewriting the whole driver, so use
tasklet_disable_in_atomic() which allows to make tasklet_disable()
sleepable once the remaining atomic users are addressed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084242.516519290@linutronix.de

---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 27a17a1..a313708 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1458,7 +1458,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * Prevents hv_pci_onchannelcallback() from running concurrently
 	 * in the tasklet.
 	 */
-	tasklet_disable(&channel->callback_event);
+	tasklet_disable_in_atomic(&channel->callback_event);
 
 	/*
 	 * Since this function is called with IRQ locks held, can't
