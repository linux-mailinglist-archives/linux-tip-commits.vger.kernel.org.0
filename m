Return-Path: <linux-tip-commits+bounces-2314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7698DF77
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33311C24EDA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B31D0DCB;
	Wed,  2 Oct 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiYeZYrS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XA83wyUt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F91D0B99;
	Wed,  2 Oct 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883822; cv=none; b=ZAMk3sJNbEGOJy0OAomkVKJjQYqrlkTWwGoZc5/qknmKCjEJ7XPErYopTaWSItyrh72Kh7ICugzS35zBLJQhT5od+SKgiixcQRyh+jGMXOssIRsyKdroh046VZ0aDXEvUC1TgGyVyN8aHG1/XyvgDaNUGl6dRr/4vkzcLROgmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883822; c=relaxed/simple;
	bh=2DyAKxjvFv4UF06UPAfKh4bWZ5YhQGI5QI1Z+w7prM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l65uMT7Uo0MI1xq0/EJ4dbHJ/5Jhd5H72dunWa/a5vVRTxubnPvljer0eKR9DMDFlMMIgbTO2vqaHb6gz71FIdClVZk2tozGfcKg+ztSPcQbrMiguAaYhqJop7tx4ZGKxr1MBrfUuO3SKNmgOOG2wUTCDFSUW7YZEtOhaOGiNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiYeZYrS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XA83wyUt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9UeIwEu2aLV4HCsaOAcRv9EzfhtrBlMLiBd6r20Uao=;
	b=fiYeZYrSSo3x0cgH46yYNMWHEFnzZ7k4B3HEOaEjnjMUenuixitXiQekYJ734ZbOfYaail
	Huwoue7jbF6UZjo/OC5Hp5fgGfRtkomDTdJHZ3r/Kx32AshCZ+TrYxNjGmfPN7qlC3iTKD
	SoISj+6YssMmmhRqDH3sctY5nYyw1Yb8R3u296+d0+/8M0l9Wcq5JFiwohptRwqwPhwFEk
	6Ekh9CJD6wqi2EafEKQxMvJFgt7oNko4yBfO7VCuBbIfVnGLEdNglxwwap59jnikk1/mqa
	wOm7eBuEXiyvpzAnX8qoZVIJAV+QbIHPC4cKcnnD4kivT61BIyFTqSRfRZthJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9UeIwEu2aLV4HCsaOAcRv9EzfhtrBlMLiBd6r20Uao=;
	b=XA83wyUtQv/qXzOCZlxGajHa7C0Z6QzKUrSDpQ60Rn4DcHkmtZW49o0meahd8TzRz/A65G
	5F5sWyIPtoy30lDA==
From: "tip-bot2 for Varshini Rajendran" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] dt-bindings: interrupt-controller: Add support for sam9x7 aic
Cc: Varshini Rajendran <varshini.rajendran@microchip.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 Dharma Balasubiramani <dharma.b@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240903064240.49415-1-varshini.rajendran@microchip.com>
References: <20240903064240.49415-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788381860.1442.10029712473702362356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5a5d6753035451027a6ae92f478eb0b07f801348
Gitweb:        https://git.kernel.org/tip/5a5d6753035451027a6ae92f478eb0b07f801348
Author:        Varshini Rajendran <varshini.rajendran@microchip.com>
AuthorDate:    Tue, 03 Sep 2024 12:12:40 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:36:47 +02:00

dt-bindings: interrupt-controller: Add support for sam9x7 aic

Document the support added for the Advanced interrupt controller(AIC)
chip in the sam9x7 SoC family. New compatible is introduced to capture
the differences like the number of interrupts supported in the
integration of the IP to that of the previous designs.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Dharma Balasubiramani <dharma.b@microchip.com>
Link: https://lore.kernel.org/all/20240903064240.49415-1-varshini.rajendran@microchip.com

---
 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
index d4658fe..d671ed8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -23,6 +23,7 @@ properties:
       - atmel,sama5d3-aic
       - atmel,sama5d4-aic
       - microchip,sam9x60-aic
+      - microchip,sam9x7-aic
 
   reg:
     maxItems: 1

