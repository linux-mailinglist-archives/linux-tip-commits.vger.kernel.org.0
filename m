Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8428A8A5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbgJKR5k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388399AbgJKR51 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:27 -0400
Date:   Sun, 11 Oct 2020 17:57:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mULzEv6OVF3LecEXZgXHTMOwYOOO3NI9Qr8p8dP9lE=;
        b=uC8eqvj4MmPr7w3CsAYBzeb2+z++uGICx1EtLxhgMmNh6YnOAbGmQ82xcgV8ReIUBaXzQ6
        7uYxNURtf67mh0DsKJ5wMXpsPSwoBlhUMaqeL5vmfWoWRSwzsKPIbya4nuPV7oeUhwlFSd
        SyjVHNDX01M7wIgJlwQyVm+wqBW2w+FREFG8GqTKiJZZPo7fwmojx4R6THHou8YeQ4FDjx
        WKj2G3g0bv20s3QaGvgvBzWzpNJ1veiQ11rP6ZeJhNtIhTAi1phk3HDLOUvA27uBj9rLus
        xpFiuSOcL3vhqPLA4O/lewCQ4oPn4JUeDFAHMniwl3RR2rzsZiGmTv/+dAxVvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mULzEv6OVF3LecEXZgXHTMOwYOOO3NI9Qr8p8dP9lE=;
        b=M7aKuiB10dPDmwjWuTxYLCEtthn86Om3AwqJBkNm2sVRw9j3JSWI9crCciJJsRhhrs5q8P
        MGP/bl/6SgPaO+AQ==
From:   "tip-bot2 for Cristian Ciocaltea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C174084658e46824a02edf41beae134214d858d46=2E16001?=
 =?utf-8?q?14378=2Egit=2Ecristian=2Eciocaltea=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C174084658e46824a02edf41beae134214d858d46=2E160011?=
 =?utf-8?q?4378=2Egit=2Ecristian=2Eciocaltea=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <160243904480.7002.17019974704038505643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     aa524294ffb621cb51dbc0a0ccdb2929c0ca2bc1
Gitweb:        https://git.kernel.org/tip/aa524294ffb621cb51dbc0a0ccdb2929c0ca2bc1
Author:        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
AuthorDate:    Mon, 14 Sep 2020 23:27:19 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Sep 2020 16:58:01 +01:00

MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller

Add entries for Actions Semi Owl SIRQ controller binding and driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/174084658e46824a02edf41beae134214d858d46.1600114378.git.cristian.ciocaltea@gmail.com
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5cfab0..250c3db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,6 +1525,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
@@ -1536,6 +1537,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/irqchip/irq-owl-sirq.c
 F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
