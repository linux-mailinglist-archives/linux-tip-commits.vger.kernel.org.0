Return-Path: <linux-tip-commits+bounces-3455-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98912A39878
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EF43B87A4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C224337F;
	Tue, 18 Feb 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QwsHeIak";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+hdtxxRa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029782417F1;
	Tue, 18 Feb 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873216; cv=none; b=mTkf6OLJj9lN5YSu+TA4t+lbyTFu66dggQZTH3XIqVJ2mv7NHEjDM8WP0eFRhC8Ap5SS5ZczRe4o+6HeJekczqHXA61nbS4Hh38AzyWmsndtce8l9cxrvhEOmfCRt488R5XwgwMhqMtiGt7FwTW6Vd/LjSA/MMm6N7frF+Vn8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873216; c=relaxed/simple;
	bh=31+sYgofcjGupSWMZnLP8klUxLie/rU3NXZUpEtnPL4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HnO+wzsLm+aUsBzJx3+Q0Wj9Q9ZH4NxfledLGnsr5TWbMojDkDByQtbGFhWAqlxNLZHfVWb6TCM2D4YAZ1u62psnONTiiC9mkr8KxA/jllNFdYFmxmrB25fAbeeVjJ9bPVe7779xNkmJNq2ZByQJlSZqa0WjVVjqPlhJv82hdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QwsHeIak; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+hdtxxRa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENszz2VBsxuliTP4tjsp0sqS296Jw5MJ9W6C5MxK7/8=;
	b=QwsHeIakCkg/R2AmzGaQ+Oh9BTnFZCmokXRYAFEevPPh54vwBe8Oaq7NeZjO2qGlyNW2cn
	GTrWELPedTUJYOt7l1BGuB7Pf7gi9xgw1wp4xZzlsIgP5PR5S5TOojE+FQBI6saTpk73Fp
	a1lZ3Auj/20lvF0bjozKAuKPKqVsv0NriMIwnW2FUU0ARNz6oky+raJT83Vo9nTh24Gqmb
	6l9Kg/mF4ajak9ANMKkFtnSRTL5FOfeuoL6tUerFpfqWxa9A9WGYp9iy3mH89cF9WM+i7R
	dlgrAin5MRivR6+eUvss9lI2pvKH6iEIA5zPBYLcIQt882zHeV5rv+b71BUShQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENszz2VBsxuliTP4tjsp0sqS296Jw5MJ9W6C5MxK7/8=;
	b=+hdtxxRaW9RLgg57ZhD98ApIpIsl8O+L0NIYSUnNdsmMEx3msxsnsctWP1K+BWG8pDFtWd
	iWpVdoLcWHj5C2Dw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] can: m_can: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf1a87fcba211f6ce262a2d23fd152185f452c32d=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cf1a87fcba211f6ce262a2d23fd152185f452c32d=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321247.10177.10695882453900703937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e0eaefcd7e4449a444b557578b60a988636b4a71
Gitweb:        https://git.kernel.org/tip/e0eaefcd7e4449a444b557578b60a988636b4a71
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:44 +01:00

can: m_can: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/all/f1a87fcba211f6ce262a2d23fd152185f452c32d.1738746872.git.namcao@linutronix.de

---
 drivers/net/can/m_can/m_can.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d025d41..884a635 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2420,12 +2420,11 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		cdev->hrtimer.function = &hrtimer_callback;
+		hrtimer_setup(&cdev->hrtimer, &hrtimer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 	} else {
-		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cdev->hrtimer.function = m_can_coalescing_timer;
+		hrtimer_setup(&cdev->hrtimer, m_can_coalescing_timer, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 
 	ret = m_can_dev_setup(cdev);

