Return-Path: <linux-tip-commits+bounces-6221-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB63B14ABC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B84165DE6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6F928641E;
	Tue, 29 Jul 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn/WyFe9"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B027CCE7
	for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780028; cv=none; b=Xn8wYlVPL5fuhBmzPwf3yE+zM8ib/y1a5QkM1IPCMLVQbVkWJb1GLiTD5TJlnTxGX9bYSOD/g5T0yqaxy3bKF2wvFCIXs9tkDeSEidd9PEC+Nr55YSBlje4lDrcvd6NaMLHlpnzolYEUaUahzxj4gbJup0i9AtPBmUiV4SO7Dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780028; c=relaxed/simple;
	bh=FdcNkA7Pi+bRDb3D1hAcfTfyRHlfb8uz7wLYbSXawTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o30JOxWM4Ax4PTGvX2CduXUvwXKk7BvaFZ7m2mdWiAxguBBujngW77gv84eOQPU8lJll3wzf9pONyS8zNPhcECweGjBO3P4MWfTiMUKDqOSnVpZXiU4tkjXYQaAPq1Jq7bnyOZS+xFMVrLGXPM0B1VKzqAj7cJg+S4IP9iMdmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hn/WyFe9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b784493b7aso100204f8f.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753780025; x=1754384825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fJKwzTxHL8umNKB9eFJO5KwPx3g3S+STD+8YbdE7yjs=;
        b=Hn/WyFe9uBmXAi4IvpBXq3od5EcLSURxzhBxlWh49ulUJyHkH+LOG5QjkAC/+NuTAS
         hJg1raRT9POFpr4C6+R3BeO0l/esi7y/vDgIjQuwmdT5ijp/d4871FnSvtGsdMVhaLmD
         um4YEEGVXueeehF41+BQ11D1smOuxCKD8+N2ieMJDmbvUqFdhB8XFecttzwxFgw7NQI7
         4h2UFbcKfj5uuTIXURjjZS12oSh5NwDpeavXkzbrLSaslj1auKZ5HtQ9zzywLwsVeD98
         ddqJC+0NGpFwFEn6gt3KdjC+UTZGF+a43jQDCQUb7sh3sWXAsnonenqYii0DsKi52ffD
         g00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780025; x=1754384825;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJKwzTxHL8umNKB9eFJO5KwPx3g3S+STD+8YbdE7yjs=;
        b=HNL6W9NqfhUJXvfL3KIlfxuTFsYhB/xa0g4cSaU776B5gTNLPLIUTqvxFaLqPL2HaW
         3WKarqRskSb/sZTxX0PT3ux8lDCyqseglsRY/RN4Jhflw9KD18BCTdyeelam+G36H3sO
         jTZFWDhBWzt8NzwVm5K/onIHT1KNmTOfQqcawjzqTsLCU9qot6EuDALqrULgTDbxByDq
         Hsmb536K5kTG8ZJbdROoqpJSX0m+DuUMLNX1MGcE8TJ2YnPejmRsKOPmfCFJb4Gm9ZKO
         vsacWG+L9BqEeAMpSGaEmBQV50AvuNg8dSF8EgNiFktCnV0sHb7Ml6jT0Man76tqSkj8
         MBSw==
X-Forwarded-Encrypted: i=1; AJvYcCWp3fbUDVnUNiOySy4nkOXJ2x7PVN2aVBNsdSdkqcOAXDEjEtYFx8cK6ghKtooZWWUifIilq437Q9AKuUNhiyF89Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYHWqkWTIVNDesyeZap0YHi6kgxtOoUNgXpLW0RkvCcG6BpxN
	iAFhAfaDxCT2wd+mOrGbTCpDmD0Gpkj9CJriU3GyzVJXaZxWfvWiFYAPkN0nYZw8lI0=
X-Gm-Gg: ASbGncs/zmcbBKgBYMGpXkoIKnFqYug2fBitn9yFNxMooO+c+zY55zTxLZ8bdPYyTxQ
	WCaBXaMh9wVlcNuMHMSp8OgschvGCbqmqdgft+I4OfVww6VCCDzZ1xFHdv5PSUFnbvtjK1KnwOD
	KOcAyOCCeiVGjzcFWwhe0DwoP7nmj8wgFbRNPs2k3wGxQ5XrqbNh2KMlLPh/TYtqdMpllKz7MKf
	xhaK1r5BuWlUhQADOmfiJa/ONuXFR6UeW7iS1DgbS0qlljQ6yoCLwLmpSjJRdvL6j/dnGKVomaZ
	ly/kcCasfFH/sNdBmCQpfwJQ7M1dF9dC0fVhz2Pa/u/inwtKGKGyIeYJnk9hlU7pHl3Lx8VLMbv
	IfOiG9kJ10ux9sBAAUn5WQAfD5pPZpHDn2PyEFthSUDI=
X-Google-Smtp-Source: AGHT+IEx3VMnoCCaTLB2AZQf4568sfpkb1ptQ307UEHFkeCyi0+s4zByH/8ghzWmmbRHKX7Qh8Uvfg==
X-Received: by 2002:a05:6000:2405:b0:3b7:8c98:2f32 with SMTP id ffacd0b85a97d-3b78c983054mr1025103f8f.8.1753780024648;
        Tue, 29 Jul 2025 02:07:04 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b790ec4dc8sm1536335f8f.53.2025.07.29.02.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:07:04 -0700 (PDT)
Message-ID: <edbc9a30-e0e7-4f89-9747-0770eb48e199@linaro.org>
Date: Tue, 29 Jul 2025 11:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
To: Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Donghoon Yu <hoony.yu@samsung.com>, Youngmin Nam <youngmin.nam@samsung.com>,
 John Stultz <jstultz@google.com>, Will McVicker <willmcvicker@google.com>,
 x86@kernel.org, Arnd Bergmann <arnd@kernel.org>
References: <87wm7rjrn5.ffs@tglx>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <87wm7rjrn5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2025 11:03, Thomas Gleixner wrote:
> On Tue, Jul 29 2025 at 10:58, Thomas Gleixner wrote:
> 
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
> 
> That requires to revert 2798e90b4e09 ("arm64: exynos: Drop select CLKSRC_EXYNOS_MCT")
> as well, no?

Yes, indeed, I missed that.

Best regards,
Krzysztof

