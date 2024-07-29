Return-Path: <linux-tip-commits+bounces-1751-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ACE93EFF1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04079282EA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63441353FE;
	Mon, 29 Jul 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OcLTRqR+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24IDGz/2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3576F2F1;
	Mon, 29 Jul 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241947; cv=none; b=ksexcfj6vV//qYhG+OihosZFr3qPhCeDDE1A9s6oA/9nxtPqMK9ibokT4DTKBcZjfKc+MzD8MvsODYt/MVDD2xk1NhufL+xKFbwLkkmUJ7k+qiaW2RWNAVPkNX9G+0E66Hi148C0R24wc0/3PMfF27QjkyBge38hUpy1MXXqMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241947; c=relaxed/simple;
	bh=gGOw6e1VWw4qQS8Sgi9jspCG1Yvhe69nV21FhD9edfY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f0cdvZ0DciAFEa+T+YZxkH8dXOb1AfVuhh63VPE0fILDLJ0Jwbs10mG9d79r7dqpb6Yv2URYbgcoEhPu3U2SiGH3yMwEdlIiQJXys0FPYEFtS7Q+XfjJnX7nYNggWQDTfqvizCCJvKjtXMCaP76sgdNHcEowNJ59FlRwgWeC/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OcLTRqR+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24IDGz/2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 08:32:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722241944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igj8WnfXHEtBehnbMlyvLDVNd2VeWb3Xm0pqSjOt3HM=;
	b=OcLTRqR++oDqVyBP3Uc1NdNZ1JAAXruEjlVmUn+qw/tms5h+kuYygm4SlglqqcQGwlIIuB
	8e9D007vloTEiiScirxmyIKVuV0AK1YwwXjHaYrCzC8Av5PD90qtK2pR5IcSCJx+LLPZPj
	TR/Lp9iqt2h/kaEZ6tsKo38Byv2U1XHUzbNNchGnHqXkeRf4mWmYInnCDN2+Twu0pPRJka
	QriLM6GjgruvEiREPknCMLuPlOwGfGwX2BtXeeuRzTZUQ8XEjfv0XK56FAa49cbUNSba42
	Zyxyq1MfUeq8ZOTSigc4lgrJxhYwOS6BOSTLTW+bhyuCF8oltXiCwVaVeEGzIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722241944;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igj8WnfXHEtBehnbMlyvLDVNd2VeWb3Xm0pqSjOt3HM=;
	b=24IDGz/2XUnfsbEMQ9ATIZNyRkWQUATyYxWM5dudZAIbIbBX7cEA268l1T4vexBKtT7jYk
	f+cntKrXQtWYRvCQ==
From: "tip-bot2 for Luca Ceresoli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-pic32-evic: Add missing 'static' to
 internal function
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To:
 <20240717-irq-pic32-evic-fix-build-static-v1-1-5129085589c6@bootlin.com>
References:
 <20240717-irq-pic32-evic-fix-build-static-v1-1-5129085589c6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224194392.2215.1753919882787406820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a4765eb49cd94a7653c1a643b03d4facc5d87aa5
Gitweb:        https://git.kernel.org/tip/a4765eb49cd94a7653c1a643b03d4facc5d=
87aa5
Author:        Luca Ceresoli <luca.ceresoli@bootlin.com>
AuthorDate:    Wed, 17 Jul 2024 14:25:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:22:45 +02:00

irqchip/irq-pic32-evic: Add missing 'static' to internal function

Fix build error reported by gcc 12:

  drivers/irqchip/irq-pic32-evic.c:164:5: error: no previous prototype for =
=E2=80=98pic32_irq_domain_xlate=E2=80=99 [-Werror=3Dmissing-prototypes]
    164 | int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node=
 *ctrlr,
        |     ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240717-irq-pic32-evic-fix-build-static-v1-1=
-5129085589c6@bootlin.com

---
 drivers/irqchip/irq-pic32-evic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evi=
c.c
index 1d9bb28..2772403 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -161,9 +161,9 @@ static int pic32_irq_domain_map(struct irq_domain *d, uns=
igned int virq,
 	return ret;
 }
=20
-int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-			   const u32 *intspec, unsigned int intsize,
-			   irq_hw_number_t *out_hwirq, unsigned int *out_type)
+static int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *=
ctrlr,
+				  const u32 *intspec, unsigned int intsize,
+				  irq_hw_number_t *out_hwirq, unsigned int *out_type)
 {
 	struct evic_chip_data *priv =3D d->host_data;
=20

