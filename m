Return-Path: <linux-tip-commits+bounces-6939-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48797BE454E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2A73BC2FE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91A350D77;
	Thu, 16 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4LZaWsi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nfQMuuH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA26350D4E;
	Thu, 16 Oct 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629601; cv=none; b=Sr6ihm81hP2G1/McoaoOcAGwX9np+MdJvJNIEXCdEKqgZTFtlq1NhUn4FeXdhEC2+B+Gun3KH7LS0Y6xmMv10LGti/ZfLlByGLOHyRF/hj3jKkbEc+tWAO7J79hTlkIh+5nak4Ez6Ajh7F26KnRtrRDxSPgWN0UybqzC9TZgYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629601; c=relaxed/simple;
	bh=zdHZ998i9DmJaOifedk1AKjFKzr0UFCfN5C8U8X+Yvg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tgza/Fpi7IbYmJr5TxnWbNezrfVkKOKFPrnVm54oqX6bp+l+cJakV5s8/Qp8zsUUxX5OWBM/Lqy+UyPhhS1kae1/aLUsyKWTJ6/5ck6sIcsMo4IzlD1RzBSuCVkoIEROIWnl4TFVKUrRBHL4qETef4X7jBGxezrbEfW5td//hnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4LZaWsi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nfQMuuH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 15:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760629596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5P0htxiuDx8sf/5FmTPjMHKu7OAJf0ptxSJMODmkob0=;
	b=M4LZaWsidLwUqALW4eEoULWE3+SjJozMm3L7rbrnjm5hEj+ix3pkkXc/tElZAq6+F1NhUH
	qA/79R4g/WMu8S/zEYdXE1kbe23ALxieJwoKejp6bNR07FFxoVihXXnk9EUuwBJK3kT9Ih
	9C5ENkUlJwBo/A1Vx31C1l0I7Cmfh55ED/XYYi/EhFlcnY1ZEmWtaaQuaFoXv2eymzR46r
	wODGtpWJSgYUxEO6qY4euhxKdAGHD1DoxeSufwQL8ONZM/U6E36da2+Uqj76eKfrDa5DbX
	HAif4f89e36uE+V2rXEPW1ApY5k7w6lBpuzhi4nlUHzqZeij2gcvDSk8jrxppg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760629596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5P0htxiuDx8sf/5FmTPjMHKu7OAJf0ptxSJMODmkob0=;
	b=4nfQMuuH+q6rb4sTmXYuLOl8S/yuml/uG9Ill6RqIKK/5oZ/l0ZcbGKnVjMryOYRHP1tSo
	f/pHEyXT0/RZfoDA==
From: "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/riscv-imsic: Remove redundant irq_data lookups
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251015195712.3813004-2-samuel.holland@sifive.com>
References: <20251015195712.3813004-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176062959530.709179.12601670469516052129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     69f81d15ae737f3e22451aa00fdaed95bfa2d65d
Gitweb:        https://git.kernel.org/tip/69f81d15ae737f3e22451aa00fdaed95bfa=
2d65d
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 15 Oct 2025 12:55:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 17:26:35 +02:00

irqchip/riscv-imsic: Remove redundant irq_data lookups

imsic_irq_set_affinity() already takes the irq_data pointer as a
parameter, so it is pointless to look it up again from the IRQ number.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
index 643c8e4..7228a33 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -158,11 +158,11 @@ static int imsic_irq_set_affinity(struct irq_data *d, c=
onst struct cpumask *mask
 		tmp_vec.local_id =3D new_vec->local_id;
=20
 		/* Point device to the temporary vector */
-		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
+		imsic_msi_update_msg(d, &tmp_vec);
 	}
=20
 	/* Point device to the new vector */
-	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
+	imsic_msi_update_msg(d, new_vec);
=20
 	/* Update irq descriptors with the new vector */
 	d->chip_data =3D new_vec;

