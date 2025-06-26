Return-Path: <linux-tip-commits+bounces-5927-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C0AEA02F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 16:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E400D188AF15
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09682EB5A5;
	Thu, 26 Jun 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tof8uUcW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/bkPDPyv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518302E88A3;
	Thu, 26 Jun 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947190; cv=none; b=b3oeUGe89xIlan8XsE86PcaJIApP8R6vdZBjbdlH3nxVz5hHV49KHBH2Vceqc4JFfu2V7bASwVlH/sBYbDrQYp106jRSAVUaMQ6hoh9ikYjYroHxn5qtI/iPVzVlI687WRqmUaTaGiow2Wv2fef9zM3oVwXaRih9i//vvUlWFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947190; c=relaxed/simple;
	bh=tkKw9az4XoT7A29OtmY0eUx8xPqX5Urhn1wuSGIgzfQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mf+WGV/cCgSbkI8yFkgO3y+YrEO0S05lKYnN8KtR2g2mM2FCj/Ho9bvKA5G0k0dE+O6Y7pG1gsC/0/7B1zLLMJWluqT/lsgeSOooTCUif8mnpcpZZWe1/9Qify7Kc3HBKdVTGnFgZSk8GBi2vfQrr8Qnu8LB9f+AL7YpKRjfyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tof8uUcW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/bkPDPyv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 14:13:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750947187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abLFzSa7DCK4nvDPg/aCWTA/N0nXTkG8tnfiwSyj7BM=;
	b=Tof8uUcWiu1xydqwrdjosZIZdhUufeIhzgYbjVuedj0GIvMY+l2rPpYqr7ypaK3cLWs5oL
	7s5hsPeO/MYkmWV2ptXi3SkRU/oFBsYbTwET0z+hdJ4l3mglcz366Dojz8TF22ujgjEeOv
	WW2Vw/w/GMWBZCILw7fwLxJ5OJLuc1TpYMfowSpa4+mBtFDugjZH1Y/SrXLz27QiTKJ8T6
	Dj6dRGSty9XASX9UtSN3y1kwQeA0vTWsFfdxYrxRU3rzBkULLq0uUn80pkwQ637MU5mjpg
	8xWJGhpOsY3oimUwUSIOBhUgVcrnTayVFND5+2pP1a43CcJ2jtSOQdm3IYrxSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750947187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abLFzSa7DCK4nvDPg/aCWTA/N0nXTkG8tnfiwSyj7BM=;
	b=/bkPDPyvs1gbn33TDEAvRKSHj4vVuGG/oR3+UK25LQE1BruTBAqCQCUHP2sTa400A0b2uh
	11JYd2a4r1FYRHBw==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aclint-sswi: Remove unneeded includes
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143911.3224046-8-vladimir.kondratiev@mobileye.com>
References: <20250612143911.3224046-8-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094718645.406.10104361621657418175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     93406e374295ad25ab06104f734459cd25ce7134
Gitweb:        https://git.kernel.org/tip/93406e374295ad25ab06104f734459cd25ce7134
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Thu, 12 Jun 2025 17:39:11 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 16:06:40 +02:00

irqchip/aclint-sswi: Remove unneeded includes

None of them are required for building the driver.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612143911.3224046-8-vladimir.kondratiev@mobileye.com

---
 drivers/irqchip/irq-aclint-sswi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-sswi.c
index 0131194..d9f28c0 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -7,15 +7,9 @@
 
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/module.h>
-#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 #include <linux/string_choices.h>

