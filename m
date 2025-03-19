Return-Path: <linux-tip-commits+bounces-4326-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1919A6898F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B274817A223
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66E253B71;
	Wed, 19 Mar 2025 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLIjvtj+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F21F585C
	for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380048; cv=none; b=aWEg/hX7aUcPK8Oo9J0U8Ldeot+ujESBk4d0eUKm3eSTfzutx1zMdlrkX1s8yOuEKqkAdkrCKl9blmByXVGoYkeM709svjgF3gDIxEpr1eQOzZD49SfaVDdLoDVFa88381iFP6r9b5fYNT2ZtG+9EAIV4OEFBSf/o1ads2hc/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380048; c=relaxed/simple;
	bh=bqyrkozSND5Nwqi67cu4PXT4r+KPyK5nBABctNN/y7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJzxcPUaEKQ2R/TTA3DFsfq760CaP4HDLqupuT7GxEmUsONW4CbK/lLhX4fawXkyR7k72ACfPaKApCNRL0A5SuM+T0Skm/MdJkLPiFtfIu97izKjuurKU4iKD21sNkSoa0ZBYfWpZOwDzmqoH1lpWFxMvVRpOji8hT88aOYzBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLIjvtj+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742380044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w6I2VFnsXYw7egElqHpLyRTYmIDRLSZRt374tXWnPyM=;
	b=iLIjvtj+ulN53XoWtggUPkivBbbN0rfcBvFIIvpbweckBRSoObjftdyHjHHwhxwPZl0myJ
	fIkFBqoMovT92Jctt0gokMAFxPqbZfVNYvjyrcJ+hynrSpHW5ggq6cBst5J+XbxVSORc14
	LBXW4Aqo/a0QkoqDNhqH8SL8sGztXFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-8wgjOtiFO0SaYXL8N1MfYg-1; Wed, 19 Mar 2025 06:27:23 -0400
X-MC-Unique: 8wgjOtiFO0SaYXL8N1MfYg-1
X-Mimecast-MFC-AGG-ID: 8wgjOtiFO0SaYXL8N1MfYg_1742380042
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912d9848a7so287723f8f.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 03:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380042; x=1742984842;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6I2VFnsXYw7egElqHpLyRTYmIDRLSZRt374tXWnPyM=;
        b=iZsflrT/iCW+NrmZ2TNRSPph87w0V/gCjxN0zxDCCsWXHRvfXkZoXKb8foZafl8Wrr
         oZRaHLt1FcQAsvdWvmCskIMUHPXytgUbs/Z9X/CZus54RLIUB1YshlSuBE/sXpD49C0Z
         Rk0iYiplYww5BFxqMZdOqscSNJ539HshQHPqJ7sT9s8yLn7qfoGXWayzPusbA6/1R7l7
         AXwS58y+WHaJV12+YEuByjly36L3RhBdfeOE0yg3erxO6jCSmOebQf+jhnHFmK/DNpht
         hiY30yttYmrb0N9ppIvxWa9PUvNiJuQfs3nD5JftG1E5t7ZALYLPYXMhI227fAQ7b7AP
         exEg==
X-Forwarded-Encrypted: i=1; AJvYcCXvCgAQoJPMNk7WGsMM9DXuKXyWbI2iQPWpsSqA125NFUnicAKyHSp3+nddB6yFAhwbY4AlNKja2QNBr0fCUWIo1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YySWd4Rq8Ks7QNL8rU3A2XV4EhbNAZsb3vevokbKuaj3zzfKIPs
	HXMQfSu2vVQqUb+IOGkigfavwSUnCwuy/8fgJjG9xaa7CHh+ePckDk/+15Xj/F4v0a3yA+HTAlU
	Xl8aHV8+Qyvk7x2h/WzwtbuqQc3e0Z+xoHg7nMWWKoCavT3vRyJ2e072UFCdOFEHZNJIp3cnT1U
	Iy5cU=
X-Gm-Gg: ASbGncur2rkvY0yf4gLyMASmxZc16WM+FOA9nGdfsA1qOSGGVN9EW2joJT0/rBV09Hb
	6ESoFw6SVoBJhgRHDOd4APw4cMQRCeDE5z3sMIojrRCpFWGHdQhmDTzVOQTE/OvqGHunh4U2x+H
	e22bQP/qUxtJOa4m1+z0cXR9H5Z5G2C9EGCzuX5rVdTBkO1zLe39tMnHzfwcLXz88a6vbcdAj5h
	ILFJdFcJrNvQS6vwdxErwtWNDHmaU4W/5k5qiEgk8m4e5fLyqygKdnz68hZQVpdsadbkQSH55Ps
	pD6vMGuN+iyw/rKJPl4oULy7cgh2HfX4+heEUZbVBm9Da8FbB6+PT/uUf3uvw3JkRnc1u+jx/27
	xylpc9N823LuoqLWb1eAxoV/I8nsmFYkGviy6tGh5EUs=
X-Received: by 2002:a05:6000:1a86:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-39973c1ac04mr1897821f8f.15.1742380041891;
        Wed, 19 Mar 2025 03:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF697jtjfPAqJaOx+sNTtFGA/kggYGBBC7AVzh2/zkXFnYPMeF6m6RVE9iL68KjM25NVBwsEA==
X-Received: by 2002:a05:6000:1a86:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-39973c1ac04mr1897805f8f.15.1742380041493;
        Wed, 19 Mar 2025 03:27:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm16338663f8f.15.2025.03.19.03.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:27:21 -0700 (PDT)
Message-ID: <faa04276-a4d7-48af-8957-9123cc09f66b@redhat.com>
Date: Wed, 19 Mar 2025 11:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 xingwei lee <xrivendell7@gmail.com>, yuxin wang <wang1315768607@163.com>,
 Marius Fleischer <fleischermarius@gmail.com>, Ingo Molnar
 <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Xu <peterx@redhat.com>, x86@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
 <20250319095357.GAZ9qUNaWSORZMXdRK@fat_crate.local>
 <50f03347-0586-4284-b02d-b16abf89e656@redhat.com>
 <20250319102441.GBZ9qbaZfRWdYFIknU@fat_crate.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250319102441.GBZ9qbaZfRWdYFIknU@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.25 11:24, Borislav Petkov wrote:
> On Wed, Mar 19, 2025 at 11:16:36AM +0100, David Hildenbrand wrote:
>> Ahh, the commit id is already supposed to be stable, got it.
> 
> Yap, we try to avoid rebasing when it becomes really hairy and the commits
> have been stable and out there for a while...
> 
>> I'm currently testing the following as fix, that avoids the second lookup
>> completely.
> 
> Cool, please holler asap what happens so that we can act accordingly.

Yes, expect it later today -- have to refresh my brain how I managed to 
reproduce the original issue.

-- 
Cheers,

David / dhildenb


