Return-Path: <linux-tip-commits+bounces-3498-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A6A3991A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23F51895FEF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0E22690E8;
	Tue, 18 Feb 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jsj2kFYx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJBHf0jq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AD267B08;
	Tue, 18 Feb 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874409; cv=none; b=LGM1AhJw5ZuC73zj2cqDAwMPoffAQ2qXsG2XDJlC6LX6kP0eFN8ka5PI4zdsBU78f1bz8JqyOiw7ICnLYbopQTOKkX1j3ce5ZwMHY5NcRp1Oqa3qvRm+xeNdN284x2CExkGdirQstQQy+7Bk0/YoJBnSNPT0lMgSRaEzjQXz+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874409; c=relaxed/simple;
	bh=IPsDxygaYLHpsm+Dxc0KLU2qHLPY4373s9VViCM57+E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V5x1D4omxaqiA/RbFDR/zUxpTcbRyUHCPnL0nPWOuPfGNGPWLi2Mxqv7XVi2+kJRZiFUe0a/J31w3SwMCyGL7vGDP2Tj5kD0XFwXnrUlTrpjcrsAy4/KCevJ6rBogekoj+LMOFG/TgkA61TpMmBv0WPu47KHorwU0uKQQAl2eMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jsj2kFYx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJBHf0jq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLwpqy2+GVZNSA8Bu9p2T0PXou3eAl3Ilb9IcykgXS0=;
	b=Jsj2kFYxKMFUMMC2O/bMxGUvccaf/LQWfkTQk4KXkbfabXX8o/MZyuIW76zgLJJK7+Y3Tx
	K4quRrQJ6be4DDzwjRidRAXCpf3VYIH9cpG3k1iLX4jTpNh6Vl8yC6+7YRdGQ5NRaWsIh2
	oNSFas58tznRN/SWnWM0pSPATlHRhkp28Cgh6sPT0hWnhyOkK3a7SKhGz9MyNVaOxhp0U4
	ElgKav3yVtYioulwEJpOmfLJ1zSOl7IMfs4csHh1LOe7YoXMhc+CSLAka9NK2g02b2fWLP
	fgoBfWiCI3bdAmkr/lYwPLhUJEsZGZvPMUzLBO/s0j6gMKou0cyDCaZ4PzMGsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLwpqy2+GVZNSA8Bu9p2T0PXou3eAl3Ilb9IcykgXS0=;
	b=sJBHf0jqDoY7QVnqL3nP1gkNiC3vk9WDLIGxWMEbQcns5aLMYHKNcoVD3fLzu8i/P6znL1
	zKf1rnzEmuNyJIBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] usb: gadget: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7239d6211ffb0dff6351d0549d065277f2562793=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C7239d6211ffb0dff6351d0549d065277f2562793=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440597.10177.14599422226040945490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     060baec57cfea34b380618e68144c1605afdb500
Gitweb:        https://git.kernel.org/tip/060baec57cfea34b380618e68144c1605afdb500
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:02 +01:00

usb: gadget: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/7239d6211ffb0dff6351d0549d065277f2562793.1738746904.git.namcao@linutronix.de

---
 drivers/usb/gadget/function/f_ncm.c | 3 +--
 drivers/usb/gadget/udc/dummy_hcd.c  | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index f60576a..58b0dd5 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1559,8 +1559,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	ncm->port.open = ncm_open;
 	ncm->port.close = ncm_close;
 
-	hrtimer_init(&ncm->task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	ncm->task_timer.function = ncm_tx_timeout;
+	hrtimer_setup(&ncm->task_timer, ncm_tx_timeout, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
 	DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index bda08c5..4f1b5db 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2479,8 +2479,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function = dummy_timer;
+	hrtimer_setup(&dum_hcd->timer, dummy_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2509,8 +2508,7 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function = dummy_timer;
+	hrtimer_setup(&dum_hcd->timer, dummy_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);

