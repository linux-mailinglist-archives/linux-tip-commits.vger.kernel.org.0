Return-Path: <linux-tip-commits+bounces-2654-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52C9B6D5E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBA0B219FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930AF1D1730;
	Wed, 30 Oct 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYbEgFhm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AL8e22MQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15421D07A2;
	Wed, 30 Oct 2024 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319216; cv=none; b=sdOQoLU+9RQiMqMVbO1DWmZFnWtPzI52ULDBU1c3sp65+SAuT5q/FMAtaJhYfVKCi+9nErVtccaWHlUn0xIVnpCaVIYipdnuxLJE/cNafcK2ckqD0+Paqjwj86813EGV45FqAlOXvm1wAPaEhXjfAZY8GlNRryuBqJPNKSaRAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319216; c=relaxed/simple;
	bh=002XoF5KLAvt3Qzm0G0Y+csmzjVP9Y26aDZDB1z1w4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OY7HxvSiI56ZdtgedG9FtnKYf3aPyHsHm9rXzZpLv3RIA9lXSFkkMjPe8HkAxprRnSt91bb1MGtwgYSsujwsrSKrFdas12iiybM8uCst+kR+ovDUqTR0+r2l+eEKwjh5lnVsonqGOSj7PCNjdOHhFLG+wGXwyxTDLx8cqshj1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYbEgFhm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AL8e22MQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/jK/BRzMTsZxLsS8ewmt+Bj/+5/KCpv4kmmfUnPD8Q=;
	b=IYbEgFhmaiqdZBVeybT4ZKmMrLCkwljMfa3EWB198Oj72wc+N7qSncq18CiLd8Il7PQuBf
	fIO62/fjAO3qQkQDK1yTqlo1UbiA7NIDyxoopaPmxI5wc/dWiuQbGFcduIcMDLAMtvbGd9
	BAR6LiM9yQXAYbdvUZNyIMgQtdwg0MWCvNrFJaUfMGJMFf+I+b0psyvM26HLALv9/pHXYF
	X6Q+SoP5vya/U04UDihfoU0yvewoRYcGsFPV90R7eMfph8UxXvSuTD92LVqW9DIgCQPto5
	NAr4w+/JEDd3qeniZH2Bd1mufvxG7DXZ07a4qzUDdj3RxrsYpnbo3ppvYEi0uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/jK/BRzMTsZxLsS8ewmt+Bj/+5/KCpv4kmmfUnPD8Q=;
	b=AL8e22MQm4zwYyG9yeG2b2BK/Hx7SxRA7YLoXlZVAd47alfoOIB7gRvc4KUpY5wz3lG5AX
	Z0y06ekXIjb2oxCQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-tegra: Remove
 clockevents shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-11-frederic@kernel.org>
References: <20241029125451.54574-11-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031921086.3137.5903483309455209574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     875cf0b1f0eb4fcd9007a0ac0891125d2ce9766b
Gitweb:        https://git.kernel.org/tip/875cf0b1f0eb4fcd9007a0ac0891125d2ce9766b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:22 +01:00

clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-11-frederic@kernel.org

---
 drivers/clocksource/timer-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index e9635c2..35b6ce9 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -158,7 +158,6 @@ static int tegra_timer_stop(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
-	to->clkevt.set_state_shutdown(&to->clkevt);
 	disable_irq_nosync(to->clkevt.irq);
 
 	return 0;

