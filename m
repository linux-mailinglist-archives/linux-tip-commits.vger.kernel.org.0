Return-Path: <linux-tip-commits+bounces-2201-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDC96FBA4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553541C20D2A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18F51DA0E1;
	Fri,  6 Sep 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNoK+US1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6InNcb6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218811D79BB;
	Fri,  6 Sep 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649022; cv=none; b=eF4xohiusibTkFkCdZXKQ+z8CD/bNi5EqUdcCAZDYRiOs0W4T0jmKCRv7iHMqKW7zqy7uYGA+OvhrFVG9rPNNHSOTwwKlttUZyJpbIcKWAvQuXUdMYAP1yiJT2uBzvhemoEK6boSRNJUjBE4N3rYuHwvg6FYmocVTKaEATcfLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649022; c=relaxed/simple;
	bh=+uN26ve36bJde/4xi8eGV5dCfXhrVleP7wL4SdchjBI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JLdYmUxXokT1n9KqyM2CqRwL0sSCCem7JWx1cQsoqUmN8fzy4ZgJt1YvVhQKZzBMfth3pTQ1FCuHoINlxB1n+0YaMfWtHJg0vvTEbzLCD4vVn7vVta30GLwd5+hD2o6O7HilfjGcLs2k1Q37db7phnrOovD3nydPFuOLqX2R1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNoK+US1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E6InNcb6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBI/NXFKpxOjiKnDDYrOzvW7b/Yv6+1qxjgcGikML5Q=;
	b=aNoK+US1pXukPFl3zfx3OkuWXj8uD4L2nwsdraX3skblZ8ayRkeVr+h3YNKyWTqGkB8KPs
	l9AZWsowp8RERKUqxxr2GnkURt7LWlUqknjJw8kzrOvvPS/TTR6EjLym9+oZ0AFWYIsi2w
	np59CRVh4/5QnZxloT6rAEG8AAGU8hOLP+3z8F2Yy2f0luA5xypm38ZVsScq/ZXYSZgtNY
	0adIBdFs+TmIiMp06+2eqOsDWmfolsbOChluII6tDmP7iARA0Z61HIYYOPvGQr7wvPwQBF
	PHY5FwEwHgbgwQCWpjUYWtzgTrLWmwKaa/IS1rjYY519HwH+a0y18i3PC8KDaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBI/NXFKpxOjiKnDDYrOzvW7b/Yv6+1qxjgcGikML5Q=;
	b=E6InNcb6G3eq7tyzHfzoySrFUlB4B4YLV5lmJ5nOyOeVHD5TPQrXYEagw+RbgJ80gYRhmz
	W+HOaHAQ4rVBDCCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.12-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <6054852d-975f-4e83-850e-815f263a40c5@linaro.org>
References: <6054852d-975f-4e83-850e-815f263a40c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901839.2215.17141147561988743914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d7b01b81bd2dad578642be6e47c1609f0ba6b7d1
Gitweb:        https://git.kernel.org/tip/d7b01b81bd2dad578642be6e47c1609f0ba6b7d1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 06 Sep 2024 20:50:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Sep 2024 20:50:43 +02:00

Merge tag 'timers-v6.12-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clockevent/clocksource updates from Daniel Lezcano:

  - Add the DT binding for the rk3576 compatible (Detlev Casanova)

  - Use for_each_available_child_of_node_scoped() to remove the
    of_node_put() calls in the loop (Zhang Zekun)

  - Add the ability to register external callbacks for suspend/resume on
    ACPI PM driver and enable to turn it off when suspended (Marek
    Maslanka)

  - Use the devm_clk_get_enabled() variant on the ingenic timer (Huan
    Yang)

  - Add missing iounmap() on errors in msm_dt_timer_init() (Ankit
    Agrawal)

  - Add missing clk_disable_unprepare() in init routine error code path
    on the asm9260 and the cadence_ttc timers (Gaosheng Cui)

  - Use request_percpu_irq() instead of request_irq() in order to fix a
    wrong address space access reported by sparse (Uros Bizjak)

  - Fix comment format for the pmc_core_acpi_pm_timer_suspend_resume()
    function (Marek Maslanka)

Link: https://lore.kernel.org/all/6054852d-975f-4e83-850e-815f263a40c5@linaro.org
---

