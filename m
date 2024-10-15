Return-Path: <linux-tip-commits+bounces-2446-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00599FACF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DAF281C72
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A01B0F08;
	Tue, 15 Oct 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQpkIo+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqFsELKu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D121E3C4;
	Tue, 15 Oct 2024 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029802; cv=none; b=NQ+ILvfSGzgF0ZKrqh+c/tC6Hl227AgFa8TctPJ5ZmkKeJMxkMVVLENdoWqMa45AiaePomJj+oGctJqkeM/knzI3fmh/Kih5vqLaW0llXByF/5XaR2t+5xk9LZ0ykVy7m51Sg0/E00qgwUOVjSWZKG5LDyipqAOgl0n326vYZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029802; c=relaxed/simple;
	bh=Xn/QwVVPsPUIzqIR7AhS7kyDn+7nH/G4+3FME/zgoRc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sk5V+qFQVozslktGjnyi+Picvv0edTuz2sYIqIYEzmcqdJ9yC4AtnbziAIRt6oaWow0PO/O8GYX2GfReVLYOL9ipScOAbrzjgMbNqXI15+sJ6pogEum+Mx7x7+BQ95+swekP5Go0zNadr6h6oV9bAbXgKU7jSE8PO2IW7+TkBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQpkIo+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqFsELKu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:03:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729029799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDEVGXAzdZMCh87fIgpEmn5OGWpUxbaX1h13DoaRg1A=;
	b=PQpkIo+M88SuhhYr0x7q36kTrlmrTNVYzx7fyW6fqlr4AJBn+eoc0lRffatlIbYE8fHLsd
	MxdRoRxaI9ttU7j7zVQ1odQLvCv5m/IhJOcWdLNPsIt969fPu2OOkI8nNstb0hB9CAWboq
	NScx8GuUhB9p6whpWr6LhFBLjFud3ZsQupohTDaJQLXCxTEBBmrmMKc2jLhIIRf0XTu5xZ
	1rIxrjO/h8b8DhOicAazss2nyppoL8rD74+6D51BPcCQCzzaNw6EN0kMGRZugWUx7RqTQv
	yXn4eAPNUYWwRzcqREKoSjD90p09lr8qOgdDI+iQnXEPRtRiettON5P2FAD85g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729029799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDEVGXAzdZMCh87fIgpEmn5OGWpUxbaX1h13DoaRg1A=;
	b=UqFsELKuAeAMpDwOA7cfSo80cq77p2chDJP5VLuC1pNtOzFnvuNAlyp2wMjKlpgzYNlVyW
	MBlAV5cM0WRKHlCg==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/renesas-rzg2l: Fix missing put_device
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241011172003.1242841-1-fabrizio.castro.jz@renesas.com>
References: <20241011172003.1242841-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172902979867.1442.5327941967241834264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d038109ac1c6bf619473dda03a16a6de58170f7f
Gitweb:        https://git.kernel.org/tip/d038109ac1c6bf619473dda03a16a6de58170f7f
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Fri, 11 Oct 2024 18:20:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 23:54:35 +02:00

irqchip/renesas-rzg2l: Fix missing put_device

rzg2l_irqc_common_init() calls of_find_device_by_node(), but the
corresponding put_device() call is missing.  This also gets reported by
make coccicheck.

Make use of the cleanup interfaces from cleanup.h to call into
__free_put_device(), which in turn calls into put_device when leaving
function rzg2l_irqc_common_init() and variable "dev" goes out of scope.

To prevent that the device is put on successful completion, assign NULL to
"dev" to prevent __free_put_device() from calling into put_device() within
the successful path.

"make coccicheck" will still complain about missing put_device() calls,
but those are false positives now.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241011172003.1242841-1-fabrizio.castro.jz@renesas.com
---
 drivers/irqchip/irq-renesas-rzg2l.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 693ff28..99e27e0 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -530,12 +531,12 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *parent,
 				  const struct irq_chip *irq_chip)
 {
+	struct platform_device *pdev = of_find_device_by_node(node);
+	struct device *dev __free(put_device) = pdev ? &pdev->dev : NULL;
 	struct irq_domain *irq_domain, *parent_domain;
-	struct platform_device *pdev;
 	struct reset_control *resetn;
 	int ret;
 
-	pdev = of_find_device_by_node(node);
 	if (!pdev)
 		return -ENODEV;
 
@@ -591,6 +592,17 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
 
+	/*
+	 * Prevent the cleanup function from invoking put_device by assigning
+	 * NULL to dev.
+	 *
+	 * make coccicheck will complain about missing put_device calls, but
+	 * those are false positives, as dev will be automatically "put" via
+	 * __free_put_device on the failing path.
+	 * On the successful path we don't actually want to "put" dev.
+	 */
+	dev = NULL;
+
 	return 0;
 
 pm_put:

