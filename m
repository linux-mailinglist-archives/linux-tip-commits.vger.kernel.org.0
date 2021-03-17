Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14F33F827
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 19:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhCQScs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 14:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232909AbhCQScc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 14:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616005951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pj0R5VrQedcfD5YEftKL4qdHxeZ+Ev/Ff2XmPsp8Sw4=;
        b=GRcdEdLLpxhS3gqyKIn+SC0dtE7O2xFkhzhWcot/NCeun8opnSFX77/+yrWv3BzRwJx8In
        ETs7UhgH4ZqbgmJGRz7sRzTokJkyBnZkBTcnQ41hO8BRnHKXgZtTVKUO0FQqmdeQ1/QEwC
        wxNl/eya7ZKrW8TXaL+6/zR6SwYRxb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-1XAU-iLUOb-_ZtsCHaXK7w-1; Wed, 17 Mar 2021 14:32:29 -0400
X-MC-Unique: 1XAU-iLUOb-_ZtsCHaXK7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20EA018C89C4;
        Wed, 17 Mar 2021 18:32:28 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88EEE5D9C0;
        Wed, 17 Mar 2021 18:32:27 +0000 (UTC)
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock()
 like a trylock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
References: <20210316153119.13802-4-longman@redhat.com>
 <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
 <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
 <YFIEo8IVQ/Mm9jUE@hirez.programming.kicks-ass.net>
 <e1bcd7fb-3a40-f207-ee19-d276c8b8bb75@redhat.com>
 <e39f4e37-e3c0-e62a-7062-fdd2c8b3d3b9@redhat.com>
 <YFIy8Bzj7WAHFmlG@hirez.programming.kicks-ass.net>
 <YFI/C4VZuWjyHLNK@hirez.programming.kicks-ass.net>
 <YFJAP8x917Ef0Khj@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <36d26109-f08a-6254-2fd3-ad1a28fcc260@redhat.com>
Date:   Wed, 17 Mar 2021 14:32:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFJAP8x917Ef0Khj@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 3/17/21 1:45 PM, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 06:40:27PM +0100, Peter Zijlstra wrote:
>> On Wed, Mar 17, 2021 at 05:48:48PM +0100, Peter Zijlstra wrote:
>>
>>> I think you'll find that if you use ww_mutex_init() it'll all work. Let
>>> me go and zap this patch, and then I'll try and figure out why
>>> DEFINE_WW_MUTEX() is buggered.
>> Moo, I can't get the compiler to do as I want :/
>>
>> The below is so close but doesn't actually compile.. Maybe we should
>> just give up on DEFINE_WW_MUTEX and simply remove it.
>>
>> ---
>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>> index 0cd631a19727..85f50538f26a 100644
>> --- a/include/linux/mutex.h
>> +++ b/include/linux/mutex.h
>> @@ -129,12 +129,15 @@ do {									\
>>   # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
>>   #endif
>>   
>> -#define __MUTEX_INITIALIZER(lockname) \
>> +#define ___MUTEX_INITIALIZER(lockname, depmap) \
>>   		{ .owner = ATOMIC_LONG_INIT(0) \
>>   		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
>>   		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
>>   		__DEBUG_MUTEX_INITIALIZER(lockname) \
>> -		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
>> +		depmap }
>> +
>> +#define __MUTEX_INITIALIZER(lockname) \
>> +		___MUTEX_INITIALIZER(lockname, __DEP_MAP_MUTEX_INITIALIZER(lockname))
>>   
>>   #define DEFINE_MUTEX(mutexname) \
>>   	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
>> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
>> index 6ecf2a0220db..c62a030652b4 100644
>> --- a/include/linux/ww_mutex.h
>> +++ b/include/linux/ww_mutex.h
>> @@ -50,9 +50,17 @@ struct ww_acquire_ctx {
>>   
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class) \
>> -		, .ww_class = class
>> +		, .ww_class = &(class)
>> +
>> +# define __DEP_MAP_WW_MUTEX_INITIALIZER(lockname, class) \
>> +		, .dep_map = { \
>> +			.key = &(class).mutex_key, \
>> +			.name = (class).mutex_name, \
> 			,name = #class "_mutex", \
>
> and it 'works', but shees!

The name string itself may be duplicated for multiple instances of 
DEFINE_WW_MUTEX(). Do you want to keep DEFINE_WW_MUTEX() or just use 
ww_mutex_init() for all?

I notice that the problem with DEFINE_WW_MUTEX is that the ww_mutex 
themselves has null key instead of the same key from the ww_class as 
with ww_mutex_init().

Cheers,
Longman


