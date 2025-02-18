Return-Path: <linux-tip-commits+bounces-3423-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB4A39780
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14797A4EFB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D9B2417D3;
	Tue, 18 Feb 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uk9AwzxB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5xYXdUHB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590F1FF7C0;
	Tue, 18 Feb 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872002; cv=none; b=bqUd2huzbXi8CQ0LWbIjwNBBoXcqs4pu8shAX/iJpJlgoa83+N2hCA96I24Uv8QAkwtJyf6JXtDvW4yAmo8UGgmL1EVELbxJ3OiXILIU8K+ZMhLoPeIDjZwyK5QvyNsEZSgt6SQDWi7CqsOO7sRpBq8WHDWFXjwEaenPrZm3rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872002; c=relaxed/simple;
	bh=hJkyKsKT09dc4M+lL1Rzb3kvyGLb0ABPifHydaRVOeI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QPm6MQcjJ2Ved5HWCi9qFRRsLtQpxtLDfS/ML9gJG6NmrPiJwaxAyjkrtgVtzy8aE+/AG1hBTrQeB0DT9cxd/kN4syU1BkLGS2wGvYqbTnVXShP8iH00/yM1HQWHgOkn/gKrA6MVSBBNbiDs9kTVhq26yhNfQbeJ6JM1MOrT8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uk9AwzxB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5xYXdUHB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTN2U8dP1Znbf3mHwPaQjAfmnbjW+zN7xnerl5BPV+Q=;
	b=uk9AwzxB2mq7K64NMcVnsWteyFV1WesoL76w9XrFrkWPc6F5yT0WUzulrLZvD1aXYeIXUh
	EzeW3hdgwuVXlBRKRjlO9Ed+HaCRtJ8/wcRNoWYYl5C2TumhS0663f2/KP55+sCFoThzGO
	ZQ6UcQYeCAhe+UPTwQ/WjFbXXkRhY75HYW1E0nwDYpFd48qE0J2G59TxvLIg2OnbHdGQgJ
	XfX/8qhCunyo0E0GFhuv4Wq2nLwnAZIXNw36YQK2qcTlDf377r9ZcJNfPdBi1lNF2rERHK
	85qVtOEmpEIVrT1u2TTDamWXGfdosc630dUrEfL7Yt4BXxCVU5dP7GkFy+raHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTN2U8dP1Znbf3mHwPaQjAfmnbjW+zN7xnerl5BPV+Q=;
	b=5xYXdUHB3v4aIh8Gx7JtOoVyyoPc5AECz+ysLVb05HvoIyZgEtt5HuBe4dBDgv67Ww8Ts4
	VwgXsKPz3fcr0OCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] s390/ap_bus: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd8a3919c09caa671e64d9f9bbf726aa8a885a844=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd8a3919c09caa671e64d9f9bbf726aa8a885a844=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199887.10177.10354724953508946914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     99fb79f6d6de533d92dc11d53b0a058ac3de8cbc
Gitweb:        https://git.kernel.org/tip/99fb79f6d6de533d92dc11d53b0a058ac3de8cbc
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:32 +01:00

s390/ap_bus: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d8a3919c09caa671e64d9f9bbf726aa8a885a844.1738746821.git.namcao@linutronix.de

---
 drivers/s390/crypto/ap_bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 26e1ea1..62feb2c 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -2326,8 +2326,7 @@ static inline int __init ap_async_init(void)
 	 */
 	if (MACHINE_IS_VM)
 		poll_high_timeout = 1500000;
-	hrtimer_init(&ap_poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ap_poll_timer.function = ap_poll_timeout;
+	hrtimer_setup(&ap_poll_timer, ap_poll_timeout, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 	queue_work(system_long_wq, &ap_scan_bus_work);
 

