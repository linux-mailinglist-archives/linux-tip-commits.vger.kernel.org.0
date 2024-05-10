Return-Path: <linux-tip-commits+bounces-1252-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947838C22D8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 13:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE21F221A0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878516E870;
	Fri, 10 May 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rl+eRDW+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BzCu77xi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E616D4CE;
	Fri, 10 May 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339459; cv=none; b=dFOj9hxNL/mX2CAJS00OhUojSSpVIQvcOmOWyeBGS50M3UGuUybd4h0q5kBbcZYwdoYIgqIdk+dO1AduTKsY1mIhxxp68Xqmz25eXJTreKg9d+SaNzVcVPApBVoR+o0p2xqXqf94wBYJuBOyOa/kE+OT/7RWNj6Aohwu5Py2uIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339459; c=relaxed/simple;
	bh=9gTWzmt1z4GD+jm/pZ50mbT4PBlMbw6qc3rQyCSAAA0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=inzVfGTspt12Cb5BoW3jsqvflaOtWqSBP+CdtNGAYNcHW7WC5021MJc9EMiu5vMxAfanevCa1mqksJk+5S38hk7BC0yzGG+BcA+DEFMAW41Sd+4GLVtXIh6m59bUcJ41i2ju7t5GrPn5JyJ7YmsHLRbPw5D70Cnam9wjFgc7WJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rl+eRDW+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BzCu77xi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 11:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715339455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=To+nEpF1B7iGXMF1FT6e20YCqgeRYFMcq4UkcTtNKTk=;
	b=Rl+eRDW+YLO6x5csAJTb7vh8tBd6B7ncQUA0HmBXrGx1vDX5r6p6TVrQw6A9vSI052JuZO
	HoDrha2oGk/m/LxF8CXOqCniWrswkwFM0oqgWjZuRFQCPS5D+MBDDuMM1hT2uClZ0r7cUp
	jtPzrKheVrzvlh7AaQ/7O4gysAV7dYnNo3ke8zKiNCN08qEch/3fQZ9c4s7qr+R7wuJFHX
	a9fMDrGz1QHh+XlGzTLqX0/z/AS2O47wm9DeQDASMHuCbYC4yew6slj9lk2YYNQMS6tWkh
	CSy0cQbZMQH9OpkJW8zTcUBN0/vzmL/xrjQ7EAPJkaITwzkIf2jVIPExP0lPow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715339455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=To+nEpF1B7iGXMF1FT6e20YCqgeRYFMcq4UkcTtNKTk=;
	b=BzCu77xiLOkTn0F0F12PqLVd1/NijeFln1TABfzTp0JAhaYeS+fRu5qy6O96eZqpeD0rZo
	0VKtqqf01YvYgfCw==
From: "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Mark
 hisi_161010101_oem_info const
Cc: dann frazier <dann.frazier@canonical.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <swboyd@chromium.org>,
 Hanjun Guo <guohanjun@huawei.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502233447.420888-1-swboyd@chromium.org>
References: <20240502233447.420888-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171533945522.10875.14417926141466251581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2030a7e11f161b4067bd4eadd984cdb36446fcca
Gitweb:        https://git.kernel.org/tip/2030a7e11f161b4067bd4eadd984cdb36446fcca
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Thu, 02 May 2024 16:34:46 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 10 May 2024 10:43:21 +02:00

clocksource/drivers/arm_arch_timer: Mark hisi_161010101_oem_info const

This isn't modified at runtime. Mark it const so it can move to
read-only data.

Cc: dann frazier <dann.frazier@canonical.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240502233447.420888-1-swboyd@chromium.org
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 8d4a520..5bb43cc 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -331,7 +331,7 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 	return __hisi_161010101_read_reg(cntvct_el0);
 }
 
-static struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
+static const struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
 	/*
 	 * Note that trailing spaces are required to properly match
 	 * the OEM table information.

