Return-Path: <linux-tip-commits+bounces-2656-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA19B6D61
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D822D28274D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45F1E0B95;
	Wed, 30 Oct 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3UgKH4Op";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ewOrKS/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D11D1502;
	Wed, 30 Oct 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319217; cv=none; b=QeVwauMgcrpg4RcDS94GGz/oPXYf+mVMcqjSoCuKROM1n61Cnbb2wPdfYXIMSX2wCSJyyxjQMYzVHXuLdZbcfaFctoL+4wXEe6d00gyk6QBBqdjc6lf2pW0pNcM4LhehZacm3MfpSj84w3oWh7hvB+BljN9u0EJ3mBA3gyTav9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319217; c=relaxed/simple;
	bh=8Y7mJizbgYSnMlVcyYVsd6OpNnueQmJCm9YwpriQp+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QK4Fy45yCzCslik3n8Ms2v2grLD9OJzuqO6ycpM/Qz1liXswbqrinkMxwiUd7kfd45xGf9s+2JDewM8ybzlrm0CcDb9w8pS/TZ2Unc3aDfuJxP8Os49hT409xwS+VtVyDB0x4ceKl4GWoKIr3LkcgBQ+sJ5dPMXkyM835lkuQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3UgKH4Op; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ewOrKS/; arc=none smtp.client-ip=193.142.43.55
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
	bh=ISepVYCJkNmEgjkuPxmZw1z6nc8OOyiqIa/phI5FxPg=;
	b=3UgKH4Op5bTEW+i+TvfDRQsQG3BTji9weSjcBskUIoy3HDOZNSG/JXJGmPweDhJR6drQ06
	MAf91sm73bquSQWq8xYzzDVNs8TiBFxG96Tk5bnk+OhefkzJWfnAw0nylsAwRSZFKOKvwW
	XrlXU0eVFcQdHADXWIrpPWAq+v0vNTBFHJCbgotuIYPVbSte52zZ7sSFTEWN/lDDBQiohl
	+gzARn8s1QF1xPxbYXWCx/ffmFh0g7u7crb4jsB5daRwQzKheKhNV7lNqtI/KDKiQJng1v
	n+UWBJ9LM9vNy46v7Ahzb7qN3HJbA0oNk1VleGgEbqUdPkqKuqnEqFgR7xwfhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISepVYCJkNmEgjkuPxmZw1z6nc8OOyiqIa/phI5FxPg=;
	b=6ewOrKS/HdzhTFQibo++gz9iI2lhG6jtWCE7RmJLfuFrHHsRIvDjH8L1wcuIZ8NS9b3m41
	535fAnp7tBWMb7Cg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Remove clockevents
 shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-8-frederic@kernel.org>
References: <20241029125451.54574-8-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031921300.3137.15834914182437634264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0f3032a3d8bb33ae98106024d289f03fb390fa34
Gitweb:        https://git.kernel.org/tip/0f3032a3d8bb33ae98106024d289f03fb390fa34
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:22 +01:00

clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-8-frederic@kernel.org

---
 drivers/clocksource/exynos_mct.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ef8cb1b..e6a02e3 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -496,7 +496,6 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt = &mevt->evt;
 
-	evt->set_state_shutdown(evt);
 	if (mct_int_type == MCT_INT_SPI) {
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);

