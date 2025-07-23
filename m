Return-Path: <linux-tip-commits+bounces-6170-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BCFB0EBA3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BAA7B5365
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52A42749D5;
	Wed, 23 Jul 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzFrOWtw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="np5m8I0b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F827465C;
	Wed, 23 Jul 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255049; cv=none; b=EZkjXRAjwK2bcgtnxrfGjomNenzDtOpSM9wCtVQkmdvONf4/e3DAHwf7PcEhhlqTZqdOZb+ezuLtXz1GVD3l/cfL5r1LQ4S5G31S9lYV7ggErpBYGHzk4h4vIrfOrVbQyHhGgOHb8J2or8wPurCRKiZZ5hTlQlI82vtoWKMeTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255049; c=relaxed/simple;
	bh=ZzQKlOQvPsQCZh+5m1Cdua17+6qN3dYVhwwNy+dm8d4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bR4vZa94hc0ZT4KeBSrDkgC4JFcQfhbPYrxannyRVYpZEp8u/WyiXqhwSt3DlyKDntP3NAh1qrUi6aErmyvT1LgbTRp2rC8tE1tdVLBiE5zV8XyYd7VzR8Y+W+jsazOS50UNHz99egxlZNCil9Q7wU8vDbxMtEjZxFuzaHiYV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzFrOWtw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=np5m8I0b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nH5X8d5tzEZ6p9quQRtDFVJJq6YCXgqRXvBd1/WAsHE=;
	b=yzFrOWtwcPVSkNdShaS3rDp3Mv/lKcXWXR7q7mw0bd5C/8UYWLAMIMAZdsrB3F0nIoE28u
	XvFtjpii+Ei6C+XhnC51Z4+lSxy4QqRcxL1+u22Y57Gitgzfs1IJL+1VF4lGtjfMVS0m2i
	TBHEOYfmVjLhFCNvNzhDCzEHSlVgfs3nP8iMITh7qsv4eDZLDJraqSr+RfIJQS/rGhCxpm
	dOLG5xMclI8ZVHWFYUobOMlyS7aK0sVwz9TRT28hvblbfdI7dpx+ZSgX/i5bggp/R3YMuL
	R8L/qD8Q5q8TfCrlOKU1RU5F9jEh7hkADY+Btxz93VRdYyZkyW7LZye3lpZL6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nH5X8d5tzEZ6p9quQRtDFVJJq6YCXgqRXvBd1/WAsHE=;
	b=np5m8I0btG1DR7uPcY7N+U6aAENtYmYOEHvEEiuYOTxXX9Z5R42Cwwh6fTRXqrFJAQr7sl
	eIKmZZ7k/Wm3rqDQ==
From: "tip-bot2 for Will McVicker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] arm64: exynos: Drop select CLKSRC_EXYNOS_MCT
Cc: Youngmin Nam <youngmin.nam@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-7-willmcvicker@google.com>
References: <20250620181719.1399856-7-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504498.1420.13665015784735622458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     aa896540ee8caff1a61431673f53199bbc980d76
Gitweb:        https://git.kernel.org/tip/aa896540ee8caff1a61431673f53199bbc9=
80d76
Author:        Will McVicker <willmcvicker@google.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:09 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:00:51 +02:00

arm64: exynos: Drop select CLKSRC_EXYNOS_MCT

Since the Exynos MCT driver can be built as a module for some Arm64 SoCs
like gs101, drop force-selecting it as a built-in driver by ARCH_EXYNOS
and instead depend on `default y if ARCH_EXYNOS` to select it
automatically. This allows platforms like Android to build the driver as
a module if desired.

Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-7-willmcvicker@google.=
com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a541bb0..46825b0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -109,7 +109,6 @@ config ARCH_BLAIZE
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select PINCTRL

