Return-Path: <linux-tip-commits+bounces-5357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F076AAD97D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59EF1C20490
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F128233D64;
	Wed,  7 May 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnokOu4k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0lSETdZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2A232365;
	Wed,  7 May 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604696; cv=none; b=eytmQi/s5Tu2GrDLrAgSwwl7dkKa17Lfq3UkOyxGGH7vZA4MeFObz5L6mGgjdMr4SyCJ/k6jKZe2q1mpj63o1EL0ZuxOLdMbYdgFX8J7GPQHY3cj+fxJKNhG7u7ZDKOzFJL8QK6n6sWOyaPZ54AlpmEtycBd+LH9LV8p9Qka9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604696; c=relaxed/simple;
	bh=0QvySyo76U1/K5hV/bCXp41cJPeZnpei0bM6qYSy2+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bh0J4XLrRuAXmajJ/w7m9mGrRZQtLl9JtZQ0M6k/OhAZW4DEzPi1XjzQ8loOuIHOJ0SxcdDWEeasDLmg2oS6CV8mUwzXwhgAFt1EgULhIOaLWYT4QMJwU3ogchr+paNrze26fWvcVlkPRvGaCpt3dWC0coh7nStOjCDWVwuIrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BnokOu4k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0lSETdZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhU7O4PxKRSBUdere4V0ilCF8KuXhdmoAu2UQPH3I0M=;
	b=BnokOu4k29PINfMIDIe6UqamW+vxl+buU5D+RNytumpE1wFK7N8eQPjx9E+MwwEJ7hntv4
	8Bw/LdiCxPt2vyzyLromthWtH78f2W2zfllj1AcKh1bZvBv8PNCUT+xMKFe8zWvph4+c1c
	HRijGDzcpef4RtRq7vsnAdXq31IIPnP0CBs5JJUUogZDgKTdRPJv0DPU67Lg0Vgob+wR7o
	//8WdRdWfab/uJ7Wt9sWHChVWjzVmXiCm3DrKE4wO2jz5w6e6MgvJeLQG44ZbZTDPiGEwI
	69qfml0qgNE7znUzxNu3Vdek7Mu4dvs0sGjKGroifKrJTSMoAL7YmqD+Vyg5jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhU7O4PxKRSBUdere4V0ilCF8KuXhdmoAu2UQPH3I0M=;
	b=Q0lSETdZED6sNwX0yPoz2TD5xNB25sdcMiTOK47mnPUEsWPdC9Uj8gxZE2TA5QBFeHlV8c
	6lb3z1ffPKLqYgAg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] EDAC/altera: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-17-jirislaby@kernel.org>
References: <20250319092951.37667-17-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660469223.406.6275979660220592630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     137c278c39e845185670b3c09b94457d0c0bf468
Gitweb:        https://git.kernel.org/tip/137c278c39e845185670b3c09b94457d0c0bf468
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:22 +02:00

EDAC/altera: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-17-jirislaby@kernel.org

---
 drivers/edac/altera_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f9..47cea64 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2130,8 +2130,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
-	edac->domain = irq_domain_add_linear(pdev->dev.of_node, 64,
-					     &a10_eccmgr_ic_ops, edac);
+	edac->domain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
+						64, &a10_eccmgr_ic_ops, edac);
 	if (!edac->domain) {
 		dev_err(&pdev->dev, "Error adding IRQ domain\n");
 		return -ENOMEM;

