Return-Path: <linux-tip-commits+bounces-5687-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D402ABF3F6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F4E7AC3AF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30D22E3F7;
	Wed, 21 May 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ftGuzpAV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Pb8xCz/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5195242D6C;
	Wed, 21 May 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829756; cv=none; b=YftS08kE1hFyxwzCL0l4tMSo8VWfiuPOFFsseltvbcbUub8YQ6Zmj68ELkBoCarW3a+DJQAfy6kjaUYUsEgTdqQhgIaQqDoXwQBzx1edtgbnhJJ2NjZyiWSmuxJouuzbrQEZZRFB83h1euFnlg4OX2znCmjB1pB1UFq5MyLgFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829756; c=relaxed/simple;
	bh=+m5HzJjZIA1R6I9jF5T0Q1Vay9RLh+k7exqZoJl4Y+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ktXr+Z4kWgBYtdOUkzlTvuTdWKj87r0o53/cH7alM24HmQoHR+ibTX2W8s+BuhdPNm/kJqtUaW1/U9v5cJvTEFzotJ4TpIQ8sc/ZypRIv3SI6qB25hlV04GuQn+b5KMtRH65jnFEtjby46QzdxzoLxOqsUhRgW7IBfv3lLss8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ftGuzpAV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Pb8xCz/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoNcbVWHvTKmgQBh2M95JspyF1bJvBvffCIAKqmlAwo=;
	b=ftGuzpAVS91fYwcSb4j527hO02AYD2PBMlAjwr1bqY2cx96dpCh+FfpJfL3UTlytTFUunR
	ecefBGiZ8yN1paPnehdmMswArc9HrmtBmSJcHUeA6d2mQm/KTQNa5WZd4J2cYRZeZqVuzN
	t6H6o3PzG43B4rR/TPkn0Bkf5DZJRGkWQYmFoXorHTAj11o1AtEmE3xRYp5a20rCcA4RBX
	UvdEOfe/H+yFyGW4EsgtC8kLzCWDqag9Hk72yweZQq2fLHYbYspVWSQJBqQsJ9g7CXPNix
	SSDkyZEtOZgGlvaRwemBSx3Q5gqOXvQb6TzpMQlL8t7grBfYJY0bvLQmwFuIlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoNcbVWHvTKmgQBh2M95JspyF1bJvBvffCIAKqmlAwo=;
	b=3Pb8xCz/oikuMIE2QhydiMS4kZAGDrge/WvQHqRWkDX5MNaq2iaboPVjSYuncN2E5URe3y
	M8+aDS1TH5+NmoCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] xtensa/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-16-kan.liang@linux.intel.com>
References: <20250520181644.2673067-16-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975207.406.14252971067490475945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5fa541ab04fcdb5ca1257143802fbd9028c13ddb
Gitweb:        https://git.kernel.org/tip/5fa541ab04fcdb5ca1257143802fbd9028c13ddb
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:46 +02:00

xtensa/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Link: https://lore.kernel.org/r/20250520181644.2673067-16-kan.liang@linux.intel.com
---
 arch/xtensa/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/perf_event.c b/arch/xtensa/kernel/perf_event.c
index 1836180..223f1d4 100644
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -388,8 +388,7 @@ irqreturn_t xtensa_pmu_irq_handler(int irq, void *dev_id)
 			struct pt_regs *regs = get_irq_regs();
 
 			perf_sample_data_init(&data, 0, last_period);
-			if (perf_event_overflow(event, &data, regs))
-				xtensa_pmu_stop(event, 0);
+			perf_event_overflow(event, &data, regs);
 		}
 
 		rc = IRQ_HANDLED;

