Return-Path: <linux-tip-commits+bounces-6199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD91B11C6E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFF57B9FB3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A592E62A4;
	Fri, 25 Jul 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+DWoO7v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPy6yI6u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170F2E5412;
	Fri, 25 Jul 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439507; cv=none; b=QVkaIOp1QHwRxX5CceYo2IPw0F64o4t0jlKeeUPUqmCJaAM89Gx8/zYFblcXPhgDco/mioWrlWgFmuBu7YZsGvk1JD68uEf2Z+6fzSG51b9InOmsbvS/M5h893BUTPdYyLzhIFx6ktfk9vSd0HIVJf9PdcU82qHTqEajjD28tPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439507; c=relaxed/simple;
	bh=/TDq1uxFeA0mBIQFB2fiz66rYZel/rasLlffT8mFClY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vFvZlCkK+krC35wdGCN5R581hyK3vtmo8i1aTtBTTQbnkM26Kato7nYwrzQGqxCkkNHdHTyQL1i52lyimkz8QMVj7YslyGOc5eq2R+TsUC2581iyNQsdjYWktHHmJh5NFVHRQji6ahlP679i5xVXAfhEX5PCJ2QUvZCpPLXufeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+DWoO7v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPy6yI6u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBB021Co1sLxRXsr3URJJ6/oHIEQlTWVb1pSlEBGdNc=;
	b=L+DWoO7v9DQszEWCnYr4aoWbMkVYGPFMhZf4METyAs/OncRsE3GX6tFqS0Jrou0t1GPVq4
	XGepmKhxcUttMnHOvhU6IbfnPZz70p7xrsXXBlYB+eh+sl0fKMTzPdJNCbKtmTxG1KD/Yu
	pCbOjn4YRT/OEhjLu9InINRWof9SNZg7oTvnGg+hxbXOQxsOHJMm0XpEqqEyrX7n3xilS9
	UGzRiw+XCYPdAgOAKfyuJTqtv5cOVWYsD2H9zPhdHyFK3T6iAKaFcq7/Ph4Yl1dFtDM5Ih
	VcmSVcD9dS+RmUpWUnj/2QpSqFGn21Syygjc2YPsp6Lwi5qZmSkyWr7VoFlJrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBB021Co1sLxRXsr3URJJ6/oHIEQlTWVb1pSlEBGdNc=;
	b=ZPy6yI6uFPZpsE/rooNWQ8X+YwbnTw2SblbrK80LI9MikduaHpW1OC7tMMkpbNDmBU2Az/
	gRy8+0O65pEzqbBQ==
From: "tip-bot2 for Will McVicker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] arm64: exynos: Drop select CLKSRC_EXYNOS_MCT
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Youngmin Nam <youngmin.nam@samsung.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-7-willmcvicker@google.com>
References: <20250620181719.1399856-7-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949906.1420.4252791083310025228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     2798e90b4e095940e3736312499a0fb562f3ee60
Gitweb:        https://git.kernel.org/tip/2798e90b4e095940e3736312499a0fb562f=
3ee60
Author:        Will McVicker <willmcvicker@google.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:09 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:06:22 +02:00

arm64: exynos: Drop select CLKSRC_EXYNOS_MCT

Since the Exynos MCT driver can be built as a module for some Arm64 SoCs
like gs101, drop force-selecting it as a built-in driver by ARCH_EXYNOS
and instead depend on `default y if ARCH_EXYNOS` to select it
automatically. This allows platforms like Android to build the driver as
a module if desired.

Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-7-willmcvicker@google.=
com
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

