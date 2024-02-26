Return-Path: <linux-tip-commits+bounces-584-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68786838A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Feb 2024 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5511C23402
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Feb 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E467131E45;
	Mon, 26 Feb 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VNHhMEKD"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B81CA91
	for <linux-tip-commits@vger.kernel.org>; Mon, 26 Feb 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986009; cv=none; b=ID9Yaz3gIfERQ3wTanG57wQhpTuoInUShKwkIb8/63r+0RqhakA32AFBNe7TiZ7gaBo8sDp1gFedzAyWprLKm5Jzj8Fxp2GHHtlq0tJb0vjN8PhvcN8TEvlVUjzSUnFUTI2Syb65Mdn4aTvCZ8WZLsY8xkZxhKXtcurNvezbdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986009; c=relaxed/simple;
	bh=skxVL5kaknU87N+S3YBA4vPUrAkeCI9uwX20e0OJgVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwZVklN9ndAnNQCq7NL879B5oFoJr3HaGki838HymCG+KCVWOT9sUXc4T1thswtYVw/esndzOd/tHGzCH9SW+0FiZboJ+d5AlvHusSRCQZOyHVf07yivOlKbcZjxfYUSVoM1ZYFmd3656YB0D9OiNygPVB27YOJnGA7kvBtd9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VNHhMEKD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e75e30d36so684966066b.1
        for <linux-tip-commits@vger.kernel.org>; Mon, 26 Feb 2024 14:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708986005; x=1709590805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Jm9mKeVX8NPdtK0hYoioIjcJhAV/zjNJl8t3JIfdWU=;
        b=VNHhMEKDhqLHz3w+pRbq0CHfmkpFmaPTbZeD170ijpvqgfaTJHrmMVb/BtoHBjD9Y/
         MUEaetSsbHzZ8St77OoX2gp3Mw5MMg6r8DeKbyl0rVZx7MdL3kbvB9F/HJlnfBQDUCuC
         RoN/Y2qMsBB1fbeAnDz1Q8469g2MsmDJCOffdihtr0kc0tp5SGdFbQjlLrf4tYdxbNiY
         DhJ0bd8r0CYZZbuRveVDj8TtC1ptMOlf5LDsWgqHthCFa6hE9kdVv8PqpO4WQo7Sfzq+
         uf7+zXl3s8sIq+bGhO4/z1mueCVLoA4T7v2LsA1AfSJSkD6EMcnKj64fvAU5iYpQDBtA
         iJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708986005; x=1709590805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jm9mKeVX8NPdtK0hYoioIjcJhAV/zjNJl8t3JIfdWU=;
        b=Md/Omf0DJGPnquU8CEE84pevx5ozJGbI5lm65vvVuU7Fb3NAL2uqGq7NUPajopJ/K5
         zp9PQLfdfYMLK/sRTeWJBfkte1cbiOm3R5mFb22MWOfgIwsGIrVyu69nP1lgQ9C0zJZb
         s1b7xX45x85WgY1A4P760abr3sbWVn/Dmt7nmuFszFwKLbH2ODsFPbr+O7mtiT6xtPu6
         DbXAO1bkAEXNhXDguLqxTLcTQ07DXfCIpJE4FGDROUXivIr4isamm4RHvsuwB5db84+9
         s/7F1K+5txi/I3TP7plCBPMpF1woQWDKgRBLQUgKD6n0NLdkLjFFidAVSZuRfc1teKyN
         gIew==
X-Forwarded-Encrypted: i=1; AJvYcCW3tcL2OizUq98etSnPJqgVhfO0QGRZ5ADk3a/tVqrX96fY/IeFziyVD1OXAFqeJnGTtNZvUrHmSR5/tOTcBP1fbsW/FDWE2RiD3GAakrDJt0Q=
X-Gm-Message-State: AOJu0YxWnFgxgWWVJNEdfXgeCOp1Xwo/QdxpyIl3+wEiAmacGEjhA2jJ
	DjjKNWPLffoSXo4RoJO2rP8nLpR3wirpn0oF/3WCcRnVBqGJhvPdGBIl+O1LBBs=
X-Google-Smtp-Source: AGHT+IFi7VtDe28YphgX/47GL8ixG0NcFoRu4OvHYMZS64J0qajiDvsZoKEclvilhnw5h4oZvgrwUg==
X-Received: by 2002:a17:907:9486:b0:a42:e819:e663 with SMTP id dm6-20020a170907948600b00a42e819e663mr7503450ejc.27.1708986004884;
        Mon, 26 Feb 2024 14:20:04 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.229])
        by smtp.gmail.com with ESMTPSA id h5-20020a1709063c0500b00a432f3bc3a5sm152057ejg.76.2024.02.26.14.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:20:04 -0800 (PST)
Message-ID: <20558f89-299b-472e-9a96-171403a83bd6@suse.com>
Date: Tue, 27 Feb 2024 00:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/bugs: Add asm helpers for executing VERW
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Alyssa Milburn <alyssa.milburn@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <170839092792.398.3678407222202963581.tip-bot2@tip-bot2>
 <6380ba8d-4e99-46e6-8d92-911d10963ba7@suse.com>
 <20240226221059.mnuurhn6g3irys37@desk>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240226221059.mnuurhn6g3irys37@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.02.24 г. 0:10 ч., Pawan Gupta wrote:
> On Mon, Feb 26, 2024 at 09:17:30AM +0200, Nikolay Borisov wrote:
>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>>> index 262e655..077083e 100644
>>> --- a/arch/x86/include/asm/nospec-branch.h
>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>> @@ -315,6 +315,17 @@
>>>    #endif
>>>    .endm
>>> +/*
>>> + * Macro to execute VERW instruction that mitigate transient data sampling
>>> + * attacks such as MDS. On affected systems a microcode update overloaded VERW
>>> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
>>> + *
>>> + * Note: Only the memory operand variant of VERW clears the CPU buffers.
>>> + */
>>> +.macro CLEAR_CPU_BUFFERS
>>> +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
>>
>> Any particular reason why this uses RIP-relative vs an absolute address
>> mode?
> 
> Early versions of the series had the VERW arg pointing to the macro
> itself, that is why relative addressing was used. That got changed in a
> later version with all VERW sites pointing to a single memory location.
> 
>> I know in our private exchange you said there is no significance but
>> for example older kernels have a missing relocation support in alternatives.
>> This of course can be worked around by slightly changing the logic of the
>> macro which means different kernels will have slightly different macros.
> 
> Do you anticipate a problem with that? If yes, I can send a patch to use
> fixed addressing in upstream as well.

I experienced crashes on older kernels before realizing that the 
relocation wasn't resolved correctly by the alternative framework. 
Instead i simply changed the macro to jmp 1f, where the next instruction 
is the verw ( I did send a backport for 5.4) and it works. Recently 
there's been a push to make as much of the kernel assembly as possible 
PIC so having a rip-relative addressing helps. Whether that makes any 
material difference - I cannot say.

Here's my backport version for reference:

https://lore.kernel.org/stable/20240226122237.198921-3-nik.borisov@suse.com/

