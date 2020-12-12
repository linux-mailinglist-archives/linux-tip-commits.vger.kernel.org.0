Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85DC2D86A4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438945AbgLLNA0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438930AbgLLNAK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A64C0617A7;
        Sat, 12 Dec 2020 04:58:43 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyUWnDAJ5Jzk5WmYGMWK9lc4JUJNpg6d6U9/2CqY6+0=;
        b=ZL5UZ3sNkk8PA6gZg9Pml828rrZ0Obk7r4EPSrETN81yz5bf95dOkQoWBbnN68M/SXeZ0T
        Xx/oPhh+ZA96XxcW/gxE+/esnrB6qiptjRq4D35Tu/SPnKuJVEfSBG2sh3ED30P2qr5C1a
        wdHlhjdVPwMyOWsH7MF7Nh5jJkVZZEcK/VETcV1fPbmLao6V+RsnqUOx0ot3WSnLWOXv2p
        5rHt9aiOA4TFLPJGALsXH34XdzdCchd5xPzd42v6o73QFAXbY0Mrk4LWJXmJdCH6bfUp4Y
        L8/FSDrxf/ZATXol53z4gi/vrE5PQbmbqHNVmks9taRgtEmLd/dycYYQzLKUgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyUWnDAJ5Jzk5WmYGMWK9lc4JUJNpg6d6U9/2CqY6+0=;
        b=mtnHr8jDQ4C3Zou0vxm/mKX1F90yLTUYD2hIfLnBGb92IZ/BNt38NsLYOxUp6wofTruiK0
        DDjwwMPMnVYmQpDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] NTB/msi: Use irq_has_action()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.255887860@linutronix.de>
References: <20201210194044.255887860@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791774.3364.1858222479021315707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d53c576bd3d4787b3d7d0d814b28ae67099d84a1
Gitweb:        https://git.kernel.org/tip/d53c576bd3d4787b3d7d0d814b28ae67099d84a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

NTB/msi: Use irq_has_action()

Use the proper core function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Link: https://lore.kernel.org/r/20201210194044.255887860@linutronix.de

---
 drivers/ntb/msi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 0a5e884..3f05cfb 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -282,15 +282,13 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 				  struct ntb_msi_desc *msi_desc)
 {
 	struct msi_desc *entry;
-	struct irq_desc *desc;
 	int ret;
 
 	if (!ntb->msi)
 		return -EINVAL;
 
 	for_each_pci_msi_entry(entry, ntb->pdev) {
-		desc = irq_to_desc(entry->irq);
-		if (desc->action)
+		if (irq_has_action(entry->irq))
 			continue;
 
 		ret = devm_request_threaded_irq(&ntb->dev, entry->irq, handler,
