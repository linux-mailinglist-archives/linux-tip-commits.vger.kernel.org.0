Return-Path: <linux-tip-commits+bounces-3469-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E0A398D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3700188B223
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294523ED69;
	Tue, 18 Feb 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJ7JgHbq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpO3eOra"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA023A58F;
	Tue, 18 Feb 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874391; cv=none; b=EWksxJRbX3j7gXS6cyfLSA2hpzWw42bhrhV7YPFPvVqvWpNpu9mH+IG8NtBIvNOOI7Gqqs5ySrXQ+crnwemBxB14QUxh6ZeLIjE4uCLzp4lsk4FaMVvcIC0gnV5TT8+Ou9tQpiIs6EbpK1yQYQKvJMVoUMDQuf0cm3JZep2WVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874391; c=relaxed/simple;
	bh=eYCpoPUlMov6fBT+oRJ0VcXplxWwCQ9EoUGDaWpk43I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ju0KdiD80UUkD3cUe9cxlT+7YFhHx8MN/CVI+yH1iFXOpUb9Vg2qULzIN8fZo/Kyf61gEwojojlYZRNWztPSEmzVP9IolYOYHNX2Pf2x58qwRDAXIYiDM1WqfF8S6zFpT9tKpX88RJb6quVZcaK3ghUoS7OHZg+E0QlUFQt0zMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJ7JgHbq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpO3eOra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gN/Twf37ajhU/X9Fnnoe+TLl908L+puSw+yrD2u0tRI=;
	b=JJ7JgHbqB+LY47lDRAmoTD6+t9rHZjDoPlXY85h+upimQGOvhN8xDIYz2rms/g6FywJj0t
	5nghJDsxgLgSTS0pPkSZvP/5cufNXam1Ph+B8Zuq3yCCpzrFOpw4nl5lGgak3GTsomba7u
	tJjuPMriOtnJwabgvGclqd36uKD5DgStzBUo1QO02k/xDdjsTyucVtAwmkh7BxzXF6dL+6
	tvSoZ+3WfMp6AoLrWYqyCRLk1+1HW5mpTT/b6sByk81pVKp0Da+f/AcSU47h7YYnRoMOCa
	zyQNxf2gNk6pEhe1TOOE5p5ffxu9V0xjQGjjexnUl/zMAlUUF7LlRrJGzxYcrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gN/Twf37ajhU/X9Fnnoe+TLl908L+puSw+yrD2u0tRI=;
	b=vpO3eOradsfLVV23S9I5ONkGAHX7P7pd3DhZTYxuWQOEehxfJJudPCteU7ZG3dptitIKax
	G1zmJkvKrvY6zCAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/i915/pmu: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, Jani Nikula <jani.nikula@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C71198b93c438866fe2be7323e59cdbf21aa0d493=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C71198b93c438866fe2be7323e59cdbf21aa0d493=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438725.10177.12058326574456575833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     82ad584eed8baa5b1988580b3785649e7a1c07e5
Gitweb:        https://git.kernel.org/tip/82ad584eed8baa5b1988580b3785649e7a1c07e5
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:06 +01:00

drm/i915/pmu: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/all/71198b93c438866fe2be7323e59cdbf21aa0d493.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/i915/i915_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index e55db03..0ce87f1 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1264,8 +1264,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	int ret = -ENOMEM;
 
 	spin_lock_init(&pmu->lock);
-	hrtimer_init(&pmu->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	pmu->timer.function = i915_sample;
+	hrtimer_setup(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	pmu->cpuhp.cpu = -1;
 	init_rc6(pmu);
 

