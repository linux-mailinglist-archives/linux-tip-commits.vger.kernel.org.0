Return-Path: <linux-tip-commits+bounces-6238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967DB1B06D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C206D17B3EB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35275259C92;
	Tue,  5 Aug 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ik0C3OFL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ie0YWurg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B432580D1;
	Tue,  5 Aug 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383716; cv=none; b=Bkh3UT4iAVQjNfRUGlPmxU9p+GSMVydUx+UMNJjyTy5mYRIAr0RFmbE17CnkCNPJ+vTeW7dttrsj1xaHWprPGcsLOEnxqxMaOIVcY9UthpvkQDRcr+GQe/G0CMgZqGLFEY1YOA7pMs4Wqqv/q8UGRhFeoRc+LImhAcWXFmJq084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383716; c=relaxed/simple;
	bh=9j52Ol9QZsLKJnXZghGH5iZSIYu8JHu4PmV7bPQBgVo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nZhpR/0+hgFBmffVZDIq1TaMmUcT6WdSg2IdyQYsAwroEWwnHZQ8gHTLih613T2mIq54s+JEowzJiDpdmDYVsREiLsDF4vLBkVoa+VSGjinekTTctwF8v5UZPj11UYV8DcA16RhzzkWuogvGysXRcyZA4v0/eyvfsGsC4R+M91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ik0C3OFL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ie0YWurg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 Aug 2025 08:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754383712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNsyThLl91hLpPwNCRTV6jTSPCt2VGRlNOtt+4Ho9Kc=;
	b=ik0C3OFLk4DmcfGr2KrHA04GfG1/dKpApIEylyNvVgOvb0/YHsBz8Yzo7+h4hbL5TyaNC3
	+H2wFVfNZ9GMa+ppe2lgLM7EoYnNgaJHSYF7wCsK4RpcyK5kK9TCD6l6K3+jFZoyt2F7Xp
	EwacoMSDnD46Eqbugs7MTHeaPjlKz2xJ0cG4YAwfiYZ1ZZViQf1oQ0JqH+6HkzuzbTRfTR
	a5qyPd4MW0mbpkAvn/3vxF5iC6vC7f/8qJBy1a/RFuz1CiT7K6zs+g3t1kXVqABYVbb3lf
	fdhyGtupXsrYVeDf1WR5PXeFf7ICu6d/jJEU2Lgfj2qhu4sEmuQmkKe15od3fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754383712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNsyThLl91hLpPwNCRTV6jTSPCt2VGRlNOtt+4Ho9Kc=;
	b=ie0YWurgBhz/1O8I5docV5YnlHpEEBOET0cxyXTblu5eGk+qEaSwdTqZoKRQuQlEkkLhD3
	RQx1PnP4j6m15VAg==
From: "tip-bot2 for Elad Nachman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/mvebu-gicp: Clear pending interrupts on init
Cc: Elad Nachman <enachman@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250803102548.669682-2-enachman@marvell.com>
References: <20250803102548.669682-2-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175438371158.1420.1973748316495700070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     3c3d7dbab2c70a4bca47634d564bf659351c05ca
Gitweb:        https://git.kernel.org/tip/3c3d7dbab2c70a4bca47634d564bf659351=
c05ca
Author:        Elad Nachman <enachman@marvell.com>
AuthorDate:    Sun, 03 Aug 2025 13:25:48 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 05 Aug 2025 10:35:03 +02:00

irqchip/mvebu-gicp: Clear pending interrupts on init

When a kexec'ed kernel boots up, there might be stale unhandled interrupts
pending in the interrupt controller. These are delivered as spurious
interrupts once the boot CPU enables interrupts.

Clear all pending interrupts when the driver is initialized to prevent
these spurious interrupts from locking the CPU in an endless loop.

Signed-off-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250803102548.669682-2-enachman@marvell.com
---
 drivers/irqchip/irq-mvebu-gicp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gic=
p.c
index d3232d6..fd85c84 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -177,6 +177,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		.ops	=3D &gicp_domain_ops,
 	};
 	struct mvebu_gicp *gicp;
+	void __iomem *base;
 	int ret, i;
=20
 	gicp =3D devm_kzalloc(&pdev->dev, sizeof(*gicp), GFP_KERNEL);
@@ -236,6 +237,15 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
=20
+	base =3D ioremap(gicp->res->start, gicp->res->end - gicp->res->start);
+	if (IS_ERR(base)) {
+		dev_err(&pdev->dev, "ioremap() failed. Unable to clear pending interrupts.=
\n");
+	} else {
+		for (i =3D 0; i < 64; i++)
+			writel(i, base + GICP_CLRSPI_NSR_OFFSET);
+		iounmap(base);
+	}
+
 	return msi_create_parent_irq_domain(&info, &gicp_msi_parent_ops) ? 0 : -ENO=
MEM;
 }
=20

