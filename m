Return-Path: <linux-tip-commits+bounces-3474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1321A398DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2861881DD1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B42417CC;
	Tue, 18 Feb 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAsdMoFT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwXzZAQO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE623FC68;
	Tue, 18 Feb 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874394; cv=none; b=AQDYJMRKiEvevoqdPMXB0a0EfepfjYB1s66Yz7Lnz7VVg+x7mtZDmGTMusLjpj9NfC/RUrIZUqvY4Nfli7yuMUwA1fAXjoXjX7DWO1xk1ih9dPaqNOuQFfVrwJmYp6VuV4YFU7huboRNRAGIDjXtaNJta3G039KdXbX0RKL/b1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874394; c=relaxed/simple;
	bh=RCDhEjWEafLxjpVJv09ne53kNV/XN/8yUn0PG43cISE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rbZxQpXuKaM2EGMxe8+gY7DvCORGJVEEMIfgFMouWIUAAW+6/8//b5B7RTbu/2cTa6qYKGV/uydcP/ir06/a0ZQIIJjX1ZY3255YJa7g77OD1gsGt84apOK8jqCPS7V3OiKnRIvErhR9VTtSGzSPmznuTupVkW61tR23r2BKwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAsdMoFT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwXzZAQO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mx7s6HEnNPWWs8sb1AXQK21MApsLPEGtTD190uZydto=;
	b=nAsdMoFT38oP9HI6FDQdshQk64lpy2duvGkedEOkDU9JXlqDewD5kXWD9y1WQf7cBqXPFY
	U/T7i6rU+UkxH8nY2bg3Yb0u38Ff6NBZ73lG56Q8SQjEdsnBfV4ocK4JufZktOOT4AQt9s
	54pR7XeSrDucA6bh9d2M/a9QvsNGcEtRNkTjlhr2loS+pCPHcmXNxl8zgrMbmnM9ZX71xS
	gX0y+ys/5U23K7uNV7abDxXMhky4PyiWGJ55soC8GpDjXstPseN+IwfgbsJZiHCruUHzip
	b4OGZNVAuIdA3UvyJkTXLMRANoQDSp9Gq3DpztOg1Buk8KeKlSIsF/eLkLdKZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mx7s6HEnNPWWs8sb1AXQK21MApsLPEGtTD190uZydto=;
	b=XwXzZAQO4s32VpYz3WBAO1I5Aap0SBi8RpXGOTIAnQCFQ1H9NOjsVLzqzydwAkVwUgfjT8
	OrXMDicCSqpmUMCw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] stm class: heartbeat: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc822671342e6ca0437b25f8e24935f09821e389f=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc822671342e6ca0437b25f8e24935f09821e389f=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439076.10177.17971478658593844194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c6be6eafd6200327d6c7952275c042785dccbb96
Gitweb:        https://git.kernel.org/tip/c6be6eafd6200327d6c7952275c042785dccbb96
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:05 +01:00

stm class: heartbeat: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/c822671342e6ca0437b25f8e24935f09821e389f.1738746904.git.namcao@linutronix.de

---
 drivers/hwtracing/stm/heartbeat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index e9496fe..495eb1d 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -81,10 +81,8 @@ static int stm_heartbeat_init(void)
 		stm_heartbeat[i].data.type	= STM_USER;
 		stm_heartbeat[i].data.link	= stm_heartbeat_link;
 		stm_heartbeat[i].data.unlink	= stm_heartbeat_unlink;
-		hrtimer_init(&stm_heartbeat[i].hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_ABS);
-		stm_heartbeat[i].hrtimer.function =
-			stm_heartbeat_hrtimer_handler;
+		hrtimer_setup(&stm_heartbeat[i].hrtimer, stm_heartbeat_hrtimer_handler,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 		ret = stm_source_register_device(NULL, &stm_heartbeat[i].data);
 		if (ret)

