Return-Path: <linux-tip-commits+bounces-1781-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5093F1BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F3D283F36
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9960146D74;
	Mon, 29 Jul 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQiGMJZj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iIwDSARy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAC14533A;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246593; cv=none; b=Y4x0IDcTg3clMS7psvlmuV+iGZCjBL4nOQhazenjOtFQF/ugFpwK2oTPOHMrtXhCtwPDWXyKeiMkj4WQAy1gg/7//MPiuwW9M8fhNe+Kf49xJJoztZBRxrdaZvB+Mi6ilrpIiss7mRlI7gDLUM/q25RRywkn4J85Rdov/1q59k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246593; c=relaxed/simple;
	bh=wKHONdh088+DfGy2YR2csxsDPrS2Lf9stLlAbj5wwd4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f/BmB1W0EpaJPNkoYKdNZS1KyImeafuytJice66C3SpWPQPXCOQzN/iAHcsu0r4HTwdlgX8BMjjWkmDAYJlXvHsUFiLRXPTjG4OmA12jm00Tf+RmC1mQmNsd8wWSp5Ij86Oe1L9BXPeUhwvYjJzj3pQUMxFx49Jj2J96zDr694k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQiGMJZj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iIwDSARy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiBGYtu2TeL360fzVbgaNJNuHj2aVMA4MRMk2uXA+V4=;
	b=vQiGMJZjCNxFcMY0267kcOTzUYV7HvUOKxrGbugsYartCRIrZORktVXk5zY8u+ulcWBPvf
	riv1DbplGGWxNE7cA1Z0o+WTNw5SEug0wHzpUqscluleso2k9w9sdVnCobNB4uokUVMh9k
	1d0BwBrnOypmLZ4g7IUUWuWp4wTX4tTf7HW6v6hujdnHBUf+O2c8QeplGh2FxwLuZA+wi7
	S6RLELZNw7j8C0X0W2/Lu60A5u6TN3F+gyFhOF1jibFEeHtm47PfkI7YaMl32bIgOP0t92
	JS8HNfVCxAVuV0o+r4a48SRRQv6SGqqLopE8g6oGyamM+VCy0GjPFmfY8SDeVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiBGYtu2TeL360fzVbgaNJNuHj2aVMA4MRMk2uXA+V4=;
	b=iIwDSARyhNR6DFadztNrJclLdbtuFsYbsqLZIlvkLNzXTKSB4ERSNpU7PD8PqsgJfx/6kD
	mVzCe3/FZzEgSuDQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Rename variable for consistency
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-2-kabel@kernel.org>
References: <20240711115748.30268-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658536.2215.13130865374061107629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d258a2da44fe9986e787da056585da0765e78437
Gitweb:        https://git.kernel.org/tip/d258a2da44fe9986e787da056585da0765e=
78437
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:22 +02:00

irqchip/armada-370-xp: Rename variable for consistency

Rename the irq variable to virq in the ipi_resume() function for
consistency with the rest of the code.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-2-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 22e1a49..7016b20 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -462,14 +462,14 @@ static const struct irq_domain_ops ipi_domain_ops =3D {
 static void ipi_resume(void)
 {
 	for (int i =3D 0; i < IPI_DOORBELL_END; i++) {
-		int irq;
+		int virq;
=20
-		irq =3D irq_find_mapping(ipi_domain, i);
-		if (irq <=3D 0)
+		virq =3D irq_find_mapping(ipi_domain, i);
+		if (virq <=3D 0)
 			continue;
-		if (irq_percpu_is_enabled(irq)) {
+		if (irq_percpu_is_enabled(virq)) {
 			struct irq_data *d;
-			d =3D irq_domain_get_irq_data(ipi_domain, irq);
+			d =3D irq_domain_get_irq_data(ipi_domain, virq);
 			armada_370_xp_ipi_unmask(d);
 		}
 	}

