Return-Path: <linux-tip-commits+bounces-5526-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21CAB5790
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3483BF142
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2D1C9B9B;
	Tue, 13 May 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXKa9w6X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pUIcjLim"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697B1C84A0;
	Tue, 13 May 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147762; cv=none; b=Bpyu8kNzmNRuBe2VXOdoGL2Ej+28hle9AYKwa2+/1dC4nzvBk89+gkAniKT/Y+c6YBhsGW2jaG69ULc+qSMGXjSnSN5/iUMNfOyfZoXdNcaF5UXdfT+xVb5G8pgsuaOdgqfeS8aIfsVwdPPEhtA9AbPRodsRXYrC4SkTkS+IWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147762; c=relaxed/simple;
	bh=horsV6zhU54XLy4AAcl0GiFBdRVk3FtVkYR1dWqa1EI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ETOSavsQanwRP1Ww3/VOYQ7Bl6LJGwkDeyFasMM7SfCunXYfaBde/5R2oXsEGp42F2vJUfch5TXICkx8xFN55/YJhwfDYxO7XoveJLBHzYHfhMf1jgzI902kUftKIf0OlbikcNmJg3c2A0EUMhOsTVF4CFcOfLllaKP1jeB7mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yXKa9w6X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pUIcjLim; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 14:49:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747147758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKK54Rn44cE0lOKxQ25Io3SwfV+oqPsZvPgN7E2mfYE=;
	b=yXKa9w6Xa6wNwOtdhTqpNo53VTWs3qJ6snQOiXGr8ouZQOkWd8MK2oARoDHR8dT/+ubRyf
	0Fb0SD1lJp4/J73vR9x2pMcIjTl/udU15yPAU3ir74LkRYSCgmYd+xG/8sL9QxDUwX4qzb
	31MHJc96dg8Wj44nj3tr6uPWNRt/jUgjNEjcbuBRi8dW7XTwHHdSUC1oMJv8zPB7nq3S0t
	N8pfC67NTOgfGPlTMUDIuhqnay8huC6BL6qHavh4B/U1W0d561g40QJqIKIGIHQkqVvvSv
	coQaQaY2797S0ruaFUSXzbG7JUrbzFT9GvtxHEAWc7dEvJv7qd8wEpVtc4obsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747147758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKK54Rn44cE0lOKxQ25Io3SwfV+oqPsZvPgN7E2mfYE=;
	b=pUIcjLimWySQ0OfoMbEYcJAHqyb5jqPSpHCB99phdMrn2l/s5DYTcAN/fO9+erQcX2JQ5c
	iHGNcQ5iK6xbwvAA==
From: "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] tick/nohz: Remove unused tick_nohz_full_add_cpus_to()
Cc: Alex Shi <alexs@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410092423.9831-1-alexs@kernel.org>
References: <20250410092423.9831-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174714775803.406.6293002744771643287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6c58d2791d6046727d87db50a5e46644f195dcf9
Gitweb:        https://git.kernel.org/tip/6c58d2791d6046727d87db50a5e46644f195dcf9
Author:        Alex Shi <alexs@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 17:24:16 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 May 2025 16:38:03 +02:00

tick/nohz: Remove unused tick_nohz_full_add_cpus_to()

This function isn't used anywhere. Remove it.

Signed-off-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250410092423.9831-1-alexs@kernel.org

---
 include/linux/tick.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index b8ddc8e..ac76ae9 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -195,12 +195,6 @@ static inline bool tick_nohz_full_enabled(void)
 	__ret;								\
 })
 
-static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask)
-{
-	if (tick_nohz_full_enabled())
-		cpumask_or(mask, mask, tick_nohz_full_mask);
-}
-
 extern void tick_nohz_dep_set(enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear(enum tick_dep_bits bit);
 extern void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit);
@@ -281,7 +275,6 @@ extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
-static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }

