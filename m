Return-Path: <linux-tip-commits+bounces-6190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA32CB10637
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jul 2025 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2C25A3FB1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jul 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB6F274B21;
	Thu, 24 Jul 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tLQab+Yf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMwGyXqK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145962874EA;
	Thu, 24 Jul 2025 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349152; cv=none; b=Aip3eZQX1k00a73YYIIZ7pbvWwGMFEor4TFzsCouxyRMAB1GMMC7A/V33GwgfhLXP1OT2cV7jNIXJK9e2EEfzI7qpx2MeQkRMSiX8XBbdK4sn6OEmSBmQ7FtjY0C94kxITfjC6IX/q9NdiJFkXWE3Xli9Kx6e8BdEfpsS19Xqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349152; c=relaxed/simple;
	bh=nxydvYHeLJVnLLoAeJ2xx+dXc2eafYJihl4FKDBzVbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BETFLal0Lj94ewSDChMCaCrEsrJ4TxUSzOez1CpWIC6GlJFlMUX4ZqgDcvFQ4tg3aCqouTV+21a+lbvy00TkKiVZ6FOgXRhNIsn7TwJIF8iIVQ6ojXVP4uJS+GAK1iWXRXXTbNpHG3m3qH5y3EmwOyJ1dzz4dsEvZW11bhiiuCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tLQab+Yf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EMwGyXqK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753349149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKAyM7SxSaeQpQ9HIU/9eKyj2brypW2xg0FICqpn4UY=;
	b=tLQab+YfYIAMw6nGO0zO1bpEkSlyHMcOkSMl00M27FtsznJB6b1fWxWnU8/rH1Gw9bK801
	GWUuE/Yx+ADhQ4wHPTkwpia811ev+Y903vmDFxApz99/HAedGtq4OqpAgDN1PdiKvNzcqV
	g3kR7mggqg9XNp5z9U7WGRv295n+NuFRpKDCFccA+FZw8LciKyHOgt4jVzx+4T1p+AvSIf
	h4YEsV+Y7bKQ5L4+yn+0LCC6jLjMBEO8+Wd3LQKz1IFAD+1yuY9QVP+onJv1J5VvQVS49e
	XUSbG8RHqeuSlosXuclyCzKwye1GPp5dUerbBbPL3eR87/Bq74NLG3IM3tn0vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753349149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKAyM7SxSaeQpQ9HIU/9eKyj2brypW2xg0FICqpn4UY=;
	b=EMwGyXqKuzCfgEqF16wWiJXagRcOmwg6JhJ4KYvvNXkyaHwlZn2zDv/F4ijwih5SsY5daN
	rSludL4ehIS4BICQ==
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Daniel
 Lezcano <daniel.lezcano@linaro.org>
Cc: linux-tip-commits@vger.kernel.org, Donghoon Yu <hoony.yu@samsung.com>,
 Youngmin Nam <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
In-Reply-To: <aIHClG3ftSeP04QW@gmail.com>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com> <aIHClG3ftSeP04QW@gmail.com>
Date: Thu, 24 Jul 2025 11:25:48 +0200
Message-ID: <87qzy6q6sj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 07:20, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> The whole SOB chain of this commit is messy and has several serious 
>> problems:
>
> Not just this commit, but most of the other commits in 
> tip:timers/clocksource have various problems in their tag sections ... 
> I only checked these more closely:
>
>  5d86e479193b clocksource/drivers/exynos_mct: Add module support
>  60618eec98f0 clocksource/drivers/exynos_mct: Fix uninitialized irq name warning
>  10934da577f6 clocksource/drivers/exynos_mct: Set local timer interrupts as percpu
>  394b981382e6 clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64
>
> but all of them have various problems. And literally all 23 commits 
> have the Link tag misplaced in the middle of the tag section.

Duh. I did not check when pulling that lot.

