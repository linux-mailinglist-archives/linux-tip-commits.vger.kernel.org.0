Return-Path: <linux-tip-commits+bounces-2194-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C784996FB94
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828A4289336
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A871D2780;
	Fri,  6 Sep 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byUUap7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocq2sQeM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1C13C3F2;
	Fri,  6 Sep 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649018; cv=none; b=gc5NgvwEUDrW844IX3y+eyoNT40QA4UTSOXfBcJHQSe+DW4LYlWNtH+LzrQ2B9h6pDMVIvqnQ+qGRKZtgvoyx4Fb3cz7YHmJKDMG9J7MLBtQmgJ7zBrHB+5qfrt2M7hL/mCORqwL9TeOT2ZM+TwVyF2idNSk/P0EPHrNqIew/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649018; c=relaxed/simple;
	bh=Xcs3vT2+0/Ip7euzzVGnOGXAdKzpM4oSp+d+2xxFLdM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hzFRjcdikVC70ufadHjdhO8JjPFTyPzFvVyipqH9JQ6pqCYefMlw+Y87vMssiqjKHnXwZutI5wmi3/PkN7sfMal+3hpthAinuHjPHJZUA8Aons8Ganrxt5DdF9KKGKFzwBR/RQWIuKsHBWGRMsPiMgk0zX7aDdQirYjKGB8HGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byUUap7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocq2sQeM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNpvvOXSvYbCfUWGIRYvhhtA3fNiWFn4SZ4FUCcCjE=;
	b=byUUap7abXQerAHcThfpdhk51RUNhsoHIWpsXJXm8fPppXLjUcT5mIQ5BV1kkiOlhcB757
	CXllcEOSUSjmxYNYuy+6IgCN8a4qQ9uJOxOuA69oli1lVW2Cuwh+oMoxiBa+gI2qFqwNSu
	l2Udj4a0dLu2RocXqppB2QVUQQZX3iP17BxQSpp7avAdVRsmC1iGhtphQn/jKQXYdQBfV5
	w3iUWRMlBIcHQ2eih0jp6iZE1aIs5CZw6dl31zJv0hb1lJo0usw29DUWCHd6erRx+OnZ7P
	iCNl9N6Z4V5uc+dPQuVw8FMwR3hNQoqfecM5HMjoq7pCn2sixT0kY6VsnimxUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNpvvOXSvYbCfUWGIRYvhhtA3fNiWFn4SZ4FUCcCjE=;
	b=ocq2sQeMP3z7nRhXDq5P3sYrloH/JLsUkpcl2UprBnXO8eFxA2vkfls4JH7kQvh94NSNMt
	3AFNIHhUkmXjrDAA==
From: "tip-bot2 for Gaosheng Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/asm9260: Add missing
 clk_disable_unprepare in asm9260_timer_init
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240803064253.331946-2-cuigaosheng1@huawei.com>
References: <20240803064253.331946-2-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901467.2215.5276875950642161569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6cc11b65e5e0a6f1487274d1ad91088f7ac01d18
Gitweb:        https://git.kernel.org/tip/6cc11b65e5e0a6f1487274d1ad91088f7ac01d18
Author:        Gaosheng Cui <cuigaosheng1@huawei.com>
AuthorDate:    Sat, 03 Aug 2024 14:42:52 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:21 +02:00

clocksource/drivers/asm9260: Add missing clk_disable_unprepare in asm9260_timer_init

Add the missing clk_disable_unprepare() before return in
asm9260_timer_init().

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Link: https://lore.kernel.org/r/20240803064253.331946-2-cuigaosheng1@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/asm9260_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 5b39d37..8f97ab0 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -210,6 +210,7 @@ static int __init asm9260_timer_init(struct device_node *np)
 			DRIVER_NAME, &event_dev);
 	if (ret) {
 		pr_err("Failed to setup irq!\n");
+		clk_disable_unprepare(clk);
 		return ret;
 	}
 

