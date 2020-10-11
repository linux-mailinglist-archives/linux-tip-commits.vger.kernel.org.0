Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4862C28A8D0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgJKR6v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388492AbgJKR5n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:43 -0400
Date:   Sun, 11 Oct 2020 17:57:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erT/FqfJXmhYxrssecF/Fc34difA0bdm3psKgjtOYy4=;
        b=zYSE/NsKLxNTvv3k9v37MZwxg/r2nVB2quYZ13ZSu+KKGkWT4aC5TfjYtNmbrMbp4GIMNE
        iAhpjN5QotIOoJ9bJ+dEBuCV17DOaXzNIb3Zn+k6Ylcx2lNakK1yy/G8EkeJrwexiTN46Q
        /ycs7EWP6w3LcomekH+tAJEsi2QNT+jQ2YHHgkwm9Kb6ZXwfG0hYkFqPw1oK/SAvUcezPW
        5f/r+lVHy6lvAsVyoRhb7X7+xr0f61amloxe+9t4eVMYcjGa2qgfYGwTvcwlyqe3SqFO+5
        0LBD7THny9HnuDnRKLVRh6g47uGxAboprJYnNp0GPPUC0g3ERdWqRcWZ++e1qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erT/FqfJXmhYxrssecF/Fc34difA0bdm3psKgjtOYy4=;
        b=ZTvfTvtbnEv3NuXf0jMWEWPNPqHioblAXW5rXek/+zIzCziCaXpcgVpyBsJrnqhyNYN3cX
        dMk2pQM+6J0VNPDQ==
From:   "tip-bot2 for Anson Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imx-intmux: Use dev_err_probe() to simplify
 error handling
Cc:     Anson Huang <Anson.Huang@nxp.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1597126576-18383-1-git-send-email-Anson.Huang@nxp.com>
References: <1597126576-18383-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Message-ID: <160243906116.7002.7305735851791605051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c201f4325588a3b0109ba552a20bd4d4b1b5c6c8
Gitweb:        https://git.kernel.org/tip/c201f4325588a3b0109ba552a20bd4d4b1b5c6c8
Author:        Anson Huang <Anson.Huang@nxp.com>
AuthorDate:    Tue, 11 Aug 2020 14:16:15 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:38:52 +01:00

irqchip/imx-intmux: Use dev_err_probe() to simplify error handling

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1597126576-18383-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/irqchip/irq-imx-intmux.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index e35b7b0..7709f97 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -226,12 +226,9 @@ static int imx_intmux_probe(struct platform_device *pdev)
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
 
 	data->channum = channum;
 	raw_spin_lock_init(&data->lock);
