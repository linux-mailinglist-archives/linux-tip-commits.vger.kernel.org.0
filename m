Return-Path: <linux-tip-commits+bounces-6225-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF4B1514C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 18:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8FF3B46B4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56C19644B;
	Tue, 29 Jul 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xz3JdEo1"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BE226CFF
	for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806475; cv=none; b=lcwbS4uPf0GKGaaISALwjNsL8nZSbhDTQnpG6Kb4vjKMqoyMHMbV68W6zoZM9Mlk2LebmcY7/tZzbLzIUTnabV6nSPB8io8CtxxBWwr6LEZOeVZ8gozYYXcdWVP5R9FEJG4Ijow/AQ6wIG3nHoyzYDKSY+2iGlV44AMpf5B8o4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806475; c=relaxed/simple;
	bh=PtfTh9/5EjYP7cCIAc8vupIcGt9u0ol0XId1dZQt8dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKtuxesa1VvxW3tKyQr/2jfVxQM6yx3/b+lvkBYX8B1geC5j5hPHYIyA53B9iWx2Mp7KpjdYS3IlRQFTJ4YZ2v1FVIoCEn2k/cTtOODLhv+7L3aUrdbaJY1gix2mlUS2K2nFleUA4qgBU/G1V4MC9qIkcf7aWdeaBxLxVcu/oPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xz3JdEo1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4560d176f97so59950435e9.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753806472; x=1754411272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7A7RLDUsOcYWlXRCgS940bPzn/qiZ8ZUn6ZRMAh3pp0=;
        b=Xz3JdEo1vTiVV1LUV3aFRg5RmxDY0xrWmb7ZCOnKPz6FpBTcmlAOMDbRSamldghP5Y
         XgrZBBGUg9PDCWJd/e1B4mevc/vtv1CgX69PXY/pTAgt8vDH210LYlpwjUEv5kw5Ow97
         rPVKcS2FivD7Y4aqGpjNEpiQiTQzz8qIFTuQnoXBKscVZaKgiDMbHf4X//aT5D3L3/lA
         h3jHXfES+R9+fylB52mDCfm0V8YiKZcT7tPsuwz3N5O6qbX/J6agT5yPs1P9zNpqG6DE
         4oyTS5LwxsVHUJohxeLwXJeqRotF52CNGeDf+a4S1W49Kb9vHDP316EN+E0D1uORIa3g
         RBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806472; x=1754411272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A7RLDUsOcYWlXRCgS940bPzn/qiZ8ZUn6ZRMAh3pp0=;
        b=Pu3Z5ZcYujcuA82nZY6Rg4BG6LhrepaD8R5633wuHv4b4AmATs8cC0KHB5UTEt4VZU
         pbOV5ebTlhV87U64ciG6mzLjjjQ/0UfX1jin4JhsY7U7qYXgctOwlcv/tRlKnuyhghK8
         kwFLOv8YCEFb7E2i7fPt3BbnhBfEPUlsk7cqgDQjho7QPoRWLLa0XeyHQv06OUpTegCx
         Fl5XxMnDhMcm54lv50DnFbqWweTy9eBl5Y4s15zv/jUnw7IfsH6jr3HeTRcpSm+jLK8v
         LEYNLecNSZ9wx8gT0y8V2Xnzdc6UEl3afQcd/050b8v42rYpWBjWhkmiuln2hzn3vf7V
         IeGA==
X-Forwarded-Encrypted: i=1; AJvYcCUln1VrolgOAhyaK43aAZ/GFCf7iTb5ndUCp5sYWGeor2BLILf+iXHguRFDtg8mstv5BOubTB/hE7RO6XDO9K6KGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIyDXoJS2KOlJi4G9bsCpFWkXdPr35lYqYg7tIvDXNwqlyXYT
	5dni88IzjV/y0msJE82tC231x8sgA/3vlvI5ggKbs+l37aOCKLIqFtHCp5ZmRO3Dk5Y=
X-Gm-Gg: ASbGnctYMO++z0v6lodRKarITKAb0XVLnWBF5xHXPzkIVMgb3AcF83eskQh2i3/nINW
	yAshEv079fV4mdO8LkIgkobsBYrgXyQRCm0QFNqHP6Koox8nUHgEklOi1ro0BlTPaLOn8wVK5Fs
	+WkQrC1X6t1NEDkfgb9pb3G2Q/XagXhu3XKO9jExuAkRYQ3n0Gl8aZPXQ6bGxRGVU+QhtdaFZ10
	mz7tHpnwSkzQ7ZwOZaZEzXHaOo0UwWoUp+hAuHIZwFwY+uyf9t8Be6yVZdlk/lJhFhTeT3gSbRZ
	CohtAW/Gc37zc3A4Z+f32CpkDg/H+NCDkSdwb8vnaBPNbVW23Ih4YFD8mth5RrHKuzaKUDv8yxi
	pzHviQXMphgK3UK9yAh3nVKmLBz0aTJVuw2IGFR6+2zw6clMYbM8+kBsRlyXTJg==
X-Google-Smtp-Source: AGHT+IHp9Zc3/dVoGDvaHUfbhAcLiJnGhZKm5gZA3joiIGW+r5lfXTxBNZ3YixZSGe6e8hK+NWThpQ==
X-Received: by 2002:a05:600c:5195:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45892b9da2dmr5059105e9.10.1753806471744;
        Tue, 29 Jul 2025 09:27:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705ce685sm202071465e9.30.2025.07.29.09.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 09:27:51 -0700 (PDT)
Message-ID: <f66b5f8e-da7b-4a24-b87c-7b563d9f14dc@linaro.org>
Date: Tue, 29 Jul 2025 18:27:50 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Donghoon Yu <hoony.yu@samsung.com>, Youngmin Nam <youngmin.nam@samsung.com>,
 John Stultz <jstultz@google.com>, Will McVicker <willmcvicker@google.com>,
 x86@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@kernel.org>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
 <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
 <aINdu_hrz6zJnBGb@gmail.com>
 <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
 <162ef225-51d5-48f5-bc00-36e00e905023@linaro.org> <87qzxznzjp.ffs@tglx>
 <920c5a0c-6ac2-49a1-8dbe-17761379765e@linaro.org> <87frefj7pd.ffs@tglx>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <87frefj7pd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2025 18:13, Thomas Gleixner wrote:
> On Tue, Jul 29 2025 at 11:13, Daniel Lezcano wrote:
>> On 29/07/2025 10:58, Thomas Gleixner wrote:
>>> On Tue, Jul 29 2025 at 09:58, Daniel Lezcano wrote:
>>>> just a gentle ping for the question below about dropping the two patches.
>>>>
>>>> On 25/07/2025 15:15, Daniel Lezcano wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>> So I got no answer for this question, but I suppose my assumption is
>>>>>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>>>>>> misattribution and a number of other problems, and also fixed various
>>>>>> typos, spelling mistakes and inconsistencies in the changelogs while at
>>>>>> it. Let me know if I got something wrong.
>>>>>
>>>>> If the rebase is possible, I suggest to take the opportunity to remove
>>>>> the following patches:
>>>>>
>>>>> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
>>>>> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section
>>>>> mismatch from the module conversion
>>>>>
>>>>> Because of:
>>>>>
>>>>> [1] https://lore.kernel.org/all/20250725090349.87730-2-
>>>>> krzysztof.kozlowski@linaro.org/
>>>>>
>>>>> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965-
>>>>> aa05-05836466f81f@app.fastmail.com/
>>>
>>> Grrr.
>>>
>>> I've already sent the pull request for the pile. Let me ask Linus not to
>>> pull and I revert them on top.
>>>
>>> Also please reset your clockevents branch so next does not have the
>>> conflicting SHAs
>>
>> There is revert otherwise above [1]
> 
> It's incomplete :)
> 
> I just reverted all three exynos mct related changes on top of the
> timers/clocksource branch and pushed the result out.


Thanks, sorry for the mess


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

