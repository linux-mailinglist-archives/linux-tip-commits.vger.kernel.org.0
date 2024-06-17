Return-Path: <linux-tip-commits+bounces-1404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363B90B2B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB58D1F27BEA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3E1D18F5;
	Mon, 17 Jun 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g58Gupcs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZjDYArJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB619B5BE;
	Mon, 17 Jun 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632272; cv=none; b=TtWTQlN/UntOA3OQCmD00dzhz/efdAEmxuMsDju9zBmeSNguMSJrjs39LLZe4FV/DfKjeJ1FgXEvpwIZy7eBUWRgdiUtAwKYeKiKtDs0s+4E64fz3RkB93r8vaZ2quLlu/SAng2DhBU4O42PfGru70CFQ+U/47YcLLhu9pj1qvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632272; c=relaxed/simple;
	bh=aYfquDb9EQrjm/4EU97kHdcnjpjClnnougiLx29DyhQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bvqCl4J4x08ahRP1iFHErX8hQxm9DPcmxzg3SqInNZEp2hMwDMSUDT7u6QPkAsCkLlta0sD37ZzJAULc660qS4bhR3rte0KORVLYtKukX4VHlkuwwXXfnKkzfFcD5auMdTgYwtpdar/yoJFD+ewSwNBWDDz+KsVHTv7nrpocpWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g58Gupcs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZjDYArJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sOtdGQQBQx/HxRD//FS4cwBCQrYBUScjt+HspYi9n8=;
	b=g58GupcszNZ+F3lNlyMq1z8Ebadc0Qp8j6pNxWw6U7xf13N5w0Qh3/1gGhk1QntPdcO2+m
	SafQBhwiSvtUDBMuX7jQmi3g9CZMNssSeTscoumP15as/+nwMwTKecmjnJDzv4G2P/bUDX
	a2a/ysvP3JOFMymQ6tj9l5Vo9kWZdWzyymGGFiiRyVAnmPfe9x4n5oOmcQQjKsvXdRGJg4
	2CEM1C5hpMmnCh3DVSwQptATY++ZbZedqpC9u4RHhZ5VOZwRori2UOL//bJ5xTzl2CAzrR
	6rcDc/J0a9p9dzDYRw4el9tq69WN7AT2WKwGCzYLmyVnqrJ6FMPuWPJTZtdeZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sOtdGQQBQx/HxRD//FS4cwBCQrYBUScjt+HspYi9n8=;
	b=oZjDYArJ+45YXZcucParnO5xM4dFHfvpnxSGCtjBIdeWMA21PTEltUxAynQLT5gN/Z1uWe
	03wkoJBDN5k2LCBw==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] MAINTAINERS: Add the Microchip LAN966x OIC driver entry
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-24-herve.codina@bootlin.com>
References: <20240614173232.1184015-24-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226750.10875.12429536332259371797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     92584deade41ac8dda3f9b79ab545f50ba0e95db
Gitweb:        https://git.kernel.org/tip/92584deade41ac8dda3f9b79ab545f50ba0e95db
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:15 +02:00

MAINTAINERS: Add the Microchip LAN966x OIC driver entry

After contributing the driver, add myself as the maintainer for the
Microchip LAN966x OIC driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-24-herve.codina@bootlin.com

---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2..c47d8b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14727,6 +14727,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan966x/*
 
+MICROCHIP LAN966X OIC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
+F:	drivers/irqchip/irq-lan966x-oic.c
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org

