Return-Path: <linux-tip-commits+bounces-565-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207DE862079
	for <lists+linux-tip-commits@lfdr.de>; Sat, 24 Feb 2024 00:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6F6B21B3A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Feb 2024 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19D25750;
	Fri, 23 Feb 2024 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2DctEtd"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C651149388
	for <linux-tip-commits@vger.kernel.org>; Fri, 23 Feb 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729567; cv=none; b=m4s652/PB/2dWF8fDTbQtGj518yKKH7t68scdmJvoO1FwXPE66EPCrWlPjQKBgZyfMOrD1fjIz7HC89xhdKuyd2T6wd+bcHzp+JQmiaZ/1x23duIwoeu4fELnjj60QCP6IuWdAPwqu8kl/iPFBLx/wGNW+PuAUnk/y0BEg3DK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729567; c=relaxed/simple;
	bh=J6bXP1G3QdLIlVsw3ae4ffaCMfgBaHhuhqhaoJM4o70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OU/1e7Bh1qyGaYwGHpIGGQSlUe/T0V1K40MAC6jEn0dpP4SNq4wCI2jvgBAdEM9yP23A5t1xDXcBWmve0Fp+F3LLE78MBYZZNARWnQNXtyF0glQUPBJjFgzO69+5iEpqzepBpvEpiWBNXYIbvZtUqnA9II2GrArknOXyfHpJtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2DctEtd; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso24711839f.1
        for <linux-tip-commits@vger.kernel.org>; Fri, 23 Feb 2024 15:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708729565; x=1709334365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLeRg2l+zjx6Yl/cN6c5YNblAb/+0HGlH3Tm2g01R+w=;
        b=b2DctEtdJLvwQZ6ig0djSvdnNRMoBt3uKArQ7K3Ohg/NSmU6MvkZFFZJ6N513mDmlh
         AswvD/ajypg6WRrhCpUZWAZiw/Zy0MykcwDhGRPtmt4ZNalDmZJlNCd7RpFahtMf827o
         r4IvnYRA3dYuXFmzAcNy77U24FA2HDvGHq0z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708729565; x=1709334365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLeRg2l+zjx6Yl/cN6c5YNblAb/+0HGlH3Tm2g01R+w=;
        b=rVFLdPF4OtlxINPdHH5WWlsntu+hZ15OtaIKpJriCraBbgTqDyuEChIRsTw2whNc74
         /laxmvXu1MzJ0Na0ViCjx4IpsNqs9hQUKrssniuWRHJ+AWLB1fmagF828vBZGChUev82
         wQxNnlT/XbsdB41urAbkdQzV/ftbwcwK3YnzA8xD6ka/HItfSWJySPD9VeNAeRtYET7G
         9WSv2syq7c/jgy7Z+NB2xpPf/95Dm1OjgKXSlnSNAKp0BNvDbEHRDoTUqEpka/P5RJpI
         14wDmNRQqZez5msIbSaBtPcZHYZ4IwtuyJ8/smy5FgfCNsgD9qF3scf7FEka1KhDRpI1
         KIdw==
X-Gm-Message-State: AOJu0YwhhdCc0D5IZALdKLUOq8WQJoZFwoKBm5BjzeURKDVsyEPrE+qT
	JlCry7iuKYNDcJQqMlgYjD7bJcw45yKOYOgrgw2nrpCkcbP984eJrbwR+0vB5MM=
X-Google-Smtp-Source: AGHT+IFEftspqDtDIxxsQ5+ckY2ai/56+ejYA2aJNqRi+8pa5blkF7cy0fo1/qadRcUdTfshyAZdUg==
X-Received: by 2002:a6b:5101:0:b0:7c7:99f8:289a with SMTP id f1-20020a6b5101000000b007c799f8289amr1199837iob.2.1708729564570;
        Fri, 23 Feb 2024 15:06:04 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id gt22-20020a0566382dd600b00474089334c1sm3983743jab.77.2024.02.23.15.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 15:06:03 -0800 (PST)
Message-ID: <629d5de5-f728-402a-888c-cc207e60c30f@linuxfoundation.org>
Date: Fri, 23 Feb 2024 16:06:03 -0700
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/core] time/kunit: Use correct format specifier
Content-Language: en-US
To: David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240221092728.1281499-5-davidgow@google.com>
 <170853967893.398.2243431921138187436.tip-bot2@tip-bot2>
 <CABVgOSn8m9SgCzu0KzYt27qMsze+LfYET=d97Pb_=TCVciyzFg@mail.gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSn8m9SgCzu0KzYt27qMsze+LfYET=d97Pb_=TCVciyzFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 00:01, David Gow wrote:
> Hi,
> 
> On Thu, 22 Feb 2024 at 02:21, tip-bot2 for David Gow
> <tip-bot2@linutronix.de> wrote:
>>
>> The following commit has been merged into the timers/core branch of tip:
>>
>> Commit-ID:     e0a1284b293bdf91a68a6d1a0479ad476d0d8ec2
>> Gitweb:        https://git.kernel.org/tip/e0a1284b293bdf91a68a6d1a0479ad476d0d8ec2
>> Author:        David Gow <davidgow@google.com>
>> AuthorDate:    Wed, 21 Feb 2024 17:27:17 +08:00
>> Committer:     Thomas Gleixner <tglx@linutronix.de>
>> CommitterDate: Wed, 21 Feb 2024 12:00:42 +01:00
>>
>> time/kunit: Use correct format specifier
>>
>> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
>>
>> This was found by extending KUnit's assertion macros to use gcc's
>> __printf attribute.
>>
>> Fixes: 276010551664 ("time: Improve performance of time64_to_tm()")
>> Signed-off-by: David Gow <davidgow@google.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/r/20240221092728.1281499-5-davidgow@google.com
>>
> 
> We're hoping to take this series in via the KUnit tree, so that we can
> enable the warning in one place without annoying Linus with lots of
> dependencies between PRs.
> (See, e.g,. https://lore.kernel.org/linux-kselftest/CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com/
> )
> 
> Would that cause a problem?
> 

Linus wants this series to go through kunit tree. I will take care.

I will pick these up for Linux 6.9-rc1 as per Linus's request.

thanks,
-- Shuah


