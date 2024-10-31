Return-Path: <linux-tip-commits+bounces-2665-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045459B77F6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8AF1F24AC9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCFF1990C8;
	Thu, 31 Oct 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BuPos9ae";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06V0sZJA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D9881E;
	Thu, 31 Oct 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368278; cv=none; b=SUYfE5GRVjysITVGkX2XDHoMhwIbjaneclr+6SSJdCjMHZBozpAGV6/g2DPzQtmks55nyieC5/pA02sZwROd/5A+JuNixUAox2ZqPFPgBMabDKS87WM5JUrAooxaqcY43A/Wxd7QGo3Mzv8lLDMxTpp4vfyIOxZn1dapbu8fApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368278; c=relaxed/simple;
	bh=s0gKMDepvfvSn53HitesT9bD1+vO4rJlDXpxYBuMGLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=doDy9/3xY2jNOvESrlR7bhPeswLMT8LFQ44NhyAN1pFWafF6eV0Dod9IvS0fcZQGgundK5M8WRIiL5qgJq/yZLjRJIscf7dlyivfhi1P0v9Za2WN+I96tvMbvrz2HVLnIv6rGcnwKo4jTMXIAl4x/VdMiExtHj93Hffojjfc8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BuPos9ae; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06V0sZJA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0pVfZjyo3NHlGP+D3Z2qsZhdsVjQj31gOWtmAZoTL0=;
	b=BuPos9aef91ZGBF0YG9bXlMQ+SiEhToRl/I8L8+vkNV56rggNhS87B8o/KlRI3KhH2gKPD
	8/EhlYCwrnVvOUsAcpBh+Dqpkr1EmkcTsDIXiQZ1jYNhyfJzWRxT7DKIMM/dlzVcS62E7C
	XYR/Z1TcUdkXfCm7vxO/Nr6tLy5NqUuDPDqZ33oEilaAXcqgHxsci6Bm3iwXIWqZdGTU76
	s7bBZ86+J3O8+vbDvuwg2fpYc0QcYyAeCk6QXhMzMEUMIIKWneCOtDAzCeqHzd+ygMBek3
	HzjEeIVM2YIuNbVA8oW9VHUjjsaonn3B8H3BNeP/dQjkwidHFousm9A/HQNfGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0pVfZjyo3NHlGP+D3Z2qsZhdsVjQj31gOWtmAZoTL0=;
	b=06V0sZJATDzlxKgMPuobZ7yE+rvzpsvQGsu/Xfk+VFnvMOY4TRvfmDXKPvfGEsu+NJ8PRL
	lDtFd3j7ICC6pHBw==
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
Message-ID: <173036827358.3137.917637394950268328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     30f8c70a85bcb756b9247c27fff5f0fabf6d5c6e
Gitweb:        https://git.kernel.org/tip/30f8c70a85bcb756b9247c27fff5f0fabf6d5c6e
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:43 +01:00

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

