Return-Path: <linux-tip-commits+bounces-1844-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638F9410E2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0FF1F24B9D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438251A0B03;
	Tue, 30 Jul 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EB6TjW7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="evJQvIZk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A51A01DE;
	Tue, 30 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339610; cv=none; b=TzL562vJ4qB88+/PZ3TtTFT/AdsS0C8AFecf5SEn8ygGkiY9/7jgjIUFbiySpOw1+wIBBOGqXgBa7YCC5GLTMVO+iKy0um6PpFoGG/pPWrO7exphgm6PqL3s8A51GQvAqlASiglOgzZ3AWIZtNJPr/QK+5rwOad+ZHD61bn/zpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339610; c=relaxed/simple;
	bh=RfOYfd8P0Cf+j8GKmI8brA7fXtkp0Ebqgih/gYC18/g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dAxOFLNuC0VSLM37Vz4tcs0PdR4EX9mRd4iMEE2MCqcK4kCtXID8rnhoViqgtgp/wEYxv+PKxuE6fjspH500BtFAYNTZKQPoiPbn+9hE3sr6XFxS5495Y6e7rXpxAghQ/Kt5F5OhrM+KWFp8+HfatEc4HxDZ/zAgAp7nmvie1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EB6TjW7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=evJQvIZk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1IleQYCbaojoTZBy6gRlckardGigXupn8aRdT8VdfM=;
	b=EB6TjW7GH2dKIIg5GJTbiNiQ8E26R8BszXU3QVjBn+j6pLN63pu30TIpZmX2GW83L1RSVv
	IqwmyDjwrDDeql/iSQUFGAHuvi1MKpAU5I943wCUyzUdm2cRaCjarVjQBhFDJKG64rDUDC
	n7GiFOyeT/ne3JwINlyl/PkweypeIA3yTZw+7WS4AXYgldKnU6G6ocGSG1TcmcJf7nXA+M
	gN61oliFwrlTtsJXkByOcujf3eQadQDfL6aw2xy7HLIo5wpBcrJAYuh/Y3n/xD638oTNJc
	t8FApwoXdz+V3UKhT5vrNJks2s3pYxxudmjFMqcDCMdeWpBDdH8E/ebPbNoptg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1IleQYCbaojoTZBy6gRlckardGigXupn8aRdT8VdfM=;
	b=evJQvIZkT1+Cl0P7u/NlaFJvJ5dRg1NMqYLjm3hkEu0PIvvsXlreDPFuSD+FnBpkgC86ob
	1/s1NgCo95InMHDQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Change spaces to tabs
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240708151801.11592-4-kabel@kernel.org>
References: <20240708151801.11592-4-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960424.2215.9185295469862933045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f04ef167b350722f1623308c085c3ce119894035
Gitweb:        https://git.kernel.org/tip/f04ef167b350722f1623308c085c3ce1198=
94035
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:45 +02:00

irqchip/armada-370-xp: Change spaces to tabs

Change spaces to tabs in register constants definitions.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240708151801.11592-4-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 588a9e2..427ba5f 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -137,13 +137,13 @@
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
-#define IPI_DOORBELL_START                      (0)
-#define IPI_DOORBELL_END                        (8)
-#define IPI_DOORBELL_MASK                       0xFF
-#define PCI_MSI_DOORBELL_START                  (16)
-#define PCI_MSI_DOORBELL_NR                     (16)
-#define PCI_MSI_DOORBELL_END                    (32)
-#define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
+#define IPI_DOORBELL_START			(0)
+#define IPI_DOORBELL_END			(8)
+#define IPI_DOORBELL_MASK			0xFF
+#define PCI_MSI_DOORBELL_START			(16)
+#define PCI_MSI_DOORBELL_NR			(16)
+#define PCI_MSI_DOORBELL_END			(32)
+#define PCI_MSI_DOORBELL_MASK			0xFFFF0000
=20
 /* MSI interrupt definitions for non-IPI platforms */
 #define PCI_MSI_FULL_DOORBELL_START		0

