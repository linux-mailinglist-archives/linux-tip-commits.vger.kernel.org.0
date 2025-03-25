Return-Path: <linux-tip-commits+bounces-4441-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B5A6EB41
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1FF3ABEEF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208C254853;
	Tue, 25 Mar 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OsAlFnJ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQ0gh4gx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E361A5B86;
	Tue, 25 Mar 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890499; cv=none; b=ErUcc39VMP6CIx81JuSlFKYJFHY2a1Frs6ThMRMVUsxvNljcF0JKtMCOwPMmDZkXgDu6+ZIMb9Zs9Hh7mCPvAoyqYO4vCDLifmtpMwBstedeAzB3IW4pb+cNrvUQ8f0IeP9Y+DuEdYM32/nQ37a2Fr8wJSGMJwfqrF+4wjWifH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890499; c=relaxed/simple;
	bh=WiF7bOEvKwD1CvPpNPEWJf7oWppIHFfb3VqeRN0mYfw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BLsl5uBWlxXUaJBO7sV2xc146WICUrMA/gGcZuL5DSeXwhcBFHu9gx3IkBFojXoIVRmXwiRGaRsmeM5Xh1nIkBxwDQu4e1pFVWqOU0sWhEit+nzQgVSV/dAbXAk0aWULWmuIxOi0WoVUlsPBPGzbMItREQOJZ+VsC24IXEayszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OsAlFnJ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQ0gh4gx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owvbMJNm5TMhoMTaP+5E4UPU1SX1FBejbZXNlgygSmY=;
	b=OsAlFnJ6I34QgB8LMKyfhaS7HMG6MhMapkeXj/gEZcWvl5Yw+8HaxnVfHRIukPgsEbAbeI
	1zDQuZF//zeJiqhvCzSJDkwFXpP63wKYQ1loL351J1Y9BTUW+SFgk+EYT4boktS8dhEMyz
	r0JOEGXrSUKtUL/iFpAWZyhc2NLqZJNv19Be8BpCciveCcprb51PoIOG3QW7i9b144ZTB4
	JbugWAxBaoIobTOxTpXkMpm9Hdn58/3nEHzs+anXysJEnwImTcDlyQrc2XRWYenojlDMzz
	qQQQqmggF3RHpksoxU3Q463bFjWO5wYOhO1bgy+mvt8NB4Id2PirllFyWbux+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owvbMJNm5TMhoMTaP+5E4UPU1SX1FBejbZXNlgygSmY=;
	b=IQ0gh4gxLQya8mBB7fY9e7uQ+Tas94Sj55kXEFFUdJN8N4SNFztpLsAxZWeeID01TnVZur
	zvdwb42hgM3pe8Aw==
From: "tip-bot2 for Anindya Sundar Gayen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Fixed a
 spelling error
Cc: Anindya Sundar Gayen <anindya.sg@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228131138.9208-1-anindya.sg@samsung.com>
References: <20250228131138.9208-1-anindya.sg@samsung.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049569.14745.885005720316544090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     7e1e4e62656fcf8fb05c0c39c649b16d78d7c8dc
Gitweb:        https://git.kernel.org/tip/7e1e4e62656fcf8fb05c0c39c649b16d78d7c8dc
Author:        Anindya Sundar Gayen <anindya.sg@samsung.com>
AuthorDate:    Fri, 28 Feb 2025 18:41:38 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 07 Mar 2025 17:55:59 +01:00

clocksource/drivers/exynos_mct: Fixed a spelling error

Fixed a spelling issue in driver /s/processer/processor/

Signed-off-by: Anindya Sundar Gayen <anindya.sg@samsung.com>
Link: https://lore.kernel.org/r/20250228131138.9208-1-anindya.sg@samsung.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index e6a02e3..da09f46 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -238,7 +238,7 @@ static cycles_t exynos4_read_current_timer(void)
 static int __init exynos4_clocksource_init(bool frc_shared)
 {
 	/*
-	 * When the frc is shared, the main processer should have already
+	 * When the frc is shared, the main processor should have already
 	 * turned it on and we shouldn't be writing to TCON.
 	 */
 	if (frc_shared)

