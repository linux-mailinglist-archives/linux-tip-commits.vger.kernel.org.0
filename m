Return-Path: <linux-tip-commits+bounces-5703-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FBABFA70
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBACA264D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211D21885D;
	Wed, 21 May 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gipGWAoS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XJKf/lWG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0991F8EFF;
	Wed, 21 May 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842566; cv=none; b=owPjEpn7+kTRugrPDnchqoP6RO7IplNHtggYPB+boPS5pJfniELnfmHgrAMsCLiKJmIeGOy00B0fURNqfDDLykbOl+148ODc9EXmaOX8HSKO6HZNuJi7p5hQma3tVKJYDEuBGwjU3yXXekNsdzvVtyDTWBAU77Pc6ToAoh1Ob08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842566; c=relaxed/simple;
	bh=ff5l3YYjXXeQRDFFTsFK81ImajiZlt+YlFfxNEOochw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FGt2s7qZams4c0OYR5j+TRwItKQmjPPXCSn3lgL+niVYogAmulLBnWgrNSr3lOpfgYdY6M0gD2kSw73rUt/Wa3pFq0NkvChf+Ebi0LETY0KUiZM0+gxlR9SZaSnzoHjBWMf/WOlCA4eUa1EeXCgU65lzdqxzK3e/jkPI0gi4OTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gipGWAoS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XJKf/lWG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9uM7YEAtHJfVeiKuWGsOV//vbcvCy50yn0+3SnHqcE=;
	b=gipGWAoSC1w3J6oT/6YofRZBdiU1/AR/PMflkJKOuQrw2Z817Z641V25qTvGHNEtgiG4He
	/yCWKpabEJCK8+doJcw50Ua/QdSGoZBAzsETTqgt19a3+DJGhfTZz1I/ODxu1ATIelOS2k
	26oysaT9YNTFXvQlC/3goatdE+JQv9ZdWZeTzndvDEBca9UOYADagr3g/i9KeHgKnxK4rl
	G4UdROSQLxLTn6W3XjPEVEptd1RQrmsuSDXRPiZeW2HDiJGvMo11A/kt8GKyNNhA0GLLpi
	p7eyy5Ta7sLgX+dLZBQF+MoE5h90LvTY04MKnqaWCpmN0cXWr+GvfJHCUQUwZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9uM7YEAtHJfVeiKuWGsOV//vbcvCy50yn0+3SnHqcE=;
	b=XJKf/lWG+HMKYEjhvrdWnmuZamrbPTq3a2lGIomWqyJmeZHZywv2JEsl6B/1PHiyJumMIb
	qZmxafQ1IkAc7OAw==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/renesas-ostm:
 Unconditionally enable reprobe support
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515182207.329176-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250515182207.329176-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256163.406.11930790244350634592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     d204e391a0d83d73fc312e71fc62896c4d8bae79
Gitweb:        https://git.kernel.org/tip/d204e391a0d83d73fc312e71fc62896c4d8bae79
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 15 May 2025 19:22:07 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 13:33:11 +02:00

clocksource/drivers/renesas-ostm: Unconditionally enable reprobe support

Previously, the OSTM driver's platform probe path was only enabled for
selected SoCs (e.g., RZ/G2L and RZ/V2H) due to issues on RZ/Ax (ARM32)
SoCs, which encountered IRQ conflicts like:

    /soc/timer@e803b000: used for clock events
    genirq: Flags mismatch irq 16. 00215201 (timer@e803c000) vs. 00215201 (timer@e803c000)
    Failed to request irq 16 for /soc/timer@e803c000
    renesas_ostm e803c000.timer: probe with driver renesas_ostm failed with error -16

These issues have since been resolved by commit 37385c0772a4
("clocksource/drivers/renesas-ostm: Avoid reprobe after successful early
probe"), which prevents reprobe on successfully initialized early timers.

With this fix in place, there is no longer a need to restrict platform
probing based on SoC-specific configs. This change unconditionally enables
reprobe support for all SoCs, simplifying the logic and avoiding the need
to update the configuration for every new Renesas SoC with OSTM.

Additionally, the `ostm_of_table` is now marked with `__maybe_unused` to
fix a build warning when `CONFIG_OF` is disabled.

RZ/A1 and RZ/A2 remain unaffected with this change.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250515182207.329176-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/renesas-ostm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 3fcbd02..2089aea 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -225,7 +225,6 @@ err_free:
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
 
-#if defined(CONFIG_ARCH_RZG2L) || defined(CONFIG_ARCH_R9A09G057)
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -233,7 +232,7 @@ static int __init ostm_probe(struct platform_device *pdev)
 	return ostm_init(dev->of_node);
 }
 
-static const struct of_device_id ostm_of_table[] = {
+static const struct of_device_id __maybe_unused ostm_of_table[] = {
 	{ .compatible = "renesas,ostm", },
 	{ /* sentinel */ }
 };
@@ -246,4 +245,3 @@ static struct platform_driver ostm_device_driver = {
 	},
 };
 builtin_platform_driver_probe(ostm_device_driver, ostm_probe);
-#endif

