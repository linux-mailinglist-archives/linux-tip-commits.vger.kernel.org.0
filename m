Return-Path: <linux-tip-commits+bounces-1958-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B79495C0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 18:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7E8281A06
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3263F9EC;
	Tue,  6 Aug 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INOf2f3I"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0F2C697;
	Tue,  6 Aug 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962547; cv=none; b=Hcc7oM9NitfnG2L5O0GCHld4JS9HIPRkggBRcBfhpp1B/PVWx2U2NYUJY8ruVGu393clzBbWewtqevapdmr+LNSlikRjflIgoUergl1Y5/axz2qEeHkfMFigE8gApIcUoZVqKLtphi0j4zYmeXof3PPZOauY7J23mHJEmBiev9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962547; c=relaxed/simple;
	bh=3UGqH7KoicUxKYN56ZUpWZAELhcMll/UFEAkjUjWMIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ousMcfdvUqhSaOcCD3RFGeAZLkZeTDrIvvMHDup9hrD+4fczse+SMXpff7qme2J3bMz1o6A4IodPdC3UCpdzmJS8ZCDK2rCjV4UaME2E4waR2i7vaK+XKAtB5gdTkqJs9UgW7UhT814d2EUcDQ4b1lKJmkaJFkMyKuCmGh7DdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INOf2f3I; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ab09739287so479386a12.3;
        Tue, 06 Aug 2024 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722962545; x=1723567345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3X16w1ElggSZ9F8ZzAYTc7zWyvivrO1Wvd05M2ygJUw=;
        b=INOf2f3IO6vopteUduOuPhMxZImZN5VKmbs360+JLquQLe89Wv9sENoeMFSkaaPjgf
         EgiqWWSn8yAfUPISszhKZryhPFR77CaRCnpqBmQChSnfxZrHqKqnXr30ZHlKfwgaiycw
         9d/WynHSQgjthiHXZoRm0qvQlbjTOyF5eTy9/64aUCCaVY+2vJljLu6wEihOW1hz+hjK
         WozAbWUjb5CB9qQ2PffVDoi9esDG0ru6ubdRrj3/OhHO6oZ3uwLo4bG9GjixrrZawudg
         6Xi88FSb+HRVFfpg1XUUGDJIynwOYraaFh/St3Wun8Gn4Pq2AzNk9O9bbHO67+nGcxKu
         t3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962545; x=1723567345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X16w1ElggSZ9F8ZzAYTc7zWyvivrO1Wvd05M2ygJUw=;
        b=OU3pN6nI9XV1J0zufPcoRPVqPFMdWMucr0khI/aCS+P77Gbb6IqzbmmiPmLoY2I4/Y
         AP4j6jA/FGPZRT6rYRIkQi+FrTqHEOvf8vMC/jQDfG+kBOR6wduAgNa9i7dNwYle5DZn
         z8hxwLrlpAYfll8n8WM3QJVxrAMy4PHny90jccbEoelq56A8OX/mC4NNjZNI/ndQBh2D
         uCRbxd6Cm9CeGfw4Ab9YX3uhXFKad7mr+bBXOU3RS5VO0MPfiQVZys5ZXAydRf1mlYQD
         EMSeCf5gi1uVQvfb52LNyEQbj2l6wXjMOmaRKbr3lOnJaQ6eIw+J8zKNvkzTpFo4jgIy
         xVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWS5rsT/pYnKpboA/Tp/avPEN8mQnzjuihZNiXbSQrDVetGk+bDmG9tdfFsDqu0onSAE8S1fPmiVS2aFNGsy626ecwNUIC9+zQo4rwNylT1x0=
X-Gm-Message-State: AOJu0Ywhle1oQIYcvi7lq/ndZMttsFzfECekdbi0s+MvUUtLJmruubqj
	h3mon87BNVaBBywBzO/7FsUldqByzLRiGP0a4iSJHWJpx2Jcp8qZ
X-Google-Smtp-Source: AGHT+IGitvFO9UlX0Te4dL6QfCzPtqZYtaNJZTUoSRlQXZUATHT81F/ggxONM0Edxk8GmPwXkHegmw==
X-Received: by 2002:a17:90b:8c2:b0:2ca:1c9e:e012 with SMTP id 98e67ed59e1d1-2cff93d4117mr14632511a91.6.1722962545327;
        Tue, 06 Aug 2024 09:42:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb0c681esm9387870a91.25.2024.08.06.09.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:42:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eab8db58-1eb5-40f7-b7c9-e58558937bf4@roeck-us.net>
Date: Tue, 6 Aug 2024 09:42:23 -0700
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 x86@kernel.org
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
 <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
 <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
 <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>
 <20240806145632.GR39708@noisy.programming.kicks-ass.net>
 <20240806150515.GS39708@noisy.programming.kicks-ass.net>
 <20240806154653.GT39708@noisy.programming.kicks-ass.net>
 <20240806155922.GH12673@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240806155922.GH12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 08:59, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 05:46:53PM +0200, Peter Zijlstra wrote:
>> On Tue, Aug 06, 2024 at 05:05:15PM +0200, Peter Zijlstra wrote:
>>> On Tue, Aug 06, 2024 at 04:56:32PM +0200, Peter Zijlstra wrote:
>>>> On Tue, Aug 06, 2024 at 07:25:42AM -0700, Guenter Roeck wrote:
>>>>
>>>>> I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
>>>>> the relevant information. Please let me know if you need anything else.
>>>>
>>>> So I grabbed that config, stuck it in the build dir I used last time and
>>>> upgraded gcc-13 from 13.2 ro 13.3. But alas, my build runs successfully
>>>> :/
>>>>
>>>> Is there anything else special I missed?
>>>
>>> run.sh is not exacrlty the same this time, different CPU model, that
>>> made it go.
>>>
>>> OK, lemme poke at this.
>>
>> Urgh, so crypto's late_initcall() does user-mode-helper based modprobe
>> looking for algorithms before we kick off /bin/init :/
>>
>> This makes things difficult.
>>
>> Urgh.
> 
> So the problem is that mark_readonly() splits a code PMD due to NX. Then
> the second pti_clone_entry_text() finds a kernel PTE but a user PMD
> mapping for the same address (from the early clone) and gets upset.
> 
> And we can't run mark_readonly() sooner, because initcall expect stuff
> to be RW. But initcalls do modprobe, which runs user crap before we're
> done initializing everything.
> 
> This is a right mess, and I really don't know what to do.

And there was me thinking this one should be easy to solve. Oh well.

Maybe Linus has an idea ? I am getting a bit wary to reporting all those
weird problems to him, though.

Guenter


