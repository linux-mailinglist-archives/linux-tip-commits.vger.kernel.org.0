Return-Path: <linux-tip-commits+bounces-2658-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9D9B6D66
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D543282AA6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD03214424;
	Wed, 30 Oct 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PUkdAnGg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Ek+cJGX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF11DE881;
	Wed, 30 Oct 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319219; cv=none; b=CdeyEwQD5uzNU8AEvBhpL8s9xLOyWcDY/IgGPU/JbRXqwhoQjVxJmPxuSwhsRxOvQhWNw5eHCbT1XDpcKSVPGgF2JnWEW9mUfNbJC3KJF7dC3e91bOheIHS5Z9RATe1vSyuQb4y7K8yeTvOkPRigKh/0INGJAyhoqfPaKIL9CHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319219; c=relaxed/simple;
	bh=XEUTjsisS0kHGDx5nEW3qAldmrkRm23JUOFddaVPTVs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NTQl1I3LmedUzVzfB7Vkusj1y4klvRg1cfbr9wKCthwheNtzphQd/L4mdSyuM22aQlHjg4+CKj9WD9gMzV18c94WUhhrAb749srF3o88V2xOpCyXYCqZBU7gptiiceB3EElTgsdbIivy9d7z+ftJixyShOvX9Zzd8MdgU1i4HEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PUkdAnGg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Ek+cJGX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gCizDQResSP9HnUEChmUA6+d08zh2IDHRteB1259DE=;
	b=PUkdAnGgnlBW/5PZQCTkc9H5dl2AJGAmusUem8aUNB46x4oO7zEE6J0WEg1Xqi/blqgDDA
	UpKfQx3wng6ZB/vtPKOQn975GIxnhv0hkxdbb9fJJYTKoSBPPpZd4g0QolLmP77A8Od9UX
	VMM329pgxhIoq+hDLPnLaYy8JblWGWHyFJ/hOf+WC5uyV61PUB0LIJp18LsYY3dkuNW6SG
	TIegL55CeOkR2I4ZFVuezct+GxhUNAJQwFs9RC+jR095RFNk4dvWdl5Xlbt+8LHpvQ0aWU
	AOOOfBYNkyFjiNSHLErOSz8HJrUTJoq7vqwN4qp7lEwk6sVo90an3UnqVMOGvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gCizDQResSP9HnUEChmUA6+d08zh2IDHRteB1259DE=;
	b=7Ek+cJGXNdg12CVh1G1kFpPMi1rWVDifHzSsEQVGeoLOSJUPJuMkfSdGR/WSEIN7TJMWf7
	2QOWekSdD6qpAaBw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ARM: smp_twd: Remove clockevents shutdown call on
 offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-5-frederic@kernel.org>
References: <20241029125451.54574-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031921493.3137.1971948753074194974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f17faf114efbe9d99d8e093cb20f8b58a0f9f31f
Gitweb:        https://git.kernel.org/tip/f17faf114efbe9d99d8e093cb20f8b58a0f9f31f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:22 +01:00

ARM: smp_twd: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-5-frederic@kernel.org

---
 arch/arm/kernel/smp_twd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f72..42a3706 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -93,7 +93,6 @@ static void twd_timer_stop(void)
 {
 	struct clock_event_device *clk = raw_cpu_ptr(twd_evt);
 
-	twd_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 }
 

