Return-Path: <linux-tip-commits+bounces-1493-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF7913C60
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28529B21DCA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE731822D8;
	Sun, 23 Jun 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3RvpEzun";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2Li9ddf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3A181B90;
	Sun, 23 Jun 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156632; cv=none; b=OPiCvYSHVEnt/BEf070XTp/UvUuc5DxznnEGqWIObBuvZ7c16p0616vG/o0th9frHrUShaQSk0wO1kEXoxabi686CrHyHmiC+QkgAr8jOEPX0CY9dbefJrazMQtp7a90UmdPYF6ZArGOppkgVSo6btIbbHxInXAsLsGigneUyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156632; c=relaxed/simple;
	bh=t22kT1XrxjZEoNUCbfrFLfKW3TjLmeMC8wH9SS0NeJg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=n6RJ2zKnaWVSdtpTk+ZPdF9qBXN92/FFZcl4UNU2O4ExU8Iwwi2WX7XqqG5gNRyicV0bPDu4gBdz8YTjzwi4aK3blJKzW4/mWydlIHin8wf0HXQgbFADhJg1Cx70Eb3cdYXcAXEBGhZcH8z+yD4Uj6q1H/THsjd2/XKI5LV93qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3RvpEzun; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2Li9ddf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:30:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hjd9KWxT52dJ1S3O263g+v89ba+faehe2dgLCBSCGDY=;
	b=3RvpEzunT/3z2sz0iilmD78VEioCU/waufzlikHkM2eh4OUItecuxwWYn6dSz1NAvH4P6u
	G2BOG/Fd9xgtfIkP9S60F8spFHs8yqeX5baTRQ3S/PsNo2Eg/e0pT/VYSmIp/01pVf91SO
	XzD7EctAcJW3inhsLK8SNlVwnx89TBNiNbSjGI32hGsdVaG3w9f1HxbRdNy2cTRGucVuom
	UEssyUpTHvp4Nd7fWmK7WNEjKFaVlqYN/I11f/RA56xXgDIAqXFqz3V3FLmYn8Ngf2Bz9K
	+os7EU8JWWrdIHONY82Qn4LxONWoUxVlrvPLi1/y+H/YhDGfc751EozFSqHfvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hjd9KWxT52dJ1S3O263g+v89ba+faehe2dgLCBSCGDY=;
	b=w2Li9ddfkD9fPRnxkhg5EKXym+/gARWZEz8BeAdSgnR3rrhdPFeQmhWJyG9N7xgm65ZSqz
	zFcDZosKM7R80+BA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use atomic_io_modify() instead
 of another spinlock
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915662931.10875.4726909640508409611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     50c43447f71c6d0eb9e320c4cc69822d396e52bc
Gitweb:        https://git.kernel.org/tip/50c43447f71c6d0eb9e320c4cc69822d396=
e52bc
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 20 Jun 2024 11:52:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:23:08 +02:00

irqchip/armada-370-xp: Use atomic_io_modify() instead of another spinlock

Use the dedicated atomic_io_modify() instead of a open coded spin_lock() +
readl() + writel() + spin_unlock() sequence.

This allows to drop the irq_controller_lock spinlock from the driver.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/irqchip/irq-armada-370-xp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 4b021a6..676df71 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -461,24 +461,18 @@ static __init void armada_xp_ipi_init(struct device_nod=
e *node)
 	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
 }
=20
-static DEFINE_RAW_SPINLOCK(irq_controller_lock);
-
 static int armada_xp_set_affinity(struct irq_data *d,
 				  const struct cpumask *mask_val, bool force)
 {
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
-	unsigned long reg, mask;
 	int cpu;
=20
 	/* Select a single core from the affinity mask which is online */
 	cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
-	mask =3D 1UL << cpu_logical_map(cpu);
=20
-	raw_spin_lock(&irq_controller_lock);
-	reg =3D readl(main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq));
-	reg =3D (reg & (~ARMADA_370_XP_INT_SOURCE_CPU_MASK)) | mask;
-	writel(reg, main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq));
-	raw_spin_unlock(&irq_controller_lock);
+	atomic_io_modify(main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq),
+			 ARMADA_370_XP_INT_SOURCE_CPU_MASK,
+			 BIT(cpu_logical_map(cpu)));
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20

