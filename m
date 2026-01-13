Return-Path: <linux-tip-commits+bounces-7893-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF6D176F2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9A3A300E3E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3537FF7D;
	Tue, 13 Jan 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F0jR9Hme";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AoFx07Py"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84A3128AE;
	Tue, 13 Jan 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294759; cv=none; b=ZqR3P5CJ0ZaHYZ3v52uASPihUEhE5gFmjo2/d5hxHYy0ufklVFHKZHNivPAPCBgi0VOsxn1CiOUnB3AX3BKyuc+xMGBrl/eyxJolVX8Ug73+hG3/7lirov11pVihdpboJHpqcPTmg6SjA5q1ujqaBral6ICJG4lWcz45OSCWigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294759; c=relaxed/simple;
	bh=sejjDQN/rQx4SHObeuu+wRFBXrNEfm4gmeylWGSuGEc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A+DKtBpjWJTOLGyU0ettt2bei5AUT0Lypc4MRjQatHL9qRDd4vf3LA/XkPA5VxCE9RDq7zuSCWhTemNgxf0EnL/DjjsjX06bBkLChZ/pSvoZNBpnCsGB55K90Jh2A1H8vtuiLcvF9n5BX+Kw6WesRK3t7nHDlAPU3Rslz+hT2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F0jR9Hme; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AoFx07Py; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 08:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768294756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSy+7ZDuE7ljob2kEBBnJ2reXrrnlPeTVTXEL3e4064=;
	b=F0jR9Hme4Do0+zE1uGyZa+fBo3PQJS6KpPB7IEyVTZwi3AExIaeBKliQAR20kqkpKf4t73
	VlZc5PrHaCZnoIx5LUmDZhe3YbZnN8I1p8Tp1THmCP59dVcNa7oRG8lPsp1aVpScUowmV1
	gSVTYnxpGD3XNlcbEUoe3CFA/e8sKLZe0LOhdAQjveZIYLiWyEPVQcq62SfLxEn1x156+0
	K3nKyFZY5648bByT9bG1JvTFj3YMxBSRXQK+WgH4RkeOxy/i2M9ubgQFDJN1275oFtb/3N
	VJDphUJjn65Xn6hJuE55H+dilqlSctr6RsYXHdyBUO3vR8kTraEGmVYjd+e4pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768294756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSy+7ZDuE7ljob2kEBBnJ2reXrrnlPeTVTXEL3e4064=;
	b=AoFx07PyQPNUFGRYqAo/cB7AUm8PZWL3iq/vsy2d9o6oIKZZLeX/SBMDm4CA0E1iwYPbIq
	Asv22wr/SmtEbaAw==
From: "tip-bot2 for Luo Haiyang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-imsic: Revert "Remove redundant
 irq_data lookups"
Cc: Luo Haiyang <luo.haiyang@zte.com.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260113111930821RrC26avITHWSFCN0bYbgI@zte.com.cn>
References: <20260113111930821RrC26avITHWSFCN0bYbgI@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829475523.510.14507156182002572447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f2edf797dab185cce439e5bc5185fe20dd536300
Gitweb:        https://git.kernel.org/tip/f2edf797dab185cce439e5bc5185fe20dd5=
36300
Author:        Luo Haiyang <luo.haiyang@zte.com.cn>
AuthorDate:    Tue, 13 Jan 2026 11:19:30 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 09:51:46 +01:00

irqchip/riscv-imsic: Revert "Remove redundant irq_data lookups"

Commit c475c0b71314("irqchip/riscv-imsic: Remove redundant irq_data
lookups") leads to a NULL pointer deference in imsic_msi_update_msg():

 virtio_blk virtio1: 8/0/0 default/read/poll queues
 Unable to handle kernel NULL pointer dereference at virtual address 00000000=
00000000
 Current kworker/u32:2 pgtable: 4K pagesize, 48-bit VAs, pgdp=3D0x0000000081c=
33000
 [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000000
 CPU: 5 UID: 0 PID: 75 Comm: kworker/u32:2 Not tainted 6.19.0-rc4-next-202601=
09 #1 NONE
 epc : 0x0
  ra : imsic_irq_set_affinity+0x110/0x130

The irq_data argument of imsic_irq_set_affinity() is associated with the
imsic domain and not with the top-level MSI domain. As a consequence the
code dereferences the wrong interrupt chip, which has the
irq_write_msi_msg() callback not populated.

Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113111930821RrC26avITHWSFCN0bYbgI@zte.com=
.cn
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
index 7228a33..643c8e4 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -158,11 +158,11 @@ static int imsic_irq_set_affinity(struct irq_data *d, c=
onst struct cpumask *mask
 		tmp_vec.local_id =3D new_vec->local_id;
=20
 		/* Point device to the temporary vector */
-		imsic_msi_update_msg(d, &tmp_vec);
+		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
 	}
=20
 	/* Point device to the new vector */
-	imsic_msi_update_msg(d, new_vec);
+	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
=20
 	/* Update irq descriptors with the new vector */
 	d->chip_data =3D new_vec;

