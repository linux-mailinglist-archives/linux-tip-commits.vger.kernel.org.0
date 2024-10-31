Return-Path: <linux-tip-commits+bounces-2668-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D830C9B77FB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1136D1C2543A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A10199945;
	Thu, 31 Oct 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aqx8Clwq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgDjDBH3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157281990AE;
	Thu, 31 Oct 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368280; cv=none; b=N+XS9ry7XiYw6xJHIvoL6+1QAIMEbjtvnEwb1UzLPXWRLx4l4nixhHG9H8fv6jc0Hy+TsGZuGDRsfd9euLUEpwZ1jIIl8aonymxiOgo9bNS0FBdP7b44ezVWwV1OZNIcfl2GwcUMMo6RpMXMqDgEKTw2Ty2BMPrRGAyRA64ps9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368280; c=relaxed/simple;
	bh=F3JtdXZJiYnP93qKa6ySBcANNbKEjDML1AMCRBm6Hdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CfpVvb7k2+yBF/xYqj75wHKdDgFNN4yUYVyB/eBQ6NZ3yee+Ro9TVIx3tXGfrR6NbHg7hV+kUscvzdFJe2+EnMFZePlyd3uPl+wSom/AFEf6ODxmjE1sDzssPwmYYzI4sF5b0v5sXiJAmLSTSIZdaEXxFxlDH8DOB04OVmGcFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aqx8Clwq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgDjDBH3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJfJAzhbtI2zExbfvdUfPwqijlJOr03IMbZKIL2kWsg=;
	b=Aqx8ClwqLc/nzPpHwRcZtnhw1ZZ8XGOG6P+E6NHCV7jFjd0+pqh7HsCZ6dsuM82K47p8e1
	5Sw8XKgVDBhBlaZ0rbepEmTkOFjvRWUPyyZx4hSjbIO/yB7/2g/X5sVujxFeEnEoy5D2pz
	n7Q7+5he4py4ASb85msGsXPm6HW4iinG2/IrXNJ7HzLjlDDAplM5Nc8J94CMCeS7JsjllM
	pv+gPWYn81frG0owmfgmVfq0dhuL+l0CSfvdEtH5OrdOfehQty7/Gfx1lEslyJZMm1QZMU
	zOtS+wLGkC+u0FOE5EqU4zeu/jaQ0RBJzYe74QThTaA0DXfwocGRes0Jnpl+TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJfJAzhbtI2zExbfvdUfPwqijlJOr03IMbZKIL2kWsg=;
	b=qgDjDBH3W4fwVTtP6cQCn+JOpKduh6P8GvsNqXV8efhr2cNc1O9RFsR8UpOFjBRqCKmdPS
	lAwvs0Y+jVEm21Dw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Remove
 clockevents shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-6-frederic@kernel.org>
References: <20241029125451.54574-6-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827589.3137.9491873945744703415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     78b5c2ca5f27534dc04fbbe0b491dd3bd4ec814b
Gitweb:        https://git.kernel.org/tip/78b5c2ca5f27534dc04fbbe0b491dd3bd4ec814b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:42 +01:00

clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-6-frederic@kernel.org

---
 drivers/clocksource/arm_arch_timer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 0373310..2bba81e 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1179,8 +1179,6 @@ static void arch_timer_stop(struct clock_event_device *clk)
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
 		disable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
-
-	clk->set_state_shutdown(clk);
 }
 
 static int arch_timer_dying_cpu(unsigned int cpu)

