Return-Path: <linux-tip-commits+bounces-4324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C8A68940
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19867A2374
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062F25486A;
	Wed, 19 Mar 2025 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4kNjDBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642B253F31
	for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379404; cv=none; b=Tpd6eSuzFz/3DZzM/lDZ19zeN2g7k3Ex7x3Pflb3vPQ/shXKMigwBs8mFT+urWhHO7eLjBcWQnSwOnkalCUPMjqzH+3TuUB7j3uhfMZBbhXp9vK7XZQ/fxzKmVteqzAeBWb3x+7Ki4zJq+isZWZ2jJbgldv9/m9cz3r2Bke2238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379404; c=relaxed/simple;
	bh=0hSJo2J5wCCA1EZgIRBa+ebBcVYXCVSDSlcROBWW8Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcWtYUlWmKApTY6KNuGdeOYSBj6Wr2WsH2GITDlY5K86ulrkO7EaBFfKZZzueWpOAEv2SJ21FU2ki1iXVeTXcvp/h2fO6DMGCtCP6WYTFjwle3zOdpcAAq/e7Pg21xqNtCKFz68rOyUwNRtGg3zZWdYtbDfV5Er1Q0o5ld/E7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4kNjDBh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742379401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=91wwG22Y+Rqbu05JtzKTJdgphnYK9zSeEo9I3ddJK2Q=;
	b=R4kNjDBhQ16gVLkYg7GzWZ+QcLHWTohHLVQlIvEBT40wCQxI5ddsUj+GKTwvhGXVzWRCcD
	LklBMRP3bSjBax11UmvLHWjJg6gn+l18sZe6M9Q1SkzOXLLzUALZ5478BUrhSa4P08ghXc
	CLnnILvJXEFcCgpMuSz7oHZ9jX0/uy8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-1CCHpDiFMxul29iHWyGTYQ-1; Wed, 19 Mar 2025 06:16:40 -0400
X-MC-Unique: 1CCHpDiFMxul29iHWyGTYQ-1
X-Mimecast-MFC-AGG-ID: 1CCHpDiFMxul29iHWyGTYQ_1742379399
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d08915f61so24312455e9.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 03:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379399; x=1742984199;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91wwG22Y+Rqbu05JtzKTJdgphnYK9zSeEo9I3ddJK2Q=;
        b=a6rr4TYk9kQmXiOpparszEvM+KmMTNycRupwjwEIJtC76P9BkI+GJKv1Qx5feD8RYg
         tZPV56OYTGV7owqkPJHTT0enlUQIwnxL+vP9YndxRCI/1LUl2ZoB1WtosTtQF2ZewdVI
         Y/K95mN5OGCaSS8+CyPIpyrl/chYYd4D27u1Ar4H+i3/an81zi+G4lU9d4WDaJZaDUey
         wn6x5qYXjpu0bLTm5kvF8hnvff/BXVh/pN56xIytJZiEcq4LGflksBQPmywQ4Nv5Fg/C
         smDqM5ANI0jUuuc6qlXTTXVAtd+oaJW8mQZCSZ0LDf8ElxgMZ7TcxY+aeCG3UYSzc2dU
         166w==
X-Forwarded-Encrypted: i=1; AJvYcCWr4Cw2ZyeUVa4FWWu2O12Pj3ugbnp1fXtCL1xlhtrKsGAfrs+EfhAnqjFdtVoGY0y3842uF3WIBMFBXbMY0nus5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEelREBR4W+U1T9sb0H/CjgO8FclUTc0RN8Vg78elxVQvVr08
	ruaiH9jWM4vEQHIWs+ea/vurEPqVMZyt6bzfjx8uTdR3gg71jXFBbBIVs7HSZM3vEE3g9H/ci6o
	87+01aC+eqoTJbqCNh0MTZmXj1ULxbPGeCKMXdTc2hlJVU2nkmAoIBJ6o9bkh12r+WqH6
X-Gm-Gg: ASbGncufr1frcsU9IFn7yQinssFeuHRU2NCoBcj1N0yK/C+yT77SdkwYeT1vdzMB12F
	OB70pdNJAoEZzpIU5FUR5PcWBY6Zgr5DQ5cBonBhO3ogfskbZBEfet/v+jOvLWoCQ35/tfH4iJj
	kK2SH4XB+jZQR1ssCgyFWuCHdT9xZMCSzfJkI40gIPf/L1lFM1QTknGltYETg0PJZuUOFBKqs8c
	1GcQHjiwK6Kon1HIOA808rWVtzMb7m6dyDFIskKB1bgUdb6rSbsB/wgPRqG3i3ITKbhWNUFxY5B
	Gc1jPDay7DUQVIpqP5UVVGT/hVvREFnqx7SkKWeGaadjo7oqOvDG3k9iKAY60i6r5p10Eohnin0
	oJpJnqBuu5nl+PmG4vNKPASk6N5A0jeZRML9urwK7hOk=
X-Received: by 2002:a05:600c:511c:b0:43c:eea9:f45a with SMTP id 5b1f17b1804b1-43d43782c16mr16437465e9.4.1742379399224;
        Wed, 19 Mar 2025 03:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFznXOHldufxwxcarInBMZBj/ol7JdOcnyV1ca9pCHCLMaEOcCqEEg9UZeCPsON8UmXbgmcrw==
X-Received: by 2002:a05:600c:511c:b0:43c:eea9:f45a with SMTP id 5b1f17b1804b1-43d43782c16mr16436995e9.4.1742379398540;
        Wed, 19 Mar 2025 03:16:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f3328bsm14433465e9.1.2025.03.19.03.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:16:37 -0700 (PDT)
Message-ID: <50f03347-0586-4284-b02d-b16abf89e656@redhat.com>
Date: Wed, 19 Mar 2025 11:16:36 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250319095357.GAZ9qUNaWSORZMXdRK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.25 10:53, Borislav Petkov wrote:
> On Wed, Mar 19, 2025 at 09:15:25AM +0100, David Hildenbrand wrote:
>> @Ingo, can you drop this patch for now? It's supposed to be "!get_pat_info"
>> here, and I want to re-verify now that a couple of months passed, whether
>> it's all working as expected with that.
>>
>> (we could actually complain if get_pat_info() would fail at this point, let
>> me think about that)
>>
>> I'll resend once I get to it. Thanks!
> 
> That patch is deep into the x86/mm branch. We could
> 
> - rebase: not good, especially one week before the merge window
> 
> - send a revert: probably better along with an explanation why we're reverting
> 
> - do a small fix which disables it ontop
> 
> - fix it properly: probably best! :-)

Ahh, the commit id is already supposed to be stable, got it.

I'm currently testing the following as fix, that avoids the second lookup completely.

 From 0f42e29d5ba413affa2494f9cbbdf7b5b6b4ae2e Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Oct 2024 12:44:59 +0200
Subject: [PATCH v1] x86/mm/pat: fix error handling in untrack_pfn_copy()

We perform another get_pat_info() to lookup the PFN, but we
accidentally

Let's fix it by just avoiding another get_pat_info() completely,
simplifying untrack_pfn_copy() to simply call untrack_pfn() with the pfn
obtained through track_pfn_copy().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lkml.kernel.org/r/lore.kernel.org/r/1d5de3d6-999b-47ca-8d43-22703b8442bc@stanley.mountain
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ma Wupeng <mawupeng1@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  arch/x86/mm/pat/memtype.c | 32 ++++----------------------------
  include/linux/pgtable.h   | 23 ++++++++++++++++++-----
  mm/memory.c               |  6 +++---
  3 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 3a9e6dd58e2f0..dc5c8e6e3001e 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -985,7 +985,7 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
  }
  
  int track_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma)
+		struct vm_area_struct *src_vma, unsigned long *pfn)
  {
  	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
  	resource_size_t paddr;
@@ -1002,36 +1002,12 @@ int track_pfn_copy(struct vm_area_struct *dst_vma,
  	if (get_pat_info(src_vma, &paddr, &pgprot))
  		return -EINVAL;
  	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
-	if (!rc)
+	if (!rc) {
  		/* Reservation for the destination VMA succeeded. */
  		vm_flags_set(dst_vma, VM_PAT);
-	return rc;
-}
-
-void untrack_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma)
-{
-	resource_size_t paddr;
-	unsigned long size;
-
-	if (!(dst_vma->vm_flags & VM_PAT))
-		return;
-
-	/*
-	 * As the page tables might not have been copied yet, the PAT
-	 * information is obtained from the src VMA, just like during
-	 * track_pfn_copy().
-	 */
-	if (get_pat_info(src_vma, &paddr, NULL)) {
-		size = src_vma->vm_end - src_vma->vm_start;
-		free_pfn_range(paddr, size);
+		*pfn = PHYS_PFN(paddr);
  	}
-
-	/*
-	 * Reservation was freed, any copied page tables will get cleaned
-	 * up later, but without getting PAT involved again.
-	 */
-	vm_flags_clear(dst_vma, VM_PAT);
+	return rc;
  }
  
  /*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index acf387d199d7b..97f8afccfec76 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1509,10 +1509,11 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
  
  /*
   * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
- * tables copied during copy_page_range().
+ * tables copied during copy_page_range(). Returns the pfn to be passed to
+ * untrack_pfn_copy() if anything goes wrong while copying page tables.
   */
  static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma)
+		struct vm_area_struct *src_vma, unsigned long *pfn)
  {
  	return 0;
  }
@@ -1553,14 +1554,26 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
  extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
  			     pfn_t pfn);
  extern int track_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma);
-extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma);
+		struct vm_area_struct *src_vma, unsigned long *pfn);
  extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
  			unsigned long size, bool mm_wr_locked);
  extern void untrack_pfn_clear(struct vm_area_struct *vma);
  #endif
  
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn)
+{
+	untrack_pfn(dst_vma, pfn, dst_vma->vm_end - dst_vma->vm_start, true);
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+}
+
  #ifdef CONFIG_MMU
  #ifdef __HAVE_COLOR_ZERO_PAGE
  static inline int is_zero_pfn(unsigned long pfn)
diff --git a/mm/memory.c b/mm/memory.c
index e4b6e599c34d8..dc8efa1358e94 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1362,12 +1362,12 @@ int
  copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  {
  	pgd_t *src_pgd, *dst_pgd;
-	unsigned long next;
  	unsigned long addr = src_vma->vm_start;
  	unsigned long end = src_vma->vm_end;
  	struct mm_struct *dst_mm = dst_vma->vm_mm;
  	struct mm_struct *src_mm = src_vma->vm_mm;
  	struct mmu_notifier_range range;
+	unsigned long next, pfn;
  	bool is_cow;
  	int ret;
  
@@ -1378,7 +1378,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
  
  	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		ret = track_pfn_copy(dst_vma, src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma, &pfn);
  		if (ret)
  			return ret;
  	}
@@ -1425,7 +1425,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  		mmu_notifier_invalidate_range_end(&range);
  	}
  	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
-		untrack_pfn_copy(dst_vma, src_vma);
+		untrack_pfn_copy(dst_vma, pfn);
  	return ret;
  }
  
-- 
2.48.1


-- 
Cheers,

David / dhildenb


