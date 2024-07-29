Return-Path: <linux-tip-commits+bounces-1777-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D460893F1BA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B104283124
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3EF1465B0;
	Mon, 29 Jul 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1LS2nsDM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nI/hbpzc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997C1459E5;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246592; cv=none; b=J1Wr2Fa0Kj5dLVtnZRjawXGva44hLSxdraNnx+erXBVW1950uq7o73rSxThAArnbR/Zsscde1ALiQpR15bel2RcT7L/1c8JpWN0unOkPHhN1fxoO09ljd/F3+CCNs7Fgth/ZCmHNJTORm5b9SdnPjdqgBamop4ehmuKw3pGFsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246592; c=relaxed/simple;
	bh=P3h+k1Ig4OEKh5SC0g9zFAa9ArJwazTDWn3sj/UlzWc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dA8CSAvEK7i5bPVQzcnyumTG1oq+QqO3T6hSWayxqCo33wCkxf5/UGBX5OqZGgXIoMWW3SwdImnVCtBwXKQjK2WiVhlkxkTOMaXoAn7CmxYqXki7FaPEAN0R9XiG0dBV1rx2lBkyp+O9U7dul0j6F3RWKol1Es2z2phMmqOOX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1LS2nsDM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nI/hbpzc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYeZi1VI6aILPQpoagOAZwtNQq+j3lW5fj1LGTmH6+E=;
	b=1LS2nsDMZcqK6n1NqeS5lCkKI37XXZEdsKQaGpAe2PSnNiOiDPwl8QR6oBEDoxRi92tYhv
	AOxNG2Wn9x/XKjF8bPWZjIrqsj7jh5KpWlBLV7MGyN3wycfiok7dGCX4Iu/jF8/UoWPSN8
	ywhNRCEQuyrk2Tgvx8KOqa5oX32++3jqxfjjhOYqtEB71n3oMudk7NpsEISqd/FSLz1VJf
	r6MCbRb34B/WN0fLU8KGceXjmpTLDzYcSolL+EBudLAwG+JqSkiFJSYg+dNOJdaDnYil56
	qnwMMKuFkUEGniDMi8dIhFR7B/Yu48nHxheBtapQwuzBS2u54QT7+Us1d5I/QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYeZi1VI6aILPQpoagOAZwtNQq+j3lW5fj1LGTmH6+E=;
	b=nI/hbpzcEYl4ZVgADNQQ1YdXjzRj3FylVcgtzAmvTgjvhDXRvrq5WW2oClE4NC8TnOdtY2
	or8VLSAXtRA1EUAg==
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
Message-ID: <172224658727.2215.1844728144923362757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b3420176dc4ae4182e33c35526d2e281d0d63b65
Gitweb:        https://git.kernel.org/tip/b3420176dc4ae4182e33c35526d2e281d0d=
63b65
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:21 +02:00

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

