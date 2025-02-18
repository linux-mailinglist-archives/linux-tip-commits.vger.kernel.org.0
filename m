Return-Path: <linux-tip-commits+bounces-3447-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C39A39866
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E8B3B731D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55C23FC66;
	Tue, 18 Feb 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErYjnWLU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6tOg80oU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70623CF07;
	Tue, 18 Feb 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873211; cv=none; b=TxxvPAnwNNU38afKLuREwoCpgzazI8aqImqSHA4fpFpXCJ/nhII+z3a5XBCD8UuN9Ip3QXHonOxMfqgXPuLONuxx4w2xs8OG1jD0iak91/AyAAuoLIwypCKahfnRKx6yrg+gYY6y1v9tpXb8Xin+uZvU8VfQnNEA7wEWPFNMJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873211; c=relaxed/simple;
	bh=ep/WpbuCcwg2lTsUqyAVQNxdDQ6Ex+Ksil75ute7Iiw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ScB9aM/0BLlhzyf8jqZSTAA3vcDFMyH5XgBmbhYoCCZOvwiULC/4VaQFOPc7nO9OC188WURGF0Ko4eCxM7fMoKFqg1e0xx/E9N++5v8xfNikdNI+vcMCqwjTpJyaSVwv8MHUWJM7PSnpCMs9BKmWR2QKAw0WeYkDbWUMPrTH+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErYjnWLU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6tOg80oU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eRW+URybfK6QLl6Hs4FrKZb8fTNFn7NawdBGLCqOME=;
	b=ErYjnWLUQtyEA9L6ehkun9gVI48wK0TKgYnPGS98mTG98xl8v0sMtdTSEpMgQPgqWgwm8o
	VkHFPtjaJzAFH7jkAG1P5kzDma7QB6B/M5I1BmEODk52c40C084BnG10xYfMMe1cwf+UqN
	OFQvbtX0UL5zB8dlB9AQKU4NNHG7tL/eK60aJewFdLN62SHXXT5hYuW/S2wWbDQp+qcNjM
	waP87jXSSOvUtr91Jp1OSKZgs5vDVwviAzXOLuph/p4kV57yDr5MwuvKYlRiRMCJnahCfF
	yg+xm0OKYbQ63f6Dmq2tPfaBxFVs8M1rQK90d0Km3i5GxCFMRw8uNVi/DD+NCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eRW+URybfK6QLl6Hs4FrKZb8fTNFn7NawdBGLCqOME=;
	b=6tOg80oUQFd7yukbFedgHAJwqb/q+0UlYCTUhXxiCUpLUBZ8s1dYhP/NgBhQyM1UXsdbBj
	oJRcFL1ck4Z5L9BQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net: ieee802154: at86rf230: Switch to use
 hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9f701c1b64e248539772aee62e130a7e50bbf1b0=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C9f701c1b64e248539772aee62e130a7e50bbf1b0=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320699.10177.11822261566775118658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     dbf13c4278a5673d8fb6ba87ea81c92b886b3aca
Gitweb:        https://git.kernel.org/tip/dbf13c4278a5673d8fb6ba87ea81c92b886b3aca
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:46 +01:00

net: ieee802154: at86rf230: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/9f701c1b64e248539772aee62e130a7e50bbf1b0.1738746872.git.namcao@linutronix.de

---
 drivers/net/ieee802154/at86rf230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index f632b0c..fd91f8a 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -776,8 +776,8 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp,
 	state->trx.tx_buf = state->buf;
 	state->trx.rx_buf = state->buf;
 	spi_message_add_tail(&state->trx, &state->msg);
-	hrtimer_init(&state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	state->timer.function = at86rf230_async_state_timer;
+	hrtimer_setup(&state->timer, at86rf230_async_state_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
 
 static irqreturn_t at86rf230_isr(int irq, void *data)

