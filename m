Return-Path: <linux-tip-commits+bounces-1835-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8189410D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B7BB2661E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77D1A0732;
	Tue, 30 Jul 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+p5ADrp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0loIG8u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115101A00F4;
	Tue, 30 Jul 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339608; cv=none; b=t2XgrIL89EDbaKTyF3c5vHW1QotyW8h60D8uWTYUCDQT0efXYARfj24XSIhnrc4SzyYzom+BZSqhQa4uo6n4mCgpgSm/MDE7lHNV093lFnCqqi9Iec+iqTxzz8f9ODBzxAIeY4zAqOaxtPnaNj8GYrz7n3LSgS6a8kJI04x5Ezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339608; c=relaxed/simple;
	bh=MIStQe0EsEUMLvAXE19ZpRR+vzou1bK+Dw7JAZwqCeE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tPfmwkDxAQ/8N63tlFXEb+iF3JQo7oUD5yk1/F1DbML07lEbCR1zPIK7hPaPm0vM95xvSbKY3oufvmUXIfL4qa1TtJJIfgLOSrbv+l6s9E6MbWbYcQR48/IfRy4zUj4Ass27yaP25d23/ay2fG2n+23ENszUNGaqT7BssNSvon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+p5ADrp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0loIG8u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql+AAMeIB59JxbkxP7CBiOQwW4gADreLDobP5IHp8u8=;
	b=R+p5ADrpNLtrqa7xgKhAcrNOQus7HiPh6eDuGliw4Gny266iA/tdOqMoENWeum4b/GaSY6
	PtAoMn0co6xjfLyIH0S4Kes9KePzS/sNa4CtX8ErUOwvRYj308llEIlzEzSUQtGrFEV6+R
	Eqj62liLLTmW1eMW6PnGlKeVawwvkFt1nr9qqt0MnsZYOdp2CkxkCBKnIVoLZ9gQij20xT
	EnpXb5bZ4hWZWiTftD2Wh80tOGQKXIs9qt85OCACN1FJhKzymuLUsnkQmuotBg/3i8L5Pb
	7ommB8WwhiQCl2pA5Ut17uQC0VLca7hH1mLB3U1HKdqnZID188vunRp/FicrZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql+AAMeIB59JxbkxP7CBiOQwW4gADreLDobP5IHp8u8=;
	b=u0loIG8uiyjkhRnXtzHB1gPYiINNI3Dsk5DG4sDGWTMs594Ob4sRM+Jq54LvpCf5O6XjuL
	Aavi+uFy9VeK/qBA==
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
Message-ID: <172233960129.2215.14799726461103783091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0381be072f301088637ab6b01f2c8f0e5745e0e5
Gitweb:        https://git.kernel.org/tip/0381be072f301088637ab6b01f2c8f0e574=
5e0e5
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:47 +02:00

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

