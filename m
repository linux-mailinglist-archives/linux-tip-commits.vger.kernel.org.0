Return-Path: <linux-tip-commits+bounces-3500-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A6FA39925
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BC11755DA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D90269883;
	Tue, 18 Feb 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+NAe3Bl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XnwWfAso"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B1268C71;
	Tue, 18 Feb 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874410; cv=none; b=nDd6prvrKFjYM0JhXYd6BApKvw2owB987SXkHeQpaogdupH8LvNAteNTWsdTstYCFG9Q8m1Sy9Z0KC1PHai0eMrcODxtlg6T+vn5zH9D4pVp3iZoabyL2XV4MgHQbNItgl4fsic9qAuuOUgVrT4oX425C/vkH8BdKYTF9oqpp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874410; c=relaxed/simple;
	bh=w1UDgtcb+1VBAAYPnseaw6L/zukzwBmmlMxzZ1A/TIw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z2GRNovx3JlAWQA2LPXYJSXSUUrbuCP1zSgqEkIB0wjx3LB3JIvI/LRFLlDAX+oicmO+KjVMIMLhSCaKQCtt+szpUc5sq2hxB6jbpK5GegpBXwD82esbZ2DLaiLbqMthHOGxL35pYl9HrqdB+CCiaiyOwV0E9wD1mRU6RTE1C8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+NAe3Bl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XnwWfAso; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWvc6yLq1sbm+IoTgT9DUoIGN/UI1XMSHd5Vf1XXntM=;
	b=1+NAe3BlLRYsNQvlKfvkAds29mvjsk2e3uJ5VaKCJmzvmS/dmwSBIlyQ8kHIrb1bh86jmv
	3IhvzKRJeu2YSTSqbdKTuZFqmWa0Uo57u41Qr48PCATN/1JZ2LX1d+Q4kwfF4vk0PmnqQT
	FNTXZAoLYuCLYKAmKjxAGI2TqMpuVsqcTjBwo4U6PJnVbNJMpVtHayYfdUyRPDuyD8gMRM
	2QZ4u2ik2DPQh6MQpP/VWYvQPQfHeL0InWWYPMBYJAQq85jqeFPJhmgqL5GJ7w3RmmqDeV
	zfGmR1gre9I+fU9XFDmZYb0TpWNxtBWntxMkCJJAM4qfcJ9XKN06z+IvulTxuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWvc6yLq1sbm+IoTgT9DUoIGN/UI1XMSHd5Vf1XXntM=;
	b=XnwWfAso/RM/71rvti835qlpXevRN33fGtFA+xxkfignFWSxvrhI1XsaKOgWvAA5v8YiVF
	sFMr7fUDnd0m56DQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] usb: dwc2: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cab5762d4fd512ac318e7962109d80547d38419cd=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cab5762d4fd512ac318e7962109d80547d38419cd=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440715.10177.3033003236355130392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     4cf533bbdfab30011da84074f1c2fce71fcdfe28
Gitweb:        https://git.kernel.org/tip/4cf533bbdfab30011da84074f1c2fce71fcdfe28
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:01 +01:00

usb: dwc2: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/ab5762d4fd512ac318e7962109d80547d38419cd.1738746904.git.namcao@linutronix.de

---
 drivers/usb/dwc2/hcd_queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 238c6fd..2a542a9 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1459,8 +1459,7 @@ static void dwc2_qh_init(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh,
 	/* Initialize QH */
 	qh->hsotg = hsotg;
 	timer_setup(&qh->unreserve_timer, dwc2_unreserve_timer_fn, 0);
-	hrtimer_init(&qh->wait_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	qh->wait_timer.function = &dwc2_wait_timer_fn;
+	hrtimer_setup(&qh->wait_timer, &dwc2_wait_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	qh->ep_type = ep_type;
 	qh->ep_is_in = ep_is_in;
 

