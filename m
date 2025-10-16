Return-Path: <linux-tip-commits+bounces-6857-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14140BE284C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 587704FDCF1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1017631D736;
	Thu, 16 Oct 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIiiQwLw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9I+MU2s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877031BC94;
	Thu, 16 Oct 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608330; cv=none; b=l4hXuMtUIFXg8q/4eGxw9twb9+oDhR3bSLTxWhU1prwglwJmat7qP3Hq4+b3PSHNlrgs7MrnAS+nZvscF8/P8z0eQ7B78iHUR/PWh8cP8OgellLC5w40rv/eFgb41h6og2Vx3u7EJObYvvfaSf6nHgdV2Mw1LXlnNq7dfje5SAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608330; c=relaxed/simple;
	bh=vkhaADwyDrPBnnQxuIJcrBF4ZKAXEQZu2cLLw2yjM9Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iEgOBdkNnbfyO0TUkLENsc8DwwaGl2Xh7hbc/xJqJEg2L1gXszT0k5yfRXBITJ6i/bfa2hbdXGccKDkbZ5Jk9DM/m+ENjGV85cYYeBB+jof5iMRoOfpD9Pa0c3tL0Y73nnuSuHb3B1stUz34oT79s5F5fh3vwPCA1beubbxafyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIiiQwLw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9I+MU2s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608299;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uVqSiPFhyg1BjqYvOBsfze/w8QkR/V6ERxIH4XpgPA=;
	b=hIiiQwLwPKTYsOOVTSBnAeCB3k4z0Qb0Z4/DgvHdtF9tUEScppUgfo+pKAqkAJL7Zf2PZk
	SXTWVfUzEDnSk/RtoQnQy7H8BT2HMg/tkf6MPWwxY5tG4gD9njNO6NLgwkHtcNYJtFLsk5
	k4oC4LoxygPdhFNLfnHVE8LCZ3I1CKsOXhCZRiXjoL/WShRSsOciFsmL9n5cGyMPeVt+LH
	Xoxdh51QGHCnD8pnOnTUve2+2e2KCRB9jiuoJbEOxAV5CgoE3DDkvq+kbPnrGHDROnR3su
	NwzuXbivmBX2BktBSFq2MLGLgmOS8wEluQRKzF7/yaxP4GvIx7PcDsMcXMUj4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608299;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uVqSiPFhyg1BjqYvOBsfze/w8QkR/V6ERxIH4XpgPA=;
	b=n9I+MU2skPEERtbUaoP2t+QcVle/9IgTgNir/n+ATz/Xp70DPxwPrBHyyl+Y86/Bw6/TKB
	GcY/ZmifYTEkYaCg==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/imx-mu-msi: Fix section mismatch
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-7-johan@kernel.org>
References: <20251013094611.11745-7-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060829803.709179.4558097304522095291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     64acfd8e680ff8992c101fe19aadb112ce551072
Gitweb:        https://git.kernel.org/tip/64acfd8e680ff8992c101fe19aadb112ce5=
51072
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:30:38 +02:00

irqchip/imx-mu-msi: Fix section mismatch

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callbacks must not live in init.

Fixes: 70afdab904d2 ("irqchip: Add IMX MU MSI controller driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-imx-mu-msi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
index d2a4e8a..41df168 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -296,9 +296,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp =3D {
 		  },
 };
=20
-static int __init imx_mu_of_init(struct device_node *dn,
-				 struct device_node *parent,
-				 const struct imx_mu_dcfg *cfg)
+static int imx_mu_of_init(struct device_node *dn, struct device_node *parent,
+			  const struct imx_mu_dcfg *cfg)
 {
 	struct platform_device *pdev =3D of_find_device_by_node(dn);
 	struct device_link *pd_link_a;
@@ -416,20 +415,17 @@ static const struct dev_pm_ops imx_mu_pm_ops =3D {
 			   imx_mu_runtime_resume, NULL)
 };
=20
-static int __init imx_mu_imx7ulp_of_init(struct device_node *dn,
-					 struct device_node *parent)
+static int imx_mu_imx7ulp_of_init(struct device_node *dn, struct device_node=
 *parent)
 {
 	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx7ulp);
 }
=20
-static int __init imx_mu_imx6sx_of_init(struct device_node *dn,
-					struct device_node *parent)
+static int imx_mu_imx6sx_of_init(struct device_node *dn, struct device_node =
*parent)
 {
 	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx6sx);
 }
=20
-static int __init imx_mu_imx8ulp_of_init(struct device_node *dn,
-					 struct device_node *parent)
+static int imx_mu_imx8ulp_of_init(struct device_node *dn, struct device_node=
 *parent)
 {
 	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp);
 }

