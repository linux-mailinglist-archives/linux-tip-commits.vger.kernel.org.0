Return-Path: <linux-tip-commits+bounces-6223-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9123BB15107
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 18:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CD9179C61
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DC220680;
	Tue, 29 Jul 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+058Bpf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqwD334Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389071DFDAB;
	Tue, 29 Jul 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805642; cv=none; b=BL2BtSNGHV5lLl7jBI7MaVaQFuTIG/1q+pu902+aeohNNgyYFUuxcv8ihGjlDr096MMdfUPZQ1okIpiUiJZXLP2QFW1OKwfqIsW4nv8wTh+3Pb9klr8i+hXoDJhJQnzaTvQF9vAZovYubMr9bllW+cCUhCCUkCr6g4DcOkFk3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805642; c=relaxed/simple;
	bh=pV3LNYldhtBosLmXQRQYKWBEIvCzDtv6oLzKvSSwzUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntg+Lj2HvTFMlsCYfD0qqVFNaYbpisSHaSsWleMghJVyIDjz0I7wi6SBBsWB9coh2RQy5umvV1xvkILas9+vpj0ZTDeVTSp2dnvZuUtOvsp7sNrzxC98ECHCHhmm0O0Zd4yKMrQQ4EAV6acVqntrrIhfs6H/2IuPi+AAu2vT294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+058Bpf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqwD334Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753805631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tphrZ7tgunzrj0u6r8O3+rF1Sn1T5aRxXhkxMP/SIVY=;
	b=g+058BpfVd//wYBoFfslDcHlFM8DyTFQTGVAR5PM7bFue+42R3kgoBFhj8tIPlGh31pRBu
	aT7LTvP4OQ2yPlw6y8LhmLzbOCDj/8gnHKDJKyj+CnPhzVGezvV/AN72gQlgKA7RR7/UpS
	7vwcMoVS+tXwGD1NqCiOnlsmlGONYjp9rLfs88AHDXBYtgUiySEEfX54nIwTIhPJH858n9
	IuOmo5IqoJSEoyL48uDl6sPaX2DCklqKCCKrDbwlWw+hKZUOLRRuGEHPNkKfrp288zA8+f
	J3icH/ogK19HcnTrrGaDlO+aCkSzPnhPlPQ43ZMzZpfxKNdpPiIa5+pJgDzX5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753805631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tphrZ7tgunzrj0u6r8O3+rF1Sn1T5aRxXhkxMP/SIVY=;
	b=TqwD334QSTMio5L7KPcel/Layn9PvSfmQDCRaTeW9aqjoAT+YEMVZDWiTUVPWJ589cK1W+
	SO5jsqE0t8zIvECA==
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Donghoon Yu <hoony.yu@samsung.com>, Youngmin Nam
 <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>, Will
 McVicker <willmcvicker@google.com>, x86@kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
In-Reply-To: <920c5a0c-6ac2-49a1-8dbe-17761379765e@linaro.org>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
 <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
 <aINdu_hrz6zJnBGb@gmail.com>
 <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
 <162ef225-51d5-48f5-bc00-36e00e905023@linaro.org> <87qzxznzjp.ffs@tglx>
 <920c5a0c-6ac2-49a1-8dbe-17761379765e@linaro.org>
Date: Tue, 29 Jul 2025 18:13:50 +0200
Message-ID: <87frefj7pd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 11:13, Daniel Lezcano wrote:
> On 29/07/2025 10:58, Thomas Gleixner wrote:
>> On Tue, Jul 29 2025 at 09:58, Daniel Lezcano wrote:
>>> just a gentle ping for the question below about dropping the two patches.
>>>
>>> On 25/07/2025 15:15, Daniel Lezcano wrote:
>>>
>>> [ ... ]
>>>
>>>>> So I got no answer for this question, but I suppose my assumption is
>>>>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>>>>> misattribution and a number of other problems, and also fixed various
>>>>> typos, spelling mistakes and inconsistencies in the changelogs while at
>>>>> it. Let me know if I got something wrong.
>>>>
>>>> If the rebase is possible, I suggest to take the opportunity to remove
>>>> the following patches:
>>>>
>>>> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
>>>> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section
>>>> mismatch from the module conversion
>>>>
>>>> Because of:
>>>>
>>>> [1] https://lore.kernel.org/all/20250725090349.87730-2-
>>>> krzysztof.kozlowski@linaro.org/
>>>>
>>>> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965-
>>>> aa05-05836466f81f@app.fastmail.com/
>> 
>> Grrr.
>> 
>> I've already sent the pull request for the pile. Let me ask Linus not to
>> pull and I revert them on top.
>> 
>> Also please reset your clockevents branch so next does not have the
>> conflicting SHAs
>
> There is revert otherwise above [1]

It's incomplete :)

I just reverted all three exynos mct related changes on top of the
timers/clocksource branch and pushed the result out.

Thanks,

        tglx

