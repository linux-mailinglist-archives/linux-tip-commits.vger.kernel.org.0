Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0DD28A8D3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgJKR7G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbgJKR5n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:43 -0400
Date:   Sun, 11 Oct 2020 17:57:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H568G1II0fkRRmctEw3+PMdGeYbtPvKJME9Ud13vQQk=;
        b=u2+gl6iB7a05CdXP+xwXnL6vVbaS1a/F6M8yMOJFneZefwBVNcQMyqyar/Oi80DeS12hpr
        kyVL6ToyDcQYTP600Q+UYRQI+W2G7n0DB+eXI4ui2b5h5vBmd5LvORd7ozAhcYI/ZGasci
        ycq1ASO1u18IC4caGbY/Sqzzr9/EO9kG6XLe1+MCSagV1GTV4H4oLCKjLwGNvFNnwNSTCS
        88k/bszKK0jeeD8PtyJIMtM08ipM0O7V+1tO2GgZ27pRynovTQ0kIU4E7mQyZdj033Q+L7
        kggQzYiw/V1EKfGCYBEY+vFp5F9Csz3pFV4zd307CBpMp/zltsQIklmYOpSGVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H568G1II0fkRRmctEw3+PMdGeYbtPvKJME9Ud13vQQk=;
        b=y1mPwiLo2or//0h3wHs9UZKqqVnlOU2KbxOQzC1LswS8ULeUDdimWFM2E5ZRYHmTTM6ThE
        kSCpAPMXxxHvsHAw==
From:   "tip-bot2 for Anson Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imx-irqsteer: Use dev_err_probe() to simplify
 error handling
Cc:     Anson Huang <Anson.Huang@nxp.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1597126576-18383-2-git-send-email-Anson.Huang@nxp.com>
References: <1597126576-18383-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Message-ID: <160243906065.7002.1771330576771757675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e0c45b107fc94c5a7a230b25cdbecab004ab1ed5
Gitweb:        https://git.kernel.org/tip/e0c45b107fc94c5a7a230b25cdbecab004ab1ed5
Author:        Anson Huang <Anson.Huang@nxp.com>
AuthorDate:    Tue, 11 Aug 2020 14:16:16 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:38:52 +01:00

irqchip/imx-irqsteer: Use dev_err_probe() to simplify error handling

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1597126576-18383-2-git-send-email-Anson.Huang@nxp.com
---
 drivers/irqchip/irq-imx-irqsteer.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 290531e..1edf769 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -158,12 +158,9 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	}
 
 	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(data->ipg_clk)) {
-		ret = PTR_ERR(data->ipg_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(data->ipg_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->ipg_clk),
+				     "failed to get ipg clk\n");
 
 	raw_spin_lock_init(&data->lock);
 
