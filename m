Return-Path: <linux-tip-commits+bounces-2094-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3F095CBF8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C33B23591
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053518452A;
	Fri, 23 Aug 2024 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOiA9sxw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/yj9NlR7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D06E184520;
	Fri, 23 Aug 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414599; cv=none; b=IKUKE3gDeYX397zyTt2irIqqk7BtHwJ62BaaUp+KOtvDlajyYl5i+9+Mk6555nZRf1WPu0EqJc3gTERGyjk/uqxaXLpY9GXKVoGFIKukfFmjmQIrfK/YgE9ka/w5FM8/53x9A6MoNSk5RifjUb89ceeIwJWm1kv1Yj5DwkApfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414599; c=relaxed/simple;
	bh=CchEQikIIATe2qrbjuWnN9ool6Os4tthXIyHcZnPHqM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cLiCgMhgBX4Le6h4IpwB650pJ///R80zNRmPYB/3P83xIJfdhSQmOaMNNBM19ktHKKCYZMIqWJMybbZwsJI+dKBbcVPlDNPIfwZUVK5pm+2CHABP8W2PidUrSs4/7h6Aw+WmBpmsyjSRvjhInSUiyD5AmZ1StE5auqIowu8JwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOiA9sxw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/yj9NlR7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 12:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724414596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeJgxEa4J3Lj5ofbuAI15yOW9ACHFinKlPh/oANJ76Y=;
	b=yOiA9sxwWGkqsbLNVwEHQ+pZWtUupTao3/tF8wSjWUckBrk77oPGUHcZ6HPifVDw/ml0G4
	ooycSgOFY3/0Ea291BJPnK/hFBIaz88gHTkgVcm7dRe2VcJbnZziBUWCsHk09ESYK0/oF2
	2Kt1qnviG0fo5bfNuHy66xwzA/5pNsGgP31sLnZGwflzSrFlO4NvA8g9p1A9gs6aWcG6Jw
	AHWOJZUy/Hh5kBoiDQfjGI9nhQe9lrsvB5AsapHLVIMGEcBWoQynzL9gPpriryT355pkM+
	4RLjPO4GvH1G3yKjGYR4S3xWtedyF5gZBgk1/eW6YgEi4QQ6sNF3Yd2QexUQ/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724414596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeJgxEa4J3Lj5ofbuAI15yOW9ACHFinKlPh/oANJ76Y=;
	b=/yj9NlR7iSfl5yFuxmRcXUOL2NZHZN/uhTGpyzwYhpsgto0D92dyjblB2v9EN8Y15bxrzO
	07UvzKlLnLe2rzCA==
From: "tip-bot2 for Maxime Chevallier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-msi-lib: Check for NULL ops in
 msi_lib_irq_domain_select()
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240823100733.1900666-1-maxime.chevallier@bootlin.com>
References: <20240823100733.1900666-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172441459534.2215.17071496172496357174.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     880799fc7a3a127c43143935c1a8767d77c19cae
Gitweb:        https://git.kernel.org/tip/880799fc7a3a127c43143935c1a8767d77c19cae
Author:        Maxime Chevallier <maxime.chevallier@bootlin.com>
AuthorDate:    Fri, 23 Aug 2024 12:07:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 13:55:15 +02:00

irqchip/irq-msi-lib: Check for NULL ops in msi_lib_irq_domain_select()

The irq_domain passed to msi_lib_irq_domain_select() may not have
msi_parent_ops set. There is a NULL pointer check for it, but unfortunately
there is a dereference of the parent ops pointer before that.

Move the NULL pointer test before the first use of that pointer.

This was found on a MacchiatoBin (Marvell Armada 8K SoC), which uses the
irq-mvebu-sei driver.

Fixes: 72e257c6f058 ("irqchip: Provide irq-msi-lib")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240823100733.1900666-1-maxime.chevallier@bootlin.com
Closes: https://lore.kernel.org/all/20240821165034.1af97bad@fedora-3.home/
---
 drivers/irqchip/irq-msi-lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index b5b9000..d8e29fc 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -128,6 +128,9 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 	const struct msi_parent_ops *ops = d->msi_parent_ops;
 	u32 busmask = BIT(bus_token);
 
+	if (!ops)
+		return 0;
+
 	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
 		return 0;
 
@@ -135,6 +138,6 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 	if (bus_token == ops->bus_select_token)
 		return 1;
 
-	return ops && !!(ops->bus_select_mask & busmask);
+	return !!(ops->bus_select_mask & busmask);
 }
 EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);

