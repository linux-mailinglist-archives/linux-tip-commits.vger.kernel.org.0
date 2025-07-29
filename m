Return-Path: <linux-tip-commits+bounces-6220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D3B14AB2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B410D7A166F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8BE2343C9;
	Tue, 29 Jul 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Hr6MpVw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pijgSKhY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61051233158;
	Tue, 29 Jul 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779796; cv=none; b=VS7xOMwqXci0XJQ3QFrUVwL8qpu0K7y7Z0/PWWy9hVtfpUX0XND2RhtPZ9Qyb7QLGB9bJNgVuYyjyDobdE8F1EfYWlw4Ib1/l5qq1EDr6m7xPTuOykH1hV2m/6FhOnHiINYBT65nKt2mzFrEvUQA1GjXuvvXbmqI5bRmjwpAcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779796; c=relaxed/simple;
	bh=bXCJAuDlkQdamYA9BqBAhVJZuWsOlCjd4WSRFdakxVk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=a994fS08zjk4g+u+7LaTourOkWovI7V1pivOvc3eUVyu37YCQ0vZzDcS/tiHndQs4oEWBSz7pa9i3YCbAIth29PDdyd+cIe/MQtylm4RNJgBE2YiaRvh9z+iLG4fPRPdExv9ZjjJjHnzj6kYMIsOKSj4l9RRe+DURQIJ+Wihrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Hr6MpVw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pijgSKhY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753779791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=PP3lDhonAPoglORoTsV090gIft5h7SGt4dIcfcgV8uI=;
	b=2Hr6MpVwHFWwaKrngalfnpCQ4HzUDdYIlIOxDuQJCZBh6qLa9VTPkYI7Jrb77Wf66NY/yL
	YQhyx8vpNFBMlZgk/aWhRWZ6hy1SxYC4nAHkNLMgL3yIMSjkMQk6RcYaxE9ebobK7y4FjM
	l8AM9+vW5KnlrxOwgAxMxSUKRE2evoIQ/Wb05gsbZBNvn3hy+uqWSOwfl8qjfSM+S8ZbzB
	KT33Wc24Q5scMzY5uqTEgfyM1Kc5bNoroVL7SO+8p0/rGfobb15ZGDuAT9nBNP3qCeBmNE
	9LIryvt11WudvW5NSQgcK/0iUeQ5izcezVK2Fg7EuXAZYQXd2EhVuPufTkY4DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753779791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=PP3lDhonAPoglORoTsV090gIft5h7SGt4dIcfcgV8uI=;
	b=pijgSKhYcXOFtir6yQ6gsyjIJuGRQAym2pzE6D0rJWqcfO873xN2g5rs2TAo7sRLyUaGkq
	kBnVOKa/cAciYvDA==
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Donghoon Yu <hoony.yu@samsung.com>, Youngmin Nam
 <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>, Will
 McVicker <willmcvicker@google.com>, x86@kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
In-Reply-To: <87qzxznzjp.ffs@tglx>
Date: Tue, 29 Jul 2025 11:03:10 +0200
Message-ID: <87wm7rjrn5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 10:58, Thomas Gleixner wrote:

> On Tue, Jul 29 2025 at 09:58, Daniel Lezcano wrote:
>> just a gentle ping for the question below about dropping the two patches.
>>
>> On 25/07/2025 15:15, Daniel Lezcano wrote:
>>
>> [ ... ]
>>
>>>> So I got no answer for this question, but I suppose my assumption is
>>>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>>>> misattribution and a number of other problems, and also fixed various
>>>> typos, spelling mistakes and inconsistencies in the changelogs while at
>>>> it. Let me know if I got something wrong.
>>> 
>>> If the rebase is possible, I suggest to take the opportunity to remove 
>>> the following patches:
>>> 
>>> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
>>> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section 
>>> mismatch from the module conversion
>>> 
>>> Because of:
>>> 
>>> [1] https://lore.kernel.org/all/20250725090349.87730-2- 
>>> krzysztof.kozlowski@linaro.org/
>>> 
>>> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965- 
>>> aa05-05836466f81f@app.fastmail.com/
>
> Grrr.
>
> I've already sent the pull request for the pile. Let me ask Linus not to
> pull and I revert them on top.

That requires to revert 2798e90b4e09 ("arm64: exynos: Drop select CLKSRC_EXYNOS_MCT")
as well, no?

Thanks,

        tglx

