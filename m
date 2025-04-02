Return-Path: <linux-tip-commits+bounces-4630-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC14A798CB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 01:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8FD3A74DE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 23:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56AE1F63C1;
	Wed,  2 Apr 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YW2/9JjC"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145081F5847
	for <linux-tip-commits@vger.kernel.org>; Wed,  2 Apr 2025 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636424; cv=none; b=gcYxfYeOjwx8HH5WKV7YdYFOogRJjWTB4TO/Rc3DavtcZLfeGmsvEgdrmGaE+NjSzuPQXm+mYQ0r0acLxEO6zflVOaEBK4KUb7c6h6w+T03bI4sGEYlx+bUq7LRvkalfG53C5nmv7faMCwXDPlMa2A1MDjsbOs2UuzwVGlRvsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636424; c=relaxed/simple;
	bh=TSPlVub8sK1k/3jJb2bB9xiezhCRc5ikRWxBwuUkz4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+04FiG4PCrnhW2K01B5gb9qFy7PrQ0dX5j6A7I6VcYayVd/ksq2WVZoJnte1J6ymzfaPg4TS+4HJ8E0Ug70lrMZ2dJMiOSHXbbLfMMCsfCYaP7sI/KavpmIsRz/++e2v90nKWBMChwyOFhxy0XrGiO5ffzyovSkg5/SS5a8ITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=YW2/9JjC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso1721315e9.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 02 Apr 2025 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743636421; x=1744241221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h4xs57uHy58GBftbej3FkFLo4jfMFCX79EJdMrWM4Qc=;
        b=YW2/9JjC4d+3OeldCbpboRXIQUGtpWInsVCA8mg0fowtN9WFav8jxAInrHDKgMlyKR
         WjVjiobc8RhGJG0vG0hcdi8FNIXHKzFBmHoFEJQ1ye1lB1OY+DdzTYgAnRmY/FdQeAd7
         CazidSbsT8FXh30iYdDM9yzMDnJlIDFkd+ZUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743636421; x=1744241221;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4xs57uHy58GBftbej3FkFLo4jfMFCX79EJdMrWM4Qc=;
        b=UMkUfT41Q/9aiPD15fTyoPMAWG+S6tgYE95xSa01ViqSJrgCPrkVoP5ba5jwfVBGyi
         4yxTjSVHP87SHcFnTeSVbuDpFBT2B4cRZlrPZ4mAWrQ2EjxMA5RZXRYLiY29HQlchjQ1
         vGCLvQvnhz5jMXz1HfODBbb+t6XNBIBhTzJbh02J07r8xv0GJ9UH8pQzbrNpt13PmR6F
         1HS8qS7HvI0Vhscmu9nLp+kOGDKW5IWQhjGn+TSiZd6m8TMIcnZUvG2vOsT7CuKW+iib
         4N7elZ1GaFE+5yRynNrLK2Lsq/FFxWXEFg3BY3L1yAcUIlABd0oH93xx3MpQPl9Ien5h
         lSMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4m8BK67C1+B4rQKTnnr3EHvYqgPPMp3zuVaw/alN6P/5Jr+gfc+c1d/7YquYwxUYiaQpYRAMwgIzGlsBnD+B9Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzysHMRGjwn0m03xtitTpQ/wIXgDKG68AGP92FgDqmjWG6vuzDi
	szJOG1QWq5jXm792p9ZldCCgiU10Ig2tew4wvsZwfnft2HXVUn8JhudsZxLzXYM=
X-Gm-Gg: ASbGncvig2EZIlG+87NrVxzSVkFzY9TgjwfeEsJeLj6dHA/nK19JndAEMOBdf50DESy
	4nDxmtzl2iUxeoZTr6OtEmlmkivpw+ltmg6XJPYrv//3N9Azy1Q+B1MCDcIB9GXGfy8Y0UCpk3O
	UIUZlTB2lQhKerhnSWUKepVNc+SdA6DeC7Ti6h57YmwyV1+biBWkvAJT3zV66FVA3OOV/X5Q9xK
	45ezn2Xa6IfdDfnVsOsefk8i+TB2TtDOx+drGvt2ariZDv3Pi0/fgem58IP5eDuCSh5JZsGO6xd
	Vr9ch1bBu8QHToCes2rIQRJOscLYiXgFr6qdQoVxat8MlDqxAogbTuGa13qDftP3d6MlLMl2YDQ
	0PizbnCBe8g==
X-Google-Smtp-Source: AGHT+IEMPRLBqe9b6PCNp/w6Jni5RVDzLp0OTadXPoIEFOzn9hr7DAxraF1OiN5hXsEpnmQyxIqMng==
X-Received: by 2002:adf:f40d:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-39c2f945f61mr224288f8f.41.1743636421304;
        Wed, 02 Apr 2025 16:27:01 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301ba2dfsm169438f8f.60.2025.04.02.16.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 16:27:00 -0700 (PDT)
Message-ID: <9ba2f0ac-eb06-4437-8662-441da7e168c7@citrix.com>
Date: Thu, 3 Apr 2025 00:26:59 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/mm] x86/idle: Standardize argument types for
 MONITOR{,X} and MWAIT{,X} instruction wrappers on 'u32'
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
References: <20250402180827.3762-1-ubizjak@gmail.com>
 <174362663333.14745.17539175188705861090.tip-bot2@tip-bot2>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <174362663333.14745.17539175188705861090.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2025 9:43 pm, tip-bot2 for Uros Bizjak wrote:
> The following commit has been merged into the x86/mm branch of tip:
>
> Commit-ID:     1ae899e413105aa81068d0282ab6e22974891d74
> Gitweb:        https://git.kernel.org/tip/1ae899e413105aa81068d0282ab6e22974891d74
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Wed, 02 Apr 2025 20:08:05 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 02 Apr 2025 22:26:17 +02:00
>
> x86/idle: Standardize argument types for MONITOR{,X} and MWAIT{,X} instruction wrappers on 'u32'
>
> MONITOR and MONITORX expect 32-bit unsigned integer arguments in the %ecx
> and %edx registers. MWAIT and MWAITX expect 32-bit usigned int
> argument in %eax and %ecx registers.
>
> Some of the helpers around these instructions in <asm/mwait.h> are using
> too wide types (long), standardize on u32 instead that makes it clear that
> this is a hardware ABI.
>
> [ mingo: Cleaned up the changelog. ]
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Something I noticed while looking over this is that you want to push the
u32's up into the callers too.

mwait_idle_with_hints() with have (marginally) better code gen by
swapping it's unsigned longs for u32's.

~Andrew

