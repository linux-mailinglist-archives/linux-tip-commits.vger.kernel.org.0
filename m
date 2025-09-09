Return-Path: <linux-tip-commits+bounces-6520-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A2DB4A8DD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9D01722A8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AAB2D5426;
	Tue,  9 Sep 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lx/o1FXn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gf4EH5ge"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEA2D3EEE;
	Tue,  9 Sep 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411523; cv=none; b=AVVugVx2Uqvzz5AMtzMXqkF6XBMYvqveAcM4lt3/V0VzufiHcd3/Oa/pHL/DbKDyu9IQnQ8s+6nXna8wHCRzuT1sktLSmXDgzwpDUomdlWsAvJl5BVXBRwbMcYDTGGKz9Tni813R4LvM7p8aAJs0GRLa8TV3t6jzb49VGcvTzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411523; c=relaxed/simple;
	bh=QP/aBIPQSbnVcdKKUXJvpPZF/QKZMFi6CbXoEKsJvh4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gulzORF3wcYHt/SqtFRbyVNt0/UVsm237sl4kr0VuGyjX0RgD/2du2omkO8pOxaXu7MMhSgnoqmcP8OtEql+T/jdho45kbd0EHcLJx1WG8WLCApkN+uFeInb10LE3y7HEU/PumeEPWQ/qYs5EgVoB05o82+YKPlEac6V+jv1qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lx/o1FXn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gf4EH5ge; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:51:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757411519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htl9VYOpJyLZ/63WFSvnVtkxGtnkVobts9X9O+GZEek=;
	b=lx/o1FXnbStQ37jrUmws6+N2iFJ/JjPCOJMI/7Unwqm0V5As1RFSn7OORZVmMB0Helh4ym
	J+D8qF6HEEGlr+iUazKqC/8FL67bqg5nB24TA0DGM8xnGxaOxImBwz9LA2950DxZH9WTuF
	Qwg8dUllSA038evp4ockVQr0LiXUlgiLqtKADlzFxkfzwctj1p4Mz2KOoIjoaJkduWX2yh
	yA6xQ9PlgajcYpgrUknmkc8gPIAuNIM+JBCndNvdCEgYO75ZO3Y6eHLTM4daGpebqyHigT
	GpXL5/M5dGqShonZwTVCV3LfWaJq2LPRKV42eMzdDn7RjUwdcjEm0TXvmTZdrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757411519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htl9VYOpJyLZ/63WFSvnVtkxGtnkVobts9X9O+GZEek=;
	b=Gf4EH5ge4LX10BPnnzTEvDRomotQflEjtBzgKYfJ9ByI+vTaacOwClSlSq7VaqW5+2FpJK
	TBO8jwR2BFj3OSCw==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/gic-v5: Fix error handling in
 gicv5_its_irq_domain_alloc()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908082745.113718-4-lpieralisi@kernel.org>
References: <20250908082745.113718-4-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741151009.1920.16587083303795597560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a186120c780e21e4cfd186a925e34f718e30de88
Gitweb:        https://git.kernel.org/tip/a186120c780e21e4cfd186a925e34f718e3=
0de88
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Mon, 08 Sep 2025 10:27:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 11:51:09 +02:00

irqchip/gic-v5: Fix error handling in gicv5_its_irq_domain_alloc()

Code in gicv5_its_irq_domain_alloc() has two issues:

 - it checks the wrong return value/variable when calling gicv5_alloc_lpi()

 - The cleanup code does not take previous loop iterations into account

Fix both issues at once by adding the right gicv5_alloc_lpi() variable
check and by reworking the function cleanup code to take into account
current and previous iterations.

[ lpieralisi: Reworded commit message ]

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/all/20250908082745.113718-4-lpieralisi@kernel.o=
rg

---
 drivers/irqchip/irq-gic-v5-its.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index dcdf8bc..554485f 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -947,15 +947,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain=
 *domain, unsigned int vi
 	device_id =3D its_dev->device_id;
=20
 	for (i =3D 0; i < nr_irqs; i++) {
-		lpi =3D gicv5_alloc_lpi();
+		ret =3D gicv5_alloc_lpi();
 		if (ret < 0) {
 			pr_debug("Failed to find free LPI!\n");
-			goto out_eventid;
+			goto out_free_irqs;
 		}
+		lpi =3D ret;
=20
 		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
-		if (ret)
-			goto out_free_lpi;
+		if (ret) {
+			gicv5_free_lpi(lpi);
+			goto out_free_irqs;
+		}
=20
 		/*
 		 * Store eventid and deviceid into the hwirq for later use.
@@ -975,8 +978,13 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain =
*domain, unsigned int vi
=20
 	return 0;
=20
-out_free_lpi:
-	gicv5_free_lpi(lpi);
+out_free_irqs:
+	while (--i >=3D 0) {
+		irqd =3D irq_domain_get_irq_data(domain, virq + i);
+		gicv5_free_lpi(irqd->parent_data->hwirq);
+		irq_domain_reset_irq_data(irqd);
+		irq_domain_free_irqs_parent(domain, virq + i, 1);
+	}
 out_eventid:
 	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
 	return ret;

