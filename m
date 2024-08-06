Return-Path: <linux-tip-commits+bounces-1953-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88DB9492EB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 16:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6017A283E7C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6117ADE4;
	Tue,  6 Aug 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9SnENaK"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CBE18D623;
	Tue,  6 Aug 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954347; cv=none; b=iGFuxwCYZln5Apa7kPc/vdnMDm5c7q8ZKru0Phkye7YNQ9If1NP5ZwYZEcLSrh2mzuhFCPTT89YA9cGe63uDGUa/IlT3Tb13fWgYrIUNqQpgH1a90EG8PxX4wBGtyhh7hl/c70ac3WD3JfntIOnvrBpEXF85LRCKLKisUTaLqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954347; c=relaxed/simple;
	bh=mnssGhPBWO68bk8UOFkUN2kFqYLjHCY4L4YhfdP1DhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP5IXHKrLbWUEVcGvcRwgtEbjyyTwJri/nOcBGe0R5PfnzYdyV7urxQZxqooS4wbVtazhXWfof+5/AVm9BpmssyzDSJwgO6i9OAqpOZNhQ8dByl7Z+pCCiOjUeUfAzxqSZRBVz2vEYsfXuGjCB4kDvvLacSjjvTtAuxnyTTY5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9SnENaK; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-264988283a3so300185fac.0;
        Tue, 06 Aug 2024 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954344; x=1723559144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yWLttfzGyrqCkqF3w1dTC2tsQvAJcZiPC68PlBswD/I=;
        b=G9SnENaKDLEQUMY5MFaH8pY46ze7vMUPilcStz4H/Xgf87mrwZ3sS4hMPadoRYUH3D
         PiI1TOOzNWV0ndxRXA4/XnzKRk/tvdy6+7ReYiI0s2UlKa8kPlCdSNSzo47jMvB3dt1n
         jaWXJVelw5F9q+k5QOXYviVhIWbb2X0LBokwEfqq5MHbrytcM3SZrDX4etBHjSzYCsSg
         dTnC5oca2Q3amSpkkrSDMtu5wAGpCTHl6GSSc8OdzglKAzuSZB45rZdd/qFULrnPwZxi
         Oc38oOUgedvEQM66/LMEaadAgpjY2oLG1ZrZBI2mcQBELVjB5yupjAtZoAVoO/L0IZ3M
         jJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954344; x=1723559144;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWLttfzGyrqCkqF3w1dTC2tsQvAJcZiPC68PlBswD/I=;
        b=B8O6IVn+SSkJKJScgAeKE8E1JnHKzh8K/xRrG1Sy+WKp0cZUWnZrO9bqnzFj6/32Yk
         jopWD8TLTDAvj/LDgw/um4PePx0+KMmBGghdT64KLnRdQIy3QOswSImWZO9rqSj36dGf
         7MNUijkORpPRoiXo4eSXFESm20X2hYdxlKD/eLxqc2ESsJSHkmamMqqFPHn8rqN1cKD1
         cTaBQo5MnqBGnRw0Tn5kEAMZ4i4GzJ+1FJka88tMvGn72pqXKiyzrE6WtgFEsCOCDG7t
         fqI6pB4cx9BTtMlDnnQcWnnUtO3SY5WdbUpsToFty/95Dj2YWrHkJ3X04yA0fknLqp7e
         CuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7UnZETonfj4d8OoacivpP0h1iCjdYRKsvJ3c/GQ0ONV+1vV5gcS11+eDIVzlnXeU7z/aLvH4h5TMgJFoYxLUd8u4XF0MulHh2R1h7AS4weQQ=
X-Gm-Message-State: AOJu0Yy+TC1P1lpbTRNBCf2tdp8rQsJboblJlXql3lTgZvdrI0mANSFD
	hkQJ7usPPh/f7Cnsg0+WnkD3PZUzLxO8omrggjDQbgSRk1j1dTVU
X-Google-Smtp-Source: AGHT+IFdw480CkU/6U8NFL5cWDhUZhqJWV/yeT1Q05BEF5RVsp8jr1mHCurUd0U9gWV8N2cz0DvEGQ==
X-Received: by 2002:a05:6870:c0cd:b0:25e:12b9:be40 with SMTP id 586e51a60fabf-26891d655c5mr16079045fac.25.1722954344579;
        Tue, 06 Aug 2024 07:25:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed14bc4sm7274038b3a.171.2024.08.06.07.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:25:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>
Date: Tue, 6 Aug 2024 07:25:42 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 01:50, Peter Zijlstra wrote:
> On Mon, Aug 05, 2024 at 09:52:06PM -0700, Guenter Roeck wrote:
>> Hi Peter,
>>
>> On Thu, Aug 01, 2024 at 10:55:31AM -0000, tip-bot2 for Peter Zijlstra wrote:
>>> The following commit has been merged into the x86/urgent branch of tip:
>>>
>>> Commit-ID:     49947e7aedfea2573bada0c95b85f6c2363bef9f
>>> Gitweb:        https://git.kernel.org/tip/49947e7aedfea2573bada0c95b85f6c2363bef9f
>>> Author:        Peter Zijlstra <peterz@infradead.org>
>>> AuthorDate:    Thu, 01 Aug 2024 12:42:25 +02:00
>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>> CommitterDate: Thu, 01 Aug 2024 12:48:23 +02:00
>>>
>>> x86/mm: Fix pti_clone_entry_text() for i386
>>>
>>> While x86_64 has PMD aligned text sections, i386 does not have this
>>> luxery. Notably ALIGN_ENTRY_TEXT_END is empty and _etext has PAGE
>>> alignment.
>>>
>>> This means that text on i386 can be page granular at the tail end,
>>> which in turn means that the PTI text clones should consistently
>>> account for this.
>>>
>>> Make pti_clone_entry_text() consistent with pti_clone_kernel_text().
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> With this patch in the tree, some of my qemu tests (those with PAE enabled)
>> report several WARNING backtraces.
>>
>> WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:256 pti_clone_pgtable+0x298/0x2dc
>>
>> WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:394 pti_clone_pgtable+0x29a/0x2dc
>>
>> The backtraces are repeated multiple times.
>>
>> Please see
>>
>> https://kerneltests.org/builders/qemu-x86-master/builds/253/steps/qemubuildcommand/logs/stdio
>>
>> for complete logs.
> 
> Could you try the below patch? If that don't work, could you provide the
> .config, I'm assuming that'll work with the bits I grabbed last time.
> 

Unfortunately that makes it worse: It causes qemu to quit immediately
without logging anything.

I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
the relevant information. Please let me know if you need anything else.

Thanks,
Guenter


