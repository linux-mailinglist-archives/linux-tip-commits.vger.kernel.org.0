Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B579528A8D1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgJKR6v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388494AbgJKR5o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:44 -0400
Date:   Sun, 11 Oct 2020 17:57:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SEXwbkscE8lmgYWhsSoyNCRpwWpTPje9v9fHDCbGTY=;
        b=aexrO7JrBiCyyFpMXxiTS6XBa4o67CsXrqa+UNiuLAFMvjdDszpB2gNQ8BJZ3DsCG0XsQ2
        TL/cynHBNRrQfwBZOKU9X7MDe82RXNYLTiarqfbOR0T5Dd09zZ2/HdIqMDLayJMaMysas3
        Mu9wT1xfoGfXfH2tOP5N/pQL5WHYxllcos7vqVbdBE/P7pm+D1A7j25mO+lBac59TpXbpf
        NHEx+NKeJsxIQKSUmqlphqK/5xog5lHT4hqdXpULJwdj7Pyb30vDC57Nn9F0LWjz5MFLBO
        mg+Zk3LMXtwLFfQGFW728FjY95SEN5n2c/A8IHLYYtiRcSGYcOOyexrLw0p/Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SEXwbkscE8lmgYWhsSoyNCRpwWpTPje9v9fHDCbGTY=;
        b=CLfMYRnfoIXvcM2fOWIbdUOac29mBhoFvDa1bjD7x+XL0LyP0IM/wXDOCkyyHpnc7swPsb
        06cIEjPhp2kpdFBg==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ti-sci: Simplify with dev_err_probe()
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902174615.24695-1-krzk@kernel.org>
References: <20200902174615.24695-1-krzk@kernel.org>
MIME-Version: 1.0
Message-ID: <160243906168.7002.4983143600687372598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ea6c25e6057c0b7c18337696be84b8f9751f19ec
Gitweb:        https://git.kernel.org/tip/ea6c25e6057c0b7c18337696be84b8f9751f19ec
Author:        Krzysztof Kozlowski <krzk@kernel.org>
AuthorDate:    Wed, 02 Sep 2020 19:46:14 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:38:37 +01:00

irqchip/ti-sci: Simplify with dev_err_probe()

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

There is also no need to assign NULL to 'intr->sci' as it is part of
devm-allocated memory.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200902174615.24695-1-krzk@kernel.org
---
 drivers/irqchip/irq-ti-sci-inta.c | 10 +++-------
 drivers/irqchip/irq-ti-sci-intr.c | 10 +++-------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index d4e9760..bc863ef 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -600,13 +600,9 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 
 	inta->pdev = pdev;
 	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
-	if (IS_ERR(inta->sci)) {
-		ret = PTR_ERR(inta->sci);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "ti,sci read fail %d\n", ret);
-		inta->sci = NULL;
-		return ret;
-	}
+	if (IS_ERR(inta->sci))
+		return dev_err_probe(dev, PTR_ERR(inta->sci),
+				     "ti,sci read fail\n");
 
 	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &inta->ti_sci_id);
 	if (ret) {
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index cbc1758..6a6fb66 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -254,13 +254,9 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 	}
 
 	intr->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
-	if (IS_ERR(intr->sci)) {
-		ret = PTR_ERR(intr->sci);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "ti,sci read fail %d\n", ret);
-		intr->sci = NULL;
-		return ret;
-	}
+	if (IS_ERR(intr->sci))
+		return dev_err_probe(dev, PTR_ERR(intr->sci),
+				     "ti,sci read fail\n");
 
 	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dev-id",
 				   &intr->ti_sci_id);
