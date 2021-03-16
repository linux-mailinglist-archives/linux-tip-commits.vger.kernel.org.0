Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A494F33D751
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Mar 2021 16:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhCPP0J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Mar 2021 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhCPPZv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Mar 2021 11:25:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAAC06174A;
        Tue, 16 Mar 2021 08:25:49 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:25:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615908348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwQkacUhSYfqj80E6WJVpogHjelAPI8Xa2wZ2lUXs2A=;
        b=31CpDNa/AaAJFVA6+/LbsJ0mTEnR4cQsDvD3b13Wtpcgo2fD0NL9QnrYg1ZDSBIIa2e4H6
        bNWr/EVGPS6KzL4LvLqPfd+S3/x/OcNhBawTKPy/ceVRouXqkLOzxi6PUcYbyJKAz5TBpJ
        Ep2/z+pKmci/KNGu52aCuMFIhWYZDZvr2MJ1YZq+7hlg0Y0lCqa0qhlZBeZtvR1QxBSndk
        5dWO88DNoj5SHvIigY9W9UM5dt0IJCvGgjcz2CUCVctnkqBWKeTqu6gpw/zBcxJ0YWK1vO
        TBP6i0n8C7fxfxfbmF1TTt5c0qxZ3ZHhwcYmM3zPPvcvPtX8H4hPsbB34vJxKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615908348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwQkacUhSYfqj80E6WJVpogHjelAPI8Xa2wZ2lUXs2A=;
        b=WLtGVEnb/Qji6a5KMxTJcEtj6A9eFbzlCffSAe/KuxkKGNcHC6ngDZVMyJ5qHm0NOQsyCR
        6tyF+l5LuP7LlRAQ==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/irq_sim: Fix typos in kernel doc (fnode -> fwnode)
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210302161453.28540-1-andriy.shevchenko@linux.intel.com>
References: <20210302161453.28540-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161590834731.398.16285162336678712661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ef4cb70a4c22bf301cd757dcc838dc8ca9526477
Gitweb:        https://git.kernel.org/tip/ef4cb70a4c22bf301cd757dcc838dc8ca9526477
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Tue, 02 Mar 2021 18:14:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 16 Mar 2021 16:20:58 +01:00

genirq/irq_sim: Fix typos in kernel doc (fnode -> fwnode)

Fix typos in kernel doc, otherwise validation script complains:

.../irq_sim.c:170: warning: Function parameter or member 'fwnode' not described in 'irq_domain_create_sim'
.../irq_sim.c:170: warning: Excess function parameter 'fnode' description in 'irq_domain_create_sim'
.../irq_sim.c:240: warning: Function parameter or member 'fwnode' not described in 'devm_irq_domain_create_sim'
.../irq_sim.c:240: warning: Excess function parameter 'fnode' description in 'devm_irq_domain_create_sim'

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210302161453.28540-1-andriy.shevchenko@linux.intel.com

---
 kernel/irq/irq_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 4800660..40880c3 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -159,7 +159,7 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
  * irq_domain_create_sim - Create a new interrupt simulator irq_domain and
  *                         allocate a range of dummy interrupts.
  *
- * @fnode:      struct fwnode_handle to be associated with this domain.
+ * @fwnode:     struct fwnode_handle to be associated with this domain.
  * @num_irqs:   Number of interrupts to allocate.
  *
  * On success: return a new irq_domain object.
@@ -228,7 +228,7 @@ static void devm_irq_domain_release_sim(struct device *dev, void *res)
  *                              a managed device.
  *
  * @dev:        Device to initialize the simulator object for.
- * @fnode:      struct fwnode_handle to be associated with this domain.
+ * @fwnode:     struct fwnode_handle to be associated with this domain.
  * @num_irqs:   Number of interrupts to allocate
  *
  * On success: return a new irq_domain object.
