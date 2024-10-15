Return-Path: <linux-tip-commits+bounces-2465-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEB99FB95
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC611C230D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C441FE100;
	Tue, 15 Oct 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mdIKtJyc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yI78wrpH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF881FDF88;
	Tue, 15 Oct 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032091; cv=none; b=mhqWrZ9W6Lh43pwib/1mrmPaPYf2ry3+UhsVPcMajtsk2BaHBPP6uMFBR5T3J5u7Nj8NEZ3176FQBguM6Dpb+MPki1q8u7dBnVllitRS2iWJgluEA+c/EBva4NasFtAmYiGb/gX3oGCPyT4ppRnWVBAKUNO/265ZBW8rUFQiHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032091; c=relaxed/simple;
	bh=AS0I4qTokBJyZLUwITwN0vSbphIZBD3F2s5JCaTQRBQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TM0ZXLY7z9O6uPLdzLTacwMkpyI/UfFLgnIzJDns5Ri9feRsnmf90HjxhdnDzWH6CR3613geLC1SaVNcFTjuKtEBS3NDB4lDQQA97xEhLZR+htF61YlHRUubxUKI3qUupwxBBNBCfM2Nu7cxm4MVvjibi/wr4v5xAvOGLzBnoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mdIKtJyc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yI78wrpH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+osP8fV4t5fXfPtYaac+jIE2SWbvuX7bb8ONygt9/JM=;
	b=mdIKtJycPisxG0BQCWKNiEi7ZBTupy+TL06AhWRTjGPYO/Guy6ITJEtW25WLf2wcEr5mwb
	pwx82Umju+OmauJkADbulCqHbqRHJfmiOq8+TmBhmr6Q7PsdcR4Z0i8PsZKwWJUZ1EhuwD
	WrrlcXcHyu0ZJvJxRw/wC6fQ9jLG20HAS/GruqBPgTq+0AxzuDYPJE8/YQ20j5UriCdnvV
	ZLe5N4uiykjhyPN23FQ5t1Dj+DsU8g1mdaNnVA0O84Ks6h23n/tpECWucsnviNw8DYazKV
	xk+ippaAeSgsW5mqLsSwF3FN59RxTNm0/eT7HMyy9U2yiDDxFbH6oglEXTxbtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+osP8fV4t5fXfPtYaac+jIE2SWbvuX7bb8ONygt9/JM=;
	b=yI78wrpHhuP6SX9qJsDulu5UibCFNGVFAc/GuDyfUXQrs04AMdQqu/sWtibeMTi6bm54lF
	HrvyDwuZd6yY6yDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] MAINTAINERS: Add missing file include/linux/delay.h
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-1-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-1-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208760.1442.6070959485241343570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3a2e83d350950a84dddb0094c92e380f31fd5333
Gitweb:        https://git.kernel.org/tip/3a2e83d350950a84dddb0094c92e380f31fd5333
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:46 +02:00

MAINTAINERS: Add missing file include/linux/delay.h

include/linux/delay.h is not covered by MAINTAINERS file. Add it to the
"HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS" section.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-1-dc8b907cb62f@linutronix.de

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f319..b523625 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10162,6 +10162,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	Documentation/timers/
 F:	include/linux/clockchips.h
+F:	include/linux/delay.h
 F:	include/linux/hrtimer.h
 F:	include/linux/timer.h
 F:	kernel/time/clockevents.c

