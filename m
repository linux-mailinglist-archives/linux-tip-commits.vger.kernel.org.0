Return-Path: <linux-tip-commits+bounces-1768-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836C93F1AE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669CF1C212FB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84F1145A07;
	Mon, 29 Jul 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m2EnCV4q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+F8OcSXK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7C144D2B;
	Mon, 29 Jul 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246590; cv=none; b=qAvjOQ23FQD+yy29m075KqH93Iozx93gLDq1zrri4rGqfH5s+BPPe1yAyOK3q1JmWRRgWsa+GJQgPXLe5WUUwAhaGa9j/ri2H4gojWwn61U9v85ddRkwXqES5Q1p0wWHMyhom0dE0ewT1fdpX+DmrS7s1u6QDdEpAziSL5/NGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246590; c=relaxed/simple;
	bh=uTBjMjc3lYnoXk3VqFOG1sMX+IFI2KlQDjpcnsM76mQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fW4Ghnj7wPP0o1UZ9HCTZ2J2eR832n0ZJwPbx75RErKZHO/OT9HQWoiWVAifVMBU0Qs6ytajab8fHkE0i76aHVCnkEA94agxqGXEA/By78wDoXY0KvFbM7rEr4Fwz2vkUZPNlPR6zWZ3D0yoj/J425+jkHUkMvFjXQ2V4rg51r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m2EnCV4q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+F8OcSXK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSFc6g9xyeqNFnSYvBBi2ye/KHyoKtADFqADZmjoUzU=;
	b=m2EnCV4q5EEJB0JDokTQmtuqCGxqilv7EgM42XYKQ6K4LqvI5p5bXNr4JjrfpuNtdnW1s6
	LITYP+dkNjm+CStacnEAS0CO7vTm41b6Y788x+5ahfGMBz94WEK2hxZIs1dDGj1JkFnGBA
	WZwuI8MjIv0F1LgOfMLwPISwrdYd9CZoUM2OvpjnlcuIWFGE/Orto+79XDmAudq1wgpd5v
	dUh+AuM3TctKYFh45YQG2jSzf2CpyrbfsYBovry1X+Efx91oLNeNP9/RdgDc2X1e1hhDjx
	gX8K3ot3X9MnTmxMfKNXrjsLEUUC9aTCxbmcCLz8voxUWqFcJ8OgDPSwT36Vig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSFc6g9xyeqNFnSYvBBi2ye/KHyoKtADFqADZmjoUzU=;
	b=+F8OcSXKaNqDeJctD+KHjym1nwx52VJFfmlvcg+xIeTPGljiAPT2unMvFZQpeR0e1Gs9ja
	mrbEnxWNg3/VNUAw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Simplify ipi_resume() code
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-5-kabel@kernel.org>
References: <20240711115748.30268-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658459.2215.18333261209386245552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e2dda25a6d2eaddb3e42f0843904ab7908ab3db3
Gitweb:        https://git.kernel.org/tip/e2dda25a6d2eaddb3e42f0843904ab7908a=
b3db3
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:23 +02:00

irqchip/armada-370-xp: Simplify ipi_resume() code

Refactor the ipi_resume() function to drop one indentation level.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-5-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index c007610..316c27c 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -462,16 +462,14 @@ static const struct irq_domain_ops ipi_domain_ops =3D {
 static void ipi_resume(void)
 {
 	for (int i =3D 0; i < IPI_DOORBELL_END; i++) {
-		unsigned int virq;
+		unsigned int virq =3D irq_find_mapping(ipi_domain, i);
+		struct irq_data *d;
=20
-		virq =3D irq_find_mapping(ipi_domain, i);
-		if (!virq)
+		if (!virq || !irq_percpu_is_enabled(virq))
 			continue;
-		if (irq_percpu_is_enabled(virq)) {
-			struct irq_data *d;
-			d =3D irq_domain_get_irq_data(ipi_domain, virq);
-			armada_370_xp_ipi_unmask(d);
-		}
+
+		d =3D irq_domain_get_irq_data(ipi_domain, virq);
+		armada_370_xp_ipi_unmask(d);
 	}
 }
=20

