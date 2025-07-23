Return-Path: <linux-tip-commits+bounces-6175-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77647B0EBB5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B68566CBA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5B275852;
	Wed, 23 Jul 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lC/OxN6n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRGz/Mjh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A57274FE5;
	Wed, 23 Jul 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255055; cv=none; b=tiVQLyw5IKXTUUpplkAPA8vvWzf+9xkKBExaWW+6Noc7RcBTQbqA/RK0KdP7sXIBvAa3UMbVY3CA1NEAh5YEho0wt32NaiI5MqzFhIxfzfS4T4BxPxG5vhEGoiBPVMWphMW663ILT4A+LOfso2Kvrtz/+h2u4ql80DuM7A3IMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255055; c=relaxed/simple;
	bh=VXg/BvN8VFoaznh5G9hh/GmRM/3Q64iPJcKCLhUsvEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UGGq1+FMozv8eZ/gBf29F9vqiGZd1j/Vgyx+J3NwlY8c7Z538wV53vrYjImUJoU+jtOsjlTfD52JhTrNZ8y8NO/dBgUbb6fUJsPNGBvdSThF8mIBFKvrJX7famqPiTKoG24lPmb499GjYeQFWe3qWxEfu4pH4kYxuKlRP6tFzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lC/OxN6n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRGz/Mjh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz/n9cEXnhpuEX+hkRsDx3CyJYbSCQVAirpRlNX6/qI=;
	b=lC/OxN6nlmImFAA4TX1EBsADhX7BW303VpDgQNuYMcd+8ZNsHJi8VAvSG3CH6bc+tigdDq
	jotWRWQzi/HxxYiOo9FCWThBUYEO3kLC5qdTf1J5FXKtdWECLmu+4beogKbYTx234Mv219
	13/8bR/Ra2wLB2er8AvG58K7PtC6hNVCu2+I0l1kG0lP8sYEUCKb5t1SLt8qZnaijLaipQ
	pEuNXqWEI4OQh/Q1/R/2e3Os7xnKzOlInMkAXBLML/O2KNuVPFDJqwA2hODYFyq7fHOLQH
	TNqeBTEq273HVxweQiW83tsd6bYG79DOLt82bOsMhJO7dFjmuN9AVqvSceN4Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz/n9cEXnhpuEX+hkRsDx3CyJYbSCQVAirpRlNX6/qI=;
	b=XRGz/MjhRoNndq9JTFXfsEGw2tfvY9skp+igpt4W5z1FlJYbNfXh4dnqnQfbvSoLASHMkL
	b0xcLZD3WoYRy+DQ==
From: "tip-bot2 for Will McVicker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] of/irq: Export of_irq_count for modules
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-2-willmcvicker@google.com>
References: <20250620181719.1399856-2-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505078.1420.10124095150535091023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     2abaaf8cc1104906cb2241a067e380a6295ffada
Gitweb:        https://git.kernel.org/tip/2abaaf8cc1104906cb2241a067e380a6295=
ffada
Author:        Will McVicker <willmcvicker@google.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:04 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:00:50 +02:00

of/irq: Export of_irq_count for modules

Need to export `of_irq_count` in preparation for modularizing the Exynos
MCT driver which uses this API for setting up the timer IRQs.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane=
.org>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-2-willmcvicker@google.=
com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f8ad79b..5adda1d 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -519,6 +519,7 @@ int of_irq_count(struct device_node *dev)
=20
 	return nr;
 }
+EXPORT_SYMBOL_GPL(of_irq_count);
=20
 /**
  * of_irq_to_resource_table - Fill in resource table with node's IRQ info

