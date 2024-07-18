Return-Path: <linux-tip-commits+bounces-1728-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3B9351C8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AE51C21015
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0B1482E8;
	Thu, 18 Jul 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nFMqqsT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jhsbioif"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C711465A9;
	Thu, 18 Jul 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327949; cv=none; b=SUb5A2sdFXitahzONTU8K91Lw1zWdBQhCeG+nlNe+Pfqulfp0qkgW5yOPkOFBVoKLzGBKgIhUilfbg3BVZRy/sKKmOSeQPDL+Wa02a0Xtq8Ng7KDizwx+zYoq/HjA4HHHO8MKQlLFzmWeHKbyZL+zkZXFqvi+OBhxw9Wo3JlGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327949; c=relaxed/simple;
	bh=YhKtLZjjpMz8j2H+EPLlESUns2A4kCFnK0C3k1Q93BY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BK8dXdY+uX1s4EuXK24g3/b6MivXUOzFgBoW1NHXqi3vjkcrgkwf4ks++k8avtyjAKefdFo3/Inhv1uUYy5C3olAj7TPlzBohX/9xGNwZ4IPE3IhvCu6ByaYKeXEu6LvUyZMuTL+sLrOCYhz8fsCHL7CgSMwq84b6ScD1nVWfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nFMqqsT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jhsbioif; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHwvZLy9+lzKqr6QqjIATFs6rxtkqQKPlGb37/mECtg=;
	b=4nFMqqsTHV7kaoqrG8GlEzCKEvoCg40lmw6l4Llhrf8mpNRxx7NATgeUkA/5VItuQL/aue
	kBLbzllbpEcOyeYCiXpSMqGFX2cRCUmF+RdWZG4MjriVxaOzXS1R0RTiMNbzAp/1JTsthm
	5lFO5j4FcW9R+H4FXdSGMIcQFGax3nX1vEeY2HXEfdVexDXDTKKs/Uf52dpL7SEFzHciXM
	+va/s3wqJsVS7ybkyOMCCr/oAaXKonb6VGea5lvAGiJYdgYJzY6gZQRHKNleeehbsI+xxY
	RJP0XCnSMLwM+GX43uOtnVoifK3YqS37RGlswrV/QZr0UJEC1UoCoYaN9kT4yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHwvZLy9+lzKqr6QqjIATFs6rxtkqQKPlGb37/mECtg=;
	b=JhsbioifPWUHeYEV2eRQYUpoiYKKzDqQMT7tWuBUz8sMuOibo0PYkQj28+80xqsC1H6GI7
	lHEJiJpeoAGx/1DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.207343466@linutronix.de>
References: <20240623142235.207343466@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794078.2215.17531869122895257071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     64a855324311ddad7a85fc0b25ce1f3914ed3425
Gitweb:        https://git.kernel.org/tip/64a855324311ddad7a85fc0b25ce1f3914ed3425
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI

Add the new bus token to the accepted list of child domain tokens.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.207343466@linutronix.de



---
 drivers/irqchip/irq-msi-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index b98a219..d20a0e6 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -69,6 +69,8 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 
 		/* Core managed MSI descriptors */
 		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
+		fallthrough;
+	case DOMAIN_BUS_WIRED_TO_MSI:
 		/* Remove PCI specific flags */
 		required_flags &= ~MSI_FLAG_PCI_MSI_MASK_PARENT;
 		break;

