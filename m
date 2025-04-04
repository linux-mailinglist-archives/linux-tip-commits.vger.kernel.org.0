Return-Path: <linux-tip-commits+bounces-4658-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550A0A7BFA1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A050A3BD9C2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BDB1F4E27;
	Fri,  4 Apr 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKx+AWDG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="estdWH7k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E71F462B;
	Fri,  4 Apr 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777381; cv=none; b=tzjOT9yqHgDn8dT849eR1+CWaJofWh8kmvaYhAxNGMjCILgcW2pQFrYf24AjtHmYDZrI/qQ8tpinvtkZZYd3LFBocXYLBBiirEeIdbPNZasHP7WoJtTIxyaGytv66dtG0sbEYoqO1FAE6G0oqfh9j9DqAvqupVsrrR0Ybpw0grE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777381; c=relaxed/simple;
	bh=FBbbBdT619CsGls61gr4qNQ0EyCOoMktJRETITbA7y8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a5/Db5tPohkqCejBSwQ6JS2BVkHV/5ZWlC6cdxYQkAPZA9I+XGOCNmKYxXu69EA4tEpK0H2UJ/SeYdurH14++5lvX0xbb4RF57CBvH5IlW8RmEvA6eYmxLG6AZBPFZprfHFxkRDq84KtXvgcRhikfroJXelw/vzDrlJU3qhbgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKx+AWDG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=estdWH7k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 14:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743777378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QsEdt3qN+UKI+hxBRXYli7pvT4FxJ/Rw1Thj2Vs/6H8=;
	b=rKx+AWDGFYZntaV1LCiFGhf68dw4E1FZbrowkhZndqkCmzsVzvtCliYLasINopLl31os0Y
	xbvsGxaqM4VY8UXMbt6yi4nealcShWkUhqAPOzSkVtnAJ9KwhjQ2fhsLbjvecRXkvPiEZW
	qI5kEfSO8GyMfnxB73Y4p4v4eMn/wEMBpcZxZoTLtS4vREM+5JOZftzMvEzxdZTAQwFzZ9
	aIj/Lv6NsQ0QEuIfc/J7ixj5gKY/2aRjqV7NuV+E6hShI1yIrbCnAf2yFcFg33e2uhP0wH
	BILEB7JY1z/kY/G6qEkT+QtCMFtpM8njUbRkM6nBYtYOJC22vUMjLpNaFjKq2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743777378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QsEdt3qN+UKI+hxBRXYli7pvT4FxJ/Rw1Thj2Vs/6H8=;
	b=estdWH7k6D4dGfR5iygaCoIGFPUo+C+ULbPfhf6BVrVyLdZUuIXX+87Snr6pq1pDVGf1HU
	sV/ioyvm1cTViLDw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Remove unnecessary NULL check in
 hrtimer_start_range_ns()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174377737735.31282.6552908615693954932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     eb396f4815e01c9fffd3ae9711b6c26503bbd9e5
Gitweb:        https://git.kernel.org/tip/eb396f4815e01c9fffd3ae9711b6c26503bbd9e5
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:26:10 +02:00

hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()

The 'function' field of struct hrtimer can only be changed using
hrtimer_setup*() or hrtimer_update_function(), and both already null-check
'function'. Therefore, null-checking 'function' in hrtimer_start_range_ns()
is not necessary.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4661c571ee87980c340ccc318fc1a473c0c8f6bc.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 88ea4bb..e883f65 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1316,8 +1316,6 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!ACCESS_PRIVATE(timer, function)))
-		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard

