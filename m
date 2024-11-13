Return-Path: <linux-tip-commits+bounces-2855-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1779C7CCF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4416B1F223F5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BE20BB26;
	Wed, 13 Nov 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="llFF9AvD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FkOtSiMB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0A20899A;
	Wed, 13 Nov 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529256; cv=none; b=aVhqObPpzKbdIbsi5v+epWHQNfY3ISsnIhVHFdi0xj1pW/SiKP+4PhzYaplXqlSn9piCd+vHWtf7UBzHMc76UFOLPIfd/+U/Wb1RZzW1C65YlmBZAhruGTv+lfZ3p5L00KuE9+mJYvIdEcNCQK0++r91NSSmsRPvXcX7zGLtQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529256; c=relaxed/simple;
	bh=zjByxk/nrfho/ViwaKv21vfU605byGUzQQPyZPZCYLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CPH/FrmlMR0OALmjGBIRxBz9ZMSMZ4HfXDZz8omsXU7iTeoloMNCrrPqPDvsQTOqYkk8lVtSOwOGu+Mc17X4KCJ5RzEbGoKpVNqW/NCpw6NmpfVOtNkZE90C3olhkD+34gn0/oA3P5IoJzdW906PcpaQDU89FPz/FVDw4Fjc5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=llFF9AvD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FkOtSiMB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufSx+KWnvmMJd9fgIU36nGy8OaPPQbfXbkV/fMtqhjg=;
	b=llFF9AvD8nMQap+Auo4n7WlaFPZFHGoQ8QZg1QnsNzThAq6z3hEZGEcMlJRAs1XdR4/cFW
	VBWPvFCyatIF64mtPFBdtr4hWOvOEP9zF7DaNIrT7ka7nA1zIKNj4zDOWZCBUBzkoK6Pqy
	IL3V3U3bkHKP/iOgGq5nUmbD0vhGbWms/BFp4YfMWNnNvM8WYpDlZg6FJB6NYUADe0ogxY
	QeQE/6qpYaLL/vRkPssxdKVehXZGx6pU4InaKAUUYXnkgtgPhMjUrsuuEldHltskVuaeti
	QhxhynFOcWpeo86mNiGNXcVBgOwxfuNkokCXrXYEkN2vj1DIxxskzogQZ62PYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufSx+KWnvmMJd9fgIU36nGy8OaPPQbfXbkV/fMtqhjg=;
	b=FkOtSiMBS8/NxHjdoVDXY4nNfp0fovd0dEZl92OD+ThYD7omftQuP0afqYXCK7AqOZf+L8
	YJZHJ3zlKS+r7JDw==
From: "tip-bot2 for Mark Brown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers:sp804: Make user selectable
Cc: Ross Burton <ross.burton@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001-arm64-vexpress-sp804-v3-1-0a2d3f7883e4@kernel.org>
References: <20241001-arm64-vexpress-sp804-v3-1-0a2d3f7883e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152925226.32228.3324722200095786374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0309f714a0908e947af1c902cf6a330cb593e75e
Gitweb:        https://git.kernel.org/tip/0309f714a0908e947af1c902cf6a330cb593e75e
Author:        Mark Brown <broonie@kernel.org>
AuthorDate:    Tue, 01 Oct 2024 12:23:56 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers:sp804: Make user selectable

The sp804 is currently only user selectable if COMPILE_TEST, this was
done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
spuriously offered on platforms that won't have the hardware since it's
generally only seen on Arm based platforms.  This config is overly
restrictive, while platforms that rely on the SP804 do select it in
their Kconfig there are others such as the Arm fast models which have a
SP804 available but currently unused by Linux.  Relax the dependency to
allow it to be user selectable on arm and arm64 to avoid surprises and
in case someone comes up with a use for extra timer hardware.

Fixes: dfc82faad725 ("clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804")
Reported-by: Ross Burton <ross.burton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20241001-arm64-vexpress-sp804-v3-1-0a2d3f7883e4@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 95dd466..d546903 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -400,7 +400,8 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	  This affects CPU_FREQ max delta from the initial frequency.
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
+	bool "Support for Dual Timer SP804 module"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && HAVE_CLK
 	select CLKSRC_MMIO
 	select TIMER_OF if OF

