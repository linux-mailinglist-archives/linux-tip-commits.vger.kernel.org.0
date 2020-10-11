Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2524B28A89E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgJKR52 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbgJKR5Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88682C0613D6;
        Sun, 11 Oct 2020 10:57:25 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92SAXetGlqbdQ7jidG3RojveO8mpUrZod2CVvMNOXPQ=;
        b=QjYer8G/EN1AsRsRz7m8/Y1P/zg7PHzI4wBdXP0za//a7zNgkgWflpcAfGyxtKshHF9Bsz
        OQLR395rE7q12SVMafXaae//jzysKYsspsTCx7I/rrO0Z52VPgu/MmP9PMldMcoZPCgx06
        /h7HZ+N05Godmp3kEgXq8UmTzLaJ3PnmAQAttFsa+DjMdWcYTbG1PLjjrj2i4qzUIIfmFA
        D+rOdFie63UoHnL15x+KhJ9o/sApS6QmQ/wbh8vYp2cG2VbInWz7+yue17RvNh4pOgwrFB
        2U0raAYMrzrYyKNIzSmJ2vIRFQUpMQPNo156wuMbIDnE6zQpxuqOsdGbSS6E6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92SAXetGlqbdQ7jidG3RojveO8mpUrZod2CVvMNOXPQ=;
        b=BGKdUIEsSQlqULqqhpLKPb2FmA3poZGcm/nbgDdCkCHWhz1U2FT0W/cgtQTnumishLL+Jk
        Ws6X4HUBKTeX5TDw==
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl: qcom: Use return value from irq_set_wake() call
Cc:     Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601267524-20199-3-git-send-email-mkshah@codeaurora.org>
References: <1601267524-20199-3-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <160243904330.7002.4809705687735318637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f41aaca593377a4fe3984459fd4539481263b4cd
Gitweb:        https://git.kernel.org/tip/f41aaca593377a4fe3984459fd4539481263b4cd
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Mon, 28 Sep 2020 10:02:00 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 06 Oct 2020 11:23:14 +01:00

pinctrl: qcom: Use return value from irq_set_wake() call

msmgpio irqchip was not using return value of irq_set_irq_wake() callback
since previously GIC-v3 irqchip neither had IRQCHIP_SKIP_SET_WAKE flag nor
it implemented .irq_set_wake callback. This lead to irq_set_irq_wake()
return error -ENXIO.

However from 'commit 4110b5cbb014 ("irqchip/gic-v3: Allow interrupt to be
configured as wake-up sources")' GIC irqchip has IRQCHIP_SKIP_SET_WAKE
flag.

Use return value from irq_set_irq_wake() and irq_chip_set_wake_parent()
instead of always returning success.

Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/1601267524-20199-3-git-send-email-mkshah@codeaurora.org
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1c23f5c..1df2322 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1077,12 +1077,10 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	 * when TLMM is powered on. To allow that, enable the GPIO
 	 * summary line to be wakeup capable at GIC.
 	 */
-	if (d->parent_data)
-		irq_chip_set_wake_parent(d, on);
-
-	irq_set_irq_wake(pctrl->irq, on);
+	if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		return irq_chip_set_wake_parent(d, on);
 
-	return 0;
+	return irq_set_irq_wake(pctrl->irq, on);
 }
 
 static int msm_gpio_irq_reqres(struct irq_data *d)
