Return-Path: <linux-tip-commits+bounces-5880-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97189AE2A49
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Jun 2025 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32561171FD0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Jun 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAF114A62B;
	Sat, 21 Jun 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M5EkpPNL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1xDO2Ua"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266319BBC;
	Sat, 21 Jun 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750523006; cv=none; b=gjTh+mf6Rh0yus62l8QGC5oYyds0M4wjZePYrfnyWV+1VFnrytcyT8a6tUE79iuqd8WPXtS2ZD5Oos1a9d6LB3z187nKJE0VYRK3h7PpPWUu/Va+OA8S2lZHVw4zTpPQIvUG7FVm+p/aStOmXXHLtWmn1ZVe6Oxte30N/tmBjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750523006; c=relaxed/simple;
	bh=WB1nStiz+B1oko4C3hYJUaedCDpytgQex/IhUk2nRrI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rXi8/gmmEsQitMMTeT9bMpN07ejH+Y7rmtC139NuEewYU20CVjsfDM8v4/XtqTbnYAySSR1D+1lblyPzaIb2QpT6eoo+WGHVei0tZb3CyneF0JL/EaC7LWuJAyceAQ5RzlDW0doHW+u/4l0AFUlJdU+l+a6JLw1eDx0CYKqAGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M5EkpPNL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1xDO2Ua; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 21 Jun 2025 16:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750523002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEKLPjakLvDWMUf3G/xeHfCAtz8WHESqBsDCqmStx6I=;
	b=M5EkpPNLnx7td8yNAhql3R6ogrfVFjlllXrFmsfMdi94G+9r6j9qNak84y1vyR6D+eJWlD
	Qulft+A3Lh0l5oVgk431KJ0O6a7O58H/ISGgEYwOztvaxu1t4V0imjKi8J16Iw6/fgZsNy
	82e9Xp2XyNAhAJx9t+v9MPN9KhdEAfwt+QsxSi38eLWW5zMifx0/ydK3YMpmQ1OEWHuGQz
	CWZ41ux7mpMtP01B84rL5abmmrbqQWZSUrp5v7fheORDie3BFUuyIvaXUKgdfio1yYYJIH
	PgITWYkxl/uYoZbxW53Fd3UlzBnLx9QuR+ONIV7l2xo5eO3HOYeDb4WeNms/rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750523002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEKLPjakLvDWMUf3G/xeHfCAtz8WHESqBsDCqmStx6I=;
	b=o1xDO2Uaw0QGenysFpro4mNZElU3RDZHIYweH64oE1YD8EdL0qJxOm+pFybx6R/FbY01dv
	5TttTN3gxsGmGYCQ==
From: "tip-bot2 for Markus Stockhausen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/mips-gic: Allow forced affinity
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
 Markus Stockhausen <markus.stockhausen@gmx.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250621054952.380374-1-markus.stockhausen@gmx.de>
References: <20250621054952.380374-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175052300141.406.12227606749602048237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     2250db8628a0d8293ad2e0671138b848a185fba1
Gitweb:        https://git.kernel.org/tip/2250db8628a0d8293ad2e0671138b848a185fba1
Author:        Markus Stockhausen <markus.stockhausen@gmx.de>
AuthorDate:    Sat, 21 Jun 2025 01:49:51 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Jun 2025 18:20:54 +02:00

irqchip/mips-gic: Allow forced affinity

Devices of the Realtek MIPS Otto platform use the official rtl-otto-timer
as clock event generator and CPU clocksource. It is registered for each CPU
startup via cpuhp_setup_state() and forces the affinity of the clockevent
interrupts to the appropriate CPU via irq_force_affinity().

On the "smaller" devices with a vendor specific interrupt controller
(supported by irq-realtek-rtl) the registration works fine. The "larger"
RTL931x series is based on a MIPS interAptiv dual core with a MIPS GIC
controller. Interrupt routing setup is cancelled because gic_set_affinity()
does not accept the current (not yet online) CPU as a target.

Relax the checks by evaluating the force parameter that is provided for
exactly this purpose like in other drivers. With this the affinity can be
set as follows:

 - force = false: allow to set affinity to any online cpu
 - force = true:  allow to set affinity to any cpu

Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250621054952.380374-1-markus.stockhausen@gmx.de

---
 drivers/irqchip/irq-mips-gic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 34e8d09..19a57c5 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -375,9 +375,13 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	/*
 	 * The GIC specifies that we can only route an interrupt to one VP(E),
 	 * ie. CPU in Linux parlance, at a time. Therefore we always route to
-	 * the first online CPU in the mask.
+	 * the first forced or online CPU in the mask.
 	 */
-	cpu = cpumask_first_and(cpumask, cpu_online_mask);
+	if (force)
+		cpu = cpumask_first(cpumask);
+	else
+		cpu = cpumask_first_and(cpumask, cpu_online_mask);
+
 	if (cpu >= NR_CPUS)
 		return -EINVAL;
 

