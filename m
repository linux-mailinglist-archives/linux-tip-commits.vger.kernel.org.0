Return-Path: <linux-tip-commits+bounces-6870-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989ABE2900
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363F63A9549
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A11322C97;
	Thu, 16 Oct 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zBmgsDjq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Syp2/QlS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CFA31A563;
	Thu, 16 Oct 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608354; cv=none; b=bzmSuFabSMzGfFTMVeWo/njDKl18g3mh5aEZTdgEI4oJAsQEv9hMSpamJ7v0tPlnftGNjinxEg9oP918bmHwM3HoSJo7L6R2gTzyv/Ti1vAc79pm8l8cIgnoxRq0vrnjrskE7ho0jfrZzRlMB3MMEXPp6vdMz0kEMg05/dQ7quE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608354; c=relaxed/simple;
	bh=sm0fa9kmPDivcSYVjJE4+4eiv98tuoDpobND4DpICTk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XGD7zdeZ+1xqTtjlAGJfC2hDSm/KRaN4a6lnwf7AjS2usL5SY1xQfHdZsZ0fByIrvtKUhZdGkmYv1fRD9taFkCvggM428x54CiTNZNqr4tFbI7mAPQSnAjlL69547P2P3NriRxqfdvcuqD+7Nw7MkJLeGXm5x1YF/oespJDQUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zBmgsDjq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Syp2/QlS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhUGzDVpjcy9BKVauKBoQca3nqv8nYSYeXCzX5oMTdU=;
	b=zBmgsDjqZXa1I03vh5jv6FcQM3yTmJ8hw7tx7rTIYer+i7VNfHtxV5uy+d4TwefMvPOgdX
	rTiurwI0XkkIONrOHtQ3BRTnujczhxchCEHld8rBogkod/UZjYcYXzk1HrSlJk8PgEjtXM
	naVQLPm2HVxvh+uUyy7492kR9RbPoWEont8z12CHd33DEA67Cdg20l3Xz4BFPpnlcOIsh7
	QmhMe7C9dbR/yWAO+F/5VR0A9qCgytYvfu+v7QPESL5nLygrVUTlPmxF1kIh4YGp37t0ft
	NNsr75wMVGpXV5/M+qIiKjZYDrrIX/tkVJS6l9DckdrbSyTEMGBV/REvQeeMqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhUGzDVpjcy9BKVauKBoQca3nqv8nYSYeXCzX5oMTdU=;
	b=Syp2/QlShMeD4Ev55FQE1L8r91khu8xMKDaFYOh5WN4ZWOZ3FN5JscNEVEgtD9/MI/0m7H
	joIlA5FGU+oJkNDg==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-bcm7120-l2: Fix section mismatch
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-5-johan@kernel.org>
References: <20251013094611.11745-5-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060830043.709179.6763794597200836690.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bfc0c5beab1fde843677923cf008f41d583c980a
Gitweb:        https://git.kernel.org/tip/bfc0c5beab1fde843677923cf008f41d583=
c980a
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:30:37 +02:00

irqchip/irq-bcm7120-l2: Fix section mismatch

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callbacks must not live in init.

Fixes: 3ac268d5ed22 ("irqchip/irq-bcm7120-l2: Switch to IRQCHIP_PLATFORM_DRIV=
ER")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l=
2.c
index ff22c31..b6c8556 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -143,8 +143,7 @@ static int bcm7120_l2_intc_init_one(struct device_node *d=
n,
 	return 0;
 }
=20
-static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_7120(struct device_node *dn, struct bcm7120=
_l2_intc_data *data)
 {
 	int ret;
=20
@@ -177,8 +176,7 @@ static int __init bcm7120_l2_intc_iomap_7120(struct devic=
e_node *dn,
 	return 0;
 }
=20
-static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_3380(struct device_node *dn, struct bcm7120=
_l2_intc_data *data)
 {
 	unsigned int gc_idx;
=20
@@ -208,10 +206,9 @@ static int __init bcm7120_l2_intc_iomap_3380(struct devi=
ce_node *dn,
 	return 0;
 }
=20
-static int __init bcm7120_l2_intc_probe(struct device_node *dn,
-				 struct device_node *parent,
+static int bcm7120_l2_intc_probe(struct device_node *dn, struct device_node =
*parent,
 				 int (*iomap_regs_fn)(struct device_node *,
-					struct bcm7120_l2_intc_data *),
+						      struct bcm7120_l2_intc_data *),
 				 const char *intc_name)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
@@ -339,15 +336,13 @@ out_free_data:
 	return ret;
 }
=20
-static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_7120(struct device_node *dn, struct device_=
node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
=20
-static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_3380(struct device_node *dn, struct device_=
node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");

