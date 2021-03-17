Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8733F15E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 14:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCQNng (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 09:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231209AbhCQNnZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615988605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6W2NAAyf0FpcLn99G024NFc9PBWLRHCwNHkA7HcE9I=;
        b=LXqV4xyGWbYTwZdMhhqGmFzr8QV4gAOpCaYIeohI71fW/YCZ4qSC02O6Lf11uUqNa51D3B
        t99kvPmPyZtNqtUzoco4mwuM5fEnCphgrIs0LivfMDDZLeylrPh5hyg2riI+IgYcAJQb0i
        UxruAudYetR41r1htFsZDivT3EVegww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-ceukJS8bOdiaPWc7vaRhjg-1; Wed, 17 Mar 2021 09:43:23 -0400
X-MC-Unique: ceukJS8bOdiaPWc7vaRhjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CF27108BD08;
        Wed, 17 Mar 2021 13:43:21 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2319610F1;
        Wed, 17 Mar 2021 13:43:20 +0000 (UTC)
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Simplify use_ww_ctx &
 ww_ctx handling
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org
References: <20210316153119.13802-2-longman@redhat.com>
 <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
 <YFH9Pw3kwCZC1UTB@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <85fbce04-c544-6041-6e7d-76f47b90e263@redhat.com>
Date:   Wed, 17 Mar 2021 09:43:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFH9Pw3kwCZC1UTB@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 3/17/21 8:59 AM, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 12:38:22PM -0000, tip-bot2 for Waiman Long wrote:
>> The following commit has been merged into the locking/urgent branch of tip:
>>
>> Commit-ID:     5de2055d31ea88fd9ae9709ac95c372a505a60fa
>> Gitweb:        https://git.kernel.org/tip/5de2055d31ea88fd9ae9709ac95c372a505a60fa
>> Author:        Waiman Long <longman@redhat.com>
>> AuthorDate:    Tue, 16 Mar 2021 11:31:16 -04:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Wed, 17 Mar 2021 09:56:44 +01:00
>>
>> locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling
>>
>> The use_ww_ctx flag is passed to mutex_optimistic_spin(), but the
>> function doesn't use it. The frequent use of the (use_ww_ctx && ww_ctx)
>> combination is repetitive.
>>
>> In fact, ww_ctx should not be used at all if !use_ww_ctx.  Simplify
>> ww_mutex code by dropping use_ww_ctx from mutex_optimistic_spin() an
>> clear ww_ctx if !use_ww_ctx. In this way, we can replace (use_ww_ctx &&
>> ww_ctx) by just (ww_ctx).
> The reason this code was like this is because GCC could constant
> propagage use_ww_ctx but could not do the same for ww_ctx (since that's
> external).
>
> Please double check generated code to make sure you've not introduced a
> bunch of extra branches.
>
I see, but this patch just replaces (use_ww_ctx && ww_ctx) by (ww_ctx). 
Even if constant propagation isn't happening for ww_ctx, gcc shouldn't 
generate any worse code wrt ww_ctx. It could be that the generated 
machine code are more or less the same, but the source code will look 
cleaner with just one variable in the conditional clauses.

Using gcc 8.4.1, the generated __mutex_lock function has the same size 
(with last instruction at offset +5179) with or without this patch. 
Well, you can say that this patch is an no-op wrt generated code.

Cheers,
Longman

