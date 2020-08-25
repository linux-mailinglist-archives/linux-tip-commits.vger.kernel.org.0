Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4C252442
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Aug 2020 01:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHYXk6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 Aug 2020 19:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHYXk4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 Aug 2020 19:40:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F8C061755;
        Tue, 25 Aug 2020 16:40:55 -0700 (PDT)
Date:   Tue, 25 Aug 2020 23:40:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WRkfD05x7MCm3eiOQBtDuIPIfOjQ7TSZpVY4wuWe4dY=;
        b=CfnDvFW5CBxTqucbnDi5dtSj6DnLfsd2hOp30wEpUJ2ad1TWrkK8LThvyn2lrRhMFMEp9x
        ILoVgvYF8KaazBYD5hb3x9YAufLFuJV9Jz/ICmAJzR1PpoCCOHQpnfPjtzYJuWo9Jk7ZEH
        0ATPNzsSLpc2nwaVooL8PYjKXxU7H6+VgxZdyi7ABbVkCwOCGw4GnuQ6WlSrwouU01D48t
        TsqOb6yScmrkInbq7YsJ2iKvAC7HYJqflCO+5kcxZFXT5fjxXjgSX1GKCt6lQkKdAjXjlD
        nWrW33sWLpsKcBAj4MDk2t/JFTWexTmPwM6WL1XOiKsM9Y8Qmc/2EBFlfcH+xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WRkfD05x7MCm3eiOQBtDuIPIfOjQ7TSZpVY4wuWe4dY=;
        b=Ww0K10CmS2d8PrbI5XrstP/Lu682BieLgWACuTywuZU5ecoKiwQv1AVoXd3qlUpwI3xc5D
        oqGfOP3KsxaUqCCw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip: Fix probing deferal when using
 IRQCHIP_PLATFORM_DRIVER helpers
Cc:     John Stultz <john.stultz@linaro.org>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159839885325.389.3069378479635894674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     7828a3ef8646fb2e69ed45616c8453a037ca7867
Gitweb:        https://git.kernel.org/tip/7828a3ef8646fb2e69ed45616c8453a037ca7867
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 10:57:45 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 17 Aug 2020 08:06:11 +01:00

irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpers

When probing an interrupt controller that is behind a parent,
we try to check whether the parent domain is available as
an indication that we can actually try to probe.

Unfortunately, we are checking this with the firmware node of
the about to be probed device, not the parent. This is obviously
bound to fail.

Instead, use the parent node.

Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros")
Reported-by: John Stultz <john.stultz@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irqchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 1bb0e36..d234115 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -52,7 +52,7 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller. The actual initialization callback of this
 	 * interrupt controller can check for specific domains as necessary.
 	 */
-	if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
+	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
 		return -EPROBE_DEFER;
 
 	return irq_init_cb(np, par_np);
