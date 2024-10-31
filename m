Return-Path: <linux-tip-commits+bounces-2666-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE99B77F8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D24FB263CF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739E1991C9;
	Thu, 31 Oct 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1NUV7te";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CYCF3PjU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27924198A0E;
	Thu, 31 Oct 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368279; cv=none; b=qvqtM0TvLHuo/PyjYgP4zk/cM3DLz32bjFGmJrSiq5aHn2e9UJ4oCZj0r6TbGGwN3KPseyW96TZw6Vv2Q5veKYgUl1BXI0UNSmnCi3NUpY6qtSyvxI/wgQQ+g5FsEl8Lu2BGoSZH6oRi+T4Bhn/VdlAHEhpGGJXpuzqxZ/xB6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368279; c=relaxed/simple;
	bh=71iNFi4TfRFFp6DRX4xv+2qvU+st9sGSVQhHWuujb1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NpqB2DWULMzlqaDvaYYfUlsfozpILRRd/YtK47naSyg+8fLu8Ca96I4Kr9pgYM37Rs7HKpFtCH6JoHZYnMErQ4o0qqkCUqL63wyzyGQQ8jVyDSU+auyYv87tiVfEXIvcjtWgBz60a+BjYumeaNRkkKsTV6LBqcaiWa3TvzmlEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X1NUV7te; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CYCF3PjU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn9QcoWwJ61M8xwT77xH15KnI9oXPXB1oHf+IFVGc/0=;
	b=X1NUV7te3L+XU17B/ilNwNeSX02sm+7GqavbVfbrR2B9qYZHS0ebpsencY7tH1Rpouyloc
	7P5cqvKT485Cz+LyuSROOBSNopnyHB+kaXrLhymvzuvpwIGb7Vrq/NZhfjtwqJnB68dR9W
	HPdiGATObT2Xk0sUxb83ywxzp9m+PoF9wG3W3PyHF5nysrt/J63ZcKssqHrNniGvjWs/u7
	Q6n+AnitzDwNI4Y+yFmpGdh8AWAhfy3ie1TLC7BRVtdHemfSroL2IFz8SoRueNJ1rXNbJB
	c2e7FE5ZavCQGtLHKgFgZ5orB6VKnM2+nJ7D+lNoxG5gD3EkYZQDW9Htx7Djhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn9QcoWwJ61M8xwT77xH15KnI9oXPXB1oHf+IFVGc/0=;
	b=CYCF3PjUX2LfozsOzwAnFKSBTWy9NYXEJ8jDCkx70FoJx7sJEkHKCceoFzNSFzi7gzd/6S
	g2Yos7Eryloz6qAw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Remove clockevents
 shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-8-frederic@kernel.org>
References: <20241029125451.54574-8-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827431.3137.9879148425880747844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ba23b6c7f97428dc5dd1898edbae397f1a524b13
Gitweb:        https://git.kernel.org/tip/ba23b6c7f97428dc5dd1898edbae397f1a524b13
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:43 +01:00

clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-8-frederic@kernel.org

---
 drivers/clocksource/exynos_mct.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ef8cb1b..e6a02e3 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -496,7 +496,6 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt = &mevt->evt;
 
-	evt->set_state_shutdown(evt);
 	if (mct_int_type == MCT_INT_SPI) {
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);

