Return-Path: <linux-tip-commits+bounces-3938-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33DA4E41E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA142038D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C89027F4F8;
	Tue,  4 Mar 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXNUlGeN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FE292F9B;
	Tue,  4 Mar 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102139; cv=none; b=NZRMcFX+f60QL5XrK1VgCELHo5F3Yx7ln9+T7iiyAlrqaIkGbA/6Dz5XlCXtAukiKUBHEIivuV1TAgOwNeKqNKKaSr5ERRZulFr7lOxYvSI/ibf3exV1IvKvERJ033WYHdWDeJ/Bcv1pXcAI024weklW9tPtfn4q+1jyA1EDUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102139; c=relaxed/simple;
	bh=RS6LhNEK2Au9xI4DC2COTGZmUZ8fBG+Z5P1n43zlbKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgo7+iHNYJDQCUlp+r3DeW8xPmTNfBXKNXiM+47ZzBFxQ+TIc7KSu0yR6rhrFP/AsgZuXW0jAU8aaZp0Ofo+e9hiQzmJ6r9d7SLf6g5Z2aF4iZ3cEebRFhnqtQtiu4/W1JpyARQ60oqLXdOMybRi3iiDcaSnNEiLuaTsfDMBHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXNUlGeN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso8743176a12.1;
        Tue, 04 Mar 2025 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741102136; x=1741706936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAq0uT6i67pZpyft0JKsd+GRwA7/+7Z3Xx89gv6MPLI=;
        b=NXNUlGeNZZOrClnB+Pmr1YwPuYpD3d57F8HhJQ/TrRPTw+3WgN8GL0JBZuLaCYosYn
         k76yuY4zXycHWb+y9hQeX6Vd+zj+PIlHfA53EFspear0FlUO9NlkSyXCG1suw/7ClVZc
         xbC5PA54bt40J66DvYOdgxDNbfgbxyI0PgQSf1oKQI3AmR59E4flIQG+3emyJ9L0OIeY
         m7n5uYAAQNvF/IR6hliShZ3zXeZcg41UnfUQIgS865dibPq7yuhZzKvbJUMEfF6/HCk+
         H/jzWpBPzqKNOk6//hkuz1EGfjC3lk7ngRhdeRsiB8PD2qBj0BJqlGDp6a80La56XEZE
         TRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102136; x=1741706936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAq0uT6i67pZpyft0JKsd+GRwA7/+7Z3Xx89gv6MPLI=;
        b=wSPsIrtid7V4ZuT+7c04oEyC9pXE/lhHUeJJZ1uRMDK0xOK0ExF9DKTrpVdh5Ud9De
         L9oSUgHKIWPDkb1nJD53so+rvK7Tsy/L5L8qtFasQ7a6bR/1Yn0zjbixWXKR+E7FBOg4
         CmOWbH7InNjSX2Bfz0Eh3ci2G4hCld0/dVFaPNu41l5FRzxWhXiQr62Dss1PuGxXO7JN
         EAHCySGElPBj7yjVmIKifHy9BtjCF4EuYHaHnvGL/kESIE1A8Q+iDcUGM9WrdZDfJ6MR
         rVy6ubMtJux3MNh1SZV5Vhp/bsGcKg7Kje94B/LqBTQGqcPAQNjkqboBnm2uEgSo02Tn
         0kVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg6eNtCGtZpjlGl/NZMSiOtwKexm/zic7kJ+jsSOeu46gj+fpE6rRyTy5ueN6xduhNCBLeqiunkXQl/ZwgAUTFXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyasey8Jxj+aUkxaDMyBCE9beW6Rqs0RnTkJB9ojsC01qgSWArE
	g8AQQQGAjmlEwcxUaXciYvspA0dCAZA8vbHs1fpj5au2143lah7Z
X-Gm-Gg: ASbGnctuf1HS6h7zlu9qPlcSa4aShbfhHboHlm6Mnu2RBUiTiSAu7bk5tn39ARTvIku
	bFoQm/wPjKZXaxCQCPdj3RZ8XEVsaciBekM4z6H335N7kYMz3Ww1TnfZAU07pfIisGCzNqA4rnJ
	uxsP9nsa9CRjLw8p/CHSMKTCa1pwMvhWek59RaUqDVJoFzEdEBpXbJuPb4GPCjqzRU+NDQlkyGx
	1FJU/7fGhgHT+VN9aBqkLmZCyGNpFMWijRaVsu2PVqrtM2jNEN/YsqYOiCzIg4KFYkcVSxMhgIh
	iEG5TneLyyvOzvCK91MwQ51F+EFQ6UPKf+8Ep+qGQH6mDg==
X-Google-Smtp-Source: AGHT+IFGLmbEKOuJDJJxg3hc4KYiwO5VF4VGn1csEbz/v4wXT7AEPdBeqdnEmuTGsnZHeXRjrGwflg==
X-Received: by 2002:a17:907:3f21:b0:abf:5db4:9e6b with SMTP id a640c23a62f3a-ac1f101c987mr356892466b.10.1741102136222;
        Tue, 04 Mar 2025 07:28:56 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm512002866b.101.2025.03.04.07.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:28:55 -0800 (PST)
Message-ID: <3102a67f-f18e-33c6-4301-4ab4df4db003@gmail.com>
Date: Tue, 4 Mar 2025 16:28:54 +0100
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
 <959B2AE8-109C-4EAD-A977-8EBAFD8A1075@zytor.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <959B2AE8-109C-4EAD-A977-8EBAFD8A1075@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4. 03. 25 00:59, H. Peter Anvin wrote:
> On March 3, 2025 2:45:48 PM PST, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>> On Mon, Mar 03, 2025 at 02:31:50PM -0800, H. Peter Anvin wrote:
>>>> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
>>>> #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>>>> +#else
>>>> +#define ASM_CALL_CONSTRAINT
>>>> +#endif
>>>>
>>>> #endif /* __ASSEMBLY__ */
>>>>
>>>
>>> Wait, why was this changed? I actually tested this form at least once
>>> and found that it didn't work under all circumstances...
>>
>> Do you have any more details about where this didn't work?  I tested
>> with several configs and it seems to work fine.  Objtool will complain
>> if it doesn't work.
>>
>> See here for the justification (the previous version was producing crap
>> code in Clang):
>>
>>   https://lore.kernel.org/dbea2ae2fb39bece21013f939ddeb15507baa7d3.1740964309.git.jpoimboe@kernel.org
>>
> 
> I need to dig it up, but I had a discussion about this with some gcc people about a year ago.

It was discussed here [1].

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117311

Uros.

