Return-Path: <linux-tip-commits+bounces-1836-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3549410DA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D519B26693
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0FB1A0739;
	Tue, 30 Jul 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SqWdxCfu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7JH9/xY4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EE1993B0;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339608; cv=none; b=nd10rPaR99tDrMWnAlaFYrvTq/HXk92I46RhqQjda1XVvy2FQN3isnctyzovYzNueeyW3TOK6OFUcXDDLabBm5nQpbU35brzZ44esOUAoZwo/Fsv6yWVosaxoj+Fmaw1b2GMylImf9ReuOG0cSyilf7CbvT+jWztLY+HuehLp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339608; c=relaxed/simple;
	bh=CUw9raTIHbh1n475TV2nLudMATatII7YnBncdlSSwdo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IQQD5UAn+ufSOPhwZjX4g56UT8s8VwQdLEXvIVioWmg/VzpKu1N4enwNXCkQYOH67tbfv4BUlADaKKx/tVT1vNEKkU8rpkKrkXOCsnx2OOm9q8rWEXDo1erCSUOyJMJNq0zc6r2q5SMwqB/g7l/vsizCtGoD/nDsJjSimuHgzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SqWdxCfu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7JH9/xY4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yh12UbBQgU2kC2uB1osjs01GrZcDiprRa6sxK7DfsIs=;
	b=SqWdxCfuNp8i1YMszfQcJ15LwAW0plXf2ARPKtKh/V0SwKRtDLSQgrQOOzCvu6lFdQ8u8c
	/W9BW43VwRRN/62rjeVQIkHQpiFaMAhs0h43zgtzmix4z/FLIhBxQxUSk8MOsO66IGF+Rn
	T+cP/mzOJ5lEK+zMdGIahJluhS3HviHSrQKVIgVtmUiv6KABB1xBI0JSACwMcY1XOg4qS+
	qwnJeyt44uc8KZcYCPNJIyf4Y4XFhZR/zjio1S559n8qf8AhPGh2axkNMiUMthPuIBtT0x
	CIwuENeWM6FUDk5G6AmiaVA7vHML9LjIBRlhi8v5kpNEKka2MXSWWVPBBlKQDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yh12UbBQgU2kC2uB1osjs01GrZcDiprRa6sxK7DfsIs=;
	b=7JH9/xY4EMEgJdcHS5dQATNtw/OFC85H5agvWSdI2PSmHDoWtZ7aZ9HGxP8XjyppcOMubu
	HU8Gp6tYSyt5QICg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Rename variable for consistency
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-2-kabel@kernel.org>
References: <20240711115748.30268-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960212.2215.11691619698477019367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     55689986d7eaed09b6569b1e06b29044cd3cb590
Gitweb:        https://git.kernel.org/tip/55689986d7eaed09b6569b1e06b29044cd3=
cb590
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

irqchip/armada-370-xp: Rename variable for consistency

Rename the irq variable to virq in the ipi_resume() function for
consistency with the rest of the code.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-2-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 22e1a49..7016b20 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -462,14 +462,14 @@ static const struct irq_domain_ops ipi_domain_ops =3D {
 static void ipi_resume(void)
 {
 	for (int i =3D 0; i < IPI_DOORBELL_END; i++) {
-		int irq;
+		int virq;
=20
-		irq =3D irq_find_mapping(ipi_domain, i);
-		if (irq <=3D 0)
+		virq =3D irq_find_mapping(ipi_domain, i);
+		if (virq <=3D 0)
 			continue;
-		if (irq_percpu_is_enabled(irq)) {
+		if (irq_percpu_is_enabled(virq)) {
 			struct irq_data *d;
-			d =3D irq_domain_get_irq_data(ipi_domain, irq);
+			d =3D irq_domain_get_irq_data(ipi_domain, virq);
 			armada_370_xp_ipi_unmask(d);
 		}
 	}

