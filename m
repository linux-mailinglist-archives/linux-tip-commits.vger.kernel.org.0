Return-Path: <linux-tip-commits+bounces-5631-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D0ABA444
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886EB7A873E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A127FD5D;
	Fri, 16 May 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEy8hp3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jz6Gw3UE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CF27875F;
	Fri, 16 May 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424831; cv=none; b=NqyDtBu7jGHFPupEyBwXl2+OU0Y9ulRIlKnWqZjXkOlSAN/r2D2jDUJUIPONSlg4GvH7j0Dg375Weqd+i+TGi6XOZCafTTwZHd7Pc/ck2nlR5BNbTeQtpA1A9LiMEe8MCTqqzvo+VUD1JeFLtJIjqxJU7AkRUi7F7Km9gKVRJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424831; c=relaxed/simple;
	bh=9N0nAUTF+XvnZM5tzMoLkGqeCNz2U9NOLkuVm2bELQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NJ+J27JeIE237zWq8JRfGp0nM9E/hroE4qAv/7S6qAUnc9aMXqsBUb5fk0YNgtK+VbyD7CwQiJwk3ybPVn/BUqe4uiuDsXo1TSNRAVAe/EY7kFwxEIls5tIye9eziXSNoWFczxpbhOAnP/XD30Iu4AxZUGzD3pj2+/gXTjShNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEy8hp3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jz6Gw3UE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBQFfibhez+aibW3Q8rb/tvCQjY7KlwC7DgbLbw6oMg=;
	b=WEy8hp3wNoa4dK+Pi8O5pUUTKMI69KHnzvrpMYtTK00KDaVceSnBG0hbaQGG9mKGEi5uyX
	OLNudXIx7CNbQBg9gc2s5l2DAdWyZ8nBOfC4NHkml7LzIKrfuEgNTBqquuPFpz/mr60P5v
	nbORUxUPW2MDPCr8XKu0O2IGqpLU1WrD+muYpuVvqGXUV2y+k7r9lXxbE2vRBqmB3JjF3R
	2FsV/DNjFpoqhn91imLRjuQNtxYlo/sqjBHxM5izw3QBxNtBsstrXNYic7wAnKn356JNAo
	ovAqv73zd5KFAaDfFG05VmbEvgS++OWSQkZteH5e7bVQXpZCqANoeirXOB1c5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBQFfibhez+aibW3Q8rb/tvCQjY7KlwC7DgbLbw6oMg=;
	b=jz6Gw3UEdQiRZ22SreAH214ftt8GiVNJh6Q4Ul/bbeDTnoM719Iaa/jnPwsCInKe6oxG/C
	C3dw//oCP/YfcdDg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/msi-lib: Honour the MSI_FLAG_NO_AFFINITY flag
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-7-maz@kernel.org>
References: <20250513172819.2216709-7-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742482690.406.6927417689415923114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     06526443a34c06879664eb5ae247c5e93dde7ed9
Gitweb:        https://git.kernel.org/tip/06526443a34c06879664eb5ae247c5e93dde7ed9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:20 +02:00

irqchip/msi-lib: Honour the MSI_FLAG_NO_AFFINITY flag

Bad MSI implementations multiplex MSIs onto a single downstream interrupt,
meaning they have no concept of individual affinity.

The old MSI code did a reasonable job at this by honouring the
MSI_FLAG_NO_AFFINITY, but the new shiny device MSI code doesn't.

Teach it about the sad reality of existing hardware.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-7-maz@kernel.org

---
 drivers/irqchip/irq-msi-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 2a61c06..246c302 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -105,8 +105,13 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	 * MSI message into the hardware which is the whole purpose of the
 	 * device MSI domain aside of mask/unmask which is provided e.g. by
 	 * PCI/MSI device domains.
+	 *
+	 * The exception to the rule is when the underlying domain
+	 * tells you that affinity is not a thing -- for example when
+	 * everything is muxed behind a single interrupt.
 	 */
-	chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
+		chip->irq_set_affinity = msi_domain_set_affinity;
 	return true;
 }
 EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);

