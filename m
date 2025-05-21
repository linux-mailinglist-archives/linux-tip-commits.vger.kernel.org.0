Return-Path: <linux-tip-commits+bounces-5688-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74560ABF3F7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2111417610A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D357264617;
	Wed, 21 May 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wcXlsARP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGJH1oda"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681B256C9F;
	Wed, 21 May 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829757; cv=none; b=m/ancnqeLl89vU0svVWVqH+SGiq45GltzqFMCDsuvbP9DAIwidfTIptvaqxeZB3S5J7duogj8w9QbFk2tAs7kckfVk2UvZMPEiMgMiN27uB/vPS8HiewMTywXNLD12KFGpcbCleHFuBiEucSCxch0IFUkwNpJMjP36Amp+xCo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829757; c=relaxed/simple;
	bh=6T15vMULp20ZQWhslpd6gsqTF99YtAagX7UyovECD64=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k4pX8h6hBxiE1hN2NdPnoBR4yGGkMbIvnZjI6Bey+AOTnW3ML502Kq3BTat4kWQF2zB9srz6iIdTwzo4o4NqxLo4aOi4dLgc3BQW8uzxkkam1FBNmSFGumnvtYv3md5n8tunGtP1rUx8LzVrCvdtsrSEYxJiFfYlam1+y5+9KvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wcXlsARP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGJH1oda; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6MyCTmaC+o7QI0Ag3NSS8lvSIwjJUeuywSoyrRBxts=;
	b=wcXlsARPayy+bslX50htb/eEpRKgoECHpi43Piv5c9e3elfR8dLcE0ckkS+c/9mIv3ja6A
	+5xUvleWiu7/TEVLvRFXRHdu9keTunOrlmUIyZPfuyz+0X+L30BL7oaYGkYGWYxdsz3UO1
	CyyjABqIKPjR/JruGWsxVpP5sBUBTEea02Pn4wHVDLHwY1JM/f42tTlU35o2rk79StZw9z
	gU/JXXX//IIhNd/QRGnw1JvuaBpO8ZklbN9VqtQOOX9k1hGQQDIcub/SVcX8lKEMvM1/4h
	ynH/EAPY/b/LInFdhk6TYze81up8U6eiACn22F6huBfuregJx0FbkPEyy6GaJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6MyCTmaC+o7QI0Ag3NSS8lvSIwjJUeuywSoyrRBxts=;
	b=rGJH1odaA2NJHYJbhGde/2sp8dskWmAVqkSaSBFW5GnhOMbF2AM44QAG7DPX5MhuqscXaw
	x3eNWGLOp6DwExCQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] sparc/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-15-kan.liang@linux.intel.com>
References: <20250520181644.2673067-15-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975303.406.8766309661681342115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e4806c17bfd5d6f4363557854cbace786311d527
Gitweb:        https://git.kernel.org/tip/e4806c17bfd5d6f4363557854cbace786311d527
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:46 +02:00

sparc/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-15-kan.liang@linux.intel.com
---
 arch/sparc/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index f02a283..cae4d33 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1668,8 +1668,7 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		if (!sparc_perf_event_set_period(event, hwc, idx))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			sparc_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	finish_clock = sched_clock();

