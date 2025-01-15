Return-Path: <linux-tip-commits+bounces-3259-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6CA12B3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 19:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD01F3A6BCF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A481D89EC;
	Wed, 15 Jan 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXrobr1f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z23/HxCm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799A1D79A3;
	Wed, 15 Jan 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967270; cv=none; b=rZ/AsjtUh6mwyEL8usPMMuK3bjuZ6yry2H5kfb8K8GwaZtmkRz++GTUNlRw7G76ehDASzI7ivT290WoRVyX4NWfRqAgecWiZxR6lgvGvemF1jGNjPgDCWGhFFUwXmzUzq7tuAnmyoIrYCICiK1Ac4y5MVG2csF5BoLFSI45RcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967270; c=relaxed/simple;
	bh=a2drR2B1bsmiEBWG4HWTFAEpL6W17zGkowkspCM00SA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bG4hLtLk3WFh406fW8Ts1KB6GuuN7pxxj/pLTThE4ZI2JmzRyOVNYzmZMydN03hjspLpDjScTz+h0/YJIXmodS1F44Y4ufcClhGp8YcZNq1xRreb2ywbzWD1BGPDZUtBxrCYG1Ea9JTUWzFWMWtiK/LBXp1Vz/z2flZSh1DFBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXrobr1f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z23/HxCm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 18:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736967265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P34CTTiB6C77fWvXCtRU9j9Ap56geHc4t0U5VLOBW+M=;
	b=ZXrobr1f8PKuWB4X8RNDPT7VpF4RCFYPViOivPH3AiIrxaB6gNEsWNI/gg/TNYwRIyOLVz
	cflvuosUSNkHXDse5mYHkikZKd/MZGeQDSrwCEpO05JFYEosMPmrOivJKam3D6Okl6Q8CY
	5NHqBYViO+/CYYrh4wEbmPFA7KCJggEbTO2Fae2X5QEix6daFLThv5geRa/1L/imG7UTxF
	8zYgb3HhuuP9gdzLms3gwUje+s/sgZz2ABFThz62QHBA+4il8xyfrZFSwydgWbwBbckCCG
	Xl0cqhCqFXuH3/5lbeE8/Ar7+XTwpFrHxJPSpWifUUjPfPwXQT3VKy93JMkUvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736967265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P34CTTiB6C77fWvXCtRU9j9Ap56geHc4t0U5VLOBW+M=;
	b=z23/HxCmdFdcfMmi1tTfXN/iGbhLaDhySTASOITT+3lpYlEzBOWDT+T9pt1PtPJH7M6H7V
	F08tV5mU/8cd62AQ==
From: "tip-bot2 for Zhu Jun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Fix typo in __lock_timer()
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241204080907.11989-1-zhujun2@cmss.chinamobile.com>
References: <20241204080907.11989-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696726500.31546.14451612488318201495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9f38e83a88979ddd630c1f80c2404ecde7854044
Gitweb:        https://git.kernel.org/tip/9f38e83a88979ddd630c1f80c2404ecde7854044
Author:        Zhu Jun <zhujun2@cmss.chinamobile.com>
AuthorDate:    Wed, 04 Dec 2024 00:09:07 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 19:49:13 +01:00

posix-timers: Fix typo in __lock_timer()

The word 'accross' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241204080907.11989-1-zhujun2@cmss.chinamobile.com

---
 kernel/time/posix-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 881a9ce..1b675ae 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -538,7 +538,7 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	 * When the reference count reaches zero, the timer is scheduled
 	 * for RCU removal after the grace period.
 	 *
-	 * Holding rcu_read_lock() accross the lookup ensures that
+	 * Holding rcu_read_lock() across the lookup ensures that
 	 * the timer cannot be freed.
 	 *
 	 * The lookup validates locklessly that timr::it_signal ==

