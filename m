Return-Path: <linux-tip-commits+bounces-4714-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9BA7D649
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09FD4211A1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA7225791;
	Mon,  7 Apr 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZNveTJA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcrgbstN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA10224259;
	Mon,  7 Apr 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011135; cv=none; b=tY+k0LDSO+ErqJf0157n477Qs7yfVySR4ddhsZA3aQPCew0ETSH52athGenXIypOd6FO2q01LMQiIc2ZgkT+mlnUourzlJAi4R8xEgVNr+O/e6uMf+2EPTMrrs24o4FN5BGDHDOV2q//o/Ia2pDCTdjkIodf0DoZRjrp8lzacmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011135; c=relaxed/simple;
	bh=+EIPvqtMgFTS9th2T1n7+fL7pBAcpJkfuyLspKgWhxw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S9B7ZhJVbrdRU/Co+WN6AkhNz6sgp6y52hgySUmjbU8U0RxO4ZxSBt2qKzSuOv9yxp76PMRY3gqZPvyfVGodVQPtSCMLz3xnEVud2KV9BzhEI6Pe09njMF8Mkq/7mS7Z47Rq7XU/dcTlAHNvMgg2DfLTb5+y8s6uvPlGjhZNV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZNveTJA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcrgbstN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:32:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiCFZ1Mr+g7ZRnBTkYBd7mClBBhyyzQQyj80IVvlZvA=;
	b=KZNveTJAA684RU9NcG1rIra4ekV1LoVbu9AJSKymPOfjUxPxJ8eRc8F5ZN4CK+Y5KPHIa2
	YdAqLfoyt0xybH9wst7u57oXqNoSR7pnnefdbocef6Qdz+hUgPj297MDRqoXOLl+npah+W
	LP8BHYhZBfYjtuhjOoMOvu5YtnJKCkRLxMHM8P/D5PhZUcn3rzEiMvJ0Z82yYXPEI4IjQD
	F/mQ15PkpI8sC4vJ9SEAgvciQiACkJzSoiCtzyiKvuB3McBtaR0NHwdNE0GhAM9w9nDh9K
	yZfJ1l4/lecJ1kldl34UalLl07+uDVELbRBgliyHqhXE8ozDeTLZumFVY03M0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiCFZ1Mr+g7ZRnBTkYBd7mClBBhyyzQQyj80IVvlZvA=;
	b=JcrgbstNlEGXhAzDMsHn5lwzvLj7Li2+gU9+D+ILzG8qLfDm8W5eiHReLquq7ARr+JbofR
	zZVwqk6VUh+W7bDQ==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/davinci: Remove leftover header
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250306084552.15894-1-brgl@bgdev.pl>
References: <20250306084552.15894-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401113139.31282.18030222633323019445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     75f8c87555e6ddeff2c49bd47460a71a940edc48
Gitweb:        https://git.kernel.org/tip/75f8c87555e6ddeff2c49bd47460a71a940edc48
Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
AuthorDate:    Thu, 06 Mar 2025 09:45:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:23:55 +02:00

irqchip/davinci: Remove leftover header

Commit fa8dede4d0a0 ("irqchip: remove davinci aintc driver") removed the
davinci aintc driver but left behind the associated header. Remove it
now.

Fixes: fa8dede4d0a0 ("irqchip: remove davinci aintc driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/20250306084552.15894-1-brgl@bgdev.pl

---
 include/linux/irqchip/irq-davinci-aintc.h | 27 +----------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 include/linux/irqchip/irq-davinci-aintc.h

diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
deleted file mode 100644
index ea4e087..0000000
--- a/include/linux/irqchip/irq-davinci-aintc.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2019 Texas Instruments
- */
-
-#ifndef _LINUX_IRQ_DAVINCI_AINTC_
-#define _LINUX_IRQ_DAVINCI_AINTC_
-
-#include <linux/ioport.h>
-
-/**
- * struct davinci_aintc_config - configuration data for davinci-aintc driver.
- *
- * @reg: register range to map
- * @num_irqs: number of HW interrupts supported by the controller
- * @prios: an array of size num_irqs containing priority settings for
- *         each interrupt
- */
-struct davinci_aintc_config {
-	struct resource reg;
-	unsigned int num_irqs;
-	u8 *prios;
-};
-
-void davinci_aintc_init(const struct davinci_aintc_config *config);
-
-#endif /* _LINUX_IRQ_DAVINCI_AINTC_ */

