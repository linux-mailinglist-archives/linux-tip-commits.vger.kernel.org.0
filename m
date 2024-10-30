Return-Path: <linux-tip-commits+bounces-2659-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CC9B6D67
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D231C21DD9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91A21501F;
	Wed, 30 Oct 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pfqd0121";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXJuZbmo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E641E1C1C;
	Wed, 30 Oct 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319219; cv=none; b=u9ZPoQnNCKhAAg0WfCGh5kZdIQMMVSri8CzkHUTGelTfLbtNpvrasx+HtK6MHLZS75NhfzaVQc3XD9gHiVHxX66dl9rtvAx0OziRsWUDWP8/ix6NI0x+cgK0L25pDvolxcUl9Hk2/zz4QA5S0PIdkG9swu70tloMESnSgPu/hZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319219; c=relaxed/simple;
	bh=SKbSGFxlqq569AnCOu7SoNZcpkJIHfv8T0wC7cozAmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mhtXzT3A5Dq3Jw/XrWiHGlCWo2kM2ycSZenIZUeIKY98YAMW7/rGtpPatVCw2IDh9/dmHJCvf0Q68/81MgWsjaR2lDEgmNGryavUFBN2gmyut0QoXp/SKfKNmLgIrjJs9GK7ujvRxUuQoDArvwmZ0DJVEFgluRZ4QYPCeS6x6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pfqd0121; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXJuZbmo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9EXibJuvY9GgzJjo4n1x2HOyGphZiU/HvbXv3wTOvc=;
	b=Pfqd0121tngGkePLQmAKvsYOpZyIESQS/GpeGhUHw0JQYsd0GRG7M0oB7cpbFN5sLoIHU5
	tiZPInhDlHrC+tfwkKO9EMggB+9d6S4rpLev9LKwKWZFttXtIWSydbVAE0vXfmLgz6Dh7a
	V+sRY5UayVSgRSx/AVkFcpGZTW1V45tX7pwPDgA/pLoBjO1CfWjryqldCZWbed9EizDLIT
	iV2ulfVAOskhUPBLNhKeR992XWDMVyAEJcY8GsSH0G1CzpKWEF4bOIB87b7uoFrN/Re7eK
	PRSEG2bKb/PMwV38kvbedHDpnUtGN0FKzWIRbxk0En3rB/V8PsS5mm8uw3jH7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9EXibJuvY9GgzJjo4n1x2HOyGphZiU/HvbXv3wTOvc=;
	b=MXJuZbmobd39p6P2ZOkdk50xQ5z2MinORfO2uvg29PsJRSY4pwi5Um0VRsuedbpHyKMf5M
	BEjlM/eYUSutdyDQ==
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
Message-ID: <173031921427.3137.351270012287274591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5f2fa3a59a715ccd7dfe041fe99d21bd504dd4f9
Gitweb:        https://git.kernel.org/tip/5f2fa3a59a715ccd7dfe041fe99d21bd504dd4f9
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:22 +01:00

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

