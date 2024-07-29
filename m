Return-Path: <linux-tip-commits+bounces-1769-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B4693F1AF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30931C215CD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F355145B17;
	Mon, 29 Jul 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OF+kuQrh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sw3oSVWf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47D14532B;
	Mon, 29 Jul 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246591; cv=none; b=LT3AJ5728L5gyV4T+CaXJImz6B+sj0ydSnmXGdnZJckF0M0J1YGY4IWyYNjd67Gy5XZxurleySOTLU5K+LjykUDxzvdLc0bo9unOoP6LX86hgRkoDPx9mPNCyon0Bl/l0/2CHplAeSmj0M1g3S5Eb1/5ScDHMzw4Ye4NtYfvHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246591; c=relaxed/simple;
	bh=2dOjh6it6UxiE+pEQFGrvAfSiMVlVqfkIpaEXet63fg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h5hH6M74JUY+rJ4PhiU6DtwSfNoQbqr4pN8OFUzZuRO9xB7q2vECOv73tC4Q56Y27uvUX/GzLGI1CMNTVAf/3vYkI/ID0sbVo79Rc0rJqrI/LzWYG7yTbls+pz2lluDDtSBCOx0f78FeDOc4iQgJ5KDy9xhH9b8ue+7AbSP8XE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OF+kuQrh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sw3oSVWf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waVLFOcN/4Js5tLyqlZ+sp2b7gBKkKi7BsMlEycfRuE=;
	b=OF+kuQrhk4hZt46cHx27xX2kTQRq+3FHNlT/rjD5y0cakbMxaUfJuUrNjWZP7IWJSH39J7
	RkMR15XCi6JaBNe52zXasWie429fJCW/agpQ0YqNcRUDuwcmgZjKqTAYXtY7Tcp+fK+Xoy
	vjVXTOxN/kfReikRUf9wh+pis58QYdtg3KbzzSjjVt4mryOtbGsEMlmoeox1tVJRiWlBoU
	dPEQYOHB5+kJ465TNn1QqQttHSHp5ipTvf5y0oaMX0+IDM2/WIYhFMbWZ0YAFvjDSbEBAS
	wQZLfQgpIHjut92rYkMuVNrrNX/f/FGoBmbUcgG2e1eh+T9Cxq/iHENhKVU7ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waVLFOcN/4Js5tLyqlZ+sp2b7gBKkKi7BsMlEycfRuE=;
	b=Sw3oSVWfW2g4DM4teoMflA0Svig1UpMNRwGqNl4x+hfTSzqjVlfoCoY4uZamN2WIDl91uh
	oOmoFL5xMOhOzlCQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use !virq instead of virq == 0
 in condition
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-4-kabel@kernel.org>
References: <20240711115748.30268-4-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658482.2215.17268694260760167787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     67197a609b33c47e5ece5902f4dd14ca0c52a9aa
Gitweb:        https://git.kernel.org/tip/67197a609b33c47e5ece5902f4dd14ca0c5=
2a9aa
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:23 +02:00

irqchip/armada-370-xp: Use !virq instead of virq =3D=3D 0 in condition

Use !virq instead of virq =3D=3D 0 when checking for availability of the
virq.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-4-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index b29f3bb..c007610 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -542,7 +542,7 @@ static void armada_xp_mpic_reenable_percpu(void)
 		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
-		if (virq =3D=3D 0)
+		if (!virq)
 			continue;
=20
 		data =3D irq_get_irq_data(virq);
@@ -737,7 +737,7 @@ static void armada_370_xp_mpic_resume(void)
 		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
-		if (virq =3D=3D 0)
+		if (!virq)
 			continue;
=20
 		data =3D irq_get_irq_data(virq);

