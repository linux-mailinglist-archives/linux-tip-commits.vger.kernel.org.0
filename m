Return-Path: <linux-tip-commits+bounces-6219-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75831B14A8F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A515C162B07
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CAD285CAF;
	Tue, 29 Jul 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="neIpJ+5z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B2Reyifg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FF2857CD;
	Tue, 29 Jul 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779533; cv=none; b=HdOFLiFP9xVOkeeRUl9wE5ZUGuDfyOK+dl56Al3amURGopbiFFTz0hH8wff3iOmOrseA/Y7iu7Am4uwlpgCT08AiCMIpZTZtR5orMld9mM9JRYhZlgHVpJkYXG2yKo2MmsvoaBq9C2yvBkir2gV+vQrXOl2ls1WLjj7u+G0h8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779533; c=relaxed/simple;
	bh=cw8L5FN9SXqUXbIM/cenny2yih0F/V1C3L8r1erdeHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D36HMSfqB6xuJ8SXnM421nVlNiGqqjXQnfcAh2jhQLvwc3+9zM84Zpt5XJ0fovl0qYime6XvizaFnQWQnS5whlZOLLURFlyiVRs5QCAkD/26D/RgWc9ef0ko1xfpViWhyXrphMKrttoJXD11IGGf9h3GUaCAALWsHr4OR6qvEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=neIpJ+5z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B2Reyifg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753779530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYNBRkcGEvHvsFEEfFNnlXqdh9tNgeuLignmZLW4sSc=;
	b=neIpJ+5zJwkNGapxRW0i8LVyblJWB6nhKOHwOPKhaMjNuvAmYpkLdUFfmxRUBIz85tULq2
	uxTt1EgovKg/AxVJZ8u6aevle52jrPOm2MhbVttQUOhDQrj0ETRiY5Z5xesPzW9gMX02Wx
	tDi9j+jjqCKU3VRA0jX4r/8qOV2wYv0oq/aLGetdb9D2lXIrJFEt3SHfc5Ky8iBQDCbanR
	/qdXSk6FuF72vP2bbP9pwFqbeqv3iDnvlMwNlzE9fI/Lke2ypetCzmDn9faOetYuex8pHq
	xk1xFdnbHy2k3X0a362JY7ENl64vz5LOCZOHWyfhOju2xZJ6g7n9m4+pZM1hEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753779530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYNBRkcGEvHvsFEEfFNnlXqdh9tNgeuLignmZLW4sSc=;
	b=B2ReyifgiqVOeFlfVkXUHa71n+ld31RJm6xa1VvidIxIiAMgSfJy2jbT/gwmG7eWWuHZo+
	Vmu3HGrEr0CIfkBQ==
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Donghoon Yu <hoony.yu@samsung.com>, Youngmin Nam
 <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>, Will
 McVicker <willmcvicker@google.com>, x86@kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
In-Reply-To: <162ef225-51d5-48f5-bc00-36e00e905023@linaro.org>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
 <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
 <aINdu_hrz6zJnBGb@gmail.com>
 <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
 <162ef225-51d5-48f5-bc00-36e00e905023@linaro.org>
Date: Tue, 29 Jul 2025 10:58:50 +0200
Message-ID: <87qzxznzjp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 09:58, Daniel Lezcano wrote:
> just a gentle ping for the question below about dropping the two patches.
>
> On 25/07/2025 15:15, Daniel Lezcano wrote:
>
> [ ... ]
>
>>> So I got no answer for this question, but I suppose my assumption is
>>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>>> misattribution and a number of other problems, and also fixed various
>>> typos, spelling mistakes and inconsistencies in the changelogs while at
>>> it. Let me know if I got something wrong.
>> 
>> If the rebase is possible, I suggest to take the opportunity to remove 
>> the following patches:
>> 
>> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
>> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section 
>> mismatch from the module conversion
>> 
>> Because of:
>> 
>> [1] https://lore.kernel.org/all/20250725090349.87730-2- 
>> krzysztof.kozlowski@linaro.org/
>> 
>> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965- 
>> aa05-05836466f81f@app.fastmail.com/

Grrr.

I've already sent the pull request for the pile. Let me ask Linus not to
pull and I revert them on top.

Also please reset your clockevents branch so next does not have the
conflicting SHAs

Thanks,

        tglx



