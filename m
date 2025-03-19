Return-Path: <linux-tip-commits+bounces-4322-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D879A68679
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 09:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE593AC53F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA7E24EA84;
	Wed, 19 Mar 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBIa4j13"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76542505AB
	for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372135; cv=none; b=O1BiPMtp8I3CWVlGqho8jK52wIuLQZsKSDkcb6BXAL8uZgrjtePKmvz+H3FF9rQMGAgW/0xC8jYug2Hmi17DkGfrfL3MnYBt0wIyc+8pYvPWtqxqe4uo8GDKdqprbdOLWDNbMd3UmjiQ+bM7r9pbSzyRYPZ+rkR46QpyVKDSYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372135; c=relaxed/simple;
	bh=/PefKqWMN9Bh6sEdUsbgjOj5gq0afBHuguhjdXjYsVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYEXlR6WI7AoxapySwX8X9/95Vq6A6iGeeSWoxKDe+UJaPIjMASUdi6E/ZOiuLU9Q7qA3PzBoAV1pevLmtLcfvLQjWOqLeYAXjgO8RhcuKx3g/zGOAK6UZDeRBvUUq2yr5asQ8OVyhY2vahHiCz89z4nXViEVapv8pUo1iMeTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBIa4j13; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742372132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KslDDVV4pY0b8Sh1eFIqlaIiawsw4XgWPUKMfmaIIWc=;
	b=VBIa4j13Snec4F/kZKjYo/C3YfSKlIlWWpfwENAL8sqqNYThzsyvbGn89dORGokkjpXDo3
	EXfH03w5Pfy78KRUFvgPSfRujeGL4kyA6kkEASJPum73WBMpOhXF1ezjTIT1a89zIy0XCc
	eZDnWudyI8Hm3GttnxBliABQ21kX9d4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-10RtHHiDN02pC_214MngUA-1; Wed, 19 Mar 2025 04:15:30 -0400
X-MC-Unique: 10RtHHiDN02pC_214MngUA-1
X-Mimecast-MFC-AGG-ID: 10RtHHiDN02pC_214MngUA_1742372130
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceed237efso34764325e9.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 19 Mar 2025 01:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372129; x=1742976929;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KslDDVV4pY0b8Sh1eFIqlaIiawsw4XgWPUKMfmaIIWc=;
        b=OOg3cpweSfPoqZDXU9KWKJ55/jFtEfp7aPD1qQA3uDdZrSTjl5BE1jXmX6YsWg+3QK
         j0Sq+HJMuazOXKyW9kPmtt6pgJlRxPaYpB98Dxf7zRq19VURl2C1ec7oasIDMepMeKg6
         8I/gG+c9wE8v+j9/J7mBgqiQVCGjysjLi+OMUgQXId5cAN5j3St1FLKHJxgvdCv8ZLt8
         NDjMXH2/2aHcIimm+9Y+oiE+Kq6c9H3nN5SjSS4eq+oc5edeCMn+6SU96LW8bWzFDHpA
         lUfqRkrQ8tKRsgHXKH60Tkm0aTBQ7eEUYsUK0VPTGKxaIaDpHaqiaUHlue5lsM9vIV+O
         74Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXE7GM+uAz1/2EpdnmJapC5SbliPL8dwXyDFp7yRDd4i7kwcQTMurGKi/idst9z1vGVnIaULV53DWkBWji8Prwytg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTj0XWQFEwBeDXfDDKf5MFm9pg0l35QATV6IgZkac0hg2D8xm
	hr31ewx7YqefGpBvrkG6VaGYMR0EWe9QsxJ6skiXaRrPKt5BCliwAjEIBOoH0o40c0RX24CGHeO
	uw/ayI24iJ/ntzvp3HP37rh+/mLBdPJB8tUZJbjVllTgKNnshsn0qTFXTH4jdB7hjCfRl
X-Gm-Gg: ASbGncvldeU2aGQpB3U6YhpgYmRMnuwKSN0Qbra/gaVXhwP/2zWsXMPgkaNXy5GQOjp
	S4grbxtAbMz6arajLkFQmjtaJRACsLr6HOU9XZbmFsjvtSJdJYOBdQzQaSq0aW9z2E/56x4Z2Hm
	rhs5YDzzZCMD1b330DkL35hg1SIP9R3BEavxADrQ6ra9kmBBr0/RYJ9a3OpEkoT3ZOxs3mDOfpN
	tlI9lKLBlj1NnCrsvdQhOAcPLbjVmV2zOTq4V860lZLoKgifYmmGFEivDIE5ALN0FVi64HV+CZE
	F9qHr91nlre8VALK9lP03S6TcM5rWwZXpgFx2UNyaJt2nnttXe1pLf8YoXGxR6RWyviCYmBDAZr
	mo6h7BN9BngDx70zr9kZgkFTOtDVuToSri9GGIYwxjp4=
X-Received: by 2002:a05:600c:358c:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d437c1881mr13237165e9.18.1742372129600;
        Wed, 19 Mar 2025 01:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+yn5FIA/S3XVwYTtF09F+q39q3lRLHoc7BOLC+fv8+gdAtt85sMShlQ7zjFQOtm5i4cxsYw==
X-Received: by 2002:a05:600c:358c:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d437c1881mr13236835e9.18.1742372129168;
        Wed, 19 Mar 2025 01:15:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3ae04a94sm21725885e9.0.2025.03.19.01.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 01:15:27 -0700 (PDT)
Message-ID: <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
Date: Wed, 19 Mar 2025 09:15:25 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: xingwei lee <xrivendell7@gmail.com>, yuxin wang <wang1315768607@163.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +void untrack_pfn_copy(struct vm_area_struct *dst_vma,
> +		struct vm_area_struct *src_vma)
> +{
> +	resource_size_t paddr;
> +	unsigned long size;
> +
> +	if (!(dst_vma->vm_flags & VM_PAT))
> +		return;
> +
> +	/*
> +	 * As the page tables might not have been copied yet, the PAT
> +	 * information is obtained from the src VMA, just like during
> +	 * track_pfn_copy().
> +	 */
> +	if (get_pat_info(src_vma, &paddr, NULL)) {
> +		size = src_vma->vm_end - src_vma->vm_start;
> +		free_pfn_range(paddr, size);
>   	}
>   

@Ingo, can you drop this patch for now? It's supposed to be 
"!get_pat_info" here, and I want to re-verify now that a couple of 
months passed, whether it's all working as expected with that.

(we could actually complain if get_pat_info() would fail at this point, 
let me think about that)

I'll resend once I get to it. Thanks!

-- 
Cheers,

David / dhildenb


