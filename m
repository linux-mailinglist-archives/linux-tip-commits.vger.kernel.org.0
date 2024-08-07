Return-Path: <linux-tip-commits+bounces-1962-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE894A647
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 12:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4519C2809E3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E71D1F46;
	Wed,  7 Aug 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHuqdBBy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RYkKr+Uk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815581E2888;
	Wed,  7 Aug 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027906; cv=none; b=R/xAEe3Xz5kQJTqWB0WRBJqk2U3Hyy+Gi6p8Ub1xyxVf7cj5oml/5s6jf0NyWhqesY8Qeas2iHIqe3Irs7B+Q2iv+GaddLGpmi3/ROHRa5cw0DMO/czDlfLkbSSYIsanFhFjo5c9FLQjwU92UXBsIj+ek3l9kvlCgkiXRzt0fis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027906; c=relaxed/simple;
	bh=c/PdH/QxJLbBhZd1X/61Nc8goWfJM6IJezUv/oKyHMw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jSZxZqHwmZmafHNTZEg29Ir65JgJ7gfzssijkGIo3YV010ezs1GCgOdgfuvwArXeYQFjHvCCtEmRcDiWsCE6Mihmh7n+0f/Q9eqbg86y3Ud877K1qfJamh1iLfMERNh6BpdihWJxwWOwpLzf3OjbeolXD0SpuFwl7YRg/J29l/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHuqdBBy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RYkKr+Uk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/U/5DR/mP7HM4ElHHK/lrkbbx25rjwrSOO0N+egN6I=;
	b=hHuqdBByTAgBN1bM8G2z593EKXecrQo9ZdPqohRO9nw+BAGMl40DZ9Yd5YOLuB0bPvkT40
	1oIVC8WJk9aYZCNOFqXDNp28R/EBLO6TXX98b1c4jCtkyL7XOy43mavbTUYCwHBhjR5C4l
	irhps1kCCVZdOC3n/qP5K6iw3WruPlwtLZmbrge5qb0oh35mthY698frD7Zr/pZPmaseT6
	+BUxapBMbqcCcFKUlQ/7E5uG8v1tyEqQwtxNdKhdwnv6Ol3xk9Fdf5p60NYvgJjFdZ4gia
	742qyUDsJIu8TALI5YVjNVy8Z3tO/sn3ZaH6xXtkSuK3SfPgznR8DZYIdZvROg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/U/5DR/mP7HM4ElHHK/lrkbbx25rjwrSOO0N+egN6I=;
	b=RYkKr+UkqcPfnoXT6nl3vGIh0BmUu2vTQOAldUXYsZh+u0tdzzrPm4QJVY4Ii7oJyn03Cj
	OM5b7r/zCrNQiYCw==
From: "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/bts: Fix comment about default
 perf_event_paranoid setting
Cc: James Clark <james.clark@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802105256.335961-1-james.clark@linaro.org>
References: <20240802105256.335961-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302789647.2215.14933930438196226723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ea1992f36b894fe60cc3537a7f6a7af4087b999a
Gitweb:        https://git.kernel.org/tip/ea1992f36b894fe60cc3537a7f6a7af4087b999a
Author:        James Clark <james.clark@linaro.org>
AuthorDate:    Fri, 02 Aug 2024 11:52:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:47 +02:00

perf/x86/intel/bts: Fix comment about default perf_event_paranoid setting

The default paranoid setting was updated in commit 0161028b7c8a
("perf/core: Change the default paranoia level to 2") so this comment is
no longer true.

Signed-off-by: James Clark <james.clark@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240802105256.335961-1-james.clark@linaro.org
---
 arch/x86/events/intel/bts.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 974e917..8f78b0c 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -557,9 +557,6 @@ static int bts_event_init(struct perf_event *event)
 	 * disabled, so disallow intel_bts driver for unprivileged
 	 * users on paranoid systems since it provides trace data
 	 * to the user in a zero-copy fashion.
-	 *
-	 * Note that the default paranoia setting permits unprivileged
-	 * users to profile the kernel.
 	 */
 	if (event->attr.exclude_kernel) {
 		ret = perf_allow_kernel(&event->attr);

