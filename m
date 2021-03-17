Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289C333F9E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 21:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCQUV1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 16:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233298AbhCQUVG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 16:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616012465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AlpPY6ekxOjyJjbkL7CucsibdK3fSyFUbHC5754coLk=;
        b=D8/TEBcNkXtuUn2gMqNqHrykcnt8CL9TXVC1/d7FKbUnKNkS2xWEdDgb6RIPPe5YtM/Hri
        sOgaNsPAPrhJC3G/GpCOOQqAbIkMlzumZXIDhMA0uS4jfcNMXPoiMQdTjfCutSqZ9pnBOf
        AmUCqBNY9I5k4XC/jK/kbQw8opiia/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-aFeaLzXvMFC2jr6ROMV3iQ-1; Wed, 17 Mar 2021 16:21:01 -0400
X-MC-Unique: aFeaLzXvMFC2jr6ROMV3iQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACDE71043360;
        Wed, 17 Mar 2021 20:20:59 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 231F960C13;
        Wed, 17 Mar 2021 20:20:59 +0000 (UTC)
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
 <36d26109-f08a-6254-2fd3-ad1a28fcc260@redhat.com>
 <20210317195834.GV4746@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5533bdea-4250-759d-1a5d-007914aad2ff@redhat.com>
Date:   Wed, 17 Mar 2021 16:20:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317195834.GV4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 3/17/21 3:58 PM, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 02:32:27PM -0400, Waiman Long wrote:
>> On 3/17/21 1:45 PM, Peter Zijlstra wrote:
>>>> +# define __DEP_MAP_WW_MUTEX_INITIALIZER(lockname, class) \
>>>> +		, .dep_map = { \
>>>> +			.key = &(class).mutex_key, \
>>>> +			.name = (class).mutex_name, \
>>> 			,name = #class "_mutex", \
>>>
>>> and it 'works', but shees!
>> The name string itself may be duplicated for multiple instances of
>> DEFINE_WW_MUTEX(). Do you want to keep DEFINE_WW_MUTEX() or just use
>> ww_mutex_init() for all?
> So linkers can merge literals, but no guarantee. But yeah, lets just
> kill the thing, less tricky macro crud to worry about.
>
Good, just to confirm the right way to move forward.

Cheers,
Longman

