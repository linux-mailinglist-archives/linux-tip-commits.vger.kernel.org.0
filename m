Return-Path: <linux-tip-commits+bounces-3841-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C83A4D06B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 01:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CCC3AC7BC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38700179BD;
	Tue,  4 Mar 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="AbLEo4yA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62B2F46
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049875; cv=none; b=tRKomJ8GIXVJ/oYxOzdO20/npnQjO06LpRink6swICfswR8sOQB9WBqQa3CxsaZJj7XKdxwxGKznA1JcDNkxl39dMGknNjm9OdYzM36vAxCkW+jKhX/TuB4+PIJxGBKyt/lJwNJVOlLVM0FmoaOhIWnbPjO/cdhGi0NV/W/DGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049875; c=relaxed/simple;
	bh=+YV8kS+wou6hpAo8zW+TZZb6W8xn3l1QBEQYY/I68ow=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=F5xcFQOAIE+24Y0nqU/pZf4AjggYvSn5IdhIWUN1nZEtkwUzggzkGYgh+Qdd9wQkT7vc4zXq05bkfG8TsejFFLlpk4MvgXkhMQ8+pVqnu6V0FYNqjhePH7R8BDRC4oFjg3oh6vWLPsQvxN85ZX7bQaqrVjbNk0X4/0RUVjj6r9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=AbLEo4yA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so54116915e9.3
        for <linux-tip-commits@vger.kernel.org>; Mon, 03 Mar 2025 16:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741049872; x=1741654672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+YV8kS+wou6hpAo8zW+TZZb6W8xn3l1QBEQYY/I68ow=;
        b=AbLEo4yADf72hnrZfU8CLnEXFVaWcVVSmpLLbsIYLSayAakgqj9i8HwsxadXwYTxvo
         US4rQMp/1nUQ1ZK2KunGiJWgAd5Odd78MV3pfNl1VzExLCB4xOfBXsDlNhP1tWYE3yhA
         HK3zMlxgubMID4dTYbGIxq0HUZbETqfrwLM6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741049872; x=1741654672;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YV8kS+wou6hpAo8zW+TZZb6W8xn3l1QBEQYY/I68ow=;
        b=vVyUTwJP6J8lB/XpftOKeOpXdLjX01RGjbY7rGsIRFhVg1rODRqQ7rTdKWuU1B8JhZ
         jxMTIvPeetXOjoMHH7i/9fVFTemQhn3SPIwi3IPpJHRgKL9Wi0o3O4PS9Uh6jgE5ETBq
         MlTFz0WWu4qd/z0qfAQjm5E2HGzVhGu4RcrqofKurCOXAFLOuUadZElnauVMreGh1jCQ
         GaHfpXMA06m5Bh7cddBDJKX62HVn5UqKkSR8UfSIVQ23WciEh79kptgYTqYshAf0VOCB
         A5PEd2Cpk1Wqp5aWEFjYFcvLuExreH79iFBcPejYS0ssuD5KgGa15b3tAOfbzDN0tMf7
         vPQw==
X-Forwarded-Encrypted: i=1; AJvYcCUkkpvpupQfxZa8Ux/7xb7YZG2WaJZZTluaoYX8XTr6gKtHHZhwoV6w4NXKAI6cST0v6ypxfFQi8gISrkJzOxVpdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIaa0ORp3lf0NqTZPBSmX+/zO17oL+hoVUyDKPitbUYkN6jSTA
	RTkIpQ4LUyq8q/1oo9xTXDP3uXP1zzDO0yLYyvQNEjvOiYyJKYO/qErdi1Ph3jE=
X-Gm-Gg: ASbGncuTxp9UE9Uzj5KNrnYpXgP8YzPihXRkSKTRfxsFzcW0Byt+cQVDTMaZpbt92Tt
	oYafQ9wCvtpgY8sIAml9jpTAc0ti2gjHJXbRS5dOPNGI/mpvZoiPP24WknzG8beeos5KuKaom0l
	MNllZK3+Zotuqo0c6fFtFtp7B0kX9DBNEPvgTuwdjbxJ5e+ZYsSPMF80s5yL1mtqK9qUBPws8XR
	HV4pC8nLRbZuCFKkUCvLO/Lmg2pEqU25VDeGQnpTprq4p4ZDC5hsK7507x4Z8AT0h12VDQggwwn
	LOBJbLej3EqKprnAlhKu97j5d4CLk1fB4JK+3dcmSCNfEHhVCjgNphtV5mRryp/2h1tXUZzLXk1
	nmglNl3Zv
X-Google-Smtp-Source: AGHT+IEZfQIJtGPnAEyRg1Yti+2OAi2L9ZgHVvQsthk3S9iWVx2SOqpwSd6mC/uBSvOUnb8r9GKO4g==
X-Received: by 2002:a05:600c:1c19:b0:43b:c5a3:2e12 with SMTP id 5b1f17b1804b1-43bc5a32ef1mr40582085e9.2.1741049871734;
        Mon, 03 Mar 2025 16:57:51 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f8034sm184251115e9.4.2025.03.03.16.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 16:57:51 -0800 (PST)
Message-ID: <c7496069-2630-45ca-b6d3-c8d6b3678271@citrix.com>
Date: Tue, 4 Mar 2025 00:57:49 +0000
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hpa@zytor.com
Cc: brgerst@gmail.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
 tip-bot2@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org
References: <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> One more thing: if we remove ASM_CALL_CONSTRAINTS, we will not be able to use the redzone in future FRED only kernel builds.

That's easy enough to fix with "|| CONFIG_FRED_EXCLUSIVE" in some
theoretical future when it's a feasible config to use.

~Andrew

