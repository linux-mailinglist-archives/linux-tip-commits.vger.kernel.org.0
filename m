Return-Path: <linux-tip-commits+bounces-2655-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB859B6D60
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF0E1F226DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200061D318A;
	Wed, 30 Oct 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JweWDXpo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NxCYecqL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127801D14FB;
	Wed, 30 Oct 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319217; cv=none; b=iJy8m+7LNW7aQrVPe7oMjjjZyEiz4P8hP0dodhnN0cH41TyFzM57MPfTtPgeBB9OAa3VFG6rir5Sa753DUVsl/wqH4UUfUESu8TtV2HiNIwDy7hT8oEDskOl/M4UrsCKQ8i/JYvH7+l+tcEaoTbna+ojV66ZEr5GdgAgZRhpSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319217; c=relaxed/simple;
	bh=UXiy849iATREmqKLflJTgxrVse1DaCCe5gaH4F9GUOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k2WGMXiWo7ILWjq7rIUBePfF9r4E2ABzcD0x61s8M/bMpxBjTpLsm0ZFUJAcfLNYIcziJQrApNRRxyX7VXKOgY5UAqjPg9uISSBlARb0Oz6LBbjGFOk4lDTb00qPNLExmiRwkSHBRMmIHfIabV/WklbpAUuqr4uVT2SzuBnj1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JweWDXpo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NxCYecqL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsGAfe65fynxICHf0t+Apcrj+kdv7LLpC85XlJ6ULng=;
	b=JweWDXpo+1vCSw8fyOkKBWJbkczqHaGbd2lfQURS2etxXIKCNPo6sqteWi/shw3D1ePRlb
	z2N4oqUFf4nQCWnkgTFayGyv47KGDxO+V26K0sIeIjwuXK7UiuCoPuF431AtvPReOlIuE9
	3GPp+VfTXyW1nJ2BwxejFe8Zlfmoxe9rh9RqvN+YszLu2f49+TUPaIia/cKHlOfOe0M2as
	tkbX7//YuvBSd7oYd+PBSkujoeak8l/gW5yMxVgBE9eaONSKTjzqARH0SweeG/45GCaa0Q
	J0BvblUcLvR5Afcvkp8sI20zokNxSUKsyDlMZm3IgKTcCZSITeZo2LUfh/MUvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsGAfe65fynxICHf0t+Apcrj+kdv7LLpC85XlJ6ULng=;
	b=NxCYecqLIrhsoQprI1SFlvt2hkpwg/DOsfI8Gpch5vlCe98MkgTplMn5WlIbSWxir1tdAW
	RyBDSTDfyV1DXRBg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/armada-370-xp: Remove
 clockevents shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-9-frederic@kernel.org>
References: <20241029125451.54574-9-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031921228.3137.7874721946327605150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8eca91eb53cdf054d16b03c1cf8e78bf0a33f2da
Gitweb:        https://git.kernel.org/tip/8eca91eb53cdf054d16b03c1cf8e78bf0a33f2da
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:22 +01:00

clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-9-frederic@kernel.org

---
 drivers/clocksource/timer-armada-370-xp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
index 6ec565d..54284c1 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -201,7 +201,6 @@ static int armada_370_xp_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
 
-	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 	return 0;
 }

