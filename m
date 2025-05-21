Return-Path: <linux-tip-commits+bounces-5731-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24866ABFAAD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1342E9E7A93
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D835F280001;
	Wed, 21 May 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W6e7R2G3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2vbeB//"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221CE27584F;
	Wed, 21 May 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842588; cv=none; b=DKeu5B2aIh4XQT40Za2+7UM82GjptK7Bwe5MMkwLIxp1eCLDwL6QoMnpLi1waj6V67h/dRH8Lu33QcEYeAgA5GCLKyJeE+IXjen/g2Pc/2doDy2hLfAZUP2JkO8mEFHRMKmbvfOfJS0ExT8ZDqDuEvvg79D41qOyNbG0wbC3Z0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842588; c=relaxed/simple;
	bh=bs8d5/4Cdzb2eqEflKfBmAdbYnWAKQlC53mlnQiE2xo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OfTnf7L19sJiCh2CuYeOKMm0z5Gx+5IkyPeatE2zBupQiBEBDfvMMntB7yebIFPLamCMNpb6OH8VnASDN6WZm/4JXFQSCVUkOZzSHrfRG6cGnxV9HBD/k75cudBX4Sbn66T8jjc84sCkDBvcY2QkJbseD9UZs3N1VDlle8VeZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W6e7R2G3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2vbeB//; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qL+D+Z2tktdPi5YNiFx0Zq08nQCwQxp3+jjmarJxAUQ=;
	b=W6e7R2G3u2HJhOqQH7mFwDol5VBgmk5wUmprqw7EfrQebizu9TUmTxGr6BiuMBFxABoLkY
	hMSWyGxvdlK2g0ym3Z3+GwxKPzBjhL103AAeVhFSaJ7I4nvovXSMFsoLDPKbo/E93tdGAN
	bbMKm6b5v/MVI3WdvFbqDuonLqySD2d+8gmNILUn3kjF33Eg6lS0XZtHGOh2QE6W9daprG
	aM7Hjnq/biC85MxZG9mBbBNBdTJtjTm+tJtOC7msjmzX3qVmEkx33xqKfrK0PHTr42Czu+
	8MtioLKqM94W6Ao8VVjLDVFC6Wvy8J1A2JkOoQqF7J9TPgKgN2P57HARx4CmrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qL+D+Z2tktdPi5YNiFx0Zq08nQCwQxp3+jjmarJxAUQ=;
	b=N2vbeB//aNvyi9+pikvV/F39hYOlEhRwryS78rNNOgfhW95cAo5zTk8k786r3DRtnvPE0I
	E+X3P3jqgr01d+Aw==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/atmel_tcb: Fix kconfig
 dependency
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409155313.1096915-1-arnd@kernel.org>
References: <20250409155313.1096915-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258417.406.8798688138719774746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     b8239054194ad67aff7d244185ef46890c5ae71a
Gitweb:        https://git.kernel.org/tip/b8239054194ad67aff7d244185ef46890c5ae71a
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 09 Apr 2025 17:53:08 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:32 +02:00

clocksource/drivers/atmel_tcb: Fix kconfig dependency

Build-testing this driver on arm without CONFIG_OF produces a warning:

drivers/clocksource/timer-atmel-tcb.c:368:34: error: 'atmel_tcb_of_match' defined but not used [-Werror=unused-const-variable=]
  368 | static const struct of_device_id atmel_tcb_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~~~

Change the dependency to require CONFIG_OF for build testing to
avoid the warning. Testing remains possible on all architectures
as CONFIG_OF is user-selectable.

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250409155313.1096915-1-arnd@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 2861b2c..3b63a28 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -437,8 +437,8 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on ARM && HAS_IOMEM
-	select TIMER_OF if OF
+	depends on ARM && OF && HAS_IOMEM
+	select TIMER_OF
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
 

