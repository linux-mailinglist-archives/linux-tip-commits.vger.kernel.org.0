Return-Path: <linux-tip-commits+bounces-6217-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73231B11F3E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4D11C883A0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645FC2ED861;
	Fri, 25 Jul 2025 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3820aIg"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C42ED844
	for <linux-tip-commits@vger.kernel.org>; Fri, 25 Jul 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449343; cv=none; b=qx9nC9cmD9HHkadfMKnxn3+jPPqnRWITvNzZo4+j1wCTegVx06XjKqTvXrz1+u3wVCr9V44/Oy2EQLT2LP7i77qlvMRWPcEc8m9bG4WZQQrebjh1sT9+DLVk2Diq1VLC6r3e2IYEAGrmEkZiRDbftIepwDA8qT4tOhWONaBS5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449343; c=relaxed/simple;
	bh=y4LvTg8Vl0ihFpvurwo/P/l0P11SNHTq4D6tssmg0pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g76xsN7xh56y30TH3osi8Bl8/CQjeeP4Ut/Jk4cSPLpGtFzUhTvAqFnrbAgXLAnQyIkpXRFYO+tEeVViYYs4bpOVwFWhBZl4Z+3YGsLASYEicfuDhCadmahXd9m6Dgjbq3DIu1SXlITFekV+kd3WqDcWigPvqHPiF84VEhYHrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y3820aIg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7788749b0so163798f8f.2
        for <linux-tip-commits@vger.kernel.org>; Fri, 25 Jul 2025 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753449340; x=1754054140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qphveX+IcbsowGUL4p1sm6U/t7i7Pc1D4Xjo/RMMv1k=;
        b=y3820aIgYOZqF970gq7SVTnV1Ha+a3lAni3B/9WoltwDXotfYVwV+Ld/ViX7ce1JNl
         OJGIkOv5hd2q6n7xYxjVv9Qu6dBpCRH1Lq50Agux9ySoi7qBtPAx/Zk/8KPkeHNXIFZj
         mbt5ch8s7Ri+60++Db0/3w0XgCt64fL3D6R7DHzqTzzZnlv/H5+yQV2c149+Eixafkc8
         3BgF8u8p7cg9SZnNU9xpt8dvZAGzPe/ONZ16VTLWYJG4JG0CIFZ9G1yI9WZdya5LSbiO
         AujdA4w/fEVOxfpgN7aPkZZswa8/O2jDG2vdkgqJqArzEXuZyQTve+BlV0h5U9HPcmo9
         BuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449340; x=1754054140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qphveX+IcbsowGUL4p1sm6U/t7i7Pc1D4Xjo/RMMv1k=;
        b=IcSt3rGbwnB18eIDbLScdJcHU74p+johcwHdLeM1XC7IkIawdJ9h25Qs+iA7dNGBsu
         l1wPdDeiwpmRhosizmE+aC+eRcj9CaYWuxWU6xH0Vwy0Q5Ukx5buMP+Yx9Rei6HyUOmv
         SaV2JcehF6gpmPjvnqnoUI+i/XSVUTAkzNcQmf43ivTAzXbgWrOc478B0roS6ctvqiT8
         xpRNtF/AfXxMHxo92kg4T+2XQH4uJuBT4gKGwxLKbzljG3CalvQiNDuPDGvxQoezk9tF
         aoa4PZuiRFOdFKsAcxnIcd08rqm0vxlD9aezdScbFWkb09cyXht9zhFh8RHjkAxSsxMT
         sHgg==
X-Forwarded-Encrypted: i=1; AJvYcCV9meQkB9EmJIFJyAncjGuzdgAO1i7W738qrQ9zv8eEW5HNba6jpkbR0tIv2hQMirnwHNQ3EjDFXnJBOjglCwvbkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7VkwMjJ8lcShgP5uja0DWL4lKk/73aTz/mEmqvt0bnfBvfv8
	gGB8l3jVCmwaw8HfBYJdXORCPcjCyXL8/Ztunk11o6C/YWRLRyjnVaKM0McAoDZfBcw=
X-Gm-Gg: ASbGncs8GTfm/eJ2xcEAOL1PPNrlTMvIM8IUNVEXyW8Re4Ye35Z772Vh4oAra+DlF3j
	7xLNx+9Rj4N3ZoG9eDbbK4nhK+Wipd7OMeNCaiGZvdNnA7VgrR7oeihNNomVMt+V8sMXFTyKcyI
	cwKe+4ShNCe/b3BzKK8449zeVTe00rVcQ4hYlbbfVn0dWYDKdQLFIp8qJ1/ONq5Il7Uk+FmdgTO
	D3hyo6Tme5mdUszOewGyvORq2epqCCrIpV8+7Zk2zM0VuPZZC5VJ/njBMlbLgFRJDF6L8Yz/n7p
	EzK5yck/h1RjX5sID03fIfHKU3Rae94svgbcrhN36W7FOWyFk+IHhUVwBZW3/7/q2gw7Es8E6Nm
	Kyo9JRFM9uxblrp0iYRITRR8tSrb/OIcvWvyP29h1ox1I0RNT0pKChl5jo6jupA==
X-Google-Smtp-Source: AGHT+IGVp1L9DRHNP0CIZJjhCbFFiMb9Q/eMfhwleA0Cy0iT2RjxXfOV27ER9+Eq/tU6xxkCYqXfpQ==
X-Received: by 2002:a05:6000:3111:b0:3b7:6828:4205 with SMTP id ffacd0b85a97d-3b77675fbf3mr1441404f8f.32.1753449339443;
        Fri, 25 Jul 2025 06:15:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b76fcb83c5sm5039599f8f.60.2025.07.25.06.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 06:15:38 -0700 (PDT)
Message-ID: <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
Date: Fri, 25 Jul 2025 15:15:37 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-tip-commits@vger.kernel.org, Donghoon Yu <hoony.yu@samsung.com>,
 Youngmin Nam <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@kernel.org>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
 <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
 <aINdu_hrz6zJnBGb@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aINdu_hrz6zJnBGb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/07/2025 12:34, Ingo Molnar wrote:
> 
> * Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

>>> 3)
>>>
>>> There's also a stray Tested-by tag by one of the SOB entries:
>>>
>>>> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>>>> Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
>>>> Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
>>>
>>> When someone passes along a patch, it's implicit that they not only
>>> have reviewed the patch, but have also tested it to a certain extent
>>
>> In this specific case where the original commit is from AOSP, this chain
>> seems to make sense. Souns like:
>>
>> "I was in the original commit delivery path"
>> "I reviewed this patch carried to Linux"
>> "I tested it on Linux"
> 
> Yeah, so then this should be documented by adding a comment to the tag
> itself:
> 
>      Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
>      Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>      Signed-off-by: Will McVicker <willmcvicker@google.com>
>      Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>      Tested-by: Youngmin Nam <youngmin.nam@samsung.com>   # AOSP -> Linux port
>      Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port
> 
> Otherwise it's just confusing as to why there's duplicate SOB and
> Reviewed-by entries.

Yes, I agree it is more clear.

> But as long as the porting was basically just a cherry-pick, these
> extra tags are probably superfluous. If there was a conflict resolved
> by one of the maintainers along the SOB chain, that should be marked
> explicitly, which I see was already done in some cases:
> 
>      [ dlezcano : Fixed conflict with 20250614175556.922159-2-linux@roeck-us.net ]

Ok, noted for the next time.

>>> 4)
>>>
>>> Why is the 'Link' tag just in the middle of the SOB chain, instead at the end of it?
>>
>> I don't know. Link must be at the end  It is stated somewhere in the
>> documentation?
>>
>> I use git b4 -s <msg-id> and the tool adds the Link then my sign off.
> 
> Yeah, so using tools and not looking at the end result will often just
> create a random tag order that looks messy.
> 
> On preferred tag ordering, see:
> 
>    Documentation/process/maintainer-tip.rst
> 
>    Ordering of commit tags
>    ^^^^^^^^^^^^^^^^^^^^^^^
>    ...
> 
> 'Link' is at the end of the list of tags.
> 
> There's some logic to the -tip tag ordering (more important tags go
> before less important tags), but it's mostly just an arbitrary order
> that we try to stick to within -tip.

Thanks for the pointer !

>>> Presumably this is the proper SOB chain:
>>>
>>>> Author:        Donghoon Yu <hoony.yu@samsung.com>
>>>
>>>> Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
>>>> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>>>> Signed-off-by: Will McVicker <willmcvicker@google.com>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Acked-by: John Stultz <jstultz@google.com>
>>>> Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
>>>
>>> Correct?
>>
>>
> 
> So I got no answer for this question, but I suppose my assumption is
> correct - so I've rebased the tip:timers/clocksource commits to fix the
> misattribution and a number of other problems, and also fixed various
> typos, spelling mistakes and inconsistencies in the changelogs while at
> it. Let me know if I got something wrong.

If the rebase is possible, I suggest to take the opportunity to remove 
the following patches:

commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section 
mismatch from the module conversion

Because of:

[1] 
https://lore.kernel.org/all/20250725090349.87730-2-krzysztof.kozlowski@linaro.org/

[2] 
https://lore.kernel.org/all/bccb77b9-7cdc-4965-aa05-05836466f81f@app.fastmail.com/


> I've attached a delta-patch of the changelog changes below - note that
> I skipped the commit IDs to make the diff easier to read.

I have one question regarding the 'handler', when there is a message like:

[ handler: I did some changes ]

...

Signed-off-by: John Doe <handler@kernel.org>

Does the 'handler' have to match the email name ?

For example below, there is:

[ dlezcano : Fixed conflict with 
20250614175556.922159-2-linux@roeck-us.net ]

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Is this form ok, or should it be:

[ daniel.lezcano: Fixed conflict with 
20250614175556.922159-2-linux@roeck-us.net ]

?

> ===================>
> ---	2025-07-25 12:15:26.024284067 +0200
> +++	2025-07-25 12:15:18.761435799 +0200
> @@ -10,6 +10,7 @@ Date:   Tue Jul 15 14:18:33 2025 +0200
>       the module loading.
>       
>       Fix this by adding the __init_or_module annotation for the functions:
> +

If my understanding of the documentation is correct, it seems to me the 
delta is ok. Until now, I was relying on the tool to put the different 
tags in the correct order, I thought it was in the arrival order.

Thanks for fixing this. Is there an existing script checking the tags 
order is correct regarding the tip criteria ?

Thanks
   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

