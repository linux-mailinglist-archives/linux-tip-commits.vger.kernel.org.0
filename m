Return-Path: <linux-tip-commits+bounces-3454-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92F1A39874
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FD73A3B07
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA41241C9D;
	Tue, 18 Feb 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="izEy+I68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+rTGbrTc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037F2417C4;
	Tue, 18 Feb 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873215; cv=none; b=cVSJUOAayid0BybN05EwXbaMnss5pzNS3Ocm65muI2a/8GdDaiXAiUvA6xtz+s6L/KYcNz0vVbdU/A8NIJG3LTT2Lf/ffdxKpIdM33h0gnB07kzpuVCg2hc+nN5KL8Ue2zXD6cycdPQsS6quSM1aDhjurbKgFoD8ywJPaWidrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873215; c=relaxed/simple;
	bh=ETXJXYqTXtpKkHLf9zHfrvLEkh6Moz32E2rBfGGGFp8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=itgHStLu1KEwa4kSGjAK8bUOU3r9mkejJhQEzUUfiEvvDppjeN0fhy8dgoVnPlVZYcc94vVgsRBR7gCI9FEEaQVdkH9Y0LvzdHhlgqHzalcLomh2lhGwq7Cx5rop1ge6d898JEpgv3p+9Zw8huHBb59HJpuyhAxY/K+56Ic7fRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=izEy+I68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+rTGbrTc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcX39CPrUoStYpaDz13sh3gK9RTO587GWmvWP+kmfNc=;
	b=izEy+I68GxZJUdrRo1VTTpQSPTgisZ9Qixg24v+ZkRXc3W4g2u5N8YzMCSOwzX5zfJf36X
	caFBFwh/FdOd3dultGcx6aIXQ5VYdb/N43cSVX3hkuhiG8LbVfdL9uUUhTMkY8wXofxRsl
	uk14Wl2Z+yp3K733MdvY4jt0WdDRF98CYMdeajhudjQ2U9mB02GS9BlnoMvlfR+cYP26cE
	T4sqvVnTuTZdKEEsNUOTu20CdQyFzVwoPRk6OlADZ3M+Hx+TUioau0/ww7uchlpuIwv6xW
	8a62KO2kZ1X229NY/KStPDswpejMLkOuXPJzgQyVHC+uDlBFWaz6w+LZFlIAOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcX39CPrUoStYpaDz13sh3gK9RTO587GWmvWP+kmfNc=;
	b=+rTGbrTc1l+gAEGWPhaHfLuQk11424qBsyIUwZcQOuqqE7qmKV8Fw9oEJI9aiBpJDuUcYX
	y1xjJKpBi4VfANAA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] can: mcp251xfd: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Caf32e1b1814263485be17bca9707d555f857c53f=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Caf32e1b1814263485be17bca9707d555f857c53f=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321189.10177.5274263745154014869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     881ec0c6db17ec6bacd968d6899508be3cf00ff4
Gitweb:        https://git.kernel.org/tip/881ec0c6db17ec6bacd968d6899508be3cf00ff4
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:45 +01:00

can: mcp251xfd: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/all/af32e1b1814263485be17bca9707d555f857c53f.1738746872.git.namcao@linutronix.de

---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 7209a83..c34f206 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -541,11 +541,11 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 	}
 	priv->rx_ring_num = i;
 
-	hrtimer_init(&priv->rx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->rx_irq_timer.function = mcp251xfd_rx_irq_timer;
+	hrtimer_setup(&priv->rx_irq_timer, mcp251xfd_rx_irq_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
-	hrtimer_init(&priv->tx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->tx_irq_timer.function = mcp251xfd_tx_irq_timer;
+	hrtimer_setup(&priv->tx_irq_timer, mcp251xfd_tx_irq_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	return 0;
 }

