Return-Path: <linux-tip-commits+bounces-3939-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2DA4E47F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B720719C6DBA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9952427EC82;
	Tue,  4 Mar 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1O6+LnX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC027E1C8;
	Tue,  4 Mar 2025 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102535; cv=none; b=ResRaJB70/w0jZ2o3PvIKVuTKytNrTGh9dR9E9ju8cqIV2CvdGLuzfb8EL6lxdD4/MBIOtgr/4Fo5VXn11idLh/bcR9G2LcaU1IoAxcv6fdVpCRber0XfWAv5h/yElW9mQn0/0iPsV9Ef/r47isk8+KXqOplQaimANs8ZsbEkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102535; c=relaxed/simple;
	bh=+XnwmcoN6IdY4KUT0KmaHLzlKg0KsHizlhJ8kKoAkr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ui27S6jXhfa1SgLR41p+T+0TbwGjfU1G/WBwKsiUZkN2LwjB6Oi5gkQd02llJCUes7mXA6IiZ4yymtzv/keAyzCLHOzGbr03WKD2v0S74FnKHw+xfHSP/M0icn2+OpmYBR1hMxO5QIfs6udGADHbQdwpG53YFEeWfo7ut8fyrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1O6+LnX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so4518744a12.2;
        Tue, 04 Mar 2025 07:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741102532; x=1741707332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49i4+pEDVoWipnogjrd+XrcmFWqDzMU2u47MulqAQXM=;
        b=g1O6+LnXnwWPBWSUjUm34Az4JlVlYuSj9ihVR8G9slxLBvRlATY8YsPFfMw2Ir708y
         GGyQV3TiuzW2L1pnnWM5iBT4dtGbZkGFKUfTfalJP9NjZ4sK0IoDdrSuI+1UqDl2GdnG
         nSCCZF4xLzAYj5ODok+/yk/czMCuaIqkWAtVwSfk5cK073jsD2rHsFbw9P/JEIH8gY13
         HFOJvGA3+0UhfvOLZCsgyjZZXOeVWlGjz0QgbqHLwRd7StyoIag7GMn0FnsKm+yJevz6
         C3T+ewHZhukj2XTokVPLqn6YXY7cDVbpgACunuhrMhJlTmgRe8fIBzoYytO91JLXE7CQ
         djNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102532; x=1741707332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49i4+pEDVoWipnogjrd+XrcmFWqDzMU2u47MulqAQXM=;
        b=ItyBsIdEBg4o8OWTRohuE5rri7Y7aRSZyyMOCxoG9SCSAzX2jTgqQYRvMmKKRIC+7A
         lRjmVQp+zMWl34GfwmNx5wdbvO+ftpjly6f7T0Dp4pPAVss84G6DO7Rx8diXf8uQB48m
         sdyyJIYYFqi/W4GcC5tPIHEHzEYkFE94GwXcT1BO5Tk70gqRnVvMGp/Oe4mklvHuBIOY
         YquVdzBZJVaiYPppeBdrWuk4DpZlvW7k2Q8HEHcMd4ZEDoz6vA/toG4mkKi0h6G/wvRP
         23X0+wBhH2XHn5PaiNSPu31G7Ej4vYR+dtHgkz2g7y6Towa+FKyRI+6vU8eCFRSbBtSp
         sDEw==
X-Forwarded-Encrypted: i=1; AJvYcCVdiVrqvfHvXmORhs4ik72Iz0iTdJSVvqMk16fEnfKcLimdGZzzJmUhMeQKPCbM260vfyiTw8JitD5+Zj92oFcQPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnxDdu7FDV2/0bAQ8nTPJRyvMpD19e84cmlDVuRWA68WlcoJf
	jLhkpm2taUzV9f0lIaZZlIjMXM43DYijMkhGt4NEHIYZbXI5p3jo
X-Gm-Gg: ASbGncuegfEMWNucQcESRoA+ndHO2HnOnkgx6YPeFOqkDEzZ0K8yKijcRgK45acnW7w
	rSWLfOPjF6KHFWUHt9V6vIm3CJdw1OioffyTe6X2QIwOJAijW9kOjvlULwCe75diafwSBGBT4zv
	0dhQDJOhUeWV9Oy+VwsCSKDiNxg3mJP8ZMqiKUaABjCZuU/0SkzpPep07ZJuC45tER4PpJMmLHD
	SfmJkMfHSMwu+H60Jz09m4Gqj35haXxcHhhT71/swleHzBHUKWvdgrGWrNEQX8V90rG3LrQh1mo
	Oh5sbqyn2cssy4goESZMYUZAFfZLyux37MsizAo+netKdw==
X-Google-Smtp-Source: AGHT+IH+/FlQ/+zOEynwiecOCpyNj0oAUZDq5BuZa2aESgVwjIWMvEl5pJUTW0/4g/ok8cIItKkk0A==
X-Received: by 2002:a17:907:7e93:b0:ac1:e332:b1f6 with SMTP id a640c23a62f3a-ac1e332b48dmr680935066b.0.1741102531841;
        Tue, 04 Mar 2025 07:35:31 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7b3882dfsm340283666b.143.2025.03.04.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:35:31 -0800 (PST)
Message-ID: <aebc3572-43a9-984b-1c47-1f06b17b2972@gmail.com>
Date: Tue, 4 Mar 2025 16:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
 linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Brian Gerst <brgerst@gmail.com>, x86@kernel.org
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com>
 <20250303224548.pghzo2j4hdww7nxt@jpoimboe>
 <20250303224758.2ugmmy7f7zsqti4m@jpoimboe>
 <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4. 03. 25 01:35, H. Peter Anvin wrote:
> On March 3, 2025 2:47:58 PM PST, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>> On Mon, Mar 03, 2025 at 02:45:50PM -0800, Josh Poimboeuf wrote:
>>> On Mon, Mar 03, 2025 at 02:31:50PM -0800, H. Peter Anvin wrote:
>>>>> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
>>>>> #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>>>>> +#else
>>>>> +#define ASM_CALL_CONSTRAINT
>>>>> +#endif
>>>>>
>>>>> #endif /* __ASSEMBLY__ */
>>>>>
>>>>
>>>> Wait, why was this changed? I actually tested this form at least once
>>>> and found that it didn't work under all circumstances...
>>>
>>> Do you have any more details about where this didn't work?  I tested
>>> with several configs and it seems to work fine.  Objtool will complain
>>> if it doesn't work.
>>>
>>> See here for the justification (the previous version was producing crap
>>> code in Clang):
>>
>> Gah, that link doesn't work because I forgot to cc lkml.
>>
>> Here's the tip bot link:
>>
>>   https://lore.kernel.org/all/174099976253.10177.12542657892256193630.tip-bot2@tip-bot2/
>>
> 
> One more thing: if we remove ASM_CALL_CONSTRAINTS, we will not be able to use the redzone in future FRED only kernel builds.

Actually, GCC 15+ will introduce "redzone" clobber, so you will be able 
to write e.g.:

void foo (void) { asm ("" : : : "cc", "memory", "redzone"); }

Please see [1] and:

+@item "redzone"
+The @code{"redzone"} clobber tells the compiler that the assembly code
+may write to the stack red zone, area below the stack pointer which on
+some architectures in some calling conventions is guaranteed not to be
+changed by signal handlers, interrupts or exceptions and so the compiler
+can store there temporaries in leaf functions.  On targets which have
+no concept of the stack red zone, the clobber is ignored.
+It should be used e.g.@: in case the assembly code uses call instructions
+or pushes something to the stack without taking the red zone into account
+by subtracting red zone size from the stack pointer first and restoring
+it afterwards.
+

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117312

Uros.

