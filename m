Return-Path: <linux-tip-commits+bounces-2318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234A98DF7F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7598B1C24ED9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7191D12EC;
	Wed,  2 Oct 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQpU6ovb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7RUTRmh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D71D0E28;
	Wed,  2 Oct 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883825; cv=none; b=cgrIzPWNIZX5r2++hzmW+F8NWTv+30k0j6YX9g+91Ace5zruXevIQYM99ArZhTNAbaffj7gF6PeRL0nwegFUaqy8/gGJ1FqNGLvkUtNiS0Pi6n8+AJG9jYLDwwS97UJ4jUWf8S/WEBr+sdOjiQHM8yl13ZqwDQmLSsffJf3x78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883825; c=relaxed/simple;
	bh=wo2It+qbfcnXpg9zhQZsvwID/TX3F2p/n/ezasR0xhM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PPVAg4lyJ81TNfc7YGgVgM7Vcgfx3BtaGwK6MB2PW+75TL+wpzaFLPNQ9hlAj5PHW62KuIHxaZuYan6INvnQSIZGqh9QgfJUGSHr6oGhgqjUuHf1F4297xkmDnQ/olOWnaTd7Ic5aOKjhTrQVD1Kcc4S0T5hpYr2mB8Xo1hJAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQpU6ovb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7RUTRmh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htf3Jk8Srsb2LqVwU0QFDJDUynAbXAZ+2q2HNPXT0Ys=;
	b=SQpU6ovbgvxanzqWN2lBxnCdoZRwkG+hdMXT5EGEc4hnMb87G+1pCnCGKXVa9sj0k0x3Ub
	0Mn34aXi4+0KFH9w5Jnglb6Zh8fIeza3KsRNZuWN6NzHa3/4YY2fcPMsVdifakBk7v/C1v
	SlxzTG3J+3661i1R8XfRguDZqC9lenhjSEugsO1jzKhzAn2IfiBsDSy0a0QG/F4k7uHab4
	NafZN/Wq4GvJJZ82sL0qsPgewtjLo4+eJDHvnhZEF7Fb1vlDMvsvz+dYnVZphrdLBVdhMs
	YeiBPX+u71U7ELeeT9xOrxh2QnCHiOw5lJpRYWndXZISoF9maSCZQ7dcgi+P5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htf3Jk8Srsb2LqVwU0QFDJDUynAbXAZ+2q2HNPXT0Ys=;
	b=I7RUTRmhnN2m9y967cpIJ609gml/6OxXgqbMxCy11dobw10EbGLj2HmyD8Rur575+Uajup
	45FeZ1fwK9LJcCCA==
From: "tip-bot2 for Sergey Matsievskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ocelot: Fix trigger register address
Cc: Sergey Matsievskiy <matsievskiysv@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240925184416.54204-2-matsievskiysv@gmail.com>
References: <20240925184416.54204-2-matsievskiysv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788382090.1442.6278337479127044634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9e9c4666abb5bb444dac37e2d7eb5250c8d52a45
Gitweb:        https://git.kernel.org/tip/9e9c4666abb5bb444dac37e2d7eb5250c8d52a45
Author:        Sergey Matsievskiy <matsievskiysv@gmail.com>
AuthorDate:    Wed, 25 Sep 2024 21:44:15 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:11:07 +02:00

irqchip/ocelot: Fix trigger register address

Controllers, supported by this driver, have two sets of registers:

 * (main) interrupt registers control peripheral interrupt sources.

 * device interrupt registers configure per-device (network interface)
   interrupts and act as an extra stage before the main interrupt
   registers.

In the driver unmask code, device trigger registers are used in the mask
calculation of the main interrupt sticky register, mixing two kinds of
registers.

Use the main interrupt trigger register instead.

Signed-off-by: Sergey Matsievskiy <matsievskiysv@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240925184416.54204-2-matsievskiysv@gmail.com

---
 drivers/irqchip/irq-mscc-ocelot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 4d0c353..c19ab37 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -37,7 +37,7 @@ static struct chip_props ocelot_props = {
 	.reg_off_ena_clr	= 0x1c,
 	.reg_off_ena_set	= 0x20,
 	.reg_off_ident		= 0x38,
-	.reg_off_trigger	= 0x5c,
+	.reg_off_trigger	= 0x4,
 	.n_irq			= 24,
 };
 
@@ -70,7 +70,7 @@ static struct chip_props jaguar2_props = {
 	.reg_off_ena_clr	= 0x1c,
 	.reg_off_ena_set	= 0x20,
 	.reg_off_ident		= 0x38,
-	.reg_off_trigger	= 0x5c,
+	.reg_off_trigger	= 0x4,
 	.n_irq			= 29,
 };
 

