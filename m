Return-Path: <linux-tip-commits+bounces-6936-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20FBE385A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 14:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E661A63943
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51017335BBF;
	Thu, 16 Oct 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zaZQmCWQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SxqzDF8+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7C334399;
	Thu, 16 Oct 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619347; cv=none; b=nCdZ24XtrHSI+vgACnntuGlTl0BbB1+rhY93urCrv02reMqOamhpQJrMPeAzNhVqASdTYRLlJN1uh/+IjwJEQYW2KEPQEk7lwkNj+WmvbN011ev8xYr73xHSosfNAMMmWBKLP5/s4QpY5gN6Q4n4KHqRP1866lekgkojx7HBa1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619347; c=relaxed/simple;
	bh=CURhU6tvopeZD4OzhN0+apQrTIxwplOblGTfM6uvawY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LADjObSPi+toTXbNRnpxC8tid7TgO4Y3fwte//7IFCnmKoFKfFS2zLnnmTMDoqTRLxjtEQeERd+rOFTA7GfTRSlugoAIDSb0zQGA5k1qTfxqphQHA6CwqinhKMr+iWhVutYznlQOq+NY/8YG3NVz+ToeIUszJGuX9u8mnhF9CII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zaZQmCWQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SxqzDF8+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 12:55:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760619343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVxkznpREkGXulHfNgc/1XyKMEWKtw1WtetrGTqJcnE=;
	b=zaZQmCWQQZHTUf+FU1JGbgcH0LBeER2HmKmi1faYqpVzjdkIqvLTKTuwMRolloXpm4seDG
	mmDRF9csSH5rgyNvJQsm34pyI5nPmoBuPOA63WfehkDc2SKcnL7f3ZE1Q9S30dDyA1tlvO
	c9ubI/2XADH1q1VxT8b4ffhb7YApfs9INi6JhDbNNOEP3AM0LZ4efEGoM3xxGauRvy+VlT
	N6VTMlYvCNAC7viKaVDT4SXt9QndmBqhD+qil0fJRF8P5ejDzYZTUEG8hHsXZ1yAGKICVL
	oXxFrKWOL7raYT1kDVDKDHO5aa4LvewWDpRxkCDP6OOtj08WI1bIgFLG0h4Uuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760619343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVxkznpREkGXulHfNgc/1XyKMEWKtw1WtetrGTqJcnE=;
	b=SxqzDF8+JH8mjp06WXBCv8CPN8YsxmQHM9cZjYyeJmVnTyN8y5wnajBtAw3zwv83wI3ABt
	+vf/6UTcHzsulpAQ==
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
Message-ID: <176061934181.709179.16551803303432704592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bbec970f417aa9796d6b36b60b5fc5df09ce5904
Gitweb:        https://git.kernel.org/tip/bbec970f417aa9796d6b36b60b5fc5df09c=
e5904
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 15 Oct 2025 12:55:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 13:12:50 +02:00

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

