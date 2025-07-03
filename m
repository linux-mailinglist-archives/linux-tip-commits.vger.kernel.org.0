Return-Path: <linux-tip-commits+bounces-5989-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21EAAF767C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7101C87106
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACE92E9EDA;
	Thu,  3 Jul 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QPpR4y96";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XfQnyi4d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB92E7F13;
	Thu,  3 Jul 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551235; cv=none; b=tUAQ6z3bqOBtynX7HYofyhY2mIUBDCQ3096dmgRBkiqCUeRzaIk2e3hg/BL8z78bNYmCI77AWdA7EwaFS/Ka5XgOb6uE/2crRvZ761YuBs0HAqIgGmgfsBr9Domj3WGt5weAPlvdN2h/s9iW7Egol1bl+zs5J8V+5iNikFB4Y2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551235; c=relaxed/simple;
	bh=84B9ECo25r7Y29uGZxqNhX2GCI/7c9dDBhQ+n7APn50=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iRB8H3zM8R4MMSm19iqxVxgmKOYU+A4pn9dH/EiWyeFjDnywlUpmAP9Q42WVGC/Z3xpcOsAIXNgeNsN5hTDjXELpIOKvCW8eU0q8El1J8+W83tIDKJ0dEQZpzgeNbDD8zXSeNYaJeIuTDhh4IspPSQ25UigDTPteHr1C5t+jVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QPpR4y96; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XfQnyi4d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eteJ/VcNVDl6VY87maxudzOv9HXtWF6OdZyM6LEZ44=;
	b=QPpR4y96lrVBrnMILWUKCPr0s8lPoAPtzktvg5Df2KkU4REz/gHhT5n1381FV7rvwBwYs3
	qMTCFFbxhR1qFYPbFtfUWAN8aWPQhRouqWvNz4o4BnC2MMU9OxsnH9xObpneV9Roh511CB
	qYkeQwwpA+3T7mXM0axO1ggFYagbUFXX/uwCILxZ3jPpahM0g15E1Ydcr9aouFX/VIoJYi
	oeKXTiTPJykbtC0sdd+eFp+fLPAF9rL4PGO1soyaIemuxou1cCacOxx+PXfJPVSxTe4BKH
	NIzOznOoppTVdSr5s0M8DxswNsiAVuuT5bopNm9pJ8tRCny7Ie0XYK8ENQnNDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eteJ/VcNVDl6VY87maxudzOv9HXtWF6OdZyM6LEZ44=;
	b=XfQnyi4dCJv9qR7s8eYgShIV8VXfC/9Qmq8wPdoYXgUEEQ1evzjxoWN2iYmBsapUj/jmeN
	/t1mlYWePC6SczBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/alpine-msi: Convert to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7886b9595aaf8e102f79364784f68dec9c49b023=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C7886b9595aaf8e102f79364784f68dec9c49b023=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123134.406.9342162435788928180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     71476f915f92cd9fb209f8729d700703ec3c36bc
Gitweb:        https://git.kernel.org/tip/71476f915f92cd9fb209f8729d700703ec3c36bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:25 +02:00

irqchip/alpine-msi: Convert to lock guards

Convert lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/7886b9595aaf8e102f79364784f68dec9c49b023.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/irq-alpine-msi.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 7e379a6..cf188e5 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -60,19 +60,12 @@ static int alpine_msix_allocate_sgi(struct alpine_msix_data *priv, int num_req)
 {
 	int first;
 
-	spin_lock(&priv->msi_map_lock);
-
-	first = bitmap_find_next_zero_area(priv->msi_map, priv->num_spis, 0,
-					   num_req, 0);
-	if (first >= priv->num_spis) {
-		spin_unlock(&priv->msi_map_lock);
+	guard(spinlock)(&priv->msi_map_lock);
+	first = bitmap_find_next_zero_area(priv->msi_map, priv->num_spis, 0, num_req, 0);
+	if (first >= priv->num_spis)
 		return -ENOSPC;
-	}
 
 	bitmap_set(priv->msi_map, first, num_req);
-
-	spin_unlock(&priv->msi_map_lock);
-
 	return priv->spi_first + first;
 }
 
@@ -80,11 +73,8 @@ static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned int sgi
 {
 	int first = sgi - priv->spi_first;
 
-	spin_lock(&priv->msi_map_lock);
-
+	guard(spinlock)(&priv->msi_map_lock);
 	bitmap_clear(priv->msi_map, first, num_req);
-
-	spin_unlock(&priv->msi_map_lock);
 }
 
 static void alpine_msix_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)

