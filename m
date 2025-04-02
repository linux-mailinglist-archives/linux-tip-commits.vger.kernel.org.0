Return-Path: <linux-tip-commits+bounces-4622-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF12A78BCB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 12:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FAC189056A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF62356A5;
	Wed,  2 Apr 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="eCeJ3/Nl"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B051EA7DC
	for <linux-tip-commits@vger.kernel.org>; Wed,  2 Apr 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589068; cv=none; b=SZpze4Qkzmpvppblm6xQsPIPvk0Q8QDO5EETNznHp4B04tFh/bni7B+e5AnluljduLu/+l8+4EBfX0xS5rwL/dA5VFpQ0GndIncQOYYnFQuSTQMHnpAZS8QBsl+qc3vP8mtkkwdgoyKL1g/MoIz2cx5H/Sm5KvFi04MCGuoga/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589068; c=relaxed/simple;
	bh=ZZSTNmBOfT4Nx0GONHsYAwg/gVKbfd4PkCBpKCshoGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmT0t7b3ZiPcp5yK5A0bCZX5FyGOorMPSISZXNIAENeM8QJRLF5CN7btWIBSBMsd5SXGhqnFHquD0iNHEh9LWdsAxCXAtDyxKVwaqbY3+XkLUtH+aYnVGHrijg2rkF3TWJnQ1TI9rZQ1IAPjhJQOPjMpSmN6ONS0PsEgPNorHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=eCeJ3/Nl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c266c1389so952100f8f.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 02 Apr 2025 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743589064; x=1744193864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BoQN/cbdRb3bl+R0TruVM2i+azMwDjjz8Hy3l7cGhO4=;
        b=eCeJ3/NlYwLNOWRnlcbZ5Ty4EMF4maUJ18qYMuhbIs6FKm91QPW8REKT5vJGr7LnPp
         2wdCIFzSM1P5VSxPaAn4VcS085oz5bOKX3o2ElwO9soSbkfM9eyBnACgDU3uD6l2/Fb5
         NLGx2PCBL8zfm3sCUUNKX4JqJlYyk95mpWCXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589064; x=1744193864;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoQN/cbdRb3bl+R0TruVM2i+azMwDjjz8Hy3l7cGhO4=;
        b=FtcPjHa+ZtNRDVR3R66EbEHWPD97tTJwJlf4daX7vaKzmoPsIUzhvHO5z6cxeSYEKx
         TNLqWGQupjZVrPntUxwLUzz34mA+LVFdeDoURDoofjCNo722ZeT4KbMTJYoImOBooNkr
         b3JQkNF+fWa23pfyk2pa103tAOYiXekIwRGx9zpawa2VqnvF3z2JQje2qxILwPVMex9j
         GiSokDafb+tAdUrQ5Mx2eDQXUmI3/J5Xy/KfKVlDfAIW+Tx7ZPvzOrKLf6Y9eyrbvE2M
         bY22Gova6L2JMV/fDGezn9BQGwImY94tFkO+hSG9ImAmy0zNp8batWZ1m87xisto/GI8
         AmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXozTOSjIkhgdzangYJTFQFi/XAk1Eigt48RAjdWzx8KpJpAAYPi7O+AIM8/z9TBuoN9rFLOq50YoLHBDh3mj13uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2TLkTSQ9r8dVlPNIsFele8zIiyZZR5v2VlmSgB6C7taRffp/
	8fy+yIX7X+mq8lSb8xdMAIASWfEctgubsrmEPehASWVYBeU0X2hXCXEMCBEmqek=
X-Gm-Gg: ASbGncsr6Nh+j3wixrZVaGWY62np9bKOKw2n1MmlzM1/teyIETqADy7WRWVqYlsDObf
	80YwtyV10JaZfsTLcl59Iq4TxldzLspK7mjheV2bKl1Hgb7pw/VoNXGH+d7Ez959CdnzntyfgSZ
	WT3kwR5kqYE403euWQIfyGemUrvZ9mI/kL6cWYCu1uKa0O3ZEoR+IKfnBfHHXVvV/UxHFxIAUxq
	amcLIa6uMNu/MXGDxWtL2b/E6FyF3S3CGBxnv8e3a4bfXlKxuZN+peMm2UFF/XlGV5Ro1d+akZL
	Iz0j2T2g5rnoQxUjwkghGNx5UtJdxjZ1vVTELgR7WrTg1G8NFfAMw0ViPQrSKuFE3dLk49bdMRO
	DzVpoeLac1A==
X-Google-Smtp-Source: AGHT+IFKbv76Zb/vVr8KmUnWnp/XarFsP9YTgpQakXdkCwmU4iiDmtZ7r18nIo32KrZiYQpJ6mdzWA==
X-Received: by 2002:a5d:47c2:0:b0:38f:2856:7d96 with SMTP id ffacd0b85a97d-39c120ca2d1mr13273123f8f.1.1743589063733;
        Wed, 02 Apr 2025 03:17:43 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66cb3dsm16844958f8f.57.2025.04.02.03.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 03:17:43 -0700 (PDT)
Message-ID: <8f2a6d7a-cdd4-4742-9977-0bc1c1e872e6@citrix.com>
Date: Wed, 2 Apr 2025 11:17:42 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/mm] x86/idle: Remove mb() barriers for
 X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints()
To: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250402091017.1249019-1-andrew.cooper3@citrix.com>
 <174358864842.14745.908324129810950623.tip-bot2@tip-bot2>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <174358864842.14745.908324129810950623.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/04/2025 11:10 am, tip-bot2 for Andrew Cooper wrote:
> The following commit has been merged into the x86/mm branch of tip:
>
> Commit-ID:     90a22a5f841490790ecb17166633582681d44945
> Gitweb:        https://git.kernel.org/tip/90a22a5f841490790ecb17166633582681d44945
> Author:        Andrew Cooper <andrew.cooper3@citrix.com>
> AuthorDate:    Wed, 02 Apr 2025 10:10:17 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 02 Apr 2025 11:54:51 +02:00
>
> x86/idle: Remove mb() barriers for X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints()
>
> The following commit, 12 years ago:
>
>   7e98b7192046 ("x86, idle: Use static_cpu_has() for CLFLUSH workaround, add barriers")
>
> added barriers around the CLFLUSH in mwait_idle_with_hints(), justified with:
>
>   ... and add memory barriers around it since the documentation is explicit
>   that CLFLUSH is only ordered with respect to MFENCE.
>
> The SDM currently states:
>
>   Executions of the CLFLUSH instruction are ordered with respect to each
>   other and with respect to writes, locked read-modify-write instructions,
>   and fence instructions.
>
>   https://web.archive.org/web/20090219054841/http://download.intel.com/design/xeon/specupdt/32033601.pdf

This link isn't the SDM.  Its ...

>
> With footnote 1 reading:
>
>   Earlier versions of this manual specified that executions of the CLFLUSH
>   instruction were ordered only by the MFENCE instruction.  All processors
>   implementing the CLFLUSH instruction also order it relative to the other
>   operations enumerated above.
>
> I.e. The SDM was incorrect at the time, and barriers should not have been
> inserted.  Double checking the original AAI65 errata (not available from
> intel.com any more) shows no mention of barriers either.

... this errata link, no longer hosted on intel.com.

~Andrew

