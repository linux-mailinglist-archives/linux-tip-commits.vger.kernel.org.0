Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D642AA62E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 16:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgKGPN5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 10:13:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgKGPN4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 10:13:56 -0500
Date:   Sat, 07 Nov 2020 15:13:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604762034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUBL1Q9ewccVzUNHLTlQuQpuEgsgoh0nVisziH9kOE0=;
        b=FPwQNs++SXrAQAJuBYJslUy5qu+w+18rTgxU5fmLw2S5akHD2fRjSDaKCxRPphzZyelu+E
        AOnc1aWhqK1e/0ue6d7zgTx+ZYjG2tH3iurTLz3oTUS9LmZg/Z4VZt5hofM/Qn8UHOuJxV
        Fzxyrz8D6YZLGKGXYlYMTF4N1zDV5wjlYIWYumi8moCPVCe0yZpIGZoXlRgPtiw0lTD+fA
        GSMGx3E2aGjCma7yqYUZoo8RdHuGmBNdieaRceW8djsXbZPMtWTUluKElN+reD7l/SVbM4
        f1SFTBEDuUOzyRQbSQNzFMGGS6iA0ez0rQphPJwTjq1ZdHQfnTIqPnMSACn6AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604762034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUBL1Q9ewccVzUNHLTlQuQpuEgsgoh0nVisziH9kOE0=;
        b=a1gNwgMYDePW1KQU5CzLdjW5mEnN7sZLOpTkveQV11M99A/NwIS0Lpt8gr0Dx65LXanu1e
        qjuPAOS8kBLQ90AQ==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] regmap: irq: Convert to use irq_domain_create_legacy()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201030165919.86234-6-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160476203345.11244.1783557205584650453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d315c627a18249930750fe4eb2b21f3fe9b32ea4
Gitweb:        https://git.kernel.org/tip/d315c627a18249930750fe4eb2b21f3fe9b32ea4
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 30 Oct 2020 18:59:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:33:46 +01:00

regmap: irq: Convert to use irq_domain_create_legacy()

irq_domain_create_legacy() takes a fwnode as parameter contrary to
irq_domain_add_legacy() which requires a OF node.

Switch the regmap irq domain creation to use that new function so it is not
longer limited to OF based usage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20201030165919.86234-6-andriy.shevchenko@linux.intel.com

---
 drivers/base/regmap/regmap-irq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ad5c2de..19db764 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -803,13 +803,12 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	}
 
 	if (irq_base)
-		d->domain = irq_domain_add_legacy(to_of_node(fwnode),
-						  chip->num_irqs, irq_base,
-						  0, &regmap_domain_ops, d);
+		d->domain = irq_domain_create_legacy(fwnode, chip->num_irqs,
+						     irq_base, 0,
+						     &regmap_domain_ops, d);
 	else
-		d->domain = irq_domain_add_linear(to_of_node(fwnode),
-						  chip->num_irqs,
-						  &regmap_domain_ops, d);
+		d->domain = irq_domain_create_linear(fwnode, chip->num_irqs,
+						     &regmap_domain_ops, d);
 	if (!d->domain) {
 		dev_err(map->dev, "Failed to create IRQ domain\n");
 		ret = -ENOMEM;
