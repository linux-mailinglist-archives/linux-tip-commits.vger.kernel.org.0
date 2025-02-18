Return-Path: <linux-tip-commits+bounces-3441-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE586A39832
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7221883092
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4F23957E;
	Tue, 18 Feb 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9DvIWzU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+lu0vk4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265423716C;
	Tue, 18 Feb 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873206; cv=none; b=D5aoIuAJbz2l9PEvGIn1Q0SFivI1qJUh7uYrZY7JiC+tQItvhd9LRVj38MtaemaKrIqD3dpkJPJcE5+ztvOT05bvyyRq1SfipgNrvQ8DF7IwgjogvVhZX0qpW3wUhdFHHrYOoHAxfra7hklimbEpKILWxX3OUsSA++8QWASIptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873206; c=relaxed/simple;
	bh=kjZrpWRLzco8M20amOfICXNBQCDS7O0l0OlPpV8jgvI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W++5d3LOpm8eFirRa+nqeGfPHpCXfuynHU/ThnjBHGD2b4ypTdTUmdrEa09xZdAQV5EhiPF/BzqaT4eclz4Qosa8OHIIjFChoWo0zGKE3/bYCtvT+ZrhpLEHBL8mgoQ5WBKQv91RgO8VV556zYnmZT7eCOPak6oBIzjxDdTobAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9DvIWzU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+lu0vk4G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bZS9KW99rvykxooZbaedxx9je8iaAN7F4IB8Z2gst8=;
	b=k9DvIWzUiEcTGDElPkZ/v5p/I5LtAtwca2kEWYC8SLpoQYTCy31UOY9lXs9lu2jnZRWvlB
	htqyaAWA6RoZTo7uS99PwtRqwbevG4iKqtsBHQb4aqYta1NzZn4sLo8XebFMO7sJ/XV48J
	3rY1XhwNJm9HIINe0nzpWJHteSu7GJs0fDz/9dmdM8bx9WoqAN8zowzZqk6dH8uqiWdbEg
	WmFnD7eOuGJ3g5G/FNO7rHhh1QTTC1qKzcm9utOimCda2JPl5XCh5FQbhsb2nw4QHnwGqZ
	e1dHggLVca836N6qy1F9sMnpmA6SJUWbqZXk8gI4OicP5B5eXSe70mNMtbhi+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bZS9KW99rvykxooZbaedxx9je8iaAN7F4IB8Z2gst8=;
	b=+lu0vk4G67Z3nGHNFw2FdYiPBVxhH67mS6xfOxCvznpRz/TJkTEdjzGnAJUdIQF3sHMACM
	xRqo63xe72Mk/tBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net/cdc_ncm: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C219735f98754fb30dcfd892fbaa5766f9d78c1f1=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C219735f98754fb30dcfd892fbaa5766f9d78c1f1=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320286.10177.15516326860189683607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     d1ba57528f44b3d3b270c9ecbf256fc6c88c748e
Gitweb:        https://git.kernel.org/tip/d1ba57528f44b3d3b270c9ecbf256fc6c88c748e
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:46 +01:00

net/cdc_ncm: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/219735f98754fb30dcfd892fbaa5766f9d78c1f1.1738746872.git.namcao@linutronix.de

---
 drivers/net/usb/cdc_ncm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index d5c47a2..34e82f1 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -833,8 +833,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 
 	ctx->dev = dev;
 
-	hrtimer_init(&ctx->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ctx->tx_timer.function = &cdc_ncm_tx_timer_cb;
+	hrtimer_setup(&ctx->tx_timer, &cdc_ncm_tx_timer_cb, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	tasklet_setup(&ctx->bh, cdc_ncm_txpath_bh);
 	atomic_set(&ctx->stop, 0);
 	spin_lock_init(&ctx->mtx);

