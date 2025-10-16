Return-Path: <linux-tip-commits+bounces-6950-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29FBE5274
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3071AA09F0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184923D7C9;
	Thu, 16 Oct 2025 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ph3wSf2l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yj565F7j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014962116E9;
	Thu, 16 Oct 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641288; cv=none; b=i7axYHuFSXn2+my9axbm47CfLTX85654xW58FK6EWVfetd2oH6rEzfl4je3PPaEVSN058RxBK6oSRr5HYvZhDdWP4Ji3nT/y9uZlzIXmCUm+D5fePp0jzjb4QvPY3s+euYoJWTYb4mEhHLuhw4M3Ddud8Rba8U6jz/so8Wgoz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641288; c=relaxed/simple;
	bh=tC8seoEaaAqffRkUFseDaMQrWEL6lS3N1PptNEXQExY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=llmV1g19LRYzd0O0HtFSqQtMW0CwiaTnjZ6D7DKECF5+L09YwQR8wpmg70YOMSL+VN+zY55FLnrffu2N5nDlMWvk/gxAeRlTnmPc5u7cNM2ZkB+nI13Y468cwR/ps/EPujS1PSTER+5ZKlB8Jke45ian0mMSErNu0j+bnWbFphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ph3wSf2l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yj565F7j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760641285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUqHe+sSFBp/rxaHga4DuBnG6IISWmEOJDsJ6GqQX1E=;
	b=Ph3wSf2lE4G7sVpAvdDzrtbdA//TY0f/vNPTxBbYCWEWGp+jIg20MIpTt63lB8eiQYBdNt
	9QEphPsPqmcGtze0Qsx/Zw7h84XAv1HX5IS/fL29uo1FCuNNmS9Vh/TlmA+OtLqYESpdcR
	28ZUn5inav19fYOm0rhv2sXZobov13A9e79jQpDamvN0M7tApjVlCa26tG8Eo5ouXTORnI
	hy74+Cp4d0OUSog5eSDEGa2Fl9t5TD2OX7uoPvy9bebQNNtSjrm9OCkAbvroLQYHbEnqP8
	7+G/QwtY7BiHbiaBH5txnjeBryDOWT8I9ALDJnJOcwQLbf/aViwfDC/uRTNZIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760641285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUqHe+sSFBp/rxaHga4DuBnG6IISWmEOJDsJ6GqQX1E=;
	b=yj565F7jJ2sMnJUS09KWsZKyPmA8Vq0HTfqm4d+jnKAYo2s1zqosYvBQGCYh2tgPN8nolu
	pZMfyisUoO6Y9IDA==
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
Message-ID: <176064128385.709179.12605136531125247228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c475c0b71314b222af576f93e2d32df077f14ad2
Gitweb:        https://git.kernel.org/tip/c475c0b71314b222af576f93e2d32df077f=
14ad2
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 15 Oct 2025 12:55:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 18:17:28 +02:00

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

