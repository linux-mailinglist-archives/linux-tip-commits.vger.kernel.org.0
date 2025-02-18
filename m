Return-Path: <linux-tip-commits+bounces-3442-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB796A39835
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603FF188C771
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FFE23AE8B;
	Tue, 18 Feb 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4zmaXcE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/r8/VTBg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37D239086;
	Tue, 18 Feb 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873207; cv=none; b=B0iyeZwDAbEdytfIJuv0EaKxLwaTQK3FJffeFJy+cv2civP+RvRDIOKXgiNvJ8ZrQtRjvIcOhCYHW/fdszjvRqsZxvMP4fp/JbtVJ63WzrWAzlbeRqWjyyJu6AshLBlY19Dlw5DAGS6w6K1i8l1isqFpbUfF/E11vKC1MsYkCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873207; c=relaxed/simple;
	bh=h0XH4wyVG//viffs1W+YjxuTj7VncCFrUaZvYBRDYGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NpV7XQ7u+mp7LB7A476V4ygiYGBsCMo35gJhPQeiNOxsU2CWX9nwvWu32ynKdYeEI7Ia2Xc3VZneFEYj8EdDjCqy7LGZV0ycoxTGg7UisZAlKAaX7A4ru89TXrUHiwMwaD9qpMsatgRm6WdVc6Ej6X2ACjuIehU1J1rIxKYfq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4zmaXcE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/r8/VTBg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtPS7FV25U/4fsXc9/8oIhS+s3fNvfsnTcT/hz4quI4=;
	b=l4zmaXcEaMfO8Wuk4dXuGIXJRX32+5QuUBosLiwpKUgNzhtKheC6YQCUPe24kErpCZFNcw
	KsOwmiJkQO0pEVops0UsTFk26wMjVtFiaqItn9pWUXlQlEOI95PF+TLHxVtznvKje0o+kE
	17Ucq8IZz2OM7lDZPx5UjSNfj3GGNkXEiBy5Zrg/5n/EGnoyMkNQBjZxl2yVqa4l1z8e8d
	JBky9ZJVAYmUI3Zts45wynnfU0tkAEk/QHlp6dgt74Yv/RqCRgYtrwoldO62VCE6d4Cm1Z
	BJ19ygUebDf38M18eYFecjwxLFQH0LlVL/o4sbgDOy3XK/0DpIdFf7bcChYnKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtPS7FV25U/4fsXc9/8oIhS+s3fNvfsnTcT/hz4quI4=;
	b=/r8/VTBgutYSV4M9Z++H8qCp2FOM9yJCvNsxJpFjAouaTbnhMZC1maGpfJLoSWd9lvh/jd
	TUmNCYK7yphR7IDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net: wwan: iosm: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce42d7d29879017d4b5ca9555f806e782658e3f21=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ce42d7d29879017d4b5ca9555f806e782658e3f21=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320351.10177.7639394034892458796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     d4bcc73352e467533b077e9253cbe68892adf6a1
Gitweb:        https://git.kernel.org/tip/d4bcc73352e467533b077e9253cbe68892adf6a1
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:46 +01:00

net: wwan: iosm: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/e42d7d29879017d4b5ca9555f806e782658e3f21.1738746872.git.namcao@linutronix.de

---
 drivers/net/wwan/iosm/iosm_ipc_imem.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 829515a..530a3ea 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1381,24 +1381,20 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
 	/* The phase is set to power off. */
 	ipc_imem->phase = IPC_P_OFF;
 
-	hrtimer_init(&ipc_imem->startup_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->startup_timer.function = ipc_imem_startup_timer_cb;
+	hrtimer_setup(&ipc_imem->startup_timer, ipc_imem_startup_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
-	hrtimer_init(&ipc_imem->tdupdate_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->tdupdate_timer.function = ipc_imem_td_update_timer_cb;
+	hrtimer_setup(&ipc_imem->tdupdate_timer, ipc_imem_td_update_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
-	hrtimer_init(&ipc_imem->fast_update_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->fast_update_timer.function = ipc_imem_fast_update_timer_cb;
+	hrtimer_setup(&ipc_imem->fast_update_timer, ipc_imem_fast_update_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
-	hrtimer_init(&ipc_imem->td_alloc_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->td_alloc_timer.function = ipc_imem_td_alloc_timer_cb;
+	hrtimer_setup(&ipc_imem->td_alloc_timer, ipc_imem_td_alloc_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
-	hrtimer_init(&ipc_imem->adb_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ipc_imem->adb_timer.function = ipc_imem_adb_timer_cb;
+	hrtimer_setup(&ipc_imem->adb_timer, ipc_imem_adb_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	if (ipc_imem_config(ipc_imem)) {
 		dev_err(ipc_imem->dev, "failed to initialize the imem");

