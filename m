Return-Path: <linux-tip-commits+bounces-7836-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D9D0AD2F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 09 Jan 2026 16:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE31E3063F41
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Jan 2026 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F9320A1F;
	Fri,  9 Jan 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WATrnly/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cErk2M0N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB1311C1B;
	Fri,  9 Jan 2026 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971498; cv=none; b=KqRbr4mW2wOC+C1lYuQYj7hLlS9EvpNlBLXnOpPPvs8lbz35R3aFTUCkZc/aXcWEXLqMa/tyAW2Kh+pHZ5CVlbzcST9rJLACt/SGdywimr2ZJRjWStRkDbg/zbUh0a5qTWnzQW1nYRQ/i1m+eH7tFHXEH6G8XiHuk/DLanxPdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971498; c=relaxed/simple;
	bh=mRLglEiC2S/08ROvVbnjuyfTNgsDMnd3LajS9QbCn0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JhN3hZf2WwF3QzjgEzT+IgEQoOea13xl5KhyD/eXjQH3NtD21oGQtrDpPN8xLEMwyV5i4K1FRapT3chAIplutoi2qR3eE3QGFH1nV4MPjewZ6v9vQISqbt+/IiUY4rLLtZ14+7H68SMAEHpQ49S4O9pt8esNfg1mEAwhBrgu61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WATrnly/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cErk2M0N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Jan 2026 15:11:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767971495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZPJrH3rzKCqgV0LwLMP3yf3lBntwI93VEcaB7OyjQE=;
	b=WATrnly/4sYwl8T0gv0AIEhabgmxRynAOETxuSNj7B+GO9uE1PYRRh4pj+hBdCe9qQcfUu
	kK5RjImE7AF4scZtuj12vDgf1B0/deZButCvy3AE5o2zh5uDQTUiH6YnQPuqCjQQgNjbgn
	n1PjER9aarIwzsQHhgc+yel2e7w1gEJgTYRumw/7JEpBrgYLktf9SfpykiqpBMrXLD7eIN
	bWxNSVOlo9tCYO+ecYGKdHNZypbFTTwrYKLBldWyxCOjYd/dRZ8NchW4RGldt2QGH1qb4Y
	fkN4UfQ7GHe0duB493NFCCAVQpx1CKzLU6gXpqYD4Wg3bZQyBF8c3qylRsX+cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767971495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZPJrH3rzKCqgV0LwLMP3yf3lBntwI93VEcaB7OyjQE=;
	b=cErk2M0N46+EWL51K/b7VA4hSh5+MQbeDD/iEh1vtlSbyUoCJU7RpEnpE9upEmKXIlkEx7
	hRrEnzvMdOdT7yBQ==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v5: Fix gicv5_its_map_event() ITTE read
 endianness
Cc: kernel test robot <lkp@intel.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251222102250.435460-1-lpieralisi@kernel.org>
References: <20251222102250.435460-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176797149438.510.2985738995782862105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     1690eeb0cb2bb77096cb6c826b6849ef05013e34
Gitweb:        https://git.kernel.org/tip/1690eeb0cb2bb77096cb6c826b6849ef050=
13e34
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Mon, 22 Dec 2025 11:22:50 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 09 Jan 2026 16:10:04 +01:00

irqchip/gic-v5: Fix gicv5_its_map_event() ITTE read endianness

Kbuild bot (through sparse) reported that the ITTE read to carry out
a valid check in gicv5_its_map_event() lacks proper endianness handling.

Add the missing endianess conversion.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://patch.msgid.link/20251222102250.435460-1-lpieralisi@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202512131849.30ZRTBeR-lkp@intel=
.com/
---
 drivers/irqchip/irq-gic-v5-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 554485f..8e22134 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -849,7 +849,7 @@ static int gicv5_its_map_event(struct gicv5_its_dev *its_=
dev, u16 event_id, u32=20
=20
 	itte =3D gicv5_its_device_get_itte_ref(its_dev, event_id);
=20
-	if (FIELD_GET(GICV5_ITTL2E_VALID, *itte))
+	if (FIELD_GET(GICV5_ITTL2E_VALID, le64_to_cpu(*itte)))
 		return -EEXIST;
=20
 	itt_entry =3D FIELD_PREP(GICV5_ITTL2E_LPI_ID, lpi) |

