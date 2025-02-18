Return-Path: <linux-tip-commits+bounces-3472-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D49A398EB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7603164854
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0D24111C;
	Tue, 18 Feb 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zOyoeAhI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IplDtQk4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AE23F276;
	Tue, 18 Feb 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874393; cv=none; b=IuvQ/AURWolsCxTgh161S61yRl/BVxSI+gFhSHJjT3mMkk9yW7UwSvc5+H3VLr2QASUECUxITMREjWvTvdXXmjLYt4SeGAo2GONSeqkcRJ/pzXSACmg/aMjvJ7+WuLIjIR9hVaj4qZyd8vzS1EUzGzxbkC4xcBpWpeRFXnAXcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874393; c=relaxed/simple;
	bh=+sxyYJYPIhZjPURPct8uGjmw/hE5LuSjanyez2LC7Bs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GcJq3Iq3Ml2Y6Isgfl5hd/eNVpW5J3sOF3Ctru2MUrRSQ8Vzf6opExunAp0KonzpF0IdF89ws2hm+dhaGPwPfWCnGNl1nQdcQsGJzqwt3NNdIB52qufnnFonCZQz9KFnA+4JB2Trzkx7pkGJnhqVOPGxgE02yVUQYj0vvffIjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zOyoeAhI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IplDtQk4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkN8RT8QmG6p+LfslDEduJff27IWqprb67Aw+XX9e1c=;
	b=zOyoeAhIWbqKE/24PK0x2jg7de3mKUhyHz7emDKAK/Uzn2KSoJZiufNlp0SEn6UUgxmDcf
	OfduvRXoUz2ds8Vj247cP1WtDNlsNy4kpgaUKGU8QLB/t5UDTcyvMDPml2/lcTm/qavjzv
	OCI99SGAV1cm6pPvgNAH+erIZoY+VhYPpe5huR0ZZPzqREW6ScFlzA/bcud9JuoVIsmqp6
	11ybHIhEQWA7CFARH3SMVv8VM3wNwH5WdtsBV279mI11xzgYTUpCu2mBj3ycg7we82Pqih
	cCAYwXmUG+Nx8MN/FXZA9iRZFNrMqEzNR+LNvnPUKwkc0KQUA1u7lDRvSoE0zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkN8RT8QmG6p+LfslDEduJff27IWqprb67Aw+XX9e1c=;
	b=IplDtQk4sadcGUg0qZ03F/xYdj90IVaSztaq+23hmSYevCk72WKOT6RJJJNOQA6+LvKLb8
	IVYXps0GrLuAWWCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/i915/huc: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, Jani Nikula <jani.nikula@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd293dd4dd9cb6a9bb9e99f3fc11ea174c6525bf8=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd293dd4dd9cb6a9bb9e99f3fc11ea174c6525bf8=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438943.10177.14936020821165269117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     0592bb39e3a33ebcc956c1730fb2c756ebc71fdb
Gitweb:        https://git.kernel.org/tip/0592bb39e3a33ebcc956c1730fb2c756ebc71fdb
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:05 +01:00

drm/i915/huc: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/all/d293dd4dd9cb6a9bb9e99f3fc11ea174c6525bf8.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/i915/gt/uc/intel_huc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
index b3cbf85..00d00c4 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
@@ -231,8 +231,8 @@ static void delayed_huc_load_init(struct intel_huc *huc)
 			   sw_fence_dummy_notify);
 	i915_sw_fence_commit(&huc->delayed_load.fence);
 
-	hrtimer_init(&huc->delayed_load.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	huc->delayed_load.timer.function = huc_delayed_load_timer_callback;
+	hrtimer_setup(&huc->delayed_load.timer, huc_delayed_load_timer_callback, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
 
 static void delayed_huc_load_fini(struct intel_huc *huc)

