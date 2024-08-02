Return-Path: <linux-tip-commits+bounces-1928-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733599461E8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5902814E6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10613633C;
	Fri,  2 Aug 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a8E5r1DK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEWoYxsj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27216BE0E;
	Fri,  2 Aug 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616985; cv=none; b=TMpE0WPy2ZgEJb3pjn6qs2g6gCN/1p6bCKiUjd+i980v/Z8i7jKgIqQNgyYZqfsC/7imo1NSrhgx+r5bq4rBVnvdw0KnX2/OM4bNp1eEHdr6qs/0ITBBkqLJVxkani3/yrJP9KnGhBZ/CmlEbd0EcgG20U1hc5QIL+5n/BgtREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616985; c=relaxed/simple;
	bh=SawTk2Xwl7AJ5i3cSF2VydWBEu68K8pJc0Tu+ciZgRg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s9C4luEZ2eZqS3g/2HUd2Gi9jDKwAxXockbxDtZCp+yygoS8b9IwMUrctAcwG+gruj82HQCWjRiUlv4WE3FMza88zw2F/JCeNsw07La06LlSakTQKAN3m/WPGiYcReZ7LML7SWGj7jnwIebPKhDUqB9dBm0MBRUFt2ecwuClL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a8E5r1DK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEWoYxsj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 16:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722616982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20mBgU/LdlJyob01VD3z7ZzUU9bo1lGKfm0IIFAGJs8=;
	b=a8E5r1DKxS20zYHEXPhShbAqOO1mZnbsBj8KqZcGrkwssX0NNHfAb2B3r6BojpONZB1BwF
	TIMWxJtcuOXgSRFiljNh4xOkDUpCsF14r3MrJ8dKyslkN/3lJo9WNILI6/nQZiefgsxWvr
	nJAypmF9hy2MCrFPRXCN8MuPKwj42/JLKcQw9gNStESbfoYmKRmOHFxy36ikaz9kp0o69D
	+OxdedrCfM/9k/cHm4sbibeDcvOr7TCKupKa5M9vRCL5L3cRvaQbOGNsS3KQtDc2bRU9wk
	y/kcAdQex+1mAKaBCECSe1qudCewKhwIVmvGpqad+G3HqPjAbB4Xcrw+HbrZxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722616982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20mBgU/LdlJyob01VD3z7ZzUU9bo1lGKfm0IIFAGJs8=;
	b=KEWoYxsjwhN3f8WP7IETx+GDtigHIrBqAzQP40cg0cGAHqXcOr0H6O2piRTM3RW+swE3ef
	j4EkYZQ5C2T6Y9Cg==
From: "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource: Fix comments on
 WATCHDOG_THRESHOLD & WATCHDOG_MAX_SKEW
Cc: Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802154618.4149953-3-paulmck@kernel.org>
References: <20240802154618.4149953-3-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172261698252.2215.3754371972506757984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     f33a5d4bd9c2e545857b2cf7481eb721bcab867c
Gitweb:        https://git.kernel.org/tip/f33a5d4bd9c2e545857b2cf7481eb721bcab867c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 02 Aug 2024 08:46:16 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 18:37:13 +02:00

clocksource: Fix comments on WATCHDOG_THRESHOLD & WATCHDOG_MAX_SKEW

The WATCHDOG_THRESHOLD macro is no longer used to supply a default value
for ->uncertainty_margin, but WATCHDOG_MAX_SKEW now is.

Therefore, update the comments to reflect this change.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240802154618.4149953-3-paulmck@kernel.org

---
 kernel/time/clocksource.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 581cdbb..ee0ad5e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -113,7 +113,6 @@ static u64 suspend_start;
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
- * Also a default for cs->uncertainty_margin when registering clocks.
  */
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 5)
 
@@ -139,6 +138,13 @@ static u64 suspend_start;
 #define MAX_SKEW_USEC	(125 * WATCHDOG_INTERVAL / HZ)
 #endif
 
+/*
+ * Default for maximum permissible skew when cs->uncertainty_margin is
+ * not specified, and the lower bound even when cs->uncertainty_margin
+ * is specified.  This is also the default that is used when registering
+ * clocks with unspecifed cs->uncertainty_margin, so this macro is used
+ * even in CONFIG_CLOCKSOURCE_WATCHDOG=n kernels.
+ */
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG

