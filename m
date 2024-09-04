Return-Path: <linux-tip-commits+bounces-2162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75396C62D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 20:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BF41F24734
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC61D6790;
	Wed,  4 Sep 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CeqA4bv9"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD91E0B81
	for <linux-tip-commits@vger.kernel.org>; Wed,  4 Sep 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473849; cv=none; b=dNok8CLWISDqYid5lRefXiZtcj4i9VSeHSDfuQD12ZbmEfJ0nTt9JfYcJfzYP3gRVkTZJtJZe567Ubn8uaz68Hkesxvv0vNFHdzroJX9doYMmYT1ugOaDXdTBG0OxnZjasm6X3ZUrB8zn3sQDzPCmX+4c3ubWIUwzLB+cx1vryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473849; c=relaxed/simple;
	bh=I+W2NTfc/9xVJnzHclTz/BeZPNHQf+LIMxJrxmBhxSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9xhIdS2MM8fbEuEPPpLtS6p7ADc3Ua8jMfk43xPPksVAYrOaMwpoXVkjHI/nQcuX9rn9C0PSovF0htCxMvBUEyRsseS267DfT8FKbur/vgQwJ9vGY0PeJ5ApUVvEbp0lrrSAG+exP15AbIeGdf0tN8Y659BTP3oQKdIk2rD3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=CeqA4bv9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86859e2fc0so798185466b.3
        for <linux-tip-commits@vger.kernel.org>; Wed, 04 Sep 2024 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1725473846; x=1726078646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6IkJHHyuzo9n/xqNW/T3zjv0yv5Sy4kGkYP2i0t9yco=;
        b=CeqA4bv9Hn5w+dW4RuGOua/qYoSj9obpehfgsSvUT8jxndYiLH4HFJ2VfnQEVUr0+Z
         lfbaiCX6OKG7RvcmDVQhrwd1k4aLeZBdBGpl9QacG8AU+LpIhiRSTKnFeDS0W52lxriY
         qkQVVlYvOp/8/NAM/EaFAuFOtoA3+JuHEjGa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473846; x=1726078646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IkJHHyuzo9n/xqNW/T3zjv0yv5Sy4kGkYP2i0t9yco=;
        b=Jq5UHBlMcNEcmukcU81vogdHhaSeIpy493PwQ010+rnZG+HqiljXgDb0BnbKLANUHW
         MANSdb4RY8OQpzazi3Fa+c66xNYRPpoHXeY3srXALmr8J1oOXPGCQIAqWI7mdtxqk4xO
         Sir0VJH8voXD1j3CSFEni3qY5Di9b5ki9qL4CZMylSEsv0O4G8idWhbS6ltQdKa4/XdM
         XoF2QvQOxhjIa6OJ/KdaWisjRzy1BPcNtX+PRHdNSxsApiIdkZfovREf/hNq1OWKrirO
         BM1ZQI2Bjd4PADb8uYjoaeXbp+4Z/PnKn4PYmLOgvqudx2un5NEVGFohtYP3+X4C3dMB
         s/iw==
X-Forwarded-Encrypted: i=1; AJvYcCW+DwCwAlf+/YqBAO3UUM/HHC7SnehVnU573rT/sQsib3BX2wQHEyydKA/590nDSJzX7BIX7RBj0ZTHzcWLnZpeUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQopydppsXFE2ZNHJhMKozrfKINICZoCR6Es/Ch3O5MYqWnx7
	ylg4TGZIN0OoHcukJPGQLrJ86Xu4REfJJ07KUn5L597m/iT9WHZOQA5jWA4zPzY=
X-Google-Smtp-Source: AGHT+IEJiF8Xyygz2cHMSbHkH4dx5Nw3HKnkwdJc4P3JjMBGxQfgXs+PkCIQUUt5ds0uDBVsfpNqKQ==
X-Received: by 2002:a17:907:944f:b0:a80:f81c:fd75 with SMTP id a640c23a62f3a-a8a32a91b7emr443793266b.0.1725473845209;
        Wed, 04 Sep 2024 11:17:25 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623c335bsm20674066b.179.2024.09.04.11.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:17:24 -0700 (PDT)
Message-ID: <bcec53f3-e6e0-4585-89f9-80c64b20649f@citrix.com>
Date: Wed, 4 Sep 2024 19:17:23 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/cpu] x86/cpu/intel: Replace PAT erratum model/family
 magic numbers with symbolic IFM references
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@kernel.org>, Len Brown <len.brown@intel.com>, x86@kernel.org
References: <20240829220042.1007820-1-dave.hansen@linux.intel.com>
 <172535592591.2215.9909836777026903684.tip-bot2@tip-bot2>
 <c9f18ae0-8239-495a-abc2-d6538fbe5f5e@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <c9f18ae0-8239-495a-abc2-d6538fbe5f5e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2024 7:46 pm, Dave Hansen wrote:
> On 9/3/24 02:32, tip-bot2 for Dave Hansen wrote:
>> -	if (c->x86 == 6 && c->x86_model < 15)
>> +	if (c->x86_vfm >= INTEL_PENTIUM_PRO &&
>> +	    c->x86_vfm <= INTEL_CORE_YONAH)
>>  		clear_cpu_cap(c, X86_FEATURE_PAT);
> Andy Cooper did point out that there is a theoretical behavioral change
> here with c->x86_model==0.  There is a reference to the existence of
> such a beast on at least on random web page[1] on the Internet as "P6
> A-step".
>
> But the SDM neither confirms nor denies that such a model ever existed.
> If the SDM can't be bothered to acknowledge its existence, Linux
> probably shouldn't either.
>
> Either way, we're talking about a 32-bit CPU that's almost 30 years old
> and was probably pre-production anyway.
>
> I'm fine with the patch as-is.
>
> 1. https://www.sandpile.org/x86/cpuid.htm

This same purveyor of top quality x86 history pointed out that PAT
didn't exist on the Pentium, PPro, or P2, so they are unlikely to be
affected by this erratum.

Other cross references if they're helpful:
 * Banias Y31
 * Dothan X14
 * Yonah AE7
 * Yonah Xeon AF7

Finally, this looks suspiciously like it's the bug described in footnote
1 of https://sandpile.org/x86/coherent.htm MTRR/PAT conflicts which
otherwise identified that the early PAT-capable chips did behave as
expected.

~Andrew

