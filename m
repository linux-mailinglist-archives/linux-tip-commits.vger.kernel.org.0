Return-Path: <linux-tip-commits+bounces-6954-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00ABE5292
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18BF7508320
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A92255F31;
	Thu, 16 Oct 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O4lH5sJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A90U561x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE424C068;
	Thu, 16 Oct 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641294; cv=none; b=hr/l5LsFO5SXkVW5TRn4gOEh1AhQ4tl41UXSeDdHZ9jq3L7Ngz3Sy9Ps8Aev1eQpVs7F55g10vA6ij/1zR5wlLqxTuUzqXEvithkQnwle+CZ+pSylV3oYn5/aimGt3qihzAK8xL/4Zo1QcFbBz8kOIsyqJOdTHSiorquxdWGR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641294; c=relaxed/simple;
	bh=KkDXO08RdOIiWf7tuY/jNXZhH242MbqZxRMoDHoiVuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=amfbEqOIg+9csp+CKl/jdbehdPngocpwGWv+HyfGdw7/hSYY4a8NPkxW65iTnvUsc1ERH/1NHQiLp9ydItXd3Uo9a4J98RZKvK9AZ2NrvGlu/bwItQxNShsBLh3HPs7UdlRA5snFep3v4rq8/jN56Iz6NuVQSukByrykzkAoK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O4lH5sJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A90U561x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760641290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGkELoJJJz0UQfU2Fio+DJGQgJdKVcRqhxtQPkadvJ4=;
	b=O4lH5sJ7Qgw3c0ESuVINy+R3Y7lCKiEMteW7CSpo1esswBAmWWhI+4+J9a3lc3JgzrwS9O
	u67WVUEnSEub8ADxPxja3VCX+kHJT3B3Wtu82gtwgTOflvc0hw4vej67ergA3akzADj2Qk
	ozFPNGDIFkDGjBGfEZUdQie/j594idJB9cNNFZWjGgxeLa/4Mjizv/OWVorLMdJeofXnhh
	XTYVhcCyCtSwAD9fassRLPvxkZHu7aZR7zv/jlbmpHTcdlahEdPZ7wZ+5oT/EdYV65M8aA
	a/hKdvsKlkhnGW0iITdfU3Lw/GLG0HrE8UFnijvtYMX2aZ5NrQyEGEsrBrc2HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760641290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGkELoJJJz0UQfU2Fio+DJGQgJdKVcRqhxtQPkadvJ4=;
	b=A90U561xjaePCerZ4fDVHNe8/P8VIRX8lbaTbuC9mXc1U4N7tAgYC02wqX4r847iZNNlZT
	I8eEPLZJrnJp8yAA==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip: Enable compile testing of Broadcom drivers
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013095027.12102-1-johan@kernel.org>
References: <20251013095027.12102-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176064128903.709179.9707042544936403346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     1230fbb225abf3f04c64697c6b0f8dfb473b3790
Gitweb:        https://git.kernel.org/tip/1230fbb225abf3f04c64697c6b0f8dfb473=
b3790
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:50:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 18:17:27 +02:00

irqchip: Enable compile testing of Broadcom drivers

There seems to be nothing preventing the Broadcom drivers from being
compile tested so enable that for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/irqchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a61c6dc..9b71537 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -151,7 +151,7 @@ config BCM6345_L1_IRQ
=20
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
@@ -159,14 +159,14 @@ config BCM7038_L1_IRQ
=20
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
=20
 config BRCMSTB_L2_IRQ
 	tristate "Broadcom STB generic L2 interrupt controller driver"
-	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN

