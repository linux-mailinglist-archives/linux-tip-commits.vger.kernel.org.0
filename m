Return-Path: <linux-tip-commits+bounces-7021-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0270C0F608
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762E542490E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200E31BCBD;
	Mon, 27 Oct 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgPun8Ge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MqSZyeXq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D731B81D;
	Mon, 27 Oct 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582681; cv=none; b=JSvw5gm1vfSJuiivfUXnXSk9za8nR2bPELDgVXBB0RmkvPBdnQglm+4VXFKRt9s+/uMZ7XGkXs1ptldK+G5F2EpDgmtjzzd1ym1PJVomRSL/S3V4nSUu5BhN/GiivyJrSXHkNHzwdg4PXAoc9t0nRiI9BmEzuBKqo1g32Jg/ncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582681; c=relaxed/simple;
	bh=N215HDRL8x07pPR7aqiNHUkOaKxJ6U3NL/eo4Bir+oQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qDv5GqIw5YdCTIfTRDuQZTI62LJqjDjd2Rarf7IPyRsWI4hOugUzy37VFMUxdjOVSXMQdeTbP11qT4mSYkYPVk3oSN4rTPy2N2tClFYVbQR6Fk8W854Fo2qgSUdN22rut01E4ssWvK/Y61WMGR6QJUYoFJkY6snBQ8aGzfWUBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgPun8Ge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MqSZyeXq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7m783KchwnRRAPoGifr++JrfqNxtBKvjeaAwGq1ORXQ=;
	b=VgPun8GeeuZecFp2RQihMrNy0oaFyUBZPa4leKyLyYAOVrDUT7JsPmNffHIahQEBn84TTg
	WyLhJDsdJlGLsNM0DHUFcs4dgWjVQzquYvA2xLP0wK/S57pPARf5H9QHJb0kJitahCROwR
	yrNixNXs7HxEatggNwXWsowBN+JGiNmNrDHAl6lDBlAukme8tlhWN0wLhBBH+jSzfZa7wR
	VhOb+8L8bIRaq6K157+E7gSVRU6LCZPR9y1OQD1OYPjXqpNNi6346VBkeLM27pMDO8Mgog
	MjAq4jggHrxZc6rsPuqg89luu9qQl8JOcfhx88yfw6NRAo+aHB/4HqHFsixi3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7m783KchwnRRAPoGifr++JrfqNxtBKvjeaAwGq1ORXQ=;
	b=MqSZyeXqS3xxKdO+fTPOQNAZRSg+okDiFCqn9dWtpSXjoOztDk3vHIEOHsze6a1Cwi//ZM
	ZWgsY7Ymi95dZbCA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/apple-aic: Add FW info retrieval support
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Sven Peter <sven@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-7-maz@kernel.org>
References: <20251020122944.3074811-7-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267649.2601451.3798748291516107234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     de575de83c77b693667256774f4d19f33e73f6db
Gitweb:        https://git.kernel.org/tip/de575de83c77b693667256774f4d19f33e7=
3f6db
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:33 +01:00

irqchip/apple-aic: Add FW info retrieval support

Plug the new .get_fwspec_info() callback into the Apple AIC driver, using
some of the existing FIQ affinity handling infrastructure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Acked-by: Sven Peter <sven@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-7-maz@kernel.org
---
 drivers/irqchip/irq-apple-aic.c | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 032d66d..0b72451 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -651,6 +651,33 @@ static int aic_irq_domain_map(struct irq_domain *id, uns=
igned int irq,
 	return 0;
 }
=20
+static int aic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fws=
pec_info *info)
+{
+	const struct cpumask *mask;
+	u32 intid;
+
+	info->flags =3D 0;
+	info->affinity =3D NULL;
+
+	if (fwspec->param[0] !=3D AIC_FIQ)
+		return 0;
+
+	if (fwspec->param_count =3D=3D 3)
+		intid =3D fwspec->param[1];
+	else
+		intid =3D fwspec->param[2];
+
+	if (aic_irqc->fiq_aff[intid])
+		mask =3D &aic_irqc->fiq_aff[intid]->aff;
+	else
+		mask =3D cpu_possible_mask;
+
+	info->affinity =3D mask;
+	info->flags =3D IRQ_FWSPEC_INFO_AFFINITY_VALID;
+
+	return 0;
+}
+
 static int aic_irq_domain_translate(struct irq_domain *id,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -750,9 +777,10 @@ static void aic_irq_domain_free(struct irq_domain *domai=
n, unsigned int virq,
 }
=20
 static const struct irq_domain_ops aic_irq_domain_ops =3D {
-	.translate	=3D aic_irq_domain_translate,
-	.alloc		=3D aic_irq_domain_alloc,
-	.free		=3D aic_irq_domain_free,
+	.translate		=3D aic_irq_domain_translate,
+	.alloc			=3D aic_irq_domain_alloc,
+	.free			=3D aic_irq_domain_free,
+	.get_fwspec_info	=3D aic_irq_get_fwspec_info,
 };
=20
 /*

