Return-Path: <linux-tip-commits+bounces-5975-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84DAF5AA7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Jul 2025 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237AB3A8963
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Jul 2025 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E52BCF51;
	Wed,  2 Jul 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XM2yBL9z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iChPUFrS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD08284B3F;
	Wed,  2 Jul 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465507; cv=none; b=XKM5UPn6db3CIlZVOyEIqyKrNqMv56gSIXiMULV0ycAFUyp54t2fD4QqJHVieGZpxO+7MJ1Sovlx7i3P1B0lIY61bfqGS9AOEh6u5B0tYd7fUyi8Ziu7/YQqq/Jp/zZyqhyrgNBkg0YYQUDLQlw+wYPJ46SMNQzDyVxnF3PhDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465507; c=relaxed/simple;
	bh=jkqGUunWYtC/6FAcQVLaqUo6B0iJuiNRSN0NLvfkka0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F/12yMiNKdkuyMLClwFQvBMO8LRVaYwE62BJM6uEwKzdV49YTAERaiykik/N8DzLpVkkF39oI+Yz+WkCeSK1YhRJkPTokaTssv+OC3lPl00kbfn0KWfvmEqIcAtIJ+TBSz4QdiUext2dljQudRwpXb30PCxq52oietV2jR6vTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XM2yBL9z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iChPUFrS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Jul 2025 14:11:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751465503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVB66cXrAO/u4wGJRc/4ma1ZhCHcA+OO3ptdgLPprAc=;
	b=XM2yBL9zmZ393NkvFj/1PHS/LWRRK08GAaLm6L2EIHCqLDDGk1RWXtwFUDPYC2OtST70P6
	6xUR+FVGCKOdv1r7LyeTNTzbQtgWCn3pKxuW9U60B+vf0K53HFiP7qPUcx+xbwyrNOmJ2O
	FS1V/DBRGw5V7WqS/oaYSXxJWdwsnu/uCRzgrVhkYNv5czqcOBwAHSKhWorTJuaCS8CSqq
	n5l+Tnxx4v1vzwdxuZe095olzOXWC6gnHVjP1aPtUh3QkMtNXTy6UBvcuWCWef8A5LgqVF
	CwfVXpt/wdDSFMB3obXrRMyW7aHtDFu/FjqHB1fxrtwIucwp8TAXJM1y9C4gxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751465503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVB66cXrAO/u4wGJRc/4ma1ZhCHcA+OO3ptdgLPprAc=;
	b=iChPUFrSsbDxcUAHxnjFlylj5rZ/O9zsc7Z8F6EAf/fYoa8wA4Mzs0ZtfZyYxG+BElO0IM
	Uf3EomiH+pajfwAw==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Remove unneeded includes
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd4fbffc39af2eaa7bc50a0a97ffb3a22e3c4cb6a=2E17514?=
 =?utf-8?q?46168=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cd4fbffc39af2eaa7bc50a0a97ffb3a22e3c4cb6a=2E175144?=
 =?utf-8?q?6168=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175146550236.406.13772230982074344211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     41a5f82885e152c364e587ab30df4e582e96b73a
Gitweb:        https://git.kernel.org/tip/41a5f82885e152c364e587ab30df4e582e96b73a
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 02 Jul 2025 10:53:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Jul 2025 16:05:36 +02:00

irqchip/renesas-rzv2h: Remove unneeded includes

The RZ/V2H ICU driver does not use clocks, of_address, or syscore.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d4fbffc39af2eaa7bc50a0a97ffb3a22e3c4cb6a.1751446168.git.geert+renesas@glider.be

---
 drivers/irqchip/irq-renesas-rzv2h.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 3daa5de..9018d9c 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -11,18 +11,15 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/irqdomain.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
-#include <linux/syscore_ops.h>
 
 /* DT "interrupts" indexes */
 #define ICU_IRQ_START				1

