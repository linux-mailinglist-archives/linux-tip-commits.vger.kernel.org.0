Return-Path: <linux-tip-commits+bounces-1612-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62444928E85
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F84B27FAD
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA1178361;
	Fri,  5 Jul 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O48c4yuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzs9zJid"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D78176257;
	Fri,  5 Jul 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213609; cv=none; b=sY1pxiHF86W+zwDHfIJQubUy7zwMgRKVqpP0i+1lU6ouiD2lxW8K15Vy5XDh62FEVYuT1egGMAT4CyoCfgpGalm56ah7yGWJzd/PgSnxC9LUbaaxNenAzBY9UL80/7XWQOWY+Q5WuPSLfQQ81z5CZG+LnGHx4nFiobPf8eS5vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213609; c=relaxed/simple;
	bh=kTYss+u12XzFYYidwOHPgwzPw8CURDlGNgPyBiWtNUg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M72ytb3aeew2Vx0PdvgrDL2DXDRqkowXF9V9BX9qLdvW3mfVZEHiclG5ZVMjKrzGAtSeXE5vG8b4u4waPnH1Ial5VMjnbwE+PgJ5G8I6cvMR5JbRMJof2KmveKygL+gMvti5xOOY7SRmI4QP3S/JPENxwEvTpUOIG6OTjBZdg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O48c4yuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzs9zJid; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2w01L2sBNeyJHL7OFlBlsWjFB1vvK0mpw37VTzv2Ik=;
	b=O48c4yuqI6yxXTgXaVo3O9Etrguf4+oa027R+51elono2u8C0Mi3r6jBdJSkrGGQuUnC5X
	eZImFnwqnlOga8e2bqBp+fUR+EnoLsgfjI6vJ7XPxCS1fxFTUyksTNvDhbpFCByKUGBMCO
	KS+iQNsrNu6NJRNcJls4RzPgQwDdogY/rRd2nkW+wk2df1kETJgngLfFswy11rQ1+9T3LD
	d6hTwFwCu/VFQkqvQ3fQP1R3QBK3W/mKSm8bSwLhg568vFCH3WXh9F0PkpLSvGbnYuuvKy
	pOpOqyLe2JontCwUBwWlLbW6938XOT3cbdUjtPTDnUXqu1eX6OTyGm6WmT1n7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2w01L2sBNeyJHL7OFlBlsWjFB1vvK0mpw37VTzv2Ik=;
	b=vzs9zJid6BYAxXtGptY2A4eQg0oXRf5lGCU2W5Wh3Jec7Qt2y+xsN/GGnv1QIaKNo6g/Tv
	TuCcR4e085x4J/CA==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix default aux_watermark calculation
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240624201101.60186-7-adrian.hunter@intel.com>
References: <20240624201101.60186-7-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360548.2215.11914104138278947134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     43deb76b19663a96ec2189d8f4eb9a9dc2d7623f
Gitweb:        https://git.kernel.org/tip/43deb76b19663a96ec2189d8f4eb9a9dc2d7623f
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 24 Jun 2024 23:11:00 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:23 +02:00

perf: Fix default aux_watermark calculation

The default aux_watermark is half the AUX area buffer size. In general,
on a 64-bit architecture, the AUX area buffer size could be a bigger than
fits in a 32-bit type, but the calculation does not allow for that
possibility.

However the aux_watermark value is recorded in a u32, so should not be
more than U32_MAX either.

Fix by doing the calculation in a correctly sized type, and limiting the
result to U32_MAX.

Fixes: d68e6799a5c8 ("perf: Cap allocation order at aux_watermark")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240624201101.60186-7-adrian.hunter@intel.com
---
 kernel/events/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4013408..485cf0a 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -688,7 +688,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		 * max_order, to aid PMU drivers in double buffering.
 		 */
 		if (!watermark)
-			watermark = nr_pages << (PAGE_SHIFT - 1);
+			watermark = min_t(unsigned long,
+					  U32_MAX,
+					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
 		 * Use aux_watermark as the basis for chunking to

