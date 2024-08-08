Return-Path: <linux-tip-commits+bounces-2007-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2194C0F9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1655F1F229A1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71F1917ED;
	Thu,  8 Aug 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wakNTRu5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cdNcWMvK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F106190684;
	Thu,  8 Aug 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130507; cv=none; b=EufEjCZhGQrG/nHUA04TVbWwVJ5mCr7W3swpTpBEZXLPbMZaTESUpKW7kuH8NbG9DMy6D2fBqHSoI4xlj1G8Y+slZ2aEwa9r+lbfLZFDBJHZzz36XjmLLN2viPIJ8jsMx6xCpdpb5bqpCjvjGKnY0vMre/ixkbjfyjlecny+1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130507; c=relaxed/simple;
	bh=WEyHXUtZwk5oLcxZSaKyXo6ZPLtIcsR6Tr/gPtj3+J0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pK+Bu8DQjXWpdVPTdu078UfhMryEUHIBzftECL895AOjJOeUQqP9ydzHlKn10b+Jh3Ba+cgXfIpTHaruM+HA82bxtEa2h+7AoBhq52etAZ58f0HYrxl2y07KZvLab3K8kOlbcChcFB2/RxkLJEu8SeOl8eNJZ9erV9oid5EljSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wakNTRu5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cdNcWMvK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vDykPAhGzLEhveE40nXa8OzscrLjfTzKj/DWfxa6tEk=;
	b=wakNTRu5POsgjuTQBWa5dGfNvxe9uTof4pAhcPCGgLooHDYzX+ZJPov8q/s+rm1a7VZ5t9
	fdKb/SdRCDAiEST/n1T3yxvyH54U5jK7E8EriSZSC0g1M+UPiP/txbjT3A45m5rkA6u8jC
	JxY5v6HODg5xdV5pnbbzLxAAxKr7yrDPTha+vIyo5NvHLG5T9y+iGbWSH3jDDIjrUpVdcD
	gjCorrDTwwNUCcxiN2VcHFqOBIK2Oes7xpK8iKo8fmXaNmZDTtFOtMqOrMRGS5A8LyRPXR
	u4dy6pa/L5u2CgrnH/c0fvefKc5tKSr7VLd+D0reA5ak4IDCCIXsGLx7NCkfbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vDykPAhGzLEhveE40nXa8OzscrLjfTzKj/DWfxa6tEk=;
	b=cdNcWMvKYwQrnbDRxSljAE3gOjOEGUv75gYJEaD0PnQbPJoHVa5IbUBgNy0mCZIQC0Kyid
	AQojKgELeuHXsuDw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Iterate only valid bits of the
 per-CPU interrupt cause register
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050328.2215.7248961297324909574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4042a965a5e62c8d298d642cbf72b14f41687319
Gitweb:        https://git.kernel.org/tip/4042a965a5e62c8d298d642cbf72b14f416=
87319
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:41:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:01 +02:00

irqchip/armada-370-xp: Iterate only valid bits of the per-CPU interrupt cause=
 register

Use MPIC_PER_CPU_IRQS_NR (29) bound instead of BITS_PER_LONG (32) when
iterating the bits of the per-CPU interrupt cause register, since there
are only 29 per-CPU interrupts. The top 3 bits are always zero anyway.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 83afc3a..36d1bac 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -678,7 +678,7 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
 	cause =3D readl_relaxed(mpic->per_cpu + MPIC_PPI_CAUSE);
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
-	for_each_set_bit(i, &cause, BITS_PER_LONG) {
+	for_each_set_bit(i, &cause, MPIC_PER_CPU_IRQS_NR) {
 		irqsrc =3D readl_relaxed(mpic->base + MPIC_INT_SOURCE_CTL(i));
=20
 		/* Check if the interrupt is not masked on current CPU.

