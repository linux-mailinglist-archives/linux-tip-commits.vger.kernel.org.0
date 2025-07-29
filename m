Return-Path: <linux-tip-commits+bounces-6222-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89169B14AE1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39E93A6E56
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75979286884;
	Tue, 29 Jul 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qe9JxUOq"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A62868AD
	for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780422; cv=none; b=OYx4r1t3gJgDyiTesuYUWw2urPUP/23uuF+z1gCc+TSJ5q/fgcd5Y387JiBp+upGczafhlGD6BNR9wnrHTzI7NiCxvfgT5wk2GnpSIM+UAyIUygb5ZrQML/cNZihXS0PATOCJ/MkYghSBHfBA/pQSNLG9Ye4ImunRiDM/NIZ0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780422; c=relaxed/simple;
	bh=Pgger2eGoP8Jfc70Jpn+Y297tCCbE/cXHE1x9qHbCRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls4ZzTTE2IlRNIC4Glo7UDwRo5ytyVd0Kkou6X7QKPKSmXy9p4YWiIujurdqJqSeLO+tm+GO8eBwafQESg/qcuytxLkqjT+k21nXNDhyXpFdd2orFKRURJAtBrRsechax76zzF5f1fIDNDe10yRPLARhpaaGb//5WMx8mg6iBio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qe9JxUOq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso55145755e9.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753780419; x=1754385219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/T7xfa6EKXzBmswjGiH5vZYytRxtAdkrVjl1Ndu+Bo=;
        b=qe9JxUOqiAHxCofI6cFX+XH7qomlcV7ELO5JOCjHsIdRgvdNccCzOSXqT+WAx63+A/
         Z27INjWGCpWSQLZ+0Ukq9PWauxwMVVkJ0oAVmMcH5QNrRURiTPkFUushH3hZGDtMeiQi
         GqQ0luOf2TBDBzNmXk1bcbsLLg5YUEPBGT10j1VX8KuSTCiMz2P48wo7KDZYEuWhFFIC
         K4g9zngYDpA8Dc1m5iXOFxSMjTRcoC7MYS6aZihF3b19iss4WsZtwlxnWpHP2U9GuJ6p
         xXw8l0t6Yf214QnNpyUKjxeK1Jjs6lbjVPO5+gWjLZ9OYfsrI1VGRqoUnwpHfUo7wcO1
         dS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780419; x=1754385219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/T7xfa6EKXzBmswjGiH5vZYytRxtAdkrVjl1Ndu+Bo=;
        b=fxCKO/bztNRF+6OnOBGXP4AgG4yRNjf4SbMCTJWE+MUy7q159BJ70vmbs0VUT/KU69
         uNt7Qx8VOdRlSPc2Uztxg7jxU5eVMuPl1azhyhx0B865pbYpEgPdo69/EaVA7b4mXQ7j
         TWiP1wjktDlPhqR6uHNFvTfa/GhSsFyzfaOUuwFkG6xu2dUsGWN8oyIRMeuvrddknHBU
         Vv9wFO7RpPYZnJsLzlp8+yTfdHCzZe+v3ChgqeBvBhixtUh1TKj813LNr0UBC2aSZyVP
         pP6EeyphcgQpEG7rDLQbjajB7D4wdKoxSfhLnXhmAFvpBThj6DU/G5W3indQK2gTlET7
         Thjg==
X-Forwarded-Encrypted: i=1; AJvYcCXptviCsMEfo1o3Ccda1iWYiXzBxWBZ04YnmwL7HxjqdUD5CyqP/bSSzCmUggkmfKCtEPXm4EOz0featmthNYzVjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5On8bVONm177qxMWF2Rv812+cmqEkT/o+RobnVqmhOLiwzRK4
	um18lxRbr0cFr6/QAK+cB5rnmCS0T2FDqmYa7Sx6MTIVq1rww/3pQX/7Zl2+kh0GP4A=
X-Gm-Gg: ASbGnctdwJxrR+J+reEwBoSKsman8Rnl+DkWPBhPEBuu+0en3t+IMEAcLQZoF+/8p9D
	hCl8iRHrNqR2VfKJajZS7EUnawYBOt6MUaYbRWE3FUvpxNnSZ5KEnnbZlqFqwci24ucs2y/RQBL
	ECFNMvkfenjcfYXoMTo/QoWvElOZMU3afDwsHSmMJIlEnBc4+rvX75bdFwZDTj6iBZ+HF7kiQ7v
	KNRuJbvdt3jDLzFZ/OmliqG21Snu5Dgt9dqUapBN8EF/mZmPRxD3uHpa5XmbwnhKBKa51a8T4TH
	1FWNPhLZs+wjx4G8QhEksrso0/2l7/tbxSdy45sc2NYxmhFrVKhhdO71f0sJU9nIu8/0mc+AlPH
	G1Y9Vk8TO1Nj6C4yblIPMnKNgYStCyZFQhsgpFPjML7rUgyirOTbf3r1zr+T1+w==
X-Google-Smtp-Source: AGHT+IFIUouVLdYyN5JupIDqGUB18/YRE2cxY7ZTWjlDFQeNFzA1mKxBf2H6uB1h2zr9LAFNkSsR0A==
X-Received: by 2002:a05:600c:c1d7:10b0:456:1c44:441f with SMTP id 5b1f17b1804b1-458769e88a1mr67665805e9.31.1753780418663;
        Tue, 29 Jul 2025 02:13:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b7887285e1sm6179310f8f.65.2025.07.29.02.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:13:38 -0700 (PDT)
Message-ID: <920c5a0c-6ac2-49a1-8dbe-17761379765e@linaro.org>
Date: Tue, 29 Jul 2025 11:13:37 +0200
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <87qzxznzjp.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2025 10:58, Thomas Gleixner wrote:
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
> 
> Also please reset your clockevents branch so next does not have the
> conflicting SHAs

There is revert otherwise above [1]

Branch reset to v6.16-rc5

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

