Return-Path: <linux-tip-commits+bounces-3427-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC3A397AC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8613BA751
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B79243388;
	Tue, 18 Feb 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e46rp5iQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogIhtFPS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32CF2417E5;
	Tue, 18 Feb 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872004; cv=none; b=hDobBn8Uf793ichgH/bzHQZpBvoVwbk1x/m2NrsWax4qOm+DP5FucvIkLZEtLavuQlZQDtIZNfec8s4YLgskvmGjoqfzjI+CBbOpnQLWiCApqGLmGR5b9UEYL5eXsNvf37CXxXmFevPm3TW3sqdGxYMtQHV0fHaN7SRTGzhR4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872004; c=relaxed/simple;
	bh=yq+sWPari3d8HvsOYj+lIYF1wOwzv2uYaB0aw8JC2Vg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c1w3NwDXfzl0coY4ieV+mBlCe33p02Wwjp1sNKnCRKmOUelFZxsR7KI7q0+rjosk+IR1blq8oXqUIGxKD8AAAnlXfUFv4NSWmujmXspg1GsUGeE0uSZR9qjMhoIf+QGNgwjy0ymIOGTlh4Ueo+rMOoSTrTBuqcKS+SBwUjWcdjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e46rp5iQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogIhtFPS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRofABaTsVlML/fYcCxzscprOgd2oTZ+ljUtpPcAs30=;
	b=e46rp5iQXZAx7LDyJmoMqmJYw0mrxTXnACNalm7faMJrQT73rPFm5J1dRCQxUN/9xSWukY
	lXOpA+14xzwdh3j6a0LGjUYhaXxVYVKYlPuMJjSaIV1bF9+cXhhNnt8ducskq7ieXXFXdb
	AhJmZ6/cNwqHCm32amSgknNpiPuVj057+xNIvAb15G04RDduxM2jwX8sqzanjkCPIAxzvD
	/3nur4eV7TOUyr+04fWg/IGeO6T+6z1gNyTwDaf9YSPBwfobt50KyYBSouUVEJAiUMRkYJ
	TayF5vRLkpqy7SbpXNSBiY9NsxOatHL9K+s3Bp15jWzjXGwHp2HlQ4aXH2YJ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRofABaTsVlML/fYcCxzscprOgd2oTZ+ljUtpPcAs30=;
	b=ogIhtFPSHvHAea60sjbNdUm5qCgjUs5N/Xby7sEGkntjLnwLQCyXvRCmjUPMOVDZqIySpQ
	2Cb02AsnqkQrcrCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] ARM: 8611/1: l2x0: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5ca584b1e32c34630bb15ccc84467c1e05059e66=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C5ca584b1e32c34630bb15ccc84467c1e05059e66=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200076.10177.14760696558609781835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     878a388866a67cb8f2d12df24f256b4e6159dcb8
Gitweb:        https://git.kernel.org/tip/878a388866a67cb8f2d12df24f256b4e6159dcb8
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

ARM: 8611/1: l2x0: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/5ca584b1e32c34630bb15ccc84467c1e05059e66.1738746821.git.namcao@linutronix.de

---
 arch/arm/mm/cache-l2x0-pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefd..93ef050 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -539,8 +539,7 @@ static __init int l2x0_pmu_init(void)
 	 * at higher frequencies.
 	 */
 	l2x0_pmu_poll_period = ms_to_ktime(1000);
-	hrtimer_init(&l2x0_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	l2x0_pmu_hrtimer.function = l2x0_pmu_poll;
+	hrtimer_setup(&l2x0_pmu_hrtimer, l2x0_pmu_poll, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	cpumask_set_cpu(0, &pmu_cpu);
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_L2X0_ONLINE,

