Return-Path: <linux-tip-commits+bounces-6218-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9DB149A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7113BF902
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB6246BC4;
	Tue, 29 Jul 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEvEmy/p"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111F1FDA8C
	for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775892; cv=none; b=B448Zf4uTElLHNkU4r0blIuGXxT4WerDAYBl19VBTe2JIz+vaB65Zm6m6Y0J/QzgiXgZSRxLDataiViG7p/JXijc1mWMU5qdSSj9ecyrtbsrdYsMUSRZxtVwZqFPP7XSEg7jdeq8H6uxAIvBGAd64oke+Rd5BftExbNhmUOOH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775892; c=relaxed/simple;
	bh=AbTOM347spOloDSOG4nl3ZHZIS1SePcI8qYC399qLTI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AH9NlXyMazxdWhEnYwGcXMJ/RgNeXIBw/fatP6xqpp7GxV1HKkgepIjgnClbALtJLmahbn19So5dCNfjmyjz8YpKA/ilLZLuiJNlDXnzjANMeaFuC6Q43AhVM/2IW7IZzsCATH8Wsb0Ml10f9ZW8JjRgZM+0eHcWPiaoXvNof18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEvEmy/p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b783ea502eso530050f8f.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 29 Jul 2025 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753775889; x=1754380689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nSRUdmOtFwIfWjaocj7a2xYBLBsc7tk6nknvXHnmLE=;
        b=VEvEmy/pto9TLgswrHw+6VJkbLFNG4DC6gr4wyHNlv267zdIM/vEXO6gwYlFNei0Qu
         PSV8SfKtWWn12zobO0JB5uYhDOLHOOJvPUnyVAjIg5EDHkK4LwFjrVpIcalC87aIp1Dz
         yuocFYgKs11Fjz/gS8LY4jFp6h36u7rcj4p7z4QPTs5PPJT1pbyed2Kaei+7p6xVAZ+T
         29OrebzNMW+XIxQiutChcMtIOChdmG8zRE2rxeaYRyzrhKfW5VE+keU88PoDfCZcZqUo
         4F3vh7tewsc6HQpQDqx503ZvTpoduDyh69uu6Q4FvsUL6sIFSs+rHY9soPoW/QLHMgf9
         9arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775889; x=1754380689;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nSRUdmOtFwIfWjaocj7a2xYBLBsc7tk6nknvXHnmLE=;
        b=Rk/lau7lkx0kRG3moXAn8gOPIuU1RpkkbeVy7Td2CJ55JnfGDIfzMw54NXVt/pAqt1
         JXMMZDyISmvbf30wEkUFSCpGZNMd5YBZ3Ogk7ggyKqoWCvyeWp3T2OCtDQBtpHoMLRI1
         OlWNKlDb30PzNv2Hx9j80yFwp56TSS04+0praMcim1yMiEJY+YWplyq5WmNhSlevJH8n
         XMPC4hkKpyTcG9xTdJ0DYriE1ZJ4qv8K2YRYqQw6D/2YArVsZCjpg6cv3aAjZ9MqMVAy
         XKqAjkKmJ3IH7nr2lqzBRh9RBcWJSUZczZXvjOhmHZNHb7JdAhEah2y/1ckn4MoyV45j
         9iZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjdXT5LuWhwQQ5pEmE3AzkjpPhqo0/Wg2OypY2N9WXDwHWx9Bjp/LpYRr7BA7HIY1g8YpRGU7MV2e1oTjJLLqx9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4YzYG1AFV4xmumJvwGH4+Rf1BDvIGyQCv8/A4ZqV/Y6vAsudO
	yIoWHcrnKrALlIA9FFdOUVLi9DBh7yp6Im7ugskJBzojI/hLpccpiAbbryYjFF3yXPE=
X-Gm-Gg: ASbGncsl7+7ZSyJraxtsEvaKS+djQTYGBfi/T2UTXitMs91sQLjmTX6hD7WTB6XGm1w
	Hs+ZXzg9Na8QV+Jft91Q0OGKJ9trqvChj5NoDc++3EyAUzCwLOwuTd/kAWlaQMnXxVKw5z+U6W6
	C7EBQ86MW7ozVhHsue7GHqVma47uWWRbB2ssB3/fiVnZDvr0WidF03VyINmziNignHus68b6Xg4
	WQ/nfcOwHK7TGvMvvteiHuFk81aqPimrS8N7cHTyNmwNh0eQb2M2IvvwT/lrYQXTEL6WwrNJBrl
	hUZLQhundRoMbzIdw+/Ku5Sh+DsJ639pinILVcn5q8CovQBUPgzJ7RaRKoYD/L7K9BeX3nDzQt/
	Rl+hbLwkIJz8WmMpV6jibt6el2RgmiV3EpZumBvDu47Z9qABbM8Y/goiVRao4kQ==
X-Google-Smtp-Source: AGHT+IGhmQCAt8Nrwl6CzOv7wPCcFH8G36gaFS3yKtLiEMiKywzAOyCeXI3zYJATdeJPcC3SqG6aYA==
X-Received: by 2002:a05:6000:3104:b0:3b7:828a:47df with SMTP id ffacd0b85a97d-3b78e3dd9a6mr1545125f8f.4.1753775888693;
        Tue, 29 Jul 2025 00:58:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b789a31c4asm4888771f8f.17.2025.07.29.00.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 00:58:08 -0700 (PDT)
Message-ID: <162ef225-51d5-48f5-bc00-36e00e905023@linaro.org>
Date: Tue, 29 Jul 2025 09:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
From: Daniel Lezcano <daniel.lezcano@linaro.org>
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
 <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
Content-Language: en-US
In-Reply-To: <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Ingo,

just a gentle ping for the question below about dropping the two patches.


On 25/07/2025 15:15, Daniel Lezcano wrote:

[ ... ]

>> So I got no answer for this question, but I suppose my assumption is
>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>> misattribution and a number of other problems, and also fixed various
>> typos, spelling mistakes and inconsistencies in the changelogs while at
>> it. Let me know if I got something wrong.
> 
> If the rebase is possible, I suggest to take the opportunity to remove 
> the following patches:
> 
> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section 
> mismatch from the module conversion
> 
> Because of:
> 
> [1] https://lore.kernel.org/all/20250725090349.87730-2- 
> krzysztof.kozlowski@linaro.org/
> 
> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965- 
> aa05-05836466f81f@app.fastmail.com/

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

