Return-Path: <linux-tip-commits+bounces-5983-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA8BAF749B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D466C189306E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A12E62BF;
	Thu,  3 Jul 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GqZMHZnw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PgToSr9A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6E233127;
	Thu,  3 Jul 2025 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546983; cv=none; b=C0eLWHA8K+U+xfE8qDGLKDWmB63xcVaHGBogFpiyfWvFu4kr1JSr0GDFH+7iFmSRRiQWYtqFaGfOmEeLFdeo6fqkBh+fxq4BxyOIJy7WlgJ81Cb4mXodLxSWoNnwad0ejnyocmHeyb1M6DEgpJ+c1IJRtIGPv5dLvNpNuPFhI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546983; c=relaxed/simple;
	bh=B/L4oIFgwl3Hxch2Pmb5tdewjqC/ENSMUQWNB9qtBC4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SZSft6dHjHEeUI5r8ByveBG7//sBPoRNF2cSeBeHD/plwHSXa/9PNsOvduj5lu2uxtBN3rPhivS4pTCdBKnIQ8q3N97uc6liF5yRbDaSEukNhkRNH0Z5E015y6aa7BY9Lqws8xvPhcnUy49T5NO/tVHdUhiQ4M2sC4+M5KAK0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GqZMHZnw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PgToSr9A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 12:49:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHFAxVWLbQyAvu3oURRPmlTXh7OSPuGh19aHRHRFeqg=;
	b=GqZMHZnwFx0FHt8CuquORACv4adJjdOi9CvMo9wAB6VuVw88HR0aK7zeIfwSOdj6aMdB+a
	pbskaO+XXX8WZpKFrWRvpKZuHXN57fJycliy9E8gyaoXsTQsVCdWPpjcLnAHwYyLMymRAZ
	U1TV8j1FMZY0WYjrBiTkvU9bYi7EcIYk6eSO0cH/OefWF7PTX4oPFTpqqQPOZ9ceS1diJz
	wDi77Gar8Wbu33D205+mjSgdgtPKkNvqPV6H43oxWmutDPqVTrivnJ1EonvfqH/J9pN/Gr
	iE+41CS0veLjjNFz/xqFfIaOMwE3fvt0emI8EGQAdFfuEH9TivjV0pYzb3oPfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHFAxVWLbQyAvu3oURRPmlTXh7OSPuGh19aHRHRFeqg=;
	b=PgToSr9ADN1n9AohKXn4V0VRjFH9+Bd33LKkR3+jM7J+Cl7nV5aHa4bkMq9Sw4XIvc4VHP
	vfBBo72VXid0RVDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Remove the temporary CLOCK_AUX workaround
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250701130923.579834908@linutronix.de>
References: <20250701130923.579834908@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175154697931.406.10685240214515263929.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     8959338617a85e35820e3a7fa21801cf55b068bf
Gitweb:        https://git.kernel.org/tip/8959338617a85e35820e3a7fa21801cf55b068bf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 03 Jul 2025 14:39:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 14:44:15 +02:00

timekeeping: Remove the temporary CLOCK_AUX workaround

ktime_get_clock_ts64() was provided for the networking tree as a stand
alone commit based on v6.16-rc1. It contains a temporary workaround for the
CLOCK_AUX* defines, which are only available in the timekeeping tree.

As this commit is now merged into the timers/ptp branch, which contains the
real CLOCK_AUX* defines, the workaround is obsolete.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701130923.579834908@linutronix.de
---
 include/linux/timekeeping.h |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 6121924..aee2c1a 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -357,13 +357,4 @@ void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 extern int update_persistent_clock64(struct timespec64 now);
 #endif
 
-/* Temporary workaround to avoid merge dependencies and cross tree messes */
-#ifndef CLOCK_AUX
-#define CLOCK_AUX			MAX_CLOCKS
-#define MAX_AUX_CLOCKS			8
-#define CLOCK_AUX_LAST			(CLOCK_AUX + MAX_AUX_CLOCKS - 1)
-
-static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { return false; }
-#endif
-
 #endif

