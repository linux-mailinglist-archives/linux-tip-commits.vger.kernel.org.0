Return-Path: <linux-tip-commits+bounces-1960-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2EF94980E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 21:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBBC1F227DA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141BE80025;
	Tue,  6 Aug 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHeuTKds"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB14F8A0;
	Tue,  6 Aug 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971579; cv=none; b=W0pvSKQ1MN40lkNBcjQ1MNvu0WK6EATnbWEo2uVUpFZ5dsWm36nCNpRYMi0k+80sPvE4otuIgEh9Zv38ZNt+Ta4ymJGauhIH+quhuLEgme7YAeqORUjdtlXBwoRKqZ3p3PqNGciUsILxK+Grm96KkzzRIitpCeVm0/IH0BEiHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971579; c=relaxed/simple;
	bh=BlAnemvgMkABYr5n2Ue8ZbYrRjHPz//OjA8YUzffgu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOJIIzv6Bu+tQ/TmV8J92ohAXzSz+mL0zKoqhTxDuo2mHUDM7TNPXvTLBXmT9u0jINEifNPNa+0OK7Kbzabusoos7r3dVHQYVizqI0Wj25eh6oJhVI4R32k/jb2w5z6esPNQaxh+H4ieFTrPz1CjP5TcnO5iNCLkEPg027B9dKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHeuTKds; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso803142a12.2;
        Tue, 06 Aug 2024 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722971576; x=1723576376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa9NdDqAtjfxdtjY1rCTBQCmLiHddHsOopyPziLCd3c=;
        b=WHeuTKdsePzXLafKyG/fDzsP7m+dtpUZRH8PLiHdZjRGosgCrFRDELgzhSzwypKWa7
         6erUolrBXXM+TeoE2NjpmZueobxAzWxJLyzXUeIl0z3fA8UT29AzMjwGv8sqkJutUfj+
         czmn0Iao+YukgFt8TqTkLyzf+ElSfcUlLoNWCQ9OWB46vk3jR40lGp3kREPsPG+OLZNo
         DacSJvaufCAf8hjYJxHV9BHkRcdzPZmvrfiVIT6shePEwaNordQQbVlSpRAK9Ejj1Adb
         r74tRZ+DbibZGE818FuNFw4a6huttpTIa6zxT1z9DyZoo8YTWxIX/QWit0UJdO+j89mV
         H8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722971576; x=1723576376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa9NdDqAtjfxdtjY1rCTBQCmLiHddHsOopyPziLCd3c=;
        b=Ji6vZQ7OfASdSLfbKgPmZ9DedaRhTw/PyLvvr/4wV1rfrNKlVtqxhSAZY25khq2yoP
         AVetqppSKD9qLWrL8xIC/oEXAfEz6ayt9eg72dNBK/yGzmmlJwGYuAL/oOvDp6FYJ7Ex
         8lfFNXUNk1fhlWjAtESptI3TQw18zIVVEpZ8mN/jXiq0lwxJ7qzN9pcrpJzHKXbYBHPF
         eQP1tyIBpMLfw+5VgSBALRNlXyMLu2pOuSNioU3fGKGh/mECmlDB89UZo6EhyBYrNrAB
         TnSbOSKITw/Gp7kWWYH7mve2QioTgfNDzLhAw3yT+qW+EAlaMSaT3emMast2KpTWw6Fz
         lF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl5bGgi2KRHbVeOy1gSsis3pHBu3XtVsf/aHzp536P830Rmc/QcTq0E6cnsZyuv6LFu5bl9CJtv9Dqf/+ME8taYLVRWne+CvjjSJBtKcUn56A=
X-Gm-Message-State: AOJu0YwWxBTlKNyzsn4aPGMyvsmPWhRDppjG5pUXUxFT75+2XByzqxcX
	mZJRfz2xTzwGc7j+VFEvIjAWAt9+VGO47EykclEFA4VGSDCrozRT
X-Google-Smtp-Source: AGHT+IHKhx50w3/bap9H5BjmBAf0IaQhDukxPACq01j4J8EC1vaQlg3kAuxxFCIa1RbY3lRXJWzH/Q==
X-Received: by 2002:a17:902:ecc9:b0:1fd:a769:fcaf with SMTP id d9443c01a7336-1ff574dfdcbmr199925795ad.61.1722971576049;
        Tue, 06 Aug 2024 12:12:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5927f161sm91101805ad.232.2024.08.06.12.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 12:12:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <35974667-c3b4-4c24-9806-1d6d9f42491e@roeck-us.net>
Date: Tue, 6 Aug 2024 12:12:53 -0700
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
 <eab8db58-1eb5-40f7-b7c9-e58558937bf4@roeck-us.net>
 <20240806184843.GX37996@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240806184843.GX37996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 11:48, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 09:42:23AM -0700, Guenter Roeck wrote:
>> On 8/6/24 08:59, Peter Zijlstra wrote:
>>> On Tue, Aug 06, 2024 at 05:46:53PM +0200, Peter Zijlstra wrote:
>>>> On Tue, Aug 06, 2024 at 05:05:15PM +0200, Peter Zijlstra wrote:
>>>>> On Tue, Aug 06, 2024 at 04:56:32PM +0200, Peter Zijlstra wrote:
>>>>>> On Tue, Aug 06, 2024 at 07:25:42AM -0700, Guenter Roeck wrote:
>>>>>>
>>>>>>> I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
>>>>>>> the relevant information. Please let me know if you need anything else.
>>>>>>
>>>>>> So I grabbed that config, stuck it in the build dir I used last time and
>>>>>> upgraded gcc-13 from 13.2 ro 13.3. But alas, my build runs successfully
>>>>>> :/
>>>>>>
>>>>>> Is there anything else special I missed?
>>>>>
>>>>> run.sh is not exacrlty the same this time, different CPU model, that
>>>>> made it go.
>>>>>
>>>>> OK, lemme poke at this.
>>>>
>>>> Urgh, so crypto's late_initcall() does user-mode-helper based modprobe
>>>> looking for algorithms before we kick off /bin/init :/
>>>>
>>>> This makes things difficult.
>>>>
>>>> Urgh.
>>>
>>> So the problem is that mark_readonly() splits a code PMD due to NX. Then
>>> the second pti_clone_entry_text() finds a kernel PTE but a user PMD
>>> mapping for the same address (from the early clone) and gets upset.
>>>
>>> And we can't run mark_readonly() sooner, because initcall expect stuff
>>> to be RW. But initcalls do modprobe, which runs user crap before we're
>>> done initializing everything.
>>>
>>> This is a right mess, and I really don't know what to do.
>>
>> And there was me thinking this one should be easy to solve. Oh well.
>>
>> Maybe Linus has an idea ? I am getting a bit wary to reporting all those
>> weird problems to him, though.
> 
> While I had dinner with the family, Thomas cooked up the below, which
> seems to make it happy.
> 

I'll give it a try for all emulations (both x86 and x86_64), just to be sure,
but it does indeed fix the problem for the test with the affected CPU/build.

Thanks!

Guenter

> It basically splits the PMD on the late copy.
> 
> ---
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index bfdf5f45b137..b6ebbc9c23b1 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -241,7 +241,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
>    *
>    * Returns a pointer to a PTE on success, or NULL on failure.
>    */
> -static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
> +static pte_t *pti_user_pagetable_walk_pte(unsigned long address, bool late_text)
>   {
>   	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
>   	pmd_t *pmd;
> @@ -251,10 +251,15 @@ static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
>   	if (!pmd)
>   		return NULL;
>   
> -	/* We can't do anything sensible if we hit a large mapping. */
> +	/* Large PMD mapping found */
>   	if (pmd_leaf(*pmd)) {
> -		WARN_ON(1);
> -		return NULL;
> +		/* Clear the PMD if we hit a large mapping from the first round */
> +		if (late_text) {
> +			set_pmd(pmd, __pmd(0));
> +		} else {
> +			WARN_ON_ONCE(1);
> +			return NULL;
> +		}
>   	}
>   
>   	if (pmd_none(*pmd)) {
> @@ -283,7 +288,7 @@ static void __init pti_setup_vsyscall(void)
>   	if (!pte || WARN_ON(level != PG_LEVEL_4K) || pte_none(*pte))
>   		return;
>   
> -	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR);
> +	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR, false);
>   	if (WARN_ON(!target_pte))
>   		return;
>   
> @@ -301,7 +306,7 @@ enum pti_clone_level {
>   
>   static void
>   pti_clone_pgtable(unsigned long start, unsigned long end,
> -		  enum pti_clone_level level)
> +		  enum pti_clone_level level, bool late_text)
>   {
>   	unsigned long addr;
>   
> @@ -390,7 +395,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>   				return;
>   
>   			/* Allocate PTE in the user page-table */
> -			target_pte = pti_user_pagetable_walk_pte(addr);
> +			target_pte = pti_user_pagetable_walk_pte(addr, late_text);
>   			if (WARN_ON(!target_pte))
>   				return;
>   
> @@ -452,7 +457,7 @@ static void __init pti_clone_user_shared(void)
>   		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
>   		pte_t *target_pte;
>   
> -		target_pte = pti_user_pagetable_walk_pte(va);
> +		target_pte = pti_user_pagetable_walk_pte(va, false);
>   		if (WARN_ON(!target_pte))
>   			return;
>   
> @@ -475,7 +480,7 @@ static void __init pti_clone_user_shared(void)
>   	start = CPU_ENTRY_AREA_BASE;
>   	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
>   
> -	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
> +	pti_clone_pgtable(start, end, PTI_CLONE_PMD, false);
>   }
>   #endif /* CONFIG_X86_64 */
>   
> @@ -492,11 +497,11 @@ static void __init pti_setup_espfix64(void)
>   /*
>    * Clone the populated PMDs of the entry text and force it RO.
>    */
> -static void pti_clone_entry_text(void)
> +static void pti_clone_entry_text(bool late)
>   {
>   	pti_clone_pgtable((unsigned long) __entry_text_start,
>   			  (unsigned long) __entry_text_end,
> -			  PTI_LEVEL_KERNEL_IMAGE);
> +			  PTI_LEVEL_KERNEL_IMAGE, late);
>   }
>   
>   /*
> @@ -571,7 +576,7 @@ static void pti_clone_kernel_text(void)
>   	 * pti_set_kernel_image_nonglobal() did to clear the
>   	 * global bit.
>   	 */
> -	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
> +	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE, false);
>   
>   	/*
>   	 * pti_clone_pgtable() will set the global bit in any PMDs
> @@ -639,7 +644,7 @@ void __init pti_init(void)
>   	/* Undo all global bits from the init pagetables in head_64.S: */
>   	pti_set_kernel_image_nonglobal();
>   	/* Replace some of the global bits just for shared entry text: */
> -	pti_clone_entry_text();
> +	pti_clone_entry_text(false);
>   	pti_setup_espfix64();
>   	pti_setup_vsyscall();
>   }
> @@ -659,7 +664,7 @@ void pti_finalize(void)
>   	 * We need to clone everything (again) that maps parts of the
>   	 * kernel image.
>   	 */
> -	pti_clone_entry_text();
> +	pti_clone_entry_text(true);
>   	pti_clone_kernel_text();
>   
>   	debug_checkwx_user();


