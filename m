Return-Path: <linux-tip-commits+bounces-1654-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D201492D658
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B2C1F223B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D25198A17;
	Wed, 10 Jul 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dT4TtR/K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5FoBC026"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E8195980;
	Wed, 10 Jul 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628753; cv=none; b=DZ2uqdVjBwcjRmM/4dWNEw0O0ZnwY44PlrvOnLdDvUxBO4KSeRcM+xzKkTheL7Hun5B5UX5gXAEYFWmw3LbHgX/Z468lBFg8sxy9/iC8CXL9FwaNQ73kTnhPqy7fwNWMYCmLV5N7i17vOPz8AqCUT5SoxKeyPLZ1xgz72J/HdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628753; c=relaxed/simple;
	bh=p6wrbNjT7tEhbjS3F5Es1kH6NYDyr2AWZ24Saa2c2h0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cXQI7lVi5yD81pzSKtm3NLOE9oBEndG4tgQiq001lSv+icUq9TLawtZWae92dZ1NP6p9r1oT1Q+TW/fhgSoIDf3Skt5uY4DnE0VkaFHWvB5F88KXekZtxsJTCMiXtH7KA3iiTO3khdUhXyhBknN7G5aUDaME2pwxoAnNAT0cykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dT4TtR/K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5FoBC026; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cpzrfBwkFEOHpwPgmSsrYcsiQZbSOGQpsChVnYkKPw=;
	b=dT4TtR/KToIgWV0qNP+CW8He0NQtcLF6Cd83FrmSDehXgxuIzZ4SqTZ8LW7Us3zEjBa18x
	Wlc0sUNAM9vBhgnZvdpQYSS1wfCYqPXWHfNY/bhnOtdUpimyMEZ4nb1YzYVBKG5vVzW0Ee
	l0Iyj3epDCl/NkzYXJQmjijn1xgB0kJj12zSqHzg+x56GnlIAeJ7wyoERkvViYmtp5a71V
	3BZcSQzwqQNiqGE4nlAfV16iytS5piwc+dh1AgRESbHzv2nbt8G71r/+UDKZY4r1hOIxZM
	/LkcXjdgqrm5kQNWfkNd6gmyEg0jLsEz0ajEBYpuW+JuVKpFdPiZR5U7an5anw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cpzrfBwkFEOHpwPgmSsrYcsiQZbSOGQpsChVnYkKPw=;
	b=5FoBC02608JZhFg210MU5nsXFCz4d2JKYzAPm7zQmDsYVXdBkBDTXvRYk/N2qwBBuHmqLz
	WkqFwjHocwxZNICg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mvebu-odmi: Switch to parent MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.759892514@linutronix.de>
References: <20240623142235.759892514@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062874900.2215.7827042175347690927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e7fa0449a49f4589ee5cb2183492865c18aef6c0
Gitweb:        https://git.kernel.org/tip/e7fa0449a49f4589ee5cb2183492865c18aef6c0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:19:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:25 +02:00

irqchip/mvebu-odmi: Switch to parent MSI

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.759892514@linutronix.de



---
 drivers/irqchip/Kconfig          |  1 +-
 drivers/irqchip/irq-mvebu-odmi.c | 37 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 85df667..d078bdc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -391,6 +391,7 @@ config MVEBU_ICU
 
 config MVEBU_ODMI
 	bool
+	select IRQ_MSI_LIB
 	select GENERIC_MSI_IRQ
 
 config MVEBU_PIC
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 1080915..ff19bfd 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -17,6 +17,9 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_ODMIN_SET			0x40
@@ -141,27 +144,29 @@ static void odmi_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops odmi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= odmi_irq_domain_alloc,
 	.free	= odmi_irq_domain_free,
 };
 
-static struct irq_chip odmi_msi_irq_chip = {
-	.name	= "ODMI",
-};
+#define ODMI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static struct msi_domain_ops odmi_msi_ops = {
-};
+#define ODMI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK)
 
-static struct msi_domain_info odmi_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &odmi_msi_ops,
-	.chip	= &odmi_msi_irq_chip,
+static const struct msi_parent_ops odmi_msi_parent_ops = {
+	.supported_flags	= ODMI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ODMI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "ODMI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain;
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -208,18 +213,12 @@ static int __init mvebu_odmi_init(struct device_node *node,
 		goto err_unmap;
 	}
 
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &odmi_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		ret = -ENOMEM;
-		goto err_remove_inner;
-	}
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &odmi_msi_parent_ops;
 
 	return 0;
 
-err_remove_inner:
-	irq_domain_remove(inner_domain);
 err_unmap:
 	for (i = 0; i < odmis_count; i++) {
 		struct odmi_data *odmi = &odmis[i];

