Return-Path: <linux-tip-commits+bounces-2013-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BDC94C104
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE45B28EA5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A61922F7;
	Thu,  8 Aug 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBVfjfhn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7LMANXLx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F83191F71;
	Thu,  8 Aug 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130510; cv=none; b=Uy9oIFj7qxHfSomdNLmorwkry5iy9Po+VGlhWBdsPU38oLWwSYL+WRctP+dG2zAI/fISKdkEre1iFHZFyzZ5l8v0suraEa6LGcvwWHnTc7p30vtpMf2ZYq+VE4tzSynD5dp3FLG+YwFtGBdBLPOwkfGMdh6WBu+HQbe0OS1z8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130510; c=relaxed/simple;
	bh=xo14lWWJK0ILuJB48aPx/djzCYtlN0D8Z9xuTZvzITg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rqMNA7PuRZ7tT+ZxvjfZkyrDf6ebvYvMlbHhiQcqNoLo3HBEoylaIe8TPttoP8cgJxBz5cskxGTeH1GckFlP+Cwk+8kaXF7Dr7AuRy29Y6NFocnnKdZ4L737lVTfGwKMuzky+g2NiSCVOAnlfAHMz3tqV6j4xBLScPvnmdplImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBVfjfhn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7LMANXLx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ynRjhQCXtvFMjyjJ0LrTHE6fjr5OBkNT2kFKoljtQOc=;
	b=uBVfjfhnVGGW8ugBhdQj6jzNjK3y/E2TKnlzSbEIDHg1JsXjuC0ei38Ly5oGLNWsI/hjpI
	rw1D8Aon4htl0RoKQ8FOTxlB6EwNgkAoBLI6lSEsZFEnohp41Ux8nARFIm83jIAkKT7L30
	8QTsZVx5/8AZgRlQBztwp7mkuX8fuhwiRRzh3TZKyqBUx5mbz/bBebJrQYmUD5566i5Njn
	IsPspS0yp9B4zdYDMOUmg5z30nNrJVC+sv1vWVv9OcOp3g7QYOhelRF3vLTpl7dvzSvgdc
	wqbhhoHJi1GyIMXpLKjY//PJp2BPB2xCzboC0lE3fl5ToqDtjSKqOlJ9HXeljw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ynRjhQCXtvFMjyjJ0LrTHE6fjr5OBkNT2kFKoljtQOc=;
	b=7LMANXLxIQ+fqFeIDYYBDMJo15JiHQKHiTexmmpeh0PovX3fXIDi/NG1DRSXFH/YF79Phj
	rNINHZL6J2w+zFDA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Drop msi_doorbell_end()
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050662.2215.2404618918055172623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0dbf9b6025e3d6092ad883541c090118e5361d98
Gitweb:        https://git.kernel.org/tip/0dbf9b6025e3d6092ad883541c090118e53=
61d98
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:40:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:00 +02:00

irqchip/armada-370-xp: Drop msi_doorbell_end()

Drop the msi_doorbell_end() function and related constants, it is not
used anymore.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 9a431d0..fcfc5f8 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -140,13 +140,11 @@
 #define IPI_DOORBELL_MASK			GENMASK(7, 0)
 #define PCI_MSI_DOORBELL_START			16
 #define PCI_MSI_DOORBELL_NR			16
-#define PCI_MSI_DOORBELL_END			32
 #define PCI_MSI_DOORBELL_MASK			GENMASK(31, 16)
=20
 /* MSI interrupt definitions for non-IPI platforms */
 #define PCI_MSI_FULL_DOORBELL_START		0
 #define PCI_MSI_FULL_DOORBELL_NR		32
-#define PCI_MSI_FULL_DOORBELL_END		32
 #define PCI_MSI_FULL_DOORBELL_MASK		GENMASK(31, 0)
 #define PCI_MSI_FULL_DOORBELL_SRC0_MASK		GENMASK(15, 0)
 #define PCI_MSI_FULL_DOORBELL_SRC1_MASK		GENMASK(31, 16)
@@ -190,11 +188,6 @@ static inline unsigned int msi_doorbell_size(void)
 	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_NR : PCI_MSI_FULL_DOORBEL=
L_NR;
 }
=20
-static inline unsigned int msi_doorbell_end(void)
-{
-	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_END : PCI_MSI_FULL_DOORBE=
LL_END;
-}
-
 static inline bool mpic_is_percpu_irq(irq_hw_number_t hwirq)
 {
 	return hwirq <=3D MPIC_MAX_PER_CPU_IRQS;

