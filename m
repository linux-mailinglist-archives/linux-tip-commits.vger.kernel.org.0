Return-Path: <linux-tip-commits+bounces-6850-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A08BE2852
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5CE4824E1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449831AF10;
	Thu, 16 Oct 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8PmZiRY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylHgOrbU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007431AF2E;
	Thu, 16 Oct 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608307; cv=none; b=eq5g5w9KbG10pKk99zfyMtGaxNHfB9ztppCIefHi3dzfWPcwfQxanftHBkM+tK7X4MQ86Kvoog1VcP22wgBdWTCHptnu1M5eKmotgS9hM3z8N18cR1UqH3x+YEnxZ1vhoG1/NfOEh4FF9kfkfhecgADdxAgbZfwg94v4J1Rt8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608307; c=relaxed/simple;
	bh=nva506pScxr+CBBvdEjr18P6JVjuzy2yZU0Za2oB16Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VfpQA7MLfALvAVXoKSbnmRwSNtIdAZPdRQDC25OurReXX4vTPtoY72XAL2JnW5/UNAycSMUZZZA6GTWP+m8GcBpWoSQk+sHkXuyqneJ4cmWUGziXG0J7xg3RyyFBQNTZgv/KwY4A0vPDvD9lmgBzmTtP9Tc6m2CoirKXnp9kaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g8PmZiRY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylHgOrbU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=563vvo0TRXibGFcDJtcupOShLok3CQr9yF3KokX6xfM=;
	b=g8PmZiRY2btWfyzakdFtNKN6Zo/9V8Hf/q8TdbxDQLAttZE/G+e/YotL3z20KaW81r9Wc1
	AnuVVCLfkUXUwfIbUWdNm4TReeYRbMZdqqOX9Yq+buzRhV17suRx3WFkQEAlvStTK37Hdq
	8IJYE8atyh9/f/TRG9VijhWlIEWyiC1HS95Xfd4cleItU6BhusdpD21swk6qQ8Xlmx87WV
	jgbOA5VWpPgWniBHpCwlLpjWwI0wwggmvOCFd8GSRcLnLq51cQTnQyfwIxdPpRR47eKyFh
	t8QV6WiWQTaufunt+vNPIaOA9vT+nQUJxHBwkq8qtg+XdTw//NR8SpJgrZmlDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=563vvo0TRXibGFcDJtcupOShLok3CQr9yF3KokX6xfM=;
	b=ylHgOrbUuqTUE4q/xK5pRlF2XXCXTntHUOBbxhe7/UZrORIEzdfbr1cxJZhtKn+Lfei+cm
	EPpijYzdcK2D81AA==
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
Message-ID: <176060829061.709179.2988348432249799679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     22fdbd215393b09af9af41ab070f19aeeb93afc4
Gitweb:        https://git.kernel.org/tip/22fdbd215393b09af9af41ab070f19aeeb9=
3afc4
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:50:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:34:24 +02:00

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

