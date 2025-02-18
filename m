Return-Path: <linux-tip-commits+bounces-3493-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23874A39905
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FEB188DA9F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E6264A91;
	Tue, 18 Feb 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2W54C+W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="corPPkTf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1909261579;
	Tue, 18 Feb 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874406; cv=none; b=pYmTBo6EREfRfANbfsuy8OiYMXX4YBgSKUbKM3aaDg1mPzVRaRbzQHrlQV9uD/qOXC/XUWRGfxa6+0U5BNHM6qP1EABvT0M9kSzsOJYTnFIoXblmpL/W0JZ9G7VU5H6gsuVzs9QLgwGoACY+VkaA1NF/TP9Xy0EH6xI4+k/SKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874406; c=relaxed/simple;
	bh=XNoA0k6L7Z06REcZMghK6qTQPW1Ebu5FtKH7WUP9L0M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qr9f8ZVM2zoAuNVOoc1SDP3liIHw65jjuhc+I06doI1VS9uqSVpeVIWFSIeU++6AqEdcSpr70U/zkuojJMlIn3Av8l3N6XOJSvzdlNtrkly1c0oKnsq9ayWw5sJK9rFsyrKEdMAe4Ng5KVJvirdrg5FyL/e015XU/obLhp6N1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2W54C+W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=corPPkTf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X5Wyce+GYnJIRrLMpDcbkEbs9r/Ynfy0p27fzdT8Zw=;
	b=s2W54C+WR8fpHesNHHY+BaoUi7kqfA2z3oHYj732SWlka+GmR8AJVo/o/LqBJKu66NgT5I
	DBBAsOuwphH9ztCT2uspK/Vv0UfmTQFm7Pwsf+pOjVqeM6SJaxKZlw7/EuLNPLwBgTrxCU
	jwVvCfncJOErjy2BAtNRn8QzWniS/gTquFsopkoEcgQOrfabVzSX3DPNmzGgykM3uhS8d/
	2p2+ycYpQr6fT1LedtknaEEpHlTpdDJ0hlAym/PPaEmY9oEStXUeeGSrZlv1B9lnHgdCTE
	St9oYDHtbdUxegOG9JZK4qOYWhdNo3YuvBDGKSp5cFfOvrAbOzO04KXHhLLcEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X5Wyce+GYnJIRrLMpDcbkEbs9r/Ynfy0p27fzdT8Zw=;
	b=corPPkTfRyDhw2bWAbClz/lYOzh0omJ3uF9V9hDU7NueQQS7cWnXqaXiI/GgCbrCsqFZoY
	+eabzMrTbEoB+1Ag==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] serial: amba-pl011: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C78e8c0d1b38998eab983fad265751ed13c2b9009=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C78e8c0d1b38998eab983fad265751ed13c2b9009=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440247.10177.15372016314805718779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c5f0fa1622f6fec7c461f2fe5b5d62229b4ae785
Gitweb:        https://git.kernel.org/tip/c5f0fa1622f6fec7c461f2fe5b5d62229b4ae785
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:02 +01:00

serial: amba-pl011: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/78e8c0d1b38998eab983fad265751ed13c2b9009.1738746904.git.namcao@linutronix.de

---
 drivers/tty/serial/amba-pl011.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 04212c8..98f178b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2867,11 +2867,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 			return -EINVAL;
 		}
 	}
-
-	hrtimer_init(&uap->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer_init(&uap->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	uap->trigger_start_tx.function = pl011_trigger_start_tx;
-	uap->trigger_stop_tx.function = pl011_trigger_stop_tx;
+	hrtimer_setup(&uap->trigger_start_tx, pl011_trigger_start_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&uap->trigger_stop_tx, pl011_trigger_stop_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
 	if (ret)

