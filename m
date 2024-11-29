Return-Path: <linux-tip-commits+bounces-2895-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B59DC260
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2024 11:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1933028204D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2024 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C3C15AD9C;
	Fri, 29 Nov 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vMGLzqBN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/a5s3z9g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702C9463;
	Fri, 29 Nov 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877307; cv=none; b=bbbaIWWL4B7qyTmCySZ5Qth7Wc/Nw4YlkpGWtpY+emgUds6bDKPxvs+8J4Ez1zfLh5AKs1rgvHSyLJO9QmTt3LEy6YFwFShR0h1czf1C+yrQr1egFRSCTXy+AKoTpC/2G2qYEN/3n9i/de6TLykwacJ3/bxRyi+n6XXx6SPE16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877307; c=relaxed/simple;
	bh=cMa1ktPMFbcpbBLWZPa3kNgET8tp5x46wkDZzO/Y0JQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OLtKsQiSGZxUPYnIe0NSy2s8xlmlmFxrvKoDP6DyNlqfBApKRQ1uhwmjREmk+KyEXE8TDrHoYLN0BPJWGhEht0mMDj9+k35gxZdjY1sSESN5LKdggdLHDd1vfyLB5USyz8ltQXNoV1I9i8z2RtcAy5OKXml/8SkoFUzK5w2Vsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vMGLzqBN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/a5s3z9g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Nov 2024 10:48:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732877303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZFTFhtm2UUBOxmPi2MDH/89rY4j+aU7c3Yb1Ug7+d4=;
	b=vMGLzqBNWSJSy7DsWLHk13PDlhbvQTDWY4EUmE5tqRSPimEFiPLO3JeHra1/L01U8y0Q6D
	ncYRTkdZ7HQAFOhyWN/pdS9Xaa4TWFxylczmeGt+RdwlEUae/9XyKP8siNskOYpg7hXvIP
	RIz4hqoxfEDrPYyws2qfWMt0O4gzlacWmjDLG9Qdfw4Wix2jr8meqqFyh7xVE29O66/MMN
	Cn9+uFAcnnhAcgnkSIBOnrmk+fOIe2GQ5NDhhYGcBCz+tnCIhdjgPbaXlq2Q16gOmDTAgt
	hoFh8CiLDocdn++Jtgb7MSHyNhpoNszJGbyF11ATI0j4M2M8wAyeN4dwXBxFPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732877303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZFTFhtm2UUBOxmPi2MDH/89rY4j+aU7c3Yb1Ug7+d4=;
	b=/a5s3z9gFwTgWXS0bWAQp/baN1RoZG8annajkAC9YGeTOgFHDMfQVZZEx60MYBtwaLJlyy
	vEMdxdkjyqmRt/Ag==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] delay: Fix ndelay() spuriously treated as udelay()
Cc: "Chen-Yu Tsai" <wenst@chromium.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241121152931.51884-1-frederic@kernel.org>
References: <20241121152931.51884-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173287730233.412.16769417461165655460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     4d17c25eaf5d8b95d70726e6946e8eb94619e139
Gitweb:        https://git.kernel.org/tip/4d17c25eaf5d8b95d70726e6946e8eb94619e139
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 21 Nov 2024 16:29:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 29 Nov 2024 11:40:22 +01:00

delay: Fix ndelay() spuriously treated as udelay()

A recent rework on delay functions wrongly ended up calling __udelay()
instead of __ndelay() for nanosecond delays, increasing those by 1000.

As a result hangs have been observed on boot

Restore the right function calls.

Fixes: 19e2d91d8cb1 ("delay: Rework udelay and ndelay")
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/all/20241121152931.51884-1-frederic@kernel.org

---
 include/asm-generic/delay.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index 76cf237..03b0ec7 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -75,11 +75,11 @@ static __always_inline void ndelay(unsigned long nsec)
 {
 	if (__builtin_constant_p(nsec)) {
 		if (nsec >= DELAY_CONST_MAX)
-			__bad_udelay();
+			__bad_ndelay();
 		else
 			__const_udelay(nsec * NDELAY_CONST_MULT);
 	} else {
-		__udelay(nsec);
+		__ndelay(nsec);
 	}
 }
 #define ndelay(x) ndelay(x)

