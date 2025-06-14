Return-Path: <linux-tip-commits+bounces-5849-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD28AD9EF0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760471776FC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950582E6D2E;
	Sat, 14 Jun 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oxg6/7pQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVz/YGhb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C202E62D9;
	Sat, 14 Jun 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924973; cv=none; b=nrpR7Bae4zZHJitE2VEXvWPhBXtmU3n9SbJkaZhPQmMfzUFnlV58/YOaPOEnm/Sy/r/BYd1w1LcVnAHB8PJr+Kx7elRz4yJ3M5S6rA1MFWFuZXVOBHCDQX1uy+rjU56zX3JExBRq7Mp5INJPz7rE9JhPewCv7YAnPZrbVVfzt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924973; c=relaxed/simple;
	bh=lXdq0zd8Y5OrvA4/o/pegESsd0gxqt4j8S8a01Mec80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SQv0aI5LcDoKuVpsjQwNFTA4I7/lD/OvyPF/YjHA1UNntfyHlBrxZbiWZGLYYkqnfFZrSEagdul5h2hkQAk1T88lOYo6zxr4sa085kA4ZhbzXPxFVQ9M8puiG9ou1ciOG3iXnpkxeB19HdIm4zvs3fUHq7BZgpVfTh5UYHn9jKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oxg6/7pQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVz/YGhb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Jun 2025 18:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749924967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjFzjT0ijZ/JIKLwJBsB72Jw6BWTexhwNDBvu1tIDBg=;
	b=Oxg6/7pQcgiv2MOqzj/9hzzEIktCfYyuwwQeZvlXawkFhY29lcTlFoazpT/KTc6ix6qy3C
	dQodIkPHTgnvDF7IqRfu86QU88t6Q3PDLGMkF+qJjQWNhf9nZlVBjdx+stNT54R+67zkbJ
	kDSnZWQ9uvckivuOcT5VlDfpuuFlvz1BOelWT1M6H2BHLcVoOmyUHwXJOwwZ7ncszr5RTt
	A1tt4XoBMgh6dziCIZaQpw7lcsZOjuO9snM9QXyYyafPizpi9Ne0w2dPvP2PM8M63a9dxP
	ITLPHCaYtbPEFA0a4MHl2pvCnW9llultvS/rsWW3sOfsyDdG9Ryw7r+r2C9xdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749924967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjFzjT0ijZ/JIKLwJBsB72Jw6BWTexhwNDBvu1tIDBg=;
	b=qVz/YGhbjf/9sY0mHD1BcJCSIHU1lkb4cIAMfxfx1UxV058bt71jMSzZjfaZXPc4/8fjB6
	nCFltVBy27XtlkCA==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Use cpumask_any_but() in
 clocksource_verify_choose_cpus()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614155031.340988-2-yury.norov@gmail.com>
References: <20250614155031.340988-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174992496671.406.7971020073622211674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4fa7d61d5a02ad57a05c69365db293afddf678fc
Gitweb:        https://git.kernel.org/tip/4fa7d61d5a02ad57a05c69365db293afddf678fc
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Sat, 14 Jun 2025 11:50:29 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 14 Jun 2025 20:09:44 +02:00

clocksource: Use cpumask_any_but() in clocksource_verify_choose_cpus()

cpumask_any_but() is more verbose than cpumask_first() followed by
cpumask_next(). Use it in clocksource_verify_choose_cpus().

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250614155031.340988-2-yury.norov@gmail.com

---
 kernel/time/clocksource.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 6a8bc7d..a2f2e9f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -323,9 +323,7 @@ static void clocksource_verify_choose_cpus(void)
 		return;
 
 	/* Make sure to select at least one CPU other than the current CPU. */
-	cpu = cpumask_first(cpu_online_mask);
-	if (cpu == smp_processor_id())
-		cpu = cpumask_next(cpu, cpu_online_mask);
+	cpu = cpumask_any_but(cpu_online_mask, smp_processor_id());
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
 		return;
 	cpumask_set_cpu(cpu, &cpus_chosen);

