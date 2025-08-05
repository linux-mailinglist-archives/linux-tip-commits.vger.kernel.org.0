Return-Path: <linux-tip-commits+bounces-6237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF3B1B06B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F412617B1D8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BD2586C5;
	Tue,  5 Aug 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFXkmTP8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RfiMjwZX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762F2040A8;
	Tue,  5 Aug 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383715; cv=none; b=XKlb0tZmw8rG3+kcOobDEe/+UWO1KVLsTRVfofHR8TQeVJdZqSzK6osORCU3F4MwEP9NzFWIySRl4Cc9shhXe4nEe0a2UOjtdgvZMMN1BQjHHTQ+0YfhpGS1Rh4TTe1QJ2CvgetvVDQiTKcF1kAt4Gx7xz9nPfY7WIxY3hb8E1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383715; c=relaxed/simple;
	bh=04AcdGFGV6gi2NDeiCUcX64BfVvIEoRkfrad9JEXIDo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XBCMKhsM/5FT8D+W267usiXzPSWSB/w2MdK7Ebrlvej1G1lBjQFJ8ND5Jpt/wThjVa6kRl3ChepBcH3ojEyxVGw3GVYxjMPfrq0BRQMVFBIWKxtWhZDPWCXRn4+DqjB0Dy7f+iJY6nz+zIA4GrAEe6EqQDE2p1WqgUhBKTA0jFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFXkmTP8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RfiMjwZX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 Aug 2025 08:48:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754383711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaxlUF9dJiMtKisxRPepCivJWwtfRZ1o7pFxjck4M88=;
	b=AFXkmTP8IH7bw31S1ciYT/ghKF9sic0Wl1OMccHFfzycx0OsBp6GM5YeB3zvhse9oscmcZ
	Vd13npzP453M+Sgd1xE4hZ+jreINpNAe2C4yRrK2lHdaVdMd/QTSEGMFWHZcqILXXBqDqU
	ZT9jgc150dv5s4C4dXD2/VcUA1sNM1eRd+3SE1fUZahcw5bnel5br5rP5OOQChQlnGyNuO
	7lMpqCWhlqXv49D4UnU+/wwkEfQldw1lBqHFBDe9Vxpr4zz1sNLejuu28zNTTEHujOFMsE
	BNiM7wXjSdvPEYJGZwkRaAkB0E8abh/uo8Pruwbtb4bRNEDhSIkoieBBpifVnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754383711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaxlUF9dJiMtKisxRPepCivJWwtfRZ1o7pFxjck4M88=;
	b=RfiMjwZX0L9wAoFaZzIrAYzPSNS7kOCHCoJKSjJW8QyFbLU/ugV7+sjh7fvF6VyXcI3ahP
	37tD3eeoOlr1d6Cg==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v5: iwb: Fix iounmap probe failure path
Cc: kernel test robot <lkp@intel.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250801-gic-v5-fixes-6-17-v1-1-4fcedaccf9e6@kernel.org>
References: <20250801-gic-v5-fixes-6-17-v1-1-4fcedaccf9e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175438371006.1420.11472579450134368633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a8913d54ab1f9ed871b4e45a7c8a4f7a9949d071
Gitweb:        https://git.kernel.org/tip/a8913d54ab1f9ed871b4e45a7c8a4f7a994=
9d071
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Fri, 01 Aug 2025 09:58:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 05 Aug 2025 10:43:48 +02:00

irqchip/gic-v5: iwb: Fix iounmap probe failure path

The 0-day bot reported that on the failure path the driver iounmap()s IWB
resources that are managed through devm_ioremap(), which is clearly wrong
because the driver would end up unmapping the MMIO resource twice on
probing failure.

Fix this by removing the error path altogether and by letting devres manage
the iounmapping on clean-up.

Fixes: 695949d8b16f ("irqchip/gic-v5: Add GICv5 IWB support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250801-gic-v5-fixes-6-17-v1-1-4fcedaccf9e=
6@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202508010038.N3r4ZmII-lkp@intel=
.com
---
 drivers/irqchip/irq-gic-v5-iwb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iw=
b.c
index ed72fbd..ad9fdc1 100644
--- a/drivers/irqchip/irq-gic-v5-iwb.c
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -241,7 +241,6 @@ static int gicv5_iwb_device_probe(struct platform_device =
*pdev)
 	struct gicv5_iwb_chip_data *iwb_node;
 	void __iomem *iwb_base;
 	struct resource *res;
-	int ret;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -254,16 +253,10 @@ static int gicv5_iwb_device_probe(struct platform_devic=
e *pdev)
 	}
=20
 	iwb_node =3D gicv5_iwb_init_bases(iwb_base, pdev);
-	if (IS_ERR(iwb_node)) {
-		ret =3D PTR_ERR(iwb_node);
-		goto out_unmap;
-	}
+	if (IS_ERR(iwb_node))
+		return PTR_ERR(iwb_node);
=20
 	return 0;
-
-out_unmap:
-	iounmap(iwb_base);
-	return ret;
 }
=20
 static const struct of_device_id gicv5_iwb_of_match[] =3D {

