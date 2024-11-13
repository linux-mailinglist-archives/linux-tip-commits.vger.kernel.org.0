Return-Path: <linux-tip-commits+bounces-2848-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA19C7CC5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13694B24D02
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF9620125C;
	Wed, 13 Nov 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HktOIzxC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8r9fRHEm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C751662E4;
	Wed, 13 Nov 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529251; cv=none; b=W/dpnd8azetTT5q+XErG2wQH0B9wyCTx2NZlyVGUsXd4cMtR+wXKJ3yZA/kFuo+W3lgcfIdr8kueUUALpZC4bjv68JIVWJ9iEEn3b7d4LU0dveAqaVlBOE705xJp58XrZVKieXH6qoTuzLSf5bqY+AOlcqCRQGw0ntChqgQYBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529251; c=relaxed/simple;
	bh=N/cGFWtSP8U98/MudMoZAWHAcKM22Rc0zCD6BRLirnA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eR+uTZ1Enw11uBxME6e3kPjhoP1t6SZLoLmhFTHk5kotgMOr2s264xBRYyymRDhO5/bOwhl/BBW5J4KkG91QRsPLT3619jUimCp/9EHtjHPCKH7M2Uzn3M/kU8BL3eqBJ4EhUUhhTB1oKBOasJgQ3MrOu0YVe0YX676pcMbptNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HktOIzxC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8r9fRHEm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIWixiUsHMo5Nfplx7oL6i+vigAfDbbfVzhq+GeEQYY=;
	b=HktOIzxCK2G+ym7vhpZQj61KfUdpmIUL/+bVePjprgHZCLvU7+1c+K4YUFNa9+sWyBn1qT
	jl/UFPXyoBdW+BUukvq/k1rQNLJhjT198oyvCmezJPdNY+/FVKKwQig6n5AL1w81mfXtNA
	Ar86YpgRTgCb3/ZdzoD3DtpYJTZbCx60JMfH7a7isKUhi1x8QfygKVZMHT5u3FjFUksz9g
	eZLQPVxC4DOV9MlBQBlhaF5vmWEuwrhoPXqzsbCbpEuBV+tZsispHjjlVBmz7eraqbsRWm
	ndGKdSGGKNUj+iMWp9UF4VtrZUwnJsNre8oWL7SNxVfa12dGroVFO8+uFDnNsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIWixiUsHMo5Nfplx7oL6i+vigAfDbbfVzhq+GeEQYY=;
	b=8r9fRHEmrfG79f3EVvbswZ0kRutUGh30C61UoPrzXUW+Rl6CPNzQ1wPehIDcoflQHgwe73
	mmdENiGa9dluFpCg==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Use
 of_property_present() for non-boolean properties
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104190505.272805-2-robh@kernel.org>
References: <20241104190505.272805-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152924640.32228.12020231350175694142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     08b97fbd13de79744b31d2b3c8a0ab1a409b94fa
Gitweb:        https://git.kernel.org/tip/08b97fbd13de79744b31d2b3c8a0ab1a409b94fa
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 04 Nov 2024 13:05:06 -06:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers/arm_arch_timer: Use of_property_present() for non-boolean properties

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20241104190505.272805-2-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c       | 2 +-
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2bba81e..808f259 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1428,7 +1428,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	has_names = of_property_read_bool(np, "interrupt-names");
+	has_names = of_property_present(np, "interrupt-names");
 
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++) {
 		if (has_names)
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index d1c144d..985a6d0 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -202,10 +202,10 @@ static bool __init dmtimer_is_preferred(struct device_node *np)
 
 	/* Secure gptimer12 is always clocked with a fixed source */
 	if (!of_property_read_bool(np, "ti,timer-secure")) {
-		if (!of_property_read_bool(np, "assigned-clocks"))
+		if (!of_property_present(np, "assigned-clocks"))
 			return false;
 
-		if (!of_property_read_bool(np, "assigned-clock-parents"))
+		if (!of_property_present(np, "assigned-clock-parents"))
 			return false;
 	}
 

