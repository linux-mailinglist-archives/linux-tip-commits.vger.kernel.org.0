Return-Path: <linux-tip-commits+bounces-4396-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77517A68C0E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5AD7A74B7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6964254AFF;
	Wed, 19 Mar 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agyztkaZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C420E31B
	for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384685; cv=none; b=dOQN27Yof6y4aS7X4ZwZlSQxMcH2J+HsOWYfswU3Z7ENwpIe8LtnEnZjN+SGymCIBpD6y6ThL0uBBqpyJCIdZ3hESCkXyuV+nMecgP3ga1EsrevKVeMN4TOoS4AevgTqmkxlzPnT18HXWEDu72UI11170hj8G858CdBzV4dMckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384685; c=relaxed/simple;
	bh=tiI86MU3DV5wQ4kR1bsgVqIn+emzG3aWNZtkIkSjRQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+7k+ahPQwOx4Xkl82sc595Fr71FcDKG9mW/5BUFDllG7XTHkxW3chzO0McymzVvjSDpIrHlQdvSCHfXvaytqMmCHewpExnGSl2e+GoQKuUwNJocQFrt0ujyc1J7xGQmUfz16HdMpFLcFf4dRz5AL4eTPkf1WPbDC1i116bWVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agyztkaZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742384683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lhNaDTEKsMWmy99m99Tdl1FbekKz4xD+K0zlGkfvAdA=;
	b=agyztkaZ4dyAsN8gFv5UR2YxXgN2qWJT2iYdBMXf/0rzqbktykXeGTRYOamfaI8xWx4d7D
	yY11viJ5Iq+qq9222Urk0wMcsRC88xW4tJCqX5GlnUopO6W2LS6HfBB2JJOZH4JFivURg7
	6hVfPvrJ0n+cLJXOeOPPJ1AnwpSKoHA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-bQBJ8sibMpi-KvjcBLGcwg-1; Wed, 19 Mar 2025 07:44:41 -0400
X-MC-Unique: bQBJ8sibMpi-KvjcBLGcwg-1
X-Mimecast-MFC-AGG-ID: bQBJ8sibMpi-KvjcBLGcwg_1742384681
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so23560725e9.3
        for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 04:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384680; x=1742989480;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lhNaDTEKsMWmy99m99Tdl1FbekKz4xD+K0zlGkfvAdA=;
        b=CBinsXqSuhw8sbjnSB7QtTHfjBqXLbKZRxuklF8JH75E1rLPuRlDP1x9NUYUIU+RT/
         Lkm4uencXrXH5p8qsQVhTSwltJN8YlCzze1f+Kk75GSnfXI4x/Xne2S24CS+iR9TndQx
         g8/BtQFYIrWbhDzgLonf6NbvgKFSx12YQ8NRyh3AQr/2FOTcPIFLmqq9W+PS4DQTW6UQ
         OhjOUSpVBRlhFCw2t6c0HvP4JUUWIV/wsZb6Cn2XDAIJc5nflnTTch1JtxQBR1sw6MK4
         WDiVp6Q8x1fVwkprGaE7Jrv90y0J2yzRax9jKYvNPwGscsJ33IXGC2OCf4lvv9s8aNvI
         uLFg==
X-Forwarded-Encrypted: i=1; AJvYcCUTRwiKFzeNNVNAiKg+aK16DskESdhRe7KUOf8gQsdGDZLaNLChBmoFbnqzXgd9nLlHrFQC7t3kGNs1yGSMtgh9LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzShQ7ZVJ2nOUwDg8gUamoIjcts7tLPvyByDuxCDBrxSe+vcrzA
	XMkB1sHYzImChFtmr1fhKKd8117bMAQBRuK5qoQKugOvzzt448f+txqvnO1nY22HHcVGsyHIrTy
	DsZy9ya1hRmYV9nRZMgzkrcOfXNx0X/tm3zkz9WzPyMw7l4ZvJVGOxkX+Vd4FCyRAnQGX/CCn/n
	cd/k0=
X-Gm-Gg: ASbGnctHiEvqxZLW0ivIgafeb/2H9Et3tqpR4M84moyFuyhGMVMUkgSalDpke+PfGYk
	/tQF8M58i/ES3hSWiMtR/dnUxRcfO69JeLlKqHHsQYdqEUTz8Qi4bGUaIqxoUGDtMoTnGx9lvF/
	T7nw/rfIHZpstchqFkw7XGsG3cfSZ9syKHsJAGXnf96bNyeIshETbsqFxWt7aabXqBWzvGkzVhF
	QVQzAF5/AnAwk71CA/5ewTnVJ6pT0EN4drQV3yrucnN+aRMIRJWt4KHUC3KeVVCy1NPkNEKKomR
	NWantTP1al+eblP/rP/axf42t7CXwBukGywP0/dY5Y781LzbbpZfL3HTAnVnIxQmrPEKFFkt4ng
	iHPs09FMJCrWIYv58547K50DegGoJ0SVDMCZ7TLtRBoo=
X-Received: by 2002:a5d:5847:0:b0:390:fe13:e0ba with SMTP id ffacd0b85a97d-399739cab38mr2117391f8f.27.1742384680611;
        Wed, 19 Mar 2025 04:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8I597hSsJY/uxI8nGKzQCgaWxjyedGq1ns5xMjH/LbJqrA8e5X3xYOYhTRQ3wUPkK8/JSOQ==
X-Received: by 2002:a5d:5847:0:b0:390:fe13:e0ba with SMTP id ffacd0b85a97d-399739cab38mr2117375f8f.27.1742384680220;
        Wed, 19 Mar 2025 04:44:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaa5sm20651383f8f.87.2025.03.19.04.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 04:44:39 -0700 (PDT)
Message-ID: <d767a3d4-b54a-4bdd-91d3-dc1de00637ec@redhat.com>
Date: Wed, 19 Mar 2025 12:44:38 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 xingwei lee <xrivendell7@gmail.com>, yuxin wang <wang1315768607@163.com>,
 Marius Fleischer <fleischermarius@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Xu <peterx@redhat.com>, x86@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, Borislav Petkov <bp@alien8.de>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
 <Z9qkCQE9dsXdlsKn@gmail.com>
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
In-Reply-To: <Z9qkCQE9dsXdlsKn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.25 12:01, Ingo Molnar wrote:
> 
> * David Hildenbrand <david@redhat.com> wrote:
> 
>>> +void untrack_pfn_copy(struct vm_area_struct *dst_vma,
>>> +		struct vm_area_struct *src_vma)
>>> +{
>>> +	resource_size_t paddr;
>>> +	unsigned long size;
>>> +
>>> +	if (!(dst_vma->vm_flags & VM_PAT))
>>> +		return;
>>> +
>>> +	/*
>>> +	 * As the page tables might not have been copied yet, the PAT
>>> +	 * information is obtained from the src VMA, just like during
>>> +	 * track_pfn_copy().
>>> +	 */
>>> +	if (get_pat_info(src_vma, &paddr, NULL)) {
>>> +		size = src_vma->vm_end - src_vma->vm_start;
>>> +		free_pfn_range(paddr, size);
>>>    	}
>>
>> @Ingo, can you drop this patch for now?
> 
> Done.

I can resend the whole thing, or just the fixup suggested by Boris, just 
let me know.

-- 
Cheers,

David / dhildenb


