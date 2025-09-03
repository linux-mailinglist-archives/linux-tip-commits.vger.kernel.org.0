Return-Path: <linux-tip-commits+bounces-6433-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B229AB41E8C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 14:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7165E1B5C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C17F2FCBEA;
	Wed,  3 Sep 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJhDpmEH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzU/JyyK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E92E62D1;
	Wed,  3 Sep 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901653; cv=none; b=klIHPduma6ZTQ9Lxdrqav0+WjMCWiX02wbuoCjDHhtJYDSbI8CqeZKmh5XUF+0XqCSDEivNwQq8cve1nfP27IPdcwcVjdIdTFv/JzVFzllCWPrWKAdktqBq0J9t8E9067eNYhgY0I66uPg6qJUEa52xQKg1eAKw6hQxgLgVxSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901653; c=relaxed/simple;
	bh=Fx0p6DhMmGUqqiEXYWdxvhrIUBgAevgLJmZaOy6xD40=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WRRcUEhwvMYZUOzZJeyrQ3RxBAe82htduKh2e3Hx6yC6ZMr23cea9hau+EcxL0O6491tmxE5zrHrvE+mPjQX/dD8+HTA5zF9ZQXK6A6KxB9jLTA7f7bwoiFKoHUNrnlcQik+p7Nb4ZiFJmLhFWt9/QN1pHnQEFgQAUyj9AKNiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJhDpmEH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzU/JyyK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 12:14:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756901649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0D9RNJCvUVFTGdG3gp4QBtoLddvq2gdNnrPyqZf5dA=;
	b=yJhDpmEHWn6Pjq6p/349IbyI9xnzNoA9yYCkx+/7S0mfDtA0LdnZO0T9sJrk4lDF7LvM5B
	MUJA0d6QHOYk4fx+LbHl7uBs6gEidQJlF/zkfaNmazYDLT26HT23kLDUrXJovCBp5HYG0Q
	3am/uwfV/oOeJNCyoNZAZAdaXlnQ7A2FzmOR5mh8o7DTuLx1gHngv32OSAqK+xuzCVJ00W
	CCPLjntBLednfnAwwwBU/ibuNOB3rog4b223U1chKZaz2WuhC7SvnD7TqlUyOlcqHuLk7z
	lxAm1Br0wY3gb0t2kTYY1gZkG1k1jE6ooYoE/OMIYyB0G347n/o+HxV9TNKQGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756901649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0D9RNJCvUVFTGdG3gp4QBtoLddvq2gdNnrPyqZf5dA=;
	b=QzU/JyyKOjkU7jIDXK9zBmLPeYbmD9QrNAMxhGrhtRVeeRwKXFWsIex7/Ntdshap2IREk8
	4IjCHuZpXgoU1gBg==
From: "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/gic-v5: Remove the redundant ITS cache
 invalidation
Cc: Zenghui Yu <yuzenghui@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250903023319.1820-1-yuzenghui@huawei.com>
References: <20250903023319.1820-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175690164851.1920.5871121421694988962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     54a1726d2e4c0c7b33f4e5ef35fcc118a4d74ea3
Gitweb:        https://git.kernel.org/tip/54a1726d2e4c0c7b33f4e5ef35fcc118a4d=
74ea3
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Wed, 03 Sep 2025 10:33:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 14:09:01 +02:00

irqchip/gic-v5: Remove the redundant ITS cache invalidation

An ITS cache invalidation has been performed immediately after programming
the L2 DTE in gicv5_its_device_register(). No need to perform it again
right after a successful gicv5_its_device_register().

Remove it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250903023319.1820-1-yuzenghui@huawei.com

---
 drivers/irqchip/irq-gic-v5-its.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 9290ac7..81d813c 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -768,8 +768,6 @@ static struct gicv5_its_dev *gicv5_its_alloc_device(struc=
t gicv5_its_chip_data *
 		goto out_dev_free;
 	}
=20
-	gicv5_its_device_cache_inv(its, its_dev);
-
 	its_dev->its_node =3D its;
=20
 	its_dev->event_map =3D (unsigned long *)bitmap_zalloc(its_dev->num_events, =
GFP_KERNEL);

